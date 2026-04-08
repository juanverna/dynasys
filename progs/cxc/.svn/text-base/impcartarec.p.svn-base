/*====================================================================================*/
/*           IMPRIME UNA CARTA DE RECLAMO DE DEUDA PARA UN CLIENTE ESPECIFICO         */
/*====================================================================================*/

DEFINE INPUT PARAMETER cli_act     AS ROWID.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/

{VPERSINM.I}
{VRSHARED.I}

DEFINE VARIABLE v-lugar-y-fecha     AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-firma             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-cargo             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-por-empresa       AS CHARACTER FORMAT "X(60)".


DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE que_archivo AS CHARACTER.
DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

/*====================================================================================*/
/*                                    FRAMES                                          */
/*====================================================================================*/


DEFINE FRAME frm-listado
  Cta_cte.tip_comprob
  SPACE(1)
  Cta_cte.prf_comprob
  SPACE(1)
  Cta_cte.nro_comprob FORMAT "ZZZZZ9"
  SPACE(1)
  Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "V"
  SPACE(1)
  Cta_cte.fecha_emision
  SPACE(1)
  Cta_cte.fecha_vencimiento
  SPACE(1)
  Imputacion.abrevia COLUMN-LABEL "Cpto."
  SPACE(1)
  Cta_cte.debito
  SPACE(1)
  Cta_cte.credito
  SPACE(1)
  saldo COLUMN-LABEL "Saldo"
  Cta_cte.leyenda
  WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO
       NO-LABEL.

/*====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                   */
/*====================================================================================*/

{findempresa.i}

FIND Moneda  WHERE Moneda.cdg_moneda = que_moneda  NO-LOCK.
FIND Cliente WHERE ROWID(Cliente) = cli_act     NO-LOCK.

ASSIGN debito    = 0
       credito   = 0
       saldo     = 0
       tot_saldo = 0.

que_archivo = dire_tmp + "resdedua.txt".
OUTPUT TO VALUE(que_archivo) PAGE-SIZE 0. 

PUT "NEWMEMO CUENTA:" SKIP "~{".

FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                              AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                              AND Cta_cte.credito <> Cta_cte.debito
                              AND Cta_cte.fecha_vencimiento <= has_fecha,
                             EACH Imputacion OF Cta_cte
                               BY Cta_cte.fecha_emision:

      ASSIGN debito  = 0
             credito = 0
             saldo   = 0.

     credito = credito + Cta_cte.credito.
     debito = debito + Cta_cte.debito.
     saldo = debito - credito.
     
     tot_saldo = tot_saldo + saldo.

     PUT   Cta_cte.tip_comprob
           SPACE(1)
           Cta_cte.prf_comprob
           SPACE(1)
           Cta_cte.nro_comprob
           SPACE(1)
           Cta_cte.nro_vencimiento
           SPACE(1)
           Cta_cte.fecha_emision
           SPACE(1)
           Cta_cte.fecha_vencimiento
           SPACE(1)
           Imputacion.abrevia
           SPACE(1)
           Cta_cte.debito
           SPACE(1)
           Cta_cte.credito
           SPACE(1)
           saldo SKIP.

END.

PUT "~}" SKIP.
PUT "NEWMEMO TOTAL-DEUDA:" SKIP.
PUT "~{Total de su deuda vencida al " STRING(has_fecha) ": " tot_saldo  "~}" SKIP.

OUTPUT CLOSE.

OS-COPY    VALUE(".\prl\modelo-reclamo.memo") VALUE(".\prl\reclamo-deuda.memo").
OS-APPEND  VALUE(que_archivo)                 VALUE(".\prl\reclamo-deuda.memo").

   /* Levanta los parametros y los mueve a variables */

{CARGATEXTOS.I "'RECLLYFE'" "v-lugar-y-fecha"}
{CARGATEXTOS.I "'RECLFIRM'" "v-firma"}
{CARGATEXTOS.I "'RECLCARG'" "v-cargo"}
{CARGATEXTOS.I "'RECLPEMP'" "v-por-empresa"}

v-params = "p-empresa=" + Empresa.nombre + "~n" +
           "p-lugar-y-fecha=" + v-lugar-y-fecha + "~n" +
           "p-firma=" + v-firma + "~n" +
           "p-cargo=" + v-cargo + "~n" +
           "p-por-empresa=" + v-por-empresa + "~n".

v-filtro = "Cliente.cdg_cliente = '" + Cliente.cdg_cliente + "'" + 
           " AND Domicilio.nro_domicilio = 1".

RUN exreport.p (  INPUT  ".\prl\sic.prl",            /* Librería desde la que se ejecuta */
                  INPUT "Reclamo de deuda",          /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                   /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  v-params                    /* Parametros de Ejecucion          */
               )   

