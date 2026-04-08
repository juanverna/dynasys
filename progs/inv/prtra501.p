/*=================================================================================*/
/*                            IMPRESION DE REMITOS                                 */
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
DEFINE VARIABLE v-comprobante   AS CHARACTER FORMAT "X(12)" INITIAL "REMITO".
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

DEFINE VARIABLE t-kilos         LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE t-bultos        LIKE Fac_header.imp_neto FORMAT "ZZZZ,ZZZ,ZZ9-".

{VRSHARED.I}
{VPERSINM.I}

FORM
    SKIP(1)
    v-letra AT 41
    Transdep_hd.prf_comprob FORMAT "9999" AT 56
    Transdep_hd.nro_comprob FORMAT "99999999"
    SKIP(1)
    v-comprobante          AT 56
    SKIP
    "COMPROBANTE NO VALIDO COMO FACTURA" AT 46
    SKIP
    Transdep_hd.fecha       AT 56
    WITH FRAME frm-comprobante NO-LABELS USE-TEXT STREAM-IO WIDTH 96.

FORM
    SKIP(8)
    Deposito.cdg_deposito       AT 12
    Deposito.denominacion_dep   AT 21   
    SKIP(1)
    Deposito.direccion          AT 21
    Deposito.cdg_postal         AT 21 format  "X(4)"
    Deposito.localidad
    SKIP
    Provincia.nombre            AT 21
    SKIP
    Condicion_impos.texto       AT 12
/*    Deposito.cuit           AT 54 FORMAT "X(15)"*/
    SKIP(3)
    "O/Compra" AT 9 
    "Factura Nro." AT 24
    "Transporte - Chofer" AT 43
    SKIP(1)
    Ped_header.tip_comprob AT 9 FORMAT "X(2)"
    Ped_header.nro_comprob FORMAT ">>>>9"
    Fac_header.prf_comprob AT 24 FORMAT "9999"
    Fac_header.nro_comprob FORMAT "99999999" 
    Transdep_hd.leyenda AT 41 FORMAT "X(25)" 
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    Transdep_hd.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 7
    SKIP
    "Kilos" AT 18
    "Bultos" AT 43
    "Valor Asegurado" AT 63
    SKIP(1)
    t-kilos AT 18
    t-bultos AT 43
    Transdep_hd.imp_total AT 73
    SKIP(1)
    "La mercaderia viaja por cuenta y riesgo de la Empresa Transportadora y debera ser entregada en destino mañana a primera hora" AT 9
    SKIP(2)
    "----------------                       ---------------------                        ---------------------" AT 9 SKIP
    "Control de Carga                             Chofer                                         Recibio" AT 9
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM

    Articulo.cdg_articulo AT 9 
    Articulo.descripcion
    Partida.cdg_partida 
    Transdep_dt.cantidad AT 71 FORMAT "->>,>>9.99"
    Transdep_dt.granel AT 84
    Unidad.abrevia AT 95
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

Transdep_hd.leyenda:WIDTH = ccoobsdc.
Transdep_hd.leyenda:HEIGHT = cliobsdc.

FIND Transdep_hd WHERE ROWID(Transdep_hd) = act_factura EXCLUSIVE-LOCK.
/*FIND Condicion_impos OF Transdep_hd NO-LOCK.*/
/*FIND Domicilio OF Transdep_hd NO-LOCK.*/
/*FIND Provincia OF Transdep_hd NO-LOCK.*/

FIND Deposito   OF Transdep_hd NO-LOCK NO-ERROR.
FIND Provincia  OF Deposito    NO-LOCK.

/*
FIND Fac_header WHERE Fac_header.nro_factura = Transdep_hd.nro_factura NO-LOCK NO-ERROR.
FIND Ped_header WHERE Ped_header.nro_pedido = Transdep_hd.nro_pedido NO-LOCK NO-ERROR.
*/

v-letra = "X". 

SUBSTRING(titulo-detalle,9,8) = "Articulo". 
SUBSTRING(titulo-detalle,22,10) = "Descripcion".
SUBSTRING(titulo-detalle,58,7) = "Partida".
SUBSTRING(titulo-detalle,76,8) = "Cantidad".
SUBSTRING(titulo-detalle,87,5) = "Kilaje".
SUBSTRING(titulo-detalle,95,6) = "Unidad".

OUTPUT TO PRINTER PAGE-SIZE 72.

PUT CONTROL "~033CH". 

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

/*RUN PONE_CODIGO ( INPUT "SET10CPI" ).*/

PUT CONTROL CHR(18).

DISPLAY
    v-letra 
    v-comprobante
    Transdep_hd.prf_comprob
    Transdep_hd.nro_comprob
    Transdep_hd.fecha
    WITH FRAME frm-comprobante.


DISPLAY
    Deposito.denominacion_dep    WHEN AVAILABLE Deposito
    Deposito.cdg_deposito        WHEN AVAILABLE Deposito
    Deposito.localidad           WHEN AVAILABLE Deposito
    Deposito.direccion           WHEN AVAILABLE Deposito
    Transdep_hd.leyenda
    Deposito.cdg_postal          WHEN AVAILABLE Deposito
    Provincia.nombre
    /*
    Transdep_hd.nro_ocm
    Ped_header.tip_comprob       WHEN AVAILABLE Ped_header
    Ped_header.nro_comprob       WHEN AVAILABLE Ped_header
    Fac_header.prf_comprob       WHEN AVAILABLE Fac_header
    Fac_header.nro_comprob       WHEN AVAILABLE Fac_header
    Condicion_impos.texto
    Deposito.cuit
    */
  
    WITH FRAME frm-encabezado.


/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

/*RUN PONE_CODIGO ( INPUT "SET17CPI").*/

PUT CONTROL CHR(15).

DISPLAY
    titulo-detalle
    WITH FRAME frm-titdetalle.

linea0 = LINE-COUNTER.
t-bultos = 0.
t-kilos = 0.

FOR EACH Transdep_dt OF Transdep_hd, Articulo OF Transdep_dt NO-LOCK,
                                    Unidad OF Articulo NO-LOCK, Partida OF Transdep_dt NO-LOCK:

  IF Articulo.extendida
  THEN DO:
     total_chars = LENGTH(Transdep_hd.leyenda).
     nt_lineas =  TRUNC(total_chars / ancho_linea,0).
     IF nt_lineas * ancho_linea <> total_chars THEN nt_lineas = nt_lineas + 1.
     DO j = 1 to nt_lineas:

        que_articulo = ( IF j = 1 THEN STRING(Articulo.cdg_articulo,"ZZZZZZZ9")
                                  ELSE "").
        que_descripcion = SUBSTRING(Transdep_hd.leyenda,( j - 1) * ancho_linea + 1 ,
                                                                     ancho_linea ).
        que_cantidad = STRING(Transdep_dt.cantidad, "ZZZZZZZ9").
        que_unidad   = Unidad.abrevia.
        /*
        que_precio   = STRING(Transdep_dt.precio, "ZZZZZZ9.99").
        que_subtotal = ( IF Transdep_dt.cantidad = 0 THEN STRING(Transdep_dt.precio, "ZZZZZZ9.99")
                                                     ELSE STRING(subtotal, "ZZZZZZ9.99")).
        */
        /*
        DISPLAY  que_cantidad    WHEN Transdep_dt.cantidad <> 0  AND j = nt_lineas
                 que_descripcion
                 que_precio      WHEN Transdep_dt.cantidad <> 0  AND j = nt_lineas
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
            Partida.cdg_partida  
            Transdep_dt.cantidad
            Transdep_dt.granel
            Unidad.abrevia
            WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
    DOWN WITH FRAME frm-detalle.
  END.

  t-bultos = t-bultos + Transdep_dt.cantidad.
  t-kilos  = t-kilos  + IF Articulo.a_granel 
                           THEN Transdep_dt.granel
                           ELSE Transdep_dt.cantidad * Articulo.kgxun_bruto.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Transdep_hd.leyenda
    t-kilos
    t-bultos
    /*
    Transdep_hd.imp_total
    */
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.


{CODIMPRE.I}
