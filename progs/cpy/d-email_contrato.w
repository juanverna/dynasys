&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation. All rights    *
* reserved. Prior versions of this work may contain portions         *
* contributed by participants of Possenet.                           *
*                                                                    *
*********************************************************************/
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
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
  {advtexto.i}
{crystal_dyna.p}
{impresoras.i}  
{html.i}
{findempresa.i}
/* Local Variable Definitions ---                                       */

DEFINE INPUT PARAMETER pcontrato LIKE contrato_hd.nro_contrato NO-UNDO.
DEFINE TEMP-TABLE tcontrato_hd LIKE contrato_hd
      FIELD administracion AS CHAR
      FIELD TOTAL_anticipo_cf AS DECIMAL
      FIELD TOTAL_cuota1_cf AS DECIMAL
      FIELD cuota_cf AS DECIMAL.

DEFINE TEMP-TABLE tcontrato_dt LIKE contrato_dt.
DEFINE DATASET dset FOR tcontrato_hd,tcontrato_dt 
      DATA-RELATION FOR tcontrato_hd, tcontrato_dt  NESTED
      RELATION-FIELDS ( nro_contrato,nro_contrato).
DEFINE STREAM errores.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Persona

/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define FIELDS-IN-QUERY-D-Dialog Persona.tratamiento Persona.nombre ~
Persona.email 
&Scoped-define ENABLED-FIELDS-IN-QUERY-D-Dialog Persona.tratamiento ~
Persona.nombre Persona.email 
&Scoped-define ENABLED-TABLES-IN-QUERY-D-Dialog Persona
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-D-Dialog Persona
&Scoped-define QUERY-STRING-D-Dialog FOR EACH Persona SHARE-LOCK
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Persona SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Persona
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Persona


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Persona.tratamiento Persona.nombre ~
Persona.email 
&Scoped-define ENABLED-TABLES Persona
&Scoped-define FIRST-ENABLED-TABLE Persona
&Scoped-Define ENABLED-OBJECTS adic Btn_OK 
&Scoped-Define DISPLAYED-FIELDS Persona.tratamiento Persona.nombre ~
Persona.email 
&Scoped-define DISPLAYED-TABLES Persona
&Scoped-define FIRST-DISPLAYED-TABLE Persona
&Scoped-Define DISPLAYED-OBJECTS adic 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ver_anticipos D-Dialog 
FUNCTION ver_anticipos RETURNS DECIMAL
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ver_couta1 D-Dialog 
FUNCTION ver_couta1 RETURNS DECIMAL
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Enviar email" 
     SIZE 97 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE adic AS CHARACTER 
     VIEW-AS EDITOR NO-WORD-WRAP MAX-CHARS 5000 SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL LARGE
     SIZE 137.6 BY 6.67 TOOLTIP "Este texto no se almacena solo queda en el cuerpo del email" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Persona SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     adic AT ROW 2.19 COL 1 NO-LABEL WIDGET-ID 6
     Persona.tratamiento AT ROW 9.57 COL 13 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 15.6 BY 1
     Persona.nombre AT ROW 9.57 COL 40 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 37 BY 1
     Persona.email AT ROW 9.57 COL 88 COLON-ALIGNED WIDGET-ID 8 FORMAT "X(300)"
          VIEW-AS FILL-IN 
          SIZE 49 BY 1 TOOLTIP "Emails separados por ;"
     Btn_OK AT ROW 11.48 COL 22
     "Cuerpo del mensaje" VIEW-AS TEXT
          SIZE 136 BY .62 TOOLTIP "Uyilize html para efectos especiales" AT ROW 1.48 COL 2 WIDGET-ID 4
     SPACE(1.39) SKIP(10.99)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Presupuesto - Email"
         DEFAULT-BUTTON Btn_OK WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   FRAME-NAME                                                           */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

ASSIGN 
       adic:RETURN-INSERTED IN FRAME D-Dialog  = TRUE.

/* SETTINGS FOR FILL-IN Persona.email IN FRAME D-Dialog
   EXP-FORMAT                                                           */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _TblList          = "sic.Persona"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON GO OF FRAME D-Dialog /* Presupuesto - Email */
DO:
  DEFINE var adtest AS CHAR INITIAL "" NO-UNDO.
  DEF VAR ReportePath AS CHAR NO-UNDO.
  DEF VAR xFullPath AS CHAR NO-UNDO.
  DEF VAR cFullPath AS CHAR NO-UNDO.


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


  DEFINE VAR one AS LOGICAL INIT YES.
  DEFINE VAR savdir AS CHARACTER NO-UNDO.
  DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
  DEFINE VAR logof AS CHAR NO-UNDO.
  DEFINE BUFFER administracion FOR cliente.
  DEFINE VAR k AS INT NO-UNDO.
  DEF VAR anticip AS DECIMAL NO-UNDO.

  DEFINE VAR objBP AS COM-HANDLE.

  
  
  ASSIGN FRAME {&FRAME-NAME} adic.
  savdir = getCurrentDirectory().
  RUN fullpath ( logo, INPUT "", OUTPUT logof ).
  FIND usuario WHERE usuario.cdg_usuario = USERID("sic").
  FOR EACH user_empresa OF usuario BY  User_empresa.rige_desde DESC:
      LEAVE.
  END.
  IF NOT AVAILABLE USER_empresa THEN DO:
      MESSAGE "Usted no tiene la direccion de email registrada" skip
              "no se enviara email" .
      RETURN NO-apply.
  END.

  IF USER_empresa.email = "" THEN DO:
      MESSAGE "Usted no tiene direccion de email registrada" SKIP
              "no se enviara el email" .
      RETURN NO-apply.
  END.

  FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = contrato_hd.nro_tipo_evento NO-LOCK NO-ERROR.
  IF NOT AVAILABLE tipo_evento  THEN DO:
        MESSAGE "Este tipo de evento no genera presupuesto" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
  END.
  ReportePath = entry(1,tipo_evento.template,".").
  RUN fullPath (ReportePath, '.rpt':U, OUTPUT ReportePath).
  IF ReportePath = ? THEN DO:
            MESSAGE "No se puede imprimir este contrato como un presupuesto" SKIP 
                    "verifique el tipo de contrato y los demas datos" VIEW-AS ALERT-BOX INFORMATION.
  END.
  
  IF adtest = "" THEN
      OUTPUT STREAM errores TO c:\dynasys10\logs\emailpresup.txt APPEND.

  
    /*impresion de un presupuesto de contrato*/
    EMPTY TEMP-TABLE tcontrato_hd.
    EMPTY TEMP-TABLE tcontrato_dt.
    FIND cliente OF contrato_hd NO-LOCK.
    FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK.
    CREATE tcontrato_hd.
    BUFFER-COPY contrato_hd TO tcontrato_hd.
    tcontrato_hd.direccion = cliente.direccion.
    tcontrato_hd.nombre = cliente.nom_cliente.
    tcontrato_hd.administracion = administracion.nom_cliente.

    FOR EACH contrato_dt OF contrato_hd.
        CREATE tcontrato_dt.
        BUFFER-COPY contrato_dt TO tcontrato_dt.
        IF NOT contrato_dt.solocuota1 THEN DO:
          IF contrato_hd.cant_periodos > 0 THEN DO:
            tcontrato_dt.documental = replace( tcontrato_dt.documental , "&VALOR" , string(tcontrato_dt.subtotal_neto_cf / contrato_hd.cant_periodos,">>>>>.99" )).
            tcontrato_dt.documental = replace( tcontrato_dt.documental , "&CUOTAS" , string( contrato_hd.cant_periodos )).
          END.
          anticip = ver_anticipos().
          IF anticip <> 0 AND contrato_hd.nro_tipo_evento = 3 THEN 
                tcontrato_dt.documental = tcontrato_dt.documental + " , Anticipo de $" + string(anticip,">>>>>9.99") .
        END.
    END.
    tcontrato_hd.total_cuota1_cf = ver_couta1().
    tcontrato_hd.total_anticipo_cf = ver_anticipos().
    tcontrato_hd.cuota_cf = ( contrato_hd.imp_total - tcontrato_hd.total_anticipo_cf ) / contrato_hd.cant_periodos.

    xfile = TempFile("") + ".xml".
    
    DATASET dset:WRITE-XML ("FILE", xfile, FALSE,?,"",YES,YES).

    exportFileName=replace(cliente.direccion," " , "_"  ).
    exportFileName=replace(exportFileName,"/" , "_"  ).
    exportFileName=replace(exportFileName,"*" , "_"  ).
    exportFileName=replace(exportFileName,"\" , "_"  ).
    exportFileName=replace(exportFileName,'"' , "_"  ).
    exportFileName=replace(exportFileName,"'" , "_"  ).
    exportFileName=replace(exportFileName,"|" , "_"  ).
    exportFileName=replace(exportFileName,"<" , "_"  ).
    exportFileName=replace(exportFileName,">" , "_"  ).
    exportFileName = SESSION:TEMP-DIR + "Presup_" + exportFileName + ".pdf".
    IF SEARCH( exportFileName ) <> ? THEN DO:
        OS-DELETE value(exportFileName).
        IF ERROR-STATUS:ERROR THEN DO:
            MESSAGE "El archivo " exportFileName " esta siendo usado por otro usuario" SKIP 
                    "no se puede proseguir" .
            RETURN NO-apply.
        END.
    END.

    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(ReportePath, {&crOpenReportByTempCopy}).
    chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile  , INPUT "", OUTPUT xFullPath ).
    chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
    RUN crearReporte(chReport,"pdf",/*ViewReport*/ no,/*PrinterName*/ "",
                 /*exportToDisk*/ TRUE, INPUT-OUTPUT exportFileName ).
    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    chApplication = ?.
    OS-DELETE value(xfile).

  RUN setCurrentDirectoryA(savDir).
  /*msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode(administracion.nom_cliente) + '</font></p>'.
  msg2 = '<p><font face=Tahoma>Enviamos nuestro presupuesto N&deg;'+contrato_hd.nro_contrato+' referido a ' + html-encode(cliente.direccion) + '. </font></p>'.
  msg3 = '<p><font face=Tahoma>' + html-encode(adic) + '</font></p>'.
  msg4 = '<p><font face=Tahoma>Quedamos a sus órdenes para cualquier aclaracion necesaria.</p><p>Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra pol&iacute;tica de calidad persigue su entera satisfacci&oacute;n y la de sus clientes.</font></p><p><font face=Tahoma>Aprovechamos la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Paulista' + '</font></p>'.
  */
  adic = html-encode(adic).
  adic = REPLACE(adic,CHR(10),"<BR>").
  msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>' + adic + '</font></p>'.
  firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="www.paulistaservicios.com.ar" title="www.paulistaservicios.com.ar">www.paulistaservicios.com.ar</font></p></BODY></HTML>'.
  /*firma= '<p><font face=Tahoma>PAULISTA</font></p><p><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.*/

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
  objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = USER_empresa.email.
  objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "joseantonio$568".      
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
  objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  
  objField:Update.
  objMessage:Configuration = objConf.
  objMessage:TO = IF adtest = "" THEN persona.email:SCREEN-VALUE ELSE adtest.
  objMessage:FROM =  USER_empresa.email.
  objMessage:BCC =  "fernando@paulistaservicios.com.ar".
  objMessage:Subject = "Paulista - Presupuesto " + html-encode(cliente.direccion).
  objMessage:HTMLBody = msg1 + /*msg2 + msg3 + msg4 +*/ firma.
  /* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
  objMessage:AddAttachment( "file://" + exportFileName,"","" ).
  objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
  objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
  objBP:Fields:Update.
  objMessage:Send.
  
  IF ERROR-STATUS:ERROR THEN do:
      RELEASE OBJECT objField NO-ERROR.
      RELEASE OBJECT objBP NO-ERROR.
      RELEASE OBJECT objMessage NO-ERROR.
      RELEASE OBJECT objConf NO-ERROR.
      IF adtest = "" THEN PUT STREAM errores now "No enviado " contrato_hd.nro_contrato SKIP.
      MESSAGE "Error al enviar el email" VIEW-AS ALERT-BOX ERROR.
  END.
  ELSE DO:
      IF adtest = "" THEN do:
        PUT STREAM errores now contrato_hd.nro_contrato SKIP.
        FIND LAST tarea WHERE tarea.destino = "CONTRATO" AND tarea.nro_destino = contrato_hd.nro_contrato EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE tarea THEN DO: 
           IF adtest = "" THEN tarea.descripcion = agregaAdvTexto ( "EMAIL ENVIO Presupuesto " + persona.email:SCREEN-VALUE , tarea.descripcion ).
        END.
        ELSE DO:
            MESSAGE "La tarea para el presup " + string(contrato_hd.nro_contrato) + " no esta disponible" VIEW-AS ALERT-BOX ERROR.
        END.
      END.
      RELEASE tarea.
      RELEASE OBJECT objField NO-ERROR.
      RELEASE OBJECT objBP NO-ERROR.
      RELEASE OBJECT objMessage NO-ERROR.
      RELEASE OBJECT objConf NO-ERROR.
      IF adtest = "" THEN OUTPUT STREAM errores CLOSE.
      objConf=?.
      objMessage=?.  
      objBP=?. 
      objField = ?.
      APPLY "windows-close" TO SELF.
  END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Presupuesto - Email */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
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
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY adic 
      WITH FRAME D-Dialog.
  IF AVAILABLE Persona THEN 
    DISPLAY Persona.tratamiento Persona.nombre Persona.email 
      WITH FRAME D-Dialog.
  ENABLE adic Persona.tratamiento Persona.nombre Persona.email Btn_OK 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER administracion FOR cliente.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  FIND contrato_hd WHERE contrato_hd.nro_contrato = pcontrato no-lock.
  FIND cliente OF contrato_hd NO-LOCK.
  FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK.
  FIND persona NO-LOCK OF contrato_hd  NO-ERROR.
  IF NOT AVAILABLE persona THEN DO:
      MESSAGE "No esta disponible ninguna persona en el contrato" VIEW-AS ALERT-BOX ERROR.
      RETURN ERROR.
  END.
  DISPLAY persona.tratamiento persona.nombre persona.email WITH FRAME {&FRAME-NAME}.
  IF persona.email = "" THEN do:
      MESSAGE "La perona NO tiene email" VIEW-AS ALERT-BOX ERROR.
      RETURN ERROR.
  END.
  adic = 'Atte Adm. '  + html-encode(administracion.nom_cliente) + chr(10) + 
      'Enviamos nuestro presupuesto N° ' + string(contrato_hd.nro_contrato) + ' referido a ' + html-encode(cliente.direccion) + chr(10) + 
      'Quedamos a sus órdenes para cualquier aclaración necesaria.' + CHR(10) +
      'Recuerde comunicarnos cualquier inquietud relacionada con nuestros servicios, nuestra política de calidad persigue su entera satisfacción y la de sus clientes.' + chr(10) + 
      'Aprovechamos la oportunidad para saludarlo atte. Paulista' .
  DISPLAY adic WITH FRAME {&FRAME-NAME}.
  adic:SENSITIVE=TRUE.
  persona.tratamiento:SENSITIVE = TRUE. 
  persona.nombre:SENSITIVE = TRUE.
  persona.email:SENSITIVE = TRUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Persona"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ver_anticipos D-Dialog 
FUNCTION ver_anticipos RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF VAR va AS DECIMAL NO-UNDO.
    va = 0.
    FOR EACH contrato_DT OF contrato_hd:
        va = va + contrato_DT.anticipo_cf.
    END.
    RETURN va.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ver_couta1 D-Dialog 
FUNCTION ver_couta1 RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF VAR vv AS DECIMAL NO-UNDO.
    vv = 0.
    FOR EACH contrato_DT OF contrato_hd WHERE contrato_DT.solocuota1:
        vv = vv + contrato_DT.subtotal_gral.
    END.
    RETURN vv.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

