&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

DEFINE BUFFER B-Rqs_detalle FOR Rqs_detalle.
DEFINE BUFFER B-Rqs_header  FOR Rqs_header.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Concurso_precios
&Scoped-define FIRST-EXTERNAL-TABLE Concurso_precios


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Concurso_precios.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rqs_detalle Articulo Rqs_header ~
Tipo_articulo Area

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Articulo.cdg_articulo ~
Articulo.descripcion Rqs_detalle.cantidad Area.cdg_area ~
Rqs_detalle.fecha_temprana Rqs_header.nro_comprob Rqs_detalle.nro_linea 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rqs_detalle WHERE TRUE /* Join to Concurso_precios incomplete */ ~
      AND Rqs_detalle.cdg_estado = "AC" NO-LOCK, ~
      EACH Articulo OF Rqs_detalle NO-LOCK, ~
      EACH Rqs_header OF Rqs_detalle NO-LOCK, ~
      EACH Tipo_articulo OF Articulo ~
      WHERE Tipo_articulo.nro_comprador = Concurso_precios.nro_comprador NO-LOCK, ~
      EACH Area OF Rqs_header NO-LOCK ~
    BY Articulo.cdg_articulo.
&Scoped-define TABLES-IN-QUERY-br_table Rqs_detalle Articulo Rqs_header ~
Tipo_articulo Area
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rqs_detalle


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table RECT-4 RECT-3 btn_incluir ~
v-observacion btn_apropiar 
&Scoped-Define DISPLAYED-OBJECTS v-observacion 

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
nro_articulo||y|sic.Rqs_detalle.nro_articulo
cdg_estado||y|sic.Rqs_detalle.cdg_estado
nro_proveedor||y|sic.Rqs_detalle.nro_proveedor
nro_requisicion||y|sic.Rqs_detalle.nro_requisicion
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_articulo,cdg_estado,nro_proveedor,nro_requisicion"':U).

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
DEFINE BUTTON btn_apropiar 
     LABEL "&Apropiar Requisición" 
     SIZE 35 BY 1.12
     FONT 6.

DEFINE BUTTON btn_incluir 
     LABEL "&Incluir en el Concurso" 
     SIZE 36 BY 1.12
     FONT 6.

DEFINE VARIABLE v-observacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 39 BY .77
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 39 BY 1.77.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 39 BY 1.77.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rqs_detalle, 
      Articulo, 
      Rqs_header, 
      Tipo_articulo, 
      Area SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Articulo.cdg_articulo
      Articulo.descripcion COLUMN-LABEL "Descripción! del Artículo" FORMAT "X(35)"
      Rqs_detalle.cantidad COLUMN-LABEL "Cantidad!Aceptada"
      Area.cdg_area
      Rqs_detalle.fecha_temprana COLUMN-LABEL "Fecha de!Necesidad"
      Rqs_header.nro_comprob COLUMN-LABEL "Número!de Pedido"
      Rqs_detalle.nro_linea COLUMN-LABEL "Número!Línea"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 61 BY 5.77
         BGCOLOR 15 FGCOLOR 12 FONT 4
         TITLE BGCOLOR 15 FGCOLOR 12 "Requisiciones Pendientes por Comprador".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
     btn_incluir AT ROW 1.27 COL 68
     v-observacion AT ROW 3.77 COL 65 COLON-ALIGNED NO-LABEL
     btn_apropiar AT ROW 5.27 COL 68
     "-< Observaciones >-" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 2.88 COL 77
          FONT 4
     RECT-4 AT ROW 4.77 COL 67
     RECT-3 AT ROW 1 COL 67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Concurso_precios
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 5.77
         WIDTH              = 109.43.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:NUM-LOCKED-COLUMNS IN FRAME F-Main = 1.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rqs_detalle Where sic.Concurso_precios ...,sic.Articulo OF sic.Rqs_detalle,sic.Rqs_header OF sic.Rqs_detalle,sic.Tipo_articulo OF sic.Articulo,sic.Area OF sic.Rqs_header"
     _Options          = "NO-LOCK"
     _TblOptList       = ",,,,"
     _OrdList          = "sic.Articulo.cdg_articulo|yes"
     _Where[1]         = "Rqs_detalle.cdg_estado = ""AC"""
     _Where[4]         = "Tipo_articulo.nro_comprador = Concurso_precios.nro_comprador"
     _FldNameList[1]   = sic.Articulo.cdg_articulo
     _FldNameList[2]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripción! del Artículo" "X(35)" "character" ? ? ? ? ? ? no ?
     _FldNameList[3]   > sic.Rqs_detalle.cantidad
"Rqs_detalle.cantidad" "Cantidad!Aceptada" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[4]   = sic.Area.cdg_area
     _FldNameList[5]   > sic.Rqs_detalle.fecha_temprana
"Rqs_detalle.fecha_temprana" "Fecha de!Necesidad" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[6]   > sic.Rqs_header.nro_comprob
"Rqs_header.nro_comprob" "Número!de Pedido" ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[7]   > sic.Rqs_detalle.nro_linea
"Rqs_detalle.nro_linea" "Número!Línea" ? "integer" ? ? ? ? ? ? no ?
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Requisiciones Pendientes por Comprador */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Requisiciones Pendientes por Comprador */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Requisiciones Pendientes por Comprador */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_apropiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_apropiar B-table-Win
ON CHOOSE OF btn_apropiar IN FRAME F-Main /* Apropiar Requisición */
DO:

  DEFINE VARIABLE act_requisicion AS ROWID.

  RUN D-APREQUIS.W ( INPUT Concurso_precios.nro_comprador, OUTPUT act_requisicion ).
  IF act_requisicion <> ?
  THEN DO:

       FIND B-Rqs_detalle WHERE ROWID(B-Rqs_detalle) = act_requisicion NO-LOCK.
       FIND B-Rqs_header OF B-Rqs_detalle NO-LOCK.
       DO TRANSACTION:

          FIND FIRST Concurso_item OF Concurso_precios
               WHERE Concurso_item.nro_articulo = B-Rqs_detalle.nro_articulo EXCLUSIVE-LOCK NO-ERROR.
  
          IF NOT AVAILABLE Concurso_item 
          THEN DO:
               CREATE Concurso_item.
               ASSIGN Concurso_item.nro_articulo  = B-Rqs_detalle.nro_articulo
                      Concurso_item.nro_concurso  = Concurso_precio.nro_concurso.
          END.
     
          Concurso_item.cantidad = Concurso_item.cantidad +  B-Rqs_detalle.cantidad.
          CREATE Concurso-requisicion.   
          ASSIGN Concurso-requisicion.cantidad        = B-Rqs_detalle.cantidad
                 Concurso-requisicion.nro_articulo    = B-Rqs_detalle.nro_articulo
                 Concurso-requisicion.nro_concurso    = Concurso_precio.nro_concurso
                 Concurso-requisicion.nro_linea       = B-Rqs_detalle.nro_linea
                 Concurso-requisicion.nro_requisicion = B-Rqs_detalle.nro_requisicion.
            
          {tgbtcamb.i "CMBERQPC" "B-"}
  
          RELEASE Concurso_item.
          RELEASE Concurso-requisicion.
     
       END.
  
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
       IF tiene_permiso
       THEN DO:
            /*------------------------------------------------------------------------
                Indicamos al browse que debe reflejar el cambio de estado
            ------------------------------------------------------------------------*/
  
            RUN get-link-handle IN adm-broker-hdl
                (THIS-PROCEDURE, 'Refrescar-Target':U, OUTPUT c).
            IF NUM-ENTRIES (c) eq 1 THEN DO:
               h = WIDGET-HANDLE (c).
               RUN refrescar_browse IN h.
            END.

       END.             
  END.    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_incluir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_incluir B-table-Win
ON CHOOSE OF btn_incluir IN FRAME F-Main /* Incluir en el Concurso */
DO:
  
  IF NOT AVAILABLE Rqs_detalle
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE007" ).
       RETURN NO-APPLY.
  END.
  ELSE DO TRANSACTION:

     FIND FIRST Concurso_item OF Concurso_precio 
          WHERE Concurso_item.nro_articulo = Rqs_detalle.nro_articulo EXCLUSIVE-LOCK NO-ERROR.
  
     IF NOT AVAILABLE Concurso_item 
     THEN DO:
          CREATE Concurso_item.
          ASSIGN Concurso_item.nro_articulo  = Articulo.nro_articulo
                 Concurso_item.nro_concurso  = Concurso_precio.nro_concurso.
     END.
     
     Concurso_item.cantidad = Concurso_item.cantidad +  Rqs_detalle.cantidad.
     CREATE Concurso-requisicion.   
     ASSIGN Concurso-requisicion.cantidad        = Rqs_detalle.cantidad
            Concurso-requisicion.nro_articulo    = Rqs_detalle.nro_articulo
            Concurso-requisicion.nro_concurso    = Concurso_precio.nro_concurso
            Concurso-requisicion.nro_linea       = Rqs_detalle.nro_linea
            Concurso-requisicion.nro_requisicion = Rqs_detalle.nro_requisicion.

     ASSIGN FRAME {&FRAME-NAME} v-observacion.
     RUN CMBERQPC.P ( INPUT ROWID(Rqs_header), 
                      INPUT ROWID(Rqs_detalle), 
                      INPUT v-observacion, 
                      OUTPUT tiene_permiso ).
     IF tiene_permiso
     THEN DO:
          FIND CURRENT Rqs_detalle NO-LOCK.
          RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields').
          v-observacion = "".
          DISPLAY v-observacion
                  WITH FRAME {&FRAME-NAME}.

       /*------------------------------------------------------------------------
           Indicamos al browse que debe reflejar el cambio de estado
       ------------------------------------------------------------------------*/
  
     END.             
  
     RELEASE Concurso_item.
     RELEASE Concurso-requisicion.
     
  END.

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

  IF tiene_permiso
  THEN DO:
       /*------------------------------------------------------------------------
           Indicamos al browse que debe reflejar el cambio de estado
       ------------------------------------------------------------------------*/
  
       RUN get-link-handle IN adm-broker-hdl
           (THIS-PROCEDURE, 'Refrescar-Target':U, OUTPUT c).
       IF NUM-ENTRIES (c) eq 1 THEN DO:
          h = WIDGET-HANDLE (c).
          RUN refrescar_browse IN h.
       END.

  END.             

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win adm/support/_adm-opn.p
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Concurso_precios"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Concurso_precios"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_articulo" "Rqs_detalle" "nro_articulo"}
  {src/adm/template/sndkycas.i "cdg_estado" "Rqs_detalle" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Rqs_detalle" "nro_proveedor"}
  {src/adm/template/sndkycas.i "nro_requisicion" "Rqs_detalle" "nro_requisicion"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Concurso_precios"}
  {src/adm/template/snd-list.i "Rqs_detalle"}
  {src/adm/template/snd-list.i "Articulo"}
  {src/adm/template/snd-list.i "Rqs_header"}
  {src/adm/template/snd-list.i "Tipo_articulo"}
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


