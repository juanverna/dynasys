/*=================================================================================*/
/*          EMITE EL LISTADO DE ENTREGAS DE O/COMPRA POR FECHA                     */ 
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha      AS   DATE.
DEFINE INPUT PARAMETER has_fecha      AS   DATE.
DEFINE INPUT PARAMETER disp_out       AS   CHARACTER.

{VRSHARED.I}
{VPERSINM.I}
{WGLISTAR.I}

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE nom_sector  LIKE Area.denominacion.
DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE tot_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_gr      LIKE Cct_stock.granel.

FORM HEADER
   que_empresa
   "Ordenes de Compra por fecha" AT 40
   "Página:" AT  103 PAGE-NUMBER FORMAT ">9" AT 111
   SKIP
   fecha_lis
   "Período" AT 40
   des_fecha " - " has_fecha
   hora_lis AT 103
   SKIP(1) 
   "-----------------------------------------------------------------------------------------------------------------" SKIP
   "Fecha de    Código de        Descripción                  Número de   Cantidad        Granel Un. de       Precio " SKIP
   "Ingreso     Artículo         Artículo                      O/Compra     Pedida        Pedido Medida     Unitario " SKIP
   "-----------------------------------------------------------------------------------------------------------------" SKIP(1)
   WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
   Ocm_detalle.fecha_temprana
   Articulo.cdg_articulo
   Articulo.descripcion  FORMAT "X(35)"
   Ocm_header.nro_comprob
   Ocm_detalle.granel
   Ocm_detalle.cantidad
   Articulo.cdg_umed
   Ocm_detalle.precio
   WITH WIDTH 131 FRAME frm-detl USE-TEXT STREAM-IO DOWN NO-LABEL NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.
  FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
  que_empresa = Empresa.nombre.

  OUTPUT TO VALUE(DIRE_TMP + "lsocmfec.txt") PAGED PAGE-SIZE 72.

  RUN PONE_CODIGO ( INPUT "HORIZONT,SET17CPI,CARTA").

     VIEW FRAME frm-titulo.

     tot_un = 0.
     tot_gr = 0.
     
     FOR EACH Ocm_detalle 
         WHERE Ocm_detalle.fecha_temprana >= des_fecha
           AND Ocm_detalle.fecha_temprana <= has_fecha,
           EACH Ocm_header OF Ocm_detalle ,
           Articulo OF Ocm_detalle 
           BREAK BY Ocm_detalle.fecha_temprana 
                 BY Articulo.cdg_articulo :


          VIEW FRAME frm-titulo.
          DISPLAY Ocm_detalle.fecha_temprana  WHEN FIRST-OF(Ocm_detalle.fecha_temprana)
                  Articulo.cdg_articulo WHEN FIRST-OF(Articulo.cdg_articulo)
                  Articulo.descripcion  WHEN FIRST-OF(Articulo.cdg_articulo)
                  Ocm_header.nro_comprob
                  Ocm_detalle.granel
                  Ocm_detalle.cantidad
                  Articulo.cdg_umed COLUMN-LABEL "Un."
                  Ocm_detalle.precio
                  WITH CENTERED FRAME frm-detl STREAM-IO USE-TEXT.

                  DOWN WITH FRAME frm-detl.
                  
          IF LAST-OF(Ocm_detalle.fecha_temprana) 
             THEN DOWN 2 WITH FRAME frm-det1.  
     END.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.

{CODIMPRE.I}
