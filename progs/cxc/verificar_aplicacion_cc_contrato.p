/*====================================================================================*/
/*                   FICHA INTEGRAL DE DEUDA DE UN contrato_hd DADO                       */
/*====================================================================================*/

DEFINE INPUT PARAMETER rid_contrato_hd AS ROWID.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.nro_moneda.

/*====================================================================================*/
/*                                 VARIABLES                                          */
/*====================================================================================*/

{parlocales.i}
{dfvarimp.i}
{wglistar.i}

DEFINE VARIABLE x-diferencia AS DECIMAL.
DEFINE VARIABLE x-aplicado   AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Saldo!Analítico".


DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.
DEFINE VARIABLE str_debitan AS CHARACTER INITIAL "F*,D*". 

DEFINE BUFFER B-Cta_cte FOR Cta_cte.

DEFINE FRAME frm-titulo HEADER
  que_empresa  
  "Ficha Integrada de Deuda" AT 50
  "Página:" AT 129 PAGE-NUMBER FORMAT ">>9" AT 138
  SKIP
  fecha_lis
  "Importes en" AT 50
  desc_moneda NO-LABEL
  hora_lis AT 129
  SKIP(1)
  "contrato_hd: " AT 50
  que_cuenta
  SKIP(1)
  WITH WIDTH 150 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cta_cte.tip_comprob COLUMN-LABEL "Ti-!po"
  Cta_cte.prf_comprob FORMAT "9999" COLUMN-LABEL "Pre-!fijo"
  Cta_cte.nro_comprob COLUMN-LABEL "Número!Compbte."
  Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "Nro!Ven"
  Cta_cte.fecha_emision  COLUMN-LABEL "Fecha!Emisión"
  Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencmto."
  Cta_cte.debito COLUMN-LABEL "Importe!Débitos"
  Cta_cte.credito COLUMN-LABEL "Importe!Créditos"
  x-aplicado COLUMN-LABEL "Importe!Aplicado"
  x-diferencia COLUMN-LABEL "Importe!Diferencia"
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*====================================================================================*/
/*                            BLOQUE PRINCIPAL                                        */
/*====================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
FIND contrato_hd WHERE ROWID(contrato_hd) = rid_contrato_hd.
FIND Moneda WHERE Moneda.nro_moneda = que_moneda.
que_cuenta = string(contrato_hd.nro_contrato) + " - " + contrato_hd.titulo.
desc_moneda = Moneda.descripcion.

{dirprinfile.i}

DO WITH FRAME frm-listado:


   FOR EACH Cta_cte OF contrato_hd WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                 AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                     BY Cta_cte.fecha_emision:

       VIEW FRAME frm-titulo.
/*

       DISPLAY Cta_cte.tip_comprob
               Cta_cte.prf_comprob
               Cta_cte.nro_comprob
               Cta_cte.nro_vencimiento
               Cta_cte.fecha_emision
               Cta_cte.fecha_vencimiento
               Cta_cte.debito   WHEN CAN-DO(str_debitan,Cta_cte.tip_comprob)
               Cta_cte.credito  WHEN NOT CAN-DO(str_debitan,Cta_cte.tip_comprob)
               WITH FRAME frm-listado.
        
       DOWN WITH FRAME frm-listado.
*/

       x-aplicado = 0.

       IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
       THEN DO: /* Facturas y N.Deb */
            
           FOR EACH Aplicacion_pagos 
                WHERE Aplicacion_pagos.cdg_empresa      = Cta_cte.cdg_empresa
                  AND Aplicacion_pagos.tip_cancela      = Cta_cte.tip_comprob
                  AND Aplicacion_pagos.prf_cancela      = Cta_cte.prf_comprob
                  AND Aplicacion_pagos.nro_cancela      = Cta_cte.nro_comprob
                  AND Aplicacion_pagos.nro_ven_cancela  = Cta_cte.nro_vencimiento,
                  FIRST B-Cta_cte OF contrato_hd
                       WHERE B-Cta_cte.tip_comprob     = Aplicacion_pagos.tip_comprob
                         AND B-Cta_cte.prf_comprob     = Aplicacion_pagos.prf_comprob
                         AND B-Cta_cte.nro_comprob     = Aplicacion_pagos.nro_comprob                  
                         AND B-Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_vencimiento NO-LOCK
                             BY B-Cta_cte.fecha_vencimiento:

               x-aplicado = x-aplicado + Aplicacion_pagos.importe.
                 

            END. /* De recorrer la aplicacion de pagos */

            IF x-aplicado <> Cta_cte.credito
            THEN DO:
                x-diferencia = x-aplicado - Cta_cte.credito.
                DISPLAY Cta_cte.tip_comprob 
                        Cta_cte.prf_comprob 
                        Cta_cte.nro_comprob 
                        Cta_cte.nro_vencimiento 
                        Cta_cte.fecha_emision  
                        Cta_cte.fecha_vencimiento 
                        Cta_cte.debito 
                        Cta_cte.credito
                        x-aplicado 
                        x-diferencia
                        WITH FRAME frm-listado.
                DOWN 2 WITH FRAME frm-listado.
            END.



       END. /* De poner aplicacion de Facturas y Notas de debito */
       ELSE DO: /* O/Pago y Notas de Credito */

            FOR EACH Aplicacion_pagos 
                WHERE Aplicacion_pagos.cdg_empresa      = Cta_cte.cdg_empresa
                  AND Aplicacion_pagos.tip_comprob      = Cta_cte.tip_comprob
                  AND Aplicacion_pagos.prf_comprob      = Cta_cte.prf_comprob
                  AND Aplicacion_pagos.nro_comprob      = Cta_cte.nro_comprob
                  AND Aplicacion_pagos.nro_vencimiento  = Cta_cte.nro_vencimiento,
                  FIRST B-Cta_cte OF contrato_hd
                       WHERE B-Cta_cte.tip_comprob     = Aplicacion_pagos.tip_cancela
                         AND B-Cta_cte.prf_comprob     = Aplicacion_pagos.prf_cancela
                         AND B-Cta_cte.nro_comprob     = Aplicacion_pagos.nro_cancela                  
                         AND B-Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_ven_cancela NO-LOCK
                             BY B-Cta_cte.fecha_vencimiento:


                x-aplicado = x-aplicado + Aplicacion_pagos.importe.
                  

            END. /* De recorrer la aplicacion de pagos */

            IF x-aplicado <> Cta_cte.debito
            THEN DO:
                x-diferencia = x-aplicado - Cta_cte.debito.
                DISPLAY Cta_cte.tip_comprob 
                        Cta_cte.prf_comprob 
                        Cta_cte.nro_comprob 
                        Cta_cte.nro_vencimiento 
                        Cta_cte.fecha_emision  
                        Cta_cte.fecha_vencimiento 
                        Cta_cte.debito 
                        Cta_cte.credito
                        x-aplicado 
                        x-diferencia
                        WITH FRAME frm-listado.
                DOWN 2 WITH FRAME frm-listado.
            END.

       END. /* De poner aplicacion de O/Pago */     

   END.

   UNDERLINE 
              Cta_cte.tip_comprob
              Cta_cte.prf_comprob
              Cta_cte.nro_comprob
              Cta_cte.nro_vencimiento
              Cta_cte.fecha_emision
              Cta_cte.fecha_vencimiento
              Cta_cte.debito
              Cta_cte.credito
              x-aplicado
              x-diferencia
              WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22).


