/*=================================================================================*/
/*                           NOTA DE DEBITO B                                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE subtotal        AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE prfac           AS CHARACTER.
DEFINE VARIABLE titulo-detalle  AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE linea_texto     AS CHARACTER FORMAT "X(65)".
DEFINE VARIABLE renglones       AS CHARACTER FORMAT "X(65)".
DEFINE VARIABLE blancos         AS CHARACTER.
DEFINE VARIABLE v-letra         AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-comprobante   AS CHARACTER FORMAT "X(18)" INITIAL "CREDITO INTERNO".
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
DEFINE VARIABLE v-bruto         LIKE Opg_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-desc          LIKE Opg_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-neto          LIKE Opg_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prciva          LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prcnoi          LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_iva     LIKE Opg_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi     LIKE Opg_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE x-imp_neto      LIKE Opg_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE codigo_iva      AS INTEGER INITIAL 2.

{VRSHARED.I}
{VPERSINM.I}

FORM
    SKIP(3)
    v-letra AT 41
    Opg_header.prf_comprob FORMAT "9999" AT 56
    Opg_header.nro_comprob FORMAT "99999999"
    SKIP(1)
    v-comprobante          AT 56
    SKIP(1)
    Opg_header.fecha       AT 56
    WITH FRAME frm-comprobante NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM
    SKIP(8)
    Proveedor.cdg_Proveedor    AT 12
    Opg_header.nombre      AT 21   
    SKIP(1)
    Domicilio_prv.direccion   AT 21
    Domicilio_prv.cdg_postal  AT 21 FORMAT "X(4)"
    Domicilio_prv.localidad
    SKIP
/*    Provincia.nombre       AT 21*/
    SKIP
    Condicion_impos.texto  AT 12
    Opg_header.cuit        AT 54 FORMAT "X(15)"
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
    Opg_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    SKIP(3)
    "Bruto" AT 18
    "Descuento" AT 36
    "Neto" AT 53
    prciva AT 65
    "%"
    prcnoi AT 85
    "%"
    "Total a Pagar" AT 119
    SKIP(1)
    
    x-imp_neto AT 18
    v-desc AT 33
    Opg_header.imp_neto  AT 53
    importe_iva AT 75
    Opg_header.imp_total AT 122 FORMAT "Z,ZZZ,ZZ9.99-"

    SKIP(3)
/*    "C.A.I.No. 99870041667004    Fecha Vto.: 22/11/2000" AT 9*/
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM

    linea_texto AT 8
/*
    Cta_cte.tip_comprob AT 71 FORMAT "X(2)"
    Cta_cte.prf_comprob AT 84 FORMAT "9999"
    Cta_cte.nro_comprob AT 95 FORMAT "99999999" 
    Cta_cte.nro_vencimiento AT 105
    Opg_detalle.importe AT 122
*/    
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

FIND Parametro "CLIOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Opg_header.leyenda:WIDTH = ccoobsdc.
Opg_header.leyenda:HEIGHT = cliobsdc.

FIND Opg_header WHERE ROWID(Opg_header) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Opg_header NO-LOCK.
FIND Condicion_venta OF Opg_header NO-LOCK.
FIND Proveedor OF Opg_header NO-LOCK NO-ERROR.
FIND Domicilio_prv OF Proveedor NO-LOCK.
FIND Provincia OF Proveedor NO-LOCK.


FIND Impuesto WHERE Impuesto.cdg_impuesto = codigo_iva NO-LOCK.
prciva = Impuesto.tasa.

FIND Impuesto 2 NO-LOCK.
prcnoi = Impuesto.tasa.

v-desc  = Opg_header.imp_bruto - Opg_header.imp_neto.
v-bruto = Opg_header.imp_bruto.
v-neto  = Opg_header.imp_neto.

v-letra = SUBSTRING(Opg_header.tip_comprob,2,1). 


SUBSTRING(titulo-detalle,76,8) = "Tipo Comprob.".
SUBSTRING(titulo-detalle,87,5) = "Pref. Comprob.".
SUBSTRING(titulo-detalle,95,6) = "Nro Comprob.".
SUBSTRING(titulo-detalle,106,6) = "Vencimiento". 
SUBSTRING(titulo-detalle,126,8) = "Descuento". 

OUTPUT TO PRINTER PAGE-SIZE 72.

PUT CONTROL CHR(18).
PUT CONTROL "~033CH".

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    v-letra 
    v-comprobante
    Opg_header.prf_comprob
    Opg_header.nro_comprob
    Opg_header.fecha
    WITH FRAME frm-comprobante.

DISPLAY
    Opg_header.nombre
    Proveedor.cdg_Proveedor    WHEN AVAILABLE Proveedor
    Domicilio_prv.direccion  
    Domicilio_prv.cdg_postal 
    Domicilio_prv.localidad
/*    Provincia.nombre*/
    Condicion_impos.texto
    Opg_header.cuit
    Condicion_venta.descripcion
    WITH FRAME frm-encabezado.


/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

RUN RENGLONS.P ( INPUT  Opg_header.leyenda,
                 INPUT  65,
                 OUTPUT renglones,
                 INPUT  "@").

DO nreng = 1 TO NUM-ENTRIES(renglones,"@"):
   linea_texto = ENTRY(nreng,renglones,"@").
   DISPLAY linea_texto WITH FRAME frm-detalle.
   DOWN WITH FRAME frm-detalle.
END.


linea0 = LINE-COUNTER.
DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

PUT CONTROL CHR(15).

DISPLAY
 
    Opg_header.imp_total @ x-imp_neto
    Opg_header.imp_total @ Opg_header.imp_neto
    Opg_header.imp_total
    
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.

