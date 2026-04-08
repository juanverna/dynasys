
DEFINE NEW SHARED STREAM listado.

{SHVSUMPS.I}

DEFINE VARIABLE l-saldo_acreed     LIKE Aps_detalle.debito.
DEFINE VARIABLE l-saldo_deudor     LIKE Aps_detalle.debito.
DEFINE VARIABLE l-saldo_per        LIKE Aps_detalle.debito LABEL "Saldo".
DEFINE VARIABLE l-acm_debitos_per  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE l-acm_creditos_per LIKE Aps_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE l-saldo_tot        LIKE Aps_detalle.debito LABEL "Saldo".
DEFINE VARIABLE l-acm_debitos_tot  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE l-acm_creditos_tot LIKE Aps_detalle.credito LABEL "Acum.creditos".

DEFINE VARIABLE que_subclase AS CHARACTER.
DEFINE VARIABLE que_archivo  AS CHARACTER.

DEFINE BUFFER   Clase  FOR Clase_de_ctapsp.
DEFINE BUFFER Subclase FOR Clase_de_ctapsp.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE mensaje   AS CHARACTER FORMAT "X(40)".

FORM 
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE "Aguarde un momento por favor" 
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 4.

DEFINE NEW SHARED FRAME frm-titulo.
   {SHFCPSTI.I}

DEFINE NEW SHARED FRAME frm-clases.
   {SHFCPSCL.I}

DEFINE NEW SHARED FRAME frm-cuentas.
   {SHFCPSCU.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

IF listar_hora
THEN DO:
   fecha_lis = STRING(TODAY).
   hora_lis = STRING(TIME,"HH:MM:SS").
END.
ELSE DO:   
   fecha_lis = " ".
   hora_lis = " ".
END.
   
FIND FIRST Clase WHERE Clase.cdg_clase = primer_nodo NO-LOCK.
tit_clase = Clase.nombre_subclase.

SESSION:IMMEDIATE-DISPLAY = YES.             
mensaje = "    Listando ...".        
DISPLAY mensaje WITH FRAME frm-espere.
  
que_archivo = dire_tmp + "lssumcps.txt".
OUTPUT STREAM Listado TO VALUE(que_archivo).     
VIEW STREAM Listado FRAME frm-titulo.
RUN RCSUMCPS.P ( INPUT ROWID(Clase), 
                 INPUT 0, 
                 INPUT-OUTPUT l-acm_debitos_per,
                 INPUT-OUTPUT l-acm_creditos_per,
                 INPUT-OUTPUT l-acm_debitos_tot,
                 INPUT-OUTPUT l-acm_creditos_tot).

ASSIGN
   l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
   l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.

DISPLAY STREAM listado 
        "TOTAL GENERAL" @ Clase.nombre_subclase
        l-acm_debitos_per
        l-acm_creditos_per
        l-saldo_per
        l-acm_debitos_tot
        l-acm_creditos_tot
        l-saldo_tot
        WITH FRAME frm-clases.   
DOWN STREAM listado WITH FRAME frm-clases.

OUTPUT CLOSE.            
HIDE FRAME frm-espere NO-PAUSE.
RUN PRINFILE.P ( INPUT que_archivo, INPUT port ).

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

{CODIMPRE.I}


