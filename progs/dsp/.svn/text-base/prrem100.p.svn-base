/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_remito      AS ROWID.

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


FORM 
    SKIP(4)
    Rem_header.tip_comprob NO-LABEL AT 15
    Rem_header.nro_comprob NO-LABEL 
    Rem_header.fecha       AT 57
    SKIP(5)
    Rem_header.nombre      AT 15
    SKIP
    Cliente.cdg_cliente    AT 57
    Vendedor.cdg_vendedor  AT 69
    SKIP(2)
    Rem_header.direccion   AT 15 FORMAT "X(40)"
    Rem_header.nro_ocm     AT 57
    Rem_header.cdg_postal  AT 15
    Rem_header.localidad   
    SKIP
    Provincia.nombre       AT 15
    SKIP(1)
    Condicion_impos.texto          AT 15
    Rem_header.cuit        AT 49
    SKIP(1)
    Condventa              AT 27
    SKIP(1)
    SPACE(5)
    "ARTICULO DESCRIPCION                  CANTIDAD UNIDAD"
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 85.

FORM
    Rem_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 85 NO-LABELS.
    
FORM 
    SPACE(6)
    Articulo.cdg_articulo 
    Articulo.descripcion FORMAT "X(30)"
    Rem_detalle.cantidad FORMAT ">>>"
    SPACE(4)
    Unidad.abrevia        
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

Rem_header.leyenda:WIDTH = ccoobsdc.
Rem_header.leyenda:HEIGHT = cliobsdc.

FIND Rem_header WHERE ROWID(Rem_header) = act_remito EXCLUSIVE-LOCK.
FIND Condicion_impos OF Rem_header NO-LOCK.
FIND Condicion_venta OF Rem_header NO-LOCK.
/*FIND Provincia OF Rem_header NO-LOCK.*/
FIND Cliente   OF Rem_header NO-LOCK NO-ERROR.
FIND Vendedor OF Rem_header NO-LOCK NO-ERROR.

IF Rem_header.sin_cargo = YES 
 THEN Condventa = "SIN CARGO".
 ELSE Condventa = Condicion_venta.descripcion.

OUTPUT TO PRINTER PAGE-SIZE 72.

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY 
    Rem_header.tip_comprob
    Rem_header.nro_comprob
    Rem_header.fecha     
    Rem_header.nombre   
    Cliente.cdg_cliente     WHEN AVAILABLE Cliente
    Vendedor.cdg_vendedor   WHEN AVAILABLE Vendedor
    Rem_header.direccion   
    Rem_header.cdg_postal  
    Rem_header.localidad   
    Rem_header.nro_ocm     
/*    Provincia.nombre    */
    Condicion_impos.texto       
    Rem_header.cuit     
    Condventa
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Rem_detalle OF Rem_header, Articulo OF Rem_detalle, Unidad OF Articulo:
   
  DISPLAY  Articulo.cdg_articulo 
           Articulo.descripcion 
           Unidad.abrevia
           Rem_detalle.cantidad 
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
