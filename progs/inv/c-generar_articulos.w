&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
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
DEFINE VARIABLE p-que_origen  AS ROWID INITIAL ".F.AH.20".   
DEFINE VARIABLE puso_ok       AS LOGICAL.   
&ELSE
DEFINE INPUT  PARAMETER   p-que_origen   AS ROWID.   
DEFINE OUTPUT PARAMETER   puso_ok        AS LOGICAL.   
&ENDIF


/* Local Variable Definitions ---                                       */

DEFINE TEMP-TABLE T-Articulo LIKE Articulo.
DEFINE TEMP-TABLE O-Articulo LIKE Articulo.

DEFINE BUFFER Subclase FOR Clase_de_articulo.
DEFINE BUFFER Clase    FOR Clase_de_articulo.
DEFINE BUFFER Superior FOR Clase_de_articulo.

DEFINE VARIABLE que_clase    LIKE Clase_de_articulo.cdg_clase.
DEFINE VARIABLE que_subclase LIKE Clase_de_articulo.cdg_subclase.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Clase_de_Articulo

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 Clase_de_Articulo.cdg_subclaseart ~
Clase_de_Articulo.nombre_subclaseart 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH Clase_de_Articulo ~
      WHERE Clase_de_Articulo.cdg_claseart  BEGINS que_subclase NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH Clase_de_Articulo ~
      WHERE Clase_de_Articulo.cdg_claseart  BEGINS que_subclase NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 Clase_de_Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 Clase_de_Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btn_generar-2 btn_generar btn_salir ~
v-cdg_articulo v-modo_bajar BROWSE-1 
&Scoped-Define DISPLAYED-OBJECTS v-origen v-cdg_articulo v-dsc_articulo ~
v-cdg_generacion v-dsc_generacion v-cantidad v-tiempo v-artseg v-modo_bajar 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_generar 
     LABEL "&Generar" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_generar-2 
     LABEL "E&quivalencias" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_salir 
     LABEL "&Salir" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-modo_bajar AS CHARACTER FORMAT "X(256)":U INITIAL "N" 
     LABEL "Actualizar" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "NINGUNO","N",
                     "REEMPLAZAR","R",
                     "SOLO NUEVOS","S"
     DROP-DOWN-LIST
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-artseg AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Art/Seg:" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cantidad AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Cant." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(15)":U 
     LABEL "Artículo Modelo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 21 BY 1
     BGCOLOR 11 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-cdg_generacion AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_generacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-origen AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nodo Origen" 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-tiempo AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Seg" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 12 FONT 6 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      Clase_de_Articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 C-Win _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      Clase_de_Articulo.cdg_subclaseart FORMAT "X(10)":U WIDTH 37.2
      Clase_de_Articulo.nombre_subclaseart FORMAT "X(40)":U WIDTH 59.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 102 BY 19.29 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-origen AT ROW 1.24 COL 18 COLON-ALIGNED
     btn_generar-2 AT ROW 1.24 COL 58
     btn_generar AT ROW 1.24 COL 74
     btn_salir AT ROW 1.24 COL 90
     v-cdg_articulo AT ROW 2.43 COL 18 COLON-ALIGNED
     v-dsc_articulo AT ROW 2.43 COL 40 COLON-ALIGNED NO-LABEL
     v-cdg_generacion AT ROW 4.81 COL 1 COLON-ALIGNED NO-LABEL
     v-dsc_generacion AT ROW 4.81 COL 23 COLON-ALIGNED NO-LABEL
     v-cantidad AT ROW 6 COL 8 COLON-ALIGNED
     v-tiempo AT ROW 6 COL 30 COLON-ALIGNED
     v-artseg AT ROW 6 COL 57 COLON-ALIGNED
     v-modo_bajar AT ROW 6 COL 81 COLON-ALIGNED
     BROWSE-1 AT ROW 7.43 COL 3
     "   Estado de la generación" VIEW-AS TEXT
          SIZE 102 BY 1 AT ROW 3.62 COL 3
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 106.2 BY 25.91.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Generación masiva de artículos"
         HEIGHT             = 25.91
         WIDTH              = 106.2
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 160
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB BROWSE-1 v-modo_bajar DEFAULT-FRAME */
/* SETTINGS FOR FILL-IN v-artseg IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cantidad IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_generacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_generacion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-origen IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-tiempo IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "sic.Clase_de_Articulo"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "Clase_de_Articulo.cdg_claseart  BEGINS que_subclase"
     _FldNameList[1]   > sic.Clase_de_Articulo.cdg_subclaseart
"Clase_de_Articulo.cdg_subclaseart" ? ? "character" ? ? ? ? ? ? no ? no no "37.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Clase_de_Articulo.nombre_subclaseart
"Clase_de_Articulo.nombre_subclaseart" ? ? "character" ? ? ? ? ? ? no ? no no "59.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Generación masiva de artículos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Generación masiva de artículos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_generar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_generar C-Win
ON CHOOSE OF btn_generar IN FRAME DEFAULT-FRAME /* Generar */
DO:
    FIND Articulo WHERE Articulo.cdg_articulo = v-cdg_articulo:INPUT-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Articulo
    THEN DO:
        RUN ponmensj.p ( "ARTI020" ).
        RETURN.
    END.
    ELSE DO:
        DO TRANSACTION:
            RUN generar.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_generar-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_generar-2 C-Win
ON CHOOSE OF btn_generar-2 IN FRAME DEFAULT-FRAME /* Equivalencias */
DO:
    DEFINE VARIABLE puso_ok AS LOGICAL.
    DEFINE VARIABLE s-reemplazo AS CHARACTER.

    RUN getparametro_o.p ( INPUT "EQVDESCR", OUTPUT s-reemplazo ).

    RUN c-edttexto.w ( INPUT-OUTPUT s-reemplazo,
                       INPUT "Abreviaturas en descripciones de artículos",
                       INPUT 0, /* Modo modificaciones */
                       OUTPUT puso_ok).
    IF puso_ok
    THEN DO:
        RUN setparametro.p ( INPUT "EQVDESCR",
                             INPUT "",
                             INPUT 0.0,
                             INPUT NO,
                             INPUT 0,
                             INPUT s-reemplazo).

    END.
    
    RETURN NO-APPLY.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_salir C-Win
ON CHOOSE OF btn_salir IN FRAME DEFAULT-FRAME /* Salir */
DO:

    DEFINE VARIABLE sino-msg AS LOGICAL.
    sino-msg = NO.
    MESSAGE "Desea abandonar esta función?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
            APPLY "CLOSE":U TO THIS-PROCEDURE.
        &ENDIF

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Artículo Modelo */
OR MOUSE-MENU-DOWN,"." OF v-cdg_articulo IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_articulo AS ROWID.

  RUN selartic.p ( INPUT-OUTPUT rid_articulo, 
                   "I",
                   INPUT YES ).

  IF rid_articulo <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
       DISPLAY Articulo.cdg_articulo  @ v-cdg_articulo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_articulo IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo C-Win
ON RETURN OF v-cdg_articulo IN FRAME DEFAULT-FRAME /* Artículo Modelo */
DO:

    {traducetabla.i "Articulo" "cdg_articulo" "descripcion" }

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

FIND Clase_de_articulo WHERE ROWID(Clase_de_articulo) = p-que_origen NO-LOCK.
que_clase = Clase_de_articulo.cdg_clase.
que_subclase = Clase_de_articulo.cdg_subclase.
v-origen = Clase_de_articulo.cdg_subclase.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  DISPLAY v-origen
      WITH FRAME {&FRAME-NAME}.
  btn_generar:SENSITIVE = CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase BEGINS que_subclase).
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  DISPLAY v-origen v-cdg_articulo v-dsc_articulo v-cdg_generacion 
          v-dsc_generacion v-cantidad v-tiempo v-artseg v-modo_bajar 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE btn_generar-2 btn_generar btn_salir v-cdg_articulo v-modo_bajar 
         BROWSE-1 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generar C-Win 
PROCEDURE generar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-nom         AS CHARACTER FORMAT "X(70)".
    DEFINE VARIABLE v-ext         AS CHARACTER FORMAT "X(70)".
    DEFINE VARIABLE v-cod         AS CHARACTER FORMAT "X(12)".
    DEFINE VARIABLE v-sup         AS CHARACTER FORMAT "X(12)".
    DEFINE VARIABLE j-wrd         AS INTEGER.
    DEFINE VARIABLE x-reemplazo   AS CHARACTER.
    DEFINE VARIABLE s-reemplazo   AS CHARACTER. 
    DEFINE VARIABLE reemplazo     AS CHARACTER EXTENT 50.
    DEFINE VARIABLE c-registro    AS INTEGER.

    RUN getparametro_o.p ( INPUT "EQVDESCR", OUTPUT s-reemplazo ).
    
    DO j-wrd = 1 TO NUM-ENTRIES(s-reemplazo,",").
        reemplazo [ j-wrd ] = ENTRY(j-wrd,s-reemplazo,",").
    END.
    
    v-tiempo = ETIME(YES).

    FIND Articulo WHERE Articulo.cdg_articulo = v-cdg_articulo:INPUT-VALUE IN FRAME {&FRAME-NAME} NO-LOCK.
    CREATE O-Articulo.
    BUFFER-COPY Articulo TO O-Articulo. 
                                               
    ASSIGN FRAME {&FRAME-NAME} v-modo_bajar.
    
    c-registro = 0.
    FOR EACH Clase WHERE NOT CAN-FIND(FIRST Subclase WHERE Subclase.cdg_clase = Clase.cdg_subclase) 
                     AND Clase.cdg_clase BEGINS que_subclase NO-LOCK:
    
        v-cod = REPLACE(Clase.cdg_subclase,".","").
        v-nom = Clase.nombre_subclase.
        v-sup = Clase.cdg_clase.
    
        FIND Superior WHERE Superior.cdg_subclase = v-sup NO-LOCK NO-ERROR.
    
        DO WHILE AVAILABLE Superior:
    
            v-nom = Superior.nombre_subclase + " " + v-nom.
            v-sup = Superior.cdg_clase.
            FIND Superior WHERE Superior.cdg_subclase = v-sup NO-LOCK NO-ERROR.
    
        END.
        v-nom = TRIM(v-nom).
        v-ext = v-nom.

        x-reemplazo = reemplazo [ 1 ].
        DO j-wrd = 1 TO 50 WHILE x-reemplazo <> "$=$":
            v-nom = REPLACE(v-nom,ENTRY(1,x-reemplazo,"="),ENTRY(2,x-reemplazo,"=")).
            x-reemplazo = reemplazo [ j-wrd + 1 ].
        END.
    
        CREATE T-Articulo.
        BUFFER-COPY O-Articulo TO T-Articulo
            ASSIGN c-registro = c-registro + 1
                   T-Articulo.cdg_articulo = v-cod
                   T-Articulo.descripcion  = v-nom
                   T-Articulo.detallada    = IF O-Articulo.extendida THEN v-ext ELSE ""
                   T-Articulo.nro_articulo = c-registro
                   T-Articulo.cdg_subclase = Clase.cdg_subclase
                   v-cdg_generacion        = v-cod
                   v-dsc_generacion        = v-nom
                   v-tiempo                = ETIME / 1000
                   v-cantidad              = v-cantidad + 1
                   v-artseg                = v-cantidad / v-tiempo.
        
       DISPLAY v-cdg_generacion
               v-dsc_generacion
               v-tiempo  
               v-cantidad
               v-artseg  
               WITH FRAME {&FRAME-NAME}.
    
    END.

    IF v-modo_bajar <> "N" 
    THEN DO:
        v-dsc_generacion = "BAJANDO ARTICULOS ...".
        v-cdg_generacion = "".
        DISPLAY v-cdg_generacion
                v-dsc_generacion
                WITH FRAME {&FRAME-NAME}.

        FOR EACH T-Articulo:

            FIND Articulo WHERE Articulo.cdg_articulo = T-Articulo.cdg_articulo EXCLUSIVE-LOCK NO-ERROR.
            IF AVAILABLE Articulo
            THEN DO:
                IF v-modo_bajar = "R" 
                    THEN BUFFER-COPY T-Articulo EXCEPT nro_articulo TO Articulo.
            END.
            ELSE DO:
                CREATE Articulo.
                BUFFER-COPY T-Articulo TO Articulo
                    ASSIGN Articulo.nro_articulo = NEXT-VALUE(proximo_articulo).
            END.

            RELEASE Articulo.

        END.

        v-dsc_generacion = "TERMINADO".
        v-cdg_generacion = "".
        DISPLAY v-cdg_generacion
                v-dsc_generacion
                WITH FRAME {&FRAME-NAME}.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

