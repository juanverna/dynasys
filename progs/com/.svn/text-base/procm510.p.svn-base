/*=================================================================================*/
/*               IMPRESION DE FACTURAS DE TIPO A                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

/*DEFINE SHARED TEMP-TABLE Ocm_header LIKE Ocm_header.*/

DEFINE VARIABLE subtotal        AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE v-total         LIKE Ocm_header.imp_total.
DEFINE VARIABLE v-bonifs        AS CHARACTER FORMAT "X(21)" .
DEFINE VARIABLE titulo-detalle  AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE blancos         AS CHARACTER.
DEFINE VARIABLE v-letra         AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-comprobante   AS CHARACTER FORMAT "X(15)" INITIAL "ORDEN DE COMPRA".
DEFINE VARIABLE que_articulo    AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE que_descripcion AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_cantidad    AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE que_unidad      AS CHARACTER FORMAT "X(5)".
DEFINE VARIABLE que_precio      AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE que_subtotal    AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE que_granel      AS CHARACTER FORMAT "X(9)".
DEFINE VARIABLE que_fecha       AS CHARACTER FORMAT "X(10)".
DEFINE VARIABLE dire_tmp        AS CHARACTER.
DEFINE VARIABLE nreng           AS INTEGER.
DEFINE VARIABLE j               AS INTEGER.
DEFINE VARIABLE nt_lineas       AS INTEGER.
DEFINE VARIABLE total_chars     AS INTEGER.
DEFINE VARIABLE ancho_linea     AS INTEGER INITIAL 40.
DEFINE VARIABLE nmax_det        AS INTEGER INITIAL 18.
DEFINE VARIABLE linea0          AS INTEGER.
DEFINE VARIABLE cliobsdc        AS INTEGER.
DEFINE VARIABLE ccoobsdc        AS INTEGER.
/*
DEFINE VARIABLE v-desc          LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-neto          LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi     LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
*/

DEFINE VARIABLE v-subtotal_bruto         LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_iva     LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prciva          LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prcnoi          LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".





/*{VRSHARED.I}
  {VPERSINM.I}*/

FORM
    SKIP(2)
    v-letra AT 41
    Ocm_header.nro_comprob FORMAT "99999999"           AT 56
    SKIP(1)
    v-comprobante          AT 56
    SKIP(1)
    Ocm_header.fecha       AT 56
    WITH FRAME frm-comprobante NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM
    SKIP(8)
    Proveedor.cdg_proveedor    AT 12
    Proveedor.nombre      AT 21   
    SKIP
    Domicilio_prv.direccion   AT 21
    Domicilio_prv.cdg_postal  AT 16 FORMAT "X(4)"
    Domicilio_prv.localidad
    SKIP
    Provincia.nombre       AT 21
    "TE. " AT 54  Domicilio_prv.telefono       AT 58

    "Comprador:"       AT 12
    Comprador.cdg_comprador  FORMAT "999"
    Comprador.nom_comprador
    SKIP
    Condicion_impos.texto  AT 12
    Proveedor.cuit        AT 54 FORMAT "X(15)"
    SKIP(1)
    "Ingresos Brutos Nro.: " AT 12
    "Convenio Multilateral:" AT 53
    SKIP(1)
    "Transportista" AT 9 
    "Condic. de Compra" AT 48
    SKIP(1)
    Ocm_header.transportista AT 9
    Condicion_venta.descripcion  AT 48 FORMAT "X(22)"
    Cta_cte.fecha_vencimiento AT 71
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    Ocm_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    SKIP(1)
    "Neto" AT 50
    prciva AT 63
    "I.V.A."
    prcnoi AT 85
    "%"
    "Total a Pagar" AT 119
    SKIP(1)
    Ocm_header.imp_neto AT 53
    importe_iva AT 68
/*    Ocm_header.imp_total AT 122 FORMAT "Z,ZZZ,ZZ9.99-"*/
    v-total AT 122 FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP(2)
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM
    que_articulo AT 9 FORMAT "X(6)"
    que_descripcion
    que_cantidad
    que_granel  
    que_unidad
    que_precio
    que_subtotal
    que_fecha 
    /*
    Articulo.cdg_articulo AT 9 FORMAT "X(6)" 
    Articulo.descripcion /*AT 22*/
    Ocm_detalle.cantidad /*AT 71*/ FORMAT ">>>,>>9.99"
    Ocm_detalle.granel /*AT 84*/ FORMAT ">>>,>>9.999"
    Unidad.abrevia /*AT 95*/ FORMAT "X(5)"
    Ocm_detalle.precio /*AT 92*/ FORMAT ">>>,>>9.999999"
    v-subtotal_bruto /*AT 122*/ FORMAT "Z,ZZZ,ZZ9.99-"
    Ocm_detalle_entr.fecha_temprana
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

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN dire_tmp = Parametro.valor_c.

FIND Parametro "CLIOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSFC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Ocm_header.leyenda:WIDTH = ccoobsdc.
Ocm_header.leyenda:HEIGHT = cliobsdc.

FIND Ocm_header      WHERE ROWID(Ocm_header) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Ocm_header NO-LOCK.
FIND Condicion_venta OF Ocm_header NO-LOCK.
FIND Proveedor       OF Ocm_header NO-LOCK NO-ERROR.
FIND Comprador       OF Ocm_header NO-LOCK NO-ERROR.
FIND Domicilio_prv   OF Ocm_header NO-LOCK NO-ERROR.
FIND Provincia       OF Domicilio_prv NO-LOCK.

FIND Impuesto 1 NO-LOCK.
prciva = Impuesto.tasa.
/* importe_iva = Ocm_header.imp_total - Ocm_header.imp_neto.*/
importe_iva = Ocm_header.imp_neto * 0.21.
v-total = Ocm_header.imp_neto + importe_iva.
v-letra = "". 

SUBSTRING(titulo-detalle,9,8)   = "Articulo". 
SUBSTRING(titulo-detalle,22,10) = "Descripcion".
SUBSTRING(titulo-detalle,59,8)  = "Cantidad".
SUBSTRING(titulo-detalle,73,5)  = "Kilaje".
SUBSTRING(titulo-detalle,80,6)  = "Unidad".
SUBSTRING(titulo-detalle,92,6)  = "Precio". 
SUBSTRING(titulo-detalle,105,8) = "Subtotal". 
SUBSTRING(titulo-detalle,115,8) = "Entrega". 

/*OUTPUT TO PRINTER PAGE-SIZE 72.*/

OUTPUT TO VALUE(dire_tmp + "PROCM501.TXT") PAGE-SIZE 72.

PUT CONTROL CHR(18).
PUT CONTROL "~033CH".

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    v-comprobante
    Ocm_header.nro_comprob
    Ocm_header.fecha
    WITH FRAME frm-comprobante.

DISPLAY
    Proveedor.nombre
    Proveedor.cdg_proveedor    WHEN AVAILABLE Proveedor
    Domicilio_prv.direccion
    Domicilio_prv.cdg_postal
    Domicilio_prv.localidad
    Provincia.nombre
    Domicilio_prv.telefono
    Comprador.cdg_comprador
    Comprador.nom_comprador
    Condicion_impos.texto
    Proveedor.cuit
    Condicion_venta.descripcion
    Ocm_header.transportista
    WITH FRAME frm-encabezado.


/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

PUT CONTROL CHR(15).

DISPLAY
    titulo-detalle
    WITH FRAME frm-titdetalle.

linea0 = LINE-COUNTER.

FOR EACH Ocm_detalle OF Ocm_header, Articulo OF Ocm_detalle NO-LOCK,
                                    Unidad OF Articulo NO-LOCK:

  v-subtotal_bruto = 
              ( IF Articulo.a_granel 
                   THEN ROUND( Ocm_detalle.precio * Ocm_detalle.granel   , 2 )
                   ELSE ROUND( Ocm_detalle.precio * Ocm_detalle.cantidad , 2 ) ).



  IF Articulo.extendida
  THEN DO:
     total_chars = LENGTH(Ocm_detalle.observacion).
     nt_lineas =  TRUNC(total_chars / ancho_linea,0).
     IF nt_lineas * ancho_linea <> total_chars THEN nt_lineas = nt_lineas + 1.
     DO j = 1 to nt_lineas:

        que_articulo = ( IF j = 1 THEN Articulo.cdg_articulo
                                  ELSE "").
        que_descripcion = SUBSTRING(Ocm_detalle.observacion,( j - 1) * ancho_linea + 1 ,
                                                                     ancho_linea ).
        que_cantidad = STRING(Ocm_detalle.cantidad).
        que_unidad   = Unidad.abrevia.
        que_precio   = STRING(Ocm_detalle.precio).
        que_subtotal = ( IF Ocm_detalle.cantidad = 0 THEN STRING(Ocm_detalle.precio)
                                                     ELSE STRING(subtotal)).
       
        DISPLAY  que_articulo    WHEN j = 1
                 que_cantidad    WHEN Ocm_detalle.cantidad <> 0  AND j = nt_lineas
                 que_descripcion
                 que_precio      WHEN Ocm_detalle.cantidad <> 0  AND j = nt_lineas
                 que_subtotal    WHEN j = nt_lineas
                 WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
        DOWN WITH FRAME frm-detalle.
        
     END.
  END.
  ELSE DO:
     FIND FIRST Ocm_detalle_entr of Ocm_detalle WHERE Ocm_detalle_entr.nro_linea = Ocm_detalle.nro_linea NO-ERROR.
     ASSIGN
        que_articulo    = Articulo.cdg_articulo
        que_descripcion = Articulo.descripcion
        que_cantidad    = STRING(Ocm_detalle.cantidad)
        que_granel      = STRING(Ocm_detalle.granel)
        que_unidad      = Unidad.abrevia
        que_precio      = STRING(Ocm_detalle.precio)
        que_subtotal    = STRING(v-subtotal_bruto)
        que_fecha       = STRING(Ocm_detalle_entr.fecha_temprana).
     DISPLAY  que_articulo    
              que_descripcion
              que_cantidad    
              que_granel
              que_unidad
              que_precio      
              que_subtotal    
              que_fecha
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
    Ocm_header.leyenda
    Ocm_header.imp_neto
    importe_iva
    v-total
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.

run veresult.w ( input "procm501.txt", input 8).

/*
DOS SILENT VALUE("COPY " + dire_tmp + "PRFAA501.TXT" + "  lpt1") /* view-as alert-box message.*/.

*/
