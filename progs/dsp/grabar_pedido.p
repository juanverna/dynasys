/*=================================================================================*/
/*            GRABACION FISICA DE UN PEDIDO EN LA BASE DE DATOS                    */
/*=================================================================================*/
       
/*=================================================================================*/
/*                            TABLAS TEMPORALES                                    */
/*=================================================================================*/       
       
    DEFINE TEMP-TABLE T-Ped_header           NO-UNDO LIKE Ped_header.
    DEFINE TEMP-TABLE T-Ped_detalle          NO-UNDO LIKE Ped_detalle.       
    DEFINE TEMP-TABLE T-Ped_detalle_entr     NO-UNDO LIKE Ped_detalle_entr.       
    DEFINE TEMP-TABLE T-Ped_header-bon       NO-UNDO LIKE Ped_header-bon.       
    DEFINE TEMP-TABLE T-Ped_detalle-bon      NO-UNDO LIKE Ped_detalle-bon.       
    DEFINE TEMP-TABLE T-Copias_pedido        NO-UNDO LIKE Copias_pedido.       
    
/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/       

    DEFINE INPUT PARAMETER TABLE FOR T-Ped_header.       
    DEFINE INPUT PARAMETER TABLE FOR T-Ped_detalle.       
    DEFINE INPUT PARAMETER TABLE FOR T-Ped_header-bon.       
    DEFINE INPUT PARAMETER TABLE FOR T-Ped_detalle-bon.       
    DEFINE INPUT PARAMETER TABLE FOR T-Copias_pedido.       
    DEFINE OUTPUT PARAMETER proceso-ok AS LOGICAL.
    DEFINE OUTPUT PARAMETER texto_error AS CHARACTER.

/*=================================================================================*/
/*                                  VARIABLES                                      */
/*=================================================================================*/       

{STPEDIDO.I} /* Posibles estados de pedido */

DEFINE VARIABLE v-habilitado AS LOGICAL.
DEFINE VARIABLE p-estado LIKE Ped_header.cdg_estado.
/*=================================================================================*/
/*                                  PROCESO                                        */
/*=================================================================================*/
FIND FIRST T-Ped_header EXCLUSIVE-LOCK.    

RUN getparametro_l.p (  INPUT  "HABAUTPD",OUTPUT v-habilitado).

IF v-habilitado 
THEN DO:
    RUN verificar_credito.p ( INPUT-OUTPUT TABLE T-Ped_header,
                              INPUT-OUTPUT TABLE T-Ped_detalle,
                              INPUT-OUTPUT TABLE T-Ped_detalle_entr).

    FIND FIRST T-Ped_header EXCLUSIVE-LOCK.

END.
ELSE DO:
    T-Ped_header.cdg_estado = stped_aprobado.
END.

/*---------------------------------------------------------------------------------*/
/* UNA VEZ VERIFICADO EL CREDITO, COPIAMOS EL RESULTADO A TODOS LOS RENGLONES      */
/*---------------------------------------------------------------------------------*/

FOR EACH T-Ped_detalle OF T-Ped_header:
   T-Ped_detalle.cdg_estado = T-Ped_header.cdg_estado.
END.

/*---------------------------------------------------------------------------------*/
/*                              RESERVA LOS STOCKS                                 */
/*---------------------------------------------------------------------------------*/

FIND Parametro WHERE Parametro.cdg_parametro = "PEDI" + STRING(T-Ped_header.prf_comprob,"9999") 
                 AND Parametro.cdg_empresa   = T-Ped_header.cdg_empresa
                     EXCLUSIVE-LOCK NO-ERROR.

IF NOT AVAILABLE Parametro
THEN DO:
    CREATE Parametro.
    ASSIGN Parametro.cdg_empresa   = T-Ped_header.cdg_empresa
           Parametro.cdg_parametro = "PEDI" + STRING(T-Ped_header.prf_comprob,"9999")
           Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
           Parametro.observacion   = ""
           Parametro.tipo          = "N"
           Parametro.valor_n       = 1.
END.         

ASSIGN
     T-Ped_header.fecha_precios = T-Ped_header.fecha.

CREATE Ped_header.
BUFFER-COPY T-Ped_header TO Ped_header
   ASSIGN  Ped_header.nro_pedido  = NEXT-VALUE(proxima_transaccion)
           Ped_header.nro_comprob = Parametro.valor_n
           Parametro.valor_n      = Parametro.valor_n + 1.

FOR EACH T-Ped_detalle:
   CREATE Ped_detalle.
   BUFFER-COPY T-Ped_detalle TO Ped_detalle
       ASSIGN  Ped_detalle.nro_pedido = Ped_header.nro_pedido.
END.

FOR EACH T-Ped_header-bon:
   CREATE Ped_header-bon.
   BUFFER-COPY T-Ped_header-bon TO Ped_header-bon
       ASSIGN  Ped_header-bon.nro_pedido = Ped_header.nro_pedido.
END.

FOR EACH T-Ped_detalle-bon:
   CREATE Ped_detalle-bon.
   BUFFER-COPY T-Ped_detalle-bon TO Ped_detalle-bon
       ASSIGN  Ped_detalle-bon.nro_pedido = Ped_header.nro_pedido.
END.

FOR EACH T-Copias_pedido:
   CREATE Copias_pedido.
   BUFFER-COPY T-Copias_pedido TO Copias_pedido
       ASSIGN  Copias_pedido.nro_pedido = Ped_header.nro_pedido.
END.

IF Ped_header.cdg_estado = stped_aprobado
THEN DO:

    RUN emitir_pedido.p ( INPUT ROWID(Ped_header),
                          OUTPUT p-estado).

    IF SEARCH("sincronizar_pedido.p") <> ? OR
      SEARCH("sincronizar_pedido.r") <> ?
    THEN DO:
       BUFFER-COPY Ped_header EXCEPT Ped_header.nro_pedido TO T-Ped_header.
       

       RUN sincronizar_pedido.p ( INPUT-OUTPUT TABLE T-Ped_header,
                                  INPUT-OUTPUT TABLE T-Ped_detalle,
                                  OUTPUT proceso-ok,
                                  OUTPUT texto_error).
       
     
       IF NOT proceso-ok 
       THEN DO:
           Ped_header.proc_estad = YES.
       END.
    END.

END.
ELSE DO:
    proceso-ok = YES.
    texto_error = "".
    RUN PONMENSJ.P (INPUT "PEDI041").
END.

RELEASE Parametro.
RELEASE Ped_header.
RELEASE Ped_detalle.
RELEASE Ped_detalle-bon.
RELEASE Ped_header-bon.
RELEASE Copias_pedido.

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/

PROCEDURE verificar_stock:

    /*---------------------------------------------------------------------------------*/
    /*                              RESERVA LOS STOCKS                                 */
    /*---------------------------------------------------------------------------------*/
  
    FIND Deposito OF Ped_header NO-LOCK.
    FOR EACH Ped_detalle OF Ped_header EXCLUSIVE-LOCK, Articulo OF Ped_detalle NO-LOCK:

        RUN verificar_existencia.
        RUN crear_historia ( INPUT Ped_detalle.cdg_estado ) .
    END.
  

END PROCEDURE.

PROCEDURE verificar_existencia:
    
    DEFINE VARIABLE sal_cantidad   LIKE Cct_stock.cantidad.
    DEFINE VARIABLE sal_granel     LIKE Cct_stock.granel.
    DEFINE VARIABLE pre_cantidad   LIKE Cct_stock.cantidad.
    DEFINE VARIABLE pre_granel     LIKE Cct_stock.granel.

    FIND Partida OF Ped_detalle NO-LOCK.
    RUN calcular_stock.p ( INPUT   ROWID(Articulo),
                           INPUT   ROWID(Deposito),
                           INPUT   ROWID(Partida),
                           INPUT   Ped_detalle.fecha_temprana,
                           INPUT   1 /*dep_y_par*/,
                           OUTPUT  sal_cantidad,
                           OUTPUT  sal_granel,
                           OUTPUT  pre_cantidad,
                           OUTPUT  pre_granel).
                           
    IF pre_cantidad >= Ped_detalle.cantidad
       AND pre_granel >= Ped_detalle.granel
    THEN DO:
         Ped_detalle.cdg_estado = "AA".
         RUN reservar_stock.
    END.                      
    ELSE DO:
         Ped_detalle.cdg_estado = "ST".
    END.                      

    FOR EACH Ped_detalle_entr OF Ped_detalle EXCLUSIVE-LOCK:
        Ped_detalle_entr.cdg_estado = Ped_detalle.cdg_estado.
    END.          

END PROCEDURE.


