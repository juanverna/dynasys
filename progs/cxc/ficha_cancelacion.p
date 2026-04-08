/*====================================================================================*/
/*                   FICHA INTEGRAL DE DEUDA DE UN CLIENTE DADO                       */
/*====================================================================================*/

DEFINE INPUT PARAMETER rid_cliente AS ROWID.
/*DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.nro_moneda.*/

/*====================================================================================*/
/*                                 VARIABLES                                          */
/*====================================================================================*/

{dfvarimp.i}
{wglistar.i}
{parlocales.i}

DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Total!Deuda".
DEFINE VARIABLE saldo_hi    AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Saldo!Histórico".
DEFINE VARIABLE saldo_an    AS DECIMAL FORMAT "->,>>>,>>>,>>9.99" COLUMN-LABEL "Saldo!Analítico".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE BUFFER B-Cta_cte FOR Cta_cte.

DEFINE FRAME frm-titulo HEADER
  que_empresa  
  "Ficha de Cancelacion de Deuda" AT 50
  "Página:" AT 110 PAGE-NUMBER FORMAT ">>9" AT 119
  SKIP
  fecha_lis
  "Importes en" AT 50
  desc_moneda NO-LABEL
  hora_lis AT 110
  SKIP(1)
  "Cliente: " AT 50
  que_cuenta
  SKIP(1)
  WITH WIDTH 300 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cta_cte.tip_comprob       COLUMN-LABEL "Ti-!po"
  Cta_cte.prf_comprob       COLUMN-LABEL "Pre-!fijo" FORMAT "9999"
  Cta_cte.nro_comprob       COLUMN-LABEL "Número!Compbte."
  Cta_cte.nro_vencimiento   COLUMN-LABEL "Nro!Ven"   FORMAT "9"
  Cta_cte.fecha_emision     COLUMN-LABEL "Fecha!Emisión"
  Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencmto."
  Imputacion.abrevia        COLUMN-LABEL "Con-!cepto"
  Cta_cte.debito            COLUMN-LABEL "Importe!Débitos"  FORMAT "->,>>>,>>>,>>9.99"
  Cta_cte.credito           COLUMN-LABEL "Importe!Créditos" FORMAT "->,>>>,>>>,>>9.99"
  saldo_hi                  COLUMN-LABEL "Saldo!Histórico"
  saldo_an                  COLUMN-LABEL "Saldo!Analítico"
  WITH WIDTH 300 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*====================================================================================*/
/*                            BLOQUE PRINCIPAL                                        */
/*====================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
FIND Cliente WHERE ROWID(Cliente) = rid_cliente.
que_cuenta = Cliente.cdg_cliente + " - " + Cliente.nom_cliente.

{dirprinfile.i}

DO WITH FRAME frm-listado:

   ASSIGN debito   = 0
          credito  = 0
          saldo_hi = 0
          saldo_an = 0.

   FOR EACH Cta_cte OF Cliente NO-LOCK
       WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa,
             EACH Imputacion OF Cta_cte, FIRST Moneda OF Cta_cte NO-LOCK,
                  FIRST Tipocomprobante OF Cta_cte
                  BY Cta_cte.fecha_emision:

       VIEW FRAME frm-titulo.

       saldo_an = saldo_an - Cta_cte.credito + Cta_cte.debito.
      
       IF Tipocomprobante.debita
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
               Cta_cte.debito   WHEN Tipocomprobante.debita
               Cta_cte.credito  WHEN NOT Tipocomprobante.debita
               WITH FRAME frm-listado.
        
       DOWN WITH FRAME frm-listado.

       IF Tipocomprobante.debita
       THEN DO: /* Facturas y N.Deb */

            FOR EACH Aplicacion_pagos 
                WHERE Aplicacion_pagos.cdg_empresa      = Cta_cte.cdg_empresa
                  AND Aplicacion_pagos.tip_cancela      = Cta_cte.tip_comprob
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
                WHERE Aplicacion_pagos.cdg_empresa      = Cta_cte.cdg_empresa
                  AND Aplicacion_pagos.tip_comprob      = Cta_cte.tip_comprob
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

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22).


