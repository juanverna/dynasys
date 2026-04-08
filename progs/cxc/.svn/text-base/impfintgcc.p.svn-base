
/*====================================================================================*/
/* Imprime una ficha integral de Deuda de un Clte., pasando ROWID Clte./Moneda        */
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
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE BUFFER B-Cta_cte FOR Cta_cte.

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
  "Cliente: " AT 50
  que_cuenta
  SKIP(1)
  WITH WIDTH 150 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cta_cte.tip_comprob COLUMN-LABEL "Tip!Com."
  Cta_cte.prf_comprob FORMAT "9999" COLUMN-LABEL "Pto.!Vta."
  Cta_cte.nro_comprob COLUMN-LABEL "Número!Compbte."
  Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "N!V"
  Cta_cte.fecha_emision  COLUMN-LABEL "Fecha!Emisión"
  Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencmto."
  Imputacion.abrevia COLUMN-LABEL "Cpto.!Docum."
  Cta_cte.debito COLUMN-LABEL "Importe!Débitos"
  Cta_cte.credito COLUMN-LABEL "Importe!Créditos"
  saldo_hi
  saldo_an  
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FIND Empresa   WHERE ROWID(Empresa) = act_empresa   NO-LOCK.
FIND Moneda    WHERE ROWID(Moneda)  = mon_act       NO-LOCK.
FIND Cliente WHERE ROWID(Cliente) = prv_act     NO-LOCK.

que_empresa = Empresa.nombre.
que_cuenta = Cliente.cdg_cliente + " - " + Cliente.nom_cliente.
desc_moneda = Moneda.descripcion.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

{SETIMPRE.I}

OUTPUT TO VALUE(dire_tmp + "impfintgcc.txt") PAGED.

RUN PONE_CODIGO (INPUT "HORIZONT,SET12CPI").

DO WITH FRAME frm-listado:

   ASSIGN debito   = 0
          credito  = 0
          saldo_hi = 0
          saldo_an = 0.

   FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda,
                                EACH Imputacion OF Cta_cte
                                  BY Cta_cte.fecha_emision:

       VIEW FRAME frm-titulo.

       saldo_an = saldo_an - Cta_cte.credito + Cta_cte.debito.
      
       IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
       THEN DO:
            saldo_hi  = saldo_hi + Cta_cte.debito.
       END.     
       ELSE DO:
            saldo_hi = saldo_hi - Cta_cte.credito.
       END.     

       DISPLAY Cta_cte.tip_comprob
               Cta_cte.prf_comprob
               Cta_cte.nro_comprob
               Imputacion.abrevia
               Cta_cte.nro_vencimiento
               Cta_cte.fecha_emision
               Cta_cte.fecha_vencimiento
               Cta_cte.debito   WHEN CAN-DO(str_debitan,str_debitan)
               Cta_cte.credito  WHEN NOT CAN-DO(str_debitan,str_debitan)
               WITH FRAME frm-listado.
        
       DOWN WITH FRAME frm-listado.

       IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
       THEN DO: /* Facturas y N.Deb */

            FOR EACH Aplicacion_pagos 
                WHERE Aplicacion_pagos.tip_cancela      = Cta_cte.tip_comprob
                  AND Aplicacion_pagos.prf_cancela      = Cta_cte.prf_comprob
                  AND Aplicacion_pagos.nro_cancela      = Cta_cte.nro_comprob
                  AND Aplicacion_pagos.nro_ven_cancela  = Cta_cte.nro_vencimiento,
                  FIRST B-Cta_cte OF Cliente
                       WHERE B-Cta_cte.tip_comprob     = Aplicacion_pagos.tip_comprob
                         AND B-Cta_cte.prf_comprob     = Aplicacion_pagos.prf_comprob
                         AND B-Cta_cte.nro_comprob     = Aplicacion_pagos.nro_comprob                  
                         AND B-Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_vencimiento NO-LOCK
                             BY B-Cta_cte.fecha_vencimiento:

                  DISPLAY 
                         B-Cta_cte.tip_comprob       @ Cta_cte.tip_comprob
                         B-Cta_cte.prf_comprob       @ Cta_cte.prf_comprob
                         B-Cta_cte.nro_comprob       @ Cta_cte.nro_comprob           
                         B-Cta_cte.nro_vencimiento   @ Cta_cte.nro_vencimiento
                         B-Cta_cte.fecha_vencimiento @ Cta_cte.fecha_vencimiento
                         Aplicacion_pagos.importe    @ Cta_cte.credito
                         WITH FRAME frm-listado.
                  
                  DOWN WITH FRAME frm-listado.       

            END. /* De recorrer la aplicacion de pagos */

            DOWN WITH FRAME frm-listado.

            UNDERLINE 
                   Cta_cte.debito   
                   Cta_cte.credito  
                   WITH FRAME frm-listado.
               
            DISPLAY 
                   Cta_cte.debito - Cta_cte.credito @ Cta_cte.debito   
                   Cta_cte.credito 
                   saldo_hi
                   saldo_an
                   WITH FRAME frm-listado.

            DOWN 2 WITH FRAME frm-listado.

       END. /* De poner aplicacion de Facturas y Notas de debito */
       ELSE DO: /* O/Pago y Notas de Credito */

            FOR EACH Aplicacion_pagos 
                WHERE Aplicacion_pagos.tip_comprob      = Cta_cte.tip_comprob
                  AND Aplicacion_pagos.prf_comprob      = Cta_cte.prf_comprob
                  AND Aplicacion_pagos.nro_comprob      = Cta_cte.nro_comprob
                  AND Aplicacion_pagos.nro_vencimiento  = Cta_cte.nro_vencimiento,
                  FIRST B-Cta_cte OF Cliente
                       WHERE B-Cta_cte.tip_comprob     = Aplicacion_pagos.tip_cancela
                         AND B-Cta_cte.prf_comprob     = Aplicacion_pagos.prf_cancela
                         AND B-Cta_cte.nro_comprob     = Aplicacion_pagos.nro_cancela                  
                         AND B-Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_ven_cancela NO-LOCK
                             BY B-Cta_cte.fecha_vencimiento:

                  DISPLAY 
                         B-Cta_cte.tip_comprob       @ Cta_cte.tip_comprob
                         B-Cta_cte.prf_comprob       @ Cta_cte.prf_comprob
                         B-Cta_cte.nro_comprob       @ Cta_cte.nro_comprob           
                         B-Cta_cte.nro_vencimiento   @ Cta_cte.nro_vencimiento
                         B-Cta_cte.fecha_vencimiento @ Cta_cte.fecha_vencimiento
                         Aplicacion_pagos.importe    @ Cta_cte.debito
                         WITH FRAME frm-listado.
                  
                  DOWN WITH FRAME frm-listado.       

            END. /* De recorrer la aplicacion de pagos */

            DOWN WITH FRAME frm-listado.

            UNDERLINE 
                   Cta_cte.debito   
                   Cta_cte.credito  
                   WITH FRAME frm-listado.
               
            DISPLAY 
                   Cta_cte.debito 
                   Cta_cte.credito - Cta_cte.debito @ Cta_cte.credito   
                   saldo_hi
                   saldo_an
                   WITH FRAME frm-listado.

           DOWN 2 WITH FRAME frm-listado.

       END. /* De poner aplicacion de O/Pago */     

   END.

   UNDERLINE 
              Cta_cte.tip_comprob
              Cta_cte.prf_comprob
              Cta_cte.nro_comprob
              Imputacion.abrevia
              Cta_cte.nro_vencimiento
              Cta_cte.fecha_emision
              Cta_cte.fecha_vencimiento
              Cta_cte.debito
              Cta_cte.credito
              saldo_hi
              saldo_an
              WITH FRAME frm-listado.

   DISPLAY "Saldos" @ Cta_cte.credito
           saldo_hi
           saldo_an
           WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.

   UNDERLINE 
              Cta_cte.tip_comprob
              Cta_cte.prf_comprob
              Cta_cte.nro_comprob
              Imputacion.abrevia
              Cta_cte.nro_vencimiento
              Cta_cte.fecha_emision
              Cta_cte.fecha_vencimiento
              Cta_cte.debito
              Cta_cte.credito
              saldo_hi
              saldo_an
              WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

{VERANTES.I "impfintgcc.txt"}

{CODIMPRE.I}
