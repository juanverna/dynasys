
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
    SKIP(1)
    "PARTE DE DESPACHO:" AT 20
    Rem_header.tip_comprob
    Rem_header.nro_comprob
    SPACE(5)
    Rem_header.fecha
    SKIP(1)
    "[" Cliente.cdg_Cliente "]"
    SPACE(3)
    Rem_header.nombre
    SKIP(1)
    "----------------------------------------------------------------------------------------" SKIP
    " ARTICULO  PARTIDA DESCRIPCION                                CANTIDAD     GRANEL UNIDAD" SKIP
    "----------------------------------------------------------------------------------------" SKIP
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM
    Rem_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 96 NO-LABELS.

FORM
    Articulo.cdg_articulo
    Partida.cdg_partida
    Articulo.descripcion
    Rem_detalle.cantidad
    Rem_detalle.granel
    Unidad.abrevia
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN NO-LABELS WIDTH 96.

FORM
    "----------------------------------------------------------------------------------------" SKIP(1)
     Rem_header.leyenda VIEW-AS EDITOR SIZE 75 BY 3 SKIP
    "----------------------------------------------------------------------------------------" SKIP
    WITH FRAME frm-pie NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

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

Rem_header.leyenda:WIDTH = ccoobsdc.
Rem_header.leyenda:HEIGHT = cliobsdc.

FIND Rem_header WHERE ROWID(Rem_header) = act_remito EXCLUSIVE-LOCK.
FIND Cliente WHERE Cliente.nro_Cliente = Rem_header.nro_cliente NO-LOCK NO-ERROR.

OUTPUT TO VALUE(dire_tmp + "prpds001.txt") PAGE-SIZE 48.

RUN PONE_CODIGO ( INPUT "SET12CPI,SET48LPP" ).

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Rem_header.tip_comprob
    Rem_header.nro_comprob
    Rem_header.fecha
    Rem_header.nombre
    Cliente.cdg_Cliente  WHEN AVAILABLE Cliente
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Rem_detalle OF Rem_header, Articulo OF Rem_detalle, Partida OF Rem_detalle,
         Unidad OF Articulo:

  DISPLAY  Articulo.cdg_articulo
           Partida.cdg_partida WHEN Articulo.hay_partida
           Articulo.descripcion
           Unidad.abrevia
           Rem_detalle.cantidad
           Rem_detalle.granel
           Rem_detalle.granel
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
    Rem_header.leyenda
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.

RUN PROPRINT.P ( INPUT dire_tmp + "prpds001.txt" ).
