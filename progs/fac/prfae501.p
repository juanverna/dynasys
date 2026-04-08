/*=================================================================================*/
/*               IMPRESION DE FACTURAS DE TIPO B                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/


DEFINE VARIABLE subtotal        AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE prfac           AS CHARACTER.
DEFINE VARIABLE titulo-detalle  AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE blancos         AS CHARACTER.
DEFINE VARIABLE v-letra         AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-comprobante   AS CHARACTER FORMAT "X(22)" INITIAL "FACTURA DE EXPORTACION".
DEFINE VARIABLE que_articulo    AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE que_descripcion AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_cantidad    AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE que_unidad      AS CHARACTER FORMAT "X(5)".
DEFINE VARIABLE que_precio      AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE que_subtotal    AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE nreng           AS INTEGER.
DEFINE VARIABLE j               AS INTEGER.
DEFINE VARIABLE nt_lineas       AS INTEGER.
DEFINE VARIABLE total_chars     AS INTEGER.
DEFINE VARIABLE ancho_linea     AS INTEGER INITIAL 40.
DEFINE VARIABLE nmax_det        AS INTEGER INITIAL 18.
DEFINE VARIABLE linea0          AS INTEGER.
DEFINE VARIABLE cliobsdc        AS INTEGER.
DEFINE VARIABLE ccoobsdc        AS INTEGER.

DEFINE VARIABLE v-bruto         LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-desc          LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-neto          LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prciva          LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prcnoi          LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_iva     LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi     LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE x-imp_total     LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE y-imp_total     LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

{VRSHARED.I}
{VPERSINM.I}

FORM
    SKIP(1)
    v-letra AT 41
    Fac_header.prf_comprob FORMAT "9999" AT 56
    Fac_header.nro_comprob FORMAT "99999999"
    SKIP(1)
    v-comprobante          AT 56
    SKIP(1)
    Fac_header.fecha       AT 56
    WITH FRAME frm-comprobante NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM
    SKIP(8)
    Cliente.cdg_cliente    AT 12
    Fac_header.nombre      AT 21   
    SKIP(1)
    Fac_header.direccion   AT 21
    SKIP
    Fac_header.cdg_postal  AT 21 FORMAT  "X(4)"
    Fac_header.localidad
    Provincia.nombre
    "Representante:"       AT 12
    Vendedor.cdg_vendedor  FORMAT "999"
    Vendedor.nombre
    SKIP
    Condicion_impos.texto  AT 12
    Fac_header.cuit        AT 54 FORMAT "X(15)"
    SKIP(1)
    "Ingresos Brutos Nro.: " AT 12
    "Convenio Multilateral:" AT 53
    SKIP(1)
    "Pedido" AT 9 
    "Remito Nro." AT 24
    "Condic. de Venta" AT 43
    "Vencimiento" AT 67
    SKIP(1)
    Ped_header.tip_comprob AT 9 FORMAT "X(2)"
    Ped_header.nro_comprob FORMAT ">>>>9"
    Rem_header.prf_comprob AT 24 FORMAT "9999"
    Rem_header.nro_comprob FORMAT "99999999" 
    Condicion_venta.descripcion  AT 41
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    Fac_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    SKIP
    "Bruto" AT 18
    "Descuento" AT 33
    "Neto" AT 53
    "Total a Pagar" AT 119
    SKIP(1)
    x-imp_total AT 18
    v-desc AT 33
    y-imp_total AT 53 FORMAT "Z,ZZZ,ZZ9.99-"
    Fac_header.imp_total AT 122 FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP(2)
    "C.A.I.No. 98870148174017    Fecha Vto.: 10/12/2000" AT 9
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM
    Articulo.cdg_articulo AT 9 
    Articulo.descripcion AT 22
    Fac_detalle.cantidad AT 71
    Fac_detalle.granel AT 84
    Unidad.abrevia AT 95
    Fac_detalle.precio AT 102 
    Fac_detalle.subtotal_bruto AT 122 FORMAT "Z,ZZZ,ZZ9.99-"
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 160 NO-UNDERLINE NO-LABELS. 

FORM
    titulo-detalle
    SKIP(1)
    WITH FRAME frm-titdetalle USE-TEXT STREAM-IO DOWN WIDTH 160 NO-UNDERLINE NO-LABELS. 
    
FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 131 NO-LABELS.
/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

{SETIMPRE.I}

FIND Parametro "CLIOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Fac_header.leyenda:WIDTH = ccoobsdc.
Fac_header.leyenda:HEIGHT = cliobsdc.

FIND Fac_header WHERE ROWID(Fac_header) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Fac_header NO-LOCK.
FIND Condicion_venta OF Fac_header NO-LOCK.
FIND Provincia OF Fac_header NO-LOCK.
FIND Cliente   OF Fac_header NO-LOCK NO-ERROR.
FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.

FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
IF AVAILABLE Rem_header 
   THEN FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.

v-bruto = Fac_header.imp_neto.
v-neto  = Fac_header.imp_neto.

v-desc  = /* Fac_header.imp_bruto - Fac_header.imp_total. */ 0.

v-letra = SUBSTRING(Fac_header.tip_comprob,2,1). 

x-imp_total = Fac_header.imp_total.
y-imp_total = Fac_header.imp_total.

SUBSTRING(titulo-detalle,9,8) = "Articulo". 
SUBSTRING(titulo-detalle,22,10) = "Descripcion".
SUBSTRING(titulo-detalle,76,8) = "Cantidad".
SUBSTRING(titulo-detalle,87,5) = "Kilaje".
SUBSTRING(titulo-detalle,95,6) = "Unidad".
SUBSTRING(titulo-detalle,106,6) = "Precio". 
SUBSTRING(titulo-detalle,126,8) = "Subtotal". 

OUTPUT TO PRINTER PAGE-SIZE 72.

PUT CONTROL CHR(18).
PUT CONTROL "~033CH".

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    v-letra 
    v-comprobante
    Fac_header.prf_comprob
    Fac_header.nro_comprob
    Fac_header.fecha
    WITH FRAME frm-comprobante.

DISPLAY
    Fac_header.nombre
    Cliente.cdg_cliente    WHEN AVAILABLE Cliente
    Fac_header.direccion
    Fac_header.nro_ocm
    Fac_header.cdg_postal
    Fac_header.localidad
    Provincia.nombre
    Vendedor.cdg_vendedor
    Vendedor.nombre
    Ped_header.tip_comprob WHEN AVAILABLE Ped_header
    Ped_header.nro_comprob WHEN AVAILABLE Ped_header
    Rem_header.prf_comprob WHEN AVAILABLE Rem_header
    Rem_header.nro_comprob WHEN AVAILABLE Rem_header
    Condicion_impos.texto
    Fac_header.cuit
    Condicion_venta.descripcion
    WITH FRAME frm-encabezado.


/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

PUT CONTROL CHR(15).

DISPLAY
    titulo-detalle
    WITH FRAME frm-titdetalle.

linea0 = LINE-COUNTER.

FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle NO-LOCK,
                                    Unidad OF Articulo NO-LOCK:

  IF Articulo.extendida
  THEN DO:
     total_chars = LENGTH(Fac_detalle.detallada).
     nt_lineas =  TRUNC(total_chars / ancho_linea,0).
     IF nt_lineas * ancho_linea <> total_chars THEN nt_lineas = nt_lineas + 1.
     DO j = 1 to nt_lineas:

        que_articulo = ( IF j = 1 THEN STRING(Articulo.cdg_articulo,"ZZZZZZZ9")
                                  ELSE "").
        que_descripcion = SUBSTRING(Fac_detalle.detallada,( j - 1) * ancho_linea + 1 ,
                                                                     ancho_linea ).
        que_cantidad = STRING(Fac_detalle.cantidad, "ZZZZZZZ9").
        que_unidad   = Unidad.abrevia.
        que_precio   = STRING(Fac_detalle.precio_cf, "ZZZZZZ9.99").
        que_subtotal = ( IF Fac_detalle.cantidad = 0 THEN STRING(Fac_detalle.precio_cf, "ZZZZZZ9.99")
                                                     ELSE STRING(subtotal, "ZZZZZZ9.99")).
        /*
        DISPLAY  que_cantidad    WHEN Fac_detalle.cantidad <> 0  AND j = nt_lineas
                 que_descripcion
                 que_precio      WHEN Fac_detalle.cantidad <> 0  AND j = nt_lineas
                 que_subtotal    WHEN j = nt_lineas
                 WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
        DOWN WITH FRAME frm-detalle.
        */
     END.
  END.
  ELSE DO:
    DISPLAY
            Articulo.cdg_articulo
            Articulo.descripcion
            Fac_detalle.cantidad
            Fac_detalle.granel
            Unidad.abrevia
            Fac_detalle.precio
            Fac_detalle.subtotal_bruto
            WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
    DOWN WITH FRAME frm-detalle.
  END.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Fac_header.leyenda
    v-desc
    x-imp_total
    y-imp_total
    Fac_header.imp_total
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.


{CODIMPRE.I}
