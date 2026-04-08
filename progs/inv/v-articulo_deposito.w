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
&Scoped-define EXTERNAL-TABLES Articulo-deposito Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Articulo-deposito


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Articulo-deposito, Articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Articulo-deposito.parametros_manuales ~
Articulo-deposito.stk_maximo_cantidad ~
Articulo-deposito.stk_seguridad_cantidad ~
Articulo-deposito.stk_minimo_cantidad Articulo-deposito.stk_maximo_granel ~
Articulo-deposito.stk_minimo_granel Articulo-deposito.stk_seguridad_granel ~
Articulo-deposito.consumo_demanda_cantidad ~
Articulo-deposito.sigma_demanda_cantidad ~
Articulo-deposito.consumo_lead_cantidad ~
Articulo-deposito.sigma_lead_cantidad Articulo-deposito.loc_cantidad ~
Articulo-deposito.consumo_demanda_granel ~
Articulo-deposito.sigma_demanda_granel ~
Articulo-deposito.consumo_lead_granel Articulo-deposito.sigma_lead_granel ~
Articulo-deposito.loc_granel Articulo-deposito.hoja_numero ~
Articulo-deposito.st_recuento Articulo-deposito.criticidad ~
Articulo-deposito.lead_time Articulo-deposito.periodo_demanda ~
Articulo-deposito.fch_recuento Articulo-deposito.numero_periodos 
&Scoped-define ENABLED-TABLES Articulo-deposito
&Scoped-define FIRST-ENABLED-TABLE Articulo-deposito
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-11 RECT-12 RECT-5 RECT-9 
&Scoped-Define DISPLAYED-FIELDS Articulo-deposito.parametros_manuales ~
Articulo-deposito.remanente_cantidad Articulo-deposito.reservado_cantidad ~
Articulo-deposito.encompra_cantidad Articulo-deposito.stk_maximo_cantidad ~
Articulo-deposito.stk_seguridad_cantidad ~
Articulo-deposito.stk_minimo_cantidad Articulo-deposito.reservado_granel ~
Articulo-deposito.stk_maximo_granel Articulo-deposito.remanente_granel ~
Articulo-deposito.stk_minimo_granel Articulo-deposito.encompra_granel ~
Articulo-deposito.stk_seguridad_granel ~
Articulo-deposito.consumo_demanda_cantidad ~
Articulo-deposito.sigma_demanda_cantidad ~
Articulo-deposito.consumo_lead_cantidad ~
Articulo-deposito.sigma_lead_cantidad Articulo-deposito.loc_cantidad ~
Articulo-deposito.consumo_demanda_granel ~
Articulo-deposito.sigma_demanda_granel ~
Articulo-deposito.consumo_lead_granel Articulo-deposito.sigma_lead_granel ~
Articulo-deposito.loc_granel Articulo-deposito.hoja_numero ~
Articulo-deposito.st_recuento Articulo-deposito.criticidad ~
Articulo-deposito.lead_time Articulo-deposito.periodo_demanda ~
Articulo-deposito.fch_parametros Articulo-deposito.fch_recuento ~
Articulo-deposito.numero_periodos 
&Scoped-define DISPLAYED-TABLES Articulo-deposito
&Scoped-define FIRST-DISPLAYED-TABLE Articulo-deposito
&Scoped-Define DISPLAYED-OBJECTS v-cdg_deposito v-dsc_deposito ~
v-abrevia_cantidad v-abrevia_granel 

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
DEFINE VARIABLE v-abrevia_cantidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-abrevia_granel AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(256)" 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 126 BY 1.67.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 21 BY 4.05.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 63 BY 4.05.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 126 BY 7.62.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 41 BY 4.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Articulo-deposito.parametros_manuales AT ROW 1.24 COL 101
          VIEW-AS TOGGLE-BOX
          SIZE 25 BY 1.05
     v-cdg_deposito AT ROW 1.29 COL 11 COLON-ALIGNED
     v-dsc_deposito AT ROW 1.29 COL 30 COLON-ALIGNED NO-LABEL
     Articulo-deposito.remanente_cantidad AT ROW 4.1 COL 11 COLON-ALIGNED
          LABEL "Unidades"
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.reservado_cantidad AT ROW 4.1 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.encompra_cantidad AT ROW 4.1 COL 49 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.stk_maximo_cantidad AT ROW 4.1 COL 68 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.stk_seguridad_cantidad AT ROW 4.1 COL 87 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.stk_minimo_cantidad AT ROW 4.14 COL 106 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.reservado_granel AT ROW 5.19 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.stk_maximo_granel AT ROW 5.19 COL 68 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.remanente_granel AT ROW 5.24 COL 11 COLON-ALIGNED
          LABEL "A Granel"
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.stk_minimo_granel AT ROW 5.24 COL 106 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.encompra_granel AT ROW 5.29 COL 49 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.stk_seguridad_granel AT ROW 5.29 COL 87 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 12 
     Articulo-deposito.consumo_demanda_cantidad AT ROW 7.67 COL 11 COLON-ALIGNED
          LABEL "Unidades"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.sigma_demanda_cantidad AT ROW 7.67 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.consumo_lead_cantidad AT ROW 7.67 COL 49 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.sigma_lead_cantidad AT ROW 7.67 COL 68 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.loc_cantidad AT ROW 7.67 COL 87 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     v-abrevia_cantidad AT ROW 7.67 COL 106 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Articulo-deposito.consumo_demanda_granel AT ROW 8.86 COL 11 COLON-ALIGNED
          LABEL "Granel"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.sigma_demanda_granel AT ROW 8.86 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.consumo_lead_granel AT ROW 8.86 COL 49 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.sigma_lead_granel AT ROW 8.86 COL 68 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.loc_granel AT ROW 8.86 COL 87 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 2 
     v-abrevia_granel AT ROW 8.86 COL 106 COLON-ALIGNED NO-LABEL
     Articulo-deposito.hoja_numero AT ROW 11.95 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo-deposito.st_recuento AT ROW 11.95 COL 26 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Pendiente", "",
"En Proceso", "P":U,
"Terminado", "R":U
          SIZE 16 BY 2.38
     Articulo-deposito.criticidad AT ROW 11.95 COL 44 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Normal (1)", 1,
"Alta (2)", 2,
"Muy Alta (3)", 3
          SIZE 18 BY 2.38
     Articulo-deposito.lead_time AT ROW 11.95 COL 75 COLON-ALIGNED FORMAT ">>>9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo-deposito.periodo_demanda AT ROW 11.95 COL 94 COLON-ALIGNED
          LABEL "Período" FORMAT ">>>9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.fch_parametros AT ROW 11.95 COL 112 COLON-ALIGNED
          LABEL "Fecha"
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 2 
     Articulo-deposito.fch_recuento AT ROW 13.14 COL 11 COLON-ALIGNED
          LABEL "Fecha"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo-deposito.numero_periodos AT ROW 13.14 COL 75 COLON-ALIGNED
          LABEL "Per.Hist."
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-10 AT ROW 1 COL 1
     RECT-11 AT ROW 10.52 COL 43
     RECT-12 AT ROW 10.52 COL 64
     RECT-5 AT ROW 2.67 COL 1
     RECT-9 AT ROW 10.52 COL 2
     " Punto Repedido" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.91 COL 108
          BGCOLOR 5 FGCOLOR 15 
     "  Consumo Lead" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.48 COL 51
          BGCOLOR 5 FGCOLOR 15 
     "  Lead Time, Período (días) y Ultima Actualización" VIEW-AS TEXT
          SIZE 61 BY 1 AT ROW 10.76 COL 65
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     "  Sigma Demanda" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.48 COL 32
          BGCOLOR 5 FGCOLOR 15 
     "  Sigma Lead" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.48 COL 70
          BGCOLOR 5 FGCOLOR 15 
     "       Unidades" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.48 COL 108
          BGCOLOR 7 FGCOLOR 15 
     "  O/C en Proceso" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.91 COL 51
          BGCOLOR 5 FGCOLOR 15 
     "      Criticidad" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 10.76 COL 44
          BGCOLOR 7 FGCOLOR 15 
     "   Stock Máximo" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.91 COL 70
          BGCOLOR 5 FGCOLOR 15 
     "   Reservado" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.91 COL 32
          BGCOLOR 5 FGCOLOR 15 
     "             Recuento Físico" VIEW-AS TEXT
          SIZE 39 BY 1 AT ROW 10.76 COL 3
          BGCOLOR 7 FGCOLOR 15 
     "   Remanente" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.91 COL 13
          BGCOLOR 5 FGCOLOR 15 
     "      Lote Optimo" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.48 COL 89
          BGCOLOR 5 FGCOLOR 15 
     " Stock Seguridad" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.91 COL 89
          BGCOLOR 5 FGCOLOR 15 
     " Consumo Deman" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.48 COL 13
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Articulo-deposito,sic.Articulo
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
         HEIGHT             = 17.29
         WIDTH              = 129.
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

/* SETTINGS FOR FILL-IN Articulo-deposito.consumo_demanda_cantidad IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo-deposito.consumo_demanda_granel IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo-deposito.encompra_cantidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Articulo-deposito.encompra_granel IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Articulo-deposito.fch_parametros IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Articulo-deposito.fch_recuento IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo-deposito.lead_time IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Articulo-deposito.numero_periodos IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo-deposito.periodo_demanda IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Articulo-deposito.remanente_cantidad IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Articulo-deposito.remanente_granel IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Articulo-deposito.reservado_cantidad IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Articulo-deposito.reservado_granel IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-abrevia_cantidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-abrevia_granel IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_deposito IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_deposito IN FRAME F-Main
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

&Scoped-define SELF-NAME Articulo-deposito.criticidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Articulo-deposito.criticidad V-table-Win
ON VALUE-CHANGED OF Articulo-deposito.criticidad IN FRAME F-Main /* Criti-!cidad */
DO:
  RUN recalcular_parametros.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_deposito IN FRAME F-Main /* Depósito */
OR "." OF v-cdg_deposito IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_deposito IN FRAME {&FRAME-NAME}

DO:

   {helptabla.i "Deposito" "cdg_deposito" "SELDEPOS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito V-table-Win
ON RETURN OF v-cdg_deposito IN FRAME F-Main /* Depósito */
DO:
   {traducetabla.i "Deposito" "cdg_deposito" "nombre"} 
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
  {src/adm/template/row-list.i "Articulo-deposito"}
  {src/adm/template/row-list.i "Articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Articulo-deposito"}
  {src/adm/template/row-find.i "Articulo"}

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

   {blanqueacodigo.i "Deposito"} 


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

   &SCOPED-DEFINE TABLA-MAESTRA  Articulo-deposito

   {validartabla.i "Deposito" "cdg_deposito" "nombre" "ARTI008"} 

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Articulo-deposito

   {asignartabla.i "Deposito" "nro_deposito" "nro_deposito"} 

   &UNDEFINE TABLA-MAESTRA

  IF NEW Articulo-deposito
  THEN DO:

       {findempresa.i}

       Articulo-deposito.nro_articulo = Articulo.nro_articulo.
       Articulo-deposito.cdg_empresa  = Empresa.cdg_empresa.

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

  v-cdg_deposito:SENSITIVE IN FRAME  {&FRAME-NAME} = NO.

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

  IF AVAILABLE Articulo-deposito
  THEN DO:
       FIND Deposito OF Articulo-deposito NO-LOCK.
       v-cdg_deposito = Deposito.cdg_deposito.
       v-dsc_deposito = Deposito.nombre.
       FIND Unidad OF Articulo NO-LOCK.
       v-abrevia_cantidad = Unidad.abrevia.
       FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
       v-abrevia_granel = Unidad.abrevia.
  END.
  ELSE DO:
      ASSIGN v-cdg_deposito = ""
             v-dsc_deposito = ""
             v-abrevia_cantidad = ""
             v-abrevia_granel = "".
  END.

  DISPLAY v-cdg_deposito
          v-dsc_deposito
          v-abrevia_cantidad
          v-abrevia_granel
          WITH FRAME {&FRAME-NAME}.

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

  v-cdg_deposito:SENSITIVE IN FRAME  {&FRAME-NAME} = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE recalcular_parametros V-table-Win 
PROCEDURE recalcular_parametros :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-criticidad                 LIKE Articulo-deposito.criticidad.
  DEFINE VARIABLE x-lead_time                  LIKE Articulo-deposito.lead_time. 
  DEFINE VARIABLE x-periodo_demanda            LIKE Articulo-deposito.periodo_demanda.

  DEFINE VARIABLE x-consumo_demanda_cantidad   LIKE Articulo-deposito.consumo_demanda_cantidad.
  DEFINE VARIABLE x-sigma_lead_cantidad        LIKE Articulo-deposito.sigma_lead_cantidad.

  DEFINE VARIABLE x-consumo_lead_cantidad      LIKE Articulo-deposito.consumo_lead_cantidad.
  DEFINE VARIABLE x-stk_seguridad_cantidad     LIKE Articulo-deposito.stk_seguridad_cantidad.
  DEFINE VARIABLE x-stk_minimo_cantidad        LIKE Articulo-deposito.stk_minimo_cantidad.

  x-criticidad = Articulo-deposito.criticidad:INPUT-VALUE IN FRAME {&FRAME-NAME}.
  x-lead_time = Articulo-deposito.lead_time:INPUT-VALUE IN FRAME {&FRAME-NAME}. 
  x-periodo_demanda = Articulo-deposito.periodo_demanda:INPUT-VALUE IN FRAME {&FRAME-NAME}. 
  x-consumo_demanda_cantidad = Articulo-deposito.consumo_demanda_cantidad:INPUT-VALUE IN FRAME {&FRAME-NAME}.
  x-sigma_lead_cantidad = Articulo-deposito.sigma_lead_cantidad:INPUT-VALUE IN FRAME {&FRAME-NAME}.

  x-consumo_lead_cantidad = x-consumo_demanda_cantidad  * x-lead_time / x-periodo_demanda.
  x-stk_seguridad_cantidad = x-sigma_lead_cantidad * x-criticidad.
  x-stk_minimo_cantidad = x-consumo_lead_cantidad + x-stk_seguridad_cantidad.

  DISPLAY x-stk_seguridad_cantidad  @ Articulo-deposito.stk_seguridad_cantidad
          x-stk_minimo_cantidad     @ Articulo-deposito.stk_minimo_cantidad
          x-consumo_lead_cantidad   @ Articulo-deposito.consumo_lead_cantidad
          WITH FRAME {&FRAME-NAME}.

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
  {src/adm/template/snd-list.i "Articulo-deposito"}
  {src/adm/template/snd-list.i "Articulo"}

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

