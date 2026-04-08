/*=================================================================================*/
/*                             SUMAS Y SALDOS POR CUENTA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-des_entidad   LIKE Entidad.cdg_entidad.
DEFINE INPUT PARAMETER p-has_entidad   LIKE Entidad.cdg_entidad.
DEFINE INPUT PARAMETER p-des_cuenta    LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER p-has_cuenta    LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER p-des_fecha     LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER p-has_fecha     LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER p-cdg_moneda  LIKE Moneda.cdg_moneda.


/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

{parlocales.i}
{DFVARIMP.I}

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo_acreed     LIKE Asn_detalle.debito FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE saldo_deudor     LIKE Asn_detalle.debito FORMAT "->,>>>,>>>,>>9.99".

DEFINE VARIABLE tot_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE tot_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE tot_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE tot_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE tot_acm_saldo_per    LIKE Asn_detalle.debito LABEL "Acum.saldo" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE tot_acm_saldo_tot    LIKE Asn_detalle.debito LABEL "Acum.saldo" FORMAT "->,>>>,>>>,>>9.99".

DEFINE VARIABLE gen_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE gen_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE gen_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE gen_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE gen_acm_saldo_per    LIKE Asn_detalle.debito LABEL "Acum.saldo" FORMAT "->,>>>,>>>,>>9.99".
DEFINE VARIABLE gen_acm_saldo_tot    LIKE Asn_detalle.debito LABEL "Acum.saldo" FORMAT "->,>>>,>>>,>>9.99".

DEFINE VARIABLE tit_entidad      AS CHARACTER FORMAT "x(30)".
DEFINE VARIABLE tit_cuenta       AS CHARACTER FORMAT "x(30)".
DEFINE VARIABLE tit_moneda       AS CHARACTER FORMAT "x(30)".

DEFINE VARIABLE hubo_entidad     AS LOGICAL.

DEFINE TEMP-TABLE T-Acumulado
    FIELD cdg_entidad      LIKE Entidad.cdg_entidad
    FIELD cdg_cuenta       LIKE Cuenta.cdg_cuenta
    FIELD acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->,>>>,>>>,>>9.99"
    FIELD acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->,>>>,>>>,>>9.99"
    FIELD acm_saldo_per    LIKE Asn_detalle.debito LABEL "Saldo" FORMAT "->,>>>,>>>,>>9.99"
    FIELD acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->,>>>,>>>,>>9.99"
    FIELD acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->,>>>,>>>,>>9.99"
    FIELD acm_saldo_tot    LIKE Asn_detalle.debito LABEL "Saldo" FORMAT "->,>>>,>>>,>>9.99"
    INDEX entidad_cuenta IS UNIQUE cdg_entidad cdg_cuenta.

DEFINE STREAM Exportar.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Sumas y Saldos por Centro de Costo" AT 85 
  "Pagina:" AT 187 PAGE-NUMBER FORMAT "ZZZ9" AT 194
  SKIP  
  fecha_lis   
  "del" AT 85
  p-des_fecha
  "al" 
  p-has_fecha 
  hora_lis AT 187
  SKIP
  tit_moneda AT 85
  SKIP
  tit_entidad AT 85
  SKIP
  tit_cuenta AT 85
  SKIP(1)
  WITH WIDTH 236 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  T-Acumulado.cdg_entidad               COLUMN-LABEL "Código!entidad"
  Entidad.dsc_entidad               COLUMN-LABEL "Descripción!de la entidad"
  T-Acumulado.cdg_cuenta                 COLUMN-LABEL "Código!Cuenta"
  Cuenta.nombre_cta                 COLUMN-LABEL "Descripción!de la cuenta"
  T-Acumulado.acm_debitos_per         COLUMN-LABEL "Débitos!Período"
  T-Acumulado.acm_creditos_per        COLUMN-LABEL "Créditos!Período"
  T-Acumulado.acm_saldo_per               COLUMN-LABEL "Saldo!Período"
  T-Acumulado.acm_debitos_tot         COLUMN-LABEL "Débitos!Ejercicio"
  T-Acumulado.acm_creditos_tot        COLUMN-LABEL "Créditos!Ejercicio"
  T-Acumulado.acm_saldo_tot               COLUMN-LABEL "Saldo!Ejercicio"
  WITH WIDTH 236 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

RUN LISTAR.  

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
/*=================================================================================*/

PROCEDURE LISTAR:

  FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
  tit_moneda = "EEXPRESADO EN " + Moneda.descripcion.

  tit_entidad = "Entidades de " + p-des_entidad + " a " + p-has_entidad.
  tit_cuenta  = "Cuentas de " + p-des_cuenta + " a " + p-has_cuenta.

  {dirprinfile.i}

  OUTPUT STREAM Exportar TO VALUE(REPLACE(arch_salida,".txt",".prn")).

  ASSIGN
      gen_debitos_per  = 0 
      gen_creditos_per = 0
      gen_debitos_tot  = 0
      gen_creditos_tot = 0
    
      tot_debitos_per  = 0 
      tot_creditos_per = 0
      tot_debitos_tot  = 0
      tot_creditos_tot = 0.
  
      hubo_entidad     = NO.

  FOR EACH Asn_detalle
      WHERE /*Asn_detalle.fecha_mayor >= p-des_fecha 
        AND */ Asn_detalle.fecha_mayor <= p-has_fecha
        AND Asn_detalle.nro_moneda = Moneda.nro_moneda
        AND Asn_detalle.reexpresion
        AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa,
      FIRST Entidad OF Asn_detalle
            WHERE T-Acumulado.cdg_entidad <= p-has_entidad
              AND T-Acumulado.cdg_entidad >= p-des_entidad,
      FIRST Cuenta OF Asn_detalle
            WHERE T-Acumulado.cdg_cuenta <= p-has_cuenta
              AND T-Acumulado.cdg_cuenta >= p-des_cuenta /*
                  BREAK BY T-Acumulado.cdg_entidad BY T-Acumulado.cdg_cuenta*/:

      VIEW FRAME frm-titulo.

      FIND FIRST T-Acumulado 
          WHERE T-Acumulado.cdg_entidad = T-Acumulado.cdg_entidad 
            AND T-Acumulado.cdg_cuenta = T-Acumulado.cdg_cuenta NO-ERROR.
      IF NOT AVAILABLE T-Acumulado
      THEN DO:
          CREATE T-Acumulado.
          ASSIGN T-Acumulado.cdg_entidad = T-Acumulado.cdg_entidad 
                 T-Acumulado.cdg_cuenta = T-Acumulado.cdg_cuenta.
      END.
      
      T-Acumulado.acm_debitos_tot  = T-Acumulado.acm_debitos_tot  + Asn_detalle.debito.
      T-Acumulado.acm_creditos_tot = T-Acumulado.acm_creditos_tot + Asn_detalle.credito.

      IF Asn_detalle.fecha_mayor >= p-des_fecha
          THEN ASSIGN T-Acumulado.acm_debitos_per  = T-Acumulado.acm_debitos_per  + Asn_detalle.debito
                      T-Acumulado.acm_creditos_per = T-Acumulado.acm_creditos_per + Asn_detalle.credito.

  END.

  FOR EACH T-Acumulado BREAK BY T-Acumulado.cdg_entidad BY T-Acumulado.cdg_cuenta:

      IF LAST-OF(T-Acumulado.cdg_cuenta)
      THEN DO:

          FIND Entidad WHERE Entidad.cdg_entidad = T-Acumulado.cdg_entidad NO-LOCK.
          FIND Cuenta WHERE Cuenta.cdg_cuenta = T-Acumulado.cdg_cuenta NO-LOCK.

          T-Acumulado.acm_saldo_per = T-Acumulado.acm_debitos_per  - T-Acumulado.acm_creditos_per.
          T-Acumulado.acm_saldo_tot = T-Acumulado.acm_debitos_tot  - T-Acumulado.acm_creditos_tot.

          EXPORT STREAM Exportar DELIMITER ";"
                   T-Acumulado.cdg_entidad
                   Entidad.dsc_entidad
                   T-Acumulado.cdg_cuenta
                   Cuenta.nombre
                   T-Acumulado.acm_debitos_per 
                   T-Acumulado.acm_creditos_per 
                   T-Acumulado.acm_saldo_per
                   T-Acumulado.acm_debitos_tot 
                   T-Acumulado.acm_creditos_tot 
                   T-Acumulado.acm_saldo_tot.

          DISPLAY  T-Acumulado.cdg_entidad WHEN NOT hubo_entidad
                   Entidad.dsc_entidad WHEN NOT hubo_entidad
                   T-Acumulado.cdg_cuenta
                   Cuenta.nombre
                   T-Acumulado.acm_debitos_per 
                   T-Acumulado.acm_creditos_per 
                   T-Acumulado.acm_saldo_per
                   T-Acumulado.acm_debitos_tot 
                   T-Acumulado.acm_creditos_tot 
                   T-Acumulado.acm_saldo_tot
                   WITH FRAME frm-movimiento.
    
          DOWN WITH FRAME frm-movimiento.         

          ASSIGN
                tot_debitos_per  = tot_debitos_per  + T-Acumulado.acm_debitos_per 
                tot_creditos_per = tot_creditos_per + T-Acumulado.acm_creditos_per  
                tot_debitos_tot  = tot_debitos_tot  + T-Acumulado.acm_debitos_tot 
                tot_creditos_tot = tot_creditos_tot + T-Acumulado.acm_creditos_tot  
                tot_acm_saldo_per    = tot_acm_saldo_per  + T-Acumulado.acm_saldo_per 
                tot_acm_saldo_tot    = tot_acm_saldo_tot  + T-Acumulado.acm_saldo_tot
                T-Acumulado.acm_debitos_per  = 0 
                T-Acumulado.acm_creditos_per = 0
                T-Acumulado.acm_debitos_tot  = 0
                T-Acumulado.acm_creditos_tot = 0
                hubo_entidad     = YES.

      END.

      IF LAST-OF(T-Acumulado.cdg_entidad)
      THEN DO:

          UNDERLINE T-Acumulado.cdg_entidad 
                    Entidad.dsc_entidad 
                    T-Acumulado.cdg_cuenta
                    Cuenta.nombre
                    T-Acumulado.acm_debitos_per 
                    T-Acumulado.acm_creditos_per 
                    T-Acumulado.acm_saldo_per
                    T-Acumulado.acm_debitos_tot 
                    T-Acumulado.acm_creditos_tot 
                    T-Acumulado.acm_saldo_tot
                    WITH FRAME frm-movimiento.  
  
          DISPLAY   "Total Entidad"     @ Cuenta.nombre
                    tot_debitos_per     @ T-Acumulado.acm_debitos_per 
                    tot_creditos_per    @ T-Acumulado.acm_creditos_per 
                    tot_acm_saldo_per       @ T-Acumulado.acm_saldo_per
                    tot_debitos_tot     @ T-Acumulado.acm_debitos_tot 
                    tot_creditos_tot    @ T-Acumulado.acm_creditos_tot 
                    tot_acm_saldo_tot       @ T-Acumulado.acm_saldo_tot
                    WITH FRAME frm-movimiento.

          DOWN 2 WITH FRAME frm-movimiento.         

          ASSIGN
                gen_debitos_per  = gen_debitos_per  + tot_debitos_per 
                gen_creditos_per = gen_creditos_per + tot_creditos_per  
                gen_debitos_tot  = gen_debitos_tot  + tot_debitos_tot 
                gen_creditos_tot = gen_creditos_tot + tot_creditos_tot  
                gen_acm_saldo_per    = gen_acm_saldo_per    + T-Acumulado.acm_saldo_per 
                gen_acm_saldo_tot    = gen_acm_saldo_tot    + T-Acumulado.acm_saldo_tot
                tot_debitos_per  = 0 
                tot_creditos_per = 0
                tot_debitos_tot  = 0
                tot_creditos_tot = 0.

          hubo_entidad = NO.
      END.

  END.

  UNDERLINE T-Acumulado.cdg_entidad 
            Entidad.dsc_entidad 
            T-Acumulado.cdg_cuenta
            Cuenta.nombre
            T-Acumulado.acm_debitos_per 
            T-Acumulado.acm_creditos_per 
            T-Acumulado.acm_saldo_per
            T-Acumulado.acm_debitos_tot 
            T-Acumulado.acm_creditos_tot 
            T-Acumulado.acm_saldo_tot
            WITH FRAME frm-movimiento.  

  OUTPUT STREAM Exportar CLOSE.
  OUTPUT CLOSE.

END PROCEDURE.  

