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

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

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
&Scoped-define EXTERNAL-TABLES Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Articulo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Articulo.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Articulo_precio Lista_Precios

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Lista_Precios.cdg_lista ~
Lista_Precios.descripcion Articulo_precio.fch_desde ~
Articulo_precio.desde_cantidad Articulo_precio.hasta_cantidad ~
Articulo_precio.precio_cf Articulo_precio.precio 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table ~
Articulo_precio.hasta_cantidad 
&Scoped-define ENABLED-TABLES-IN-QUERY-br_table Articulo_precio
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br_table Articulo_precio
&Scoped-define QUERY-STRING-br_table FOR EACH Articulo_precio OF Articulo WHERE ~{&KEY-PHRASE} ~
      AND Articulo_precio.cdg_empresa = que_empresa NO-LOCK, ~
      EACH Lista_Precios OF Articulo_precio NO-LOCK ~
    BY Articulo_precio.cdg_lista
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Articulo_precio OF Articulo WHERE ~{&KEY-PHRASE} ~
      AND Articulo_precio.cdg_empresa = que_empresa NO-LOCK, ~
      EACH Lista_Precios OF Articulo_precio NO-LOCK ~
    BY Articulo_precio.cdg_lista.
&Scoped-define TABLES-IN-QUERY-br_table Articulo_precio Lista_Precios
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Articulo_precio
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Lista_Precios


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table btn_todos 

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
nro_articulo||y|sic.Articulo_precio.nro_articulo
cdg_empresa||y|sic.Articulo_precio.cdg_empresa
cdg_lista||y|sic.Articulo_precio.cdg_lista
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_articulo,cdg_empresa,cdg_lista"':U).

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
DEFINE BUTTON btn_todos 
     LABEL "&Agregar el Artículo a todas las listas de precio existentes" 
     SIZE 103 BY 1.14.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Articulo_precio, 
      Lista_Precios SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Lista_Precios.cdg_lista COLUMN-LABEL "Nro.!Lista" FORMAT ">>9":U
      Lista_Precios.descripcion COLUMN-LABEL "Descripcion!Lista" FORMAT "X(31)":U
            WIDTH 27.8
      Articulo_precio.fch_desde FORMAT "99/99/9999":U
      Articulo_precio.desde_cantidad COLUMN-LABEL "Desde!Cant." FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8
      Articulo_precio.hasta_cantidad COLUMN-LABEL "Hasta!Cant." FORMAT "->>>,>>>,>>9.99":U
            WIDTH 8.2
      Articulo_precio.precio_cf COLUMN-LABEL "Precio!Vta.C.F." FORMAT "->>,>>9.9999":U
      Articulo_precio.precio FORMAT "->>,>>9.9999":U
  ENABLE
      Articulo_precio.hasta_cantidad
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 103 BY 9.43
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Precios de Venta del articulo actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
     btn_todos AT ROW 10.67 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Articulo
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
         HEIGHT             = 17.29
         WIDTH              = 109.
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
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Articulo_precio OF sic.Articulo,sic.Lista_Precios OF sic.Articulo_precio"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ","
     _OrdList          = "sic.Articulo_precio.cdg_lista|yes"
     _Where[1]         = "Articulo_precio.cdg_empresa = que_empresa"
     _FldNameList[1]   > sic.Lista_Precios.cdg_lista
"Lista_Precios.cdg_lista" "Nro.!Lista" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.Lista_Precios.descripcion
"Lista_Precios.descripcion" "Descripcion!Lista" "X(31)" "character" ? ? ? ? ? ? no ? no no "27.8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = sic.Articulo_precio.fch_desde
     _FldNameList[4]   > sic.Articulo_precio.desde_cantidad
"Articulo_precio.desde_cantidad" "Desde!Cant." ? "decimal" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sic.Articulo_precio.hasta_cantidad
"Articulo_precio.hasta_cantidad" "Hasta!Cant." ? "decimal" ? ? ? ? ? ? yes ? no no "8.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sic.Articulo_precio.precio_cf
"Articulo_precio.precio_cf" "Precio!Vta.C.F." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = sic.Articulo_precio.precio
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Precios de Venta del articulo actual */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Precios de Venta del articulo actual */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Precios de Venta del articulo actual */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todos B-table-Win
ON CHOOSE OF btn_todos IN FRAME F-Main /* Agregar el Artículo a todas las listas de precio existentes */
DO:
  DEFINE VARIABLE sino AS LOGICAL.
  sino = NO.
  MESSAGE "Este procedimiento aregará el artículo a todas las listas de precio en" 
          "las que no esté actualmente incluído. Indique si desea proceder"
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" SET sino .
  IF sino
  THEN DO:
       FOR EACH Lista_precio WHERE CAN-DO(Lista_precio.lista_empresas,que_empresa):
           FIND LAST Vigencia_precios OF Lista_precios NO-ERROR.
           IF AVAILABLE Vigencia_precios
           THEN DO:
               FIND LAST Articulo_precio OF Articulo 
                    WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                      AND Articulo_precio.cdg_lista = Lista_precio.cdg_lista
                      AND Articulo_precio.fch_desde = Vigencia_precios.fch_desde
                          NO-ERROR.
                          
               IF NOT AVAILABLE Articulo_precio
               THEN DO:
                    CREATE Articulo_precio.
                    ASSIGN Articulo_precio.cdg_empresa  = Empresa.cdg_empresa
                           Articulo_precio.cdg_lista    = Lista_precio.cdg_lista
                           Articulo_precio.fch_desde    = Vigencia_precios.fch_desde
                           Articulo_precio.nro_articulo = Articulo.nro_articulo.
    
               END.           
           END.
       END.
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/sndkycas.i "nro_articulo" "Articulo_precio" "nro_articulo"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Articulo_precio" "cdg_empresa"}
  {src/adm/template/sndkycas.i "cdg_lista" "Articulo_precio" "cdg_lista"}

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
  {src/adm/template/snd-list.i "Articulo"}
  {src/adm/template/snd-list.i "Articulo_precio"}
  {src/adm/template/snd-list.i "Lista_Precios"}

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

