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
&Scoped-define INTERNAL-TABLES Concurso_item Articulo Unidad

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Articulo.cdg_articulo ~
Articulo.descripcion Concurso_item.cantidad Concurso_item.cantidad_adj ~
Unidad.abrevia Concurso_item.st_item 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Concurso_item OF Concurso_precios WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Articulo OF Concurso_item NO-LOCK, ~
      EACH Unidad OF Articulo NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Concurso_item Articulo Unidad
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Concurso_item


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table 

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
nro_articulo||y|sic.Concurso_item.nro_articulo
nro_concurso||y|sic.Concurso_item.nro_concurso
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_articulo,nro_concurso"':U).

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
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Concurso_item, 
      Articulo, 
      Unidad SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Articulo.cdg_articulo
      Articulo.descripcion COLUMN-LABEL "Descripción!Artículo" FORMAT "X(30)"
      Concurso_item.cantidad COLUMN-LABEL "Cantidad!A Comprar"
      Concurso_item.cantidad_adj COLUMN-LABEL "Cantidad!Adjudicada" FORMAT ">>>>>>9.99"
      Unidad.abrevia COLUMN-LABEL "Unidad!Medida"
      Concurso_item.st_item COLUMN-LABEL "Es-!tado"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 61 BY 8.35
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Items del presente concurso".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


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
         HEIGHT             = 10.19
         WIDTH              = 72.29.
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
     _TblList          = "sic.Concurso_item OF sic.Concurso_precios,sic.Articulo OF sic.Concurso_item,sic.Unidad OF sic.Articulo"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,"
     _FldNameList[1]   = sic.Articulo.cdg_articulo
     _FldNameList[2]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripción!Artículo" "X(30)" "character" ? ? ? ? ? ? no ?
     _FldNameList[3]   > sic.Concurso_item.cantidad
"Concurso_item.cantidad" "Cantidad!A Comprar" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[4]   > sic.Concurso_item.cantidad_adj
"Concurso_item.cantidad_adj" "Cantidad!Adjudicada" ">>>>>>9.99" "decimal" ? ? ? ? ? ? no ?
     _FldNameList[5]   > sic.Unidad.abrevia
"Unidad.abrevia" "Unidad!Medida" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[6]   > sic.Concurso_item.st_item
"Concurso_item.st_item" "Es-!tado" ? "character" ? ? ? ? ? ? no ?
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
ON ROW-DISPLAY OF br_table IN FRAME F-Main /* Items del presente concurso */
DO:

  IF Concurso_item.st_item = ""
  THEN DO:
       RUN poner_color ( INPUT 9, INPUT 11).
  END.
  ELSE DO:
       RUN poner_color ( INPUT 14, INPUT 2).
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Items del presente concurso */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Items del presente concurso */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Items del presente concurso */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color B-table-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER fg-color AS INTEGER.
  DEFINE INPUT PARAMETER bg-color AS INTEGER.

  ASSIGN
      Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME}     = fg-color
      Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME}      = fg-color
      Concurso_item.cantidad:FGCOLOR IN BROWSE {&BROWSE-NAME}    = fg-color
      Concurso_item.cantidad_adj:FGCOLOR IN BROWSE {&BROWSE-NAME}= fg-color
      Unidad.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME}            = fg-color
      Concurso_item.st_item:FGCOLOR IN BROWSE {&BROWSE-NAME}     = fg-color.

  ASSIGN
      Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME}     = bg-color
      Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME}      = bg-color
      Concurso_item.cantidad:BGCOLOR IN BROWSE {&BROWSE-NAME}    = bg-color
      Concurso_item.cantidad_adj:BGCOLOR IN BROWSE {&BROWSE-NAME}= bg-color
      Unidad.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME}            = bg-color
      Concurso_item.st_item:BGCOLOR IN BROWSE {&BROWSE-NAME}     = bg-color.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE re-display B-table-Win 
PROCEDURE re-display :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE BUFFER B-Concurso_item FOR Concurso_item.

 FIND B-Concurso_item WHERE ROWID(B-Concurso_item) = ROWID(Concurso_item) NO-LOCK.
 Concurso_item.st_item:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = B-Concurso_item.st_item.
 Concurso_item.cantidad:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = STRING(B-Concurso_item.cantidad).
 Concurso_item.cantidad_adj:SCREEN-VALUE IN BROWSE {&BROWSE-NAME} = STRING(B-Concurso_item.cantidad_adj).

 ASSIGN
       Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME}   = 14
       Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME}    = 14
       Concurso_item.cantidad:FGCOLOR IN BROWSE {&BROWSE-NAME}  = 14
       Unidad.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME}          = 14
       Concurso_item.st_item:FGCOLOR IN BROWSE {&BROWSE-NAME}   = 14

       Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME}   = 2
       Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME}    = 2
       Concurso_item.cantidad:BGCOLOR IN BROWSE {&BROWSE-NAME}  = 2
       Unidad.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME}          = 2
       Concurso_item.st_item:BGCOLOR IN BROWSE {&BROWSE-NAME}   = 2.

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

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).   
  RUN dispatch IN THIS-PROCEDURE ('row-available':U).
  
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
  {src/adm/template/sndkycas.i "nro_articulo" "Concurso_item" "nro_articulo"}
  {src/adm/template/sndkycas.i "nro_concurso" "Concurso_item" "nro_concurso"}

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
  {src/adm/template/snd-list.i "Concurso_item"}
  {src/adm/template/snd-list.i "Articulo"}
  {src/adm/template/snd-list.i "Unidad"}

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


