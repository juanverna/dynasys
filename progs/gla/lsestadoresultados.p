/*=================================================================================*/
/*           GENERA EL LISTADO DE ESTADO DE RESULTADOS                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-des_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-has_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER  p-reexpresion    AS LOGICAL.
DEFINE INPUT PARAMETER  p-cdg_nombalance AS CHARACTER.
DEFINE INPUT PARAMETER  p-lis_fecha      AS LOGICAL.
DEFINE INPUT PARAMETER  p-lin_pagina     AS INTEGER.
DEFINE INPUT PARAMETER  p-ult_pagina     AS INTEGER.
DEFINE INPUT PARAMETER  p-todas_cuent    AS LOGICAL.   

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE NEW SHARED STREAM listado.
DEFINE NEW SHARED VARIABLE c-linea     AS INTEGER.

{SHVSUMYS.I "NEW"}

/*{SHTSUMYS.I "NEW"}*/

DEFINE VARIABLE l-saldo_acreed     LIKE Asn_detalle.debito FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_deudor     LIKE Asn_detalle.debito FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_per        LIKE Asn_detalle.debito LABEL "Saldo" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_tot        LIKE Asn_detalle.debito LABEL "Saldo" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE que_subclase AS CHARACTER.
DEFINE VARIABLE que_archivo  AS CHARACTER.

DEFINE BUFFER   Clase  FOR Clase_de_cuenta.
DEFINE BUFFER Subclase FOR Clase_de_cuenta.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Balance de Sumas y Saldos según Clasificación de Cuentas" AT 52 
  "Pagina:" AT 150 PAGE-NUMBER FORMAT "ZZZ9" AT 157
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 150
  SKIP(1)
  /*
  "             Totales  del  periodo                       Totales  del  ejercicio" AT 44 SKIP
  "Codigo Descripcion" 
  "       Debitos       Creditos          Saldo        Debitos       Creditos          Saldo" AT 44 SKIP
  "------ -----------------------------------" 
  "-------------- -------------- -------------- -------------- -------------- --------------" AT 44 SKIP
  */
  WITH WIDTH 165 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.


DEFINE FRAME frm-listado
  Lst_sumysal.que_codigo       
  Lst_sumysal.que_nombre       
  Lst_sumysal.saldo_per        
  Lst_sumysal.acm_debitos_per  
  Lst_sumysal.acm_creditos_per 
  Lst_sumysal.saldo_tot        
  Lst_sumysal.acm_debitos_tot  
  Lst_sumysal.acm_creditos_tot 
  WITH WIDTH 165 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX
       FRAME frm-listado FONT 2.


DEFINE VARIABLE mensaje   AS CHARACTER FORMAT "X(40)".

FORM 
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE "Aguarde un momento por favor" 
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 4.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
FIND FIRST Clase WHERE Clase.cdg_clase = ? NO-LOCK.
/*
FIND FIRST Clase 
    WHERE Clase.cdg_clase = ? 
      AND Clase.cdg_librocontable = p-cdg_nombalance NO-LOCK.
*/
tit_clase = Clase.nombre_subclase.

ASSIGN
  des_fecha   = p-des_fecha
  has_fecha   = p-has_fecha
  listar_hora = p-lis_fecha
  todas_cuent = p-todas_cuent. 

SESSION:IMMEDIATE-DISPLAY = YES.             

DO TRANSACTION:
   FOR EACH Lst_sumysal EXCLUSIVE-LOCK:
       DELETE Lst_sumysal.
   END.
END.   

RUN recorrer_cuentas_resultado.p ( INPUT ROWID(Clase), 
                                   INPUT 0, 
                                   INPUT Empresa.cdg_empresa,
                                   INPUT p-cdg_nombalance,
                                   INPUT Moneda.nro_moneda,
                                   INPUT p-des_fecha,
                                   INPUT p-has_fecha,
                                   INPUT-OUTPUT l-acm_debitos_per,
                                   INPUT-OUTPUT l-acm_creditos_per,
                                   INPUT-OUTPUT l-acm_debitos_tot,
                                   INPUT-OUTPUT l-acm_creditos_tot).

ASSIGN
   l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
   l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.

DO TRANSACTION:

   c-linea = c-linea + 1.
   CREATE Lst_sumysal.
   ASSIGN Lst_sumysal.cdg_empresa       = Empresa.cdg_empresa
          Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
          Lst_sumysal.que_codigo        = FILL("-",10)
          Lst_sumysal.que_nombre        = FILL("-",35)
          Lst_sumysal.acm_debitos_per   = 0
          Lst_sumysal.acm_creditos_per  = 0
          Lst_sumysal.saldo_per         = 0
          Lst_sumysal.acm_creditos_tot  = 0
          Lst_sumysal.acm_debitos_tot   = 0
          Lst_sumysal.saldo_tot         = 0
          Lst_sumysal.linea             = c-linea.

   c-linea = c-linea + 1.
   CREATE Lst_sumysal.
   ASSIGN Lst_sumysal.cdg_empresa       = Empresa.cdg_empresa
          Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
          Lst_sumysal.que_codigo        = ""
          Lst_sumysal.que_nombre        = "TOTAL GENERAL"
          Lst_sumysal.acm_debitos_per   = l-acm_debitos_per
          Lst_sumysal.acm_creditos_per  = l-acm_creditos_per
          Lst_sumysal.saldo_per         = l-saldo_per
          Lst_sumysal.acm_creditos_tot  = l-acm_creditos_tot
          Lst_sumysal.acm_debitos_tot   = l-acm_debitos_tot
          Lst_sumysal.saldo_tot         = l-saldo_tot
          Lst_sumysal.linea             = c-linea.

   c-linea = c-linea + 1.
   CREATE Lst_sumysal.
   ASSIGN Lst_sumysal.cdg_empresa       = Empresa.cdg_empresa
          Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
          Lst_sumysal.que_codigo        = FILL("-",10)
          Lst_sumysal.que_nombre        = FILL("-",35)
          Lst_sumysal.acm_debitos_per   = 0
          Lst_sumysal.acm_creditos_per  = 0
          Lst_sumysal.saldo_per         = 0
          Lst_sumysal.acm_creditos_tot  = 0
          Lst_sumysal.acm_debitos_tot   = 0
          Lst_sumysal.saldo_tot         = 0
          Lst_sumysal.linea             = c-linea.

END.

/*=================================================================================*/
/*           INVOCA AL REPORT BUILDER PARA VER EL BALANCE                          */
/*=================================================================================*/

v-filtro =  "".

v-params = "p-listhora=" + STRING(listar_hora) + "~n" + 
           "p-moneda=" + Moneda.descripcion + "~n" + 
           "p-fechas=" + STRING(des_fecha) + " al " + STRING(has_fecha) + "~n" + 
           "p-empresa=" + Empresa.nombre + "~n" +
           "p-sinmov="  + IF todas_cuent THEN "S" ELSE "N" + "~n".

RUN exreport.p (  INPUT  ".\prl\sic.prl",     /* Librería desde la que se ejecuta   */
                  INPUT  "Estado de Resultados", /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,            /* Filtro de registros a imponer      */
                  INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                  /* Impresora de destino del listado   */
                  INPUT  v-params             /* Parametros especificos del reporte */
                ).   

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/
                                                          
