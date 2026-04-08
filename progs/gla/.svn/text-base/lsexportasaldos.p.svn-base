/*=================================================================================*/
/*                             SUMAS Y SALDOS POR CUENTA                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_cuenta   LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta   LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER listar_hora  AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina   AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina   AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent  AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I }
{DFVARIMP.I}

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

{WGLISTAR.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Sumas y Saldos".
nom_menu = "CONTABILIDAD".

que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
/*=================================================================================*/

PROCEDURE LISTAR:

  {dirprinfile.i}

  tot_debitos_per  = 0. 
  tot_creditos_per = 0.
  tot_debitos_tot  = 0.
  tot_creditos_tot = 0.
  
  FOR EACH Cuenta 
      WHERE Cuenta.cdg_cuenta <= has_cuenta
        AND Cuenta.cdg_cuenta >= des_cuenta
        AND (CAN-FIND(FIRST Asn_detalle OF Cuenta 
                            WHERE Asn_detalle.fecha >= des_fecha 
                              AND Asn_detalle.fecha <= has_fecha)
                      OR todas_cuent):                              
        

      RUN CALCULAR_SALDO. 

      EXPORT  Cuenta.cdg_cuenta
               Cuenta.nombre
               acm_debitos_per 
               acm_creditos_per 
               acm_debitos_tot 
               acm_creditos_tot.
  END.

  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO:

    acm_debitos_per  = 0. 
    acm_creditos_per = 0.
    acm_debitos_tot  = 0.
    acm_creditos_tot = 0.

   /* Busca por Acumulado_cuenta hasta el mes anterior a la fecha */
   FOR EACH Acumulado_cuenta OF Cuenta
       WHERE   DATE(Acumulado_cuenta.mes,1,Acumulado_cuenta.ano) < 
               DATE(MONTH(has_fecha),1,YEAR(has_fecha)):
                             
      acm_debitos_tot  = acm_debitos_tot  + Acumulado_cuenta.tot_debitos.
      acm_creditos_tot = acm_creditos_tot + Acumulado_cuenta.tot_creditos.

   END.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Asn_detalle OF Cuenta 
       WHERE Asn_detalle.fecha_mayor >= DATE(MONTH(has_fecha),1,YEAR(has_fecha)) 
         AND Asn_detalle.fecha_mayor <= has_fecha 
          BY fecha_mayor:

      acm_debitos_per  = acm_debitos_per  + Asn_detalle.debito.
      acm_creditos_per = acm_creditos_per + Asn_detalle.credito.


   END.

   acm_debitos_tot  = acm_debitos_tot  + acm_debitos_per.
   acm_creditos_tot = acm_creditos_tot + acm_creditos_per.

   saldo_per = acm_debitos_per  - acm_creditos_per.
   saldo_tot = acm_debitos_tot  - acm_creditos_tot.

END PROCEDURE.


