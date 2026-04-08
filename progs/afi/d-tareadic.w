&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
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

DEFINE INPUT PARAMETER nroev AS INT NO-UNDO.
DEFINE INPUT PARAMETER nrocli AS INT NO-UNDO.
DEFINE OUTPUT PARAMETER pobservaciones  LIKE evento.observaciones NO-UNDO.
DEFINE OUTPUT PARAMETER pleyenda  LIKE evento.leyenda NO-UNDO.
DEFINE OUTPUT PARAMETER pnro_tarea  LIKE tarea.nro_tarea NO-UNDO.

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
&Scoped-define INTERNAL-TABLES Evento

/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define QUERY-STRING-D-Dialog FOR EACH Evento SHARE-LOCK
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Evento SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Evento
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Evento


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel Btn_Help x_cdg_tipotarea ~
Tnueva Observaciones Leyenda 
&Scoped-Define DISPLAYED-OBJECTS x_cdg_tipotarea Tnueva Observaciones ~
Leyenda 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     IMAGE-UP FILE "iconos24/error.jpg":U
     LABEL "Cancel" 
     SIZE 6 BY 1.43
     BGCOLOR 8 .

DEFINE BUTTON Btn_Help 
     IMAGE-UP FILE "iconos24/help2.jpg":U
     LABEL "&Help" 
     SIZE 6 BY 1.43
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     IMAGE-UP FILE "iconos24/check.jpg":U
     LABEL "OK" 
     SIZE 6 BY 1.43
     BGCOLOR 8 .

DEFINE VARIABLE x_cdg_tipotarea AS CHARACTER FORMAT "X(1)" INITIAL "*" 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 48 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE Leyenda LIKE Evento.Leyenda
     VIEW-AS EDITOR NO-WORD-WRAP MAX-CHARS 400 SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 92 BY 6.91 TOOLTIP "Leyenda Publica"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE Observaciones LIKE Evento.Observaciones
     VIEW-AS EDITOR NO-WORD-WRAP MAX-CHARS 400 SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 92 BY 5.95 TOOLTIP "Observaciones del evento Privada de la empresa"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE Tnueva AS LOGICAL INITIAL no 
     LABEL "Nueva" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Evento SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     Btn_OK AT ROW 1.48 COL 87.2
     Btn_Cancel AT ROW 1.48 COL 93.6
     Btn_Help AT ROW 1.48 COL 100
     x_cdg_tipotarea AT ROW 1.71 COL 35 COLON-ALIGNED WIDGET-ID 2
     Tnueva AT ROW 1.81 COL 16.8 WIDGET-ID 98
     Observaciones AT ROW 3.14 COL 16 HELP
          "" NO-LABEL WIDGET-ID 78
          BGCOLOR 15 FGCOLOR 9 
     Leyenda AT ROW 9.33 COL 16 HELP
          "" NO-LABEL WIDGET-ID 94
          BGCOLOR 15 FGCOLOR 9 
     "Observacion:" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 3.14 COL 2 WIDGET-ID 80
     "Leyenda:" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 9.33 COL 5 WIDGET-ID 96
     SPACE(94.79) SKIP(6.56)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Informacion Adicional"
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


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

/* SETTINGS FOR EDITOR Leyenda IN FRAME D-Dialog
   LIKE = sic.Evento. EXP-SIZE                                          */
/* SETTINGS FOR EDITOR Observaciones IN FRAME D-Dialog
   LIKE = sic.Evento. EXP-SIZE                                          */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _TblList          = "sic.Evento"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Informacion Adicional */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Help D-Dialog
ON CHOOSE OF Btn_Help IN FRAME D-Dialog /* Help */
OR HELP OF FRAME {&FRAME-NAME}
DO: 
MESSAGE 
    "Se generara una tarea del tipo indicado" SKIP
    "las Observaciones y Leyenda se grabaran" SKIP 
    "tanto en el evento como en la nueva tarea" VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* OK */
DO:
    DEFINE VAR opt AS LOGICAL.
    ASSIGN FRAME {&FRAME-NAME} leyenda 
          observaciones
          X_cdg_tipotarea 
          tnueva.
    IF tnueva THEN DO:
        FIND tarea WHERE Tarea.nro_identificacion = evento.nro_evento AND tarea.origen = "EVENTO" and
            tarea.cdg_tipotarea <> "Z" NO-LOCK NO-ERROR.
        IF AVAILABLE tarea THEN DO:
            MESSAGE "Ya existe una tarea para este evento, Abre otra mas?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
        END.
        ELSE opt = TRUE.
        IF opt THEN DO:
            IF AVAILABLE evento THEN 
                 RUN crea_tarea.p( (IF AVAILABLE evento THEN evento.nro_evento ELSE ?),nrocli,x_cdg_tipotarea , "Verificacion:" + string(evento.nro_identificacion) , leyenda ,TODAY,"",OUTPUT pnro_tarea).
            IF pnro_tarea = ? THEN DO:
                MESSAGE "No se puede crear tarea por error en usuario/recurso".
                RETURN NO-APPLY.
            END.
            ELSE DO:
                tarea.leyenda = leyenda.
                Tarea.descripcion = observaciones.
            END.
        END.
    END.
pobservaciones = observaciones.
pleyenda = leyenda.
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
  DISPLAY x_cdg_tipotarea Tnueva Observaciones Leyenda 
      WITH FRAME D-Dialog.
  ENABLE Btn_OK Btn_Cancel Btn_Help x_cdg_tipotarea Tnueva Observaciones 
         Leyenda 
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
 DEFINE VAR x-lista AS CHAR NO-UNDO.
  x-lista = "[Indique Tipo de Tarea],*".
  FOR EACH Tipo_tarea  NO-LOCK BY Tipo_tarea.cdg_tipotarea :
    x-lista = x-lista +  "," + Tipo_tarea.dsc_tipotarea + "," + Tipo_tarea.cdg_tipotarea.
  END.
  x_cdg_tipotarea:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).
  FIND evento WHERE evento.nro_evento = nroev NO-ERROR.
  observaciones = IF AVAILABLE evento THEN evento.observaciones ELSE "".
  leyenda = IF AVAILABLE evento THEN evento.leyenda ELSE "".
  
  /* Code placed here will execute PRIOR to standard behavior. */
  

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
  {src/adm/template/snd-list.i "Evento"}

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

