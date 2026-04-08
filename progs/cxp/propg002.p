
/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE subtotal    AS DECIMAL FORMAT "-ZZZ,ZZ9.99".
DEFINE VARIABLE a_confirmar AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE que_archivo AS CHARACTER.
DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 10.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE v-bruto     LIKE Opg_header.imp_neto.
DEFINE VARIABLE v-desc      LIKE Opg_header.imp_neto.
DEFINE VARIABLE v-valores   LIKE Opg_header.imp_neto.
DEFINE VARIABLE prciva      LIKE Impuesto.tasa.
DEFINE VARIABLE prcnoi      LIKE Impuesto.tasa.
DEFINE VARIABLE importe_iva LIKE Sub_detalle_prv.valor.
DEFINE VARIABLE importe_noi LIKE Sub_detalle_prv.valor.
DEFINE VARIABLE dtl_rubro   AS CHARACTER.

DEFINE QUERY qry_aplicacion FOR Opg_detalle,Cta_cte_prv.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FORM
    "ORDEN DE PAGO:"
    Opg_header.nro_comprob
    a_confirmar
    SKIP(1)
    Opg_header.fecha       AT 42
    SKIP(1)
    Proveedor.nombre
    "  ["
    Proveedor.cdg_Proveedor
    "]"
    SKIP(2)
    Proveedor.direccion
    SKIP
    Proveedor.cdg_postal
    Proveedor.localidad
    SKIP
    Provincia.nombre
    SKIP(1)
    Condicion_impos.texto
    Proveedor.cuit        AT 49
    SKIP(1)
    "-------------------------------------------------------------------------------------------"
    SKIP
    "           APLICACION DE PAGO                              VALORES ENTREGADOS"
    SKIP
    "-------------------------------------------------------------------------------------------"
    SKIP
    "   DOCUMENTO          IMPORTE     DESCTO.        IMPORTE  CONCEPTO"
    SKIP(1)
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    Opg_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 15
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 132 NO-LABELS.

FORM
    Opg_detalle.tip_cancela
    Opg_detalle.prf_cancela
    Opg_detalle.nro_cancela
    Opg_detalle.nro_vencimiento
    Opg_detalle.importe
    Opg_detalle.descuento
    Caj_detalle.importe
    Rubro.cdg_rubro
    Rubro.abrevia
    dtl_rubro FORMAT "X(25)"
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

{SETIMPRE.I}

FIND Parametro "CLIOBSOP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSOP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Opg_header.leyenda:WIDTH = ccoobsdc.
Opg_header.leyenda:HEIGHT = cliobsdc.

FIND Opg_header WHERE ROWID(Opg_header) = act_recibo EXCLUSIVE-LOCK.
FIND Condicion_impos   OF Opg_header NO-LOCK.
/*FIND Provincia OF Opg_header NO-LOCK.*/
FIND Proveedor OF Opg_header NO-LOCK.

FIND Impuesto 1 NO-LOCK.
prciva = Impuesto.tasa.

/*
FIND FIRST Sub_detalle OF Opg_header WHERE Sub_detalle.cdg_cuenta = Impuesto.cdg_cuenta.
importe_iva = Sub_detalle.valor.

FIND Impuesto 2 NO-LOCK.
prcnoi = Impuesto.tasa.
FIND FIRST Sub_detalle OF Opg_header WHERE Sub_detalle.cdg_cuenta = Impuesto.cdg_cuenta NO-ERROR.
IF AVAILABLE Sub_detalle THEN importe_noi = Sub_detalle.valor.
                         ELSE importe_noi = 0.
v-desc  = Opg_header.imp_bruto - Opg_header.imp_neto.
v-bruto = Opg_header.imp_bruto.
*/

v-desc  = 0.
v-bruto = 0.
v-valores = 0.

que_archivo = dire_tmp + "PROPG002.TXT".
OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72.

RUN PONE_CODIGO ( INPUT "HORIZONT,SET12CPI").

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

IF Opg_header.estado <> "E" THEN a_confirmar = "Orden a confirmar".
                            ELSE a_confirmar = "".

DISPLAY
    Opg_header.nro_comprob
    a_confirmar
    Opg_header.fecha
    Proveedor.nombre
    Proveedor.cdg_Proveedor
    Proveedor.direccion
    Proveedor.cdg_postal
    Proveedor.localidad
/*  Provincia.nombre     */
    Condicion_impos.texto
    Proveedor.cuit
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

FIND Caj_header
     WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.

OPEN QUERY qry_aplicacion
     FOR EACH Opg_detalle OF Opg_header,
          FIRST Cta_cte_prv /*WHERE Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                              AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                              AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela
                              AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                              AND Cta_cte_prv.nro_proveedor   = Proveedor.nro_proveedor*/.

OPEN QUERY qry_valores
     FOR EACH Caj_detalle OF Caj_header.

GET FIRST qry_valores    NO-LOCK.
GET FIRST qry_aplicacion NO-LOCK.

DO WHILE AVAILABLE Opg_detalle OR AVAILABLE Caj_detalle:

  IF AVAILABLE Caj_detalle
  THEN DO:
     v-valores = v-valores + Caj_detalle.importe.
     FIND Rubro OF Caj_detalle NO-ERROR.
     CASE Rubro.tipo:
        WHEN "D"
          THEN DO:
               dtl_rubro = "".
          END.
        WHEN "C"
          THEN DO:
               dtl_rubro = TRIM(STRING(Caj_detalle.divisas,"->,>>>,>>9.99")) + " * " +
                           TRIM(STRING(Caj_detalle.cambio,">>,>>9.9999")).
          END.
        WHEN "P"
          THEN DO:
               FIND Cheque OF Caj_detalle NO-LOCK.
               FIND Cuenta_bancaria OF Cheque NO-LOCK.
               FIND Banco OF Cuenta_bancaria NO-LOCK.
               dtl_rubro = Banco.abrevia + " " +
                           STRING(Cheque.numero_cheque,"99999999") + " " +
                           STRING(Cheque.fecha_emision).
          END.
        WHEN "V"
          THEN DO:
               FIND Valor OF Caj_detalle NO-LOCK.
               FIND Banco OF Valor NO-LOCK.
               dtl_rubro = Banco.abrevia + " " +
                           STRING(Valor.numero_cheque,"99999999") + " " +
                           STRING(Valor.fecha_emision).
          END.

        WHEN "R"
          THEN DO:
               dtl_rubro = Caj_detalle.observacion.
          END.

     END CASE.
  END.

  IF AVAILABLE Opg_detalle
  THEN DO:
     v-bruto = v-bruto + Opg_detalle.importe.
     v-desc  = v-desc  + Opg_detalle.descuento.
  END.

  DISPLAY  Opg_detalle.tip_cancela      WHEN AVAILABLE Opg_detalle
           Opg_detalle.prf_cancela      WHEN AVAILABLE Opg_detalle
           Opg_detalle.nro_cancela      WHEN AVAILABLE Opg_detalle
           Opg_detalle.nro_vencimiento  WHEN AVAILABLE Opg_detalle
           Opg_detalle.importe          WHEN AVAILABLE Opg_detalle
           Opg_detalle.descuento        WHEN AVAILABLE Opg_detalle
           Caj_detalle.importe          WHEN AVAILABLE Caj_detalle
           Rubro.cdg_rubro              WHEN AVAILABLE Caj_detalle
           Rubro.abrevia                WHEN AVAILABLE Caj_detalle
           dtl_rubro                    WHEN AVAILABLE Caj_detalle
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

  DOWN WITH FRAME frm-detalle.
  GET NEXT qry_valores    NO-LOCK.
  GET NEXT qry_aplicacion NO-LOCK.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

UNDERLINE  Opg_detalle.tip_cancela
           Opg_detalle.prf_cancela
           Opg_detalle.nro_cancela
           Opg_detalle.nro_vencimiento
           Opg_detalle.importe
           Opg_detalle.descuento
           Rubro.abrevia
           Caj_detalle.importe
           dtl_rubro
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

DISPLAY  Opg_header.imp_total  @ Opg_detalle.importe
         v-desc                @ Opg_detalle.descuento
         Caj_header.importe    @ Caj_detalle.importe
         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Opg_header.leyenda
    WITH FRAME frm-pie.

FOR EACH X_Calculo OF Opg_header NO-LOCK:

    DISPLAY X_Calculo.concepto X_Calculo.importe
            WITH FRAME dd NO-LABEL DOWN USE-TEXT.
    DOWN WITH FRAME dd.
    
END.            


/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.
RUN PROPRINT.P ( INPUT que_archivo ).

{CODIMPRE.I}
