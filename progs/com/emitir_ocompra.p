/*=================================================================================*/
/*                 PROCESO DE EMISION DE UNA ORDEN DE COMPRA                       */
/*=================================================================================*/

/*=================================================================================*/
/*                      DEFINNICION DE TABLAS TEMPORALES                           */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Ocm_header       NO-UNDO LIKE Ocm_header.
DEFINE TEMP-TABLE T-Ocm_detalle      NO-UNDO LIKE Ocm_detalle.
DEFINE TEMP-TABLE T-Ocm_detalle_entr NO-UNDO LIKE Ocm_detalle_entr.
DEFINE TEMP-TABLE T-Ocm_header-bon   NO-UNDO LIKE Ocm_header-bon.  
DEFINE TEMP-TABLE T-Ocm_detalle-bon  NO-UNDO LIKE Ocm_detalle-bon.

/*=================================================================================*/
/*                                PARAMETROS                                       */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_header.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_detalle.      
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_detalle_entr. 
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_header-bon.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_detalle-bon.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE saldo_remito          AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento   AS INTEGER.
DEFINE VARIABLE j                     AS INTEGER.
DEFINE VARIABLE ncopias               AS INTEGER.

DEFINE VARIABLE que_rutina            AS CHARACTER.

DEFINE VARIABLE v-reservar            AS LOGICAL.

DEFINE BUFFER B-Ocm_detalle           FOR Ocm_detalle.

/*=================================================================================*/
/*                           RECUPERACION DEL COMPROBANTE                          */
/*=================================================================================*/

RUN getparametro_l.p (  INPUT  "RSVSTOCK", OUTPUT v-reservar).

FIND FIRST T-Ocm_header.

FIND Parametro WHERE Parametro.cdg_parametro = "POCM" + STRING(T-Ocm_header.prf_comprob,"9999") 
                 AND Parametro.cdg_empresa   = T-Ocm_header.cdg_empresa 
                    EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Parametro
THEN DO:
    CREATE Parametro.
    ASSIGN Parametro.cdg_empresa   = T-Ocm_header.cdg_empresa 
           Parametro.cdg_parametro = "POCM" + STRING(T-Ocm_header.prf_comprob,"9999")
           Parametro.descripcion   = "Próxima Orden de Compra a Emitir"
           Parametro.observacion   = ""
           Parametro.tipo          = "N"
           Parametro.valor_n       = 1.
END.         

CREATE Ocm_header.
BUFFER-COPY T-Ocm_header TO Ocm_header
   ASSIGN  Ocm_header.nro_ocompra   = NEXT-VALUE(proxima_transaccion)
           Ocm_header.cdg_estado    = "AA"
           Ocm_header.nro_comprob   = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1
           T-Ocm_header.nro_ocompra = Ocm_header.nro_ocompra.

FOR EACH T-Ocm_detalle, Articulo OF T-Ocm_detalle NO-LOCK:

   CREATE Ocm_detalle.
   BUFFER-COPY T-Ocm_detalle TO Ocm_detalle
       ASSIGN  Ocm_detalle.nro_ocompra = Ocm_header.nro_ocompra
               Ocm_detalle.cdg_estado = Ocm_header.cdg_estado. 

   RUN asociar_proveedor.

   IF CAN-FIND(FIRST T-Ocm_detalle_entr OF T-Ocm_detalle)
   THEN DO:
       FOR EACH T-Ocm_detalle_entr OF T-Ocm_detalle:
           CREATE Ocm_detalle_entr.
           BUFFER-COPY T-Ocm_detalle_entr TO Ocm_detalle_entr
               ASSIGN  Ocm_detalle_entr.nro_ocompra = Ocm_detalle.nro_ocompra
                       Ocm_detalle_entr.cdg_estado = Ocm_detalle.cdg_estado. 
       END.
   END.
   ELSE DO:
       CREATE Ocm_detalle_entr.
       BUFFER-COPY T-Ocm_detalle TO Ocm_detalle_entr
               ASSIGN  Ocm_detalle_entr.nro_ocompra = Ocm_detalle.nro_ocompra
                       Ocm_detalle_entr.nro_entrega = 1
                       Ocm_detalle_entr.cdg_estado  = Ocm_detalle.cdg_estado. 
   END.

   IF v-reservar
       THEN RUN reservar_stock.

END.

FOR EACH T-Ocm_header-bon:

    CREATE Ocm_header-bon.
    BUFFER-COPY T-Ocm_header-bon TO Ocm_header-bon
        ASSIGN Ocm_header-bon.nro_ocompra = Ocm_header.nro_ocompra.

END.

FOR EACH T-Ocm_detalle-bon:

    CREATE Ocm_detalle-bon.
    BUFFER-COPY T-Ocm_detalle-bon TO Ocm_detalle-bon
        ASSIGN Ocm_detalle-bon.nro_ocompra = Ocm_header.nro_ocompra.

END.

RELEASE Parametro.        


/*=================================================================================*/
/*        CALCULO DE LA ORDEN DE COMPRA, HALLA NETO Y TOTAL CON IMPUESTOS          */
/*=================================================================================*/

/*{CALCOCOM.I}*/


/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN imprimir_ocompra.p (INPUT ROWID(Ocm_header)).

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE ASOCIAR_PROVEEDOR:

    FIND FIRST Articulo-proveedor  
         WHERE Articulo-proveedor.nro_proveedor = Ocm_header.nro_proveedor
           AND Articulo-proveedor.nro_articulo  = Ocm_detalle.nro_articulo 
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE Articulo-proveedor
    THEN DO:
         CREATE Articulo-proveedor.
         ASSIGN Articulo-proveedor.nro_proveedor = Ocm_header.nro_proveedor
                Articulo-proveedor.nro_articulo  = Ocm_detalle.nro_articulo.
    END.
    
    Articulo-proveedor.a_fecha = Ocm_header.fecha.
         
END PROCEDURE.

PROCEDURE reservar_stock:

    FIND Articulo-deposito 
         WHERE Articulo-deposito.nro_articulo = Articulo.nro_articulo
           AND Articulo-deposito.nro_deposito = Deposito.nro_deposito 
           AND Articulo-deposito.cdg_empresa  = Ocm_header.cdg_empresa 
               EXCLUSIVE-LOCK NO-ERROR.
 
    IF NOT AVAILABLE Articulo-deposito
    THEN DO:
         CREATE Articulo-deposito.
         ASSIGN Articulo-deposito.nro_articulo = Articulo.nro_articulo
                Articulo-deposito.nro_deposito = Deposito.nro_deposito 
                Articulo-deposito.cdg_empresa  = Ocm_header.cdg_empresa.
    END.
    
    FIND Partida OF Ocm_detalle EXCLUSIVE-LOCK.
 
    IF NOT AVAILABLE Partida
    THEN DO:
         BELL.
         MESSAGE "El articulo " Articulo.cdg_articulo Articulo.descripcion " tiene "
                 "habilitadas las partidas pero no tiene ninguna ingresada. Nro.:"
                 STRING(Ocm_detalle.nro_partida)
                 VIEW-AS ALERT-BOX ERROR
         TITLE "Error de consistencia en la definicion del articulo".
    END.
 
    FIND Partida-deposito  
         WHERE Partida-deposito.nro_deposito = Deposito.nro_deposito 
           AND Partida-deposito.nro_articulo = Ocm_detalle.nro_articulo
           AND Partida-deposito.nro_partida  = Ocm_detalle.nro_partida
           AND Partida-deposito.cdg_empresa  = Ocm_header.cdg_empresa
               EXCLUSIVE-LOCK NO-ERROR.
 
    IF NOT AVAILABLE Partida-deposito
    THEN DO:
         CREATE Partida-deposito.
         ASSIGN Partida-deposito.nro_deposito = Deposito.nro_deposito
                Partida-deposito.nro_articulo = Ocm_detalle.nro_articulo
                Partida-deposito.nro_partida  = Ocm_detalle.nro_partida
                Partida-deposito.cdg_empresa  = Ocm_header.cdg_empresa.
    END.
 
    ASSIGN 
           Articulo-deposito.encompra_cantidad = Articulo-deposito.encompra_cantidad + Ocm_detalle.cantidad.
           Articulo-deposito.encompra_granel   = Articulo-deposito.encompra_granel + Ocm_detalle.granel.
           Partida.encompra_cantidad           = Partida.encompra_cantidad + Ocm_detalle.cantidad.
           Partida.encompra_granel             = Partida.encompra_granel + Ocm_detalle.granel.
           Partida-deposito.encompra_cantidad  = Partida-deposito.encompra_cantidad + Ocm_detalle.cantidad.
           Partida-deposito.encompra_granel    = Partida-deposito.encompra_granel + Ocm_detalle.granel.

    CREATE Cct_stock.
    ASSIGN Cct_stock.nro_deposito   = Deposito.nro_deposito
           Cct_stock.tipo_mov       = ( IF Ocm_header.tip_comprob = "OC" THEN "I" ELSE "E" )
           Cct_stock.tip_comprob    = Ocm_header.tip_comprob
           Cct_stock.prf_comprob    = Ocm_header.prf_comprob
           Cct_stock.nro_comprob    = Ocm_header.nro_comprob
           Cct_stock.fecha          = Ocm_detalle.fecha_temprana
           Cct_stock.nro_linea      = Ocm_detalle.nro_linea
           Cct_stock.cantidad       = Ocm_detalle.cantidad
           Cct_stock.granel         = Ocm_detalle.granel
           Cct_stock.nro_articulo   = Ocm_detalle.nro_articulo
           Cct_stock.nro_partida    = Ocm_detalle.nro_partida
           Cct_stock.nro_entidad    = Ocm_detalle.nro_entidad
           Cct_stock.cdg_empresa    = Ocm_header.cdg_empresa
           Cct_stock.presupuestado  = "R".
    
END PROCEDURE.
