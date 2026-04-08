&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Modulo-SIC NO-UNDO LIKE Modulo-SIC.


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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE codigo      AS INTEGER.
DEFINE VARIABLE que_clave   AS INTEGER.
DEFINE VARIABLE que_clave_d AS DECIMAL.
DEFINE VARIABLE que_clave_o AS DECIMAL.
DEFINE VARIABLE que_fecha   AS DATE.
DEFINE VARIABLE que_hora    AS CHARACTER.
DEFINE VARIABLE tiempo      AS INTEGER.
DEFINE VARIABLE titulo      AS CHARACTER FORMAT "X(40)".

DEFINE BUFFER B-Empresa FOR Empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-4

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Modulo-SIC

/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 T-Modulo-SIC.cdg_sigla-sic ~
T-Modulo-SIC.descripcion T-Modulo-SIC.usuarios_maximo 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4 ~
T-Modulo-SIC.usuarios_maximo 
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-4 T-Modulo-SIC
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-4 T-Modulo-SIC
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH T-Modulo-SIC NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY BROWSE-4 FOR EACH T-Modulo-SIC NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 T-Modulo-SIC
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 T-Modulo-SIC


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-4}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Empresa.nombre Empresa.direccion ~
Empresa.localidad Empresa.codigo_postal Empresa.provincia Empresa.telefono ~
Empresa.sistema Empresa.actividad Empresa.cuit Empresa.clave ~
Empresa.fecha_limite 
&Scoped-define ENABLED-TABLES Empresa
&Scoped-define FIRST-ENABLED-TABLE Empresa
&Scoped-Define ENABLED-OBJECTS BROWSE-4 Btn_OK Btn_Cancel RECT-1 
&Scoped-Define DISPLAYED-FIELDS Empresa.nombre Empresa.direccion ~
Empresa.localidad Empresa.codigo_postal Empresa.provincia Empresa.telefono ~
Empresa.sistema Empresa.actividad Empresa.cuit Empresa.clave ~
Empresa.fecha_limite 
&Scoped-define DISPLAYED-TABLES Empresa
&Scoped-define FIRST-DISPLAYED-TABLE Empresa


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 17 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Grabar" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 66 BY 11.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-4 FOR 
      T-Modulo-SIC SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 Dialog-Frame _STRUCTURED
  QUERY BROWSE-4 NO-LOCK DISPLAY
      T-Modulo-SIC.cdg_sigla-sic COLUMN-LABEL "Sigla!Módulo" FORMAT "X(3)":U
            WIDTH 10.2
      T-Modulo-SIC.descripcion COLUMN-LABEL "Descripción!Módulo" FORMAT "X(35)":U
      T-Modulo-SIC.usuarios_maximo FORMAT ">,>>9":U WIDTH 11.8
  ENABLE
      T-Modulo-SIC.usuarios_maximo
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 63 BY 11.91
         BGCOLOR 15 FGCOLOR 9  EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     BROWSE-4 AT ROW 1.24 COL 70
     Empresa.nombre AT ROW 1.71 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.direccion AT ROW 2.91 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.localidad AT ROW 4.1 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.codigo_postal AT ROW 5.29 COL 12 COLON-ALIGNED
          LABEL "C. Postal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.provincia AT ROW 5.29 COL 37 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 26.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.telefono AT ROW 6.48 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.sistema AT ROW 7.67 COL 12 COLON-ALIGNED FORMAT "X(200)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.actividad AT ROW 8.86 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.cuit AT ROW 8.86 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.clave AT ROW 10.05 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empresa.fecha_limite AT ROW 10.05 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 11.48 COL 14
     Btn_Cancel AT ROW 11.48 COL 49
     RECT-1 AT ROW 1.29 COL 2
     SPACE(66.79) SKIP(0.41)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos de la empresa actual"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Modulo-SIC T "?" NO-UNDO sic Modulo-SIC
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-4 1 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Empresa.codigo_postal IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Empresa.sistema IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _TblList          = "Temp-Tables.T-Modulo-SIC"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > Temp-Tables.T-Modulo-SIC.cdg_sigla-sic
"T-Modulo-SIC.cdg_sigla-sic" "Sigla!Módulo" ? "character" ? ? ? ? ? ? no ? no no "10.2" yes no no "U" "" ""
     _FldNameList[2]   > Temp-Tables.T-Modulo-SIC.descripcion
"T-Modulo-SIC.descripcion" "Descripción!Módulo" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Modulo-SIC.usuarios_maximo
"T-Modulo-SIC.usuarios_maximo" ? ? "integer" ? ? ? ? ? ? yes ? no no "11.8" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _Options          = "SHARE-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Datos de la empresa actual */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Grabar */
DO:
    ASSIGN FRAME {&FRAME-NAME}
        Empresa.nombre         
        Empresa.direccion      
        Empresa.localidad      
        Empresa.telefono       
        Empresa.cuit
      /*Empresa.sistema        */
        Empresa.fecha_limite   
        Empresa.clave
        Empresa.codigo_postal
        Empresa.provincia.

    RUN grabar_datos.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
  FIND Empresa OF Usuario EXCLUSIVE-LOCK NO-ERROR.
  IF NOT AVAILABLE Empresa
  THEN DO:
       MESSAGE "No se encontro la empresa de LOGIN. Accediendo a la primera empresa definida"
               VIEW-AS ALERT-BOX WARNING TITLE "Aviso!!!".
       FIND FIRST Empresa EXCLUSIVE-LOCK.        
  END.

  RUN cargar_modulos.
   
  RUN enable_UI.

  que_fecha = TODAY.
  que_hora =  STRING(TIME,"HH:MM:SS").
  tiempo = INTEGER(SUBSTRING(que_hora,4,2)) * 100 + INTEGER(SUBSTRING(que_hora,7,2)).
  que_clave_d = tiempo * 10000 + MONTH(que_fecha) * 100 + DAY(que_fecha).  
  que_clave_d = TRUNCATE(que_clave_d / 311303,4).
  que_clave =  INTEGER(TRUNCATE(que_clave_d * 10000,0) MOD 10000).
  titulo = "Datos de la empresa actual " + " - " + Empresa.cdg_empresa + "  " + STRING(que_fecha) + " - " + que_hora.

  FRAME {&FRAME-NAME}:TITLE = titulo.
  DISPLAY 
        Empresa.nombre         
        Empresa.direccion      
        Empresa.localidad      
        Empresa.telefono       
        Empresa.cuit
        Empresa.sistema        
        Empresa.fecha_limite   
        Empresa.clave
        Empresa.codigo_postal
        Empresa.provincia
        WITH FRAME {&FRAME-NAME}.
        
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_modulos Dialog-Frame 
PROCEDURE cargar_modulos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE j-modulo  AS INTEGER.
    DEFINE VARIABLE n-modulos AS INTEGER.
    
    EMPTY TEMP-TABLE T-Modulo-SIC.
    FOR EACH Modulo-SIC:
        CREATE T-Modulo-SIC.
        BUFFER-COPY Modulo-SIC TO T-Modulo-SIC
            ASSIGN T-Modulo-SIC.usuarios_maximo = 0.
    END.
    
    IF Empresa.sistema = "SIC" 
    THEN DO:
    END.
    ELSE DO:
        DO j-modulo = 1 TO NUM-ENTRIES(Empresa.sistema,","):
            FIND T-Modulo-SIC WHERE T-Modulo-SIC.cdg_sigla-sic = ENTRY(1,ENTRY(j-modulo,Empresa.sistema,","),":").
            T-Modulo-SIC.usuarios_maximo = INTEGER(ENTRY(2,ENTRY(j-modulo,Empresa.sistema,","),":")).
        END.
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
  IF AVAILABLE Empresa THEN 
    DISPLAY Empresa.nombre Empresa.direccion Empresa.localidad 
          Empresa.codigo_postal Empresa.provincia Empresa.telefono 
          Empresa.sistema Empresa.actividad Empresa.cuit Empresa.clave 
          Empresa.fecha_limite 
      WITH FRAME Dialog-Frame.
  ENABLE BROWSE-4 Empresa.nombre Empresa.direccion Empresa.localidad 
         Empresa.codigo_postal Empresa.provincia Empresa.telefono 
         Empresa.sistema Empresa.actividad Empresa.cuit Empresa.clave 
         Empresa.fecha_limite Btn_OK Btn_Cancel RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE grabar_datos Dialog-Frame 
PROCEDURE grabar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE x-modulos AS CHARACTER.
    DEFINE VARIABLE cod_aut   AS INTEGER.

    DO TRANSACTION:

        x-modulos = "".
        FOR EACH T-Modulo-SIC:

            FIND Modulo-SIC WHERE Modulo-SIC.cdg_sigla-sic = T-Modulo-SIC.cdg_sigla-sic EXCLUSIVE-LOCK. 
            Modulo-SIC.usuarios_maximo = T-Modulo-SIC.usuarios_maximo.

            IF T-Modulo-SIC.usuarios_maximo <> 0
            THEN DO:
                x-modulos = x-modulos + "," + T-Modulo-SIC.cdg_sigla-sic + ":" + STRING(T-Modulo-SIC.usuarios_maximo,"9999").
                Modulo-SIC.activo = YES.
            END.
            ELSE DO:
                Modulo-SIC.activo = NO.
            END.

            RELEASE Modulo-SIC.
        END.

        x-modulos = SUBSTRING(x-modulos,2).
        Empresa.sistema = x-modulos.
    
        FOR EACH B-Empresa WHERE B-Empresa.cdg_empresa <> Empresa.cdg_empresa EXCLUSIVE-LOCK:
            B-Empresa.sistema = Empresa.sistema.
        END.

        IF Empresa.clave = que_clave 
           THEN RUN autorizar_empresa.p ( INPUT 1, OUTPUT cod_aut ) .

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

