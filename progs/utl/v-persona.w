&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
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
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Agenda Persona
&Scoped-define FIRST-EXTERNAL-TABLE Agenda


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Agenda, Persona.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Persona.nombre Persona.direccion ~
Persona.localidad Persona.cdg_postal Persona.provincia Persona.pais ~
Persona.numeros_telefono 
&Scoped-define ENABLED-TABLES Persona
&Scoped-define FIRST-ENABLED-TABLE Persona
&Scoped-Define ENABLED-OBJECTS btn_copiar v-nue-agenda RECT-1 RECT-2 
&Scoped-Define DISPLAYED-FIELDS Persona.nombre Persona.direccion ~
Persona.localidad Persona.cdg_postal Persona.provincia Persona.pais ~
Persona.palabras Persona.observacion Persona.numeros_telefono 
&Scoped-define DISPLAYED-TABLES Persona
&Scoped-define FIRST-DISPLAYED-TABLE Persona
&Scoped-Define DISPLAYED-OBJECTS v-nue-agenda 

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
DEFINE BUTTON btn_copiar 
     LABEL "Copiar a esta agenda --->" 
     SIZE 25 BY 1.

DEFINE VARIABLE v-nue-agenda AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 155 BY 10.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 155 BY 1.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Persona.nombre AT ROW 1.48 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 66 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Persona.direccion AT ROW 2.67 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 66 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Persona.localidad AT ROW 2.67 COL 115 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 37 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Persona.cdg_postal AT ROW 2.67 COL 89 COLON-ALIGNED FORMAT "X(8)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Persona.provincia AT ROW 1.48 COL 89 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Persona.pais AT ROW 1.48 COL 115 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 37 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Persona.palabras AT ROW 6.24 COL 2 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 77 BY 4.52
          BGCOLOR 15 FGCOLOR 7 
     Persona.observacion AT ROW 6.24 COL 81 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 73 BY 4.52
          BGCOLOR 15 FGCOLOR 7 
     btn_copiar AT ROW 11.48 COL 2
     v-nue-agenda AT ROW 11.48 COL 26 COLON-ALIGNED NO-LABEL
     Persona.numeros_telefono AT ROW 3.86 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 141 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "  Palabras claves asociadas a la persona" VIEW-AS TEXT
          SIZE 77 BY 1 AT ROW 5.05 COL 2
          BGCOLOR 5 FGCOLOR 15 
     "  Observaciones asociadas a la persona" VIEW-AS TEXT
          SIZE 73 BY 1 AT ROW 5.05 COL 81
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 1 COL 1
     RECT-2 AT ROW 11.24 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Agenda,sic.Persona
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
         HEIGHT             = 13.33
         WIDTH              = 160.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit Custom                                       */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Persona.cdg_postal IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR EDITOR Persona.observacion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR Persona.palabras IN FRAME F-Main
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

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar V-table-Win
ON CHOOSE OF btn_copiar IN FRAME F-Main /* Copiar a esta agenda ---> */
DO:
  
  DEFINE BUFFER B-Agenda  FOR Agenda.
  DEFINE BUFFER B-Persona FOR Persona.
  
  IF NOT CAN-FIND(B-Agenda WHERE B-Agenda.cdg_agenda = INPUT FRAME {&FRAME-NAME} v-nue-agenda)
  THEN DO:
       MESSAGE "No existe la agenda indicada" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.
  ELSE DO:
       DO TRANSACTION:
            CREATE B-Persona.
            BUFFER-COPY Persona TO B-Persona 
                   ASSIGN B-Persona.cdg_agenda = INPUT FRAME {&FRAME-NAME} v-nue-agenda.
       END.       
       MESSAGE "El registro ha sido copiado" VIEW-AS ALERT-BOX MESSAGE.
       v-nue-agenda:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  END.

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
  {src/adm/template/row-list.i "Agenda"}
  {src/adm/template/row-list.i "Persona"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Agenda"}
  {src/adm/template/row-find.i "Persona"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

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
  HIDE FRAME F-Main.
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

  /* Code placed here will execute PRIOR to standard behavior. */
    DEFINE VARIABLE j AS INTEGER.
    DEFINE VARIABLE hay_error AS LOGICAL.
    
    IF Persona.palabras:INPUT-VALUE IN FRAME {&FRAME-NAME} <> ""
    THEN DO:
        hay_error = NO.
        DO j = 1 TO NUM-ENTRIES(Persona.palabras:INPUT-VALUE IN FRAME {&FRAME-NAME}):
            FIND Palabras_agenda
                WHERE PalabraS_agenda.cdg_palabra = ENTRY(j,Persona.palabras:INPUT-VALUE IN FRAME {&FRAME-NAME},",")
                      NO-LOCK NO-ERROR.
            IF NOT AVAILABLE PalabraS_agenda
                THEN hay_error = YES.
        END.
        IF hay_error
        THEN DO:
            RUN ponmensj.p ( INPUT "TELE001").
            RETURN ERROR.
        END.
    END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  
  ASSIGN FRAME {&FRAME-NAME} 
      Persona.observacion 
      Persona.palabras.

  IF NEW Persona
  THEN DO:
      ASSIGN Persona.cdg_agenda = Agenda.cdg_agenda
             Persona.nro_persona = NEXT-VALUE(proxima_persona).
      RUN completar_auditoria.p ( OUTPUT Persona.nro_usuario,
                                  OUTPUT Persona.fecha_grab,
                                  OUTPUT Persona.hora_grab,
                                  OUTPUT Persona.pc_name).
  END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-delete-record V-table-Win 
PROCEDURE local-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   {verseguridad.i "ELITELEF"}
   
   FOR EACH Persona_telefono OF Persona:
       DELETE Persona_telefono.
   END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN 
    Persona.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 7 
    Persona.palabras:FGCOLOR IN FRAME {&FRAME-NAME} = 7

    Persona.observacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES 
    Persona.palabras:SENSITIVE IN FRAME {&FRAME-NAME} = YES.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    ASSIGN 
      Persona.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 9 
      Persona.palabras:FGCOLOR IN FRAME {&FRAME-NAME} = 9

      Persona.observacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES 
      Persona.palabras:SENSITIVE IN FRAME {&FRAME-NAME} = YES.


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
  {src/adm/template/snd-list.i "Agenda"}
  {src/adm/template/snd-list.i "Persona"}

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

