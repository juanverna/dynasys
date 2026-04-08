/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codart  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codart  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER des_coddep  LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER has_coddep  LIKE Deposito.cdg_deposito.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE BUFFER Ugranel FOR Unidad.

DEFINE VARIABLE que_comprobante    AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!del Comprobante".

DEFINE VARIABLE t-a-cantidad       LIKE Rem_detalle_prv.cantidad.
DEFINE VARIABLE t-a-granel         LIKE Rem_detalle_prv.granel.
DEFINE VARIABLE t-p-cantidad       LIKE Rem_detalle_prv.cantidad.
DEFINE VARIABLE t-p-granel         LIKE Rem_detalle_prv.granel.
DEFINE VARIABLE t-d-cantidad       LIKE Rem_detalle_prv.cantidad.
DEFINE VARIABLE t-d-granel         LIKE Rem_detalle_prv.granel.
DEFINE VARIABLE umed               AS CHARACTER FORMAT "X(5)".


DEFINE VARIABLE g-a-cantidad       LIKE Rem_detalle_prv.cantidad.
DEFINE VARIABLE g-a-granel         LIKE Rem_detalle_prv.granel.
DEFINE VARIABLE mostrar_articulo   AS LOGICAL.

DEFINE VARIABLE que_sector LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Total Recibido por Artículo/Depósito" AT 40
    "Página:" AT 93 PAGE-NUMBER FORMAT "9999" AT 100
    SKIP  
    fecha_lis
    "del" AT 40
    des_fecha
    "al"
    has_fecha
    hora_lis AT 93
    SKIP (1) 
    WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    Deposito.cdg_deposito
    t-d-cantidad             COLUMN-LABEL "Cantidad!Recibida"
    Unidad.abrevia           COLUMN-LABEL "Unidad!Medida"
    t-d-granel               COLUMN-LABEL "Granel!Recibido"
    Ugranel.abrevia          COLUMN-LABEL "Unidad!Medida"
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
  FOR EACH Rem_header_prv NO-LOCK
        WHERE Rem_header_prv.cdg_empresa = Empresa.cdg_empresa
          AND Rem_header_prv.fecha <= has_fecha
          AND Rem_header_prv.fecha >= des_fecha
          AND NOT Rem_header_prv.anulado,
              FIRST Tipocomprobante OF Rem_header_prv NO-LOCK,
              EACH Rem_detalle_prv OF Rem_header_prv NO-LOCK,
          FIRST Articulo OF Rem_detalle_prv
                WHERE Articulo.cdg_articulo <= has_codart
                  AND Articulo.cdg_articulo >= des_codart NO-LOCK,
          FIRST Deposito OF Rem_detalle_prv
                WHERE Deposito.cdg_deposito <= has_coddep
                  AND Deposito.cdg_deposito >= des_coddep NO-LOCK,
          FIRST Partida  OF Rem_detalle_prv NO-LOCK
          BREAK BY Articulo.cdg_articulo
                BY Partida.cdg_partida
                BY Deposito.cdg_deposito:

       VIEW FRAME frm-titulo.

       IF NOT Tipocomprobante.debita
           THEN ASSIGN t-d-cantidad = t-d-cantidad + Rem_detalle_prv.cantidad
                       t-d-granel   = t-d-granel   + Rem_detalle_prv.granel.
           ELSE ASSIGN t-d-cantidad = t-d-cantidad - Rem_detalle_prv.cantidad
                       t-d-granel   = t-d-granel   - Rem_detalle_prv.granel.

       IF LAST-OF(Deposito.cdg_deposito)
       THEN DO:
     
           FIND Unidad OF Articulo NO-LOCK. 
           FIND Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.

           DISPLAY 
                 Articulo.cdg_articulo WHEN mostrar_articulo
                 Articulo.descripcion  WHEN mostrar_articulo
                 Partida.cdg_partida   
                 Deposito.cdg_deposito   
                 t-d-cantidad
                 Unidad.abrevia
                 t-d-granel
                 Ugranel.abrevia               
                 WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.

            ASSIGN
                 t-p-cantidad = t-p-cantidad + t-d-cantidad
                 t-p-granel   = t-p-granel   + t-d-granel
                 t-d-cantidad = 0
                 t-d-granel   = 0
                 mostrar_articulo = NO.

       END.

       IF LAST-OF(Partida.cdg_partida)
       THEN DO:
     
           FIND Unidad OF Articulo NO-LOCK. 
           FIND Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.

           UNDERLINE 
                t-d-cantidad
                t-d-granel
                WITH FRAME frm-listado.

           DISPLAY 
                 t-p-cantidad      @ t-d-cantidad
                 Unidad.abrevia    
                 t-p-granel        @ t-d-granel
                 Ugranel.abrevia               
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
                 t-d-cantidad
                 t-d-granel
                 WITH FRAME frm-listado.
            DISPLAY
                 t-a-cantidad @ t-d-cantidad
                 unidad.abrevia
                 t-a-granel   @ t-d-granel
                 ugranel.abrevia
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

  OUTPUT CLOSE.

END PROCEDURE.  

