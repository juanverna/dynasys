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
&Scoped-define EXTERNAL-TABLES Rubro
&Scoped-define FIRST-EXTERNAL-TABLE Rubro


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Rubro.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Rubro.abrevia Rubro.nombre Rubro.tipo ~
Rubro.habilitado Rubro.es_retencion Rubro.modo_deposito ~
Rubro.admite_negativo Rubro.imp_minimo Rubro.imp_maximo ~
Rubro.requiere_observacion 
&Scoped-define ENABLED-TABLES Rubro
&Scoped-define FIRST-ENABLED-TABLE Rubro
&Scoped-Define ENABLED-OBJECTS RECT-5 RECT-6 RECT-7 RECT-8 
&Scoped-Define DISPLAYED-FIELDS Rubro.abrevia Rubro.cdg_rubro Rubro.nombre ~
Rubro.tipo Rubro.habilitado Rubro.es_retencion Rubro.modo_deposito ~
Rubro.admite_negativo Rubro.imp_minimo Rubro.imp_maximo ~
Rubro.requiere_observacion 
&Scoped-define DISPLAYED-TABLES Rubro
&Scoped-define FIRST-DISPLAYED-TABLE Rubro
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-dsc_cuenta v-cdg_moneda ~
v-dsc_moneda v-cdg_banco v-dsc_banco 

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
DEFINE VARIABLE v-cdg_banco AS INTEGER FORMAT "999" INITIAL 0 
     LABEL "Banco" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(8)" INITIAL "0" 
     LABEL "Imputación" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_moneda AS CHARACTER FORMAT "X(8)" 
     LABEL "Moneda" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_banco AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_moneda AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 89 BY 14.52.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 25 BY 2.62.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 19 BY 2.62.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 26 BY 2.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Rubro.abrevia AT ROW 1.48 COL 69 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rubro.cdg_rubro AT ROW 1.52 COL 15 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rubro.nombre AT ROW 2.62 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 70 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cuenta AT ROW 3.67 COL 15 COLON-ALIGNED HELP
          "Numero interno de la cuenta de acreditación de valores"
     v-dsc_cuenta AT ROW 3.67 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_moneda AT ROW 4.81 COL 15 COLON-ALIGNED HELP
          "Numero interno de la cuenta de acreditación de valores"
     v-dsc_moneda AT ROW 4.81 COL 29 COLON-ALIGNED NO-LABEL
     v-cdg_banco AT ROW 6 COL 15 COLON-ALIGNED HELP
          "Numero interno de la cuenta de acreditación de valores"
     v-dsc_banco AT ROW 6 COL 29 COLON-ALIGNED NO-LABEL
     Rubro.tipo AT ROW 8.38 COL 16 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 7
          LIST-ITEM-PAIRS "Dineral","D",
                     "Valor al Cobro","V",
                     "Valor de Cambio","C",
                     "Acreditación Bria.","A",
                     "Débito Bancario","B",
                     "Cheque Propio","P",
                     "Retención","R"
          DROP-DOWN-LIST
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rubro.habilitado AT ROW 8.38 COL 42 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Ingreso","I",
                     "Egreso","E",
                     "Ambos","A"
          DROP-DOWN-LIST
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rubro.es_retencion AT ROW 8.38 COL 60 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "No es Retención","NO",
                     "Ganancias","GAN",
                     "Ingresos Brutos","IBR",
                     "I.V.A.","IVA",
                     "SUSS","SUS"
          DROP-DOWN-LIST
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rubro.modo_deposito AT ROW 11.24 COL 17 NO-LABEL WIDGET-ID 4
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Solamente depositarlos en cuenta", "D":U,
"Solamente darlos en pago a terceros", "N":U,
"Ambas modalidades están admitidas", "A":U
          SIZE 41 BY 3
     Rubro.admite_negativo AT ROW 11.48 COL 62 WIDGET-ID 14
          VIEW-AS TOGGLE-BOX
          SIZE 25 BY .81
     Rubro.imp_minimo AT ROW 13 COL 68 COLON-ALIGNED WIDGET-ID 16 FORMAT "->>>,>>9.99"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rubro.imp_maximo AT ROW 14.1 COL 67.8 COLON-ALIGNED WIDGET-ID 12
          LABEL "Maximo"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1 TOOLTIP "Poner 0 si no tiene maximo"
          BGCOLOR 15 FGCOLOR 9 
     Rubro.requiere_observacion AT ROW 14.33 COL 17.2 WIDGET-ID 10
          LABEL "Requiere observacion"
          VIEW-AS TOGGLE-BOX
          SIZE 37 BY .81
     "  Habilitado para" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 7.43 COL 43
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     "     Tipo de Rubro" VIEW-AS TEXT
          SIZE 23 BY .81 AT ROW 7.43 COL 18
          BGCOLOR 7 FGCOLOR 15 
     "     Tipo de Retención" VIEW-AS TEXT
          SIZE 24 BY .81 AT ROW 7.43 COL 62
          BGCOLOR 7 FGCOLOR 15 
     "   En el caso de que este rubro sea de tipo valores, con estos se puede:" VIEW-AS TEXT
          SIZE 70 BY 1 AT ROW 10.05 COL 17 WIDGET-ID 2
          BGCOLOR 7 FGCOLOR 15 
     RECT-5 AT ROW 1 COL 1
     RECT-6 AT ROW 7.19 COL 17
     RECT-7 AT ROW 7.19 COL 42
     RECT-8 AT ROW 7.19 COL 61
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Rubro
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
         HEIGHT             = 14.67
         WIDTH              = 92.4.
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

/* SETTINGS FOR FILL-IN Rubro.cdg_rubro IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX Rubro.es_retencion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Rubro.habilitado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Rubro.imp_maximo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Rubro.imp_minimo IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR TOGGLE-BOX Rubro.requiere_observacion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Rubro.tipo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_banco IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_moneda IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_banco IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_moneda IN FRAME F-Main
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

&Scoped-define SELF-NAME Rubro.tipo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Rubro.tipo V-table-Win
ON VALUE-CHANGED OF Rubro.tipo IN FRAME F-Main /* Tipo */
DO:
  IF INPUT FRAME {&FRAME-NAME} Rubro.tipo = "R"
  THEN DO:
      Rubro.es_retencion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
      Rubro.es_retencion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "NO".
      Rubro.es_retencion:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
      IF INPUT FRAME {&FRAME-NAME} Rubro.tipo = "V"
      THEN DO:
          Rubro.modo_deposito:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
          DISPLAY Rubro.modo_deposito
              WITH FRAME {&FRAME-NAME}.
      END.
      ELSE DO:
          Rubro.modo_deposito:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_banco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_banco V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_banco IN FRAME F-Main /* Banco */
OR "." OF v-cdg_banco IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_banco IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "banco" "cdg_banco" "selbanco.p"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_banco V-table-Win
ON RETURN OF v-cdg_banco IN FRAME F-Main /* Banco */
DO:
   {traducetabla.i "banco" "cdg_banco" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cuenta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cuenta IN FRAME F-Main /* Imputación */
OR "." OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cuenta IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Cuenta" "cdg_cuenta" "selcuent.p"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cuenta V-table-Win
ON RETURN OF v-cdg_cuenta IN FRAME F-Main /* Imputación */
DO:
   {traducetabla.i "Cuenta" "cdg_cuenta" "nombre_cta"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_moneda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_moneda IN FRAME F-Main /* Moneda */
OR "." OF v-cdg_moneda IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_moneda IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Moneda" "cdg_moneda" "selmoned.p"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_moneda V-table-Win
ON RETURN OF v-cdg_moneda IN FRAME F-Main /* Moneda */
DO:
   {traducetabla.i "Moneda" "cdg_moneda" "descripcion"} 
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
  {src/adm/template/row-list.i "Rubro"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Rubro"}

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

  Rubro.cdg_rubro:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {blanqueacodigo.i "Cuenta"}
   {blanqueacodigo.i "Moneda"}
   {blanqueacodigo.i "Banco"}

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

    DEFINE BUFFER B-Rubro FOR Rubro.
    
    IF CAN-FIND(FIRST B-Rubro 
                       WHERE B-Rubro.cdg_rubro = 
                           INPUT FRAME {&FRAME-NAME} Rubro.cdg_rubro  
                        AND ROWID(B-Rubro) <> ROWID(Rubro) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "RUBR002").
         RETURN ERROR.
    END. 

    IF INPUT FRAME {&FRAME-NAME} Rubro.cdg_rubro = 0   
    THEN DO:
         RUN PONMENSJ.P (INPUT "RUBR006").
         RETURN ERROR.
    END.

    IF INPUT FRAME {&FRAME-NAME} Rubro.nombre = ""   
    THEN DO:
         RUN PONMENSJ.P (INPUT "RUBR001").
         RETURN ERROR.
    END.                  


    IF Rubro.tipo:SCREEN-VALUE IN FRAM {&FRAME-NAME} = "R" AND Rubro.es_retencion:SCREEN-VALUE IN FRAM {&FRAME-NAME} = "NO"
    THEN DO:
         RUN PONMENSJ.P (INPUT "RUBR005").
         RETURN ERROR.
    END.            
   
   &SCOPED-DEFINE TABLA-MAESTRA  Rubro
   
   {validartabla.i "Moneda" "cdg_moneda" "descripcion" "MONE003"} 
   {validartabla.i "Cuenta" "cdg_cuenta" "nombre_cta" "RUBR003"} 
   {validartabla.i "Banco" "cdg_banco" "nombre" "RUBR007"} 

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Rubro

   {asignartabla.i "Moneda" "nro_moneda" "nro_moneda"} 
   {asignartabla.i "Cuenta" "nro_cuenta" "nro_cuenta"} 
   {asignartabla.i "Banco"  "cdg_banco"  "cdg_banco"} 

   &UNDEFINE TABLA-MAESTRA
  
    ASSIGN FRAME {&FRAME-NAME} Rubro.es_retencion.
    ASSIGN FRAME {&FRAME-NAME} Rubro.cdg_rubro.

    Rubro.cdg_rubro:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-cancel-record V-table-Win 
PROCEDURE local-cancel-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  Rubro.cdg_rubro:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'cancel-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  Rubro.cdg_rubro:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

   DEFINE VARIABLE baja_no AS LOGICAL.
   RUN vlb-rubro_caja.p ( INPUT ROWID(Rubro), OUTPUT baja_no ).
   IF baja_no 
   THEN DO:
        RUN PONMENSJ.P ( "IREF001" ).
        RETURN ERROR.
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

  {deshabcodigo.i "Cuenta"}
  {deshabcodigo.i "Moneda"}
  {deshabcodigo.i "Banco"}

   DISABLE 
        Rubro.es_retencion
        WITH FRAME {&FRAME-NAME}.

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

  IF AVAILABLE Rubro
  THEN DO:
      &SCOPED-DEFINE TABLA-MAESTRA  Rubro
      {displaytabla.i "Cuenta" "cdg_cuenta" "nombre_cta" "nro_cuenta" "nro_cuenta"} 
      {displaytabla.i "Moneda" "cdg_moneda" "descripcion" "nro_moneda" "nro_moneda"} 
      {displaytabla.i "Banco" "cdg_banco" "nombre" "cdg_banco" "cdg_banco"} 
      &UNDEFINE TABLA-MAESTRA
  END.
  ELSE DO:
      {blanqueacodigo.i "Cuenta"}
      {blanqueacodigo.i "Moneda"}
      {blanqueacodigo.i "Banco"}
      Rubro.es_retencion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "NO".
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

  {habilcodigo.i "Cuenta"}
  {habilcodigo.i "Moneda"}
  {habilcodigo.i "Banco"}

  Rubro.es_retencion:SENSITIVE IN FRAME {&FRAME-NAME} = Rubro.tipo = "R".

  IF INPUT FRAME {&FRAME-NAME} Rubro.tipo = "R"
  THEN DO:
      Rubro.es_retencion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
      Rubro.es_retencion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "NO".
      Rubro.es_retencion:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
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
  {src/adm/template/snd-list.i "Rubro"}

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

