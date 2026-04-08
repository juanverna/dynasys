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

DEFINE VARIABLE rid_tabla AS ROWID.

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
&Scoped-define EXTERNAL-TABLES Concepto
&Scoped-define FIRST-EXTERNAL-TABLE Concepto


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Concepto.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Concepto.cdg_concepto Concepto.descripcion ~
Concepto.abreviatura Concepto.desde_fecha Concepto.hasta_fecha ~
Concepto.unidad Concepto.observacion Concepto.obligatorio ~
Concepto.haber_retenc Concepto.temporario Concepto.salario_fliar ~
Concepto.formula 
&Scoped-define ENABLED-TABLES Concepto
&Scoped-define FIRST-ENABLED-TABLE Concepto
&Scoped-Define ENABLED-OBJECTS RECT-3 RECT-4 RECT-5 
&Scoped-Define DISPLAYED-FIELDS Concepto.cdg_concepto Concepto.descripcion ~
Concepto.abreviatura Concepto.desde_fecha Concepto.hasta_fecha ~
Concepto.unidad Concepto.observacion Concepto.obligatorio ~
Concepto.haber_retenc Concepto.temporario Concepto.salario_fliar ~
Concepto.formula 
&Scoped-define DISPLAYED-TABLES Concepto
&Scoped-define FIRST-DISPLAYED-TABLE Concepto
&Scoped-Define DISPLAYED-OBJECTS v-cdg_sumador v-dsc_sumador ~
v-cdg_totalizador v-dsc_totalizador FILL-IN-3 

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
DEFINE VARIABLE FILL-IN-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_sumador AS INTEGER FORMAT ">>9" INITIAL 0 
     LABEL "Sumador" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_totalizador AS INTEGER FORMAT ">>9" INITIAL 0 
     LABEL "Totalizador" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_sumador AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_totalizador AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 3.52.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 92 BY 16.67.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 20 BY 3.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Concepto.cdg_concepto AT ROW 1.24 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Concepto.descripcion AT ROW 1.29 COL 41 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 48 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Concepto.abreviatura AT ROW 2.43 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Concepto.desde_fecha AT ROW 2.43 COL 41 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Concepto.hasta_fecha AT ROW 2.43 COL 75 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_sumador AT ROW 3.62 COL 13 COLON-ALIGNED HELP
          "Sumador en que se acumula este concepto"
     v-dsc_sumador AT ROW 3.67 COL 27 COLON-ALIGNED NO-LABEL
     v-cdg_totalizador AT ROW 4.71 COL 13 COLON-ALIGNED HELP
          "Código del totalizador"
     v-dsc_totalizador AT ROW 4.76 COL 27 COLON-ALIGNED NO-LABEL
     Concepto.unidad AT ROW 5.81 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     FILL-IN-3 AT ROW 5.86 COL 27 COLON-ALIGNED NO-LABEL
     Concepto.observacion AT ROW 8.29 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 42 BY 3.52
          BGCOLOR 15 FGCOLOR 7 
     Concepto.obligatorio AT ROW 8.62 COL 47
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .76
     Concepto.haber_retenc AT ROW 8.62 COL 67 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Haber", "H":U,
"Retencion", "R":U,
"Aporte/Contribución", "A":U,
"Contrapartida", "C":U
          SIZE 23 BY 3.1
     Concepto.temporario AT ROW 9.81 COL 47
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     Concepto.salario_fliar AT ROW 11 COL 47
          VIEW-AS TOGGLE-BOX
          SIZE 18 BY .76
     Concepto.formula AT ROW 13.14 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 88 BY 4.05
          BGCOLOR 15 FGCOLOR 7 
     RECT-3 AT ROW 8.38 COL 66
     RECT-4 AT ROW 1 COL 1
     RECT-5 AT ROW 8.38 COL 46
     "     Fórmula de cálculo del concepto" VIEW-AS TEXT
          SIZE 88 BY 1 AT ROW 12.05 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "     Observaciones" VIEW-AS TEXT
          SIZE 42 BY 1 AT ROW 7.19 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "     Atributos de Liquidación del Concepto" VIEW-AS TEXT
          SIZE 45 BY 1 AT ROW 7.19 COL 46
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Concepto
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
         HEIGHT             = 26.33
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
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN FILL-IN-3 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_sumador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_totalizador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_sumador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_totalizador IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_sumador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_sumador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_sumador IN FRAME F-Main /* Sumador */
OR "." OF v-cdg_sumador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_sumador IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Sumador" "cdg_sumador" "SELSUMAD.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_sumador V-table-Win
ON RETURN OF v-cdg_sumador IN FRAME F-Main /* Sumador */
DO:
    {traducetabla.i "Sumador" "cdg_sumador" "dsc_sumador"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_totalizador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_totalizador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_totalizador IN FRAME F-Main /* Totalizador */
OR "." OF v-cdg_totalizador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_totalizador IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Totalizador" "cdg_totalizador" "SELTOTAL.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_totalizador V-table-Win
ON RETURN OF v-cdg_totalizador IN FRAME F-Main /* Totalizador */
DO:
    {traducetabla.i "Totalizador" "cdg_totalizador" "dsc_totalizador"} 
  
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
  {src/adm/template/row-list.i "Concepto"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Concepto"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {blanqueacodigo.i "Sumador"}
  {blanqueacodigo.i "Totalizador"}

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

     DEFINE VARIABLE rc_sintax AS INTEGER.
     DEFINE VARIABLE palabra   AS CHARACTER.
     DEFINE VARIABLE caracter  AS CHARACTER.
     DEFINE VARIABLE aux_total AS DECIMAL.

     IF ROWID(Concepto) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE000").
        RETURN.
     END.

     IF INPUT FRAME {&FRAME-NAME} Concepto.descripcion = "" OR 
        INPUT FRAME {&FRAME-NAME} Concepto.descripcion = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Concepto 
                       WHERE Concepto.cdg_concepto = INPUT FRAME {&FRAME-NAME} Concepto.cdg_concepto  
                         AND ROWID(Concepto) <> rid_tabla )
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE002").
        RETURN.
     END.            

     IF INPUT FRAME {&FRAME-NAME} Concepto.abreviatura = "" OR 
        INPUT FRAME {&FRAME-NAME} Concepto.abreviatura = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE003").
        RETURN.
     END.            

     IF INPUT FRAME {&FRAME-NAME} Concepto.obligatorio AND 
        INPUT FRAME {&FRAME-NAME} Concepto.temporario
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE005").
        RETURN.
     END.            

     RUN vrsintax.p ( INPUT FRAME {&FRAME-NAME} Concepto.formula,
                      OUTPUT rc_sintax, 
                      OUTPUT palabra, 
                      OUTPUT caracter).
     IF rc_sintax <> 0 
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE006").
        RETURN.
     END.            

     /*
     {IFNOTEXS.I "Sumador"  "cdg_sumador"  "{&FRAME-NAME}" "Concepto" "cdg_sumador"  "CNCE004" }
     {IFNOTEXS.I "Totalizador"  "cdg_totalizador"  "{&FRAME-NAME}" "Concepto" "cdg_totalizador"  "CNCE007" }
     */


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

     IF NEW Concepto
     THEN DO:
          Concepto.nro_concepto = NEXT-VALUE(proximo_concepto).
     END.


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

  DO WITH FRAME {&FRAME-NAME}:
    Concepto.formula:SENSITIVE = NO.
    Concepto.observacion:SENSITIVE = NO.
    
    Concepto.formula:FGCOLOR = 7.
    Concepto.observacion:FGCOLOR = 7.
    
  END.
  
  {deshabcodigo.i "Sumador"}
  {deshabcodigo.i "Totalizador"}
  
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

  IF AVAILABLE Concepto
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Concepto

        {displaytabla.i "Sumador" "cdg_sumador" "dsc_sumador" "cdg_sumador" "cdg_sumador"} 
        {displaytabla.i "Totalizador" "cdg_totalizador" "dsc_totalizador" "cdg_totalizador" "cdg_totalizador"} 

        &UNDEFINE TABLA-MAESTRA

  END.


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

  DO WITH FRAME {&FRAME-NAME}:
    Concepto.formula:SENSITIVE = YES.
    Concepto.observacion:SENSITIVE = YES.
    
    Concepto.formula:FGCOLOR = 9.
    Concepto.observacion:FGCOLOR = 9.
    
  END.

  {habilcodigo.i "Sumador"}
  {habilcodigo.i "Totalizador"}

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
  {src/adm/template/snd-list.i "Concepto"}

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

