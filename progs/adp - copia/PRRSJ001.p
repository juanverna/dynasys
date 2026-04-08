/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE uldep_banco  AS CHARACTER FORMAT "X(12)" LABEL "Banco".
DEFINE VARIABLE uldep_period AS CHARACTER FORMAT "X(8)"  LABEL "Periodo".
DEFINE VARIABLE uldep_fecha  AS CHARACTER FORMAT "X(8)"  LABEL "Fecha".
DEFINE VARIABLE abonado      AS CHARACTER FORMAT "X(12)" LABEL "Per. Abonado".
DEFINE VARIABLE cuando       AS CHARACTER FORMAT "X(15)" LABEL "Fecha de pago".

FIND Rcb_header WHERE ROWID(Rcb_header) = act_recibo NO-LOCK.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

v-filtro =  "Rcb_header.nro_comprob= " +
            STRING(Rcb_header.nro_comprob) + 
            " AND Concepto.haber_retenc <> 'A' " + 
            " AND Rcb_detalle.importe <> 0".

FIND Parametro "ULDEPBCO" NO-LOCK.
uldep_banco = Parametro.valor_c.

FIND Parametro "ULDEPPER" NO-LOCK.
uldep_period = Parametro.valor_c.
     
FIND Parametro "ULDEPFCH" NO-LOCK.
uldep_fecha = Parametro.valor_c.

FIND Parametro "PERABONA" NO-LOCK.
abonado  = Parametro.valor_c.

FIND Parametro "FECHPAGO" NO-LOCK.
cuando = Parametro.valor_c.

v-params = "p_ultdepos=" + uldep_fecha  + "~n" +
           "p_bcodepos=" + uldep_banco  + "~n" +
           "p_perdepos=" + uldep_period + "~n" +
           "p_abonado="  + abonado      + "~n" +
           "p_cuando="   + cuando.

RUN exreport.p (  INPUT  ".\prl\sic.prl",     /* Librería desde la que se ejecuta   */
                  INPUT  "Recibo de Haberes", /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,            /* Filtro de registros a imponer      */
                  INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                  /* Impresora de destino del listado   */
                  INPUT  v-params             /* Parametros especificos del reporte */
                )   
