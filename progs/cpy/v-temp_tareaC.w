&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
/*------------------------------------------------------------------------

  File:

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{findempresa.i}
{tiempo.i}
{crystal_dyna.p}
{advtexto.i}

DEFINE VAR h_vecinos AS HANDLE.
DEFINE BUFFER administrador FOR cliente.
DEFINE TEMP-TABLE trestriccion
    FIELD cdg_restriccion LIKE restriccion.cdg_restriccion
    FIELD valor LIKE cliente_restriccion.valor
    FIELD descripcion LIKE restriccion.descripcion
    INDEX cdg_restriccion cdg_restriccion.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME V1
&Scoped-define BROWSE-NAME BROWSE-7

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES trestriccion

/* Definitions for BROWSE BROWSE-8                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-8 trestriccion.cdg_restriccion trestriccion.valor trestriccion.descr   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-8   
&Scoped-define SELF-NAME BROWSE-8
&Scoped-define QUERY-STRING-BROWSE-8 FOR EACH trestriccion
&Scoped-define OPEN-QUERY-BROWSE-8 OPEN QUERY {&SELF-NAME} FOR EACH trestriccion.
&Scoped-define TABLES-IN-QUERY-BROWSE-8 trestriccion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-8 trestriccion


/* Definitions for FRAME V1                                             */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.hora_prevista Tarea.informa ~
Tarea.horas_estimadas 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS bemail RECT-10 BROWSE-8 b-resumen ~
b-resumen-2 bvecino totdeuda totdeuda-2 Brestricciones horario_de_atencion ~
BROWSE-7 
&Scoped-Define DISPLAYED-FIELDS Tarea.hora_prevista Tarea.informa ~
Tarea.horas_estimadas 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS fmin fmax frecursos hora_fin TCOPER ~
totdeuda totdeuda-2 horario_de_atencion v-texto 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */
&Scoped-define ADM-ASSIGN-FIELDS fmin Tarea.hora_prevista frecursos ~
hora_fin TCOPER Tarea.horas_estimadas 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cerrar V-table-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fcorte V-table-Win 
FUNCTION fcorte RETURNS DATE
  ( nro_admin AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fmoroso V-table-Win 
FUNCTION fmoroso RETURNS DATE
  ( nro_admin AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-agrega 
     IMAGE-UP FILE "img/add.gif":U
     LABEL "Agrega" 
     SIZE 5 BY 4.52.

DEFINE BUTTON b-resumen 
     LABEL "&Deuda" 
     SIZE 8 BY .91 TOOLTIP "Deuda con fecha de corte".

DEFINE BUTTON b-resumen-2 
     LABEL "&DT" 
     SIZE 7 BY .91 TOOLTIP "Deuda Total".

DEFINE BUTTON bemail 
     LABEL "Email" 
     SIZE 15.8 BY .91.

DEFINE BUTTON Bigual 
     LABEL "=" 
     SIZE 4 BY 1 TOOLTIP "Si iguala las fechas al cierre , asigna el evento.".

DEFINE BUTTON BRECURSOS 
     LABEL "Sel" 
     SIZE 4 BY 1.

DEFINE BUTTON Brestricciones 
     LABEL "Restricciones" 
     SIZE 15.8 BY .91.

DEFINE BUTTON Bresuelto 
     LABEL "Resuelto" 
     SIZE 16 BY .91.

DEFINE BUTTON bvecino 
     LABEL "Vecinos" 
     SIZE 15.8 BY .91.

DEFINE VARIABLE v-texto AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 59 BY 4.52
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE fmax AS DATE FORMAT "99/99/99":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fmin AS DATE FORMAT "99/99/99":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE frecursos AS CHARACTER FORMAT "X(8)" 
     LABEL "Recur" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1 TOOLTIP "Recursos asignados para realizar el evento".

DEFINE VARIABLE horario_de_atencion LIKE Cliente.horario_de_atencion
     VIEW-AS FILL-IN 
     SIZE 43 BY 1 TOOLTIP "Horario Habitual de atencion"
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE hora_fin AS CHARACTER FORMAT "X(5)":U INITIAL "?" 
     LABEL "Fin" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Hora prevista para la finalizacion" NO-UNDO.

DEFINE VARIABLE totdeuda AS CHARACTER FORMAT "X(256)":U 
     LABEL "Deuda" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 14 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE totdeuda-2 AS CHARACTER FORMAT "X(256)":U 
     LABEL "DeudaMo." 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.29 TOOLTIP "Administracion con Observacion"
     BGCOLOR 10 .

DEFINE VARIABLE TCOPER AS LOGICAL INITIAL no 
     LABEL "COPER" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.8 BY .81 TOOLTIP "Si es cobrada por el operario" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-8 FOR 
      trestriccion SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 V-table-Win _STRUCTURED
  
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 82 BY 4.52 ROW-HEIGHT-CHARS .57.

DEFINE BROWSE BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-8 V-table-Win _FREEFORM
  QUERY BROWSE-8 DISPLAY
      trestriccion.cdg_restriccion
trestriccion.valor
trestriccion.descr
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 56 BY 4.52
         BGCOLOR 14  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME V1
     bemail AT ROW 1 COL 73 WIDGET-ID 92
     BROWSE-8 AT ROW 1.14 COL 91 WIDGET-ID 300
     fmin AT ROW 1.48 COL 7 COLON-ALIGNED WIDGET-ID 20
     Bigual AT ROW 1.48 COL 23 WIDGET-ID 86
     fmax AT ROW 1.48 COL 25 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     Tarea.hora_prevista AT ROW 1.48 COL 56 COLON-ALIGNED WIDGET-ID 26
          LABEL "Inicio" FORMAT "X(5)"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1 TOOLTIP "Hora Previstade comienzo de la tarea"
     b-resumen AT ROW 1.95 COL 73 WIDGET-ID 8
     b-resumen-2 AT ROW 1.95 COL 82 WIDGET-ID 90
     frecursos AT ROW 2.67 COL 7 COLON-ALIGNED WIDGET-ID 66
     BRECURSOS AT ROW 2.67 COL 26 WIDGET-ID 36
     hora_fin AT ROW 2.67 COL 56 COLON-ALIGNED WIDGET-ID 72
     Tarea.informa AT ROW 2.76 COL 45.2 WIDGET-ID 94
          LABEL "Inf."
          VIEW-AS TOGGLE-BOX
          SIZE 7 BY .81 TOOLTIP "Si se informa en la agenda diaria"
     TCOPER AT ROW 2.81 COL 32.2 WIDGET-ID 84
     bvecino AT ROW 3 COL 73 WIDGET-ID 78
     totdeuda AT ROW 3.76 COL 7 COLON-ALIGNED WIDGET-ID 82
     Tarea.horas_estimadas AT ROW 3.76 COL 61 COLON-ALIGNED WIDGET-ID 70
          LABEL "Dur" FORMAT ">>9"
          VIEW-AS FILL-IN 
          SIZE 9 BY 1
     totdeuda-2 AT ROW 3.86 COL 38 COLON-ALIGNED WIDGET-ID 88
     Brestricciones AT ROW 3.95 COL 73 WIDGET-ID 42
     horario_de_atencion AT ROW 4.86 COL 20 COLON-ALIGNED HELP
          "" WIDGET-ID 12
          BGCOLOR 14 
     Bresuelto AT ROW 4.91 COL 73 WIDGET-ID 64
     BROWSE-7 AT ROW 5.95 COL 1.8 WIDGET-ID 200
     v-texto AT ROW 5.95 COL 84.8 NO-LABEL WIDGET-ID 50
     b-agrega AT ROW 5.95 COL 144.2 WIDGET-ID 52
     RECT-10 AT ROW 1.24 COL 42 WIDGET-ID 96
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tarea
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 9.57
         WIDTH              = 148.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}
{html.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME V1
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB BROWSE-8 RECT-10 V1 */
/* BROWSE-TAB BROWSE-7 Bresuelto V1 */
ASSIGN 
       FRAME V1:SCROLLABLE       = FALSE
       FRAME V1:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON b-agrega IN FRAME V1
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bigual IN FRAME V1
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BRECURSOS IN FRAME V1
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Bresuelto IN FRAME V1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fmax IN FRAME V1
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fmin IN FRAME V1
   NO-ENABLE 2                                                          */
/* SETTINGS FOR FILL-IN frecursos IN FRAME V1
   NO-ENABLE 2                                                          */
/* SETTINGS FOR FILL-IN horario_de_atencion IN FRAME V1
   LIKE = sic.Cliente. EXP-SIZE                                         */
ASSIGN 
       horario_de_atencion:READ-ONLY IN FRAME V1        = TRUE.

/* SETTINGS FOR FILL-IN Tarea.horas_estimadas IN FRAME V1
   2 EXP-LABEL EXP-FORMAT                                               */
/* SETTINGS FOR FILL-IN hora_fin IN FRAME V1
   NO-ENABLE 2                                                          */
/* SETTINGS FOR FILL-IN Tarea.hora_prevista IN FRAME V1
   2 EXP-LABEL EXP-FORMAT                                               */
/* SETTINGS FOR TOGGLE-BOX Tarea.informa IN FRAME V1
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX TCOPER IN FRAME V1
   NO-ENABLE 2                                                          */
ASSIGN 
       TCOPER:HIDDEN IN FRAME V1           = TRUE.

ASSIGN 
       totdeuda:READ-ONLY IN FRAME V1        = TRUE.

ASSIGN 
       totdeuda-2:READ-ONLY IN FRAME V1        = TRUE.

/* SETTINGS FOR EDITOR v-texto IN FRAME V1
   NO-ENABLE                                                            */
ASSIGN 
       v-texto:RETURN-INSERTED IN FRAME V1  = TRUE
       v-texto:READ-ONLY IN FRAME V1        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-8
/* Query rebuild information for BROWSE BROWSE-8
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH trestriccion.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-8 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME V1
/* Query rebuild information for FRAME V1
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME V1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME b-agrega
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-agrega V-table-Win
ON CHOOSE OF b-agrega IN FRAME V1 /* Agrega */
DO:
  v-texto = "".
  v-texto:READ-ONLY = FALSE.
  b-agrega:SENSITIVE = FALSE.
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-resumen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-resumen V-table-Win
ON CHOOSE OF b-resumen IN FRAME V1 /* Deuda */
DO:
  RUN resumen_cob(fcorte(cliente.nro_cliente)).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b-resumen-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-resumen-2 V-table-Win
ON CHOOSE OF b-resumen-2 IN FRAME V1 /* DT */
DO:
  RUN resumen_cob2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bemail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bemail V-table-Win
ON CHOOSE OF bemail IN FRAME V1 /* Email */
DO:
    
    {findempresa.i} 

  DEF VAR xfile AS CHAR NO-UNDO.
  DEF VAR ReportePath AS CHAR NO-UNDO.
  DEF VAR cFullPath AS CHAR NO-UNDO.
  DEF VAR xFullPath AS CHAR NO-UNDO.
  DEF VAR exportFileName AS CHAR NO-UNDO.
  DEFINE VARIABLE chApplication AS COM-HANDLE.
  DEFINE VARIABLE chReport      AS COM-HANDLE.
  DEF VARIABLE oSuccessful  AS LOGICAL NO-UNDO.
  DEF VARIABLE vmessage  AS CHAR NO-UNDO.
  DEFINE VAR i AS INT NO-UNDO.
  DEFINE VAR msg1 AS CHAR.
  DEFINE VAR msg2 AS CHAR.
  DEFINE VAR msg3 AS CHAR.
  DEFINE VAR msg4 AS CHAR.
  DEFINE VAR firma AS CHAR NO-UNDO.
  DEFINE VAR exfile AS CHAR NO-UNDO.
  DEFINE VAR img64 AS CHAR NO-UNDO.
  DEFINE VAR objMessage AS COM-HANDLE.
  DEFINE VAR objConf AS COM-HANDLE.
  DEFINE VAR objField AS COM-HANDLE.
  DEFINE VAR objBP AS COM-HANDLE.

  DEFINE VAR one AS LOGICAL INIT YES.
  DEFINE VAR savdir AS CHARACTER NO-UNDO.
  DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
  DEFINE VAR logof AS CHAR NO-UNDO.
  DEF VAR opc AS LOGICAL.
  DEFINE VAR em_email AS CHAR NO-UNDO.
  MESSAGE "Quiere enviar un mail con el pedido de fecha de cobranza" VIEW-AS ALERT-BOX QUESTION BUTTONS ok-cancel SET opc.
  IF NOT opc THEN RETURN NO-APPLY.
  savdir = getCurrentDirectory().
  RUN fullpath ( logo, INPUT "", OUTPUT logof ).
  FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
  FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
      LEAVE.
  END.
  IF NOT AVAILABLE USER_empresa THEN DO:
      MESSAGE "Usted tiene la direccion de email registrada" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
  IF USER_empresa.email = "" THEN DO:
      MESSAGE "Usted tiene la direccion de email registrada" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
  /*recuperando datos para enviar el email*/
  FIND cliente OF tarea NO-LOCK.
  FIND administrador WHERE cliente.nro_admin = administrador.nro_cliente NO-LOCK.
  FIND FIRST domicilio OF cliente NO-LOCK NO-ERROR.
  FOR each Cliente-contacto OF Domicilio , Persona OF Cliente-contacto WHERE persona.email <> "" AND  can-do(Cliente-contacto.canal-email,"COB") :
        em_email = em_email + "," + persona.email.
  END.
  IF em_email = "" THEN DO:
      MESSAGE "No hay definida una persona de contacto, el email no puede ser enviado" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
  em_email = SUBSTRING( em_email , 2 ).
  exfile = "DeudaconPaulista.pdf".
  exportFileName = SESSION:TEMP-DIR + exfile.
  OS-DELETE value(exportFileName).
  IF ERROR-STATUS:ERROR THEN DO:
      MESSAGE "El archivo " exportFileName " esta siendo usado por otro usuario" SKIP 
              "no se puede proseguir" VIEW-AS alert-box error.
      RETURN no-apply.
  END.
  RUN prinresumenes-email.p ( INPUT Empresa.cdg_empresa,
                               INPUT administrador.cdg_cliente,
                               INPUT administrador.cdg_cliente,
                               INPUT fcorte(administrador.nro_cliente),
                               INPUT 01/01/3000,
                               INPUT "*", /*todos los puntos de venta*/
                               INPUT 1,
                               INPUT fmoroso(administrador.nro_cliente) ,
                               OUTPUT xfile). 

  IF xfile = ? THEN DO:
      MESSAGE "No registra deuda no se envia el email" VIEW-AS ALERT-BOX INFORMATION.
      RETURN NO-APPLY.
  END.
  ReportePath = "pendiente_cobranemail.rpt".
  RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
  IF cFullPath = ? 
  THEN DO:
      RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
      RETURN NO-apply.
  END.

  CREATE "CrystalRuntime.Application" chApplication.
  chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
  chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
  xFullPath = xfile.
  chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
  RUN crearReporte(chReport,"pdf",/*ViewReport*/ NO,/*PrinterName*/ "",
                   /*exportToDisk*/ TRUE, INPUT-OUTPUT exportFileName ).
  IF ERROR-STATUS:ERROR THEN DO:     
          MESSAGE "Existio un problema al generar el reporte" SKIP "no puede continuar" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-APPLY.
  END.
  RELEASE OBJECT chReport. 
  chReport = ?.
  RELEASE OBJECT chApplication.
  chApplication = ?.
  RUN setCurrentDirectoryA(savDir).

  msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administrador.nom_cliente) + ':</font></p>'.
  msg3 = '<p><font face=Tahoma>Enviamos nuestro resumen de cuenta, el cual contiene el detalle de facturas y monto adeudado. </font></p><p><font face=Tahoma>En caso de haber facturas cuyo atraso en el pago es mayor al habitual, las encontrar&aacute; resaltadas.</font></p>'.
  msg4 = '<p><font face=Tahoma>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista cobranzas' + '</font></p>'.

  firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="www.paulistaservicios.com.ar" title="www.paulistaservicios.com.ar">www.paulistaservicios.com.ar</font></p><p></BODY></HTML>'.
  /*firma= '<p><font face=Tahoma>PAULISTA</font></p><p><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.*/
  msg2='<br><p><font face=Tahoma>Nos dirigimos a Uds. a fin de solicitar fecha y horario de pago del mes en curso.</font></p>'.

  /*mandando el email*/
  CREATE "CDO.Message" objMessage.
  CREATE "CDO.Configuration" objConf.
  objField = objConf:FIELDS.
  /*
  objField:Item( "http://schemas.microsoft.com/cdo/configuration/sendusing" ) = 1. /*cdoSendUsingPickup*/
  objField:Item( "http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory" ) = "c:\temp\pickup" .*/
  objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2. /*cdoSendUsingPort*/
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com". 
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465. 
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1.      
  objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "admin@paulistaservicios.com.ar".
  objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
  objField:Update.
  objMessage:Configuration = objConf.
  objMessage:TO = em_email.
  objMessage:FROM =  USER_empresa.email.
  /*objMessage:Subject = IF anal.accion = "EVENTO" AND anal.fecha<>? THEN "Paulista - Estado de deuda" ELSE "Paulista - Solicitud de fecha de pago".*/
  objMessage:Subject = "Paulista - Solicitud de fecha de pago".
  objMessage:HTMLBody = msg1 + msg2 + msg3 + msg4 + firma.
  /* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
  objMessage:AddAttachment( "file://" + exportFileName,"","" ).
  objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
  objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
  objBP:Fields:Update.
  objMessage:Send.
  FIND CURRENT tarea EXCLUSIVE-LOCK.  
  tarea.descripcion = agregaAdvTexto("EMAIL Estado deuda a " + em_email , tarea.descripcion ).
  FIND CURRENT tarea no-lock.  
  RELEASE OBJECT objField NO-ERROR.
  RELEASE OBJECT objBP NO-ERROR.
  RELEASE OBJECT objMessage NO-ERROR.
  RELEASE OBJECT objConf NO-ERROR.
  objConf=?.
  objMessage=?.  
  objBP=?. 
  objField = ?.
  MESSAGE "Enviado" VIEW-AS ALERT-BOX.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bigual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bigual V-table-Win
ON CHOOSE OF Bigual IN FRAME V1 /* = */
DO:
  fmax:SCREEN-VALUE = fmin:SCREEN-VALUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BRECURSOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRECURSOS V-table-Win
ON CHOOSE OF BRECURSOS IN FRAME V1 /* Sel */
DO:
  DEF VAR lista AS CHAR.
  lista = frecursos:SCREEN-VALUE.

  RUN d-recursos.w (INPUT-OUTPUT lista, string(tarea.nro_tipo_evento) ).
  frecursos:SCREEN-VALUE = lista.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Brestricciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Brestricciones V-table-Win
ON CHOOSE OF Brestricciones IN FRAME V1 /* Restricciones */
DO:
  RUN d-cliente_restriccion.w(cliente.nro_cliente).
  {&OPEN-QUERY-BROWSE-8}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bresuelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bresuelto V-table-Win
ON CHOOSE OF Bresuelto IN FRAME V1 /* Resuelto */
DO:
  RUN d-tarearesol.w (INPUT tarea.nro_tarea).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
&Scoped-define SELF-NAME BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-7 V-table-Win
ON VALUE-CHANGED OF BROWSE-7 IN FRAME V1
DO:
    IF AVAILABLE tttexto THEN v-texto = tttexto.ttexto.
    DISPLAY v-texto WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-8
&Scoped-define SELF-NAME BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-8 V-table-Win
ON VALUE-CHANGED OF BROWSE-8 IN FRAME V1
DO:
    IF AVAILABLE tttexto THEN v-texto = tttexto.ttexto.
    DISPLAY v-texto WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bvecino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bvecino V-table-Win
ON CHOOSE OF bvecino IN FRAME V1 /* Vecinos */
DO:
DEFINE VAR pnro_cliente LIKE cliente.nro_cliente.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR hcproc AS CHAR NO-UNDO.
DEFINE VAR pcdg_tipotarea LIKE tarea.cdg_tipotarea.
DEFINE VAR ii AS INT NO-UNDO.
DEFINE VAR geolat AS DECIMAL NO-UNDO.
DEFINE VAR geolong AS DECIMAL NO-UNDO.

RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "record-Source",
        OUTPUT hcproc ).
    /* Code placed here will execute PRIOR to standard behavior. */
hproc = WIDGET-HANDLE(hcproc).

IF NOT VALID-HANDLE(hproc) THEN DO:
    MESSAGE "No se puede obtener el handle del record-source" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

RUN damegeo IN hproc (OUTPUT geolat, OUTPUT geolong).
RUN dametipo IN hproc(OUTPUT pcdg_tipotarea).
IF geolat = 0 OR geolong = 0 THEN DO:
    MESSAGE "Referencia no esta correctamente geocodificada para obtener vecinos" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.


cerrar(h_vecinos).

RUN w-vecinosCO.w PERSISTENT SET h_vecinos ( tarea.nro_tarea,"T",5000,THIS-PROCEDURE,fmin:INPUT-VALUE,fmax:INPUT-VALUE,tarea.hora_prevista:INPUT-VALUE,hora_fin:INPUT-VALUE).
RUN dispatch IN h_vecinos ( INPUT 'initialize':U ) .
DYNAMIC-FUNCTION("tope" IN  h_vecinos ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fmax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fmax V-table-Win
ON MOUSE-MENU-CLICK OF fmax IN FRAME V1
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fmin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fmin V-table-Win
ON MOUSE-MENU-CLICK OF fmin IN FRAME V1 /* Fecha */
DO:
  {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.horas_estimadas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.horas_estimadas V-table-Win
ON LEAVE OF Tarea.horas_estimadas IN FRAME V1 /* Dur */
DO:
   IF aint(tarea.horas_estimadas:SCREEN-VALUE) <> 0 AND aint(tarea.hora_prevista:screen-value) <> 0 THEN DO:
        hora_fin:SCREEN-VALUE= ajuh(string(addmil(aint(tarea.hora_prevista:SCREEN-VALUE),int(tarea.horas_estimadas:SCREEN-VALUE)))).
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME hora_fin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL hora_fin V-table-Win
ON LEAVE OF hora_fin IN FRAME V1 /* Fin */
DO:
   DEFINE VAR i AS INT NO-UNDO.
   SELF:SCREEN-VALUE= ajuh(SELF:SCREEN-VALUE).
  IF aINT(hora_fin:SCREEN-VALUE) <> 0 AND 
      aINT(hora_prevista:SCREEN-VALUE) <> 0 THEN DO:
      i = INT(TRUNCATE( ( ahdec(aint(hora_fin:INPUT-VALUE) ) - ahdec( aint(hora_prevista:INPUT-VALUE) ) ) * 60 , 0 )).
      IF i < 0 THEN DO:
          MESSAGE "Mal la hora".
          RETURN NO-APPLY.
      END.
      
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME RECT-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL RECT-10 V-table-Win
ON MOUSE-SELECT-CLICK OF RECT-10 IN FRAME V1
DO:
   DEFINE BUFFER administrador FOR cliente.
   DEFINE VARIABLE puso_ok AS LOGICAL.
       FIND administrador WHERE administrador.nro_cliente = int( rect-10:PRIVATE-DATA ) NO-ERROR.
   IF AVAILABLE administrador THEN DO:
     IF administrador.observacion <> "" THEN DO:
        RUN c-edttexto.w ( INPUT-OUTPUT administrador.observacion,
                      INPUT "Observaciónes del administrador",
                      4,
                      OUTPUT puso_ok).
     END.
   END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TCOPER
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TCOPER V-table-Win
ON VALUE-CHANGED OF TCOPER IN FRAME V1 /* COPER */
DO:
ASSIGN tcoper.
  frecursos:HIDDEN = tcoper.
  brecursos:HIDDEN = tcoper.
  frecursos:SENSITIVE = NOT tcoper.
  brecursos:SENSITIVE = NOT tcoper.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tarea"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambia_cliente V-table-Win 
PROCEDURE cambia_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM p AS ROWID.
DEFINE BUFFER administrador FOR cliente.
    FIND cliente WHERE ROWID(cliente) = p NO-LOCK NO-ERROR.
    IF AVAILABLE cliente  THEN DO WITH FRAME {&FRAME-NAME}:
        /*ver el rect-10 de advertencias*/
        FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
        IF AVAILABLE administrador THEN DO:
            rect-10:PRIVATE-DATA = string(administrador.nro_administrador).
            IF administrador.observacion <> "" THEN DO:
                rect-10:BGCOLOR  = 12.
            END.
        ELSE rect-10:BGCOLOR = 10.
        END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME V1.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.
DEFINE VAR sal AS CHAR NO-UNDO.
DEFINE VAR vartemplate AS CHAR NO-UNDO.
DEFINE VAR resu AS CHAR NO-UNDO.
DEFINE VAR recno AS LOGICAL NO-UNDO.
DEFINE BUFFER btipo_evento FOR tipo_evento.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

IF Tarea.hora_prevista:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 THEN DO:
    MESSAGE "indique duracion de la tarea" VIEW-AS ALERT-BOX ERROR.
    RETURN error.
END.
FIND btipo_evento WHERE btipo_evento.cdg_tipo_evento = "CO" NO-LOCK.
recno = TRUE.
DO k = 1 TO num-entries(frecursos):
  FIND recurso WHERE recurso.cdg_recurso = ENTRY(k,frecursos) NO-LOCK NO-ERROR.
  IF NOT AVAILABLE recurso THEN do:
      recno = false.
      LEAVE.
  END.
  FIND FIRST recurso_habilidad OF Recurso 
       WHERE recurso_habilidad.nro_tipo_evento = btipo_evento.nro_tipo_evento NO-LOCK NO-ERROR.
  IF NOT AVAILABLE recurso_habilidad THEN do:
      recno = false.
      LEAVE.
  END.
END.
IF NOT recno THEN DO:
    MESSAGE "Ninguno de los recursos, tiene la habilidad necesaria para efectuar la tarea" 
    VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.



phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
sal = "".

vartemplate = "frecursos|fmin|fmax|hora_fin|TCOPER".
  DO WHILE VALID-HANDLE(hWidget):
    k = lookup(hWidget:NAME ,vartemplate, "|").
    IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
    DO:
        IF hWidget:TYPE = 'COMBO-BOX'  THEN 
            resu = hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
            resu = hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
            resu = hWidget:NAME + "|" +  IF hWidget:CHECKED THEN "yes" ELSE "no".
        ELSE resu = hWidget:NAME + "|" + hWidget:SCREEN-VALUE.
        IF resu <> ? THEN
            sal = sal + "|" + resu.
    END.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  
  /*para simplicidad de visualizacion de la tarea la restriccion de se pondra como CP*/
  FIND restriccion WHERE restriccion.cdg_restriccion = "CONFC" NO-LOCK NO-ERROR.
  IF AVAILABLE restriccion THEN DO:
    FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = cliente.nro_cliente AND
            cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN DO:
        IF cliente_restriccion.valor = ? THEN DO:
            MESSAGE "Hay un error en la restriccion CONFC corrijala" view-as alert-box error.
            RETURN ERROR.
        END.
     sal = sal + "|CP|" + entry(1,cliente_restriccion.valor,"|").
    END.
  END.
  Tarea.datos-template = substring(sal,2).
  tarea.descripcion = saveAdvTexto ( v-texto:INPUT-VALUE, INPUT TABLE tttexto ).
  tarea.nro_tipo_evento = btipo_evento.nro_tipo_evento.
  /*IF DATE(tarea.visualizar) < fmin THEN
    tarea.visualizar = fmin.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-destroy V-table-Win 
PROCEDURE local-destroy :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'destroy':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
    DEFINE VAR hcproc AS CHAR NO-UNDO.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

  DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = FALSE.
    hWidget = hWidget:NEXT-SIBLING.
  END.
  v-texto:READ-ONLY = TRUE.
  b-agrega:SENSITIVE = FALSE.
  brecursos:SENSITIVE = FALSE.
  bigual:SENSITIVE = FALSE.

  RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "sincro-target",
          OUTPUT hcproc ).
      /* Code placed here will execute PRIOR to standard behavior. */
    hproc = WIDGET-HANDLE(hcproc).

    IF VALID-HANDLE(hProc) THEN
          RUN local-enable-fields IN hproc  NO-ERROR.

  END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .


phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
IF AVAILABLE tarea THEN 
DO: 

    bresuelto:SENSITIVE = tarea.fecha_resuelto <> ?. 
    DO WHILE VALID-HANDLE(hWidget):
        k = lookup(hWidget:NAME ,Tarea.datos-template, "|").
        IF  k > 0 AND CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        DO:
            IF hWidget:TYPE = 'COMBO-BOX'  THEN
              hWidget:SCREEN-VALUE = ENTRY( k + 1 , tarea.datos-template , "|" ).
            ELSE IF CAN-QUERY( hWidget, 'INPUT-VALUE':U ) THEN
              hWidget:SCREEN-VALUE = ENTRY( k + 1  , tarea.datos-template  , "|" ).
            ELSE IF CAN-QUERY( hWidget, 'CHECKED':U ) THEN
              hWidget:CHECKED = LOGICAL(ENTRY( k + 1 , tarea.datos-template , "|" ) ).
            ELSE IF CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
              hWidget:SCREEN-VALUE = ENTRY( k + 1 , tarea.datos-template , "|" ).
        END.
        hWidget = hWidget:NEXT-SIBLING.
    END.

  RUN loadAdvTexto (tarea.descripcion,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
  
  hora_fin:SCREEN-VALUE = ajuh(hora_fin:SCREEN-VALUE).
  tarea.hora_prevista:SCREEN-VALUE= ajuh(tarea.hora_prevista).
  FIND cliente OF tarea NO-LOCK.
  horario_de_atencion:SCREEN-VALUE = cliente.horario_de_atencion.  
  EMPTY TEMP-TABLE trestriccion.
  FOR EACH cliente_restriccion OF cliente, restriccion OF cliente_restriccion:
        CREATE trestriccion.
        ASSIGN trestriccion.cdg_restriccion = restriccion.cdg_restriccion
               trestriccion.valor = cliente_restriccion.valor
               trestriccion.descrip = restriccion.descripcion.
  END.
  {&OPEN-QUERY-BROWSE-8}
  RUN deuda_administracion.p(cliente.nro_cliente,fcorte(cliente.nro_cliente),OUTPUT totdeuda).
  RUN deuda_administracion-corte.p(cliente.nro_cliente,fmoroso(cliente.nro_cliente),OUTPUT totdeuda-2).
    /*es coper?*/
    FIND restriccion WHERE restriccion.cdg_restriccion = "COPER" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN DO:
            MESSAGE "No se encuentra la restirccion COPER" VIEW-AS ALERT-BOX ERROR.
    END.
    FIND cliente_restriccion OF cliente WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF AVAILABLE cliente_restriccion THEN DO:
       tcoper:HIDDEN = FALSE.
       frecursos:HIDDEN = TRUE.
       brecursos:HIDDEN = TRUE.
    END.
    ELSE DO:
       tcoper:HIDDEN = TRUE.
       frecursos:HIDDEN = FALSE.
       brecursos:HIDDEN = FALSE.
    END.
    DISPLAY totdeuda totdeuda-2 WITH FRAME {&FRAME-NAME}.
    RUN loadAdvTexto(tarea.descripcion,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
    DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR k AS INT NO-UNDO.
DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.
DEFINE VAR phframe AS HANDLE NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
    DEFINE VAR hcproc AS CHAR NO-UNDO.
RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

phframe = FRAME {&FRAME-NAME}:HANDLE.
hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.

DO WHILE VALID-HANDLE(hWidget):
    IF  CAN-QUERY( hWidget, 'SCREEN-VALUE' ) THEN
        hWidget:SENSITIVE = TRUE.
    hWidget = hWidget:NEXT-SIBLING.
END.
b-agrega:SENSITIVE = TRUE.
brecursos:SENSITIVE = TRUE.
bigual:SENSITIVE = TRUE.

  RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "sincro-target",
          OUTPUT hcproc ).
      /* Code placed here will execute PRIOR to standard behavior. */
    hproc = WIDGET-HANDLE(hcproc).

    IF VALID-HANDLE(hProc) THEN
          RUN local-disable-fields IN hproc.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
totdeuda:TOOLTIP IN FRAME {&FRAME-NAME}= "Corte:" + STRING(fcorte(cliente.nro_cliente)).
totdeuda-2:TOOLTIP = "Corte:" + STRING(fmoroso(cliente.nro_cliente)).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resumen_cob V-table-Win 
PROCEDURE resumen_cob :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 
DEFINE INPUT PARAM pcorte AS DATE NO-UNDO.
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.

  RUN prinresumenes.p ( INPUT Empresa.cdg_empresa,
                             INPUT cliente.cdg_cliente,
                             INPUT cliente.cdg_cliente,
                             INPUT pcorte,
                             INPUT 01/01/3000,
                             INPUT "*", /*todos los puntos de venta*/
                             INPUT 1,
                             OUTPUT xfile). 
IF xfile = ? THEN do:
    MESSAGE "No hay deuda actual" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.

ReportePath = "resumen_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resumen_cob2 V-table-Win 
PROCEDURE resumen_cob2 :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.

  RUN prinresumenes.p ( INPUT Empresa.cdg_empresa,
                             INPUT cliente.cdg_cliente,
                             INPUT cliente.cdg_cliente,
                             INPUT TODAY,
                             INPUT 01/01/3000,
                             INPUT "*", /*todos los puntos de venta*/
                             INPUT 1,
                             OUTPUT xfile). 
IF xfile = ? THEN do:
    MESSAGE "No hay deuda actual" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
ReportePath = "resumen_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Tarea"}
  {src/adm/template/snd-list.i "trestriccion"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.
      
  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cerrar V-table-Win 
FUNCTION cerrar RETURNS LOGICAL
  ( hh AS WIDGET-HANDLE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
IF VALID-HANDLE(hh) THEN   do:
    RUN dispatch IN hh ( INPUT 'destroy':U ) . 
    RETURN TRUE.
END.
ELSE RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fcorte V-table-Win 
FUNCTION fcorte RETURNS DATE
  ( nro_admin AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VAR p-corte AS DATE.
    DEFINE VAR p-precorte AS DATE.
    p-precorte = DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1.
    p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
    FIND restriccion WHERE restriccion.cdg_restriccion = "CORTE" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN DO:
        MESSAGE "No existe la restriccion tipo CORTE" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    FIND cliente_restriccion WHERE cliente_restriccion.nro_cliente = nro_admin and
         cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente_restriccion THEN p-corte = p-precorte + 9.
    ELSE do:
            p-corte =TODAY - INT(cliente_restriccion.valor) NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 2 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 3 NO-ERROR.
            IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 4 NO-ERROR.
    END.
    REPEAT:
         IF es_habil(p-corte,"23456") THEN LEAVE.
         p-corte = p-corte + 1.
    END.
    /*p-corte esta ok*/
RETURN p-corte.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fmoroso V-table-Win 
FUNCTION fmoroso RETURNS DATE
  ( nro_admin AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR fpremoroso AS DATE NO-UNDO.
DEFINE VAR fmoroso AS DATE NO-UNDO.
DEFINE VAR p-precorte AS DATE NO-UNDO.
p-precorte = DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1.
p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
fpremoroso = DATE(MONTH(p-precorte - 1 ),1,YEAR(p-precorte - 1)).
fmoroso = fpremoroso + 9.
FIND restriccion WHERE restriccion.cdg_restriccion = "MOROSO" NO-LOCK NO-ERROR.
FIND cliente_restriccion OF restriccion WHERE cliente_restriccion.nro_cliente = nro_admin NO-LOCK NO-ERROR.
IF AVAILABLE cliente_restriccion 
THEN do:
fmoroso = TODAY - INT(cliente_restriccion.valor).
END.
REPEAT:
     IF es_habil(fmoroso,"23456") THEN LEAVE.
     fmoroso = fmoroso - 1.
END.

  RETURN fmoroso.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

