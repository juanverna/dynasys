/*====================================================================================*/
/*                Genera el listado de movimientos por articulo                       */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por    AS   INTEGER.
DEFINE INPUT PARAMETER des_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER des_fecha  AS   DATE.
DEFINE INPUT PARAMETER has_fecha  AS   DATE.

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE ry             AS   CHARACTER FORMAT "X(131)".
DEFINE VARIABLE tod            AS   INTEGER INITIAL 0.
DEFINE VARIABLE dep            AS   INTEGER INITIAL 1.
DEFINE VARIABLE par            AS   INTEGER INITIAL 2.
DEFINE VARIABLE ing_cantidad   LIKE Cct_stock.cantidad LABEL "In.".
DEFINE VARIABLE egr_cantidad   LIKE Cct_stock.cantidad LABEL "Eg.".
DEFINE VARIABLE sal_cantidad   LIKE Cct_stock.cantidad LABEL "Unidades".
DEFINE VARIABLE ing_granel     LIKE Cct_stock.granel LABEL "In.".
DEFINE VARIABLE egr_granel     LIKE Cct_stock.granel LABEL "Eg.".
DEFINE VARIABLE sal_granel     LIKE Cct_stock.granel LABEL "Granel".
DEFINE VARIABLE list_i_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE list_e_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_i_un       LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_e_un       LIKE Cct_stock.cantidad.

DEFINE VARIABLE list_i_gr      LIKE Cct_stock.granel.
DEFINE VARIABLE list_e_gr      LIKE Cct_stock.granel.
DEFINE VARIABLE tot_i_gr       LIKE Cct_stock.granel.
DEFINE VARIABLE tot_e_gr       LIKE Cct_stock.granel.

DEFINE VARIABLE todos       AS LOGICAL.
DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".

DEFINE QUERY qry_partidas   FOR Partida, Articulo.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       "Vencimiento de partidas" AT 50
       "Pagina:" AT  108 PAGE-NUMBER FORMAT ">9" AT 115
       SKIP
       fecha_lis
       des_fecha  AT 50
       "-"
       has_fecha
       hora_lis AT 108
       SKIP(1)
       WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.


DEFINE FRAME frm-partida
       Partida.fecha_vencimiento  COLUMN-LABEL "Fecha!Vencimiento"
       Partida.cdg_partida        COLUMN-LABEL "Código!Partida"
       Partida.descripcion        COLUMN-LABEL "Descripción!Partida"
       Partida.remanente_cantidad COLUMN-LABEL "Remanente!Unidades"
       Partida.remanente_granel   COLUMN-LABEL "Remanente!A Granel"
       Articulo.cdg_articulo      COLUMN-LABEL "Código!Artículo"
       Articulo.descripcion       COLUMN-LABEL "Descripción!Artículo"
       Articulo.a_granel          COLUMN-LABEL "Gra!nel"
       Articulo.cdg_umed          COLUMN-LABEL "Uni!dad"
       WITH WIDTH 151 FRAME frm-partida USE-TEXT STREAM-IO DOWN. 

DEFINE FRAME frm-raya
       ry
       SKIP
       WITH WIDTH 131 FRAME frm-raya USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  titulo_det = "Al " + STRING(has_fecha).
  ry = FILL("-",131).
  PAUSE 0.
  mensaje = "    Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i}

  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_partidas
     FOR EACH Partida  WHERE Partida.fecha_vencimiento <= has_fecha 
                         AND Partida.fecha_vencimiento >= des_fecha,
                         FIRST Articulo OF Partida 
                         WHERE Articulo.cdg_articulo >= des_codart
                         AND Articulo.cdg_articulo <= has_codart
                             BY Partida.fecha_vencimiento 
                             BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_partidas
     FOR EACH Partida  WHERE Partida.fecha_vencimiento <= has_fecha 
                         AND Partida.fecha_vencimiento >= des_fecha,
                         FIRST Articulo OF Partida 
                         WHERE Articulo.descripcion >= des_nomart
                           AND Articulo.descripcion <= has_nomart
                               BY Partida.fecha_vencimiento 
                               BY Articulo.descripcion.

  END.

  GET FIRST qry_partidas.
  DO WHILE AVAILABLE Partida:

     VIEW FRAME frm-titulo.
     DISPLAY
         Partida.fecha_vencimiento
         Partida.cdg_partida
         Partida.descripcion
         Partida.remanente_cantidad 
         Partida.remanente_granel
         Articulo.cdg_articulo
         Articulo.descripcion
         Articulo.a_granel       
         Articulo.cdg_umed       
         WITH FRAME frm-partida.
     
     DOWN WITH FRAME frm-partida.

     GET NEXT qry_partidas.

  END. /* De las Partidas */

  OUTPUT CLOSE.

  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).

END PROCEDURE.

