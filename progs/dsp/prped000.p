/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_remito      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{vrshared.i "new}

DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 20.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE condventa   AS CHARACTER FORMAT "X(35)".


FORM 
    Ped_header.tip_comprob AT 57
    Ped_header.nro_comprob 
    SKIP(2)
    Ped_header.fecha       AT 57
    SKIP(2)
    Cliente.nom_cliente      AT 15
    SKIP
    Cliente.cdg_cliente    AT 57
    Vendedor.cdg_vendedor  AT 69
    SKIP(2)
    Cliente.direccion   AT 15 FORMAT "X(40)"
    Ped_header.nro_ocm     AT 57
    Cliente.cdg_postal  AT 15
    Cliente.localidad   
    SKIP
    Provincia.nombre       AT 15
    SKIP(1)
    Condicion_impos.texto          AT 15
    Cliente.cuit        AT 49
    SKIP(1)
    Condventa              AT 27
    SKIP(1)
    Ped_header.cdg_estado  AT 15
    Estado_pedido.descripcion   NO-LABEL 
    SKIP(1)
    SPACE(5)
    "ARTICULO   DESCRIPCION                   CANT. UNIDAD GRANEL    ESTADO"
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 85.

FORM
    Ped_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    WITH FRAME frm-pie USE-TEXT STREAM-IO WIDTH 85 NO-LABELS.
    
FORM 
    SPACE(6)
    Articulo.cdg_articulo 
    Articulo.descripcion FORMAT "X(30)"
    Ped_detalle.cantidad FORMAT "ZZZ"
    SPACE(4)
    Unidad.abrevia        
    Ped_detalle.granel
    Ped_detalle.cdg_estado
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 85 NO-LABELS.

FORM 
    blancos 
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 85 NO-LABELS.
/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

RUN getparametro.p (  INPUT  "CLIOBSFC",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
cliobsdc = v-valor_n.

RUN getparametro.p (  INPUT  "CCOOBSFC",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
ccoobsdc = v-valor_n.

Ped_header.leyenda:WIDTH = ccoobsdc.
Ped_header.leyenda:HEIGHT = cliobsdc.

FIND Ped_header WHERE ROWID(Ped_header) = act_remito EXCLUSIVE-LOCK.
FIND Condicion_venta OF Ped_header NO-LOCK.

FIND Cliente   OF Ped_header NO-LOCK NO-ERROR.
FIND Condicion_impos OF Cliente NO-LOCK.
/*FIND Provincia OF Cliente NO-LOCK.*/

FIND Vendedor OF Ped_header NO-LOCK NO-ERROR.
FIND Estado_pedido OF Ped_header NO-LOCK.

IF Ped_header.sin_cargo = YES 
 THEN Condventa = "SIN CARGO".
 ELSE Condventa = Condicion_venta.descripcion.

OUTPUT TO "P.TXT" PAGE-SIZE 72.


/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY 
    Ped_header.tip_comprob
    Ped_header.nro_comprob
    Ped_header.fecha     
    Cliente.nom_cliente   
    Cliente.cdg_cliente     WHEN AVAILABLE Cliente
    Vendedor.cdg_vendedor   WHEN AVAILABLE Vendedor
    Cliente.direccion   
    Cliente.cdg_postal  
    Cliente.localidad   
    Ped_header.nro_ocm     
/*    Provincia.nombre    */
    Condicion_impos.texto       
    Cliente.cuit     
    Condventa
    Ped_header.cdg_estado 
    Estado_pedido.descripcion
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Ped_detalle OF Ped_header, Articulo OF Ped_detalle NO-LOCK, Unidad OF Articulo NO-LOCK:
   
  DISPLAY  Articulo.cdg_articulo 
           Articulo.descripcion 
           Unidad.abrevia
           Ped_detalle.cantidad 
           Ped_detalle.granel WHEN Articulo.a_granel
           Ped_detalle.cdg_estado
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
    Ped_header.leyenda
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/
    
OUTPUT CLOSE.
