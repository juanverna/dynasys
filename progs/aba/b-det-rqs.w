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

DEFINE TEMP-TABLE T-RQS NO-UNDO

    FIELD T-Art-cdg         LIKE Articulo.cdg_articulo
    FIELD T-Det-nro-lin     LIKE Rqs_detalle.nro_linea
    FIELD T-Art-des         LIKE Articulo.Descripcion
    FIELD T-Det-Can-sol     LIKE Rqs_detalle.cantidad_sol
    FIELD T-Det-can         LIKE Rqs_detalle.cantidad
    FIELD T-un-med          LIKE Articulo.cdg_umed
    FIELD T-Val-art         LIKE Rqs_detalle.costo
    FIELD T-Fec-Req         LIKE Rqs_detalle.fecha_temprana
    FIELD T-Estado          LIKE Rqs_detalle.cdg_estado.


{VRSHARED.I}.

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
&Scoped-define EXTERNAL-TABLES Rqs_header
&Scoped-define FIRST-EXTERNAL-TABLE Rqs_header


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Rqs_header.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rqs_detalle Articulo

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Articulo.cdg_articulo ~
Rqs_detalle.nro_linea Articulo.descripcion Rqs_detalle.cantidad_sol ~
Rqs_detalle.cantidad Articulo.cdg_umed Rqs_detalle.costo ~
Rqs_detalle.fecha_temprana Rqs_detalle.cdg_estado 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rqs_detalle OF Rqs_header WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Articulo OF Rqs_detalle NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Rqs_detalle Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rqs_detalle


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg-articulo v-art-cant br_table ~
Btn_Cancel B-Grabar b-completar b-Agregar 
&Scoped-Define DISPLAYED-OBJECTS v-cdg-articulo V-Descripcion v-art-cant 

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
DEFINE BUTTON b-Agregar 
     LABEL "Agregar" 
     SIZE 13 BY 1.13
     FONT 4.

DEFINE BUTTON b-completar 
     LABEL "Completar" 
     SIZE 13 BY 1.13
     FONT 4.

DEFINE BUTTON B-Grabar 
     LABEL "Grabar" 
     SIZE 13 BY 1.13
     FONT 4.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY DEFAULT 
     LABEL "Cancelar" 
     SIZE 13 BY 1.13
     BGCOLOR 8 FONT 4.

DEFINE VARIABLE v-art-cant AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10.56 BY .75
     BGCOLOR 15 FONT 4 NO-UNDO.

DEFINE VARIABLE v-cdg-articulo AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13.22 BY .75
     BGCOLOR 15 FONT 4 NO-UNDO.

DEFINE VARIABLE V-Descripcion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .75
     BGCOLOR 7 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rqs_detalle, 
      Articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Articulo.cdg_articulo
      Rqs_detalle.nro_linea COLUMN-LABEL "Nro!Lin"
      Articulo.descripcion COLUMN-LABEL "Descripcion!Articulo" FORMAT "X(29)"
      Rqs_detalle.cantidad_sol COLUMN-LABEL "Cantidad!Solicitada"
      Rqs_detalle.cantidad COLUMN-LABEL "Cantidad!Aceptada"
      Articulo.cdg_umed COLUMN-LABEL "Un. !Med."
      Rqs_detalle.costo COLUMN-LABEL "Valuacion !Articulo"
      Rqs_detalle.fecha_temprana COLUMN-LABEL "Fecha !Requerida"
      Rqs_detalle.cdg_estado COLUMN-LABEL "Es-!tado"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 44 BY 7.75
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Articulos solicitados".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg-articulo AT ROW 1.5 COL 4.45 COLON-ALIGNED NO-LABEL AUTO-RETURN 
     V-Descripcion AT ROW 1.5 COL 19 COLON-ALIGNED NO-LABEL
     v-art-cant AT ROW 2.5 COL 7.11 COLON-ALIGNED NO-LABEL
     br_table AT ROW 3.5 COL 1
     Btn_Cancel AT ROW 12.25 COL 17
     B-Grabar AT ROW 12.25 COL 32
     b-completar AT ROW 12.25 COL 47
     b-Agregar AT ROW 12.28 COL 2
     "Solicitado" VIEW-AS TEXT
          SIZE 7 BY .63 AT ROW 2.63 COL 1
          FONT 4
     "Articulo" VIEW-AS TEXT
          SIZE 5.56 BY .63 AT ROW 1.63 COL 1
          FONT 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 
         CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Rqs_header
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
         HEIGHT             = 12.56
         WIDTH              = 64.45.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-art-cant F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN V-Descripcion IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rqs_detalle OF sic.Rqs_header,sic.Articulo OF sic.Rqs_detalle"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _FldNameList[1]   = sic.Articulo.cdg_articulo
     _FldNameList[2]   > sic.Rqs_detalle.nro_linea
"Rqs_detalle.nro_linea" "Nro!Lin" ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[3]   > sic.Articulo.descripcion
"Articulo.descripcion" "Descripcion!Articulo" "X(29)" "character" ? ? ? ? ? ? no ?
     _FldNameList[4]   > sic.Rqs_detalle.cantidad_sol
"Rqs_detalle.cantidad_sol" "Cantidad!Solicitada" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[5]   > sic.Rqs_detalle.cantidad
"Rqs_detalle.cantidad" "Cantidad!Aceptada" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[6]   > sic.Articulo.cdg_umed
"Articulo.cdg_umed" "Un. !Med." ? "character" ? ? ? ? ? ? no ?
     _FldNameList[7]   > sic.Rqs_detalle.costo
"Rqs_detalle.costo" "Valuacion !Articulo" ? "decimal" ? ? ? ? ? ? no ?
     _FldNameList[8]   > sic.Rqs_detalle.fecha_temprana
"Rqs_detalle.fecha_temprana" "Fecha !Requerida" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[9]   > sic.Rqs_detalle.cdg_estado
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

&Scoped-define SELF-NAME b-Agregar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-Agregar B-table-Win
ON CHOOSE OF b-Agregar IN FRAME F-Main /* Agregar */
DO:
 
   ASSIGN V-cdg-articulo = " "
          V-descripcion  = " "
          V-art-cant     = 0 .
          
   DISPLAY V-descripcion  WITH FRAME {&FRAME-NAME}.
   DISPLAY V-cdg-articulo WITH FRAME {&FRAME-NAME}.
   DISPLAY V-art-cant     WITH FRAME {&FRAME-NAME}.
   
    
       

  
  
  
  
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME B-Grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL B-Grabar B-table-Win
ON CHOOSE OF B-Grabar IN FRAME F-Main /* Grabar */
DO:
  CREATE T-RQS.
  ASSIGN  T-Art-cdg      = V-cdg-articulo
          T-Det-nro-lin  = 1
          T-Art-des      = V-Descripcion
          T-Det-Can-sol  = V-art-cant
          T-Det-can      = V-Art-cant
          T-un-med       = Articulo.cdg_umed
        /*T-Val-art      =  LIKE Rqs_detalle.costo*/
          T-Fec-Req      = Today .
        /*T-Estado       =  LIKE Rqs_detalle.cdg_estado.*/

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main /* Articulos solicitados */
DO:
  IF Rqs_detalle.nro_linea = 1 
    THEN DO:
       APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.
  END.     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Articulos solicitados */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Articulos solicitados */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Articulos solicitados */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}
  
  ASSIGN V-art-cant     = Rqs_detalle.Cantidad
         V-Descripcion  = Articulo.Descripcion
         V-cdg-articulo = Articulo.Cdg_articulo.
  Display V-art-cant
          V-Descripcion
          V-cdg-Articulo WITH FRAME {&FRAME-NAME}.     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel B-table-Win
ON CHOOSE OF Btn_Cancel IN FRAME F-Main /* Cancelar */
DO:

    APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg-articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg-articulo B-table-Win
ON LEAVE OF v-cdg-articulo IN FRAME F-Main
DO:
  ASSIGN V-cdg-articulo.
  FIND FIRST Articulo 
       WHERE Articulo.cdg_articulo = V-cdg-articulo NO-LOCK NO-ERROR.
  IF AVAILABLE Articulo THEN DO:
     Assign V-descripcion = Articulo.Descripcion .
     Display V-descripcion WITH FRAME {&FRAME-NAME}.
   END.  
  ELSE DO:
     MESSAGE "Mensaje provisorio de Codigo inexistente" VIEW-AS ALERT-BOX.
     RETURN NO-APPLY.
  END.
  
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg-articulo B-table-Win
ON LEFT-MOUSE-DBLCLICK OF v-cdg-articulo IN FRAME F-Main
OR "+" OF v-cdg-articulo IN FRAME {&FRAME-NAME}

DO:

  DEFINE VARIABLE rid_articulo AS ROWID.
  
  RUN selartic.p ( INPUT-OUTPUT rid_articulo, "C", INPUT YES).
  IF rid_articulo <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
       ASSIGN V-cdg-articulo = Articulo.cdg_articulo.
       Display V-descripcion WITH FRAME {&FRAME-NAME}.

       
       APPLY "RETURN" TO SELF.
       RETURN NO-APPLY.
  END.             
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg-articulo B-table-Win
ON RETURN OF v-cdg-articulo IN FRAME F-Main
DO:

  FIND Articulo WHERE Articulo.cdg_articulo = INPUT FRAME F-Main v-cdg-articulo NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Articulo 
  THEN DO:
       RUN PONMENSJ.P ( '1036' ).
       RETURN NO-APPLY.
  END.
  
  v-Descripcion = Articulo.Descripcion .
  DISPLAY v-Descripcion 
          WITH FRAME {&FRAME-NAME}.
          
  

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
  {src/adm/template/row-list.i "Rqs_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Rqs_header"}

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

  /* Dispatch standard ADM method.                             */
  
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
  
  APPLY "VALUE-CHANGED" TO {&BROWSE-NAME} IN FRAME {&FRAME-NAME}.
  
  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Rqs_header"}
  {src/adm/template/snd-list.i "Rqs_detalle"}
  {src/adm/template/snd-list.i "Articulo"}

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


