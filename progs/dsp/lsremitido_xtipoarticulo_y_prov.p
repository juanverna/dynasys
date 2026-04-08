/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Tipo_articulo.cdg_tipoart.
DEFINE INPUT PARAMETER has_codigo  LIKE Tipo_articulo.cdg_tipoart.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE t-a-cantidad       LIKE Rem_detalle.cantidad.
DEFINE VARIABLE t-a-granel         LIKE Rem_detalle.granel.
DEFINE VARIABLE t-p-cantidad       LIKE Rem_detalle.cantidad.
DEFINE VARIABLE t-p-granel         LIKE Rem_detalle.granel.

DEFINE VARIABLE g-a-cantidad       LIKE Rem_detalle.cantidad.
DEFINE VARIABLE g-a-granel         LIKE Rem_detalle.granel.
DEFINE VARIABLE mostrar_articulo   AS LOGICAL.
DEFINE VARIABLE titulo_det         AS CHARACTER FORMAT "X(40)".

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Total Remitido por Provincia y T.Artículo" AT 40
    "Página:" AT 83 PAGE-NUMBER FORMAT "9999" AT 90
    SKIP  
    fecha_lis
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 83
    SKIP (1) 
    titulo_det AT 40
    SKIP(1)
    WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    t-p-cantidad             COLUMN-LABEL "Cantidad!Remitida"
    t-p-granel               COLUMN-LABEL "Granel!Remitido"
    WITH WIDTH 96 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  que_empresa = Empresa.nombre.
   
  {dirprinfile.i}

  mostrar_articulo = YES.
  FOR EACH Rem_header NO-LOCK
        WHERE Rem_header.cdg_empresa = Empresa.cdg_empresa
          AND Rem_header.fecha <= has_fecha
          AND Rem_header.fecha >= des_fecha
          AND NOT Rem_header.anulado,
              FIRST Cliente OF Rem_header,
              EACH Rem_detalle NO-LOCK OF Rem_header,
          FIRST Articulo OF Rem_detalle
                WHERE Articulo.cdg_tipoart <= has_codigo
                  AND Articulo.cdg_tipoart >= des_codigo,
          FIRST Partida  OF Rem_detalle
          BREAK BY Rem_header.cdg_provincia
                BY Articulo.cdg_tipoart
                BY Articulo.cdg_articulo
                BY Partida.cdg_partida:

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Rem_header.cdg_provincia)
       THEN DO:
            FIND Tipo_articulo OF Articulo NO-LOCK.
            titulo_det = Tipo_articulo.cdg_tipoart + " - " + Tipo_articulo.dsc_tipoart.
       END.

       IF FIRST-OF(Articulo.cdg_tipoart)
       THEN DO:
            FIND Tipo_articulo OF Articulo NO-LOCK.
            titulo_det = Tipo_articulo.cdg_tipoart + " - " + Tipo_articulo.dsc_tipoart.
       END.

       ASSIGN
            t-p-cantidad = t-p-cantidad + Rem_detalle.cantidad
            t-p-granel   = t-p-granel   + Rem_detalle.granel.


       IF LAST-OF(Partida.cdg_partida)
       THEN DO:
     
            DISPLAY 
                 Articulo.cdg_articulo WHEN mostrar_articulo
                 Articulo.descripcion  WHEN mostrar_articulo
                 Partida.cdg_partida   
                 t-p-cantidad
                 t-p-granel
                 WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.

            ASSIGN
                 t-a-cantidad = t-a-cantidad + t-p-cantidad
                 t-a-granel   = t-a-granel   + t-p-granel
                 t-p-cantidad = 0
                 t-p-granel   = 0
                 mostrar_articulo = NO.

       END.
       
       IF LAST-OF(Articulo.cdg_articulo)
       THEN DO:

            UNDERLINE 
                 t-p-cantidad
                 t-p-granel
                 WITH FRAME frm-listado.
            DISPLAY
                 t-a-cantidad @ t-p-cantidad
                 t-a-granel   @ t-p-granel
                 WITH FRAME frm-listado.

            DOWN 2 WITH FRAME frm-listado.

            ASSIGN
                 g-a-cantidad = g-a-cantidad + t-a-cantidad
                 g-a-granel   = g-a-granel   + t-a-granel
                 t-a-cantidad = 0
                 t-a-granel   = 0
                 mostrar_articulo = YES.

       END.

       IF LAST-OF(Articulo.cdg_tipoart)
       THEN IF NOT LAST(Articulo.cdg_tipoart)
               THEN PAGE.

  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

