/*=================================================================================*/
/*           GENERA EL LISTADO DE BALANCE DE SUMAS Y SALDOS CLASIFICADO            */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-cdg_balance    AS CHARACTER.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE NEW SHARED STREAM listado.
DEFINE NEW SHARED VARIABLE c-linea AS INTEGER.

{SHVSUMYS.I "NEW"}

/*{SHTSUMYS.I "NEW"}*/

DEFINE VARIABLE l-saldo_acreed     LIKE Asn_detalle.debito  FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_deudor     LIKE Asn_detalle.debito  FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_per        LIKE Asn_detalle.debito  LABEL "Saldo"         FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_debitos_per  LIKE Asn_detalle.debito  LABEL "Acum.debitos"  FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_tot        LIKE Asn_detalle.debito  LABEL "Saldo"         FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_debitos_tot  LIKE Asn_detalle.debito  LABEL "Acum.debitos"  FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE que_subclase AS CHARACTER.
DEFINE VARIABLE que_archivo  AS CHARACTER.

DEFINE VARIABLE arch_salida AS CHARACTER.

DEFINE BUFFER   Clase  FOR Clase_de_cuenta.
DEFINE BUFFER Subclase FOR Clase_de_cuenta.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

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
que_empresa = Empresa.nombre.

/*FIND FIRST Clase WHERE Clase.cdg_clase = primer_nodo NO-LOCK.*/
FIND FIRST Clase WHERE Clase.cdg_clase = ? NO-LOCK.
/*tit_clase = Clase.nombre_subclase.

ASSIGN
  des_fecha   = p-des_fecha
  has_fecha   = p-has_fecha
  listar_hora = p-lis_fecha
  todas_cuent = p-todas_cuent. 
*/
SESSION:IMMEDIATE-DISPLAY = YES.             

DO TRANSACTION:
   FOR EACH Lst_sumysal EXCLUSIVE-LOCK:
       DELETE Lst_sumysal.
   END.
END.   

FOR EACH Cuenta:
    Cuenta.esta_restringida = YES.
END.

RUN recorrer_estructura.p ( INPUT ROWID(Clase), 
                            INPUT 0,
                            INPUT Empresa.cdg_empresa,
                            INPUT p-cdg_balance).

DO TRANSACTION:

   c-linea = c-linea + 1.
   CREATE Lst_sumysal.
   ASSIGN Lst_sumysal.cdg_empresa       = Empresa.cdg_empresa
          Lst_sumysal.cdg_nombalance    = p-cdg_balance
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

/* v-filtro =  "".                                                                        */
/*                                                                                        */
/* v-params = "p-listhora=" + STRING(listar_hora) + "~n" +                                */
/*            "p-fechas=" + STRING(des_fecha) + " al " + STRING(has_fecha) + "~n" +       */
/*            "p-empresa=" + Empresa.nombre + "~n" +                                      */
/*            "p-moneda=" + Moneda.descripcion + "~n" +                                   */
/*            "p-sinmov="  + IF todas_cuent THEN "S" ELSE "N" + "~n".                     */
/*                                                                                        */
/* RUN exreport.p (  INPUT  ".\prl\sic.prl",     /* Librería desde la que se ejecuta   */ */
/*                   INPUT  "Balance de Saldos", /* Nombre del reporte a ejecutar      */ */
/*                   INPUT  v-filtro,            /* Filtro de registros a imponer      */ */
/*                   INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */ */
/*                   INPUT  "",                  /* Impresora de destino del listado   */ */
/*                   INPUT  v-params             /* Parametros especificos del reporte */ */
/*                 ).                                                                     */

RUN verestructura.p ( INPUT "Plan de Cuentas Clasificado").

