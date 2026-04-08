&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic            PROGRESS
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

DEFINE VARIABLE fg_pendiente  AS INTEGER INITIAL 9.
DEFINE VARIABLE bg_pendiente  AS INTEGER INITIAL 11.

DEFINE VARIABLE fg_resuelto   AS INTEGER INITIAL 14.
DEFINE VARIABLE bg_resuelto   AS INTEGER INITIAL 2.

DEFINE VARIABLE fg_descartado AS INTEGER INITIAL 15.
DEFINE VARIABLE bg_descartado AS INTEGER INITIAL 7.

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
&Scoped-define EXTERNAL-TABLES Tema
&Scoped-define FIRST-EXTERNAL-TABLE Tema


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tema.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Problema

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Problema.nro_problema ~
Problema.titulo Problema.fecha_reportado Problema.fecha_resuelto ~
Problema.version-reporte 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Problema OF Tema ~
      WHERE Problema.estado = que_estado NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_table Problema
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Problema


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-7 que_estado br_table 
&Scoped-Define DISPLAYED-OBJECTS que_estado 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-br_table 
       MENU-ITEM m_Reclasificar LABEL "Reclasificar"  .


/* Definitions of the field level widgets                               */
DEFINE VARIABLE que_estado AS CHARACTER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Abierto", "",
"Resuelto", "R":U,
"Descartado", "D":U,
"Presupuestar", "P":U
     SIZE 52 BY .81 NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 87 BY 1.35.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Problema SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Problema.nro_problema COLUMN-LABEL "Número de!Tarea" FORMAT ">>>>>9"
      Problema.titulo COLUMN-LABEL "Titulo!Descriptivo" FORMAT "X(45)"
      Problema.fecha_reportado COLUMN-LABEL "Fecha!Reportado"
      Problema.fecha_resuelto COLUMN-LABEL "Fecha!Resuelto"
      Problema.version-reporte
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 87 BY 6.73
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Tareas Inherentes al presente proyecto".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     que_estado AT ROW 1.27 COL 34 NO-LABEL
     br_table AT ROW 2.62 COL 1
     RECT-7 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Tema
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
         HEIGHT             = 10.62
         WIDTH              = 88.43.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

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
       br_table:POPUP-MENU IN FRAME F-Main         = MENU POPUP-MENU-br_table:HANDLE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Problema OF sic.Tema"
     _Options          = "NO-LOCK"
     _Where[1]         = "Problema.estado = que_estado"
     _FldNameList[1]   > sic.Problema.nro_problema
"Problema.nro_problema" "Número de!Tarea" ">>>>>9" "integer" ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Problema.titulo
"Problema.titulo" "Titulo!Descriptivo" "X(45)" "character" ? ? ? ? ? ? no ?
     _FldNameList[3]   > sic.Problema.fecha_reportado
"Problema.fecha_reportado" "Fecha!Reportado" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[4]   > sic.Problema.fecha_resuelto
"Problema.fecha_resuelto" "Fecha!Resuelto" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[5]   = sic.Problema.version-reporte
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
ON ROW-DISPLAY OF br_table IN FRAME F-Main /* Tareas Inherentes al presente proyecto */
DO:
  CASE Problema.estado:
       WHEN "" THEN RUN poner_pendiente.
       WHEN "R" THEN RUN poner_resuelto.
       WHEN "D" THEN RUN poner_descartado.
  END.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Tareas Inherentes al presente proyecto */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Tareas Inherentes al presente proyecto */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Tareas Inherentes al presente proyecto */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Reclasificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Reclasificar B-table-Win
ON CHOOSE OF MENU-ITEM m_Reclasificar /* Reclasificar */
DO:
  DEFINE BUFFER B-Problema FOR Problema.
  DEFINE VARIABLE que_modulo LIKE Problema.cdg_tema.
  que_modulo = Problema.cdg_tema.
  UPDATE que_modulo LABEL "Indique nuevo módulo"
         WITH FRAME f-modulo VIEW-AS DIALOG-BOX TITLE "Reclasificar Problemas"
              THREE-D SIDE-LABEL.

  DO TRANSACTION:            
     FIND CURRENT Problema EXCLUSIVE-LOCK.
     Problema.cdg_tema = que_modulo.
     FIND CURRENT Tema EXCLUSIVE-LOCK.
     FIND LAST B-Problema OF Tema NO-ERROR.
     Problema.nro_problema = IF AVAILABLE B-Problema 
                                THEN B-Problema.nro_problema + 1
                                ELSE 1.
     RUN dispatch IN THIS-PROCEDURE ('open-query':U).

  END.    
                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_estado B-table-Win
ON VALUE-CHANGED OF que_estado IN FRAME F-Main
DO:
  ASSIGN que_estado.
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
  {src/adm/template/row-list.i "Tema"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tema"}

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_descartado B-table-Win 
PROCEDURE poner_descartado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      Problema.fecha_reportado:FGCOLOR IN BROWSE br_table = fg_descartado.
      Problema.fecha_resuelto:FGCOLOR IN BROWSE br_table  = fg_descartado. 
      Problema.nro_problema:FGCOLOR IN BROWSE br_table    = fg_descartado. 
      Problema.titulo:FGCOLOR IN BROWSE br_table          = fg_descartado.
      Problema.version-reporte:FGCOLOR IN BROWSE br_table = fg_descartado.

      Problema.fecha_reportado:BGCOLOR IN BROWSE br_table = bg_descartado.
      Problema.fecha_resuelto:BGCOLOR IN BROWSE br_table  = bg_descartado. 
      Problema.nro_problema:BGCOLOR IN BROWSE br_table    = bg_descartado. 
      Problema.titulo:BGCOLOR IN BROWSE br_table          = bg_descartado.
      Problema.version-reporte:BGCOLOR IN BROWSE br_table = bg_descartado.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_pendiente B-table-Win 
PROCEDURE poner_pendiente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      Problema.fecha_reportado:FGCOLOR IN BROWSE br_table = fg_pendiente.
      Problema.fecha_resuelto:FGCOLOR IN BROWSE br_table  = fg_pendiente. 
      Problema.nro_problema:FGCOLOR IN BROWSE br_table    = fg_pendiente. 
      Problema.titulo:FGCOLOR IN BROWSE br_table          = fg_pendiente.
      Problema.version-reporte:FGCOLOR IN BROWSE br_table = fg_pendiente.

      Problema.fecha_reportado:BGCOLOR IN BROWSE br_table = bg_pendiente.
      Problema.fecha_resuelto:BGCOLOR IN BROWSE br_table  = bg_pendiente. 
      Problema.nro_problema:BGCOLOR IN BROWSE br_table    = bg_pendiente. 
      Problema.titulo:BGCOLOR IN BROWSE br_table          = bg_pendiente.
      Problema.version-reporte:BGCOLOR IN BROWSE br_table = bg_pendiente.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_resuelto B-table-Win 
PROCEDURE poner_resuelto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      Problema.fecha_reportado:FGCOLOR IN BROWSE br_table = fg_resuelto.
      Problema.fecha_resuelto:FGCOLOR IN BROWSE br_table  = fg_resuelto. 
      Problema.nro_problema:FGCOLOR IN BROWSE br_table    = fg_resuelto. 
      Problema.titulo:FGCOLOR IN BROWSE br_table          = fg_resuelto.
      Problema.version-reporte:FGCOLOR IN BROWSE br_table = fg_resuelto.

      Problema.fecha_reportado:BGCOLOR IN BROWSE br_table = bg_resuelto.
      Problema.fecha_resuelto:BGCOLOR IN BROWSE br_table  = bg_resuelto. 
      Problema.nro_problema:BGCOLOR IN BROWSE br_table    = bg_resuelto. 
      Problema.titulo:BGCOLOR IN BROWSE br_table          = bg_resuelto.
      Problema.version-reporte:BGCOLOR IN BROWSE br_table = bg_resuelto.



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
  {src/adm/template/snd-list.i "Tema"}
  {src/adm/template/snd-list.i "Problema"}

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


