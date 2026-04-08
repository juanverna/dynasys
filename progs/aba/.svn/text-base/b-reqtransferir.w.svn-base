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

DEFINE VARIABLE fgcolor_inc AS INTEGER INITIAL 14.
DEFINE VARIABLE bgcolor_inc AS INTEGER INITIAL 2.

DEFINE VARIABLE fgcolor_pen AS INTEGER INITIAL 9.
DEFINE VARIABLE bgcolor_pen AS INTEGER INITIAL 11.

DEFINE VARIABLE rid-detalle AS ROWID.

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
Articulo.cdg_articulo Articulo.descripcion Rqs_detalle.cantidad ~
Rqs_detalle.cantidad_cum Unidad.abrevia Area.cdg_area Area.denominacion ~
Rqs_header.nro_comprob Rqs_detalle.nro_linea Rqs_header.fecha ~
Rqs_detalle.cdg_estado 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rqs_header OF Deposito WHERE ~{&KEY-PHRASE} ~
      AND Rqs_header.cdg_estado <> "ZZ" ~
 AND Rqs_header.es_reposicion ~
 AND Rqs_header.tip_comprob = "PI" NO-LOCK, ~
      EACH Rqs_detalle OF Rqs_header ~
      WHERE (Rqs_detalle.cdg_estado = "AC" ~
  OR Rqs_detalle.cdg_estado = "AL" ~
  OR Rqs_detalle.cdg_estado = "RC" ~
  OR Rqs_detalle.cdg_estado = "PA") NO-LOCK, ~
      EACH Articulo OF Rqs_detalle NO-LOCK, ~
      EACH Unidad OF Articulo NO-LOCK, ~
      EACH Area OF Rqs_header NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Rqs_header Rqs_detalle Articulo ~
Unidad Area
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rqs_header


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table btn_renovar 

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
DEFINE BUTTON btn_renovar 
     LABEL "Renovar Datos" 
     SIZE 84 BY 1
     FONT 4.

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
      Rqs_detalle.fecha_temprana COLUMN-LABEL "Entregar!antes del"
      Articulo.cdg_articulo
      Articulo.descripcion COLUMN-LABEL "Descripción!del artículo"
      Rqs_detalle.cantidad COLUMN-LABEL "Total!Pedido"
      Rqs_detalle.cantidad_cum COLUMN-LABEL "Total!Cumplido"
      Unidad.abrevia COLUMN-LABEL "Unidad!Medida"
      Area.cdg_area
      Area.denominacion COLUMN-LABEL "Denominación!Area"
      Rqs_header.nro_comprob COLUMN-LABEL "Número!Solicitud"
      Rqs_detalle.nro_linea COLUMN-LABEL "Nro.!Línea"
      Rqs_header.fecha COLUMN-LABEL "Fecha!Solic."
      Rqs_detalle.cdg_estado COLUMN-LABEL "Es-!tado"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 84 BY 5.75
         BGCOLOR 11 FGCOLOR 9 FONT 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
     btn_renovar AT ROW 6.75 COL 1
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
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 6.75
         WIDTH              = 84.33.
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
     _TblList          = "sic.Rqs_header OF sic.Deposito,sic.Rqs_detalle OF sic.Rqs_header,sic.Articulo OF sic.Rqs_detalle,sic.Unidad OF sic.Articulo,sic.Area OF sic.Rqs_header"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,,,"
     _Where[1]         = "Rqs_header.cdg_estado <> ""ZZ""
 AND sic.Rqs_header.es_reposicion
 AND Rqs_header.tip_comprob = ""PI"""
     _Where[2]         = "(Rqs_detalle.cdg_estado = ""AC""
  OR Rqs_detalle.cdg_estado = ""AL""
  OR Rqs_detalle.cdg_estado = ""RC""
  OR Rqs_detalle.cdg_estado = ""PA"")"
     _FldNameList[1]   > sic.Rqs_detalle.fecha_temprana
"Rqs_detalle.fecha_temprana" "Entregar!antes del" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[2]   = sic.Articulo.cdg_articulo
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripción!del artículo" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[4]   > sic.Rqs_detalle.cantidad
"Rqs_detalle.cantidad" "Total!Pedido" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[5]   > sic.Rqs_detalle.cantidad_cum
"Rqs_detalle.cantidad_cum" "Total!Cumplido" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[6]   > sic.Unidad.abrevia
"Unidad.abrevia" "Unidad!Medida" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[7]   = sic.Area.cdg_area
     _FldNameList[8]   > sic.Area.denominacion
"Area.denominacion" "Denominación!Area" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[9]   > sic.Rqs_header.nro_comprob
"Rqs_header.nro_comprob" "Número!Solicitud" ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[10]   > sic.Rqs_detalle.nro_linea
"Rqs_detalle.nro_linea" "Nro.!Línea" ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[11]   > sic.Rqs_header.fecha
"Rqs_header.fecha" "Fecha!Solic." ? "date" ? ? ? ? ? ? no ?
     _FldNameList[12]   > sic.Rqs_detalle.cdg_estado
"Rqs_detalle.cdg_estado" "Es-!tado" ? "character" ? ? ? ? ? ? no ?
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
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
  IF Rqs_Detalle.selectado 
     THEN DO:
       RUN poner_incluido IN THIS-PROCEDURE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
     objects when the browser's current row changes.     */
     {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_renovar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_renovar B-table-Win
ON CHOOSE OF btn_renovar IN FRAME F-Main /* Renovar Datos */
DO:     
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_excluido B-table-Win 
PROCEDURE poner_excluido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters: <none>
  Notes:       
------------------------------------------------------------------------------*/

  Rqs_detalle.fecha_temprana:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Rqs_detalle.cantidad:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Rqs_detalle.cantidad_cum:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Unidad.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Area.cdg_area:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Area.denominacion:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Rqs_header.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Rqs_detalle.nro_linea:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Rqs_header.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.
  Rqs_detalle.cdg_estado:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen.

  Rqs_detalle.fecha_temprana:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Rqs_detalle.cantidad:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Rqs_detalle.cantidad_cum:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Unidad.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Area.cdg_area:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Area.denominacion:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Rqs_header.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Rqs_detalle.nro_linea:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Rqs_header.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.
  Rqs_detalle.cdg_estado:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_incluido B-table-Win 
PROCEDURE poner_incluido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  Rqs_detalle.fecha_temprana:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Rqs_detalle.cantidad:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Rqs_detalle.cantidad_cum:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Unidad.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Area.cdg_area:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Area.denominacion:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Rqs_header.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Rqs_detalle.nro_linea:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Rqs_header.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.
  Rqs_detalle.cdg_estado:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc.

  Rqs_detalle.fecha_temprana:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Rqs_detalle.cantidad:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Rqs_detalle.cantidad_cum:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Unidad.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Area.cdg_area:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Area.denominacion:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Rqs_header.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Rqs_detalle.nro_linea:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Rqs_header.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.
  Rqs_detalle.cdg_estado:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc.

  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse B-table-Win 
PROCEDURE refrescar_browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND CURRENT Rqs_detalle NO-LOCK.
     DISPLAY Rqs_detalle.cdg_estado WITH BROWSE {&BROWSE-NAME}.

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
  {src/adm/template/sndkycas.i "nro_comprador" "Rqs_header" "nro_comprador"}
  {src/adm/template/sndkycas.i "cdg_deposito" "Rqs_header" "cdg_deposito"}
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
/*-------------------------------------------------------------
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


