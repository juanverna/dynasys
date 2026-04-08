/*====================================================================================*/
/*           IMPRIME UNA FICHA DE CUENTA CORRIENTE PARA UN CLIENTE DADO               */
/*====================================================================================*/

DEFINE INPUT PARAMETER rid_cliente AS ROWID.
DEFINE INPUT PARAMETER mon_act AS ROWID.
DEFINE INPUT PARAMETER des_fecha AS DATE.
DEFINE INPUT PARAMETER has_fecha AS DATE.

/*====================================================================================*/
/*                                     VARIABLES                                      */
/*====================================================================================*/

{VPERSINM.I}
{VRSHARED.I}

DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE v-saldo     AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE v-saldo-ant AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE v-credito   AS DECIMAL.
DEFINE VARIABLE v-debito    AS DECIMAL.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE que_archivo AS CHARACTER.
DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE hubo_inicio AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Ficha de deuda" AT 38
  has_fecha
  "Página:" AT 95 PAGE-NUMBER FORMAT ">>9" AT 102
  SKIP 
  fecha_lis
  "Importes en" AT 38
  desc_moneda NO-LABEL
  hora_lis AT 95
  SKIP(1)
  "Cuenta: " AT 38
  que_cuenta
  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

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
  v-saldo COLUMN-LABEL "Saldo"
  Cta_cte.leyenda
         WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


/*====================================================================================*/
/*                                  BLOQUE PRINCIPAL                                  */
/*====================================================================================*/

FIND Moneda  WHERE ROWID(Moneda)  = mon_act         NO-LOCK.
FIND Cliente WHERE ROWID(Cliente) = rid_cliente     NO-LOCK.

{findempresa.i}
que_empresa = Empresa.nombre.
que_cuenta = Cliente.cdg_cliente + " - " + Cliente.nom_cliente.
desc_moneda = Moneda.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

ASSIGN v-debito    = 0
       v-credito   = 0
       v-saldo     = 0
       v-saldo-ant = 0
       tot_saldo = 0
       hubo_inicio = NO.

{SETIMPRE.I}

que_archivo = dire_tmp + "IMPFICHA.TXT".
OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72. 

RUN PONE_CODIGO (INPUT "NEGRITNO").

DO WITH FRAME frm-listado:
   FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                 AND Cta_cte.credito <> Cta_cte.debito
                                 AND Cta_cte.fecha_vencimiento <= has_fecha
                                 AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
                                EACH Imputacion OF Cta_cte
                                  BY Cta_cte.fecha_emision:


      VIEW FRAME frm-titulo.

      v-credito = v-credito + Cta_cte.credito.
      v-debito = v-debito + Cta_cte.debito.
      v-saldo = v-debito - v-credito.
      
      IF Cta_cte.fecha_emision >= des_fecha
         AND NOT hubo_inicio
      THEN DO:
            DISPLAY "Saldo Inicial" @ Cta_cte.credito
                            v-saldo-ant @ v-saldo WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.
            hubo_inicio = YES.
      END.

      IF Cta_cte.fecha_emision >= des_fecha
         THEN DISPLAY   Cta_cte.cdg_empresa
                        Cta_cte.tip_comprob
                        Cta_cte.prf_comprob
                        Cta_cte.nro_comprob
                        Imputacion.abrevia
                        Cta_cte.nro_vencimiento
                        Cta_cte.fecha_emision
                        Cta_cte.fecha_vencimiento
                        Cta_cte.debito
                        Cta_cte.credito  
                        v-saldo
                        Cta_cte.leyenda  
                        WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.
      
      v-saldo-ant = v-saldo.

   END.

/* RUN PONE_CODIGO (INPUT "NEGRITNO"). */

   UNDERLINE Cta_cte.tip_comprob
             Cta_cte.prf_comprob
             Cta_cte.nro_comprob
             Imputacion.abrevia
             Cta_cte.nro_vencimiento
             Cta_cte.fecha_emision
             Cta_cte.fecha_vencimiento
             Cta_cte.debito
             Cta_cte.credito
             v-saldo 
             Cta_cte.leyenda  
             WITH FRAME frm-listado.
   DISPLAY "Tot.Cliente" @ Cta_cte.credito
               tot_saldo @ v-saldo WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.

   UNDERLINE Cta_cte.tip_comprob
             Cta_cte.prf_comprob
             Cta_cte.nro_comprob
             Imputacion.abrevia
             Cta_cte.nro_vencimiento
             Cta_cte.fecha_emision
             Cta_cte.fecha_vencimiento
             Cta_cte.debito
             Cta_cte.credito
             v-saldo 
             Cta_cte.leyenda  
             WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
END.

OUTPUT CLOSE.
RUN PROPRINT.P ( INPUT que_archivo ).

{CODIMPRE.I}
 
