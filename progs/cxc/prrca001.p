
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
DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 10.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE v-bruto     LIKE Rec_header.imp_neto.
DEFINE VARIABLE v-desc      LIKE Rec_header.imp_neto.
DEFINE VARIABLE v-valores   LIKE Rec_header.imp_neto.
DEFINE VARIABLE prciva      LIKE Impuesto.tasa.
DEFINE VARIABLE prcnoi      LIKE Impuesto.tasa.
DEFINE VARIABLE importe_iva LIKE Sub_detalle_vta.valor.
DEFINE VARIABLE importe_noi LIKE Sub_detalle_vta.valor.
DEFINE VARIABLE dtl_rubro   AS CHARACTER.

DEFINE QUERY qry_aplicacion FOR Rec_detalle,Cta_cte.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FORM
    SPACE(15)
    "Recibo:"
    Rec_header.tip_comprob
    Rec_header.nro_comprob
    SKIP(1)
    Rec_header.fecha       AT 57
    SKIP(1)
    Cliente.nom_cliente      AT 15
    SKIP
    Cliente.cdg_cliente    AT 57
    Vendedor.cdg_vendedor  AT 69
    SKIP(2)
    Rec_header.direccion   AT 15 FORMAT "X(40)"
    Rec_header.cdg_postal  AT 15
    Rec_header.localidad
    SKIP
    Provincia.nombre       AT 15
    SKIP(1)
    Condicion_impos.texto          AT 15
    Cliente.cuit        AT 49
    SKIP(1)
    SPACE(15)
    "DOCUMENTO      NRO.  VTO.   IMPORTE     DESCTO.   VALORES RECIBIDOS"
    SKIP
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    SPACE(15)
    Rec_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 15
    SKIP(1)
    prciva AT 27
    prcnoi AT 39
    SKIP(1)
    importe_iva AT 27
    importe_noi AT 39
    v-desc      AT 68
    SKIP
    Rec_header.imp_total AT 48
    Rec_header.imp_neto  AT 68
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 132 NO-LABELS.

FORM
    SPACE(16)
    Rec_detalle.nro_linea COLUMN-LABEL "# "
    Cta_Cte.tip_comprob
    Cta_Cte.prf_comprob
    Cta_Cte.nro_comprob
    Cta_Cte.nro_vencimiento
    Rec_detalle.importe
    Rec_detalle.descuento
    SPACE(3)
    Caj_detalle.importe
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

FIND Parametro "CLIOBSRC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSRC" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Rec_header.leyenda:WIDTH = ccoobsdc.
Rec_header.leyenda:HEIGHT = cliobsdc.

FIND Rec_header WHERE ROWID(Rec_header) = act_recibo EXCLUSIVE-LOCK.
FIND Condicion_impos OF Rec_header NO-LOCK.
/*FIND Provincia OF Rec_header NO-LOCK.*/
FIND Cliente   OF Rec_header NO-LOCK NO-ERROR.
FIND Vendedor OF Rec_header NO-LOCK NO-ERROR.

FIND Impuesto 1 NO-LOCK.
prciva = Impuesto.tasa.


/*
FIND FIRST Sub_detalle_vta OF Rec_header WHERE Sub_detalle_vta.cdg_cuenta = Impuesto.cdg_cuenta.
importe_iva = Sub_detalle_vta.valor.

FIND Impuesto 2 NO-LOCK.
prcnoi = Impuesto.tasa.
FIND FIRST Sub_detalle_vta OF Rec_header WHERE Sub_detalle_vta.cdg_cuenta = Impuesto.cdg_cuenta NO-ERROR.
IF AVAILABLE Sub_detalle_vta THEN importe_noi = Sub_detalle_vta.valor.
                         ELSE importe_noi = 0.
v-desc  = Rec_header.imp_bruto - Rec_header.imp_neto.
v-bruto = Rec_header.imp_bruto.
*/

v-desc  = 0.
v-bruto = 0.
v-valores = 0.

OUTPUT TO PRINTER PAGE-SIZE 72.

RUN PONE_CODIGO ( INPUT "HORIZONT").
RUN PONE_CODIGO ( INPUT "SET12CPI").

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Rec_header.tip_comprob
    Rec_header.nro_comprob
    Rec_header.fecha
    Cliente.nom_cliente         WHEN AVAILABLE Cliente
    Cliente.cdg_cliente    WHEN AVAILABLE Cliente
    Vendedor.cdg_vendedor  WHEN AVAILABLE Vendedor
    Rec_header.direccion
    Rec_header.cdg_postal
    Rec_header.localidad
    Provincia.nombre     WHEN AVAILABLE Provincia
    Condicion_impos.texto
    Cliente.cuit
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

OPEN QUERY qry_aplicacion
     FOR EACH Rec_detalle OF Rec_header,
          FIRST Cta_cte WHERE Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                          AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                          AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                          AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento.


FIND Caj_header
     WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion NO-LOCK.

OPEN QUERY qry_valores
     FOR EACH Caj_detalle OF Caj_header.

GET FIRST qry_valores    NO-LOCK.
GET FIRST qry_aplicacion NO-LOCK.

DO WHILE AVAILABLE Rec_detalle OR AVAILABLE Caj_detalle:

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
               dtl_rubro = STRING(Caj_detalle.divisas) + " * " +
                           STRING(Caj_detalle.cambio,"ZZZ9.9999").
          END.
        WHEN "V"
          THEN DO:
               FIND Valor OF Caj_detalle NO-LOCK.
               FIND Banco OF Valor NO-LOCK.
               dtl_rubro = Banco.abrevia + " " +
                           STRING(Valor.numero_cheque,"99999999") + " " +
                           STRING(Valor.fecha_emision).
          END.
     END CASE.
  END.

  IF AVAILABLE Rec_detalle
  THEN DO:
     v-bruto = v-bruto + Rec_detalle.importe.
     v-desc  = v-desc  + Rec_detalle.descuento.
  END.

  DISPLAY  Rec_detalle.nro_linea    WHEN AVAILABLE Rec_detalle
           Cta_Cte.tip_comprob      WHEN AVAILABLE Rec_detalle
           Cta_Cte.prf_comprob      WHEN AVAILABLE Rec_detalle
           Cta_Cte.nro_comprob      WHEN AVAILABLE Rec_detalle
           Cta_Cte.nro_vencimiento  WHEN AVAILABLE Rec_detalle
           Rec_detalle.importe      WHEN AVAILABLE Rec_detalle
           Rec_detalle.descuento    WHEN AVAILABLE Rec_detalle
           Caj_detalle.importe      WHEN AVAILABLE Caj_detalle
           Rubro.abrevia            WHEN AVAILABLE Caj_detalle
           dtl_rubro                WHEN AVAILABLE Caj_detalle
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

  DOWN WITH FRAME frm-detalle.
  GET NEXT qry_valores    NO-LOCK.
  GET NEXT qry_aplicacion NO-LOCK.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

UNDERLINE  Rec_detalle.nro_linea
           Cta_Cte.tip_comprob
           Cta_Cte.prf_comprob
           Cta_Cte.nro_comprob
           Cta_Cte.nro_vencimiento
           Rec_detalle.importe
           Rec_detalle.descuento
           Rubro.abrevia
           Caj_detalle.importe
           dtl_rubro
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

DISPLAY  v-bruto   @ Rec_detalle.importe
         v-desc    @ Rec_detalle.descuento
         v-valores @ Caj_detalle.importe
         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Rec_header.leyenda
    v-bruto
    prciva
    prcnoi
    Rec_header.imp_total
    v-desc
    Rec_header.imp_neto
    importe_iva
    importe_noi
    Rec_header.imp_total
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.


{CODIMPRE.I}
