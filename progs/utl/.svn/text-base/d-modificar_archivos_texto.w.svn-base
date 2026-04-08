&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Modulo-SIC NO-UNDO LIKE Modulo-SIC
       FIELD selectado AS LOGICAL.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE TEMP-TABLE T-Cambios
    FIELD old_string AS CHARACTER FORMAT "X(30)" COLUMN-LABEL "Secuencia!Existente"
    FIELD new_string AS CHARACTER FORMAT "X(30)" COLUMN-LABEL "Secuencia!Reemplaza".

DEFINE STREAM Compilacion.

DEFINE VARIABLE x-dir AS CHARACTER.
DEFINE VARIABLE pusocancel AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BRW-CAMBIOS

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Cambios T-Modulo-SIC

/* Definitions for BROWSE BRW-CAMBIOS                                   */
&Scoped-define FIELDS-IN-QUERY-BRW-CAMBIOS T-Cambios.old_string T-Cambios.new_string   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-CAMBIOS   
&Scoped-define SELF-NAME BRW-CAMBIOS
&Scoped-define QUERY-STRING-BRW-CAMBIOS FOR EACH T-Cambios
&Scoped-define OPEN-QUERY-BRW-CAMBIOS OPEN QUERY {&SELF-NAME} FOR EACH T-Cambios.
&Scoped-define TABLES-IN-QUERY-BRW-CAMBIOS T-Cambios
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-CAMBIOS T-Cambios


/* Definitions for BROWSE BRW-MODULOS-DISPONIBLES                       */
&Scoped-define FIELDS-IN-QUERY-BRW-MODULOS-DISPONIBLES ~
T-Modulo-SIC.cdg_sigla-sic T-Modulo-SIC.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-MODULOS-DISPONIBLES 
&Scoped-define QUERY-STRING-BRW-MODULOS-DISPONIBLES FOR EACH T-Modulo-SIC NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BRW-MODULOS-DISPONIBLES OPEN QUERY BRW-MODULOS-DISPONIBLES FOR EACH T-Modulo-SIC NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BRW-MODULOS-DISPONIBLES T-Modulo-SIC
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-MODULOS-DISPONIBLES T-Modulo-SIC


/* Definitions for BROWSE BRW-MODULOS-SELECTADOS                        */
&Scoped-define FIELDS-IN-QUERY-BRW-MODULOS-SELECTADOS ~
T-Modulo-SIC.cdg_sigla-sic T-Modulo-SIC.descripcion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-MODULOS-SELECTADOS 
&Scoped-define QUERY-STRING-BRW-MODULOS-SELECTADOS FOR EACH T-Modulo-SIC NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BRW-MODULOS-SELECTADOS OPEN QUERY BRW-MODULOS-SELECTADOS FOR EACH T-Modulo-SIC NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BRW-MODULOS-SELECTADOS T-Modulo-SIC
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-MODULOS-SELECTADOS T-Modulo-SIC


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BRW-CAMBIOS}~
    ~{&OPEN-QUERY-BRW-MODULOS-DISPONIBLES}~
    ~{&OPEN-QUERY-BRW-MODULOS-SELECTADOS}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-archivo v-directorio_in btn_elegir-2 ~
btn_leer btn_grabar btn_elegir v-directorio_out btn_elegir-3 btn_probar ~
btn_hacer btn_todos BRW-CAMBIOS BRW-MODULOS-DISPONIBLES ~
BRW-MODULOS-SELECTADOS v-old_string v-new_string btn_borrar btn_agregar ~
btn_modificar 
&Scoped-Define DISPLAYED-OBJECTS v-archivo v-directorio_in v-directorio_out ~
v-procesando v-old_string v-new_string 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_agregar 
     LABEL "&Agregar" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_borrar 
     LABEL "&Eliminar" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_elegir 
     LABEL "&Elegir" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_elegir-2 
     LABEL "...." 
     SIZE 5 BY 1.

DEFINE BUTTON btn_elegir-3 
     LABEL "...." 
     SIZE 5 BY 1.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_hacer 
     LABEL "&Revisar y Cambiar" 
     SIZE 20 BY 1.14.

DEFINE BUTTON btn_leer 
     LABEL "&Leer" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_modificar 
     LABEL "&Modificar" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_probar 
     LABEL "&Revisar" 
     SIZE 20 BY 1.14.

DEFINE BUTTON btn_todos 
     LABEL "&Todos" 
     SIZE 20 BY 1.14.

DEFINE VARIABLE v-archivo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-directorio_in AS CHARACTER FORMAT "X(256)":U 
     LABEL "Inp" 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-directorio_out AS CHARACTER FORMAT "X(256)":U 
     LABEL "Out" 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-new_string AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nueva" 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-old_string AS CHARACTER FORMAT "X(256)":U 
     LABEL "Anterior" 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-procesando AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BRW-CAMBIOS FOR 
      T-Cambios SCROLLING.

DEFINE QUERY BRW-MODULOS-DISPONIBLES FOR 
      T-Modulo-SIC SCROLLING.

DEFINE QUERY BRW-MODULOS-SELECTADOS FOR 
      T-Modulo-SIC SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BRW-CAMBIOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-CAMBIOS Dialog-Frame _FREEFORM
  QUERY BRW-CAMBIOS DISPLAY
      T-Cambios.old_string
      T-Cambios.new_string
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 67 BY 13.1
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Equivalencias de reemplazos" EXPANDABLE.

DEFINE BROWSE BRW-MODULOS-DISPONIBLES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-MODULOS-DISPONIBLES Dialog-Frame _STRUCTURED
  QUERY BRW-MODULOS-DISPONIBLES NO-LOCK DISPLAY
      T-Modulo-SIC.cdg_sigla-sic COLUMN-LABEL "Sigla!Mödulo" FORMAT "X(3)":U
            WIDTH 12.2
      T-Modulo-SIC.descripcion COLUMN-LABEL "Descripción!Módulo" FORMAT "X(35)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 62 BY 9.05
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Modulos Disponibles" EXPANDABLE.

DEFINE BROWSE BRW-MODULOS-SELECTADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-MODULOS-SELECTADOS Dialog-Frame _STRUCTURED
  QUERY BRW-MODULOS-SELECTADOS NO-LOCK DISPLAY
      T-Modulo-SIC.cdg_sigla-sic COLUMN-LABEL "Sigla!Módulo" FORMAT "X(3)":U
            WIDTH 12.2
      T-Modulo-SIC.descripcion COLUMN-LABEL "Descripción!Módulo" FORMAT "X(35)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 62 BY 9.05
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Modulos Seleccionados" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-archivo AT ROW 3.38 COL 10 COLON-ALIGNED NO-LABEL
     v-directorio_in AT ROW 3.38 COL 83 COLON-ALIGNED
     btn_elegir-2 AT ROW 3.38 COL 142
     btn_leer AT ROW 4.57 COL 12
     btn_grabar AT ROW 4.57 COL 35
     btn_elegir AT ROW 4.57 COL 58
     v-directorio_out AT ROW 4.57 COL 83 COLON-ALIGNED
     btn_elegir-3 AT ROW 4.57 COL 142
     v-procesando AT ROW 6.24 COL 10 COLON-ALIGNED NO-LABEL
     btn_probar AT ROW 6.24 COL 85
     btn_hacer AT ROW 6.24 COL 106
     btn_todos AT ROW 6.24 COL 127
     BRW-CAMBIOS AT ROW 7.91 COL 12
     BRW-MODULOS-DISPONIBLES AT ROW 7.91 COL 85
     BRW-MODULOS-SELECTADOS AT ROW 17.43 COL 85
     v-old_string AT ROW 22.67 COL 10 COLON-ALIGNED
     v-new_string AT ROW 24.1 COL 10 COLON-ALIGNED
     btn_borrar AT ROW 25.52 COL 12
     btn_agregar AT ROW 25.52 COL 35
     btn_modificar AT ROW 25.52 COL 58
     "   Archivo que contiene la lista de equivalencias para el reemplazo" VIEW-AS TEXT
          SIZE 67 BY 1 AT ROW 1.95 COL 12
          BGCOLOR 5 FGCOLOR 15 
     "   Directorio de entrada y salida" VIEW-AS TEXT
          SIZE 62 BY 1 AT ROW 1.95 COL 85
          BGCOLOR 5 FGCOLOR 15 
     "   Cadena anterior y nueva que la reemplaza" VIEW-AS TEXT
          SIZE 67 BY 1 AT ROW 21.48 COL 12
          BGCOLOR 5 FGCOLOR 15 
     SPACE(79.39) SKIP(4.65)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cambio Masivo de Archivos de Texto".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Modulo-SIC T "?" NO-UNDO sic Modulo-SIC
      ADDITIONAL-FIELDS:
          FIELD selectado AS LOGICAL
      END-FIELDS.
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BRW-CAMBIOS btn_todos Dialog-Frame */
/* BROWSE-TAB BRW-MODULOS-DISPONIBLES BRW-CAMBIOS Dialog-Frame */
/* BROWSE-TAB BRW-MODULOS-SELECTADOS BRW-MODULOS-DISPONIBLES Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-procesando IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-CAMBIOS
/* Query rebuild information for BROWSE BRW-CAMBIOS
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Cambios.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BRW-CAMBIOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-MODULOS-DISPONIBLES
/* Query rebuild information for BROWSE BRW-MODULOS-DISPONIBLES
     _TblList          = "Temp-Tables.T-Modulo-SIC"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > Temp-Tables.T-Modulo-SIC.cdg_sigla-sic
"T-Modulo-SIC.cdg_sigla-sic" "Sigla!Mödulo" ? "character" ? ? ? ? ? ? no ? no no "12.2" yes no no "U" "" ""
     _FldNameList[2]   > Temp-Tables.T-Modulo-SIC.descripcion
"T-Modulo-SIC.descripcion" "Descripción!Módulo" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-MODULOS-DISPONIBLES */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-MODULOS-SELECTADOS
/* Query rebuild information for BROWSE BRW-MODULOS-SELECTADOS
     _TblList          = "Temp-Tables.T-Modulo-SIC"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > Temp-Tables.T-Modulo-SIC.cdg_sigla-sic
"T-Modulo-SIC.cdg_sigla-sic" "Sigla!Módulo" ? "character" ? ? ? ? ? ? no ? no no "12.2" yes no no "U" "" ""
     _FldNameList[2]   > Temp-Tables.T-Modulo-SIC.descripcion
"T-Modulo-SIC.descripcion" "Descripción!Módulo" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BRW-MODULOS-SELECTADOS */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cambio Masivo de Archivos de Texto */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-CAMBIOS
&Scoped-define SELF-NAME BRW-CAMBIOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-CAMBIOS Dialog-Frame
ON VALUE-CHANGED OF BRW-CAMBIOS IN FRAME Dialog-Frame /* Equivalencias de reemplazos */
DO:
    IF AVAILABLE T-Cambios
    THEN DO:
        ASSIGN v-old_string = T-Cambios.old_string
               v-new_string = T-Cambios.new_string.
    END.
    ELSE DO:
        ASSIGN v-old_string = ""
               v-new_string = "".
    END.

    DISPLAY v-old_string 
            v-new_string 
        WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-MODULOS-DISPONIBLES
&Scoped-define SELF-NAME BRW-MODULOS-DISPONIBLES
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-MODULOS-DISPONIBLES Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BRW-MODULOS-DISPONIBLES IN FRAME Dialog-Frame /* Modulos Disponibles */
DO:
  APPLY "RETURN" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-MODULOS-DISPONIBLES Dialog-Frame
ON RETURN OF BRW-MODULOS-DISPONIBLES IN FRAME Dialog-Frame /* Modulos Disponibles */
DO:
  
  T-Modulo-sic.selectado = NOT T-Modulo-sic.selectado.
  RUN abrir_querys.
  /*
  IF T-Modulo-sic.selectado
      THEN ASSIGN T-Modulo-sic.cdg_sigla-sic:FGCOLOR IN BROWSE BRW-MODULOS = 12
                  T-Modulo-sic.cdg_sigla-sic:BGCOLOR IN BROWSE BRW-MODULOS = 15
                  T-Modulo-sic.descripcion:FGCOLOR IN BROWSE BRW-MODULOS = 12
                  T-Modulo-sic.descripcion:BGCOLOR IN BROWSE BRW-MODULOS = 15.
      ELSE ASSIGN T-Modulo-sic.cdg_sigla-sic:FGCOLOR IN BROWSE BRW-MODULOS = 9
                  T-Modulo-sic.cdg_sigla-sic:BGCOLOR IN BROWSE BRW-MODULOS = 15
                  T-Modulo-sic.descripcion:FGCOLOR IN BROWSE BRW-MODULOS = 9
                  T-Modulo-sic.descripcion:BGCOLOR IN BROWSE BRW-MODULOS = 15.
  END.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-MODULOS-SELECTADOS
&Scoped-define SELF-NAME BRW-MODULOS-SELECTADOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-MODULOS-SELECTADOS Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BRW-MODULOS-SELECTADOS IN FRAME Dialog-Frame /* Modulos Seleccionados */
DO:
  APPLY "RETURN" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-MODULOS-SELECTADOS Dialog-Frame
ON RETURN OF BRW-MODULOS-SELECTADOS IN FRAME Dialog-Frame /* Modulos Seleccionados */
DO:
  
  T-Modulo-sic.selectado = NOT T-Modulo-sic.selectado.
  RUN abrir_querys.
  /*
  IF T-Modulo-sic.selectado
      THEN ASSIGN T-Modulo-sic.cdg_sigla-sic:FGCOLOR IN BROWSE BRW-MODULOS = 12
                  T-Modulo-sic.cdg_sigla-sic:BGCOLOR IN BROWSE BRW-MODULOS = 15
                  T-Modulo-sic.descripcion:FGCOLOR IN BROWSE BRW-MODULOS = 12
                  T-Modulo-sic.descripcion:BGCOLOR IN BROWSE BRW-MODULOS = 15.
      ELSE ASSIGN T-Modulo-sic.cdg_sigla-sic:FGCOLOR IN BROWSE BRW-MODULOS = 9
                  T-Modulo-sic.cdg_sigla-sic:BGCOLOR IN BROWSE BRW-MODULOS = 15
                  T-Modulo-sic.descripcion:FGCOLOR IN BROWSE BRW-MODULOS = 9
                  T-Modulo-sic.descripcion:BGCOLOR IN BROWSE BRW-MODULOS = 15.
  END.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_agregar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_agregar Dialog-Frame
ON CHOOSE OF btn_agregar IN FRAME Dialog-Frame /* Agregar */
DO:
  
  CREATE T-Cambios.
  ASSIGN FRAME {&FRAME-NAME} v-old_string v-new_string.
  ASSIGN T-Cambios.old_string = v-old_string
         T-Cambios.new_string = v-new_string.
  OPEN QUERY BRW-CAMBIOS FOR EACH T-Cambios.
  APPLY "VALUE-CHANGED" TO BRW-CAMBIOS.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_borrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_borrar Dialog-Frame
ON CHOOSE OF btn_borrar IN FRAME Dialog-Frame /* Eliminar */
DO:
  IF AVAILABLE T-Cambios
  THEN DO:
      DELETE T-Cambios.
      OPEN QUERY BRW-CAMBIOS FOR EACH T-Cambios.
      APPLY "VALUE-CHANGED" TO BRW-CAMBIOS.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir Dialog-Frame
ON CHOOSE OF btn_elegir IN FRAME Dialog-Frame /* Elegir */
DO:
  DEFINE VARIABLE puso_ok AS LOGICAL.
  ASSIGN FRAME {&FRAME-NAME} v-archivo.
  SYSTEM-DIALOG GET-FILE v-archivo
      FILTERS "Archivos texto (*.txt)" "*.txt"
      INITIAL-FILTER 1
      DEFAULT-EXTENSION ".txt"
      INITIAL-DIR "c:\sic-temp" 
      RETURN-TO-START-DIR 
      MUST-EXIST
      TITLE "Seleccione el archivo de entrada" 
      USE-FILENAME
      UPDATE puso_ok.

  IF puso_ok THEN DO:
      IF LENGTH(v-archivo) > 70 THEN DO:
          MESSAGE "Debe guardar el archivo en una ruta más corta" 
              VIEW-AS ALERT-BOX.
          APPLY "ENTRY" TO SELF.
          RETURN NO-APPLY.
      END.
      ELSE DISPLAY v-archivo WITH FRAME {&FRAME-NAME}.
  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir-2 Dialog-Frame
ON CHOOSE OF btn_elegir-2 IN FRAME Dialog-Frame /* .... */
DO:

    RUN buscarpeta.p ( INPUT "Seleccione el directorio de entrada", OUTPUT X-dir, OUTPUT pusocancel ).
    IF NOT pusocancel 
    THEN DO:
        v-directorio_in = X-dir.
        DISPLAY v-directorio_in
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        MESSAGE "No se indicó un directorio"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir-3 Dialog-Frame
ON CHOOSE OF btn_elegir-3 IN FRAME Dialog-Frame /* .... */
DO:
    RUN buscarpeta.p ( INPUT "Seleccione el directorio de destino", OUTPUT X-dir, OUTPUT pusocancel ).
    IF NOT pusocancel 
    THEN DO:
        v-directorio_out = X-dir.
        DISPLAY v-directorio_out
            WITH FRAME {&FRAME-NAME}.
    END.
    ELSE DO:
        MESSAGE "No se indicó un directorio"
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar Dialog-Frame
ON CHOOSE OF btn_grabar IN FRAME Dialog-Frame /* Grabar */
DO:
    ASSIGN FRAME {&FRAME-NAME} v-archivo.
    FILE-INFO:FILE-NAME = v-archivo.
    OUTPUT TO VALUE(v-archivo) PAGE-SIZE 0.
    FOR EACH T-Cambios:
        EXPORT DELIMITER "," T-Cambios.new_string T-Cambios.old_string.
    END.
    OUTPUT CLOSE.
    MESSAGE "Archivo Exportado"
        VIEW-AS ALERT-BOX INFO BUTTONS OK.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_hacer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_hacer Dialog-Frame
ON CHOOSE OF btn_hacer IN FRAME Dialog-Frame /* Revisar y Cambiar */
DO:
    RUN ejecutar ( INPUT YES ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_leer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_leer Dialog-Frame
ON CHOOSE OF btn_leer IN FRAME Dialog-Frame /* Leer */
DO:
    ASSIGN FRAME {&FRAME-NAME} v-archivo.
    FILE-INFO:FILE-NAME = v-archivo.
    IF FILE-INFO:FULL-PATHNAME <> ? 
    THEN DO:
        EMPTY TEMP-TABLE T-Cambios.
        RUN cargar_tabla_edicion.p ( INPUT v-archivo:INPUT-VALUE IN FRAME {&FRAME-NAME},
                               OUTPUT TABLE T-cambios).
        OPEN QUERY BRW-CAMBIOS FOR EACH T-Cambios.
        APPLY "VALUE-CHANGED" TO BRW-CAMBIOS.
    END.
    ELSE DO:
        MESSAGE "No se encontro el archivo indicado"
            VIEW-AS ALERT-BOX ERROR.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_modificar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_modificar Dialog-Frame
ON CHOOSE OF btn_modificar IN FRAME Dialog-Frame /* Modificar */
DO:
  
  ASSIGN FRAME {&FRAME-NAME} v-old_string v-new_string.
  ASSIGN T-Cambios.old_string = v-old_string
         T-Cambios.new_string = v-new_string.
  DISPLAY T-Cambios.old_string  
          T-Cambios.new_string
          WITH BROWSE BRW-CAMBIOS.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_probar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_probar Dialog-Frame
ON CHOOSE OF btn_probar IN FRAME Dialog-Frame /* Revisar */
DO:
  RUN ejecutar ( INPUT NO ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todos Dialog-Frame
ON CHOOSE OF btn_todos IN FRAME Dialog-Frame /* Todos */
DO:
  FOR EACH T-Modulo-sic:
      T-Modulo-sic.selectado = YES.
  END.
  RUN abrir_querys.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-CAMBIOS
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

RUN crear_modulos.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  OPEN QUERY BRW-MODULOS-DISPONIBLES 
    FOR EACH T-Modulo-sic WHERE NOT T-Modulo-sic.selectado.
  OPEN QUERY BRW-MODULOS-SELECTADOS 
    FOR EACH T-Modulo-sic WHERE T-Modulo-sic.selectado.

  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir_querys Dialog-Frame 
PROCEDURE abrir_querys :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  OPEN QUERY BRW-MODULOS-DISPONIBLES 
      FOR EACH T-Modulo-sic WHERE NOT T-Modulo-sic.selectado.
  OPEN QUERY BRW-MODULOS-SELECTADOS 
      FOR EACH T-Modulo-sic WHERE T-Modulo-sic.selectado.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_modulos Dialog-Frame 
PROCEDURE crear_modulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH Modulo-sic:
    CREATE T-Modulo-sic.
    BUFFER-COPY Modulo-sic TO T-Modulo-sic
        ASSIGN T-Modulo-sic.selectado = NO.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
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
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ejecutar Dialog-Frame 
PROCEDURE ejecutar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-bajar_cambios AS LOGICAL.

    ASSIGN FRAME {&FRAME-NAME} v-directorio_in v-directorio_out.

    ASSIGN v-procesando:FGCOLOR IN FRAME {&FRAME-NAME} = 15
           v-procesando:BGCOLOR IN FRAME {&FRAME-NAME} = 12.

    FOR EACH T-Modulo-sic WHERE T-Modulo-sic.selectado:
        RUN procesar_modulo ( INPUT v-directorio_in  + "\" + T-Modulo-sic.cdg_sigla-sic, 
                              INPUT v-directorio_out + "\" + T-Modulo-sic.cdg_sigla-sic, 
                              INPUT p-bajar_cambios ).
    END.

    ASSIGN v-procesando:FGCOLOR IN FRAME {&FRAME-NAME} = 9
           v-procesando:BGCOLOR IN FRAME {&FRAME-NAME} = 15.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY v-archivo v-directorio_in v-directorio_out v-procesando v-old_string 
          v-new_string 
      WITH FRAME Dialog-Frame.
  ENABLE v-archivo v-directorio_in btn_elegir-2 btn_leer btn_grabar btn_elegir 
         v-directorio_out btn_elegir-3 btn_probar btn_hacer btn_todos 
         BRW-CAMBIOS BRW-MODULOS-DISPONIBLES BRW-MODULOS-SELECTADOS 
         v-old_string v-new_string btn_borrar btn_agregar btn_modificar 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procesar_modulo Dialog-Frame 
PROCEDURE procesar_modulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

     DEFINE INPUT PARAMETER p-que_dir AS CHARACTER.
     DEFINE INPUT PARAMETER p-que_out AS CHARACTER.
     DEFINE INPUT PARAMETER p-bajar_cambios AS LOGICAL.

     /*-----------------------------------------------------------------------*/
     /*                     definicion de variables                           */
     /*-----------------------------------------------------------------------*/

     DEFINE VARIABLE rc          AS INTEGER.
     DEFINE VARIABLE t_archs     AS INTEGER.
     DEFINE VARIABLE t_tiempo    AS INTEGER.
     DEFINE VARIABLE tiempo      AS INTEGER.
     DEFINE VARIABLE n_archs     AS INTEGER.
     DEFINE VARIABLE j           AS INTEGER.
     DEFINE VARIABLE x           AS CHARACTER.
     DEFINE VARIABLE ext         AS CHARACTER.
     DEFINE VARIABLE prg         AS CHARACTER.
     DEFINE VARIABLE que_camino  AS CHARACTER FORMAT "X(60)".
     DEFINE VARIABLE que_tipo    AS CHARACTER FORMAT "X(1)".
     DEFINE VARIABLE que_archivo AS CHARACTER FORMAT "X(40)".
     DEFINE VARIABLE que_mensaje AS CHARACTER FORMAT "X(65)".
     DEFINE VARIABLE v-fecha     AS DATE.

     /*-----------------------------------------------------------------------*/
     /*                              proceso                                  */
     /*-----------------------------------------------------------------------*/

     INPUT FROM OS-DIR(p-que_dir).     
     OUTPUT STREAM Compilacion TO VALUE(p-que_dir + "\EDICION.LOG").

     n_archs = 0.
     tiempo = TIME.                                                       
     v-fecha = TODAY.
     que_mensaje = "Comienza " + STRING(tiempo,"HH:MM:SS") + " " + STRING(v-fecha).
     REPEAT:
        IMPORT que_archivo que_camino que_tipo.
        IF NUM-ENTRIES(que_archivo,".") > 1
        THEN DO:

            v-procesando = que_archivo.
            DISPLAY v-procesando
                WITH FRAME {&FRAME-NAME}.

            ext = ENTRY(2,que_archivo,".").
            IF  LOOKUP(ext,"P,I,W") <> 0
            THEN DO:

                n_archs = n_archs + 1.

                IF p-bajar_cambios
                    THEN RUN editar_un_archivo.p ( INPUT que_archivo , 
                                                   INPUT p-que_out,
                                                   INPUT TABLE T-Cambios,
                                                   OUTPUT rc ).
              
                PUT STREAM Compilacion n_archs que_camino rc SKIP.

            END.   

        END.

     END.      

     tiempo = TIME - tiempo.     
     que_mensaje = "Termina " + STRING(TIME,"HH:MM:SS") + " (" +
                    STRING(n_archs,"ZZ9") + " archivos " + STRING(tiempo,"HH:MM:SS") +
                    " horas )" .

     PUT STREAM Compilacion UNFORMATTED que_mensaje SKIP.

     OUTPUT STREAM Compilacion CLOSE.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

