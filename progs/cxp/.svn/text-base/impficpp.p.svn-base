/*====================================================================================*/
/* Imprime una ficha de Deuda de un Prov., pasando ROWID Prov./Moneda y has.fecha     */
/*====================================================================================*/

DEFINE INPUT PARAMETER prv_act AS ROWID.
DEFINE INPUT PARAMETER mon_act AS ROWID.
DEFINE INPUT PARAMETER has_fecha AS DATE.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Ficha Resumen de Deuda, al" AT 23
    has_fecha
    "Pagina:" AT 69 PAGE-NUMBER FORMAT ">>9" AT 76
    SKIP
    fecha_lis
    "Importes en" AT 23
    desc_moneda NO-LABEL
    hora_lis AT 69
    SKIP(1)
    "Cuenta: " AT 23
    que_cuenta
    SKIP(1)
    WITH WIDTH 81 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Cta_cte_prv.tip_comprob
    SPACE(1)
    Cta_cte_prv.prf_comprob FORMAT "9999"
    SPACE(1)
    Cta_cte_prv.nro_comprob FORMAT "ZZZZZZZ9"
    SPACE(1)
    Cta_cte_prv.nro_vencimiento FORMAT "9" COLUMN-LABEL "V"
    SPACE(1)
    Cta_cte_prv.fecha_emision
    SPACE(1)
    Cta_cte_prv.fecha_vencimiento
    SPACE(1)
    Imputacion.abrevia COLUMN-LABEL "Cpto."
    SPACE(1)
    Cta_cte_prv.debito
    SPACE(1)
    Cta_cte_prv.credito
    SPACE(1)
    saldo COLUMN-LABEL "Saldo"
    WITH WIDTH 80 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


FIND Empresa   WHERE ROWID(Empresa) = act_empresa   NO-LOCK.
FIND Moneda    WHERE ROWID(Moneda)  = mon_act       NO-LOCK.
FIND Proveedor WHERE ROWID(Proveedor) = prv_act     NO-LOCK.

que_empresa = Empresa.nombre.
que_cuenta = STRING(Proveedor.cdg_Proveedor, ">>>>>9") + " - " + Proveedor.nombre.
desc_moneda = Moneda.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

ASSIGN debito    = 0
       credito   = 0
       saldo     = 0
       tot_saldo = 0.

{SETIMPRE.I}

OUTPUT TO value(port) PAGED.

RUN PONE_CODIGO (INPUT "NEGRITSI").

DO WITH FRAME frm-listado:
   FOR EACH Cta_cte_prv OF Proveedor WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda
                                   /*  AND Cta_cte_prv.credito <> Cta_cte_prv.debito*/
                                       AND Cta_cte_prv.fecha_emision <= has_fecha,
                                      EACH Imputacion OF Cta_cte_prv
                                        BY Cta_cte_prv.fecha_emision:

       ASSIGN debito  = 0
              credito = 0
              saldo   = 0.

      credito = credito + Cta_cte_prv.credito.
      debito = debito + Cta_cte_prv.debito.
      saldo = credito - debito.

      tot_saldo = tot_saldo + saldo.

      VIEW FRAME frm-titulo.

      DISPLAY Cta_cte_prv.tip_comprob
              Cta_cte_prv.prf_comprob
              Cta_cte_prv.nro_comprob
              Imputacion.abrevia
              Cta_cte_prv.nro_vencimiento
              Cta_cte_prv.fecha_emision
              Cta_cte_prv.fecha_vencimiento
              Cta_cte_prv.debito
              Cta_cte_prv.credito
              saldo
              WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.

   END.

   RUN PONE_CODIGO (INPUT "NEGRITNO").

   UNDERLINE Cta_cte_prv.tip_comprob
             Cta_cte_prv.prf_comprob
             Cta_cte_prv.nro_comprob
             Imputacion.abrevia
             Cta_cte_prv.nro_vencimiento
             Cta_cte_prv.fecha_emision
             Cta_cte_prv.fecha_vencimiento
             Cta_cte_prv.debito
             Cta_cte_prv.credito
             saldo WITH FRAME frm-listado.
   DISPLAY "Tot.Proveedor" @ Cta_cte_prv.credito
               tot_saldo @ saldo WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.

   UNDERLINE Cta_cte_prv.tip_comprob
             Cta_cte_prv.prf_comprob
             Cta_cte_prv.nro_comprob
             Imputacion.abrevia
             Cta_cte_prv.nro_vencimiento
             Cta_cte_prv.fecha_emision
             Cta_cte_prv.fecha_vencimiento
             Cta_cte_prv.debito
             Cta_cte_prv.credito
             saldo WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
END.

OUTPUT CLOSE.

{CODIMPRE.I}
