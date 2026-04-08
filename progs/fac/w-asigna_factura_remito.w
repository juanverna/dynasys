&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Fac_header

/* Definitions for FRAME F-Main                                         */
&Scoped-define FIELDS-IN-QUERY-F-Main Fac_header.codigo_cliente ~
Fac_header.nombre Fac_header.direccion Fac_header.nom_Administrador ~
Fac_header.imp_total 
&Scoped-define ENABLED-FIELDS-IN-QUERY-F-Main Fac_header.codigo_cliente ~
Fac_header.nombre Fac_header.direccion Fac_header.nom_Administrador ~
Fac_header.imp_total 
&Scoped-define ENABLED-TABLES-IN-QUERY-F-Main Fac_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-F-Main Fac_header
&Scoped-define QUERY-STRING-F-Main FOR EACH Fac_header SHARE-LOCK
&Scoped-define OPEN-QUERY-F-Main OPEN QUERY F-Main FOR EACH Fac_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-F-Main Fac_header
&Scoped-define FIRST-TABLE-IN-QUERY-F-Main Fac_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Fac_header.codigo_cliente Fac_header.nombre ~
Fac_header.direccion Fac_header.nom_Administrador Fac_header.imp_total 
&Scoped-define ENABLED-TABLES Fac_header
&Scoped-define FIRST-ENABLED-TABLE Fac_header
&Scoped-Define ENABLED-OBJECTS vtip_comprob vprf_comprob vnro_comprob ~
vtip_comprob2 vprf_comprob2 vnro_comprob2 basig 
&Scoped-Define DISPLAYED-FIELDS Fac_header.codigo_cliente Fac_header.nombre ~
Fac_header.direccion Fac_header.nom_Administrador Fac_header.imp_total 
&Scoped-define DISPLAYED-TABLES Fac_header
&Scoped-define FIRST-DISPLAYED-TABLE Fac_header
&Scoped-Define DISPLAYED-OBJECTS vtip_comprob vprf_comprob vnro_comprob ~
vtip_comprob2 vprf_comprob2 vnro_comprob2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON basig 
     LABEL "Asignar" 
     SIZE 13 BY 1.14.

DEFINE VARIABLE vnro_comprob AS INTEGER FORMAT "99999999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE vnro_comprob2 AS INTEGER FORMAT "99999999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE vprf_comprob AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE vprf_comprob2 AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE vtip_comprob AS CHARACTER FORMAT "X(256)":U 
     LABEL "Comprobante" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE VARIABLE vtip_comprob2 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Remito" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY F-Main FOR 
      Fac_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     vtip_comprob AT ROW 1.95 COL 15 COLON-ALIGNED WIDGET-ID 2
     vprf_comprob AT ROW 1.95 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     vnro_comprob AT ROW 1.95 COL 28.6 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     Fac_header.codigo_cliente AT ROW 3.38 COL 15 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     Fac_header.nombre AT ROW 4.57 COL 3.2 WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 61 BY 1
     Fac_header.direccion AT ROW 5.52 COL 6.8 WIDGET-ID 14
          LABEL "Direccion"
          VIEW-AS FILL-IN 
          SIZE 61 BY 1
     Fac_header.nom_Administrador AT ROW 6.48 COL 2.2 WIDGET-ID 20
          LABEL "Administracion"
          VIEW-AS FILL-IN 
          SIZE 61 BY 1
     Fac_header.imp_total AT ROW 7.67 COL 15 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 25.8 BY 1
     vtip_comprob2 AT ROW 9.1 COL 15 COLON-ALIGNED WIDGET-ID 22
     vprf_comprob2 AT ROW 9.1 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     vnro_comprob2 AT ROW 9.1 COL 29 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     basig AT ROW 9.1 COL 46 WIDGET-ID 10
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 84.2 BY 9.76 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Asignacion de remitos a facturas"
         HEIGHT             = 9.76
         WIDTH              = 84.2
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 84.2
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 84.2
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = yes
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
ASSIGN 
       Fac_header.codigo_cliente:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Fac_header.direccion IN FRAME F-Main
   ALIGN-L EXP-LABEL                                                    */
ASSIGN 
       Fac_header.direccion:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       Fac_header.imp_total:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Fac_header.nombre IN FRAME F-Main
   ALIGN-L                                                              */
ASSIGN 
       Fac_header.nombre:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Fac_header.nom_Administrador IN FRAME F-Main
   ALIGN-L EXP-LABEL                                                    */
ASSIGN 
       Fac_header.nom_Administrador:READ-ONLY IN FRAME F-Main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _TblList          = "sic.Fac_header"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Asignacion de remitos a facturas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Asignacion de remitos a facturas */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME basig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL basig W-Win
ON CHOOSE OF basig IN FRAME F-Main /* Asignar */
DO:
  ASSIGN vtip_comprob vnro_comprob vprf_comprob vtip_comprob2 vnro_comprob2 vprf_comprob2.
  FIND fac_header WHERE 
      fac_header.tip_comprob = vtip_comprob AND
      fac_header.prf_comprob = vprf_comprob AND
      fac_header.nro_comprob = vnro_comprob NO-ERROR.
  FIND rem_header WHERE 
      rem_header.tip_comprob = vtip_comprob2 AND
      rem_header.prf_comprob = vprf_comprob2 AND
      rem_header.nro_comprob = vnro_comprob2 NO-ERROR.
  
  IF NOT AVAILABLE fac_header THEN DO:
      STATUS INPUT "Verifique los datos factura".
      RETURN NO-APPLY.
  END.
  IF NOT AVAILABLE rem_header THEN DO:
      STATUS INPUT "Verifique los datos remito".
      RETURN NO-APPLY.
  END.
  rem_header.nro_factura = fac_header.nro_factura.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vnro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vnro_comprob W-Win
ON LEAVE OF vnro_comprob IN FRAME F-Main
DO:
    ASSIGN vtip_comprob vnro_comprob vprf_comprob.
  FIND fac_header WHERE fac_header.tip_comprob = vtip_comprob AND
      fac_header.prf_comprob = vprf_comprob AND
      fac_header.nro_comprob = vnro_comprob NO-LOCK NO-ERROR.
  IF NOT AVAILABLE fac_header THEN DO:
      STATUS INPUT "Comprobante no registrado".
      RETURN NO-APPLY.
  END.
  DISPLAY fac_header.codigo_cliente
      fac_header.direccion
      fac_header.nom_administrador
      fac_header.nombre
      fac_header.imp_total.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vnro_comprob2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vnro_comprob2 W-Win
ON LEAVE OF vnro_comprob2 IN FRAME F-Main
DO:
    ASSIGN vtip_comprob vnro_comprob vprf_comprob.
  FIND rem_header WHERE rem_header.tip_comprob = vtip_comprob AND
      rem_header.prf_comprob = vprf_comprob AND
      rem_header.nro_comprob = vnro_comprob NO-LOCK NO-ERROR.
  IF NOT AVAILABLE rem_header THEN DO:
      STATUS INPUT "Comprobante no registrado".
      RETURN NO-APPLY.
  END.
  DISPLAY rem_header.codigo_cliente
      rem_header.direccion
      rem_header.nombre
      rem_header.imp_total.
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
  DISPLAY vtip_comprob vprf_comprob vnro_comprob vtip_comprob2 vprf_comprob2 
          vnro_comprob2 
      WITH FRAME F-Main IN WINDOW W-Win.
  IF AVAILABLE Fac_header THEN 
    DISPLAY Fac_header.codigo_cliente Fac_header.nombre Fac_header.direccion 
          Fac_header.nom_Administrador Fac_header.imp_total 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE vtip_comprob vprf_comprob vnro_comprob Fac_header.codigo_cliente 
         Fac_header.nombre Fac_header.direccion Fac_header.nom_Administrador 
         Fac_header.imp_total vtip_comprob2 vprf_comprob2 vnro_comprob2 basig 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
STATUS DEFAULT "Ingrese comprobante".
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

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Fac_header"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

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

