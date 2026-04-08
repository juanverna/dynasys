&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
/* Procedure Description
"This SmartPanel starts a transaction 
which remains open until the Commit
or Undo button is pressed. "
*/
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-WIn 
/*------------------------------------------------------------------------

  File: p-updtxn.w 

  Description:

        This is the transaction version of the database
        update SmartPanel. It uses the TABLEIO link
        to communicate with SmartViewers and Smart-
        Browsers. This panel opens a transaction block
        for the duration of the update of the record in its
        TABLEIO-TARGET.
 
        Its SmartPanelType attribute is Update-Trans.

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
{admhlp.i} /* ADM help contexts in UIB help file */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

&Scoped-define adm-attribute-dlg adm/support/u-paneld.w

DEFINE VARIABLE trans-commit AS LOGICAL NO-UNDO.  
DEFINE VARIABLE panel-type   AS CHARACTER NO-UNDO INIT 'UPDATE-TRANS':U.
DEFINE VARIABLE add-active   AS LOGICAL NO-UNDO INIT no.
DEFINE VARIABLE estadohabilitado AS CHARACTER NO-UNDO INIT 'N'. /*esta variable va tener 3 estados N= nulo, H= habilitado y  D=deshabilitado */

{defestadobtns.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartPanel
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS TableIO-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Panel-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn-Commit Btn-Reset Btn-Undo Btn-Update 

/* Custom List Definitions                                              */
/* Box-Rectangle,List-2,List-3,List-4,List-5,List-6                     */
&Scoped-define Box-Rectangle RECT-1 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn-Commit 
     IMAGE-UP FILE "save.gif":U NO-FOCUS
     LABEL "&Graba" 
     SIZE 9 BY 1.33 TOOLTIP "Graba los cambios"
     FONT 4.

DEFINE BUTTON Btn-Reset 
     IMAGE-UP FILE "reset.gif":U NO-FOCUS
     LABEL "&Deshace" 
     SIZE 9 BY 1.33 TOOLTIP "Deshace los cambios realizados"
     FONT 4.

DEFINE BUTTON Btn-Undo 
     IMAGE-UP FILE "cancel.gif":U NO-FOCUS
     LABEL "&Cancela" 
     SIZE 9 BY 1.33 TOOLTIP "Cancela la operacion en curso"
     FONT 4.

DEFINE BUTTON Btn-Update 
     IMAGE-UP FILE "update.gif":U NO-FOCUS
     LABEL "&Modifica" 
     SIZE 9 BY 1.33 TOOLTIP "Modifica el registro actual"
     FONT 4.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 38 BY 1.76.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Panel-Frame
     Btn-Commit AT ROW 1.24 COL 20
     Btn-Reset AT ROW 1.24 COL 11
     Btn-Undo AT ROW 1.24 COL 29
     Btn-Update AT ROW 1.24 COL 2
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartPanel
   Allow: Basic
   Frames: 1
   Add Fields to: NEITHER
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
  CREATE WINDOW C-WIn ASSIGN
         HEIGHT             = 2.76
         WIDTH              = 68.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB C-WIn 
/* ************************* Included-Libraries *********************** */

{src/adm/method/panel.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-WIn
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME Panel-Frame
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME Panel-Frame:SCROLLABLE       = FALSE
       FRAME Panel-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR RECTANGLE RECT-1 IN FRAME Panel-Frame
   NO-ENABLE 1                                                          */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME Panel-Frame
/* Query rebuild information for FRAME Panel-Frame
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME Panel-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Btn-Commit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-Commit C-WIn
ON CHOOSE OF Btn-Commit IN FRAME Panel-Frame /* Graba */
DO:  
      RUN notify ('update-record':U).
      /* If there was an error somewhere in the update, then
         don't commit the larger transaction. */
      IF RETURN-VALUE <> "ADM-ERROR":U THEN DO:
          trans-commit = yes.  
          add-active = no.
          APPLY "U1":U TO THIS-PROCEDURE.
      END.
  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-Reset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-Reset C-WIn
ON CHOOSE OF Btn-Reset IN FRAME Panel-Frame /* Deshace */
DO:
  RUN notify ('reset-record':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-Undo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-Undo C-WIn
ON CHOOSE OF Btn-Undo IN FRAME Panel-Frame /* Cancela */
DO:
  DO WITH FRAME Panel-Frame:
     add-active = no.
     RUN notify ('cancel-record':U).
     trans-commit = no.
     APPLY "U1":U TO THIS-PROCEDURE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-Update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-Update C-WIn
ON CHOOSE OF Btn-Update IN FRAME Panel-Frame /* Modifica */
DO:
    DO WITH FRAME Panel-Frame:
         RUN new-state ('update-begin':U).
         add-active = no.
         RUN start-transaction. 
    END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-WIn 


/* ***************************  Main Block  *************************** */

  /* Set the default SmartPanel to the one that has the Commit push */
  /* button displayed (the TABLEIO-TARGETS are not enabled/disabled */
  /* automatically with this type of SmartPanel).                   */
  
  RUN set-attribute-list ("SmartPanelType=Update-Trans,
                           Edge-Pixels=2,
                           AddFunction=One-Record":U).
                           
  /* If the application hasn't enabled the behavior that a RETURN in a frame = GO,
     then enable the usage of the Save button as the default button. (Note that in
     8.0, the Save button was *always* the default button.) */
  /*IF SESSION:DATA-ENTRY-RETURN NE yes THEN 
  ASSIGN
      Btn-Commit:DEFAULT IN FRAME {&FRAME-NAME} = yes
      FRAME {&FRAME-NAME}:DEFAULT-BUTTON = Btn-Commit:HANDLE.*/
  

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE deshabilitar C-WIn 
PROCEDURE deshabilitar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN estadohabilitado = 'D'.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-WIn  _DEFAULT-DISABLE
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
  HIDE FRAME Panel-Frame.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar C-WIn 
PROCEDURE habilitar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  ASSIGN estadohabilitado = 'H'.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_modificaciones C-WIn 
PROCEDURE habilitar_modificaciones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-habilitar AS LOGICAL.

  Btn-Update:SENSITIVE IN FRAME  {&FRAME-NAME}= p-habilitar.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable C-WIn 
PROCEDURE local-enable :
/*------------------------------------------------------------------------------
  Purpose: The SmartPanel's buttons sensitivities are re-set to whatever
           state they were in when they were disabled. This state is de-
           termined from the variable adm-panel-state.
  Notes:       
------------------------------------------------------------------------------*/

  RUN dispatch ('enable':U).      /* Get all objects enabled to start. */
  RUN set-buttons (adm-panel-state).
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize C-WIn 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'adm-initialize':U ) .

  RUN get-attribute IN THIS-PROCEDURE ('UIB-MODE':U).
  IF RETURN-VALUE <> 'DESIGN':U THEN DO:
     IF VALID-HANDLE (adm-broker-hdl) THEN DO:
       DEFINE VAR tab-target-link AS CHARACTER NO-UNDO.
       RUN get-link-handle IN adm-broker-hdl
           (INPUT THIS-PROCEDURE, 'TABLEIO-TARGET':U, OUTPUT tab-target-link).
       IF (tab-target-link EQ "":U) THEN
         adm-panel-state = 'disable-all':U.
       ELSE DO:
         RUN request-attribute IN adm-broker-hdl
            (INPUT THIS-PROCEDURE, INPUT 'TABLEIO-TARGET':U,
             INPUT 'Query-Position':U).
         IF RETURN-VALUE = 'no-record-available':U THEN 
           adm-panel-state = 'add-only':U.
         ELSE IF RETURN-VALUE = 'no-external-record-available':U THEN 
           adm-panel-state = 'disable-all':U.
         ELSE adm-panel-state = 'initial':U.
       END.
     END.
     RUN set-buttons (adm-panel-state).
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-UIB-mode C-WIn 
PROCEDURE local-UIB-mode :
/*------------------------------------------------------------------------------
  Purpose:     Put up an Advisor message to make sure that the user
               understands that this Transaction SmartPanel should be used
               only under certain circumstances.
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE l_never-again   AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE c_key-value     AS CHARACTER NO-UNDO.
  DEFINE VARIABLE c_choice        AS CHARACTER NO-UNDO.
  
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'UIB-mode':U ) .

  /* If this is the first time this object is used, then put up
     a warning message.  */
  RUN get-attribute ('Drawn-in-UIB':U).
  IF RETURN-VALUE eq ? THEN DO:
    /* Set the attribute so we won't do this again. */
    RUN set-attribute-list ('Drawn-in-UIB=yes':U).
    /* Put up a warning, if necessary. */
    GET-KEY-VALUE SECTION "SmartPanel":U KEY "AdviseTransactionUsage":U 
      VALUE c_key-value.
    IF c_key-value ne "no":U THEN DO:
    RUN adeuib/_advisor.w 
      (INPUT "This Transaction Update SmartPanel creates a transaction" + 
             " which will remain open until the Commit or Undo button is pressed." +
             " Unless you specifically want a transaction which spans the" +
             " data entry process, you should use the Standard Update SmartPanel" +
             " which scopes the transaction to the Save button." ,
       INPUT "":U, /* No Radio-Set choice to present */
       INPUT yes,  /* Show the use a "never again" toggle */
       INPUT "uib":U, /* help file */
       INPUT {&Advisor_Transaction_Update}, /* help context id */
       INPUT-OUTPUT c_choice, /* Placeholder only */
       OUTPUT l_never-again).   /* Did they ask never to see this again? */ 
       
      IF l_never-again THEN 
        PUT-KEY-VALUE SECTION "SmartPanel":U KEY "AdviseTransactionUsage":U 
          VALUE "no":U.
    END.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view C-WIn 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  IF estadohabilitado = 'D' THEN
  DO:
       adm-panel-state = 'disable-all':U.
       RUN set-buttons (adm-panel-state).
  END.
  IF estadohabilitado = 'H' THEN
  DO:
       adm-panel-state = 'initial':U.
       RUN set-buttons (adm-panel-state).
  END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-buttons C-WIn 
PROCEDURE set-buttons :
/*------------------------------------------------------------------------------
  Purpose:    Sets the sensitivity of the panel's buttons depending upon what
              sort of action is occuring to the TABLIO-TARGET(s) of the panel.
  Parameters: Character string that denotes which action to set the button
              sensitivities. 
              
              The values are: initial - the panel is in a state where no record
                                        changes are occuring; i.e. it is possible
                                        to Update, Add, Copy, or Delete a record.
                              action-chosen - the panel is in the state where
                                              Update, Add, or Copy has been
                                              pressed.
                              disable-all - the panel has all its buttons set
                                            to insensitive.
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER panel-state AS CHARACTER NO-UNDO.

DO WITH FRAME Panel-Frame:

  IF panel-state = 'disable-all':U THEN DO:
  
    /* The panel sets all its buttons to insensitive whenever the link */
    /* to the smartpanel is deactivated.                               */

&IF LOOKUP("Btn-Reset":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Reset:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Add":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Add:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Copy":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Copy:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Delete":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Delete:SENSITIVE = NO.
&ENDIF

    ASSIGN Btn-Update:SENSITIVE = NO
           Btn-Commit:SENSITIVE = NO
           Btn-Undo:SENSITIVE = NO.
       
  END. /* panel-state = 'disable-all' */
  
  ELSE IF panel-state = 'initial':U THEN DO: 

    /* The panel is not actively changing any of its TABLEIO-TARGET(s). */

&IF LOOKUP("Btn-Reset":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Reset:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Add":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Add:SENSITIVE = YES.
&ENDIF
&IF LOOKUP("Btn-Copy":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Copy:SENSITIVE = YES.
&ENDIF
&IF LOOKUP("Btn-Delete":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Delete:SENSITIVE = YES.
&ENDIF

    ASSIGN Btn-Update:SENSITIVE = YES
           Btn-Commit:SENSITIVE = NO
           Btn-Undo:SENSITIVE = NO.

  END. /* panel-state = 'initial' */

  ELSE IF panel-state = 'add-only':U THEN DO:

    /* All buttons are set to insensitive, except add. This only should */
    /* happen only when there are no records in the query and the only  */
    /* thing that can be done to it is add-record.                      */

&IF LOOKUP("Btn-Reset":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Reset:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Add":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Add:SENSITIVE = YES.
&ENDIF
&IF LOOKUP("Btn-Copy":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Copy:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Delete":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
             Btn-Delete:SENSITIVE = NO.
&ENDIF

    ASSIGN Btn-Update:SENSITIVE = NO
           Btn-Commit:SENSITIVE = NO
           Btn-Undo:SENSITIVE = NO.

  END. /* panel-state = 'add-only' */
   
  ELSE DO: /* panel-state = 'action-chosen' */

    /* The panel had one of the buttons capable of changing/adding a record */
    /* pressed.                                                             */

&IF LOOKUP("Btn-Reset":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
           Btn-Reset:SENSITIVE = YES.
&ENDIF
&IF LOOKUP("Btn-Add":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
           Btn-Add:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Copy":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
           Btn-Copy:SENSITIVE = NO.
&ENDIF
&IF LOOKUP("Btn-Delete":U, "{&ENABLED-OBJECTS}":U," ":U) NE 0 &THEN
           Btn-Delete:SENSITIVE = NO.
&ENDIF

    ASSIGN Btn-Update:SENSITIVE = NO
           Btn-Commit:SENSITIVE = YES
           Btn-Undo:SENSITIVE = YES.
  
  END. /* panel-state = 'action-chosen' */

END. /* DO WITH FRAME */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-sensitivo C-WIn 
PROCEDURE set-sensitivo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-estado AS LOGICAL.
  IF NOT origino-yo
  THEN DO:
        DO WITH FRAME {&FRAME-NAME}:
      
              IF p-estado  /* Habilitar */
              THEN DO:
                ASSIGN
                  Btn-Commit:SENSITIVE = S-Btn-Commit
                  Btn-Reset:SENSITIVE = S-Btn-Reset
                  Btn-Undo:SENSITIVE = S-Btn-Undo
                  Btn-Update:SENSITIVE = S-Btn-Update.
              END.
              ELSE DO:  /* Deshabilitar */
                ASSIGN
                  S-Btn-Commit    = Btn-Commit:SENSITIVE
                  S-Btn-Reset     = Btn-Reset:SENSITIVE
                  S-Btn-Undo      = Btn-Undo:SENSITIVE
                  S-Btn-Update    = Btn-Update:SENSITIVE.
            
                ASSIGN
                  Btn-Commit:SENSITIVE = NO
                  Btn-Reset:SENSITIVE = NO
                  Btn-Undo:SENSITIVE = NO
                  Btn-Update:SENSITIVE = NO.
              
              END.
      
        END.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE start-transaction C-WIn 
PROCEDURE start-transaction :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE source-hdl-string AS CHARACTER NO-UNDO.


  IF VALID-HANDLE (adm-broker-hdl) THEN
  DO TRANSACTION ON STOP UNDO, LEAVE ON ERROR UNDO, RETRY:
       /* Tell our parent Container that we've started a transaction
          so it can make sure it isn't destroyed before the txn is ended. */

       ASSIGN origino-yo = YES.

       RUN get-link-handle IN adm-broker-hdl (THIS-PROCEDURE,
           'CONTAINER-SOURCE':U, OUTPUT source-hdl-string).

       RUN set-attribute-list IN WIDGET-HANDLE(source-hdl-string)
           ('ADM-TRANSACTION=yes':U).

       RUN set-estado-folders IN WIDGET-HANDLE(source-hdl-string)
           ('DESHABILITAR').

       WAIT-FOR U1 OF THIS-PROCEDURE.

       ASSIGN origino-yo = NO.

       IF not trans-commit THEN UNDO, LEAVE. 
  END. /* else commit the transaction. */ 

  RUN set-attribute-list IN WIDGET-HANDLE(source-hdl-string)
      ('ADM-TRANSACTION=no':U).     /* Signal end of transaction */

  RUN set-estado-folders IN WIDGET-HANDLE(source-hdl-string)
      ('HABILITAR').

  /* The transaction panel must get its TABLEIO target to do the 
     end-update after the txn ends because that method may not
     be executable while a txn is open. */
  RUN notify ('end-update, TABLEIO-TARGET':U).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed C-WIn 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.

  DEFINE VAR source-hdl-string AS CHAR NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/pustates.i}
      
      WHEN "cambio-ficha"
      THEN DO:
           APPLY "CHOOSE" TO btn-update IN FRAME Panel-frame.
      END.     
      WHEN "cancelar" 
      THEN DO:
          APPLY "CHOOSE" TO btn-undo IN FRAME Panel-frame.
      END.
      
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

