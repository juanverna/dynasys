/*====================================================================================*/
/*                GENERA EL LISTADO DE EXISTENCIAS POR DEPOSITO                       */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por    AS   INTEGER.
DEFINE INPUT PARAMETER des_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_fecha  AS   DATE.

/*====================================================================================*/
/*                                 VARIABLES                                          */
/*====================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE ing_cantidad   LIKE Cct_stock.cantidad LABEL "In.".
DEFINE VARIABLE egr_cantidad   LIKE Cct_stock.cantidad LABEL "Eg.".
DEFINE VARIABLE sal_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE ing_granel     LIKE Cct_stock.granel LABEL "In.".
DEFINE VARIABLE egr_granel     LIKE Cct_stock.granel LABEL "Eg.".
DEFINE VARIABLE sal_granel     LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE lst_e          AS   DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE lst_i          AS   DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE tot_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE tot_granel     LIKE Cct_stock.granel LABEL "Granel".

DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE hubo_dep AS LOGICAL.

DEFINE BUFFER B-Articulo-deposito FOR Articulo-deposito.
DEFINE QUERY qry_movimiento   FOR Cct_stock, B-Articulo-deposito.

{WGLISTAR.I}
{dfmodoexist.i}

/*====================================================================================*/
/*                                 FRAMES                                             */
/*====================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Existencias por Articulo/Depósito" AT 30
  "Página:" AT 86 PAGE-NUMBER FORMAT ">>9" AT 93
  SKIP
  fecha_lis
  titulo_det AT 30
  hora_lis AT 86
  SKIP(1)
  WITH WIDTH 120 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       Articulo.cdg_articulo COLUMN-LABEL "Código!Artículo"
       Articulo.descripcion  COLUMN-LABEL "Descripción!Artículo"
       Articulo.cdg_umed     COLUMN-LABEL "Uni!dad" 
       Articulo.a_granel     COLUMN-LABEL "Gra!nel" FORMAT "Si/"
       tot_cantidad          COLUMN-LABEL "Existencia!Unidades"
       tot_granel            COLUMN-LABEL "Existencia!a Granel"
       WITH WIDTH 120 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

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
     tot_cantidad = 0.
     tot_granel = 0.
     
     FOR EACH Articulo-deposito OF Articulo NO-LOCK 
              WHERE Articulo-deposito.cdg_empresa   = Empresa.cdg_empresa,
         FIRST Deposito OF Articulo-deposito NO-LOCK
                    WHERE Deposito.cdg_deposito >= des_coddep
                      AND Deposito.cdg_deposito <= has_coddep:
              
         
         RUN calcular_stock_real.p (INPUT ROWID(Articulo),
                                    INPUT ROWID(Deposito),
                                    INPUT ?, /* No deseamos stock por partidas */
                                    INPUT has_fecha ,
                                    INPUT dep,
                                    OUTPUT sal_cantidad,
                                    OUTPUT sal_granel ).

         tot_cantidad = tot_cantidad + sal_cantidad.
         tot_granel   = tot_granel   + sal_granel.
             
     END.

     DISPLAY Articulo.cdg_articulo
             Articulo.descripcion
             Articulo.cdg_umed
             Articulo.a_granel
             tot_cantidad
             tot_granel
     WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.

     GET NEXT qry_Articulos.

  END.

  UNDERLINE
       Articulo.cdg_articulo
       Articulo.descripcion
       Articulo.cdg_umed
       Articulo.a_granel
       tot_cantidad
       tot_granel
       WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).

END PROCEDURE.

