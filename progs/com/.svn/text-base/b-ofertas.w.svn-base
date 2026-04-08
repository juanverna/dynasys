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
&Scoped-define EXTERNAL-TABLES Concurso_item
&Scoped-define FIRST-EXTERNAL-TABLE Concurso_item


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Concurso_item.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Concurso_cotiza Proveedor

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Concurso_cotiza.st_item ~
Proveedor.nombre 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Concurso_cotiza WHERE TRUE /* Join to Concurso_item incomplete */ ~
      AND Concurso_cotiza.nro_concurso = Concurso_item.nro_concurso ~
 AND Concurso_cotiza.nro_articulo = Concurso_item.nro_articulo NO-LOCK, ~
      EACH Proveedor OF Concurso_cotiza NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Concurso_cotiza Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Concurso_cotiza


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table RECT-3 btn_crear btn_rechazar ~
btn_adjudicar btn_desinvitar btn_desrechazar btn_desadjudicar 

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
nro_articulo||y|sic.Concurso_cotiza.nro_articulo
nro_concurso||y|sic.Concurso_cotiza.nro_concurso
nro_proveedor||y|sic.Concurso_cotiza.nro_proveedor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_articulo,nro_concurso,nro_proveedor"':U).

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
DEFINE BUTTON btn_adjudicar 
     LABEL "Ad&judicar" 
     SIZE 16 BY .81
     FONT 4.

DEFINE BUTTON btn_crear 
     LABEL "&Nueva" 
     SIZE 16 BY .81
     FONT 4.

DEFINE BUTTON btn_desadjudicar 
     LABEL "De&sadjudicar" 
     SIZE 16 BY .81
     FONT 4.

DEFINE BUTTON btn_desinvitar 
     LABEL "&Retirar" 
     SIZE 16 BY .81
     FONT 4.

DEFINE BUTTON btn_desrechazar 
     LABEL "Desrecha&zar" 
     SIZE 16 BY .81
     FONT 4.

DEFINE BUTTON btn_rechazar 
     LABEL "Rec&hazar" 
     SIZE 16 BY .81
     FONT 4.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 52 BY 2.15.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Concurso_cotiza, 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Concurso_cotiza.st_item COLUMN-LABEL "Estado!Adjudic."
      Proveedor.nombre COLUMN-LABEL "Razón!Social"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 52 BY 5.65
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Proveedores Invitados".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
     btn_crear AT ROW 7.19 COL 3
     btn_rechazar AT ROW 7.19 COL 19
     btn_adjudicar AT ROW 7.19 COL 35
     btn_desinvitar AT ROW 8 COL 3
     btn_desrechazar AT ROW 8 COL 19
     btn_desadjudicar AT ROW 8 COL 35
     RECT-3 AT ROW 6.92 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Concurso_item
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
         HEIGHT             = 9.73
         WIDTH              = 55.72.
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

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Concurso_cotiza WHERE sic.Concurso_item <external> ...,sic.Proveedor OF sic.Concurso_cotiza"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Concurso_cotiza.nro_concurso = Concurso_item.nro_concurso
 AND Concurso_cotiza.nro_articulo = Concurso_item.nro_articulo"
     _FldNameList[1]   > sic.Concurso_cotiza.st_item
"Concurso_cotiza.st_item" "Estado!Adjudic." ? "character" ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Proveedor.nombre
"Proveedor.nombre" "Razón!Social" ? "character" ? ? ? ? ? ? no ?
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Proveedores Invitados */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Proveedores Invitados */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Proveedores Invitados */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_adjudicar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_adjudicar B-table-Win
ON CHOOSE OF btn_adjudicar IN FRAME F-Main /* Adjudicar */
DO:
  
  IF NOT AVAILABLE Concurso_cotiza
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE005" ).
       RETURN NO-APPLY.
  END.
  
  IF Concurso_item.cantidad <= Concurso_item.cantidad_adj 
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE006" ).
       RETURN NO-APPLY.
  END.

  IF LENGTH(Concurso_cotiza.adjudicacion) <= 6 
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE008" ).
       RETURN NO-APPLY.
  END.

  IF Concurso_cotiza.st_item <> ""
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE013" ).
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:
  
     FIND CURRENT Concurso_item EXCLUSIVE-LOCK.
     Concurso_item.st_item = "A".
     Concurso_item.cantidad_adj = Concurso_item.cantidad_adj + Concurso_cotiza.cantidad.
     FIND CURRENT Concurso_item NO-LOCK.

     FIND CURRENT Concurso_cotiza EXCLUSIVE-LOCK.
     Concurso_cotiza.st_item = "A".
     FIND CURRENT Concurso_cotiza NO-LOCK.

  END.
  
/*------------------------------------------------------------------------
  Actualizamos el registro en el browse de items de concurso.
  ------------------------------------------------------------------------*/

  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.
  
  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/

  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Adjudicacion-SOURCE':U, OUTPUT c).
       
  IF NUM-ENTRIES (c) eq 1 THEN DO:
    h = WIDGET-HANDLE (c).
    RUN re-display IN h. /* Refresca el estado del item */
  END.
  
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  RUN new-state ( 'refrescar_browse' ).   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_crear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_crear B-table-Win
ON CHOOSE OF btn_crear IN FRAME F-Main /* Nueva */
DO:

   DEFINE VARIABLE rid_proveedor AS ROWID.
   DEFINE BUFFER B-Proveedor FOR Proveedor.

   RUN SELPROVE.P ( INPUT-OUTPUT rid_proveedor, INPUT  YES).
   IF rid_proveedor <> ?
   THEN DO:
        FIND B-Proveedor WHERE ROWID(B-Proveedor) = rid_proveedor NO-LOCK.
        DO TRANSACTION:
           CREATE Concurso_cotiza.
           ASSIGN Concurso_cotiza.cantidad      = Concurso_item.cantidad
                  Concurso_cotiza.nro_articulo  = Concurso_item.nro_articulo
                  Concurso_cotiza.nro_concurso  = Concurso_item.nro_concurso
                  Concurso_cotiza.nro_proveedor = B-Proveedor.nro_proveedor.
        END.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.                
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_desadjudicar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_desadjudicar B-table-Win
ON CHOOSE OF btn_desadjudicar IN FRAME F-Main /* Desadjudicar */
DO:
  
  IF NOT AVAILABLE Concurso_cotiza
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE005" ).
       RETURN NO-APPLY.
  END.
  
  IF Concurso_cotiza.st_item <> "A"
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE012" ).
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:
  
     FIND CURRENT Concurso_item EXCLUSIVE-LOCK.
     Concurso_item.cantidad_adj = Concurso_item.cantidad_adj - Concurso_cotiza.cantidad.
     FIND CURRENT Concurso_item NO-LOCK.

     FIND CURRENT Concurso_cotiza EXCLUSIVE-LOCK.
     Concurso_cotiza.st_item = "".
     FIND CURRENT Concurso_cotiza NO-LOCK.

  END.
  
/*------------------------------------------------------------------------
  Actualizamos el registro en el browse de items de concurso.
  ------------------------------------------------------------------------*/

  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.
  
  /* Ask the Record-Source for the current customer record.  Make sure
     there is only one.*/

  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Adjudicacion-SOURCE':U, OUTPUT c).

  IF NUM-ENTRIES (c) eq 1 THEN DO:
    h = WIDGET-HANDLE (c).
    RUN re-display IN h. /* Refresca el estado del item */
  END.
  
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  RUN new-state ( 'refrescar_browse' ).   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_desinvitar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_desinvitar B-table-Win
ON CHOOSE OF btn_desinvitar IN FRAME F-Main /* Retirar */
DO:
  
  IF NOT AVAILABLE Concurso_cotiza
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE004" ).
       RETURN NO-APPLY.
  END.
  
  IF Concurso_cotiza.st_item <> ""
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE010" ).
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:

     FIND CURRENT Concurso_cotiza EXCLUSIVE-LOCK.   
     DELETE Concurso_cotiza.

  END.
  
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_desrechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_desrechazar B-table-Win
ON CHOOSE OF btn_desrechazar IN FRAME F-Main /* Desrechazar */
DO:
  
  IF NOT AVAILABLE Concurso_cotiza
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE004" ).
       RETURN NO-APPLY.
  END.
  
  IF Concurso_cotiza.st_item <> "R"
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE011" ).
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:
  
     FIND CURRENT Concurso_cotiza EXCLUSIVE-LOCK.
     Concurso_cotiza.st_item = "".
     FIND CURRENT Concurso_cotiza NO-LOCK.

  END.
  
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar B-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar */
DO:
  
  IF NOT AVAILABLE Concurso_cotiza
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE004" ).
       RETURN NO-APPLY.
  END.
  
  IF Concurso_cotiza.st_item <> ""
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CPRE010" ).
       RETURN NO-APPLY.
  END.

  DO TRANSACTION:
  
     FIND CURRENT Concurso_cotiza EXCLUSIVE-LOCK.
     Concurso_cotiza.st_item = "R".
     FIND CURRENT Concurso_cotiza NO-LOCK.

  END.
  
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
  {src/adm/template/row-list.i "Concurso_item"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Concurso_item"}

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar-browse B-table-Win 
PROCEDURE refrescar-browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN dispatch IN THIS-PROCEDURE ('open-query').
  
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
  {src/adm/template/sndkycas.i "nro_articulo" "Concurso_cotiza" "nro_articulo"}
  {src/adm/template/sndkycas.i "nro_concurso" "Concurso_cotiza" "nro_concurso"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Concurso_cotiza" "nro_proveedor"}

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
  {src/adm/template/snd-list.i "Concurso_item"}
  {src/adm/template/snd-list.i "Concurso_cotiza"}
  {src/adm/template/snd-list.i "Proveedor"}

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


