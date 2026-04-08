
/*====================================================================================*/
/* Imprime una ficha integral de Deuda de un Prov., pasando ROWID Prov./Moneda        */
/*====================================================================================*/

DEFINE INPUT PARAMETER prv_act AS ROWID.
DEFINE INPUT PARAMETER mon_act AS ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE SHARED VARIABLE ver_antes    AS INTEGER.

DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Total!Deuda".
DEFINE VARIABLE saldo_hi    AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Saldo!Histórico".
DEFINE VARIABLE saldo_an    AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Saldo!Analítico".
DEFINE VARIABLE saldo_nt    AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Saldo Ex!Retencion".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE BUFFER B-Cta_cte_prv FOR Cta_cte_prv.

DEFINE FRAME frm-titulo HEADER
  que_empresa  
  "Ficha Integrada de Deuda" AT 50
  "Pagina:" AT 129 PAGE-NUMBER FORMAT ">>9" AT 138
  SKIP
  fecha_lis
  "Importes en" AT 50
  desc_moneda NO-LABEL
  hora_lis AT 129
  SKIP(1)
  "Proveedor: " AT 50
  que_cuenta
  SKIP(1)
  WITH WIDTH 150 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cta_cte_prv.tip_comprob COLUMN-LABEL "Tip!Com."
  Cta_cte_prv.prf_comprob FORMAT "9999" COLUMN-LABEL "Pto.!Vta."
  Cta_cte_prv.nro_comprob COLUMN-LABEL "Número!Compbte."
  Cta_cte_prv.nro_vencimiento FORMAT "9" COLUMN-LABEL "N!V"
  Cta_cte_prv.fecha_emision  COLUMN-LABEL "Fecha!Emisión"
  Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Fecha!Vencmto."
  Imputacion.abrevia COLUMN-LABEL "Cpto.!Docum."
  Cta_cte_prv.debito
  Cta_cte_prv.credito
  saldo_hi
  saldo_an  
  /*
  Cta_cte_prv.imp_retibr
  Cta_cte_prv.imp_retiva
  saldo_nt 
  */
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FIND Empresa   WHERE ROWID(Empresa) = act_empresa   NO-LOCK.
FIND Moneda    WHERE ROWID(Moneda)  = mon_act       NO-LOCK.
FIND Proveedor WHERE ROWID(Proveedor) = prv_act     NO-LOCK.

que_empresa = Empresa.nombre.
que_cuenta = Proveedor.cdg_Proveedor + " - " + Proveedor.nombre.
desc_moneda = Moneda.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

{SETIMPRE.I}

OUTPUT TO VALUE(dire_tmp + "impfintg.txt") PAGED.

RUN PONE_CODIGO (INPUT "HORIZONT,SET12CPI").

DO WITH FRAME frm-listado:

   ASSIGN debito   = 0
          credito  = 0
          saldo_hi = 0
          saldo_an = 0
          saldo_nt = 0.

   FOR EACH Cta_cte_prv OF Proveedor WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda,
                                EACH Imputacion OF Cta_cte_prv
                                  BY Cta_cte_prv.fecha_emision:

       VIEW FRAME frm-titulo.

       saldo_an = saldo_an + Cta_cte_prv.credito - Cta_cte_prv.debito.
       saldo_nt = saldo_nt + Cta_cte_prv.credito - Cta_cte_prv.debito -
                             Cta_cte_prv.imp_retiva + Cta_cte_prv.imp_retibr.
      
       IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
       THEN DO:
            saldo_hi  = saldo_hi + Cta_cte_prv.debito.
       END.     
       ELSE DO:
            saldo_hi = saldo_hi - Cta_cte_prv.credito.
       END.     

       DISPLAY Cta_cte_prv.tip_comprob
               Cta_cte_prv.prf_comprob
               Cta_cte_prv.nro_comprob
               Imputacion.abrevia
               Cta_cte_prv.nro_vencimiento
               Cta_cte_prv.fecha_emision
               Cta_cte_prv.fecha_vencimiento
               Cta_cte_prv.debito   WHEN LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv)  <> 0
               Cta_cte_prv.credito  WHEN LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv)  =  0
               WITH FRAME frm-listado.
        
       DOWN WITH FRAME frm-listado.

       IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
        THEN DO: /* O/Pago y Notas de Credito */

            FOR EACH Aplicacion_pagos_prv 
                WHERE Aplicacion_pagos_prv.nro_proveedor    = Cta_cte_prv.nro_proveedor
                  AND Aplicacion_pagos_prv.tip_cancela      = Cta_cte_prv.tip_comprob
                  AND Aplicacion_pagos_prv.prf_cancela      = Cta_cte_prv.prf_comprob
                  AND Aplicacion_pagos_prv.nro_cancela      = Cta_cte_prv.nro_comprob
                  AND Aplicacion_pagos_prv.nro_ven_cancela  = Cta_cte_prv.nro_vencimiento /*,
                  FIRST B-Cta_cte_prv OF Proveedor
                       WHERE B-Cta_cte_prv.tip_comprob     = Aplicacion_pagos_prv.tip_comprob
                         AND B-Cta_cte_prv.prf_comprob     = Aplicacion_pagos_prv.prf_comprob
                         AND B-Cta_cte_prv.nro_comprob     = Aplicacion_pagos_prv.nro_comprob                  
                         AND B-Cta_cte_prv.nro_vencimiento = Aplicacion_pagos_prv.nro_vencimiento NO-LOCK
                             BY B-Cta_cte_prv.fecha_vencimiento */:

                  DISPLAY 
                         Aplicacion_pagos_prv.tip_comprob       @ Cta_cte_prv.tip_comprob
                         Aplicacion_pagos_prv.prf_comprob       @ Cta_cte_prv.prf_comprob
                         Aplicacion_pagos_prv.nro_comprob       @ Cta_cte_prv.nro_comprob           
                         Aplicacion_pagos_prv.nro_vencimiento   @ Cta_cte_prv.nro_vencimiento
                         /*Aplicacion_pagos_prv.fecha_vencimiento @ Cta_cte_prv.fecha_vencimiento*/
                         Aplicacion_pagos_prv.importe    @ Cta_cte_prv.credito
                         WITH FRAME frm-listado.
                  
                  DOWN WITH FRAME frm-listado.       

            END. /* De recorrer la aplicacion de pagos */

            DOWN WITH FRAME frm-listado.

            UNDERLINE 
                   Cta_cte_prv.debito   
                   Cta_cte_prv.credito  
                   WITH FRAME frm-listado.
               
            DISPLAY 
                   Cta_cte_prv.credito - Cta_cte_prv.debito @ Cta_cte_prv.debito   
                   Cta_cte_prv.credito 
                   saldo_hi
                   saldo_an
                   Cta_cte_prv.imp_retibr
                   Cta_cte_prv.imp_retiva 
                   saldo_nt                           
                   WITH FRAME frm-listado.

            DOWN 2 WITH FRAME frm-listado.

       END. /* De poner aplicacion de Facturas y Notas de debito */
       ELSE DO: /* Facturas y N.Deb */ 

            FOR EACH Aplicacion_pagos_prv 
                WHERE Aplicacion_pagos_prv.nro_proveedor    = Cta_cte_prv.nro_proveedor
                  AND Aplicacion_pagos_prv.tip_comprob      = Cta_cte_prv.tip_comprob
                  AND Aplicacion_pagos_prv.prf_comprob      = Cta_cte_prv.prf_comprob
                  AND Aplicacion_pagos_prv.nro_comprob      = Cta_cte_prv.nro_comprob
                  AND Aplicacion_pagos_prv.nro_vencimiento  = Cta_cte_prv.nro_vencimiento /*,
                  FIRST B-Cta_cte_prv OF Proveedor
                       WHERE B-Cta_cte_prv.tip_comprob     = Aplicacion_pagos_prv.tip_cancela
                         AND B-Cta_cte_prv.prf_comprob     = Aplicacion_pagos_prv.prf_cancela
                         AND B-Cta_cte_prv.nro_comprob     = Aplicacion_pagos_prv.nro_cancela                  
                         AND B-Cta_cte_prv.nro_vencimiento = Aplicacion_pagos_prv.nro_ven_cancela NO-LOCK
                             BY B-Cta_cte_prv.fecha_vencimiento */:

                  DISPLAY 
                         Aplicacion_pagos_prv.tip_cancela       @ Cta_cte_prv.tip_comprob
                         Aplicacion_pagos_prv.prf_cancela       @ Cta_cte_prv.prf_comprob
                         Aplicacion_pagos_prv.nro_cancela       @ Cta_cte_prv.nro_comprob           
                         Aplicacion_pagos_prv.nro_vencimiento   @ Cta_cte_prv.nro_vencimiento
/*                       Aplicacion_pagos_prv.fecha_vencimiento @ Cta_cte_prv.fecha_vencimiento*/
                         Aplicacion_pagos_prv.importe    @ Cta_cte_prv.debito
                         WITH FRAME frm-listado.
                  
                  DOWN WITH FRAME frm-listado.       

            END. /* De recorrer la aplicacion de pagos */

            DOWN WITH FRAME frm-listado.

            UNDERLINE 
                   Cta_cte_prv.debito   
                   Cta_cte_prv.credito  
                   WITH FRAME frm-listado.
               
            DISPLAY 
                   Cta_cte_prv.debito 
                   Cta_cte_prv.credito - Cta_cte_prv.debito @ Cta_cte_prv.credito   
                   saldo_hi
                   saldo_an
                   Cta_cte_prv.imp_retibr
                   Cta_cte_prv.imp_retiva                            
                   saldo_nt                           
                   WITH FRAME frm-listado.

           DOWN 2 WITH FRAME frm-listado.

       END. /* De poner aplicacion de O/Pago */     

   END.

   UNDERLINE 
              Cta_cte_prv.tip_comprob
              Cta_cte_prv.prf_comprob
              Cta_cte_prv.nro_comprob
              Imputacion.abrevia
              Cta_cte_prv.nro_vencimiento
              Cta_cte_prv.fecha_emision
              Cta_cte_prv.fecha_vencimiento
              Cta_cte_prv.debito
              Cta_cte_prv.credito
              saldo_hi
              saldo_an
              Cta_cte_prv.imp_retibr
              Cta_cte_prv.imp_retiva
              saldo_nt
              WITH FRAME frm-listado.

   DISPLAY "Saldos" @ Cta_cte_prv.credito
           saldo_hi
           saldo_an
           saldo_nt
           WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.

   UNDERLINE 
              Cta_cte_prv.tip_comprob
              Cta_cte_prv.prf_comprob
              Cta_cte_prv.nro_comprob
              Imputacion.abrevia
              Cta_cte_prv.nro_vencimiento
              Cta_cte_prv.fecha_emision
              Cta_cte_prv.fecha_vencimiento
              Cta_cte_prv.debito
              Cta_cte_prv.credito
              saldo_hi
              saldo_an
              Cta_cte_prv.imp_retibr
              Cta_cte_prv.imp_retiva
              saldo_nt
              WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

{VERANTES.I "impfintg.txt"}

{CODIMPRE.I}
