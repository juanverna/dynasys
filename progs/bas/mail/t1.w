&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
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

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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
  DEFINE VAR savdir AS CHARACTER NO-UNDO.
{crystal_dyna.p}
{html.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-15 BUTTON-17 BUTTON-16 BUTTON-18 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-15 
     LABEL "CDO" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-16 
     LABEL "IMAP" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-17 
     LABEL "CDO subj Externo" 
     SIZE 24 BY 1.14.

DEFINE BUTTON BUTTON-18 
     LABEL "CDO JS" 
     SIZE 15 BY 1.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-15 AT ROW 5.05 COL 25 WIDGET-ID 2
     BUTTON-17 AT ROW 5.05 COL 48 WIDGET-ID 6
     BUTTON-16 AT ROW 8.38 COL 28 WIDGET-ID 4
     BUTTON-18 AT ROW 11.48 COL 25 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 17 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 17
         WIDTH              = 80
         MAX-HEIGHT         = 31.95
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 31.95
         VIRTUAL-WIDTH      = 256
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  RUN setCurrentDirectoryA(savDir).
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-15 W-Win
ON CHOOSE OF BUTTON-15 IN FRAME F-Main /* CDO */
DO:
DEFINE VAR objMessage AS COM-HANDLE NO-UNDO.
DEFINE VAR objConf AS COM-HANDLE NO-UNDO.
DEFINE VAR objField AS COM-HANDLE NO-UNDO.
DEFINE VAR objBP AS COM-HANDLE.
DEFINE VAR msg1 AS CHAR NO-UNDO.
DEFINE VAR msg2 AS CHAR NO-UNDO.
DEFINE VAR msg3 AS CHAR  NO-UNDO.
DEFINE VAR msg4 AS CHAR NO-UNDO.
DEFINE VAR firma AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.
DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR logof AS CHAR NO-UNDO.

DEFINE VAR accion AS CHAR INITIAL "EVENTO".
savdir = getCurrentDirectory().
RUN fullpath ( logo, INPUT "", OUTPUT logof ).
exportFileName = "DeudaconPaulista.pdf".
exportFileName = SESSION:TEMP-DIR + exportFileName.

msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode( "FERNANDO" ) + ':</font></p>'.
msg3 = '<p><font face=Tahoma>Enviamos nuestro resumen de cuenta, el cual contiene el detalle de facturas y monto adeudado. </font></p>'.
msg4 = '<p><font face=Tahoma>Recuerde comunicarnos cualquier problema o necesidad especial relacionado con nuestros servicios. Nuestra pol&iacute;tica de calidad persigue la entera satisfacci&oacute;n suya y de sus clientes. </font></p><p><font face=Tahoma>Aprovecho la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Fernando-usuario' + '</font></p>'.

firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.
/*firma= '<p><font face=Tahoma>PAULISTA</font></p><p><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.*/
IF accion = "EVENTO" THEN msg2 = '<p><font face=Tahoma>La cobradora concurrira a sus oficinas el dia ' + STRING(06/01/2011) + '</font></p>'.
ELSE msg2='<br><p><font face=Tahoma>Nos dirigimos a Uds. a fin de solicitar fecha y horario de pago del mes en curso.</font></p>'.

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
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "fvergniaud@paulistaservicios.com.ar".
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "alcaudon".      
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  


objField:Update.

objMessage:Configuration = objConf.
objMessage:TO = "fvergniaud@fvsys.com.ar".
objMessage:FROM = "fvergniaud@paulistaservicios.com.ar".
objMessage:Subject = IF accion = "EVENTO" THEN "Paulista - Estado de deuda" ELSE "Paulista - Solicitud de fecha de pago".
objMessage:HTMLBody = msg1 + msg2 + msg3 + msg4 + firma.
/* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
objMessage:AddAttachment( "file://" + exportFileName,"","" ).
objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
objBP:Fields:Update.


objMessage:Send.

RELEASE OBJECT objMessage NO-ERROR.
RELEASE OBJECT objConf NO-ERROR.
objConf=?.
objMessage=?.  
objBP=?.
objField=?.
RUN setCurrentDirectoryA(savDir).
MESSAGE "Listo!".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-16
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-16 W-Win
ON CHOOSE OF BUTTON-16 IN FRAME F-Main /* IMAP */
DO:
DEFINE VAR objMail AS COM-HANDLE.
DEFINE VAR objSession AS COM-HANDLE.
DEFINE VAR objMessage AS COM-HANDLE.
DEFINE VAR objRecip AS COM-HANDLE.
DEFINE VAR objAttach AS COM-HANDLE.
DEFINE VAR msg1 AS CHAR.
DEFINE VAR msg2 AS CHAR.
DEFINE VAR msg3 AS CHAR.
DEFINE VAR msg4 AS CHAR.
DEFINE VAR firma AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

DEFINE VAR accion AS CHAR INITIAL "EVENTO".
savdir = getCurrentDirectory().
exportFileName = "DeudaconPaulista.pdf".
exportFileName = SESSION:TEMP-DIR + exportFileName.

msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode( "FERNANDO" ) + ':</font></p>'.
msg3 = '<p><font face=Tahoma>Enviamos nuestro resumen de cuenta, el cual contiene el detalle de facturas y monto adeudado. </font></p>'.
msg4 = '<p><font face=Tahoma>Recuerde comunicarnos cualquier problema o necesidad especial relacionado con nuestros servicios. Nuestra pol&iacute;tica de calidad persigue la entera satisfacci&oacute;n suya y de sus clientes. </font></p><p><font face=Tahoma>Aprovecho la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Fernando-usuario' + '</font></p>'.

/*firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.*/
firma= '<p><font face=Tahoma>PAULISTA</font></p><p><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.
IF accion = "EVENTO" THEN msg2 = '<p><font face=Tahoma>La cobradora concurrira a sus oficinas el dia ' + STRING(06/01/2011) + '</font></p>'.
ELSE msg2='<br><p><font face=Tahoma>Nos dirigimos a Uds. a fin de solicitar fecha y horario de pago del mes en curso.</font></p>'.

/*mandando el email*/

CREATE "MAPI.SESSION" objSession.
objSession:Logon("outlook",,FALSE).

objMessage = objSession:OutBox:Messages:Add().
objMessage:Subject = IF accion = "EVENTO" THEN "Paulista - Estado de deuda" ELSE "Paulista - Solicitud de fecha de pago".
objMessage:Type = "Text/HTML".
objMessage:Text = msg1 + msg2 + msg3 + msg4 + firma.


objRecip = objMessage:Recipients:Add().
objRecip:Name = "fvergniaud@fvsys.com.ar".
objRecip:Type = 1.
objRecip:Resolve.

ObjAttach = objMessage:Attachments:Add().
ObjAttach:Name = "Estado de Cuenta".
ObjAttach:POSITION = 0.
ObjAttach:Source = exportFileName.

objMessage:Update(TRUE, TRUE).
objMessage:Send(TRUE, FALSE).
objSession:Logoff.


RELEASE OBJECT objMail NO-ERROR.
RELEASE OBJECT objAttach NO-ERROR.
RELEASE OBJECT objRecip NO-ERROR.
RELEASE OBJECT objMessage NO-ERROR.
RELEASE OBJECT objSession NO-ERROR.
objAttach=?.
objRecip=?.    
objMessage=?.  
objSession=?.  
RUN setCurrentDirectoryA(savDir).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-17
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-17 W-Win
ON CHOOSE OF BUTTON-17 IN FRAME F-Main /* CDO subj Externo */
DO:


DEFINE VAR objMessage AS COM-HANDLE.
DEFINE VAR objConf AS COM-HANDLE.
DEFINE VAR objField AS COM-HANDLE.
DEFINE VAR msg1 AS CHAR.
DEFINE VAR msg2 AS CHAR.
DEFINE VAR msg3 AS CHAR.
DEFINE VAR msg4 AS CHAR.
DEFINE VAR firma AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

DEFINE VAR accion AS CHAR INITIAL "EVENTO".
savdir = getCurrentDirectory().
exportFileName = "DeudaconPaulista.pdf".
exportFileName = SESSION:TEMP-DIR + exportFileName.

msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Atte Adm. '  + html-encode( "FERNANDO" ) + ':</font></p>'.
msg3 = '<p><font face=Tahoma>Enviamos nuestro resumen de cuenta, el cual contiene el detalle de facturas y monto adeudado. </font></p>'.
msg4 = '<p><font face=Tahoma>Recuerde comunicarnos cualquier problema o necesidad especial relacionado con nuestros servicios. Nuestra pol&iacute;tica de calidad persigue la entera satisfacci&oacute;n suya y de sus clientes. </font></p><p><font face=Tahoma>Aprovecho la oportunidad para saludarlo atte.</font></p><p><font face=Tahoma>' + 'Fernando-usuario' + '</font></p>'.

/*firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.*/
firma= '<p><font face=Tahoma>PAULISTA</font></p><p><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.
IF accion = "EVENTO" THEN msg2 = '<p><font face=Tahoma>La cobradora concurrira a sus oficinas el dia ' + STRING(06/01/2011) + '</font></p>'.
ELSE msg2='<br><p><font face=Tahoma>Nos dirigimos a Uds. a fin de solicitar fecha y horario de pago del mes en curso.</font></p>'.

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
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "fvergniaud@paulistaservicios.com.ar".
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "alcaudon".      
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  


objField:Update.

objMessage:Configuration = objConf.
objMessage:TO = "fvergniaud@paulistaservicios.com.ar".
objMessage:FROM = "fvergniaud@paulistaservicios.com.ar".
objMessage:Subject = IF accion = "EVENTO" THEN "Paulista - Estado de deuda" ELSE "Paulista - Solicitud de fecha de pago".
objMessage:CreateMHTMLBody("file://c:/1.htm",,, ).
objMessage:AddAttachment( "file://" + exportFileName,"","" ).

objMessage:Send.

RELEASE OBJECT objMessage NO-ERROR.
RELEASE OBJECT objConf NO-ERROR.
objConf=?.
objMessage=?.  
RUN setCurrentDirectoryA(savDir).
MESSAGE "Listo!".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-18
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-18 W-Win
ON CHOOSE OF BUTTON-18 IN FRAME F-Main /* CDO JS */
DO:
DEFINE VAR objMessage AS COM-HANDLE NO-UNDO.
DEFINE VAR objConf AS COM-HANDLE NO-UNDO.
DEFINE VAR objField AS COM-HANDLE NO-UNDO.
DEFINE VAR objBP AS COM-HANDLE.
DEFINE VAR msg1 AS CHAR NO-UNDO.
DEFINE VAR msg2 AS CHAR NO-UNDO.
DEFINE VAR msg3 AS CHAR  NO-UNDO.
DEFINE VAR msg4 AS CHAR NO-UNDO.
DEFINE VAR msgboton AS CHAR NO-UNDO.
DEFINE VAR firma AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.
DEFINE VAR logo AS CHAR INITIAL "logopau.jpg" NO-UNDO.
DEFINE VAR logof AS CHAR NO-UNDO.

DEFINE VAR accion AS CHAR INITIAL "EVENTO".
savdir = getCurrentDirectory().
RUN fullpath ( logo, INPUT "", OUTPUT logof ).
exportFileName = "DeudaconPaulista.pdf".
exportFileName = SESSION:TEMP-DIR + exportFileName.

msg1 = '<HTML><HEAD><TITLE></TITLE><META HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"></HEAD><BODY><p><font face=Tahoma>Contesta solo SI o no con los botones</font></p>'.
firma= '<p><span><img width=87 height=67 src="cid:logopau.jpg" v:shapes="_x0000_s1026"></span><font face=Tahoma>Tel: 4961-1900</font></p><p><font face=Tahoma><a href="mailto:info@paulistaservicios.com.ar" title="mailto:info@paulistaservicios.com.ar">info@paulistaservicios.com.ar</a></font></p><p><font face=Tahoma><a href="skype:paulistaservicios" title="Skype:paulistaservicios">Skype:paulistaservicios</font></p><p></BODY></HTML>'.

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
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "fvergniaud@paulistaservicios.com.ar".
objField:Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "alcaudon".      
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = TRUE.
objField:Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 100.  


objField:Update.

objMessage:Configuration = objConf.
objMessage:TO = "fvergniaud@fvsys.com.ar".
objMessage:FROM = "fvergniaud@paulistaservicios.com.ar".
objMessage:Subject = IF accion = "EVENTO" THEN "Paulista - Estado de deuda" ELSE "Paulista - Solicitud de fecha de pago".
objMessage:HTMLBody = msg1 + firma.
/* desde un archivo 'objMessage.CreateMHTMLBody "file://c|/temp/test.htm"*/
objMessage:AddAttachment( "file://" + exportFileName,"","" ).
objBP = objMessage:AddRelatedBodyPart("file://" + logof, logo, 0, , ).
objBP:Fields:Item("urn:schemas:mailheader:Content-ID") = "<" + logo + ">".
objBP:Fields:Update.


objMessage:Send.

RELEASE OBJECT objMessage NO-ERROR.
RELEASE OBJECT objConf NO-ERROR.
objConf=?.
objMessage=?.  
objBP=?.
objField=?.
RUN setCurrentDirectoryA(savDir).
MESSAGE "Listo!".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
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
  ENABLE BUTTON-15 BUTTON-17 BUTTON-16 BUTTON-18 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
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

