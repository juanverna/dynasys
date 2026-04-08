&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
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

  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-ult_ano v-ult_mes v-generar v-tip_comprob ~
v-nro_comprob RECT-1 
&Scoped-Define DISPLAYED-OBJECTS v-ult_ano v-ult_mes v-generar ~
v-tip_comprob v-nro_comprob v-leyenda 

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
DEFINE VARIABLE v-leyenda AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-nro_comprob AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(256)":U 
     LABEL "Modelo" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-ult_ano AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Año" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-ult_mes AS INTEGER FORMAT "99":U INITIAL 0 
     LABEL "Mes" 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 89 BY 4.33.

DEFINE VARIABLE v-generar AS LOGICAL INITIAL no 
     LABEL "Generar Asiento" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .76 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-ult_ano AT ROW 1.48 COL 16 COLON-ALIGNED
     v-ult_mes AT ROW 1.52 COL 30 COLON-ALIGNED
     v-generar AT ROW 1.52 COL 65
     v-tip_comprob AT ROW 3.95 COL 16 COLON-ALIGNED
     v-nro_comprob AT ROW 3.95 COL 24 COLON-ALIGNED NO-LABEL
     v-leyenda AT ROW 3.95 COL 39 COLON-ALIGNED NO-LABEL
     RECT-1 AT ROW 1 COL 1
     "     Indique el asiento modelo a ejecutar para distribución de resultados" VIEW-AS TEXT
          SIZE 68 BY .86 AT ROW 2.86 COL 18
          BGCOLOR 7 FGCOLOR 15 
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
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 6.1
         WIDTH              = 92.2.
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
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-leyenda IN FRAME F-Main
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

&Scoped-define SELF-NAME v-nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob V-table-Win
ON MOUSE-MENU-DOWN OF v-nro_comprob IN FRAME F-Main
DO:
  DEFINE VARIABLE rid AS ROWID.
  RUN SELASMOD.P (OUTPUT rid).
  IF rid <> ?
  THEN DO:
     FIND Amd_header WHERE ROWID(Amd_header) = rid NO-LOCK.
     DISPLAY Amd_header.tip_comprob @ v-tip_comprob
             Amd_header.nro_comprob @ v-nro_comprob
             Amd_header.leyenda     @ v-leyenda        
             WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO v-nro_comprob IN FRAME {&FRAME-NAME}.
  END.  
  RETURN NO-APPLY.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob V-table-Win
ON RETURN OF v-nro_comprob IN FRAME F-Main
DO:
   FIND Amd_header WHERE Amd_header.tip_comprob = INPUT FRAME {&FRAME-NAME} v-tip_comprob 
                     AND Amd_header.nro_comprob = INPUT FRAME {&FRAME-NAME} v-nro_comprob 
                         NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Amd_header
   THEN DO:
      RUN PONMENSJ.P (INPUT "ASIE007").
      RETURN NO-APPLY.
   END.
   ELSE DO:   
      IF Amd_header.modo_importes <> "P"
      THEN DO:
         RUN PONMENSJ.P (INPUT "ASIE008").
         RETURN NO-APPLY.
      END.
      ELSE DO:         
         DISPLAY Amd_header.tip_comprob @ v-tip_comprob
                 Amd_header.nro_comprob @ v-nro_comprob
                 Amd_header.leyenda     @ v-leyenda        
                 WITH FRAME {&FRAME-NAME}.
      END.           
   END.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-ult_mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-ult_mes V-table-Win
ON LEAVE OF v-ult_mes IN FRAME F-Main /* Mes */
DO:
   IF INPUT v-ult_mes < 1 OR
      INPUT v-ult_mes > 12
   THEN DO:
      RUN PONMENSJ.P (INPUT "ASIE004").
      RETURN NO-APPLY.
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

  DEFINE OUTPUT PARAMETER p-ult_ano          AS INTEGER.
  DEFINE OUTPUT PARAMETER p-ult_mes          AS INTEGER.
  DEFINE OUTPUT PARAMETER p-generar          AS LOGICAL.
  DEFINE OUTPUT PARAMETER p-tip_comprob      AS CHARACTER.
  DEFINE OUTPUT PARAMETER p-nro_comprob      AS CHARACTER.
  DEFINE OUTPUT PARAMETER error_rango        AS LOGICAL.

  error_rango = YES.

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN 
           v-ult_ano     
           v-ult_mes     
           v-generar     
           v-tip_comprob 
           v-nro_comprob.


     IF INPUT v-ult_mes < 1 OR
        INPUT v-ult_mes > 12
     THEN DO:
        RUN PONMENSJ.P (INPUT "ASIE004").
        RETURN ERROR.
     END.     
 
     FIND Amd_header WHERE Amd_header.tip_comprob = INPUT FRAME {&FRAME-NAME} v-tip_comprob 
                       AND Amd_header.nro_comprob = INPUT FRAME {&FRAME-NAME} v-nro_comprob 
                           NO-LOCK NO-ERROR.
  
     IF NOT AVAILABLE Amd_header
     THEN DO:
        RUN PONMENSJ.P (INPUT "ASIE007").
        RETURN ERROR.
     END.
     ELSE DO:   
        IF Amd_header.modo_importes <> "P"
        THEN DO:
             RUN PONMENSJ.P (INPUT "ASIE008").
             RETURN ERROR.
        END.
     END.   

     ASSIGN
            p-ult_ano          = v-ult_ano
            p-ult_mes          = v-ult_mes
            p-generar          = v-generar
            p-tip_comprob      = v-tip_comprob
            p-nro_comprob      = v-nro_comprob
            error_rango        = NO.  
 
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

