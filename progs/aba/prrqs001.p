/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_requisicion      AS ROWID.

{VRSHARED.I}

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/


DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 20.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE condventa   AS CHARACTER FORMAT "X(35)".

DEFINE SHARED TEMP-TABLE T-Rqs_header LIKE Rqs_header.

FORM 
    T-Rqs_header.tip_comprob AT 57
    T-Rqs_header.nro_comprob 
    SKIP(2)
    T-Rqs_header.fecha       AT 57
    SKIP(2)
    Comprador.cdg_Comprador  AT 69
    SKIP(1)
    T-Rqs_header.cdg_estado  AT 15
    Estado_pedido.descripcion   NO-LABEL 
    SKIP(1)
    SPACE(5)
    "ARTICULO   DESCRIPCION                   CANT. UNIDAD GRANEL    ESTADO"
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 85.

FORM
    T-Rqs_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 85 NO-LABELS.
    
FORM 
    SPACE(6)
    Articulo.cdg_articulo 
    Articulo.descripcion FORMAT "X(30)"
    Rqs_detalle.cantidad FORMAT ">,>>>,>>9.99"
    Unidad.abrevia        
    Rqs_detalle.granel
    Rqs_detalle.cdg_estado
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 85 NO-LABELS.

FORM 
    blancos 
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 85 NO-LABELS.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

FIND Parametro "CLIOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

T-Rqs_header.leyenda:WIDTH = ccoobsdc.
T-Rqs_header.leyenda:HEIGHT = cliobsdc.

FIND FIRST T-Rqs_header EXCLUSIVE-LOCK.

FIND Comprador OF T-Rqs_header NO-LOCK NO-ERROR.
FIND Estado_pedido OF T-Rqs_header NO-LOCK NO-ERROR.

OUTPUT TO VALUE(dire_tmp + "prrqs000.txt") PAGE-SIZE 72.

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY 
    T-Rqs_header.tip_comprob
    T-Rqs_header.nro_comprob
    T-Rqs_header.fecha     
    T-Rqs_header.cdg_estado    WHEN AVAILABLE Estado_pedido
    Estado_pedido.descripcion  WHEN AVAILABLE Estado_pedido
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Rqs_detalle OF T-Rqs_header, Articulo OF Rqs_detalle NO-LOCK, Unidad OF Articulo NO-LOCK:
   
  DISPLAY  Articulo.cdg_articulo 
           Articulo.descripcion 
           Unidad.abrevia
           Rqs_detalle.cantidad 
           Rqs_detalle.granel WHEN Articulo.a_granel
           Rqs_detalle.cdg_estado
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
    T-Rqs_header.leyenda
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/
    
OUTPUT CLOSE.

RUN PRINFILE.P ( INPUT dire_tmp + "prrqs000.txt", INPUT port).
