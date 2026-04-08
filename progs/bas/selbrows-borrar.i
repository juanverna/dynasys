&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME gDialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS gDialog 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM2 SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE act_registro AS ROWID.
DEFINE VARIABLE ALT-MOD      AS LOGICAL.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER act_registro as ROWID.
DEFINE INPUT  PARAMETER ALT-MOD      AS LOGICAL.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_item      AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE que_tecla     AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE des_registro  AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE p_letra       AS INTEGER.
DEFINE VARIABLE que_char      AS INTEGER.
DEFINE VARIABLE ldes          AS INTEGER.
DEFINE VARIABLE ancho         AS INTEGER.
DEFINE VARIABLE alto          AS INTEGER.

DEFINE VARIABLE que_empresa   LIKE Empresa.cdg_empresa.
{findempresa.i}
que_empresa = Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME gDialog
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES {&TABLA}

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 {&TABLA}.{&NOMBRE} ~
{&TABLA}.{&CODIGO} {&EXTRA}
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH {&TABLA} ~
      WHERE {&TABLA}.{&NOMBRE} BEGINS des_registro {&WHERE} NO-LOCK ~
    BY {&TABLA}.{&NOMBRE} INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH {&TABLA} ~
      WHERE {&TABLA}.{&NOMBRE} BEGINS des_registro {&WHERE} AND {&CONDICION} NO-LOCK ~
    BY {&TABLA}.{&NOMBRE} INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 {&TABLA}
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 {&TABLA}


/* Definitions for DIALOG-BOX gDialog                                   */
&Scoped-define OPEN-BROWSERS-IN-QUERY-gDialog ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS sel_registro BROWSE-1 Btn_elegir Btn_salir 
&Scoped-Define DISPLAYED-OBJECTS sel_registro 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_elegir AUTO-GO 
     LABEL "Elegir" 
     SIZE 23 BY 1.14.

DEFINE BUTTON Btn_salir AUTO-END-KEY 
     LABEL "Cancelar" 
     SIZE 23 BY 1.14.

DEFINE VARIABLE sel_registro AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 96 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      {&TABLA} SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 gDialog _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      {&TABLA}.{&NOMBRE} WIDTH 42.29
      {&TABLA}.{&CODIGO} WIDTH 15.43
      {&EXTRA}
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 96 BY 7.81 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME gDialog
     sel_registro AT ROW 1.29 COL 3 NO-LABEL NO-TAB-STOP 
     BROWSE-1 AT ROW 2.62 COL 3
     Btn_elegir AT ROW 10.67 COL 3
     Btn_salir AT ROW 10.76 COL 76
     SPACE(2.79) SKIP(0.42)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de Registros..."
         DEFAULT-BUTTON Btn_elegir CANCEL-BUTTON Btn_salir.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB gDialog 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX gDialog
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-1 sel_registro gDialog */
ASSIGN 
       FRAME gDialog:SCROLLABLE       = FALSE
       FRAME gDialog:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN sel_registro IN FRAME gDialog
   ALIGN-L                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "sic.{&TABLA}"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sic.{&TABLA}.{&NOMBRE}|yes"
     _Where[1]         = "{&TABLA}.{&NOMBRE} BEGINS des_registro"
     _FldNameList[1]   > sic.{&TABLA}.{&NOMBRE}
"{&TABLA}.{&NOMBRE}" ? ? "character" ? ? ? ? ? ? no ? no no "42.29" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.{&TABLA}.{&CODIGO}
"{&TABLA}.{&CODIGO}" ? ? "character" ? ? ? ? ? ? no ? no no "15.43" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX gDialog
/* Query rebuild information for DIALOG-BOX gDialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX gDialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME gDialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL gDialog gDialog
ON WINDOW-CLOSE OF FRAME gDialog /* Selección de Registros... */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_elegir gDialog
ON CHOOSE OF Btn_elegir IN FRAME gDialog /* Elegir */
DO:
  act_registro = ROWID({&TABLA}).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME sel_registro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sel_registro gDialog
ON ANY-KEY OF sel_registro IN FRAME gDialog
DO:
    ldes = LENGTH(des_registro).
    que_char = LASTKEY.
    IF KEYFUNCTION(que_char) = "GO" 
    THEN DO:
      APPLY "RETURN" TO SELF.
      RETURN NO-APPLY.
    END.  

    IF KEYFUNCTION(que_char) = "TAB" 
    THEN DO:
       APPLY "TAB" TO SELF.
       RETURN NO-APPLY.
    END.

    IF KEYFUNCTION(que_char) = "END-ERROR" 
    THEN DO:
       APPLY "END-ERROR" TO SELF.
       RETURN NO-APPLY.
    END.

    IF que_char = 1091    /* ALT-C */
    THEN DO:
       APPLY "CHOOSE" TO btn_salir IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.
    END.

    IF que_char = 1093    /* ALT-E */
    THEN DO:
       APPLY "CHOOSE" TO btn_elegir IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.
    END.

    que_tecla = CAPS(CHR(que_char)).
    p_letra = INDEX("ABCDEFGHIJKLMN¥OPQRSTUVWXYZ0123456789., ",que_tecla).

    IF p_letra <> 0
    THEN DO:
      des_registro = des_registro + que_tecla.
      ldes = ldes + 1.
    END.  
    ELSE
      IF KEYFUNCTION(que_char) = "BACKSPACE" 
      THEN DO:
         des_registro = substring(des_registro,1,ldes - 1).
         ldes = ldes - 1.
      END.   
      ELSE DO:
         BELL.
      END.
        /*
    OPEN QUERY brw_registro
       FOR EACH {&TABLA} 
       WHERE 
        /*   {&TABLA}.{&NOMBRE} BEGINS des_registro */
           &IF DEFINED(CONDICION)
           &THEN 
              {&CONDICION}
           &ENDIF
           BY {&TABLA}.{&NOMBRE}.*/
    {&OPEN-QUERY-{&BROWSE-NAME}}
    sel_registro:SCREEN-VALUE IN FRAME {&FRAME-NAME} = des_registro.
    IF ldes >= 0 THEN
       sel_registro:CURSOR-OFFSET IN FRAME {&FRAME-NAME} = ldes + 1.

    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL sel_registro gDialog
ON RETURN OF sel_registro IN FRAME gDialog
OR MOUSE-SELECT-DBLCLICK OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
OR RETURN OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:
  APPLY "CHOOSE" TO Btn_elegir.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK gDialog 


/* ***************************  Main Block  *************************** */

{src/adm2/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects gDialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI gDialog  _DEFAULT-DISABLE
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
  HIDE FRAME gDialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI gDialog  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY sel_registro 
      WITH FRAME gDialog.
  ENABLE sel_registro BROWSE-1 Btn_elegir Btn_salir 
      WITH FRAME gDialog.
  VIEW FRAME gDialog.
&IF DEFINED(PROCESO_INIT)
&THEN 
 {&PROCESO_INIT}
&ENDIF
/*OPEN QUERY brw_registro
     FOR EACH {&TABLA} 
     WHERE 
  /*       {&TABLA}.{&NOMBRE} BEGINS des_registro */
         &IF DEFINED(CONDICION)
         &THEN 
            {&CONDICION}
         &ENDIF
         BY {&TABLA}.{&NOMBRE}.*/
  {&OPEN-BROWSERS-IN-QUERY-gDialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

