
/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/


DEFINE VARIABLE subtotal        AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE prfac           AS CHARACTER.
DEFINE VARIABLE blancos         AS CHARACTER.
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
DEFINE VARIABLE nmax_det        AS INTEGER INITIAL 22.
DEFINE VARIABLE linea0          AS INTEGER.
DEFINE VARIABLE cliobsdc        AS INTEGER.
DEFINE VARIABLE ccoobsdc        AS INTEGER.
DEFINE VARIABLE v-bruto     LIKE Fac_header.imp_neto FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE v-desc      LIKE Fac_header.imp_neto FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE prciva      LIKE Impuesto.tasa.
DEFINE VARIABLE prcnoi      LIKE Impuesto.tasa.
DEFINE VARIABLE importe_iva LIKE Sub_detalle_vta.valor FORMAT "-ZZZZ9.99".
DEFINE VARIABLE importe_noi LIKE Sub_detalle_vta.valor FORMAT "-ZZZZ9.99".
DEFINE VARIABLE p_Printed       AS LOGICAL.


{VRSHARED.I}
{VPERSINM.I}

FORM
    SKIP(2)
    Fac_header.fecha       AT 57
    SKIP(6)
    Fac_header.nombre      AT 15
    Cliente.cdg_cliente    AT 57
    SKIP(1)
    Fac_header.direccion   AT 15 FORMAT "X(40)"
    Fac_header.cdg_postal  AT 59 format  "X(4)"
    Fac_header.localidad
    SKIP(1)
    Condicion_impos.texto          AT 24
    Fac_header.cuit        AT 58 FORMAT "X(15)"
    SKIP(1)
    Condicion_venta.descripcion  AT 27
    Fac_header.nro_remito  AT 69
    SKIP(1)
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM
    Fac_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    SKIP
    v-bruto AT 71
    SKIP(2)
    v-bruto AT 71
    SKIP(1)
    prciva AT 62
    importe_iva AT 72
    SKIP
    prcnoi AT 62
    importe_noi AT 72
    SKIP(1)
    Fac_header.imp_total AT 72
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 96 NO-LABELS.

FORM
    SPACE(1)
    que_cantidad
    SPACE(3)
    que_descripcion
    que_precio
    que_subtotal AT 71
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 96 NO-LABELS.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 96 NO-LABELS.
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

FIND Impuesto 1 NO-LOCK.
prciva = Impuesto.tasa.
FIND FIRST Sub_detalle_vta OF Fac_header WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta.
importe_iva = Sub_detalle_vta.valor.

FIND Impuesto 2 NO-LOCK.
prcnoi = Impuesto.tasa.
FIND FIRST Sub_detalle_vta OF Fac_header WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta NO-ERROR.
IF AVAILABLE Sub_detalle_vta THEN importe_noi = Sub_detalle_vta.valor.
                         ELSE importe_noi = 0.

v-desc  = Fac_header.imp_bruto - Fac_header.imp_neto.
v-bruto = Fac_header.imp_bruto.

OUTPUT TO PRINTER PAGE-SIZE 72.

/*RUN PONE_CODIGO ( INPUT "SET72LPP,SET12CPI" ).*/

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Fac_header.fecha
    Fac_header.nombre
    Cliente.cdg_cliente    WHEN AVAILABLE Cliente
    Fac_header.direccion
    Fac_header.nro_ocm
    Fac_header.nro_remito
    Fac_header.cdg_postal
    Fac_header.localidad
    Condicion_impos.texto
    Fac_header.cuit
    Condicion_venta.descripcion
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle NO-LOCK,
                                    Unidad OF Articulo NO-LOCK:

  subtotal = ROUND (Fac_detalle.precio *
                     ( IF Articulo.a_granel THEN Fac_detalle.granel
                                            ELSE Fac_detalle.cantidad) ,2).
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
        DISPLAY  que_cantidad    WHEN Fac_detalle.cantidad <> 0  AND j = nt_lineas
                 que_descripcion
                 que_precio      WHEN Fac_detalle.cantidad <> 0  AND j = nt_lineas
                 que_subtotal    WHEN j = nt_lineas
                 WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
        DOWN WITH FRAME frm-detalle.

     END.
  END.
  ELSE DO:
     que_articulo = Articulo.cdg_articulo.
     que_descripcion = Articulo.descripcion.
     que_cantidad = STRING(Fac_detalle.cantidad, "ZZZZZZZ9").
     que_unidad   = Unidad.abrevia.
     que_precio   = STRING(Fac_detalle.precio, "ZZZZZZ9.99").
     que_subtotal = STRING(subtotal, "ZZZZZZ9.99").

     DISPLAY  que_articulo
              que_descripcion
              que_cantidad
              que_precio
              que_subtotal
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
    v-bruto
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

/*
RUN _osprint.p ( INPUT  CURRENT-WINDOW:HANDLE,       /* HANDLE de la WINDOW    */
                 INPUT  dire_tmp + "PRFAA500.TXT",   /* Archivo a imprimir     */
                 INPUT  2,                           /* FONT a utilizar        */
                 INPUT  0,                           /* Print Flags 2=Apaisado */
                 INPUT  72,                          /* Lineas por Pagina      */
                 INPUT  0,                           /* 0= Todo, <>0 seleccion */
                 OUTPUT p_Printed ).                 /* Se imprimió o no       */
*/



