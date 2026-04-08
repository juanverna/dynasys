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
&Scoped-Define ENABLED-OBJECTS RECT-1 Bigual des_fecha has_fecha has_hora ~
des_hora 
&Scoped-Define DISPLAYED-OBJECTS des_fecha has_fecha has_hora des_hora 

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setfechas V-table-Win 
FUNCTION setfechas RETURNS LOGICAL
  ( fd AS DATE , fh AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD sethoras V-table-Win 
FUNCTION sethoras RETURNS LOGICAL
  ( hd AS INT , hh AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Bigual 
     LABEL "=" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Desde Fecha" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE des_hora AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Hora" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Hasta Fecha" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE has_hora AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Hora" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 100 BY 3.33.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Bigual AT ROW 1.71 COL 41 WIDGET-ID 2
     des_fecha AT ROW 1.81 COL 16 COLON-ALIGNED
     has_fecha AT ROW 1.81 COL 71 COLON-ALIGNED
     has_hora AT ROW 2.91 COL 71.2 COLON-ALIGNED WIDGET-ID 6
     des_hora AT ROW 3 COL 16 COLON-ALIGNED WIDGET-ID 4
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
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 3.43
         WIDTH              = 100.8.
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

&Scoped-define SELF-NAME Bigual
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bigual V-table-Win
ON CHOOSE OF Bigual IN FRAME F-Main /* = */
DO:
  has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME} = des_fecha:SCREEN-VALUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha V-table-Win
ON MOUSE-MENU-DOWN OF des_fecha IN FRAME F-Main /* Desde Fecha */
DO:
  fecha_inicial = DATE(des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha V-table-Win
ON RETURN OF des_fecha IN FRAME F-Main /* Desde Fecha */
DO:

  IF DATE(des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = DATE("")
  THEN DO:
       des_fecha = TODAY.
       DISPLAY des_fecha
               WITH FRAME {&FRAME-NAME}.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_hora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_hora V-table-Win
ON LEAVE OF des_hora IN FRAME F-Main /* Hora */
DO:
  IF INPUT des_hora > 2359 THEN DO:
      MESSAGE "Hora invalida"VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha V-table-Win
ON MOUSE-MENU-DOWN OF has_fecha IN FRAME F-Main /* Hasta Fecha */
DO:

  fecha_inicial = DATE(has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha V-table-Win
ON RETURN OF has_fecha IN FRAME F-Main /* Hasta Fecha */
DO:
  IF DATE(has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = DATE("")
  THEN DO:
       has_fecha = TODAY.
       DISPLAY has_fecha
               WITH FRAME {&FRAME-NAME}.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_hora
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_hora V-table-Win
ON LEAVE OF has_hora IN FRAME F-Main /* Hora */
DO:
  IF INPUT has_hora > 2359 THEN DO:
      MESSAGE "Hora invalida"VIEW-AS ALERT-BOX ERROR.
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

  DEFINE OUTPUT PARAMETER p-des_fecha   AS DATE.
  DEFINE OUTPUT PARAMETER p-has_fecha   AS DATE.
  DEFINE OUTPUT PARAMETER p-des_hora AS INT.
  DEFINE OUTPUT PARAMETER p-has_hora AS INT.
  DEFINE OUTPUT PARAMETER error_rango   AS LOGICAL.

  error_rango = NO.
  
  DO WITH FRAME {&FRAME-NAME}:

        des_fecha = DATE(des_fecha:SCREEN-VALUE) NO-ERROR.
        IF ERROR-STATUS:ERROR OR des_fecha = DATE("") THEN error_rango = YES.

        has_fecha = DATE(has_fecha:SCREEN-VALUE) NO-ERROR.
        IF ERROR-STATUS:ERROR OR has_fecha = DATE("") THEN error_rango = YES.

        IF NOT error_rango
        THEN DO:
             IF has_fecha < des_fecha
             THEN DO:
                error_rango = YES.
             END.
             ELSE DO: 
                ASSIGN des_hora
                    has_hora.
                p-des_fecha = des_fecha.
                p-has_fecha = has_fecha.
                p-des_hora = des_hora.
                p-has_hora = has_hora.
             END.
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
 DEF VAR a AS DATE NO-UNDO.
 DEFINE VAR b AS INT NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  a = DATE(MONTH(TODAY),1,YEAR(TODAY)) + 32.
  
/*des_fecha = DATE(MONTH(TODAY),1,YEAR(TODAY)).*/
des_fecha = TODAY.
has_fecha = des_fecha.
/* has_fecha = date(month(a),1,YEAR(a)) - 1.*/
RUN getparametro_n.p("HORCCAJA", OUTPUT b).
des_hora = b.
has_hora = b.
IF b <> 0 THEN
 has_fecha = has_fecha + 1.
DISPLAY des_fecha has_fecha has_hora des_hora WITH FRAME   {&FRAME-NAME}.
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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setfechas V-table-Win 
FUNCTION setfechas RETURNS LOGICAL
  ( fd AS DATE , fh AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  des_fecha = fd.
  has_fecha = fh.
  DISPLAY des_fecha has_fecha WITH FRAME {&FRAME-NAME}.

  RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION sethoras V-table-Win 
FUNCTION sethoras RETURNS LOGICAL
  ( hd AS INT , hh AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  des_hora = hd.
  has_hora = hh.
  DISPLAY des_hora has_hora WITH FRAME {&FRAME-NAME}.

  RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

