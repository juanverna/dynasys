/*=================================================================================*/
/*                     LISTADO DE RESULTADOS COMPARADOS                            */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }

DEFINE INPUT PARAMETER des_fecha    LIKE Aps_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Aps_detalle.fecha.
DEFINE INPUT PARAMETER des_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER has_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER listar_hora  AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina   AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina   AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent  AS LOGICAL.

DEFINE VARIABLE que_empresa  LIKE Empresa.nombre.
DEFINE VARIABLE fecha_lis    AS CHARACTER.
DEFINE VARIABLE hora_lis     AS CHARACTER.

DEFINE VARIABLE fecha_fr     AS CHARACTER.
DEFINE VARIABLE hora_fr      AS CHARACTER.
DEFINE VARIABLE transpor     AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE pri_mes      AS DATE.

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE s_deb-pres LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Deudor!Presupestado".
DEFINE VARIABLE s_crd-pres LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Acreedor!Presupestado".
DEFINE VARIABLE s_deb-real LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Deudor!Real".
DEFINE VARIABLE s_crd-real LIKE Aps_detalle.debito COLUMN-LABEL "Saldo Acreedor!Real".
DEFINE VARIABLE prc_desvio AS DECIMAL FORMAT "->>>>>9.99" COLUMN-LABEL "   %!Desvío".

DEFINE VARIABLE acm_debitos  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Aps_detalle.credito LABEL "Acum.creditos".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Resultado de Saldos Comparados" AT 52 
  "Pagina:" AT 116 PAGE-NUMBER FORMAT "ZZZ9" AT 123
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 116
  SKIP(1)
  WITH WIDTH 132 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  Ctapsp.cdg_ctapsp COLUMN-LABEL "Código!Sumariza"
  Ctapsp.nombre     COLUMN-LABEL "Descripción!Sumariza"
  s_deb-pres
  s_crd-pres
  s_deb-real
  s_crd-real
  prc_desvio
  WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  IF listar_hora
  THEN DO:
     fecha_lis = STRING(TODAY).
     hora_lis = STRING(TIME,"HH:MM:SS").
  END.
  ELSE DO:   
     fecha_lis = " ".
     hora_lis = " ".
  END.

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  OUTPUT TO VALUE (dire_tmp + "lsrescom.txt") PAGED PAGE-SIZE VALUE(lin_pagina).
 
  RUN PONE_CODIGO ( INPUT "SET17CPI,CARTA,SET8LPI" ).
  
  FOR EACH Ctapsp 
      WHERE Ctapsp.cdg_ctapsp <= has_ctapsp
        AND Ctapsp.cdg_ctapsp >= des_ctapsp NO-LOCK:
        
      VIEW FRAME frm-titulo.

      RUN CALCULAR_SALDO_PRESUP ( OUTPUT acm_debitos, OUTPUT acm_creditos).
      ASSIGN
            s_deb-pres = acm_debitos
            s_crd-pres = acm_creditos.

      FOR EACH  Sumariza_psp OF Ctapsp, FIRST Cuenta OF Sumariza_psp:

          RUN CALCULAR_SALDO_REAL ( OUTPUT acm_debitos, OUTPUT acm_creditos).
          ASSIGN
               s_deb-real = s_deb-real + acm_debitos
               s_crd-real = s_crd-real + acm_creditos.
      END.

      prc_desvio = ( ( s_deb-real - s_crd-real ) / ( s_deb-pres - s_crd-pres ) - 1 ) * 100.      

      DISPLAY  Ctapsp.cdg_ctapsp
               Ctapsp.nombre
               s_deb-pres
               s_crd-pres
               s_deb-real
               s_crd-real
               prc_desvio
               WITH FRAME frm-movimiento.
     
      DOWN WITH FRAME frm-movimiento.

  END.
  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO_PRESUP:

   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Acumulado_ctapsp hasta el mes anterior a la fecha */
   FOR EACH Acumulado_ctapsp OF Ctapsp
       WHERE   DATE(Acumulado_ctapsp.mes,1,Acumulado_ctapsp.ano) < 
               DATE(MONTH(des_fecha),1,YEAR(des_fecha)):
                             
      tot_debitogr  = tot_debitogr  + Acumulado_ctapsp.tot_debitos.
      tot_creditogr = tot_creditogr + Acumulado_ctapsp.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Aps_detalle OF Ctapsp 
       WHERE Aps_detalle.fecha_mayor >= DATE(MONTH(des_fecha),1,YEAR(des_fecha)) 
         AND Aps_detalle.fecha_mayor < has_fecha 
          BY fecha_mayor:

       tot_debitogr  = tot_debitogr + Aps_detalle.debito.
       tot_creditogr = tot_creditogr + Aps_detalle.credito.

   END.

END PROCEDURE.

PROCEDURE CALCULAR_SALDO_REAL:

   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Acumulado_cuenta hasta el mes anterior a la fecha */
   FOR EACH Acumulado_cuenta OF Cuenta
       WHERE   DATE(Acumulado_cuenta.mes,1,Acumulado_cuenta.ano) < 
               DATE(MONTH(des_fecha),1,YEAR(des_fecha)):
                             
      tot_debitogr  = tot_debitogr  + Acumulado_cuenta.tot_debitos.
      tot_creditogr = tot_creditogr + Acumulado_cuenta.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor >= DATE(MONTH(des_fecha),1,YEAR(des_fecha)) 
         AND Asn_detalle.fecha_mayor < has_fecha 
          BY fecha_mayor:

       tot_debitogr  = tot_debitogr + Asn_detalle.debito.
       tot_creditogr = tot_creditogr + Asn_detalle.credito.

   END.

END PROCEDURE.


{CODIMPRE.I}
 
