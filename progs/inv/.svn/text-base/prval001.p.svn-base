/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_remito      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{DEFVRIMP.I}

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
    "VALE DE ALMACENES:" AT 40
    Valeinv_hd.tip_comprob FORMAT "X(2)" NO-LABEL
    Valeinv_hd.nro_comprob NO-LABEL
    SPACE(10)
    Valeinv_hd.fecha
    SKIP(2)
    "[" AT 15 
    Area.cdg_Area 
    "]"
    Area.denominacion      
    SKIP(2)
    "["       AT 15
    Imputacion.cdg_Imputacion 
    "]"
    Imputacion.dsc_imputacion
    SKIP(1)
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 160.

FORM
    Valeinv_hd.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 96 NO-LABELS.

FORM
    Articulo.cdg_articulo            COLUMN-LABEL "Código!Artículo"
    Partida.cdg_partida              COLUMN-LABEL "Código!Partida"
    Articulo.descripcion             COLUMN-LABEL "Descripción!del Artículo"
    Valeinv_dt.cantidad              COLUMN-LABEL "Cantidad!MOvimiento"
    Unidad.abrevia                   COLUMN-LABEL "Un.!Med."
    Deposito.cdg_deposito            COLUMN-LABEL "Código de!Depósito"
    Deposito.nombre                  COLUMN-LABEL "Nombre!Depósito"
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 160 /* NO-LABELS.*/.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 160 NO-LABELS.
/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/


FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = act_remito NO-LOCK .
FIND Area     OF Valeinv_hd NO-LOCK NO-ERROR.
FIND Imputacion OF Valeinv_hd NO-LOCK NO-ERROR.

OUTPUT TO "c:\sic-temp\prval001.txt" PAGE-SIZE 0.


/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Valeinv_hd.tip_comprob
    Valeinv_hd.nro_comprob
    Valeinv_hd.fecha
    Area.denominacion        WHEN AVAILABLE Area
    Area.cdg_Area          WHEN AVAILABLE Area
    Imputacion.dsc_imputacion  WHEN AVAILABLE Imputacion
    Imputacion.cdg_Imputacion  WHEN AVAILABLE Imputacion
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Valeinv_dt NO-LOCK OF Valeinv_hd, 
        Articulo OF Valeinv_dt NO-LOCK:

  FIND Unidad OF Articulo NO-LOCK.
  FIND Partida OF Valeinv_dt NO-LOCK NO-ERROR.
  FIND Deposito OF Valeinv_dt NO-LOCK NO-ERROR.

  DISPLAY  Articulo.cdg_articulo
           Partida.cdg_partida  WHEN AVAILABLE Partida
           Articulo.descripcion
           Unidad.abrevia
           Valeinv_dt.cantidad
           Deposito.cdg_deposito WHEN AVAILABLE Deposito
           Deposito.nombre       WHEN AVAILABLE Deposito
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

RUN veresult.w ( INPUT  "c:\sic-temp\prval001.txt" ,  /* Archivo */
                 INPUT 2 ).            /* FONT a utilizar por default */               

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/



