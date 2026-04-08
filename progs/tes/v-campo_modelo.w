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

DEFINE VARIABLE x-secuencia AS CHARACTER.

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
&Scoped-define EXTERNAL-TABLES Campo_modelocheque Modelocheque
&Scoped-define FIRST-EXTERNAL-TABLE Campo_modelocheque


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Campo_modelocheque, Modelocheque.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Campo_modelocheque.cdg_campomodelo ~
Campo_modelocheque.valor_fijo Campo_modelocheque.x_campomodelo ~
Campo_modelocheque.y_campomodelo Campo_modelocheque.n_campomodelo ~
Campo_modelocheque.s1_campomodelo Campo_modelocheque.s2_campomodelo 
&Scoped-define ENABLED-TABLES Campo_modelocheque
&Scoped-define FIRST-ENABLED-TABLE Campo_modelocheque
&Scoped-Define ENABLED-OBJECTS RECT-4 
&Scoped-Define DISPLAYED-FIELDS Campo_modelocheque.cdg_campomodelo ~
Campo_modelocheque.valor_fijo Campo_modelocheque.x_campomodelo ~
Campo_modelocheque.y_campomodelo Campo_modelocheque.n_campomodelo ~
Campo_modelocheque.s1_campomodelo Campo_modelocheque.s2_campomodelo 
&Scoped-define DISPLAYED-TABLES Campo_modelocheque
&Scoped-define FIRST-DISPLAYED-TABLE Campo_modelocheque


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
DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 136 BY 5.24.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Campo_modelocheque.cdg_campomodelo AT ROW 1.24 COL 17 COLON-ALIGNED
          LABEL "Campo" FORMAT "X(25)"
          VIEW-AS COMBO-BOX INNER-LINES 21
          LIST-ITEM-PAIRS "Número de Cheque","numero_cheque",
                     "Fecha de Emisión","fecha_emision",
                     "Día Fecha Emisión","diafch_emision",
                     "Mes Fecha Emisión","mesfch_emision",
                     "Año Fecha Emisión","anofch_emision",
                     "Nombre Mes Fecha Emisión","nomesfch_emision",
                     "Fecha de Pago","fecha_pago",
                     "Día Fecha Pago","diafch_pago",
                     "Mes Fecha Pago","mesfch_pago",
                     "Año Fecha Pago","anofch_pago",
                     "Nombre Mes Fecha Pago","nomesfch_pago",
                     "Importe","importe",
                     "Monto Letras 1","monto_letras1",
                     "Monto Letras 2","monto_letras2",
                     "Orden","orden",
                     "Orden2","orden2",
                     "Observación","observacion",
                     "Firmante","firmante",
                     "Empresa","empresa",
                     "Dato Fijo","datofijo",
                     "Lugar de Pago","lugarpago",
                     "No a la Orden","noalaorden"
          DROP-DOWN-LIST
          SIZE 115 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Campo_modelocheque.valor_fijo AT ROW 2.43 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 62 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Campo_modelocheque.x_campomodelo AT ROW 2.43 COL 85 COLON-ALIGNED
          LABEL "X"
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Campo_modelocheque.y_campomodelo AT ROW 2.43 COL 102 COLON-ALIGNED
          LABEL "Y"
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Campo_modelocheque.n_campomodelo AT ROW 2.43 COL 126 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6.2 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Campo_modelocheque.s1_campomodelo AT ROW 3.62 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 115 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Campo_modelocheque.s2_campomodelo AT ROW 4.81 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 115 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-4 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Campo_modelocheque,sic.Modelocheque
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
         HEIGHT             = 9.1
         WIDTH              = 143.2.
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

/* SETTINGS FOR COMBO-BOX Campo_modelocheque.cdg_campomodelo IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Campo_modelocheque.x_campomodelo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Campo_modelocheque.y_campomodelo IN FRAME F-Main
   EXP-LABEL                                                            */
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

&Scoped-define SELF-NAME Campo_modelocheque.s1_campomodelo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Campo_modelocheque.s1_campomodelo V-table-Win
ON MOUSE-MENU-DOWN OF Campo_modelocheque.s1_campomodelo IN FRAME F-Main /* Sec. Anterior */
OR SHIFT-F1 OF Campo_modelocheque.s1_campomodelo IN FRAME {&FRAME-NAME}
DO:
  x-secuencia = Campo_modelocheque.s1_campomodelo.
  RUN selectar_secuencias.p ( INPUT-OUTPUT  x-secuencia, INPUT Modelocheque.cdg_impresora ).
  DISPLAY x-secuencia @ Campo_modelocheque.s1_campomodelo 
      WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Campo_modelocheque.s2_campomodelo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Campo_modelocheque.s2_campomodelo V-table-Win
ON MOUSE-MENU-DOWN OF Campo_modelocheque.s2_campomodelo IN FRAME F-Main /* Sec. Posterior */
OR SHIFT-F1 OF Campo_modelocheque.s2_campomodelo IN FRAME {&FRAME-NAME}
DO:
  x-secuencia = Campo_modelocheque.s2_campomodelo.
  RUN selectar_secuencias.p ( INPUT-OUTPUT  x-secuencia, INPUT Modelocheque.cdg_impresora ).
  DISPLAY x-secuencia @ Campo_modelocheque.s2_campomodelo 
      WITH FRAME {&FRAME-NAME}.
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
  {src/adm/template/row-list.i "Campo_modelocheque"}
  {src/adm/template/row-list.i "Modelocheque"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Campo_modelocheque"}
  {src/adm/template/row-find.i "Modelocheque"}

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

   DEFINE VARIABLE k-entrada AS INTEGER.

   IF Campo_modelocheque.n_campomodelo:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0
   THEN DO:
       RUN ponmensj.p ( INPUT "MDCH001" ).
       RETURN ERROR.
   END.

   IF Campo_modelocheque.x_campomodelo:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0
   THEN DO:
       RUN ponmensj.p ( INPUT "MDCH002" ).
       RETURN ERROR.
   END.

   IF Campo_modelocheque.y_campomodelo:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0
   THEN DO:
       RUN ponmensj.p ( INPUT "MDCH003" ).
       RETURN ERROR.
   END.


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  Campo_modelocheque.cdg_modelocheque = Modelocheque.cdg_modelocheque.
  
  DO WITH FRAME {&FRAME-NAME}:
      k-entrada = Campo_modelocheque.cdg_campomodelo:LOOKUP(Campo_modelocheque.cdg_campomodelo:INPUT-VALUE).
      Campo_modelocheque.dsc_campomodelo = ENTRY( 2 * k-entrada - 1,Campo_modelocheque.cdg_campomodelo:LIST-ITEM-PAIRS,",").
  END.
  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF AVAILABLE Modelocheque
  THEN DO:
      IF Modelocheque.tipo_impresora = "Pixeles"
          THEN ASSIGN Campo_modelocheque.x_campomodelo:FORMAT IN FRAME {&FRAME-NAME} = ">>>>9.99"
                      Campo_modelocheque.y_campomodelo:FORMAT IN FRAME {&FRAME-NAME} = ">>>>9.99".
          ELSE ASSIGN Campo_modelocheque.x_campomodelo:FORMAT IN FRAME {&FRAME-NAME} = ">>>>9"
                      Campo_modelocheque.y_campomodelo:FORMAT IN FRAME {&FRAME-NAME} = ">>>>9".

  END.

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
  {src/adm/template/snd-list.i "Campo_modelocheque"}
  {src/adm/template/snd-list.i "Modelocheque"}

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

