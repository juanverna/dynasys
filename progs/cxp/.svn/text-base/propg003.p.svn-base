
/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*                                                                                 */
/*  Modelo de Manuel Sanmartin S.A.                                                */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{NOMMESES.I}

DEFINE VARIABLE subtotal    AS DECIMAL FORMAT "-ZZZ,ZZ9.99".
DEFINE VARIABLE a_confirmar AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE que_cheque  AS CHARACTER.
DEFINE VARIABLE que_letras  AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE que_banco   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE que_fecha   AS CHARACTER FORMAT "X(10)".
DEFINE VARIABLE que_archivo AS CHARACTER.
DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE donde       AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE cuando      AS CHARACTER FORMAT "X(35)".
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
    "COMPROBANTE DE PAGO"   AT 60  
    SKIP
    "Nro.:" AT 60 
    Opg_header.nro_comprob
    a_confirmar
    SKIP
    "Entregamos a:"
    Opg_header.fecha       AT 60
    SKIP
    Proveedor.nombre  AT 5
    "  ["  Proveedor.cdg_Proveedor "]"
    SKIP
    Domicilio_prv.direccion AT 5
    SKIP
    Domicilio_prv.cdg_postal AT 5
    Domicilio_prv.localidad
    Provincia.nombre
    SKIP(1)
    "Detalle de valores entregados"
    SKIP
    "-----------------------------------------------------------------------"  SKIP
    "Cheque Nro.   Cargo Banco                  Fecha Vto.           Importe"  SKIP
    "-----------------------------------------------------------------------"  SKIP
    WITH FRAME frm-encabezado-val NO-LABELS USE-TEXT STREAM-IO WIDTH 80.

FORM
    SKIP(1)
    "Aplicación de Pago"  SKIP
    "-----------------------------------------------------------------------"  SKIP
    "Fecha      Comprobante                                          Importe"  SKIP
    "-----------------------------------------------------------------------"  SKIP
    WITH FRAME frm-encabezado-apl NO-LABELS USE-TEXT STREAM-IO WIDTH 80.


FORM
    Opg_header.leyenda VIEW-AS EDITOR SIZE 65 BY 3 AT 14
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 132 NO-LABELS.

FORM
    Rubro.abrevia
    dtl_rubro FORMAT "X(25)"
    Caj_detalle.importe TO 71
    WITH FRAME frm-detalle-val USE-TEXT STREAM-IO DOWN WIDTH 80 NO-LABELS.

FORM
    Cta_cte_prv.fecha_vencimiento
    Cta_cte_prv.leyenda
    Opg_detalle.tip_cancela
    Opg_detalle.prf_cancela
    Opg_detalle.nro_cancela
    Opg_detalle.importe  TO 71
    WITH FRAME frm-detalle-apl USE-TEXT STREAM-IO DOWN WIDTH 80 NO-LABELS.

FORM
    "-----------------------------------------------------------------------"  SKIP
    SKIP(1)
    "Recibí(mos) de Manuel Sanmartín S.A. la cantidad de" AT 5 Moneda.descripcion SKIP
    que_letras 
    SKIP(5)
    "Firma" AT 60
    SKIP(2)
    donde SPACE(3) cuando
    WITH FRAME frm-pie NO-LABELS USE-TEXT STREAM-IO WIDTH 80.


FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

{SETIMPRE.I}

FIND Opg_header WHERE ROWID(Opg_header) = act_recibo EXCLUSIVE-LOCK.
FIND Proveedor OF Opg_header NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
FIND Provincia OF Domicilio_prv NO-LOCK.
FIND Moneda OF Opg_header NO-LOCK.

que_archivo = dire_tmp + "propg003.txt".
OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72.

RUN PONE_CODIGO ( INPUT "VERTICAL,SET10CPI").

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
    Domicilio_prv.direccion
    Domicilio_prv.cdg_postal
    Domicilio_prv.localidad
    Provincia.nombre
    WITH FRAME frm-encabezado-val.

/*---------------------------------------------------------------------------------*/
/*                                    VALORES                                      */
/*---------------------------------------------------------------------------------*/

v-valores = 0.

FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.
FOR EACH Caj_detalle OF Caj_header, Rubro OF Caj_detalle WITH FRAME frm-detalle-val:

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

     DISPLAY Rubro.abrevia
             dtl_rubro
             Caj_detalle.importe
             WITH FRAME frm-detalle-val.
     DOWN WITH FRAME frm-detalle-val.
     v-valores = v-valores + Caj_detalle.importe.

END.

UNDERLINE  Caj_detalle.importe
           WITH FRAME frm-detalle-val.
DISPLAY v-valores @ Caj_detalle.importe
           WITH FRAME frm-detalle-val.

/*---------------------------------------------------------------------------------*/
/*                              APLICACION DE PAGO                                 */
/*---------------------------------------------------------------------------------*/

v-valores = 0.

VIEW FRAME frm-encabezado-apl.

FOR EACH Opg_detalle OF Opg_header,
          FIRST Cta_cte_prv WHERE Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                              AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                              AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela
                              AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                              AND Cta_cte_prv.nro_proveedor   = Proveedor.nro_proveedor
                                  WITH FRAME frm-detalle-apl:

  DISPLAY  Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.leyenda
           Opg_detalle.tip_cancela
           Opg_detalle.prf_cancela
           Opg_detalle.nro_cancela
           Opg_detalle.importe
           WITH FRAME frm-detalle-apl USE-TEXT STREAM-IO DOWN.
  DOWN WITH FRAME frm-detalle-apl.
  v-valores = v-valores + Opg_detalle.importe.

END.

UNDERLINE  Opg_detalle.importe
           WITH FRAME frm-detalle-apl.
DISPLAY v-valores @ Opg_detalle.importe
           WITH FRAME frm-detalle-apl.
           
/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

RUN TOLETRAS.P ( INPUT v-valores, OUTPUT que_letras ).

cuando = STRING(DAY(Opg_header.fecha),">9") + 
         " de " + 
         nom_mes [ MONTH(Opg_header.fecha) ] +
         " de " + 
         STRING(YEAR(Opg_header.fecha),"9999").

donde    = "Mercedes, Pcia. de Buenos Aires".


DISPLAY
    que_letras 
    Moneda.descripcion
    donde 
    cuando
    WITH FRAME frm-pie.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.

/*RUN PROPRINT.P ( INPUT que_archivo ).*/

RUN veresult.w ( INPUT que_archivo, INPUT 8 ).

{CODIMPRE.I}
