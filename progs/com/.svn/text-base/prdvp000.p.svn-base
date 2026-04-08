/*=================================================================================*/
/*                  IMPRIME UN REMITO DE PROVEEDOR                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_remito      AS ROWID.

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

DEFINE SHARED TEMP-TABLE T-Rem_header_prv LIKE Rem_header_prv.

FORM 
    T-Rem_header_prv.tip_comprob AT 57
    T-Rem_header_prv.prf_comprob 
    T-Rem_header_prv.nro_comprob 
    SKIP(2)
    T-Rem_header_prv.fecha       AT 57
    SKIP(2)
    Proveedor.nombre      AT 15
    SKIP
    Proveedor.cdg_proveedor    AT 57
    Comprador.cdg_comprador  AT 69
    SKIP(2)
    SPACE(5)
    "ARTICULO   DESCRIPCION                   CANT. UNIDAD GRANEL    ESTADO"
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 85.

FORM
    T-Rem_header_prv.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 85 NO-LABELS.
    
FORM 
    SPACE(6)
    Articulo.cdg_articulo 
    Articulo.descripcion FORMAT "X(30)"
    Rem_detalle_prv.cantidad FORMAT ">,>>>,>>9.99"
    Unidad.abrevia        
    Rem_detalle_prv.cantidad
    Rem_detalle_prv.cdg_estado
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

T-Rem_header_prv.leyenda:WIDTH = ccoobsdc.
T-Rem_header_prv.leyenda:HEIGHT = cliobsdc.

FIND FIRST T-Rem_header_prv EXCLUSIVE-LOCK.
FIND Proveedor   OF T-Rem_header_prv NO-LOCK NO-ERROR.
FIND Comprador OF T-Rem_header_prv NO-LOCK NO-ERROR.

OUTPUT TO VALUE(dire_tmp + "prdvp000.txt") PAGE-SIZE 72.

/*=================================================================================*/
/*                                    ENCABEZADO                                   */
/*=================================================================================*/

DISPLAY 
    T-Rem_header_prv.tip_comprob
    T-Rem_header_prv.prf_comprob 
    T-Rem_header_prv.nro_comprob 
    T-Rem_header_prv.fecha
    Proveedor.nombre
    Proveedor.cdg_proveedor
    Comprador.cdg_comprador
    WITH FRAME frm-encabezado.

/*=================================================================================*/
/*                                      DETALLE                                    */
/*=================================================================================*/

linea0 = LINE-COUNTER.

FOR EACH Rem_detalle_prv OF T-Rem_header_prv, Articulo OF Rem_detalle_prv NO-LOCK, Unidad OF Articulo NO-LOCK:
   
  DISPLAY  Articulo.cdg_articulo 
           Articulo.descripcion 
           Unidad.abrevia
           Rem_detalle_prv.cantidad 
           Rem_detalle_prv.granel WHEN Articulo.a_granel
           Rem_detalle_prv.cdg_estado
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
  DOWN WITH FRAME frm-detalle.         

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.   

/*=================================================================================*/
/*                                       PIE                                       */
/*=================================================================================*/

DISPLAY 
    T-Rem_header_prv.leyenda
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/
    
OUTPUT CLOSE.

RUN PRINFILE.P ( INPUT dire_tmp + "prdpv000.txt", INPUT port).
