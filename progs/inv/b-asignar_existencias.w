&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
/*------------------------------------------------------------------------

  File:  

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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

  {dfcamest.i}

  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Deposito
&Scoped-define FIRST-EXTERNAL-TABLE Deposito


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Deposito.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rqs_header Rqs_detalle Articulo Unidad Area

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rqs_detalle.fecha_temprana ~
Articulo.cdg_articulo Articulo.descripcion Unidad.abrevia Area.cdg_area ~
Area.denominacion Rqs_header.nro_comprob Rqs_header.fecha 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Rqs_header OF Deposito WHERE ~{&KEY-PHRASE} ~
      AND Rqs_header.cdg_estado <> "ZZ" ~
 AND Rqs_header.tip_comprob = "PI" ~
 AND Rqs_header.cdg_empresa = Empresa.cdg_empresa NO-LOCK, ~
      EACH Rqs_detalle OF Rqs_header ~
      WHERE (Rqs_detalle.cdg_estado = que_estado) ~
 AND Rqs_detalle.fecha_temprana <= has_fecha ~
 AND Rqs_detalle.fecha_temprana >= des_fecha NO-LOCK, ~
      EACH Articulo OF Rqs_detalle NO-LOCK, ~
      EACH Unidad OF Articulo NO-LOCK, ~
      EACH Area OF Rqs_header NO-LOCK
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rqs_header OF Deposito WHERE ~{&KEY-PHRASE} ~
      AND Rqs_header.cdg_estado <> "ZZ" ~
 AND Rqs_header.tip_comprob = "PI" ~
 AND Rqs_header.cdg_empresa = Empresa.cdg_empresa NO-LOCK, ~
      EACH Rqs_detalle OF Rqs_header ~
      WHERE (Rqs_detalle.cdg_estado = que_estado) ~
 AND Rqs_detalle.fecha_temprana <= has_fecha ~
 AND Rqs_detalle.fecha_temprana >= des_fecha NO-LOCK, ~
      EACH Articulo OF Rqs_detalle NO-LOCK, ~
      EACH Unidad OF Articulo NO-LOCK, ~
      EACH Area OF Rqs_header NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Rqs_header Rqs_detalle Articulo ~
Unidad Area
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rqs_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Rqs_detalle
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Articulo
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table Unidad
&Scoped-define FIFTH-TABLE-IN-QUERY-br_table Area


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS des_fecha has_fecha que_estado br_table ~
btn_a-compras btn_a-almacenes btn_rechazar btn_revertir btn_renovar ~
v-observacion RECT-6 RECT-7 RECT-8 
&Scoped-Define DISPLAYED-OBJECTS des_fecha has_fecha que_estado ~
v-observacion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_comprador||y|sic.Rqs_header.nro_comprador
cdg_deposito||y|sic.Rqs_header.cdg_deposito
nro_entidad||y|sic.Rqs_header.nro_entidad
cdg_estado||y|sic.Rqs_header.cdg_estado
fecha||y|sic.Rqs_header.fecha
nro_moneda||y|sic.Rqs_header.nro_moneda
nro_ocompra||y|sic.Rqs_header.nro_ocompra
nro_requisicion||y|sic.Rqs_header.nro_requisicion
nro_area||y|sic.Rqs_header.nro_area
cdg_solicitante||y|sic.Rqs_header.cdg_solicitante
nro_usuario||y|sic.Rqs_header.nro_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_comprador,cdg_deposito,nro_entidad,cdg_estado,fecha,nro_moneda,nro_ocompra,nro_requisicion,nro_area,cdg_solicitante,nro_usuario"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_a-almacenes 
     LABEL "A &Preparar" 
     SIZE 22 BY 1
     FONT 4.

DEFINE BUTTON btn_a-compras 
     LABEL "A &Compras" 
     SIZE 22 BY 1
     FONT 4.

DEFINE BUTTON btn_rechazar 
     LABEL "&Rechazar" 
     SIZE 22 BY 1
     FONT 4.

DEFINE BUTTON btn_renovar 
     LABEL "Renovar Datos" 
     SIZE 22 BY 1
     FONT 4.

DEFINE BUTTON btn_revertir 
     LABEL "Re&vertir" 
     SIZE 22 BY 1
     FONT 4.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Del" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Al" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 16 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-observacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 117 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_estado AS CHARACTER INITIAL "AL" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Pendientes", "AL",
"A Compras", "AC",
"A Preparar", "PA",
"Rechazados", "RC"
     SIZE 65 BY .67
     FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 67 BY 1.67.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 51 BY 1.67.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 119 BY 2.57.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rqs_header, 
      Rqs_detalle, 
      Articulo, 
      Unidad, 
      Area SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Rqs_detalle.fecha_temprana COLUMN-LABEL "Entregar!antes del" FORMAT "99/99/9999":U
      Articulo.cdg_articulo FORMAT "X(12)":U
      Articulo.descripcion COLUMN-LABEL "Descripción!del artículo" FORMAT "X(36)":U
      Unidad.abrevia COLUMN-LABEL "Unidad!Medida" FORMAT "X(5)":U
      Area.cdg_area FORMAT "X(8)":U
      Area.denominacion COLUMN-LABEL "Denominación!Area" FORMAT "X(15)":U
      Rqs_header.nro_comprob COLUMN-LABEL "Número!Solicitud" FORMAT "ZZZZZZZ9":U
      Rqs_header.fecha COLUMN-LABEL "Fecha!Solicitud" FORMAT "99/99/99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 119 BY 6.43
         BGCOLOR 11 FGCOLOR 9 FONT 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     des_fecha AT ROW 1.24 COL 7 COLON-ALIGNED
     has_fecha AT ROW 1.24 COL 30 COLON-ALIGNED
     que_estado AT ROW 1.48 COL 54 NO-LABEL
     br_table AT ROW 2.91 COL 1
     btn_a-compras AT ROW 9.81 COL 25
     btn_a-almacenes AT ROW 9.81 COL 49
     btn_rechazar AT ROW 9.81 COL 73
     btn_revertir AT ROW 9.81 COL 97
     btn_renovar AT ROW 9.86 COL 2
     v-observacion AT ROW 10.95 COL 2 NO-LABEL
     RECT-6 AT ROW 1 COL 53
     RECT-7 AT ROW 1 COL 1
     RECT-8 AT ROW 9.62 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Deposito
   Allow: Basic,Browse
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 11.57
         WIDTH              = 136.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table que_estado F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:NUM-LOCKED-COLUMNS IN FRAME F-Main     = 1.

/* SETTINGS FOR FILL-IN v-observacion IN FRAME F-Main
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rqs_header OF sic.Deposito,sic.Rqs_detalle OF sic.Rqs_header,sic.Articulo OF sic.Rqs_detalle,sic.Unidad OF sic.Articulo,sic.Area OF sic.Rqs_header"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,,,"
     _Where[1]         = "Rqs_header.cdg_estado <> ""ZZ""
 AND Rqs_header.tip_comprob = ""PI""
 AND Rqs_header.cdg_empresa = Empresa.cdg_empresa"
     _Where[2]         = "(Rqs_detalle.cdg_estado = que_estado)
 AND Rqs_detalle.fecha_temprana <= has_fecha
 AND Rqs_detalle.fecha_temprana >= des_fecha"
     _FldNameList[1]   > sic.Rqs_detalle.fecha_temprana
"Rqs_detalle.fecha_temprana" "Entregar!antes del" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Articulo.cdg_articulo
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripción!del artículo" "X(36)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Unidad.abrevia
"Unidad.abrevia" "Unidad!Medida" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   = sic.Area.cdg_area
     _FldNameList[6]   > sic.Area.denominacion
"Area.denominacion" "Denominación!Area" "X(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Rqs_header.nro_comprob
"Rqs_header.nro_comprob" "Número!Solicitud" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic.Rqs_header.fecha
"Rqs_header.fecha" "Fecha!Solicitud" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

    RUN estado_botones.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_a-almacenes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_a-almacenes B-table-Win
ON CHOOSE OF btn_a-almacenes IN FRAME F-Main /* A Preparar */
DO:

   DO TRANSACTION:

      FIND FIRST Articulo-deposito OF Articulo 
           WHERE Articulo-deposito.nro_deposito = Deposito.nro_deposito 
             AND Articulo-deposito.cdg_empresa = Empresa.cdg_empresa
                 EXCLUSIVE-LOCK.
           
      Articulo-deposito.reservado_cantidad = Articulo-deposito.reservado_cantidad + 
                                              Rqs_detalle.cantidad.

      Articulo-deposito.reservado_granel   = Articulo-deposito.reservado_granel + 
                                              Rqs_detalle.granel.
      RELEASE Articulo-deposito.

      {tgbtcamb.i "CMBERQPA"}

      RUN dispatch IN THIS-PROCEDURE ('open-query').

   END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_a-compras
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_a-compras B-table-Win
ON CHOOSE OF btn_a-compras IN FRAME F-Main /* A Compras */
DO:
   {tgbtcamb.i "CMBERQAC"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar B-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar */
DO:
   {tgbtcamb.i "CMBERQRC"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_renovar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_renovar B-table-Win
ON CHOOSE OF btn_renovar IN FRAME F-Main /* Renovar Datos */
DO:
  ASSIGN des_fecha has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_revertir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_revertir B-table-Win
ON CHOOSE OF btn_revertir IN FRAME F-Main /* Revertir */
DO:

    IF Rqs_detalle.cdg_estado = "PA"
    THEN DO:

         FIND FIRST Articulo-deposito OF Articulo 
              WHERE Articulo-deposito.nro_deposito = Deposito.nro_deposito EXCLUSIVE-LOCK.
           
         Articulo-deposito.reservado_cantidad = Articulo-deposito.reservado_cantidad - 
                                                 Rqs_detalle.cantidad.

         Articulo-deposito.reservado_granel   = Articulo-deposito.reservado_granel -
                                                 Rqs_detalle.granel.
         RELEASE Articulo-deposito.

         RUN get-link-handle IN adm-broker-hdl
             (THIS-PROCEDURE, 'Renovar-target':U, OUTPUT c).
              
         IF NUM-ENTRIES (c) eq 1 
         THEN DO:
              h = WIDGET-HANDLE (c).
              RUN dispatch IN h ('open-query').
         END.   

    END.

   {tgbtcamb.i "CMBERQAL"}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON LEAVE OF des_fecha IN FRAME F-Main /* Del */
DO:
  ASSIGN des_fecha has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF des_fecha IN FRAME F-Main /* Del */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON RETURN OF des_fecha IN FRAME F-Main /* Del */
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


&Scoped-define SELF-NAME has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON LEAVE OF has_fecha IN FRAME F-Main /* Al */
DO:
  ASSIGN des_fecha has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF has_fecha IN FRAME F-Main /* Al */
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON RETURN OF has_fecha IN FRAME F-Main /* Al */
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


&Scoped-define SELF-NAME que_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_estado B-table-Win
ON VALUE-CHANGED OF que_estado IN FRAME F-Main
DO:
  ASSIGN FRAME {&FRAME-NAME} que_estado.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Deposito"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Deposito"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE estado_botones B-table-Win 
PROCEDURE estado_botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

     IF AVAILABLE Rqs_detalle 
        THEN ASSIGN btn_a-compras:SENSITIVE   = Rqs_detalle.cdg_estado = "AL"
                    btn_a-almacenes:SENSITIVE = Rqs_detalle.cdg_estado = "AL"
                    btn_rechazar:SENSITIVE    = Rqs_detalle.cdg_estado = "AL"
                    btn_revertir:SENSITIVE    = LOOKUP(Rqs_detalle.cdg_estado,"AC,RC,PA") <> 0.
        ELSE ASSIGN btn_a-compras:SENSITIVE   = NO
                    btn_a-almacenes:SENSITIVE = NO
                    btn_rechazar:SENSITIVE    = NO
                    btn_revertir:SENSITIVE    = NO.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}

   des_fecha = TODAY - 60.
   has_fecha = TODAY + 15.
   que_estado = "AL".

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DISPLAY des_fecha has_fecha que_estado
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   RUN estado_botones.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_comprador" "Rqs_header" "nro_comprador"}
  {src/adm/template/sndkycas.i "nro_deposito" "Rqs_header" "nro_deposito"}
  {src/adm/template/sndkycas.i "nro_entidad" "Rqs_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Rqs_header" "cdg_estado"}
  {src/adm/template/sndkycas.i "fecha" "Rqs_header" "fecha"}
  {src/adm/template/sndkycas.i "nro_moneda" "Rqs_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_ocompra" "Rqs_header" "nro_ocompra"}
  {src/adm/template/sndkycas.i "nro_requisicion" "Rqs_header" "nro_requisicion"}
  {src/adm/template/sndkycas.i "nro_area" "Rqs_header" "nro_area"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Rqs_header" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "nro_usuario" "Rqs_header" "nro_usuario"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Deposito"}
  {src/adm/template/snd-list.i "Rqs_header"}
  {src/adm/template/snd-list.i "Rqs_detalle"}
  {src/adm/template/snd-list.i "Articulo"}
  {src/adm/template/snd-list.i "Unidad"}
  {src/adm/template/snd-list.i "Area"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

