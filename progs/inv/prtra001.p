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
    "VALE DE TRANSFERENCIA ENTRE ALMACENES:" AT 40
    Transdep_hd.tip_comprob NO-LABEL
    Transdep_hd.nro_comprob NO-LABEL
    SPACE(10)
    Transdep_hd.fecha
    SKIP(2)
    "[" AT 15 
    Deposito.cdg_Deposito 
    "]"
    Deposito.nombre      
    SKIP(2)
    "["       AT 15
    Imputacion.cdg_Imputacion 
    "]"
    Imputacion.dsc_imputacion
    SKIP(1)
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 160.

FORM
    Transdep_hd.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 96 NO-LABELS.

FORM
    Articulo.cdg_articulo            COLUMN-LABEL "Código!Artículo"
    Partida.cdg_partida              COLUMN-LABEL "Código!Partida"
    Articulo.descripcion             COLUMN-LABEL "Descripción!del Artículo"
    Transdep_dt.cantidad              COLUMN-LABEL "Cantidad!Egresada"
    Unidad.abrevia                   COLUMN-LABEL "Un.!Med."
    Transdep_dt.granel                COLUMN-LABEL "A Granel!Egresado"
    Deposito.cdg_deposito            COLUMN-LABEL "Código de!Depósito"
    Deposito.nombre                  COLUMN-LABEL "Nombre!Depósito"
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 160 /* NO-LABELS.*/.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 160 NO-LABELS.
/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/


{SETIMPRE.I}


FIND Parametro "CLIOBSRC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSRC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Transdep_hd.leyenda:WIDTH = ccoobsdc.
Transdep_hd.leyenda:HEIGHT = cliobsdc.

FIND Transdep_hd WHERE ROWID(Transdep_hd) = act_remito EXCLUSIVE-LOCK.
FIND Deposito     OF Transdep_hd NO-LOCK NO-ERROR.
FIND Imputacion OF Transdep_hd NO-LOCK NO-ERROR.

{drsalida.i "55"} /* Direcciona la salida de impresión */

RUN PONE_CODIGO ( INPUT "CARTA,SET12CPI" ).

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Transdep_hd.tip_comprob
    Transdep_hd.nro_comprob
    Transdep_hd.fecha
    Deposito.nombre        WHEN AVAILABLE Deposito
    Deposito.cdg_Deposito          WHEN AVAILABLE Deposito
    Imputacion.dsc_imputacion  WHEN AVAILABLE Imputacion
    Imputacion.cdg_Imputacion  WHEN AVAILABLE Imputacion
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Transdep_dt OF Transdep_hd, 
        Articulo OF Transdep_dt, 
        Partida OF Transdep_dt, 
        Deposito OF Transdep_dt:

  FIND Unidad OF Articulo NO-LOCK.
  DISPLAY  Articulo.cdg_articulo
           Partida.cdg_partida
           Articulo.descripcion
           Unidad.abrevia
           Transdep_dt.cantidad
           Transdep_dt.granel
           Deposito.cdg_deposito
           Deposito.nombre
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
    Transdep_hd.leyenda
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.

RUN veresult.w ( INPUT  arch_salida ,  /* Archivo */
                 INPUT 9 ).            /* FONT a utilizar por default */               

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/


{CODIMPRE.I}
