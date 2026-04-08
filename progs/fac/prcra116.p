/*=================================================================================*/
/*               IMPRESION DE FACTURAS DE TIPO A                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE subtotal        AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE v-bonifs        AS CHARACTER FORMAT "X(21)" .
DEFINE VARIABLE v-descuentos    AS CHARACTER FORMAT "X(21)" .
DEFINE VARIABLE titulo-detalle  AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE blancos         AS CHARACTER.
DEFINE VARIABLE v-letra         AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-comprobante   AS CHARACTER FORMAT "X(16)" INITIAL "NOTA DE CREDITO".
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
DEFINE VARIABLE nmax_det        AS INTEGER INITIAL 17.
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

DEFINE VARIABLE v-cantidad      LIKE Fac_detalle.cantidad.
DEFINE VARIABLE v-subtotal      LIKE Fac_detalle.subtotal_neto.

{VRSHARED.I}
{VPERSINM.I}

FORM
    Fac_header.fecha       AT 68
    SKIP(1)
    v-comprobante          AT 68
    SKIP(2)
    Fac_header.nombre      AT 12   
    Cliente.cdg_cliente    AT 54
    "(" Vendedor.cdg_vendedor ")"
    SKIP
    Fac_header.direccion   AT 12 FORMAT "X(30)"
    Fac_header.localidad   AT 54
    SKIP
    Provincia.nombre       AT 12
    Fac_header.cdg_postal  AT 54 FORMAT "X(12)"
    SKIP(1)
    Condicion_impos.texto  AT 12
    Fac_header.cuit        AT 54 FORMAT "X(15)"
    SKIP
    Condicion_venta.descripcion  AT 16 FORMAT "X(15)"
    Cta_cte.fecha_vencimiento
    Fac_header.nro_ocm  
    Ped_header.tip_comprob FORMAT "X(2)"
    Ped_header.nro_comprob FORMAT ">>>>9"
    Rem_header.prf_comprob FORMAT "9999" AT 66
    Rem_header.nro_comprob FORMAT "99999999" 
    SKIP(2)
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
/*    Fac_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7*/
    SKIP

    Fac_header.imp_bruto AT 120 FORMAT "Z,ZZZ,ZZ9.99-"

    "IMPORTANTE=========================================" AT 7
    v-descuentos AT 90 
    v-desc AT 120 FORMAT "Z,ZZZ,ZZ9.99-"

    "Este importe equivale a dolares estadounidenses" AT 7
    Fac_header.imp_neto  AT 120 FORMAT "Z,ZZZ,ZZ9.99-"

    "y se cancelara el dia de su efectivo pago." AT 7
    prciva AT 98
    importe_iva AT 120 FORMAT "Z,ZZZ,ZZ9.99-"

    "Los cheques el dia de su acreditacion" AT 7
    prcnoi AT 98
    importe_noi AT 120 FORMAT "Z,ZZZ,ZZ9.99-"

    SKIP(1)

    Fac_header.imp_total AT 120 FORMAT "Z,ZZZ,ZZ9.99-"

    SKIP(2)
    Fac_header.prf_comprob FORMAT "9999" 
    Fac_header.nro_comprob FORMAT "99999999"
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM
    Fac_detalle.cantidad AT 7 FORMAT "->>,>>9"
    Articulo.cdg_articulo AT 19 FORMAT "X(6)" 
    Articulo.descripcion
    v-bonifs  AT 72
    Fac_detalle.precio  AT 99
    Fac_detalle.subtotal_bruto AT 120 FORMAT "Z,ZZZ,ZZ9.99-"
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
/*
Fac_header.leyenda:WIDTH = ccoobsdc.
Fac_header.leyenda:HEIGHT = cliobsdc.
*/
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
FIND FIRST Sub_detalle_vta OF Fac_header 
     WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta NO-LOCK NO-ERROR.
IF AVAILABLE Sub_detalle_vta 
    THEN importe_iva = Sub_detalle_vta.valor.
    ELSE importe_iva = 0.

FIND Impuesto 2 NO-LOCK.
prcnoi = Impuesto.tasa.
FIND FIRST Sub_detalle_vta OF Fac_header 
     WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta 
           NO-LOCK NO-ERROR.
IF AVAILABLE Sub_detalle_vta 
    THEN importe_noi = Sub_detalle_vta.valor.
    ELSE importe_noi = 0.

FIND FIRST Cta_cte 
     WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa 
       AND Cta_cte.tip_comprob = Fac_header.tip_comprob 
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

Fac_header.impreso = "S".

OUTPUT TO VALUE(dire_tmp + "prcra116.txt") PAGE-SIZE 72.

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Fac_header.fecha
    v-comprobante
    Fac_header.nombre
    Cliente.cdg_cliente    WHEN AVAILABLE Cliente
    Fac_header.direccion
    Fac_header.nro_ocm
    Fac_header.cdg_postal
    Fac_header.localidad
    Provincia.nombre
    Vendedor.cdg_vendedor
/*    Ped_header.tip_comprob WHEN AVAILABLE Ped_header
    Ped_header.nro_comprob WHEN AVAILABLE Ped_header*/
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
/*
DISPLAY
    titulo-detalle
    WITH FRAME frm-titdetalle.
*/
linea0 = LINE-COUNTER.

v-descuentos = "Descuento  ".
FOR EACH Fac_header-bon OF Fac_header NO-LOCK:
    v-descuentos = v-descuentos + STRING(Fac_header-bon.porcentaje,"ZZ9.99") + " ".
END.    

FOR EACH Fac_detalle OF Fac_header 
         WHERE Fac_detalle.cantidad <> 0 OR Fac_detalle.granel <> 0,
               Articulo OF Fac_detalle 
               BREAK BY Articulo.cdg_articulo 
                     BY Fac_detalle.precio DESCENDING:

    v-cantidad = v-cantidad + Fac_detalle.cantidad.
    v-subtotal = v-subtotal + Fac_detalle.subtotal_neto.

    IF LAST-OF(Fac_detalle.precio)
    THEN DO:

        v-bonifs = "  ".
        FOR EACH Fac_detalle-bon OF Fac_detalle NO-LOCK:
            v-bonifs = v-bonifs + STRING(Fac_detalle-bon.porcentaje,"ZZ9.99") + " ".
        END.    

        DISPLAY
                Articulo.cdg_articulo
                Articulo.descripcion
                v-cantidad @ Fac_detalle.cantidad
    /*          Fac_detalle.granel
                Unidad.abrevia */
                Fac_detalle.precio
                v-bonifs
                v-subtotal @ Fac_detalle.subtotal_bruto
                WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
        DOWN WITH FRAME frm-detalle.
        
        ASSIGN
            v-cantidad = 0
            v-subtotal = 0.
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
/*    Fac_header.leyenda*/
    Fac_header.imp_bruto
    v-descuentos
    v-desc
    Fac_header.imp_neto
    prciva
    prcnoi
    importe_iva
    importe_noi
    Fac_header.imp_total
    Fac_header.prf_comprob
    Fac_header.nro_comprob
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.

   DEFINE VARIABLE p_printed   AS LOGICAL.

   RUN _osprint.p ( INPUT  CURRENT-WINDOW:HANDLE, /* HANDLE de la WINDOW    */
                    INPUT  dire_tmp + "prcra116.txt",           /* Archivo a imprimir     */
                    INPUT  2,                     /* FONT a utilizar        */
                    INPUT  2,                     /* Print Flags 2=Apaisado */
                    INPUT  72,                    /* Lineas por Pagina      */
                    INPUT  0,                     /* 0= Todo, <>0 seleccion */
                    OUTPUT p_Printed ).           /* Se imprimió o no       */


