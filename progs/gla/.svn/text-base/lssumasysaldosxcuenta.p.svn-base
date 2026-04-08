/*=================================================================================*/
/*                             SUMAS Y SALDOS POR CUENTA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha     LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha     LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_cuenta    LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta    LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER p-cdg_moneda  LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion AS LOGICAL.
DEFINE INPUT PARAMETER listar_hora   AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina    AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina    AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent   AS LOGICAL.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }
{DFVARIMP.I}

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo_acreed     LIKE Asn_detalle.debito.
DEFINE VARIABLE saldo_deudor     LIKE Asn_detalle.debito.
DEFINE VARIABLE saldo_per        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE saldo_tot        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tot_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE tot_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tot_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE tot_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tot_saldo_per    LIKE Asn_detalle.debito LABEL "Acum.saldo".
DEFINE VARIABLE tot_saldo_tot    LIKE Asn_detalle.debito LABEL "Acum.saldo".
DEFINE VARIABLE tit_moneda       AS CHARACTER FORMAT "X(50)".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Sumas y Saldos" AT 52 
  "Pagina:" AT 122 PAGE-NUMBER FORMAT "ZZZ9" AT 129
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 122 
  SKIP
  tit_moneda AT 52
  SKIP(1)
  WITH WIDTH 196 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  Cuenta.cdg_cuenta       COLUMN-LABEL "Código!Cuenta"
  Cuenta.nombre           COLUMN-LABEL "Descripción!de la Cuenta"
  acm_debitos_per         COLUMN-LABEL "Débitos!Período"
  acm_creditos_per        COLUMN-LABEL "Créditos!Período"
  saldo_per               COLUMN-LABEL "Saldo!Período"
  acm_debitos_tot         COLUMN-LABEL "Débitos!Ejercicio"
  acm_creditos_tot        COLUMN-LABEL "Créditos!Ejercicio"
  saldo_tot               COLUMN-LABEL "Saldo!Ejercicio"
  WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                              P R O C E D I M I E N T O S                        */
/*=================================================================================*/

PROCEDURE LISTAR:

  {dirprinfile.i}

  ASSIGN tot_debitos_per  = 0 
         tot_creditos_per = 0
         tot_debitos_tot  = 0
         tot_creditos_tot = 0.
  
  FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
  IF p-reexpresion 
     THEN tit_moneda = "REEXPRESADO EN " + Moneda.descripcion.
     ELSE tit_moneda = "MONEDA ORIGINAL " + Moneda.descripcion.

  FOR EACH Cuenta 
      WHERE Cuenta.cdg_cuenta <= has_cuenta
        AND Cuenta.cdg_cuenta >= des_cuenta
      AND (CAN-FIND(FIRST Asn_detalle OF Cuenta 
                          WHERE Asn_detalle.fecha_mayor >= des_fecha 
                            AND Asn_detalle.fecha_mayor <= has_fecha
                            AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
                            AND Asn_detalle.nro_moneda = Moneda.nro_moneda
                            AND Asn_detalle.reexpresion = p-reexpresion)
                    OR todas_cuent):                              
        
      VIEW FRAME frm-titulo.

      RUN CALCULAR_SALDO. 

      DISPLAY  Cuenta.cdg_cuenta
               Cuenta.nombre
               acm_debitos_per 
               acm_creditos_per 
               saldo_per
               acm_debitos_tot 
               acm_creditos_tot 
               saldo_tot
               WITH FRAME frm-movimiento.

      DOWN WITH FRAME frm-movimiento.         

      ASSIGN
            tot_debitos_per  = tot_debitos_per  + acm_debitos_per 
            tot_creditos_per = tot_creditos_per + acm_creditos_per  
            tot_debitos_tot  = tot_debitos_tot  + acm_debitos_tot 
            tot_creditos_tot = tot_creditos_tot + acm_creditos_tot  
            tot_saldo_per  = tot_saldo_per  + saldo_per 
            tot_saldo_tot  = tot_saldo_tot  + saldo_tot. 

  END.

  UNDERLINE Cuenta.cdg_cuenta
            Cuenta.nombre
            acm_debitos_per 
            acm_creditos_per 
            saldo_per
            acm_debitos_tot 
            acm_creditos_tot 
            saldo_tot
            WITH FRAME frm-movimiento.  
  
  DISPLAY   "Totales Generales" @ Cuenta.nombre
            tot_debitos_per     @ acm_debitos_per 
            tot_creditos_per    @ acm_creditos_per 
            tot_saldo_per       @ saldo_per
            tot_debitos_tot     @ acm_debitos_tot 
            tot_creditos_tot    @ acm_creditos_tot 
            tot_saldo_tot       @ saldo_tot
            WITH FRAME frm-movimiento.

  UNDERLINE Cuenta.cdg_cuenta
            Cuenta.nombre
            acm_debitos_per 
            acm_creditos_per 
            saldo_per
            acm_debitos_tot 
            acm_creditos_tot 
            saldo_tot
            WITH FRAME frm-movimiento.  

  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO:

   ASSIGN acm_debitos_per  = 0 
          acm_creditos_per = 0
          acm_debitos_tot  = 0
          acm_creditos_tot = 0.

  /* Busca por Movimiento desde la noche de los tiempos hasta la fecha */
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor <= has_fecha 
         AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
         AND Asn_detalle.nro_moneda  = Moneda.nro_moneda
         AND Asn_detalle.reexpresion = p-reexpresion
          BY Asn_detalle.fecha_mayor:

      IF Asn_detalle.fecha_mayor >= des_fecha
          THEN ASSIGN acm_debitos_per  = acm_debitos_per  + Asn_detalle.debito
                      acm_creditos_per = acm_creditos_per + Asn_detalle.credito.

      acm_debitos_tot  = acm_debitos_tot  + Asn_detalle.debito.
      acm_creditos_tot = acm_creditos_tot + Asn_detalle.credito.

   END.

   saldo_per = acm_debitos_per  - acm_creditos_per.
   saldo_tot = acm_debitos_tot  - acm_creditos_tot.

END PROCEDURE.

PROCEDURE CALCULAR_SALDO_CON_ACUMULADOS:

    acm_debitos_per  = 0. 
    acm_creditos_per = 0.
    acm_debitos_tot  = 0.
    acm_creditos_tot = 0.

   /* Busca por Acumulado_cuenta hasta el mes anterior a la fecha */
   FOR EACH Acumulado_cuenta OF Cuenta
       WHERE   DATE(Acumulado_cuenta.mes,1,Acumulado_cuenta.ano) < 
               DATE(MONTH(has_fecha),1,YEAR(has_fecha))
               AND Acumulado_cuenta.cdg_empresa = Empresa.cdg_empresa:
                             
      acm_debitos_tot  = acm_debitos_tot  + Acumulado_cuenta.tot_debitos.
      acm_creditos_tot = acm_creditos_tot + Acumulado_cuenta.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor >= DATE(MONTH(has_fecha),1,YEAR(has_fecha)) 
         AND Asn_detalle.fecha_mayor <= has_fecha 
         AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
          BY Asn_detalle.fecha_mayor:

      acm_debitos_per  = acm_debitos_per  + Asn_detalle.debito.
      acm_creditos_per = acm_creditos_per + Asn_detalle.credito.

   END.

   acm_debitos_tot  = acm_debitos_tot  + acm_debitos_per.
   acm_creditos_tot = acm_creditos_tot + acm_creditos_per.

   saldo_per = acm_debitos_per  - acm_creditos_per.
   saldo_tot = acm_debitos_tot  - acm_creditos_tot.

END PROCEDURE.


