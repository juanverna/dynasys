/*====================================================================================*/
/*                   FICHA INTEGRAL DE DEUDA DE UN CLIENTE DADO                       */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_cliente LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_cliente LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER que_fecha   AS DATE.

/*====================================================================================*/
/*                                 VARIABLES                                          */
/*====================================================================================*/

DEFINE TEMP-TABLE T-Ficha
  FIELD cdg_cliente            LIKE Cliente.cdg_cliente       COLUMN-LABEL "Código!Cliente"
  FIELD tipo_registro          AS INTEGER /* 1 es el documento, 2 es la cancelacion */
  FIELD tip_comprob            LIKE Cta_cte.tip_comprob       COLUMN-LABEL "Ti-!po"
  FIELD prf_comprob            LIKE Cta_cte.prf_comprob       COLUMN-LABEL "Pre-!fijo" FORMAT "9999"
  FIELD nro_comprob            LIKE Cta_cte.nro_comprob       COLUMN-LABEL "Número!Compbte."
  FIELD nro_vencimiento        LIKE Cta_cte.nro_vencimiento   COLUMN-LABEL "Nro!Ven"
  FIELD abrevia                LIKE Imputacion.abrevia        COLUMN-LABEL "Con-!cepto"
  FIELD fecha_emision          LIKE Cta_cte.fecha_emision     COLUMN-LABEL "Fecha!Emisión"
  FIELD debito                 LIKE Cta_cte.debito            COLUMN-LABEL "Importe!Débitos"
  FIELD credito                LIKE Cta_cte.credito           COLUMN-LABEL "Importe!Créditos"
  FIELD fecha_cancelacion      LIKE Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Pago"
  FIELD tip_cancela            LIKE Cta_cte.tip_comprob       COLUMN-LABEL "Ti-!po"
  FIELD prf_cancela            LIKE Cta_cte.prf_comprob       COLUMN-LABEL "Pre-!fijo" FORMAT "9999"
  FIELD nro_cancela            LIKE Cta_cte.nro_comprob       COLUMN-LABEL "Número!Compbte."
  FIELD nro_vencancela         LIKE Cta_cte.nro_vencimiento   COLUMN-LABEL "Nro!Ven"
  FIELD imp_cancela            LIKE Cta_cte.debito            COLUMN-LABEL "Saldo!Histórico"
  FIELD saldo_an               LIKE Cta_cte.debito            COLUMN-LABEL "Saldo!Analítico"
  INDEX i-cdg_cliente 
      IS PRIMARY cdg_cliente fecha_emision tip_comprob prf_comprob nro_comprob nro_vencimiento 
                 tipo_registro fecha_cancelacion tip_cancela prf_cancela nro_cancela nro_vencancela
                 ASCENDING.

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}
{wglistar.i}

DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Total!Deuda".
DEFINE VARIABLE saldo_hi    AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Saldo!Histórico".
DEFINE VARIABLE saldo_an    AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Saldo!Analítico".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE BUFFER B-Cta_cte FOR Cta_cte.

DEFINE FRAME frm-titulo HEADER
  que_empresa  
  "Composiciónn de saldos analíticos al " que_fecha AT 50
  "Página:" AT 129 PAGE-NUMBER FORMAT ">>9" AT 138
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
  T-Ficha.cdg_cliente            COLUMN-LABEL "Código!Cliente"
  T-Ficha.tip_comprob            COLUMN-LABEL "Ti-!po"
  T-Ficha.prf_comprob            COLUMN-LABEL "Pre-!fijo" FORMAT "9999"
  T-Ficha.nro_comprob            COLUMN-LABEL "Número!Compbte."
  T-Ficha.nro_vencimiento        COLUMN-LABEL "Nro!Ven"
  T-Ficha.abrevia                COLUMN-LABEL "Con-!cepto"
  T-Ficha.fecha_emision          COLUMN-LABEL "Fecha!Emisión"
  T-Ficha.debito                 COLUMN-LABEL "Importe!Débitos"
  T-Ficha.credito                COLUMN-LABEL "Importe!Créditos"
  T-Ficha.fecha_cancelacion      COLUMN-LABEL "Fecha!Pago"
  T-Ficha.tip_cancela            COLUMN-LABEL "Ti-!po"
  T-Ficha.prf_cancela            COLUMN-LABEL "Pre-!fijo" FORMAT "9999"
  T-Ficha.nro_cancela            COLUMN-LABEL "Número!Compbte."
  T-Ficha.nro_vencancela         COLUMN-LABEL "Nro!Ven"
  T-Ficha.imp_cancela            COLUMN-LABEL "Importe!Cancela"
  T-Ficha.saldo_an               COLUMN-LABEL "Saldo!Analítico"
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*====================================================================================*/
/*                            BLOQUE PRINCIPAL                                        */
/*====================================================================================*/

FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.

FOR EACH Cliente WHERE Cliente.cdg_cliente <= has_cliente
                   AND Cliente.cdg_cliente >= des_cliente
                       BY Cliente.cdg_cliente:

    FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                 AND Cta_cte.cdg_empresa = Empresa.cdg_empresa
                                 AND Cta_cte.fecha_emision <= que_fecha,
                                EACH Imputacion OF Cta_cte
                                  BY Cta_cte.fecha_emision:
    
       CREATE T-Ficha.
       ASSIGN T-Ficha.tipo_registro     = 1
              T-Ficha.cdg_cliente       = Cliente.cdg_cliente
              T-Ficha.tip_comprob       = Cta_cte.tip_comprob
              T-Ficha.prf_comprob       = Cta_cte.prf_comprob
              T-Ficha.nro_comprob       = Cta_cte.nro_comprob           
              T-Ficha.nro_vencimiento   = Cta_cte.nro_vencimiento
              T-Ficha.fecha_emision     = Cta_cte.fecha_emision.
      
       IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
       THEN DO:
           T-Ficha.debito = Cta_cte.debito.
           OPEN QUERY q-aplicacion 
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
                             AND B-Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_vencimiento 
                             AND B-Cta_cte.fecha_emision <= que_fecha
                                 NO-LOCK BY B-Cta_cte.fecha_emision.
       END.
       ELSE DO:
           T-Ficha.credito = Cta_cte.credito.
           OPEN QUERY q-aplicacion
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
                             AND B-Cta_cte.nro_vencimiento = Aplicacion_pagos.nro_ven_cancela 
                             AND B-Cta_cte.fecha_emision <= que_fecha
                                 NO-LOCK BY B-Cta_cte.fecha_emision.
       END.
    
       GET FIRST q-aplicacion.   
       DO WHILE AVAILABLE Aplicacion_pagos:
    
          CREATE T-Ficha.
          ASSIGN T-Ficha.tipo_registro     = 2
                 T-Ficha.cdg_cliente       = Cliente.cdg_cliente
                 T-Ficha.tip_comprob       = Cta_cte.tip_comprob
                 T-Ficha.prf_comprob       = Cta_cte.prf_comprob
                 T-Ficha.nro_comprob       = Cta_cte.nro_comprob           
                 T-Ficha.nro_vencimiento   = Cta_cte.nro_vencimiento
                 T-Ficha.fecha_emision     = Cta_cte.fecha_emision
                 T-Ficha.tip_cancela       = B-Cta_cte.tip_comprob
                 T-Ficha.prf_cancela       = B-Cta_cte.prf_comprob
                 T-Ficha.nro_cancela       = B-Cta_cte.nro_comprob           
                 T-Ficha.nro_vencancela    = B-Cta_cte.nro_vencimiento
                 T-Ficha.fecha_cancelacion = B-Cta_cte.fecha_emision
                 T-Ficha.imp_cancela       = Aplicacion_pagos.importe.
          GET NEXT q-aplicacion.                   
    
       END. /* De recorrer la aplicacion de pagos */
    
    END.

END.

que_empresa = Empresa.nombre.
desc_moneda = Moneda.descripcion.

{dirprinfile.i}

FOR EACH T-Ficha, Cliente OF T-Ficha
    BREAK BY T-Ficha.cdg_cliente:

    VIEW FRAME frm-titulo.

    DISPLAY 
        T-Ficha.cdg_cliente            
        T-Ficha.tip_comprob            
        T-Ficha.prf_comprob            
        T-Ficha.nro_comprob            
        T-Ficha.nro_vencimiento        
        T-Ficha.abrevia                
        T-Ficha.fecha_emision          
        T-Ficha.debito                 
        T-Ficha.credito                
        T-Ficha.fecha_cancelacion      
        T-Ficha.tip_cancela            
        T-Ficha.prf_cancela            
        T-Ficha.nro_cancela            
        T-Ficha.nro_vencancela         
        T-Ficha.imp_cancela            
        T-Ficha.saldo_an               
        WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22).
