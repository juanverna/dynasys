/*====================================================================================*/
/*   GENERA LOS REQUERIMIENTOS DE COMPRA EN FUNCION DE LAS NECESIDADES DE REPOSICION  */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart        LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codart        LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER des_coddep        LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep        LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER que_fecha         AS DATE.
DEFINE INPUT PARAMETER gen_requer        AS LOGICAL.
DEFINE INPUT PARAMETER ver_compras       AS LOGICAL.

/*====================================================================================*/
/*                                 VARIABLES                                          */
/*====================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE ing_cantidad             LIKE Cct_stock.cantidad LABEL "In.".
DEFINE VARIABLE egr_cantidad             LIKE Cct_stock.cantidad LABEL "Eg.".
DEFINE VARIABLE sal_cantidad             LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE com_cantidad             LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE ing_granel               LIKE Cct_stock.granel LABEL "In.".
DEFINE VARIABLE egr_granel               LIKE Cct_stock.granel LABEL "Eg.".
DEFINE VARIABLE sal_granel               LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE com_granel               LIKE Cct_stock.cantidad LABEL "Granel".
DEFINE VARIABLE lst_e                    AS   DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE lst_i                    AS   DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE rep_cantidad             LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE rep_granel               LIKE Cct_stock.granel LABEL "Granel".
                                         
DEFINE VARIABLE titulo_lst               AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det               AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE hubo_transf              AS LOGICAL.
                                         
DEFINE TEMP-TABLE T-Rqs_header           LIKE Rqs_header.
DEFINE TEMP-TABLE T-Rqs_detalle          LIKE Rqs_detalle.
DEFINE TEMP-TABLE T-Rqs_detalle_ent      LIKE Rqs_detalle_ent.

DEFINE VARIABLE v-cuenta_req             AS INTEGER.

DEFINE BUFFER B-Partida                  FOR Partida.
DEFINE QUERY qry_movimiento              FOR Cct_stock, B-Partida.

/*====================================================================================*/
/*                                      FRAMES                                        */
/*====================================================================================*/

/*{WGLISTAR.I}*/
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "Necesidades de Compra por Depósito" AT 45
    "Página:" AT 102 PAGE-NUMBER FORMAT ">>>9" AT 111
    SKIP
    fecha_lis
    titulo_det AT 45
    hora_lis AT 102
    SKIP(1)
    WITH WIDTH 231 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.
  
DEFINE FRAME frm-listado
    Articulo.cdg_articulo COLUMN-LABEL "Código"
    Articulo.descripcion  COLUMN-LABEL "Artículo!Descripción" FORMAT "X(25)"
    Articulo-deposito.stk_minimo_cantid COLUMN-LABEL "Stock!Mínimo"
    Articulo-deposito.stk_maximo_cantid COLUMN-LABEL "Stock!Máximo" 
    sal_cantidad COLUMN-LABEL "Existencia!Real"
    com_cantidad COLUMN-LABEL "Cantidad!en Repos."
    rep_cantidad COLUMN-LABEL "Necesidad!Reposición"
    Articulo.cdg_umed COLUMN-LABEL "Unidad!Medida"
    WITH WIDTH 231 DOWN FRAME frm-listado USE-TEXT STREAM-IO.
       
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  v-cuenta_req = 0.
  
  {dirprinfile.i}
  
  FOR EACH Deposito WHERE Deposito.cdg_deposito <= has_coddep
                      AND Deposito.cdg_deposito >= des_coddep:
                      
      titulo_det = "Depósito: " + STRING(Deposito.cdg_deposito) +  " - " + 
               Deposito.nombre + " Al " + STRING(que_fecha).
               
      VIEW FRAME frm-titulo.

      IF gen_requer
      THEN DO:
          RUN crear_pedido_cabecera.
      END.
      
      FOR EACH Articulo-deposito OF Deposito
          WHERE Articulo-deposito.cdg_empresa = Empresa.cdg_empresa
             AND ( Articulo-deposito.remanente_cantidad - Articulo-deposito.reservado_cantidad <
                  Articulo-deposito.stk_minimo_cantid ) 
             OR ( Articulo-deposito.remanente_granel - Articulo-deposito.reservado_granel <
                  Articulo-deposito.stk_minimo_granel ) NO-LOCK, 
               FIRST Articulo OF Articulo-deposito                 
               WHERE Articulo.Cdg_Articulo >= des_codart 
               AND   Articulo.Cdg_Articulo <= has_codart 
                    BY Articulo.cdg_articulo:
               
                  /* Hallamos los Saldos */
                  
         RUN CALCSTCKN.P (INPUT ROWID(Articulo),
                          INPUT TODAY,
                          INPUT 1,
                          INPUT des_coddep,
                          INPUT has_coddep,
                          OUTPUT sal_cantidad,
                          OUTPUT sal_granel ).
                         

             /* Sumamos las compras pendientes 
                PARA CUANDO UTILICE LAS COMPRAS */
             
/*         RUN SUMACOMP.P (INPUT ROWID(Articulo),
                         INPUT ROWID(Deposito),
                         OUTPUT com_cantidad,
                         OUTPUT com_granel ).*/


         rep_granel   = MAXIMUM(Articulo-deposito.stk_minimo_granel - sal_granel - com_granel, 0).
         rep_cantidad = MAXIMUM(Articulo-deposito.stk_minimo_cantid - sal_cantidad - com_cantidad, 0).
         
         IF ( rep_cantidad > 0 OR rep_granel > 0 ) 
         THEN DO:
         
              hubo_transf = YES. /* Marcamos para hacer el salto de pagina entre depositos */
              
                    /* -------------------------------------*/
                    /* Mandamos al listado y agregamos a la */
                    /* transferencia si se genera la misma  */
                    /* -------------------------------------*/
                    
              DISPLAY
                      Articulo.cdg_articulo
                      Articulo.descripcion
                      Articulo-deposito.stk_minimo_cantid
                      Articulo-deposito.stk_maximo_cantid
                      sal_cantidad
                      com_cantidad
                      rep_cantidad
                      Articulo.cdg_umed
                      /*
                      sal_granel WHEN Articulo.a_granel
                      com_granel WHEN Articulo.a_granel
                      rep_granel WHEN Articulo.a_granel
                      */
                      WITH FRAME frm-listado.
                      
              DOWN WITH FRAME frm-listado.
              
              FOR EACH FComercial OF Articulo NO-LOCK:
                    DISPLAY
                            "  " + FComercial.cdg_fcomercial @ Articulo.cdg_articulo
                            "  " + FComercial.dsc_fcomercial @ Articulo.descripcion
                            WITH FRAME frm-listado.
                            
                    DOWN WITH FRAME frm-listado.
              END.
              
              IF gen_requer
              THEN DO:
                   RUN crear_pedido_detalle.
              END.     

         END. /* Del IF que verifica las existencias */

      END. /* Del FOR EACH de los articulos para este deposito */
     
      IF hubo_transf
      THEN DO:
           UNDERLINE
                   Articulo.cdg_articulo
                   Articulo.descripcion 
                   Articulo-deposito.stk_minimo_cantid
                   Articulo-deposito.stk_maximo_cantid
                   sal_cantidad
                   com_cantidad
                   rep_cantidad
                   Articulo.cdg_umed
                   /*
                   sal_granel
                   com_granel
                   rep_granel
                   */
                   WITH FRAME frm-listado.
           DOWN 1 WITH FRAME frm-listado.
           PAGE.
      END.
  END. /* De los depositos */
  
  IF gen_requer
  THEN DO:                   
       RUN BAJAR_DATOS.
  END.
  
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

END PROCEDURE.

PROCEDURE crear_pedido_cabecera:

  FIND FIRST Sector-deposito OF Deposito WHERE Sector-deposito.modo_relacion = "A" NO-LOCK NO-ERROR.

  CREATE T-Rqs_header.
  ASSIGN v-cuenta_req                  = v-cuenta_req + 1
         T-Rqs_header.cdg_empresa      = Empresa.cdg_empresa
         T-Rqs_header.nro_deposito     = Deposito.nro_deposito
         T-Rqs_header.nro_area         = Sector-deposito.nro_area
         T-Rqs_header.fecha            = TODAY
         T-Rqs_header.nro_comprob      = v-cuenta_req
         T-Rqs_header.nro_entidad      = Deposito.nro_entidad
         T-Rqs_header.nro_requisicion  = T-Rqs_header.nro_comprob
         T-Rqs_header.nro_usuario      = Usuario.nro_usuario
         T-Rqs_header.origen           = "A"
         T-Rqs_header.tip_comprob      = "PI"
      /* T-Rqs_header.prf_comprob      = 0 */
         T-Rqs_header.cdg_estado       = "AL"
         T-Rqs_header.es_reposicion    = YES
         T-Rqs_header.ultima_linea     = 0 
         T-Rqs_header.cdg_solicitante  = 1
         T-Rqs_header.estado           = "E".
/*       T-Rqs_header.cdg_solicitante  = Solicitante.cdg_solicitante.*/
         
  
END PROCEDURE.

PROCEDURE crear_pedido_detalle:

  T-Rqs_header.ultima_linea = T-Rqs_header.ultima_linea + 1.
  FIND Unidad OF Articulo NO-LOCK.
  CREATE T-Rqs_detalle.
  ASSIGN T-Rqs_detalle.nro_requisicion  = T-Rqs_header.nro_requisicion
         T-Rqs_detalle.nro_linea        = T-Rqs_header.ultima_linea
         T-Rqs_detalle.nro_Articulo     = Articulo.nro_Articulo
         T-Rqs_detalle.a_granel         = Articulo.a_granel
         T-Rqs_detalle.costo            = Articulo.costo
         T-Rqs_detalle.cantidad         = rep_cantidad
         T-Rqs_detalle.cantidad_sol     = rep_cantidad
         T-Rqs_detalle.granel           = rep_granel
         T-Rqs_detalle.cdg_estado       = "AL"
         T-Rqs_detalle.fecha_temprana   = TODAY
         T-Rqs_detalle.ultima_entrega   = 1.
         
  CREATE T-Rqs_detalle_ent.
  ASSIGN T-Rqs_detalle_ent.nro_requisicion  = T-Rqs_header.nro_requisicion
         T-Rqs_detalle_ent.nro_linea        = T-Rqs_header.ultima_linea
         T-Rqs_detalle_ent.nro_entrega      = 1
         T-Rqs_detalle_ent.a_granel         = Articulo.a_granel
         T-Rqs_detalle_ent.cantidad         = rep_cantidad
         T-Rqs_detalle_ent.granel           = rep_granel
         T-Rqs_detalle_ent.cdg_estado       = "AL"
         T-Rqs_detalle_ent.fecha_temprana   = TODAY.
         
      
END PROCEDURE.

PROCEDURE BAJAR_DATOS:

  DO TRANSACTION:
  
     FIND Parametro "PROXNRQS" EXCLUSIVE-LOCK.
  
     FOR EACH T-Rqs_header:
     
         T-Rqs_header.nro_comprob = Parametro.valor_n.
         Parametro.valor_n = Parametro.valor_n + 1.
         
         CREATE Rqs_header.
         BUFFER-COPY T-Rqs_header TO Rqs_header.
      
         FOR EACH T-Rqs_detalle 
             WHERE T-Rqs_detalle.nro_requisicion = T-Rqs_header.nro_requisicion:
             
             CREATE Rqs_detalle.
             BUFFER-COPY T-Rqs_detalle TO Rqs_detalle.
             
         END.
         
         FOR EACH T-Rqs_detalle_ent 
             WHERE T-Rqs_detalle_ent.nro_requisicion = T-Rqs_header.nro_requisicion:
             
             CREATE Rqs_detalle_ent.
             BUFFER-COPY T-Rqs_detalle_ent TO Rqs_detalle_ent.
             
         END.
         
         
     END.
     
     RELEASE Parametro.
     
  END.

/*
  FIND Parametro "PROXNTRA" EXCLUSIVE-LOCK.
  ASSIGN T-Rqs_header.nro_comprob = Parametro.valor_n
         Parametro.valor_n         = Parametro.valor_n + 1.
  RELEASE Parametro.
*/

END PROCEDURE.
