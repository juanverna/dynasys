/*=================================================================================*/
/*                             SUMAS Y SALDOS POR CUENTA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE.
DEFINE INPUT PARAMETER has_fecha    AS DATE.
DEFINE INPUT PARAMETER des_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER has_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER listar_hora  AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina   AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina   AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent  AS LOGICAL.
DEFINE INPUT PARAMETER exportacion  AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I }

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

DEFINE VARIABLE fecha_lis    AS CHARACTER.
DEFINE VARIABLE hora_lis     AS CHARACTER.

DEFINE VARIABLE fecha_fr     AS CHARACTER.
DEFINE VARIABLE hora_fr      AS CHARACTER.
DEFINE VARIABLE transpor     AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE pri_mes      AS DATE.

DEFINE VARIABLE saldo_acreed     LIKE Aps_detalle.debito.
DEFINE VARIABLE saldo_deudor     LIKE Aps_detalle.debito.
DEFINE VARIABLE saldo_per        LIKE Aps_detalle.debito LABEL "Saldo".
DEFINE VARIABLE acm_debitos_per  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos_per LIKE Aps_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE saldo_tot        LIKE Aps_detalle.debito LABEL "Saldo".
DEFINE VARIABLE acm_debitos_tot  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos_tot LIKE Aps_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tot_debitos_per  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE tot_creditos_per LIKE Aps_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tot_debitos_tot  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE tot_creditos_tot LIKE Aps_detalle.credito LABEL "Acum.creditos".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Sumas y Saldos Presupuestados" AT 52 
  "Pagina:" AT 122 PAGE-NUMBER FORMAT "ZZZ9" AT 129
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 122
  SKIP(1)
  "             Totales  del  periodo                       Totales  del  ejercicio" AT 44 SKIP
  "Codigo Descripcion" 
  "       Debitos       Creditos          Saldo        Debitos       Creditos          Saldo" AT 44 SKIP
  "------ -----------------------------------" 
  "-------------- -------------- -------------- -------------- -------------- --------------" AT 44 SKIP
  WITH WIDTH 136 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  Ctapsp.cdg_ctapsp
  Ctapsp.nombre
  acm_debitos_per
  acm_creditos_per
  saldo_per
  acm_debitos_tot
  acm_creditos_tot
  saldo_tot
  WITH WIDTH 136 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
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
  
  IF NOT exportacion 
     THEN OUTPUT TO VALUE (dire_tmp + "lssyscps.txt") PAGED PAGE-SIZE VALUE(lin_pagina).
     ELSE OUTPUT TO VALUE (dire_tmp + "lssyscps.txt").
      
  IF NOT exportacion THEN RUN PONE_CODIGO ( INPUT "SET17CPI,CARTA,SET8LPI" ).

  tot_debitos_per  = 0. 
  tot_creditos_per = 0.
  tot_debitos_tot  = 0.
  tot_creditos_tot = 0.
  
  FOR EACH Ctapsp 
      WHERE Ctapsp.cdg_ctapsp <= has_ctapsp
        AND Ctapsp.cdg_ctapsp >= des_ctapsp
        AND (CAN-FIND(FIRST Aps_detalle OF Ctapsp 
                            WHERE Aps_detalle.fecha >= des_fecha 
                              AND Aps_detalle.fecha <= has_fecha)
                      OR todas_cuent):                              
        
      IF NOT exportacion THEN VIEW FRAME frm-titulo.

      RUN CALCULAR_SALDO. 

      IF NOT exportacion 
      THEN DO:

         DISPLAY  Ctapsp.cdg_ctapsp
                  Ctapsp.nombre
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
            tot_creditos_per = tot_creditos_per + acm_debitos_per  
            tot_debitos_tot  = tot_debitos_tot  + acm_debitos_tot 
            tot_creditos_tot = tot_creditos_tot + acm_debitos_tot.  
      END.
      ELSE DO:
         EXPORT  Ctapsp.cdg_ctapsp
                 Ctapsp.nombre
                 acm_debitos_per 
                 acm_creditos_per 
                 acm_debitos_tot 
                 acm_creditos_tot.
      END.            
  END.

  IF NOT exportacion 
  THEN DO:
     UNDERLINE Ctapsp.cdg_ctapsp
               Ctapsp.nombre
               acm_debitos_per 
               acm_creditos_per 
               saldo_per
               acm_debitos_tot 
               acm_creditos_tot 
               saldo_tot
               WITH FRAME frm-movimiento.  
  
     DISPLAY   "Totales Generales" @ Ctapsp.nombre
                tot_debitos_per     @ acm_debitos_per 
                tot_creditos_per    @ acm_creditos_per 
                tot_debitos_tot     @ acm_debitos_tot 
                tot_creditos_tot    @ acm_creditos_tot 
                WITH FRAME frm-movimiento.

     UNDERLINE Ctapsp.cdg_ctapsp
               Ctapsp.nombre
               acm_debitos_per 
               acm_creditos_per 
               saldo_per
               acm_debitos_tot 
               acm_creditos_tot 
               saldo_tot
               WITH FRAME frm-movimiento.  
  END.             

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO:

    acm_debitos_per  = 0. 
    acm_creditos_per = 0.
    acm_debitos_tot  = 0.
    acm_creditos_tot = 0.

   /* Busca por Acumulado_ctapsp hasta el mes anterior a la fecha */
   FOR EACH Acumulado_ctapsp OF Ctapsp
       WHERE   DATE(Acumulado_ctapsp.mes,1,Acumulado_ctapsp.ano) < 
               DATE(MONTH(has_fecha),1,YEAR(has_fecha)):
                             
      acm_debitos_tot  = acm_debitos_tot  + Acumulado_ctapsp.tot_debitos.
      acm_creditos_tot = acm_creditos_tot + Acumulado_ctapsp.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Aps_detalle OF Ctapsp 
       WHERE Aps_detalle.fecha_mayor >= DATE(MONTH(has_fecha),1,YEAR(has_fecha)) 
         AND Aps_detalle.fecha_mayor <= has_fecha 
          BY fecha_mayor:

      acm_debitos_per  = acm_debitos_per  + Aps_detalle.debito.
      acm_creditos_per = acm_creditos_per + Aps_detalle.credito.


   END.

   acm_debitos_tot  = acm_debitos_tot  + acm_debitos_per.
   acm_creditos_tot = acm_creditos_tot + acm_creditos_per.

   saldo_per = acm_debitos_per  - acm_creditos_per.
   saldo_tot = acm_debitos_tot  - acm_creditos_tot.

END.

{CODIMPRE.I}
 
