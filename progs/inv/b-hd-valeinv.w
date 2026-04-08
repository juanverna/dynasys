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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Valeinv_hd Area

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Area.cdg_area Area.denominacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Valeinv_hd WHERE ~{&KEY-PHRASE} ~
      AND Valeinv_hd.estado = "P" NO-LOCK, ~
      EACH Area OF Valeinv_hd NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Valeinv_hd Area
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Valeinv_hd


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table RECT-6 btn_cerrar btn_imprimir 

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
nro_area||y|sic.Valeinv_hd.nro_area
nro_entidad||y|sic.Valeinv_hd.nro_entidad
fecha||y|sic.Valeinv_hd.fecha
cdg_imputacion||y|sic.Valeinv_hd.cdg_imputacion
cdg_planta||y|sic.Valeinv_hd.cdg_planta
nro_usuario||y|sic.Valeinv_hd.nro_usuario
nro_valeinv||y|sic.Valeinv_hd.nro_valeinv
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_area,nro_entidad,fecha,cdg_imputacion,cdg_planta,nro_usuario,nro_valeinv"':U).

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
DEFINE BUTTON btn_cerrar 
     LABEL "&Cerrar Vale" 
     SIZE 15 BY 1.12
     FONT 4.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir Vale" 
     SIZE 15 BY 1.12
     FONT 4.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 17 BY 6.77.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Valeinv_hd, 
      Area SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Area.cdg_area COLUMN-LABEL "Código!de Area"
      Area.denominacion COLUMN-LABEL "Denominación!del área"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 48 BY 6.77
         BGCOLOR 11 FGCOLOR 9 FONT 4.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
     btn_cerrar AT ROW 1.54 COL 51
     btn_imprimir AT ROW 3.15 COL 51
     RECT-6 AT ROW 1 COL 50
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
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
         HEIGHT             = 6.88
         WIDTH              = 69.14.
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
     _TblList          = "sic.Valeinv_hd,sic.Area OF sic.Valeinv_hd"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "sic.Valeinv_hd.estado = ""P"""
     _FldNameList[1]   > sic.Area.cdg_area
"Area.cdg_area" "Código!de Area" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Area.denominacion
"Area.denominacion" "Denominación!del área" ? "character" ? ? ? ? ? ? no ?
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

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cerrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cerrar B-table-Win
ON CHOOSE OF btn_cerrar IN FRAME F-Main /* Cerrar Vale */
DO:
     MESSAGE " Confirma el cierre de los vales pendientes ? "
         VIEW-AS ALERT-BOX 
         QUESTION BUTTONS YES-NO 
         TITLE "Se pide confirmación"
         UPDATE wlselec AS LOGICAL.
         
    IF wlselec THEN DO:

     IF AVAILABLE Valeinv_hd
     THEN DO:
          RUN cerrar_vale.
          RUN dispatch IN THIS-PROCEDURE ('open-query':U).
          
         /* Para disparar el Open-Query de b-reqalma */
     
       
          DEFINE VARIABLE h1    AS HANDLE NO-UNDO.
          DEFINE VARIABLE h2    AS HANDLE NO-UNDO.
          DEFINE VARIABLE c1    AS CHAR   NO-UNDO.
          DEFINE VARIABLE d1    AS CHAR   NO-UNDO.
                 
          RUN get-link-handle IN adm-broker-hdl
             (THIS-PROCEDURE, 'Renueva-Target':U, OUTPUT c1).
          IF NUM-ENTRIES (c1) eq 1 
             THEN DO:
             h1 = WIDGET-HANDLE (c1).
          END.  
       
          RUN get-link-handle IN adm-broker-hdl
             (H1, 'Record-Target':U, OUTPUT d1).
          IF NUM-ENTRIES (d1) eq 1 
             THEN DO:
             h2 = WIDGET-HANDLE (d1).
             RUN dispatch IN H2 ('local-display-fields').
          END.  

          
          
          
     END.
     ELSE DO:
          MESSAGE "No hay vales que puedan cerrarse"
                  VIEW-AS ALERT-BOX ERROR.
     END.     
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir Vale */
DO:
     IF AVAILABLE Valeinv_hd
     THEN DO:
          FIND Parametro "NFVALSAL" NO-LOCK NO-ERROR.
          RUN VALUE("PRVSA" + STRING(Parametro.valor_n, "999") + ".P") ( INPUT ROWID(Valeinv_hd) ).
     END.
     ELSE DO:
          MESSAGE "No hay vales que puedan imprimirse"
                  VIEW-AS ALERT-BOX ERROR.
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cerrar_vale B-table-Win 
PROCEDURE cerrar_vale :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND CURRENT Valeinv_hd EXCLUSIVE-LOCK.

  FIND Parametro "PROXNVSA" EXCLUSIVE-LOCK.
  ASSIGN Valeinv_hd.estado       = "E"
         Valeinv_hd.nro_comprob  = Parametro.valor_n
         Parametro.valor_n       = Parametro.valor_n + 1.
  RELEASE Parametro.

  FOR EACH Rqs_detalle WHERE Rqs_detalle.ult_valeinv = Valeinv_hd.nro_valeinv EXCLUSIVE-LOCK: 

      ASSIGN
             Rqs_detalle.cantidad_cum  = Rqs_detalle.cantidad_cum +  Rqs_detalle.cantidad_ult
             Rqs_detalle.ult_valeinv   = 0
             Rqs_detalle.cantidad_ult  = 0 
             Rqs_detalle.granel_ult    = 0
             Rqs_detalle.selectado     = NO.
      IF  Rqs_detalle.cantidad_cum >=  Rqs_detalle.cantidad 
         THEN Rqs_detalle.cdg_estado    = "CA".
  
  END.
  
  RUN SRWVALEHD.P ( INPUT ROWID(Valeinv_hd) ).

  RUN EMIVALSA.
  FIND CURRENT Valeinv_hd NO-LOCK.
  
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view B-table-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Refresca-browse B-table-Win 
PROCEDURE Refresca-browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  RUN dispatch IN THIS-PROCEDURE ("open-query":U).
  
       DEFINE VARIABLE h    AS HANDLE NO-UNDO.
       DEFINE VARIABLE c    AS CHAR   NO-UNDO.
       DEFINE VARIABLE d    AS CHAR   NO-UNDO.
                 
       /* Ask the Record-Source for the current customer record.  Make sure
           there is only one.*/

       RUN get-link-handle IN adm-broker-hdl
             (THIS-PROCEDURE, 'Record-Target':U, OUTPUT c).
       IF NUM-ENTRIES (c) eq 1 
       THEN DO:
         h = WIDGET-HANDLE (c).
         RUN dispatch IN h ('open-query':U).
       END.  
       
       RUN get-link-handle IN adm-broker-hdl
             (H, 'Record-Target':U, OUTPUT d).
       IF NUM-ENTRIES (d) eq 1 
       THEN DO:
         h = WIDGET-HANDLE (d).
         RUN dispatch IN h ('open-query':U).
       END.  



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
  {src/adm/template/sndkycas.i "nro_area" "Valeinv_hd" "nro_area"}
  {src/adm/template/sndkycas.i "nro_entidad" "Valeinv_hd" "nro_entidad"}
  {src/adm/template/sndkycas.i "fecha" "Valeinv_hd" "fecha"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Valeinv_hd" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_planta" "Valeinv_hd" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_usuario" "Valeinv_hd" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_valeinv" "Valeinv_hd" "nro_valeinv"}

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
  {src/adm/template/snd-list.i "Valeinv_hd"}
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


