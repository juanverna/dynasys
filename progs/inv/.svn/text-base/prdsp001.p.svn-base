
/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_remito      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 20.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE condventa   AS CHARACTER FORMAT "X(35)".


FORM
    SKIP(2)
    "PARTE DE DESPACHO:" AT 40
    Valeinv_hd.tip_comprob NO-LABEL
    Valeinv_hd.nro_comprob NO-LABEL
    SKIP(1)
    Valeinv_hd.fecha       AT 57
    SKIP(5)
    Area.denominacion      AT 15
    "[" Area.cdg_Area "]"
    SKIP(1)
    SPACE(5)
    "ARTICULO DESCRIPCION                  CANTIDAD UNIDAD"
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 85.

FORM
    Valeinv_hd.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 96 NO-LABELS.

FORM
    Articulo.cdg_articulo
    Partida.cdg_partida
    Articulo.descripcion
    Valeinv_dt.cantidad
    Unidad.abrevia
    Valeinv_dt.granel
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 96 NO-LABELS.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 96 NO-LABELS.
/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/


{SETIMPRE.I}


FIND Parametro "CLIOBSRC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSRC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Valeinv_hd.leyenda:WIDTH = ccoobsdc.
Valeinv_hd.leyenda:HEIGHT = cliobsdc.

FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = act_remito EXCLUSIVE-LOCK.
FIND Area OF Valeinv_hd NO-LOCK NO-ERROR.

OUTPUT TO VALUE(dire_tmp + "prdsp001.txt") PAGE-SIZE 72.

RUN PONE_CODIGO ( INPUT "CARTA,SET12CPI" ).

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Valeinv_hd.tip_comprob
    Valeinv_hd.nro_comprob
    Valeinv_hd.fecha
    Area.denominacion
    Area.cdg_Area  WHEN AVAILABLE Area
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Valeinv_dt OF Valeinv_hd, Articulo OF Valeinv_dt, Partida OF Valeinv_dt:

  FIND Unidad OF Articulo NO-LOCK.
  DISPLAY  Articulo.cdg_articulo
           Partida.cdg_partida
           Articulo.descripcion
           Unidad.abrevia
           Valeinv_dt.cantidad
           Valeinv_dt.granel
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
  DOWN WITH FRAME frm-detalle.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Valeinv_hd.leyenda
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.

RUN PROPRINT.P ( INPUT dire_tmp + "prdsp001.txt" ).

