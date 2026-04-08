&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS a 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{nrorelea.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME a
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Empresa

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 Empresa.cdg_empresa Empresa.nombre 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH Empresa NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH Empresa NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 Empresa
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 Empresa


/* Definitions for DIALOG-BOX a                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-a ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-1 v-empresa v-tipo_rendicion ~
btn_ingresar Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-empresa v-nom-empresa v-tipo_rendicion ~
v-nom-tiporend 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir del Sistema" 
     SIZE 30 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_ingresar 
     LABEL "Ingresar Recibos" 
     SIZE 30 BY 1.14.

DEFINE VARIABLE v-empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 14 FGCOLOR 5 FONT 0 NO-UNDO.

DEFINE VARIABLE v-nom-empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1 NO-UNDO.

DEFINE VARIABLE v-nom-tiporend AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1 NO-UNDO.

DEFINE VARIABLE v-tipo_rendicion AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tipo" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 14 FGCOLOR 5 FONT 0 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      Empresa SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 a _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      Empresa.cdg_empresa FORMAT "X(8)":U WIDTH 10.2
      Empresa.nombre COLUMN-LABEL "Razón!Social" FORMAT "X(30)":U
            WIDTH 47.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 63 BY 5.24 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME a
     BROWSE-1 AT ROW 2.91 COL 9
     v-empresa AT ROW 8.86 COL 19 COLON-ALIGNED
     v-nom-empresa AT ROW 8.86 COL 28 COLON-ALIGNED NO-LABEL
     v-tipo_rendicion AT ROW 12.67 COL 19 COLON-ALIGNED
     v-nom-tiporend AT ROW 12.67 COL 28 COLON-ALIGNED NO-LABEL
     btn_ingresar AT ROW 18.62 COL 10
     Btn_Cancel AT ROW 18.62 COL 43
     "1 - Cobranzas" VIEW-AS TEXT
          SIZE 22 BY .62 AT ROW 14.52 COL 22
          BGCOLOR 8 FGCOLOR 5 FONT 0
     "4 - Devoluciones" VIEW-AS TEXT
          SIZE 24 BY .62 AT ROW 16.95 COL 22
          BGCOLOR 8 FGCOLOR 5 FONT 0
     "   Indique el tipo de rendición a ingresar:" VIEW-AS TEXT
          SIZE 63 BY 1 AT ROW 10.76 COL 9
          BGCOLOR 5 FGCOLOR 15 
     "2 - Moras" VIEW-AS TEXT
          SIZE 22 BY .62 AT ROW 15.33 COL 22
          BGCOLOR 8 FGCOLOR 5 FONT 0
     "   Por Favor, identifique la empresa:" VIEW-AS TEXT
          SIZE 63 BY 1 AT ROW 1.48 COL 9
          BGCOLOR 5 FGCOLOR 15 
     "3 - Bajas" VIEW-AS TEXT
          SIZE 22 BY .62 AT ROW 16.14 COL 22
          BGCOLOR 8 FGCOLOR 5 FONT 0
     SPACE(34.99) SKIP(3.85)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Identificacion de Empresa"
         CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX a
                                                                        */
/* BROWSE-TAB BROWSE-1 1 a */
ASSIGN 
       FRAME a:SCROLLABLE       = FALSE
       FRAME a:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-nom-empresa IN FRAME a
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nom-tiporend IN FRAME a
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "sic.Empresa"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sic.Empresa.cdg_empresa
"Empresa.cdg_empresa" ? ? "character" ? ? ? ? ? ? no ? no no "10.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Empresa.nombre
"Empresa.nombre" "Razón!Social" ? "character" ? ? ? ? ? ? no ? no no "47.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a a
ON WINDOW-CLOSE OF FRAME a /* Identificacion de Empresa */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ingresar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ingresar a
ON CHOOSE OF btn_ingresar IN FRAME a /* Ingresar Recibos */
DO:
        
    DO TRANSACTION:
               
        RUN d-alta_recibos.w ( INPUT v-tipo_rendicion, INPUT v-empresa ).       
        
    END.
               
    ASSIGN
          v-empresa = ""
          v-tipo_rendicion = ""
          v-nom-empresa = ""
          v-nom-tiporend = "".
    
    DISPLAY
          v-empresa
          v-tipo_rendicion
          v-nom-empresa
          v-nom-tiporend
          WITH FRAME {&FRAME-NAME}.
    
    APPLY "ENTRY" TO v-empresa.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-empresa a
ON ANY-PRINTABLE OF v-empresa IN FRAME a /* Empresa */
DO:
    v-empresa = CAPS(KEYFUNCTION(LASTKEY)).
    FIND Empresa WHERE Empresa.cdg_empresa = v-empresa NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Empresa
    THEN DO:
        MESSAGE "No existe la empresa indicada" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        v-nom-empresa = "Seleccionó " + Empresa.nombre.
        DISPLAY v-nom-empresa
                v-empresa
                WITH FRAME {&FRAME-NAME}.
        APPLY "TAB" TO SELF.
        RETURN NO-APPLY.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-empresa a
ON RETURN OF v-empresa IN FRAME a /* Empresa */
DO:
  APPLY "TAB" TO v-empresa IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-tipo_rendicion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tipo_rendicion a
ON ANY-PRINTABLE OF v-tipo_rendicion IN FRAME a /* Tipo */
DO:

 v-tipo_rendicion = KEYFUNCTION(LASTKEY).
 IF LOOKUP(v-tipo_rendicion,"1,2,3,4") = 0
 THEN DO:
      MESSAGE "Para el TIPO DE RENDICION debe indicar solo 1, 2, 3 o 4" 
              VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
 END.
 ELSE DO:
      v-nom-tiporend = "Seleccionó ".
      CASE v-tipo_rendicion:
           WHEN "1" THEN v-nom-tiporend = v-nom-tiporend + "COBRANZAS".
           WHEN "2" THEN v-nom-tiporend = v-nom-tiporend + "MORAS".
           WHEN "3" THEN v-nom-tiporend = v-nom-tiporend + "BAJAS".
           WHEN "4" THEN v-nom-tiporend = v-nom-tiporend + "DEVOLUCIONES".
      END CASE.
      DISPLAY v-nom-tiporend
              v-tipo_rendicion
              WITH FRAME {&FRAME-NAME}.
      APPLY "TAB" TO SELF.
      RETURN NO-APPLY.
 END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tipo_rendicion a
ON LEAVE OF v-tipo_rendicion IN FRAME a /* Tipo */
DO:
/* 
 ASSIGN FRAME {&FRAME-NAME} v-tipo_rendicion.
 IF LOOKUP(v-tipo_rendicion,"1,2,3,4") = 0
 THEN DO:
      MESSAGE "Para el TIPO DE RENDICION debe indicar solo 1, 2, 3 o 4" 
              VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
 END.
 ELSE DO:
      v-nom-tiporend = "Seleccionó ".
      CASE v-tipo_rendicion:
           WHEN "1" THEN v-nom-tiporend = v-nom-tiporend + "COBRANZAS".
           WHEN "2" THEN v-nom-tiporend = v-nom-tiporend + "MORAS".
           WHEN "3" THEN v-nom-tiporend = v-nom-tiporend + "BAJAS".
           WHEN "4" THEN v-nom-tiporend = v-nom-tiporend + "DEVOLUCIONES".
      END CASE.
      DISPLAY v-nom-tiporend
              WITH FRAME {&FRAME-NAME}.
 END.
*/ 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tipo_rendicion a
ON RETURN OF v-tipo_rendicion IN FRAME a /* Tipo */
DO:
  APPLY "TAB" TO v-tipo_rendicion IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK a 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  {setwintit.i "SIC/AFI" "Ingreso de Cupones"}
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI a  _DEFAULT-DISABLE
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
  HIDE FRAME a.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI a  _DEFAULT-ENABLE
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
  DISPLAY v-empresa v-nom-empresa v-tipo_rendicion v-nom-tiporend 
      WITH FRAME a.
  ENABLE BROWSE-1 v-empresa v-tipo_rendicion btn_ingresar Btn_Cancel 
      WITH FRAME a.
  VIEW FRAME a.
  {&OPEN-BROWSERS-IN-QUERY-a}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

