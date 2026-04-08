&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Provincia NO-UNDO LIKE Provincia
       FIELD habilitado AS LOGICAL.



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
&Scoped-define EXTERNAL-TABLES Impuesto_condicion Condicion_impos
&Scoped-define FIRST-EXTERNAL-TABLE Impuesto_condicion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Impuesto_condicion, Condicion_impos.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Impuesto_condicion.tasa ~
Impuesto_condicion.valor_minimo Impuesto_condicion.imp_minimo ~
Impuesto_condicion.fch_desde Impuesto_condicion.fch_hasta 
&Scoped-define ENABLED-TABLES Impuesto_condicion
&Scoped-define FIRST-ENABLED-TABLE Impuesto_condicion
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-9 
&Scoped-Define DISPLAYED-FIELDS Impuesto_condicion.tasa ~
Impuesto_condicion.valor_minimo Impuesto_condicion.imp_minimo ~
Impuesto_condicion.fch_desde Impuesto_condicion.fch_hasta 
&Scoped-define DISPLAYED-TABLES Impuesto_condicion
&Scoped-define FIRST-DISPLAYED-TABLE Impuesto_condicion
&Scoped-Define DISPLAYED-OBJECTS v-cdg_impuesto v-dsc_impuesto ~
v-cdg_familia_impositiva v-dsc_familia_impositiva v-cab v-bas v-sfe v-err ~
v-cor v-mis v-cba v-sgo v-tuc v-cat v-cha v-for v-sal v-juy v-nqn v-lpa ~
v-rng v-chu v-lrj v-SJU v-mdz v-sls v-scz v-tfg 

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
DEFINE BUTTON btn_todas 
     LABEL "&Todas" 
     SIZE 12 BY .81.

DEFINE VARIABLE v-cdg_familia_impositiva AS CHARACTER FORMAT "X(8)" 
     LABEL "F.Impositiva" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_impuesto AS INTEGER FORMAT ">>>,>>9" INITIAL 0 
     LABEL "Impuesto" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_familia_impositiva AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 58 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_impuesto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 58 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 4.05.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 5.14.

DEFINE VARIABLE v-bas AS LOGICAL INITIAL no 
     LABEL "BAS" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-cab AS LOGICAL INITIAL no 
     LABEL "CAB" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-cat AS LOGICAL INITIAL no 
     LABEL "CAT" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-cba AS LOGICAL INITIAL no 
     LABEL "CBA" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-cha AS LOGICAL INITIAL no 
     LABEL "CHA" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-chu AS LOGICAL INITIAL no 
     LABEL "CHU" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-cor AS LOGICAL INITIAL no 
     LABEL "COR" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-err AS LOGICAL INITIAL no 
     LABEL "ERR" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-for AS LOGICAL INITIAL no 
     LABEL "FOR" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-juy AS LOGICAL INITIAL no 
     LABEL "JUY" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-lpa AS LOGICAL INITIAL no 
     LABEL "LPA" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-lrj AS LOGICAL INITIAL no 
     LABEL "LRJ" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-mdz AS LOGICAL INITIAL no 
     LABEL "MDZ" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-mis AS LOGICAL INITIAL no 
     LABEL "MIS" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-nqn AS LOGICAL INITIAL no 
     LABEL "NQN" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-rng AS LOGICAL INITIAL no 
     LABEL "RNG" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-sal AS LOGICAL INITIAL no 
     LABEL "SAL" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-scz AS LOGICAL INITIAL no 
     LABEL "SCZ" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-sfe AS LOGICAL INITIAL no 
     LABEL "SFE" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-sgo AS LOGICAL INITIAL no 
     LABEL "SGO" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-SJU AS LOGICAL INITIAL no 
     LABEL "SJU" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-sls AS LOGICAL INITIAL no 
     LABEL "SLS" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-tfg AS LOGICAL INITIAL no 
     LABEL "TFG" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.

DEFINE VARIABLE v-tuc AS LOGICAL INITIAL no 
     LABEL "TUC" 
     VIEW-AS TOGGLE-BOX
     SIZE 7 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_impuesto AT ROW 1.52 COL 13 COLON-ALIGNED
     v-dsc_impuesto AT ROW 1.52 COL 26 COLON-ALIGNED NO-LABEL
     v-cdg_familia_impositiva AT ROW 2.62 COL 13 COLON-ALIGNED
     v-dsc_familia_impositiva AT ROW 2.62 COL 26 COLON-ALIGNED NO-LABEL
     Impuesto_condicion.tasa AT ROW 3.67 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Impuesto_condicion.valor_minimo AT ROW 3.67 COL 42 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Impuesto_condicion.imp_minimo AT ROW 3.67 COL 72 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Impuesto_condicion.fch_desde AT ROW 4.76 COL 13 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Impuesto_condicion.fch_hasta AT ROW 4.76 COL 42 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY .81
          BGCOLOR 15 FGCOLOR 9 
     btn_todas AT ROW 4.76 COL 74
     v-cab AT ROW 7.71 COL 7
     v-bas AT ROW 7.71 COL 17
     v-sfe AT ROW 7.71 COL 27
     v-err AT ROW 7.71 COL 37
     v-cor AT ROW 7.71 COL 47
     v-mis AT ROW 7.71 COL 57
     v-cba AT ROW 7.71 COL 66
     v-sgo AT ROW 7.71 COL 76
     v-tuc AT ROW 8.52 COL 7
     v-cat AT ROW 8.52 COL 17
     v-cha AT ROW 8.52 COL 27
     v-for AT ROW 8.52 COL 37
     v-sal AT ROW 8.52 COL 47
     v-juy AT ROW 8.52 COL 57
     v-nqn AT ROW 8.52 COL 66
     v-lpa AT ROW 8.52 COL 76
     v-rng AT ROW 9.33 COL 7
     v-chu AT ROW 9.33 COL 17
     v-lrj AT ROW 9.33 COL 27
     v-SJU AT ROW 9.33 COL 37
     v-mdz AT ROW 9.33 COL 47
     v-sls AT ROW 9.33 COL 57
     v-scz AT ROW 9.33 COL 66
     v-tfg AT ROW 9.33 COL 76
     "          Provincias de Aplicación del Impuesto" VIEW-AS TEXT
          SIZE 84 BY .81 AT ROW 6.67 COL 2
          BGCOLOR 7 FGCOLOR 15 
     RECT-10 AT ROW 6.38 COL 1
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Impuesto_condicion,sic.Condicion_impos
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Provincia T "?" NO-UNDO sic Provincia
      ADDITIONAL-FIELDS:
          FIELD habilitado AS LOGICAL
      END-FIELDS.
   END-TABLES.
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
         HEIGHT             = 12
         WIDTH              = 87.4.
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

/* SETTINGS FOR BUTTON btn_todas IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Impuesto_condicion.fch_desde IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Impuesto_condicion.fch_hasta IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR TOGGLE-BOX v-bas IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-bas:PRIVATE-DATA IN FRAME F-Main     = 
                "01".

/* SETTINGS FOR TOGGLE-BOX v-cab IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-cab:PRIVATE-DATA IN FRAME F-Main     = 
                "00".

/* SETTINGS FOR TOGGLE-BOX v-cat IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-cat:PRIVATE-DATA IN FRAME F-Main     = 
                "02".

/* SETTINGS FOR TOGGLE-BOX v-cba IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-cba:PRIVATE-DATA IN FRAME F-Main     = 
                "03".

/* SETTINGS FOR FILL-IN v-cdg_familia_impositiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_impuesto IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX v-cha IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-cha:PRIVATE-DATA IN FRAME F-Main     = 
                "16".

/* SETTINGS FOR TOGGLE-BOX v-chu IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-chu:PRIVATE-DATA IN FRAME F-Main     = 
                "17".

/* SETTINGS FOR TOGGLE-BOX v-cor IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-cor:PRIVATE-DATA IN FRAME F-Main     = 
                "04".

/* SETTINGS FOR FILL-IN v-dsc_familia_impositiva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_impuesto IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX v-err IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-err:PRIVATE-DATA IN FRAME F-Main     = 
                "05".

/* SETTINGS FOR TOGGLE-BOX v-for IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-for:PRIVATE-DATA IN FRAME F-Main     = 
                "FOR".

/* SETTINGS FOR TOGGLE-BOX v-juy IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-juy:PRIVATE-DATA IN FRAME F-Main     = 
                "06".

/* SETTINGS FOR TOGGLE-BOX v-lpa IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-lpa:PRIVATE-DATA IN FRAME F-Main     = 
                "21".

/* SETTINGS FOR TOGGLE-BOX v-lrj IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-lrj:PRIVATE-DATA IN FRAME F-Main     = 
                "08".

/* SETTINGS FOR TOGGLE-BOX v-mdz IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-mdz:PRIVATE-DATA IN FRAME F-Main     = 
                "07".

/* SETTINGS FOR TOGGLE-BOX v-mis IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-mis:PRIVATE-DATA IN FRAME F-Main     = 
                "19".

/* SETTINGS FOR TOGGLE-BOX v-nqn IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-nqn:PRIVATE-DATA IN FRAME F-Main     = 
                "20".

/* SETTINGS FOR TOGGLE-BOX v-rng IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-rng:PRIVATE-DATA IN FRAME F-Main     = 
                "22".

/* SETTINGS FOR TOGGLE-BOX v-sal IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-sal:PRIVATE-DATA IN FRAME F-Main     = 
                "09".

/* SETTINGS FOR TOGGLE-BOX v-scz IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-scz:PRIVATE-DATA IN FRAME F-Main     = 
                "23".

/* SETTINGS FOR TOGGLE-BOX v-sfe IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-sfe:PRIVATE-DATA IN FRAME F-Main     = 
                "12".

/* SETTINGS FOR TOGGLE-BOX v-sgo IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-sgo:PRIVATE-DATA IN FRAME F-Main     = 
                "13".

/* SETTINGS FOR TOGGLE-BOX v-SJU IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-SJU:PRIVATE-DATA IN FRAME F-Main     = 
                "10".

/* SETTINGS FOR TOGGLE-BOX v-sls IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-sls:PRIVATE-DATA IN FRAME F-Main     = 
                "11".

/* SETTINGS FOR TOGGLE-BOX v-tfg IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-tfg:PRIVATE-DATA IN FRAME F-Main     = 
                "24".

/* SETTINGS FOR TOGGLE-BOX v-tuc IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       v-tuc:PRIVATE-DATA IN FRAME F-Main     = 
                "14".

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

&Scoped-define SELF-NAME btn_todas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todas V-table-Win
ON CHOOSE OF btn_todas IN FRAME F-Main /* Todas */
DO:
  IF btn_todas:LABEL IN FRAME {&FRAME-NAME} = "&Todas"
  THEN DO:
       RUN poner_valor_sino ( INPUT YES ).
       btn_todas:LABEL IN FRAME {&FRAME-NAME} = "&Ninguna".
  END.
  ELSE DO:
       RUN poner_valor_sino ( INPUT NO ).
       btn_todas:LABEL IN FRAME {&FRAME-NAME} = "&Todas".
  END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_familia_impositiva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_impositiva V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_familia_impositiva IN FRAME F-Main /* F.Impositiva */
OR "." OF v-cdg_familia_impositiva IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_familia_impositiva IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Familia_impositiva" "cdg_familimpos" "SELFIMPOS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_familia_impositiva V-table-Win
ON RETURN OF v-cdg_familia_impositiva IN FRAME F-Main /* F.Impositiva */
DO:
    {traducetabla.i "Familia_impositiva" "cdg_familimpos" "dsc_familimpos"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_impuesto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_impuesto V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_impuesto IN FRAME F-Main /* Impuesto */
OR "." OF v-cdg_impuesto IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_impuesto IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "impuesto" "cdg_impuesto" "SELIMPUE.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_impuesto V-table-Win
ON RETURN OF v-cdg_impuesto IN FRAME F-Main /* Impuesto */
DO:
    {traducetabla.i "Impuesto" "cdg_impuesto" "nombre"}   
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
  {src/adm/template/row-list.i "Impuesto_condicion"}
  {src/adm/template/row-list.i "Condicion_impos"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Impuesto_condicion"}
  {src/adm/template/row-find.i "Condicion_impos"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_provincias V-table-Win 
PROCEDURE grabar_provincias :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE VARIABLE hToggle AS HANDLE.
  
 Impuesto_condicion.lista_provincias = "".
 hToggle = v-cab:HANDLE IN FRAME {&FRAME-NAME}.
 DO WHILE hToggle:TYPE = "TOGGLE-BOX":
    IF hToggle:SCREEN-VALUE = "YES" 
       THEN Impuesto_condicion.lista_provincias = Impuesto_condicion.lista_provincias + "," + hToggle:PRIVATE-DATA.
    hToggle = hToggle:NEXT-SIBLING.

 END.
 IF Impuesto_condicion.lista_provincias <> ""
    THEN Impuesto_condicion.lista_provincias = SUBSTRING(Impuesto_condicion.lista_provincias,2).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_provincias V-table-Win 
PROCEDURE habilitar_provincias :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-estado AS LOGICAL.

  DEFINE VARIABLE hToggle AS HANDLE.

  DO WITH FRAME {&FRAME-NAME}:

     hToggle = v-cab:HANDLE IN FRAME {&FRAME-NAME}.

     DO WHILE hToggle:TYPE = "TOGGLE-BOX":
        hToggle:SENSITIVE = p-estado.
        hToggle = hToggle:NEXT-SIBLING.

     END.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE leer_provincias V-table-Win 
PROCEDURE leer_provincias :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE VARIABLE hToggle AS HANDLE.
  
 hToggle = v-cab:HANDLE IN FRAME {&FRAME-NAME}.

 DO WHILE hToggle:TYPE = "TOGGLE-BOX":
    IF LOOKUP(hToggle:PRIVATE-DATA,Impuesto_condicion.lista_provincias,",") <> 0
       THEN hToggle:SCREEN-VALUE = "YES".
       ELSE hToggle:SCREEN-VALUE = "NO".
    hToggle = hToggle:NEXT-SIBLING.

 END.

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

  {blanqueacodigo.i "Impuesto"}
  {blanqueacodigo.i "Familia_impositiva"}

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

   &SCOPED-DEFINE TABLA-MAESTRA  Impuesto_condicion

   {validartabla.i "Impuesto" "cdg_impuesto" "nombre" "CIMP001"} 
   {validartabla.i "Familia_impositiva" "cdg_familimpos" "dsc_familimpos" "CIMP002"} 

   &UNDEFINE TABLA-MAESTRA

   IF Impuesto_condicion.tasa:INPUT-VALUE = 0
   THEN DO:
        RUN ponmensj.p ( INPUT "CIMP003").
        RETURN ERROR.
   END.
   
   IF Impuesto_condicion.fch_desde:INPUT-VALUE = DATE("")
   THEN DO:
        RUN ponmensj.p ( INPUT "CIMP004").
        RETURN ERROR.
   END.

   IF Impuesto_condicion.fch_hasta:INPUT-VALUE = DATE("")
   THEN DO:
        RUN ponmensj.p ( INPUT "CIMP005").
        RETURN ERROR.
   END.

   IF Impuesto_condicion.fch_desde:INPUT-VALUE >= Impuesto_condicion.fch_hasta:INPUT-VALUE
   THEN DO:
        RUN ponmensj.p ( INPUT "CIMP006").
        RETURN ERROR.
   END.

   DO WITH FRAME {&FRAME-NAME}:

      ASSIGN 
            v-bas  v-cab  v-cat  v-cba  v-cha  v-chu  
            v-cor  v-err  v-for  v-juy  v-lpa  v-lrj  
            v-mdz  v-mis  v-nqn  v-rng  v-sal  v-scz  
            v-sfe  v-sgo  v-sju  v-sls  v-tfg  v-tuc .
   END.

   IF NOT ( v-bas  OR v-cab  OR v-cat  OR v-cba  OR v-cha  OR v-chu OR
            v-cor  OR v-err  OR v-for  OR v-juy  OR v-lpa  OR v-lrj OR
            v-mdz  OR v-mis  OR v-nqn  OR v-rng  OR v-sal  OR v-scz OR 
            v-sfe  OR v-sgo  OR v-sju  OR v-sls  OR v-tfg  OR v-tuc)
   THEN DO:
        RUN ponmensj.p ( INPUT "CIMP007").
        RETURN ERROR.
   END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Impuesto_condicion

   {asignartabla.i "Impuesto" "cdg_impuesto" "cdg_impuesto"} 
   {asignartabla.i "Familia_impositiva" "nro_familimpos" "nro_familimpos"} 

   &UNDEFINE TABLA-MAESTRA

  {findempresa.i}
  
  Impuesto_condicion.cdg_condiva = Condicion_impos.cdg_condiva.
  Impuesto_condicion.cdg_empresa = Empresa.cdg_empresa.
  RUN grabar_provincias.  

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

  {deshabcodigo.i "Impuesto"}
  {deshabcodigo.i "Familia_impositiva"}

  RUN habilitar_provincias ( NO ).
  btn_todas:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  IF AVAILABLE Impuesto_condicion 
      THEN RUN leer_provincias.
      ELSE RUN provincias_no.

  IF AVAILABLE Impuesto_condicion
  THEN DO:

       &SCOPED-DEFINE TABLA-MAESTRA  Impuesto_condicion

       {displaytabla.i "Impuesto" "cdg_impuesto" "nombre" "cdg_impuesto" "cdg_impuesto"} 
       {displaytabla.i "Familia_impositiva" "cdg_familimpos" "dsc_familimpos" "nro_familimpos" "nro_familimpos"} 

       &UNDEFINE TABLA-MAESTRA

  END.
  ELSE DO:
      {blanqueacodigo.i "Impuesto"}
      {blanqueacodigo.i "Familia_impositiva"}
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

  {habilcodigo.i "Impuesto"}
  {habilcodigo.i "Familia_impositiva"}

  RUN habilitar_provincias ( YES ).
  btn_todas:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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

  DEFINE VARIABLE hToggle AS HANDLE.

  hToggle = v-cab:HANDLE IN FRAME {&FRAME-NAME}.

  DO WHILE hToggle:TYPE = "TOGGLE-BOX":
     FIND Provincia WHERE Provincia.sigla_prov = hToggle:LABEL NO-LOCK NO-ERROR.
     IF AVAILABLE Provincia
        THEN hToggle:PRIVATE-DATA = Provincia.cdg_provincia.
        ELSE MESSAGE "No existe la provincia con abreviatura " hToggle:LABEL
             VIEW-AS ALERT-BOX MESSAGE TITLE "ERROR DE IMPLEMENTACION!!!".
     hToggle = hToggle:NEXT-SIBLING.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_valor_sino V-table-Win 
PROCEDURE poner_valor_sino :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE INPUT PARAMETER p-estado AS LOGICAL.
 
 DEFINE VARIABLE hToggle AS HANDLE.
  
 hToggle = v-cab:HANDLE IN FRAME {&FRAME-NAME}.

 DO WHILE hToggle:TYPE = "TOGGLE-BOX":
    hToggle:SCREEN-VALUE = STRING(p-estado).
    hToggle = hToggle:NEXT-SIBLING.

 END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE provincias_no V-table-Win 
PROCEDURE provincias_no :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE VARIABLE hToggle AS HANDLE.
  
 hToggle = v-cab:HANDLE IN FRAME {&FRAME-NAME}.

 DO WHILE hToggle:TYPE = "TOGGLE-BOX":
    hToggle:SCREEN-VALUE = "NO".
    hToggle = hToggle:NEXT-SIBLING.

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
  {src/adm/template/snd-list.i "Impuesto_condicion"}
  {src/adm/template/snd-list.i "Condicion_impos"}

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

