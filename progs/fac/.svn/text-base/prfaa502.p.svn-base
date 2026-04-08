/*=================================================================================*/
/*               IMPRESION DE FACTURAS DE TIPO A                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE subtotal        AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE v-bonifs        AS CHARACTER FORMAT "X(21)" .
DEFINE VARIABLE titulo-detalle  AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE blancos         AS CHARACTER.
DEFINE VARIABLE v-letra         AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-comprobante   AS CHARACTER FORMAT "X(12)" INITIAL "FACTURA".
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
    SKIP
    Fac_header.direccion   AT 21
    Fac_header.cdg_postal  AT 16 FORMAT "X(4)"
    Fac_header.localidad
    SKIP
    Provincia.nombre       AT 21
    Domicilio.nombre       AT 54

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
    "O/Compra" AT 9 
    "Nro. Pedido" AT 19 
    "Remito Nro." AT 34
    "Condic. de Venta" AT 48
    "Vencimiento" AT 70
    SKIP(1)
    Fac_header.nro_ocm  AT 9
    Ped_header.tip_comprob AT 19 FORMAT "X(2)"
    Ped_header.nro_comprob FORMAT ">>>>9"
    Rem_header.prf_comprob AT 34 FORMAT "9999"
    Rem_header.nro_comprob FORMAT "99999999" 
    Condicion_venta.descripcion  AT 48 FORMAT "X(22)"
    Cta_cte.fecha_vencimiento AT 71
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    Fac_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    SKIP
    "Bruto" AT 18
    "Descuento" AT 36
    "Neto" AT 53
    prciva AT 65
    "%"
    prcnoi AT 85
    "%"
    "Total a Pagar" AT 119
    SKIP(1)
    Fac_header.imp_bruto AT 18
    v-desc AT 33
    Fac_header.imp_neto  AT 53
    importe_iva AT 65
    importe_noi AT 85
    Fac_header.imp_total AT 122 FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP(2)
    "C.A.I.No. 99870041667004    Fecha Vto.: 22/11/2000" AT 9
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM
    Articulo.cdg_articulo AT 9 FORMAT "X(6)" 
    Articulo.descripcion /*AT 22*/
    Fac_detalle.cantidad /*AT 71*/ FORMAT "->>,>>9.99"
    Fac_detalle.granel /*AT 84*/ FORMAT "->>,>>9.999"
    Unidad.abrevia /*AT 95*/ FORMAT "X(5)"
    Fac_detalle.precio /*AT 92*/ 
    v-bonifs
    Fac_detalle.subtotal_bruto /*AT 122*/ FORMAT "Z,ZZZ,ZZ9.99-"
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

Fac_header.leyenda:WIDTH = ccoobsdc.
Fac_header.leyenda:HEIGHT = cliobsdc.

FIND Fac_header WHERE ROWID(Fac_header) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Fac_header NO-LOCK.
FIND Condicion_venta OF Fac_header NO-LOCK.
FIND Provincia OF Fac_header NO-LOCK.
FIND Cliente   OF Fac_header NO-LOCK NO-ERROR.
FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.
FIND Domicilio OF Fac_header NO-LOCK NO-ERROR.

FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
IF AVAILABLE Rem_header 
   THEN FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.

FIND Impuesto 1 NO-LOCK.
prciva = Impuesto.tasa.
FIND FIRST Sub_detalle_vta OF Fac_header WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta.
importe_iva = Sub_detalle_vta.valor.

FIND Impuesto 2 NO-LOCK.
prcnoi = Impuesto.tasa.
FIND FIRST Sub_detalle_vta OF Fac_header WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta NO-ERROR.
IF AVAILABLE Sub_detalle_vta 
    THEN importe_noi = Sub_detalle_vta.valor.
    ELSE importe_noi = 0.


FIND FIRST Cta_cte 
     WHERE Cta_cte.tip_comprob = Fac_header.tip_comprob 
       AND Cta_cte.prf_comprob = Fac_header.prf_comprob
       AND Cta_cte.nro_comprob = Fac_header.nro_comprob
           NO-ERROR.
       
v-desc  = Fac_header.imp_bruto - Fac_header.imp_neto.
v-bruto = Fac_header.imp_bruto.
v-neto  = Fac_header.imp_neto.

v-letra = SUBSTRING(Fac_header.tip_comprob,2,1). 

SUBSTRING(titulo-detalle,9,8)   = "Articulo". 
SUBSTRING(titulo-detalle,22,10) = "Descripcion".
SUBSTRING(titulo-detalle,59,8)  = "Cantidad".
SUBSTRING(titulo-detalle,73,5)  = "Kilaje".
SUBSTRING(titulo-detalle,80,6)  = "Unidad".
SUBSTRING(titulo-detalle,92,6)  = "Precio". 
SUBSTRING(titulo-detalle,102,6) = "Bonificaciones". 
SUBSTRING(titulo-detalle,126,8) = "Subtotal". 

OUTPUT TO VALUE(dire_tmp + "PRFAA501.TXT") PAGE-SIZE 72.

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
    Domicilio.nombre
    Vendedor.cdg_vendedor
    Vendedor.nombre
    Ped_header.tip_comprob WHEN AVAILABLE Ped_header
    Ped_header.nro_comprob WHEN AVAILABLE Ped_header
    Rem_header.prf_comprob WHEN AVAILABLE Rem_header
    Rem_header.nro_comprob WHEN AVAILABLE Rem_header
    Condicion_impos.texto
    Fac_header.cuit
    Condicion_venta.descripcion
    Cta_cte.fecha_vencimiento WHEN AVAILABLE Cta_cte
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

  v-bonifs = "  ".
  FOR EACH Fac_detalle-bon OF Fac_detalle NO-LOCK:
      v-bonifs = v-bonifs + STRING(Fac_detalle-bon.porcentaje,"ZZ9.99") + " ".
  END.    

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
        que_precio   = STRING(Fac_detalle.precio, "ZZZZZZ9.99").
        que_subtotal = ( IF Fac_detalle.cantidad = 0 THEN STRING(Fac_detalle.precio, "ZZZZZZ9.99")
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
            v-bonifs
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
    Fac_header.imp_bruto
    v-desc
    Fac_header.imp_neto
    prciva
    prcnoi
    importe_iva
    importe_noi
    Fac_header.imp_total
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.

/*DOS SILENT VALUE("COPY " + dire_tmp + "PRFAA501.TXT" + "  lpt1") view-as alert-box message.*/.
OS-COPY VALUE(dire_tmp + STRING(Rem_header.nro_comprob,"99999999") + ".rem") 
        VALUE("c:\remoto\swift\" + STRING(Fac_header.nro_comprob,"99999999") + ".fac").
OS-APPEND VALUE(dire_tmp + "PRFAA501.TXT") 
          VALUE("c:\remoto\swift\" + STRING(Fac_header.nro_comprob,"99999999") + ".fac").

