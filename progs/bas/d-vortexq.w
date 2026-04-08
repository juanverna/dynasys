&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          custom           PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE tt NO-UNDO LIKE Vortex.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
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

/* Local Variable Definitions ---                                       */
    DEFINE INPUT-OUTPUT PARAMETER TABLE FOR tt.
    DEFINE INPUT PARAMETER pesnuevo AS LOGICAL.
    DEFINE OUTPUT PARAMETER paccion AS CHAR.

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
&Scoped-define INTERNAL-TABLES Vortex

/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define QUERY-STRING-D-Dialog FOR EACH Vortex SHARE-LOCK
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Vortex SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Vortex
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Vortex


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS tt.Tesaurus tt.Nombre tt.PGrabado tt.PLectura ~
tt.PBorrado tt.PVersionado tt.Tipo tt.FAccedido tt.FCreado tt.FModif ~
tt.Tamanio tt.Carpeta tt.Indice tt.Version tt.Protegido 
&Scoped-define ENABLED-TABLES tt
&Scoped-define FIRST-ENABLED-TABLE tt
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 Btn_OK Btn_Cancel Btn_Help ~
bacceso 
&Scoped-Define DISPLAYED-FIELDS tt.Tesaurus tt.Nombre tt.PGrabado ~
tt.PLectura tt.PBorrado tt.PVersionado tt.Tipo tt.FAccedido tt.FCreado ~
tt.FModif tt.Tamanio tt.Carpeta tt.Indice tt.Version tt.Protegido 
&Scoped-define DISPLAYED-TABLES tt
&Scoped-define FIRST-DISPLAYED-TABLE tt


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON bacceso 
     LABEL "Acceder" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Help 
     LABEL "&Help" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 49 BY 5.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 49 BY 5.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Vortex SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     tt.Tesaurus AT ROW 7.67 COL 3 NO-LABEL WIDGET-ID 36
          VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
          SIZE 61 BY 4 TOOLTIP "Palabras claves para la busqueda futura del file"
     tt.Nombre AT ROW 1.24 COL 11 COLON-ALIGNED WIDGET-ID 10
          VIEW-AS FILL-IN 
          SIZE 42 BY 1
     tt.PGrabado AT ROW 2.91 COL 15 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     tt.PLectura AT ROW 3.91 COL 15 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     tt.PBorrado AT ROW 4.91 COL 15 COLON-ALIGNED WIDGET-ID 12
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     tt.PVersionado AT ROW 5.91 COL 15 COLON-ALIGNED WIDGET-ID 20
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     tt.Tipo AT ROW 1.24 COL 61 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     tt.FAccedido AT ROW 3.14 COL 66 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 34.2 BY 1
     tt.FCreado AT ROW 4.14 COL 66 COLON-ALIGNED WIDGET-ID 6
          VIEW-AS FILL-IN 
          SIZE 34.2 BY 1
     tt.FModif AT ROW 5.14 COL 66 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN 
          SIZE 34.2 BY 1
     tt.Tamanio AT ROW 7.91 COL 73 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 14.6 BY 1
     tt.Carpeta AT ROW 9.33 COL 73 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS FILL-IN 
          SIZE 46 BY 1
     tt.Indice AT ROW 10.52 COL 73 COLON-ALIGNED WIDGET-ID 40
          VIEW-AS FILL-IN 
          SIZE 46 BY 1
     tt.Version AT ROW 1.24 COL 85 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS FILL-IN 
          SIZE 6.2 BY 1
     tt.Protegido AT ROW 1.24 COL 98 WIDGET-ID 30
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY .81
     Btn_OK AT ROW 2.43 COL 107
     Btn_Cancel AT ROW 3.62 COL 107
     Btn_Help AT ROW 5.19 COL 107
     bacceso AT ROW 6.95 COL 107 WIDGET-ID 2
     RECT-1 AT ROW 2.43 COL 3 WIDGET-ID 32
     RECT-2 AT ROW 2.43 COL 56 WIDGET-ID 34
     SPACE(17.00) SKIP(4.51)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Caracteristicas del Archivo"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Temp-Tables and Buffers:
      TABLE: tt T "?" NO-UNDO custom Vortex
   END-TABLES.
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
   FRAME-NAME L-To-R,COLUMNS                                            */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

ASSIGN 
       tt.Carpeta:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.FAccedido:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.FCreado:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.FModif:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.Indice:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.Nombre:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.Tamanio:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.Tipo:READ-ONLY IN FRAME D-Dialog        = TRUE.

ASSIGN 
       tt.Version:READ-ONLY IN FRAME D-Dialog        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _TblList          = "custom.Vortex"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Caracteristicas del Archivo */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bacceso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bacceso D-Dialog
ON CHOOSE OF bacceso IN FRAME D-Dialog /* Acceder */
DO:
  /*      
      IF AVAILABLE vortex THEN do: /*existe admite versionado? o regrabado*/
          IF CAN-DO(usuario,tt.versionado )  THEN DO:
              MESSAGE "Desea generar una version de " vnombre
                  VIEW-AS ALERT-BOX question BUTTONS YES-NO UPDATE rup.
              IF rup THEN vv = tt.versionado + 1.
          ELSE DO:
              MESSAGE "
                  VIEW-AS ALERT-BOX INFO BUTTONS OK.
          END.
*/    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Help D-Dialog
ON CHOOSE OF Btn_Help IN FRAME D-Dialog /* Help */
OR HELP OF FRAME {&FRAME-NAME}
DO: /* Call Help Function (or a simple message). */
MESSAGE "Help for File: {&FILE-NAME}":U VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* OK */
DO:
    DEF VAR pud AS LOGICAL NO-UNDO.
    RUN assignFrame /*IN TARGET-PROCEDURE*/
      ((FRAME {&FRAME-NAME}:HANDLE), (BUFFER tt:HANDLE), '*').
    paccion = "".
    IF NOT pesnuevo THEN do:
        paccion = "G".  
    END.
  ELSE DO:
      MESSAGE "ya existe la version " tt.VERSION " del mismo archivo" SKIP
              "Si si desea una nueva version No si sobrescribe el existe" SKIP
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL UPDATE pud.
      IF pud THEN paccion = "V".
      IF NOT pud THEN paccion = "G".
  END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE assignframe D-Dialog 
PROCEDURE assignframe :
/*------------------------------------------------------------------------------
  Recorre la frame asignado los objetos a la temp-table del mismo nombre
  es un assign *.
------------------------------------------------------------------------------*/
  DEFINE INPUT  PARAMETER phFrame  AS HANDLE     NO-UNDO.
  DEFINE INPUT  PARAMETER phBuffer AS HANDLE     NO-UNDO.
  DEFINE INPUT  PARAMETER pcMatch  AS CHARACTER  NO-UNDO.


  DEFINE VARIABLE hWidget AS HANDLE     NO-UNDO.
  DEFINE VARIABLE cField  AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE hField  AS HANDLE     NO-UNDO.

  hWidget = phFrame:CURRENT-ITERATION:FIRST-CHILD.
  DO WHILE VALID-HANDLE(hWidget):
    
      IF CAN-DO(pcMatch, hWidget:NAME)
      AND CAN-QUERY(hWidget, 'SCREEN-VALUE':U) THEN
    DO:
      cField = hWidget:name.
      hField = phBuffer:BUFFER-FIELD(cField).
      IF VALID-HANDLE(hField) THEN
      DO:


          IF hWidget:TYPE = 'COMBO-BOX' 
          AND hWidget:SCREEN-VALUE = ?
          AND hWidget:LOOKUP('') > 0 THEN
          hField:BUFFER-VALUE = ''.
        ELSE IF CAN-QUERY(hWidget, 'INPUT-VALUE':U) THEN
          hField:BUFFER-VALUE = hWidget:INPUT-VALUE.
        ELSE IF CAN-QUERY(hWidget, 'CHECKED':U) THEN
          hField:BUFFER-VALUE = hWidget:CHECKED.
        ELSE IF CAN-QUERY(hWidget, 'SCREEN-VALUE') THEN
          hField:BUFFER-VALUE = hWidget:SCREEN-VALUE.
      END.
    END.
    hWidget = hWidget:NEXT-SIBLING.
  END.
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
  IF AVAILABLE tt THEN 
    DISPLAY tt.Tesaurus tt.Nombre tt.PGrabado tt.PLectura tt.PBorrado 
          tt.PVersionado tt.Tipo tt.FAccedido tt.FCreado tt.FModif tt.Tamanio 
          tt.Carpeta tt.Indice tt.Version tt.Protegido 
      WITH FRAME D-Dialog.
  ENABLE RECT-1 RECT-2 tt.Tesaurus tt.Nombre tt.PGrabado tt.PLectura 
         tt.PBorrado tt.PVersionado tt.Tipo tt.FAccedido tt.FCreado tt.FModif 
         tt.Tamanio tt.Carpeta tt.Indice tt.Version tt.Protegido Btn_OK 
         Btn_Cancel Btn_Help bacceso 
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

  /* Code placed here will execute PRIOR to standard behavior. */
  FIND FIRST tt.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

   
  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Vortex"}

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

