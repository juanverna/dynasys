&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 des_registro has_registro 
&Scoped-Define DISPLAYED-OBJECTS des_registro des_nombre has_registro ~
has_nombre 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

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


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE des_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .77
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE des_registro AS CHARACTER FORMAT "X(256)":U 
     LABEL "Desde Cobrador" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .77
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE has_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .77
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE has_registro AS CHARACTER FORMAT "X(256)":U 
     LABEL "Hasta Cobrador" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .77
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 89 BY 2.42.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     des_registro AT ROW 1.27 COL 16 COLON-ALIGNED
     des_nombre AT ROW 1.27 COL 32 COLON-ALIGNED NO-LABEL
     has_registro AT ROW 2.35 COL 16 COLON-ALIGNED
     has_nombre AT ROW 2.35 COL 32 COLON-ALIGNED NO-LABEL
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 6.85
         WIDTH              = 92.14.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN des_nombre IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN has_nombre IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME des_registro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_registro V-table-Win
ON + OF des_registro IN FRAME F-Main /* Desde Cobrador */
DO:
  APPLY "MOUSE-MENU-DOWN" TO SELF.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_registro V-table-Win
ON MOUSE-MENU-DOWN OF des_registro IN FRAME F-Main /* Desde Cobrador */
DO:
  &SCOPED-DEFINE ROWID_TABLA        rid_descobrador
  &SCOPED-DEFINE SELECCION          SELCOBRA.P
  &SCOPED-DEFINE TABLA              Cobrador
  &SCOPED-DEFINE CDG_TABLA          cdg_cobrador
  &SCOPED-DEFINE DSC_TABLA          nom_cobrador
  &SCOPED-DEFINE V-DSC_TABLA        des_nombre    
  &SCOPED-DEFINE V-CDG_TABLA        des_registro    
  &SCOPED-DEFINE MOSTRAR_DSC        YES

  {hlptabla-var.i}      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_registro V-table-Win
ON RETURN OF des_registro IN FRAME F-Main /* Desde Cobrador */
DO:

    ASSIGN FRAME {&FRAME-NAME} des_registro.
    IF SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
        THEN FIND Cobrador WHERE Cobrador.cdg_cobrador = SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
        ELSE FIND FIRST Cobrador NO-LOCK NO-ERROR.
    
    IF AVAILABLE Cobrador 
    THEN DO:
         des_nombre = Cobrador.nom_cobrador.
         des_registro = Cobrador.cdg_cobrador.
    END.
    ELSE DO:
         des_nombre = "???".
    END.

    DISPLAY des_nombre des_registro WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_registro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_registro V-table-Win
ON + OF has_registro IN FRAME F-Main /* Hasta Cobrador */
DO:
  APPLY "MOUSE-MENU-DOWN" TO SELF.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_registro V-table-Win
ON MOUSE-MENU-DOWN OF has_registro IN FRAME F-Main /* Hasta Cobrador */
DO:
  &SCOPED-DEFINE ROWID_TABLA        rid_hascobrador
  &SCOPED-DEFINE SELECCION          SELCOBRA.P
  &SCOPED-DEFINE TABLA              Cobrador
  &SCOPED-DEFINE CDG_TABLA          cdg_cobrador
  &SCOPED-DEFINE DSC_TABLA          nom_cobrador
  &SCOPED-DEFINE V-DSC_TABLA        has_nombre    
  &SCOPED-DEFINE V-CDG_TABLA        has_registro    
  &SCOPED-DEFINE MOSTRAR_DSC        YES

  {hlptabla-var.i}      
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_registro V-table-Win
ON RETURN OF has_registro IN FRAME F-Main /* Hasta Cobrador */
DO:

    ASSIGN FRAME {&FRAME-NAME} has_registro.
    IF SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
        THEN FIND Cobrador WHERE Cobrador.cdg_cobrador = SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
        ELSE FIND LAST Cobrador NO-LOCK NO-ERROR.
    
    IF AVAILABLE Cobrador 
    THEN DO:
         has_nombre = Cobrador.nom_cobrador.
         has_registro = Cobrador.cdg_cobrador.
    END.
    ELSE DO:
         has_nombre = "???".
    END.

    DISPLAY has_nombre has_registro WITH FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win _ADM-ROW-AVAILABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE dar_rango V-table-Win 
PROCEDURE dar_rango :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER des_codigo   AS CHARACTER.
  DEFINE OUTPUT PARAMETER has_codigo   AS CHARACTER.
  DEFINE OUTPUT PARAMETER error_rango  AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

        ASSIGN des_registro has_registro.
      
        IF des_registro:SCREEN-VALUE = "" OR 
           has_registro:SCREEN-VALUE = ""
           THEN error_rango = YES.

         des_codigo = STRING(des_registro).
         has_codigo = STRING(has_registro).

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartViewer, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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


