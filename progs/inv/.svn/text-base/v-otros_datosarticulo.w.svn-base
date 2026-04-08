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
&Scoped-define EXTERNAL-TABLES Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Articulo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Articulo.modo_volumen Articulo.modo_etiquetas ~
Articulo.ley_merma Articulo.periodo_merma Articulo.perdida_merma ~
Articulo.prcmax_merma Articulo.sumaneto Articulo.retornable ~
Articulo.cyorden_sino Articulo.importado Articulo.codigo_barra ~
Articulo.extendida Articulo.granel_pesado Articulo.cdg_bcaja ~
Articulo.dec_precio Articulo.metodo_costeo Articulo.cdg_bean ~
Articulo.cdg_bitf14 Articulo.unidxpres Articulo.ancho_caja ~
Articulo.cdg_busa Articulo.kgxun_neto Articulo.alto_caja ~
Articulo.kgxun_bruto Articulo.prof_caja Articulo.es_bduso ~
Articulo.es_registrable Articulo.prc_tolerancia Articulo.relacion_granel 
&Scoped-define ENABLED-TABLES Articulo
&Scoped-define FIRST-ENABLED-TABLE Articulo
&Scoped-Define ENABLED-OBJECTS RECT-12 RECT-8 
&Scoped-Define DISPLAYED-FIELDS Articulo.cdg_articulo Articulo.descripcion ~
Articulo.modo_volumen Articulo.modo_etiquetas Articulo.ley_merma ~
Articulo.total_comprado Articulo.periodo_merma Articulo.perdida_merma ~
Articulo.unidades_compradas Articulo.prcmax_merma Articulo.granel_comprado ~
Articulo.sumaneto Articulo.retornable Articulo.cyorden_sino ~
Articulo.importado Articulo.costo Articulo.codigo_barra Articulo.fch_costo ~
Articulo.extendida Articulo.granel_pesado Articulo.cdg_bcaja ~
Articulo.dec_precio Articulo.metodo_costeo Articulo.cdg_bean ~
Articulo.cdg_bitf14 Articulo.unidxpres Articulo.ancho_caja ~
Articulo.cdg_busa Articulo.kgxun_neto Articulo.alto_caja ~
Articulo.kgxun_bruto Articulo.prof_caja Articulo.es_bduso ~
Articulo.es_registrable Articulo.detallada Articulo.prc_tolerancia ~
Articulo.relacion_granel 
&Scoped-define DISPLAYED-TABLES Articulo
&Scoped-define FIRST-DISPLAYED-TABLE Articulo


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
DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 126 BY 20.71.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 79 BY 1.43.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Articulo.cdg_articulo AT ROW 1.48 COL 11 COLON-ALIGNED
          LABEL "Articulo"
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 7 FGCOLOR 15 
     Articulo.descripcion AT ROW 1.48 COL 27 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 51 BY 1
          BGCOLOR 7 FGCOLOR 15 
     Articulo.modo_volumen AT ROW 2.67 COL 84 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Ninguno", "",
"Directo", "D":U,
"Escalado", "E":U
          SIZE 18 BY 2.38
     Articulo.modo_etiquetas AT ROW 2.91 COL 105 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Juntas", "J":U,
"Independientes", "I":U
          SIZE 19.8 BY 1.91
     Articulo.ley_merma AT ROW 4.1 COL 9 COLON-ALIGNED
          LABEL "Modo"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "No merma",0,
                     "Lineal",1,
                     "Exponencial",2
          DROP-DOWN-LIST
          SIZE 34 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.total_comprado AT ROW 4.1 COL 54 COLON-ALIGNED
          LABEL "Pesos" FORMAT "->>>>>>>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.periodo_merma AT ROW 5.29 COL 9 COLON-ALIGNED
          LABEL "Ciclo" FORMAT ">>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.perdida_merma AT ROW 5.29 COL 34 COLON-ALIGNED
          LABEL "Pérdida %" FORMAT ">>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.unidades_compradas AT ROW 5.29 COL 54 COLON-ALIGNED
          LABEL "Uns." FORMAT "->>>>>>>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.prcmax_merma AT ROW 6.48 COL 9 COLON-ALIGNED FORMAT ">>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.granel_comprado AT ROW 6.48 COL 54 COLON-ALIGNED
          LABEL "Granel" FORMAT "->>>>>>>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.sumaneto AT ROW 6.48 COL 85 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "No", 0,
"Si", 1
          SIZE 17 BY .95
     Articulo.retornable AT ROW 6.48 COL 106 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Si", "S":U,
"No", ""
          SIZE 18 BY 1
     Articulo.cyorden_sino AT ROW 8.86 COL 4
          LABEL "Cuenta y Orden"
          VIEW-AS TOGGLE-BOX
          SIZE 20 BY .81
     Articulo.importado AT ROW 8.86 COL 24
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .81
     Articulo.costo AT ROW 8.86 COL 54 COLON-ALIGNED
          LABEL "Valor"
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.codigo_barra AT ROW 8.86 COL 90 COLON-ALIGNED
          LABEL "Interno"
          VIEW-AS FILL-IN NATIVE 
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.fch_costo AT ROW 9.95 COL 54 COLON-ALIGNED
          LABEL "Fecha"
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Articulo.extendida AT ROW 10.05 COL 4
          VIEW-AS TOGGLE-BOX
          SIZE 21 BY .81
     Articulo.granel_pesado AT ROW 10.05 COL 24
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .81
     Articulo.cdg_bcaja AT ROW 10.05 COL 90 COLON-ALIGNED
          LABEL "Caja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.dec_precio AT ROW 11.24 COL 35 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.metodo_costeo AT ROW 11.24 COL 54 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Standard","ST",
                     "P.P.P.","PP"
          DROP-DOWN-LIST
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.cdg_bean AT ROW 11.24 COL 90 COLON-ALIGNED
          LABEL "EAN"
          VIEW-AS FILL-IN NATIVE 
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.cdg_bitf14 AT ROW 12.43 COL 90 COLON-ALIGNED
          LABEL "ITF14"
          VIEW-AS FILL-IN NATIVE 
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.unidxpres AT ROW 13.62 COL 20 COLON-ALIGNED
          LABEL "U.x Bulto"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.ancho_caja AT ROW 13.62 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.cdg_busa AT ROW 13.62 COL 90 COLON-ALIGNED
          LABEL "USA"
          VIEW-AS FILL-IN NATIVE 
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.kgxun_neto AT ROW 14.81 COL 20 COLON-ALIGNED
          LABEL "Peso Neto"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.alto_caja AT ROW 14.81 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.kgxun_bruto AT ROW 16 COL 20 COLON-ALIGNED
          LABEL "Peso Bruto"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.prof_caja AT ROW 16 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.es_bduso AT ROW 16.24 COL 86
          VIEW-AS TOGGLE-BOX
          SIZE 18 BY .81
     Articulo.es_registrable AT ROW 16.24 COL 106
          VIEW-AS TOGGLE-BOX
          SIZE 18 BY .81
     Articulo.detallada AT ROW 18.62 COL 4 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 91 BY 2.62
          BGCOLOR 15 FGCOLOR 7 
     Articulo.prc_tolerancia AT ROW 18.62 COL 108 COLON-ALIGNED
          LABEL "% Tolerancia"
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo.relacion_granel AT ROW 20.05 COL 104 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-12 AT ROW 1 COL 1
     RECT-8 AT ROW 1.24 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     "  Información de Merma" VIEW-AS TEXT
          SIZE 40 BY 1 AT ROW 2.91 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "   Dtos.  X Volumen" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 1.48 COL 83
          BGCOLOR 5 FGCOLOR 15 
     "  Retornable" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 5.29 COL 104
          BGCOLOR 5 FGCOLOR 15 
     "   Etiquetas" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 1.48 COL 104
          BGCOLOR 5 FGCOLOR 15 
     "   Relación Granel y Cantidad" VIEW-AS TEXT
          SIZE 30 BY 1 AT ROW 17.43 COL 95
          BGCOLOR 5 FGCOLOR 15 
     "    Embalaje en Peso (Kg) y Capacidad (M)" VIEW-AS TEXT
          SIZE 76 BY 1 AT ROW 12.43 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "   Otros Seteos del Artículo" VIEW-AS TEXT
          SIZE 41 BY 1 AT ROW 7.67 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "   Relación con los Bienes de Uso" VIEW-AS TEXT
          SIZE 41 BY 1 AT ROW 14.81 COL 84
          BGCOLOR 5 FGCOLOR 15 
     "    Descripción detallada asociada al artículo" VIEW-AS TEXT
          SIZE 90 BY 1 AT ROW 17.43 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "   Código de Barras Asociados al Artículo" VIEW-AS TEXT
          SIZE 41 BY 1 AT ROW 7.67 COL 84
          BGCOLOR 5 FGCOLOR 15 
     "  Total Ingresado" VIEW-AS TEXT
          SIZE 33 BY 1 AT ROW 2.91 COL 47
          BGCOLOR 5 FGCOLOR 15 
     "   Información de Costos" VIEW-AS TEXT
          SIZE 33 BY 1 AT ROW 7.67 COL 47
          BGCOLOR 5 FGCOLOR 15 
     "   Suma Neto" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 5.29 COL 84
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Articulo
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
         HEIGHT             = 23.91
         WIDTH              = 139.4.
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

/* SETTINGS FOR FILL-IN Articulo.cdg_articulo IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Articulo.cdg_bcaja IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.cdg_bean IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.cdg_bitf14 IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.cdg_busa IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.codigo_barra IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.costo IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR TOGGLE-BOX Articulo.cyorden_sino IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.descripcion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR Articulo.detallada IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Articulo.fch_costo IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Articulo.granel_comprado IN FRAME F-Main
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN Articulo.kgxun_bruto IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.kgxun_neto IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Articulo.ley_merma IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.perdida_merma IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Articulo.periodo_merma IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Articulo.prcmax_merma IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Articulo.prc_tolerancia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.total_comprado IN FRAME F-Main
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN Articulo.unidades_compradas IN FRAME F-Main
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN Articulo.unidxpres IN FRAME F-Main
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

&Scoped-define SELF-NAME Articulo.cyorden_sino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Articulo.cyorden_sino V-table-Win
ON VALUE-CHANGED OF Articulo.cyorden_sino IN FRAME F-Main /* Cuenta y Orden */
DO:
  /* RUN habilitar_proveedor ( INPUT SELF:INPUT-VALUE ).*/

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
  {src/adm/template/row-list.i "Articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
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

  Articulo.sumaneto:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1".
  Articulo.detallada:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN FRAME {&FRAME-NAME} Articulo.detallada.

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

  Articulo.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  Articulo.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

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

  Articulo.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  Articulo.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 9.


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

