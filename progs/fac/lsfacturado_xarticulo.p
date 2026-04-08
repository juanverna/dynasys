/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codigo  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante    AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!del Comprobante".

DEFINE VARIABLE t-a-cantidad       LIKE Fac_detalle.cantidad.
DEFINE VARIABLE t-a-granel         LIKE Fac_detalle.granel.
DEFINE VARIABLE t-p-cantidad       LIKE Fac_detalle.cantidad.
DEFINE VARIABLE t-p-granel         LIKE Fac_detalle.granel.

DEFINE VARIABLE g-a-cantidad       LIKE Fac_detalle.cantidad.
DEFINE VARIABLE g-a-granel         LIKE Fac_detalle.granel.
DEFINE VARIABLE mostrar_articulo   AS LOGICAL.
{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE BUFFER Ugranel FOR Unidad.

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Total Facturado por Artículo" AT 40
    "Página:" AT 89 PAGE-NUMBER FORMAT "9999" AT 96
    SKIP  
    fecha_lis
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 89
    SKIP (1) 
    WITH WIDTH 110 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    t-p-cantidad             COLUMN-LABEL "Cantidad!Facturada"
    Unidad.abrevia           COLUMN-LABEL "Uni-!dad"
    t-p-granel               COLUMN-LABEL "Granel!Facturado"
    Ugranel.abrevia          COLUMN-LABEL "Uni-!dad"
    WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO.

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
  FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
          AND Fac_header.fecha <= has_fecha
          AND Fac_header.fecha >= des_fecha
          AND NOT Fac_header.anulado,
              FIRST Cliente OF Fac_header,
              EACH Fac_detalle OF Fac_header,
          FIRST Articulo OF Fac_detalle
                WHERE Articulo.cdg_articulo <= has_codigo
                  AND Articulo.cdg_articulo >= des_codigo,
          FIRST Partida  OF Fac_detalle
          BREAK BY Articulo.cdg_articulo
                BY Partida.cdg_partida:

       VIEW FRAME frm-titulo.

       FIND Tipocomprobante OF Fac_header NO-LOCK.
       FIND Imputacion OF Fac_header NO-LOCK.

       IF Imputacion.afecta_stock
           THEN IF Tipocomprobante.debita
                  THEN ASSIGN t-p-cantidad = t-p-cantidad + Fac_detalle.cantidad
                              t-p-granel   = t-p-granel   + Fac_detalle.granel.
                  ELSE ASSIGN t-p-cantidad = t-p-cantidad - Fac_detalle.cantidad
                              t-p-granel   = t-p-granel   - Fac_detalle.granel.

       IF LAST-OF(Partida.cdg_partida)
       THEN DO:
     
           FIND Unidad OF Articulo NO-LOCK.
           FIND Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
            
           DISPLAY 
                 Articulo.cdg_articulo WHEN mostrar_articulo
                 Articulo.descripcion  WHEN mostrar_articulo
                 Partida.cdg_partida   
                 t-p-cantidad
                 Unidad.abrevia
                 t-p-granel
                 Ugranel.abrevia
                 WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.

            IF Imputacion.afecta_stock
            THEN DO: 
                ASSIGN
                    t-a-cantidad = t-a-cantidad + t-p-cantidad
                    t-a-granel   = t-a-granel   + t-p-granel.
            END.

            ASSIGN
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
                 Unidad.abrevia
                 t-a-granel   @ t-p-granel
                 Ugranel.abrevia
                 WITH FRAME frm-listado.

            DOWN 2 WITH FRAME frm-listado.

            ASSIGN
                 g-a-cantidad = g-a-cantidad + t-a-cantidad
                 g-a-granel   = g-a-granel   + t-a-granel
                 t-a-cantidad = 0
                 t-a-granel   = 0
                 mostrar_articulo = YES.

       END.

  END.   

  UNDERLINE 
       t-p-cantidad
       t-p-granel
       WITH FRAME frm-listado.
  DISPLAY
       g-a-cantidad @ t-p-cantidad
       g-a-granel   @ t-p-granel
       WITH FRAME frm-listado.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.
