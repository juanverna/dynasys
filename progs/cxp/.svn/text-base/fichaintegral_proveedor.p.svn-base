/*====================================================================================*/
/*             IMPRIME UNA FICHA INTEGRAL DE DEUDA DE UN PROVEEDOR DADO               */
/*====================================================================================*/

DEFINE INPUT PARAMETER rid_proveedor AS ROWID.
DEFINE INPUT PARAMETER rid_moneda AS ROWID.

/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/

{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Total!Deuda".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE BUFFER B-Cta_cte_prv FOR Cta_cte_prv.

/*====================================================================================*/
/*                                      FRAMES                                        */
/*====================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa  
  "Ficha Integrada de Deuda por Proveedor" AT 42
  "Página:" AT 90 PAGE-NUMBER FORMAT ">>9" AT 99
  SKIP
  fecha_lis
  "Importes en" AT 42
  desc_moneda NO-LABEL
  hora_lis AT 90
  SKIP(1)
  que_cuenta AT 42
  SKIP(1)
  WITH WIDTH 150 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cta_cte_prv.tip_comprob COLUMN-LABEL "Ti-!po"
  Cta_cte_prv.prf_comprob FORMAT "9999" COLUMN-LABEL "Pre-!fijo"
  Cta_cte_prv.nro_comprob COLUMN-LABEL "Número!Compbte."
  Cta_cte_prv.nro_vencimiento FORMAT ">>9" COLUMN-LABEL "N!V"
  Cta_cte_prv.fecha_emision  COLUMN-LABEL "Fecha!Emisión"
  Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Fecha!Vencmto."
  Imputacion.abrevia COLUMN-LABEL "Con-!cepto"
  Cta_cte_prv.debito
  Cta_cte_prv.credito
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*====================================================================================*/
/*                                    BLOQUE PRINCIPAL                                */
/*====================================================================================*/

{findempresa.i}

FIND Moneda    WHERE ROWID(Moneda)    = rid_moneda       NO-LOCK.
FIND Proveedor WHERE ROWID(Proveedor) = rid_proveedor    NO-LOCK.

que_empresa = Empresa.nombre.
que_cuenta = Proveedor.cdg_Proveedor + " - " + Proveedor.nombre.
desc_moneda = Moneda.descripcion.

{dirprinfile.i}

DO WITH FRAME frm-listado:

   ASSIGN debito   = 0
          credito  = 0.

   FOR EACH Cta_cte_prv OF Proveedor 
       WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda,
             FIRST Imputacion OF Cta_cte_prv NO-LOCK, 
             FIRST Tipocomprobante OF Cta_cte_prv NO-LOCK
                                  BY Cta_cte_prv.fecha_emision:

       VIEW FRAME frm-titulo.

       DISPLAY Cta_cte_prv.tip_comprob
               Cta_cte_prv.prf_comprob
               Cta_cte_prv.nro_comprob
               Imputacion.abrevia
               Cta_cte_prv.nro_vencimiento
               Cta_cte_prv.fecha_emision
               Cta_cte_prv.fecha_vencimiento
               Cta_cte_prv.debito   WHEN Tipocomprobante.debita
               Cta_cte_prv.credito  WHEN NOT Tipocomprobante.debita
               WITH FRAME frm-listado.
        
       DOWN WITH FRAME frm-listado.

       RUN poner_aplicacion.  /* Imprime la cancelación de los comprobantes */

   END.
   
   UNDERLINE  Cta_cte_prv.tip_comprob
              Cta_cte_prv.prf_comprob
              Cta_cte_prv.nro_comprob
              Imputacion.abrevia
              Cta_cte_prv.nro_vencimiento
              Cta_cte_prv.fecha_emision
              Cta_cte_prv.fecha_vencimiento
              Cta_cte_prv.debito
              Cta_cte_prv.credito
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
              WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22 ).

PROCEDURE poner_aplicacion:

    IF NOT Tipocomprobante.debita
    THEN DO: /* Facturas y otras yerbas */

         FOR EACH Aplicacion_pagos_prv 
             WHERE Aplicacion_pagos_prv.nro_proveedor    = Cta_cte_prv.nro_proveedor
               AND Aplicacion_pagos_prv.tip_cancela      = Cta_cte_prv.tip_comprob
               AND Aplicacion_pagos_prv.prf_cancela      = Cta_cte_prv.prf_comprob
               AND Aplicacion_pagos_prv.nro_cancela      = Cta_cte_prv.nro_comprob
               AND Aplicacion_pagos_prv.nro_ven_cancela  = Cta_cte_prv.nro_vencimiento ,
               FIRST B-Cta_cte_prv OF Proveedor
                    WHERE B-Cta_cte_prv.tip_comprob     = Aplicacion_pagos_prv.tip_comprob
                      AND B-Cta_cte_prv.prf_comprob     = Aplicacion_pagos_prv.prf_comprob
                      AND B-Cta_cte_prv.nro_comprob     = Aplicacion_pagos_prv.nro_comprob                  
                      AND B-Cta_cte_prv.nro_vencimiento = Aplicacion_pagos_prv.nro_vencimiento NO-LOCK
                          BY B-Cta_cte_prv.fecha_vencimiento :

               DISPLAY 
                      B-Cta_cte_prv.tip_comprob       @ Cta_cte_prv.tip_comprob
                      B-Cta_cte_prv.prf_comprob       @ Cta_cte_prv.prf_comprob
                      B-Cta_cte_prv.nro_comprob       @ Cta_cte_prv.nro_comprob           
                      B-Cta_cte_prv.nro_vencimiento   @ Cta_cte_prv.nro_vencimiento
                      B-Cta_cte_prv.fecha_emision     @ Cta_cte_prv.fecha_emision
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
                WITH FRAME frm-listado.

         DOWN 2 WITH FRAME frm-listado.

    END. /* De poner aplicacion de Facturas y Notas de debito */
    ELSE DO: /* O/Pago y otras yerbas */ 

         FOR EACH Aplicacion_pagos_prv 
             WHERE Aplicacion_pagos_prv.nro_proveedor    = Cta_cte_prv.nro_proveedor
               AND Aplicacion_pagos_prv.tip_comprob      = Cta_cte_prv.tip_comprob
               AND Aplicacion_pagos_prv.prf_comprob      = Cta_cte_prv.prf_comprob
               AND Aplicacion_pagos_prv.nro_comprob      = Cta_cte_prv.nro_comprob
               AND Aplicacion_pagos_prv.nro_vencimiento  = Cta_cte_prv.nro_vencimiento ,
               FIRST B-Cta_cte_prv OF Proveedor
                    WHERE B-Cta_cte_prv.tip_comprob     = Aplicacion_pagos_prv.tip_cancela
                      AND B-Cta_cte_prv.prf_comprob     = Aplicacion_pagos_prv.prf_cancela
                      AND B-Cta_cte_prv.nro_comprob     = Aplicacion_pagos_prv.nro_cancela                  
                      AND B-Cta_cte_prv.nro_vencimiento = Aplicacion_pagos_prv.nro_ven_cancela NO-LOCK
                          BY B-Cta_cte_prv.fecha_vencimiento:

               DISPLAY 
                      B-Cta_cte_prv.tip_comprob       @ Cta_cte_prv.tip_comprob
                      B-Cta_cte_prv.prf_comprob       @ Cta_cte_prv.prf_comprob
                      B-Cta_cte_prv.nro_comprob       @ Cta_cte_prv.nro_comprob           
                      B-Cta_cte_prv.nro_vencimiento   @ Cta_cte_prv.nro_vencimiento
                      B-Cta_cte_prv.fecha_emision     @ Cta_cte_prv.fecha_emision
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
                Cta_cte_prv.debito - Cta_cte_prv.credito @ Cta_cte_prv.debito 
                Cta_cte_prv.credito   
                WITH FRAME frm-listado.

        DOWN 2 WITH FRAME frm-listado.

    END. /* De poner aplicacion de O/Pago */     

END PROCEDURE.
