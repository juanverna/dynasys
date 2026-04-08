/*=================================================================================*/
/*                             SUMAS Y SALDOS POR CUENTA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha              LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha              LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER p-cdg_tipocoeficiente  LIKE tipocoeficiente.cdg_tipocoeficiente.
DEFINE INPUT PARAMETER p-generar              AS LOGICAL.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

{parlocales.i}
{DFVARIMP.I}

DEFINE TEMP-TABLE T-CoeficienteAjuste
    FIELD ano AS INTEGER
    FIELD mes AS INTEGER
    FIELD valor AS DECIMAL DECIMALS 6
    INDEX por_periodo IS UNIQUE  ano mes.

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo_org        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE saldo_aju        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE saldo_dif        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE tot_saldo_org    LIKE Asn_detalle.debito LABEL "Acum.saldo".
DEFINE VARIABLE tot_saldo_aju    LIKE Asn_detalle.debito LABEL "Acum.saldo".
DEFINE VARIABLE tot_saldo_dif    LIKE Asn_detalle.debito LABEL "Acum.saldo".
DEFINE VARIABLE tit_moneda       AS CHARACTER FORMAT "X(50)".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Ajuste por exposición a la inflación (R.T. 6)" AT 52 
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
  saldo_org               COLUMN-LABEL "Saldo!Histórico"
  saldo_aju               COLUMN-LABEL "Saldo!Ajustado"
  saldo_dif               COLUMN-LABEL "Ajuste!Saldo"
  WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}

que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                              P R O C E D I M I E N T O S                        */
/*=================================================================================*/

PROCEDURE LISTAR:

  {dirprinfile.i}

  ASSIGN tot_saldo_org  = 0 
         tot_saldo_aju  = 0
         tot_saldo_dif  = 0.
  
  FIND Moneda WHERE Moneda.es_local NO-LOCK.
  tit_moneda = "EEXPRESADO EN " + Moneda.descripcion.

  RUN calcular_coeficientes.

  FOR EACH Cuenta 
      WHERE Cuenta.ajuste
        AND CAN-FIND(FIRST Asn_detalle OF Cuenta 
                          WHERE Asn_detalle.fecha_mayor >= des_fecha 
                            AND Asn_detalle.fecha_mayor <= has_fecha
                            AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
                            AND Asn_detalle.nro_moneda = Moneda.nro_moneda
                            AND Asn_detalle.reexpresion = YES):                              
        
      VIEW FRAME frm-titulo.

      RUN CALCULAR_SALDO. 

      saldo_dif = saldo_aju - saldo_org.

      DISPLAY  Cuenta.cdg_cuenta
               Cuenta.nombre
               saldo_org  
               saldo_aju  
               saldo_dif  
               WITH FRAME frm-movimiento.

      DOWN WITH FRAME frm-movimiento.         

      ASSIGN
            tot_saldo_org  = tot_saldo_org  + saldo_org 
            tot_saldo_aju  = tot_saldo_aju  + saldo_aju. 

  END.

  UNDERLINE Cuenta.cdg_cuenta
            Cuenta.nombre
            saldo_org  
            saldo_aju  
            saldo_dif  
            WITH FRAME frm-movimiento.  
  
  DISPLAY   "Totales Generales" @ Cuenta.nombre
            tot_saldo_org       @ saldo_org
            tot_saldo_aju       @ saldo_aju
            tot_saldo_dif       @ saldo_dif
            WITH FRAME frm-movimiento.

  UNDERLINE Cuenta.cdg_cuenta
            Cuenta.nombre
            saldo_org  
            saldo_aju  
            saldo_dif  
            WITH FRAME frm-movimiento.  

  OUTPUT CLOSE.

  RUN veresult.w (INPUT arch_salida, INPUT 22).

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO:

   DEFINE VARIABLE acm_debitos_org  AS DECIMAL. 
   DEFINE VARIABLE acm_creditos_org AS DECIMAL.
   DEFINE VARIABLE acm_debitos_aju  AS DECIMAL.
   DEFINE VARIABLE acm_creditos_aju AS DECIMAL.

   ASSIGN acm_debitos_org  = 0 
          acm_creditos_org = 0
          acm_debitos_aju  = 0
          acm_creditos_aju = 0.

  /* Busca por Movimiento desde la noche de los tiempos hasta la fecha */
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor <= has_fecha 
         AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
         AND Asn_detalle.nro_moneda  = Moneda.nro_moneda
         AND Asn_detalle.reexpresion = YES 
          BY Asn_detalle.fecha_mayor:

      FIND T-CoeficienteAjuste 
          WHERE T-CoeficienteAjuste.mes = MONTH(Asn_detalle.fecha_mayor)
            AND T-CoeficienteAjuste.ano = YEAR(Asn_detalle.fecha_mayor)
                NO-LOCK.

      acm_debitos_aju  = acm_debitos_aju  + Asn_detalle.debito * T-CoeficienteAjuste.valor.
      acm_creditos_aju = acm_creditos_aju + Asn_detalle.credito * T-CoeficienteAjuste.valor.

      acm_debitos_org  = acm_debitos_aju  + Asn_detalle.debito.
      acm_creditos_org = acm_creditos_aju + Asn_detalle.credito.

   END.

   saldo_org = acm_debitos_org  - acm_creditos_org.
   saldo_aju = acm_debitos_aju  - acm_creditos_aju.

END PROCEDURE.
/*
PROCEDURE CALCULAR_SALDO_CON_ACUMULADOS:

    acm_debitos_org  = 0. 
    acm_creditos_org = 0.
    acm_debitos_aju  = 0.
    acm_creditos_aju = 0.

   /* Busca por Acumulado_cuenta hasta el mes anterior a la fecha */
   FOR EACH Acumulado_cuenta OF Cuenta
       WHERE   DATE(Acumulado_cuenta.mes,1,Acumulado_cuenta.ano) < 
               DATE(MONTH(has_fecha),1,YEAR(has_fecha))
               AND Acumulado_cuenta.cdg_empresa = Empresa.cdg_empresa:
                             
      acm_debitos_aju  = acm_debitos_aju  + Acumulado_cuenta.tot_debitos.
      acm_creditos_aju = acm_creditos_aju + Acumulado_cuenta.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor >= DATE(MONTH(has_fecha),1,YEAR(has_fecha)) 
         AND Asn_detalle.fecha_mayor <= has_fecha 
         AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
          BY Asn_detalle.fecha_mayor:

      acm_debitos_org  = acm_debitos_org  + Asn_detalle.debito.
      acm_creditos_org = acm_creditos_org + Asn_detalle.credito.

   END.

   acm_debitos_aju  = acm_debitos_aju  + acm_debitos_org.
   acm_creditos_aju = acm_creditos_aju + acm_creditos_org.

   saldo_org = acm_debitos_org  - acm_creditos_org.
   saldo_aju = acm_debitos_aju  - acm_creditos_aju.

END PROCEDURE.
*/

PROCEDURE calcular_coeficientes:

    DEFINE VARIABLE j-mes AS INTEGER.
    DEFINE VARIABLE j-ano AS INTEGER.

    DEFINE VARIABLE a-mes AS INTEGER.
    DEFINE VARIABLE a-ano AS INTEGER.

    FIND Tipocoeficiente WHERE Tipocoeficiente.cdg_tipocoeficiente = p-cdg_tipocoeficiente NO-LOCK.

    ASSIGN j-mes = MONTH(des_fecha)
           j-ano = YEAR(des_fecha).

    /* Puede optimizarse haciendo que recuerde el coeficiente anterior para el proximo lazo */

    DO WHILE  j-ano * 100 + j-mes <= YEAR(has_fecha) * 100 + MONTH(has_fecha):

        FIND FIRST Coeficiente OF Tipocoeficiente
            WHERE Coeficiente.ano = j-ano AND Coeficiente.mes = j-mes NO-LOCK.

        CREATE T-CoeficienteAjuste.
        BUFFER-COPY Coeficiente TO T-CoeficienteAjuste.

        a-mes = j-mes - 1.
        IF a-mes > 0
            THEN ASSIGN a-ano = j-ano.
            ELSE ASSIGN a-ano = j-ano - 1
                        a-mes = 12.

        FIND FIRST Coeficiente OF Tipocoeficiente
            WHERE Coeficiente.ano = a-ano AND Coeficiente.mes = a-mes NO-LOCK.

        T-CoeficienteAjuste.valor = T-CoeficienteAjuste.valor / Coeficiente.valor .

        j-mes = j-mes + 1.
        IF j-mes = 13 
            THEN ASSIGN j-ano = j-ano + 1
                        j-mes = 1.

    END.

END.
