/*====================================================================================*/
/*                Genera el listado de existencias por Articulo-deposito                        */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por    AS   INTEGER.
DEFINE INPUT PARAMETER des_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_fecha  AS   DATE.

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE ing_cantidad   LIKE Cct_stock.cantidad LABEL "In.".
DEFINE VARIABLE egr_cantidad   LIKE Cct_stock.cantidad LABEL "Eg.".
DEFINE VARIABLE sal_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE ing_granel     LIKE Cct_stock.granel LABEL "In.".
DEFINE VARIABLE egr_granel     LIKE Cct_stock.granel LABEL "Eg.".
DEFINE VARIABLE sal_granel     LIKE Cct_stock.granel LABEL "Granel" FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE lst_e          AS   DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE lst_i          AS   DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE valor          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE valor_extracontable AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tar_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades" FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tar_granel     LIKE Cct_stock.granel LABEL "Granel" FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tar_valor          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tar_valor_extracontable AS DECIMAL FORMAT "->>>,>>9.99".

DEFINE VARIABLE tot_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades" FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_granel     LIKE Cct_stock.granel LABEL "Granel" FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_valor          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_valor_extracontable AS DECIMAL FORMAT "->>>,>>9.99".

DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE hubo_dep AS LOGICAL.

DEFINE BUFFER B-Articulo-deposito FOR Articulo-deposito.
DEFINE QUERY qry_movimiento   FOR Cct_stock, B-Articulo-deposito.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Existencias Valorizadas por Artículo/Depósito" AT 48
  "Página:" AT 136 PAGE-NUMBER FORMAT "9999" AT 144
  SKIP
  fecha_lis
  titulo_det AT 48
  hora_lis AT 136
  SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       Articulo.cdg_articulo              COLUMN-LABEL "Código!Artículo"
       Articulo.descripcion               COLUMN-LABEL "Descripción!Artículo"
       Articulo.costo                     COLUMN-LABEL "Costo!Artículo" FORMAT ">>>,>>9.99"
       Articulo.costo_extracontable       COLUMN-LABEL "Costo!Extracon" FORMAT ">>>,>>9.99"
       Articulo.cdg_umed                  COLUMN-LABEL "Uni!dad"
       Articulo.a_granel                  COLUMN-LABEL "Gra!nel" FORMAT "Si/"
       Deposito.cdg_deposito     COLUMN-LABEL "Código!Depósito"
       sal_cantidad                       COLUMN-LABEL "Existencia!Unidades"
       sal_granel                         COLUMN-LABEL "Existencia!A Granel"
       valor                              COLUMN-LABEL "Valuación!Contable"
       valor_extracontable                COLUMN-LABEL "Valuación!Extracont."
       WITH WIDTH 160 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  titulo_det = "Depósitos: " + STRING(des_coddep) + " - " + STRING(has_coddep) + " Al " + STRING(has_fecha).

  PAUSE 0.
  mensaje = "    Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i}
  
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.cdg_articulo >= des_codart
                         AND Articulo.cdg_articulo <= has_codart
                         AND Articulo.stock_sino
                          BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.descripcion >= des_nomart
                         AND Articulo.descripcion <= has_nomart
                         AND Articulo.stock_sino
                          BY Articulo.descripcion.
  END.

  GET FIRST qry_Articulos.
  DO WHILE AVAILABLE Articulo:
     VIEW FRAME frm-titulo.
     tar_cantidad = 0.
     tar_granel = 0.
     hubo_dep = NO.
     FOR EACH Articulo-deposito OF Articulo
              WHERE Articulo-deposito.cdg_empresa = Empresa.cdg_empresa, 
              FIRST Deposito OF Articulo-deposito 
                    WHERE Deposito.cdg_deposito >= des_coddep
                      AND Deposito.cdg_deposito <= has_coddep
              BREAK BY Deposito.cdg_deposito:
              
         act_deposito = ROWID(Deposito).
         RUN CALCSTCK.P (INPUT ROWID(Articulo),
                         INPUT has_fecha,
                         INPUT 1,
                         OUTPUT sal_cantidad,
                         OUTPUT sal_granel).
         IF sal_cantidad <> 0 OR sal_granel <> 0  
         THEN DO:                        
             IF Articulo.a_granel THEN DO:
                valor = sal_granel * Articulo.costo.
                valor_extracontable = sal_granel * Articulo.costo_extracontable.
             END.
             ELSE DO:
                valor = sal_cantidad * Articulo.costo.
                valor_extracontable = sal_cantidad * Articulo.costo_extracontable.
             END.
          
             DISPLAY
                 Articulo.cdg_articulo          WHEN FIRST(Deposito.cdg_deposito)
                 Articulo.descripcion           WHEN FIRST(Deposito.cdg_deposito)
                 Articulo.cdg_umed              WHEN FIRST(Deposito.cdg_deposito)
                 Articulo.a_granel              WHEN FIRST(Deposito.cdg_deposito)
                 Articulo.costo                 WHEN FIRST(Deposito.cdg_deposito)
                 Articulo.costo_extracontable   WHEN FIRST(Deposito.cdg_deposito)
                 Deposito.cdg_deposito
                 sal_cantidad
                 sal_granel
                 valor
                 valor_extracontable
                 WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.

            tar_cantidad = tar_cantidad + sal_cantidad.
            tar_granel = tar_granel + sal_granel.
            tar_valor = tar_valor + valor.
            tar_valor_extracontable = tar_valor_extracontable + valor_extracontable.
            hubo_dep = YES.
        END.       
     END.

     IF hubo_dep
     THEN DO:
          UNDERLINE
              Deposito.cdg_deposito
              sal_cantidad
              sal_granel
              Articulo.costo                 
              Articulo.costo_extracontable
              valor
              valor_extracontable
              WITH FRAME frm-listado.

          DISPLAY     tar_cantidad @ sal_cantidad
                      tar_granel   @ sal_granel
                      tar_valor    @ valor
                      tar_valor_extracontable @ valor_extracontable
                      WITH FRAME frm-listado.

          DOWN 2 WITH FRAME frm-listado.
     END.     

     tot_cantidad = tot_cantidad + tar_cantidad.
     tot_granel = tot_granel + tar_granel.
     tot_valor = tot_valor + tar_valor.
     tot_valor_extracontable = tot_valor_extracontable + tar_valor_extracontable.

     tar_cantidad = 0.
     tar_granel = 0.
     tar_valor = 0.
     tar_valor_extracontable = 0. 

     GET NEXT qry_Articulos.

  END.

  UNDERLINE
       Articulo.cdg_articulo
       Articulo.a_granel
       Articulo.descripcion
       Articulo.cdg_umed
       Deposito.cdg_deposito
       sal_cantidad
       sal_granel
       Articulo.costo                 
       Articulo.costo_extracontable
       valor
       valor_extracontable
       WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.

  DISPLAY   "TOTAL GENERAL" @ Articulo.descripcion
            tot_cantidad @ sal_cantidad
            tot_granel   @ sal_granel
            tot_valor    @ valor
            tot_valor_extracontable @ valor_extracontable
            WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).

END PROCEDURE.

