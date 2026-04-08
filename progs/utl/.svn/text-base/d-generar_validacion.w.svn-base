&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BRW-CAMPOS

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES _Field _File

/* Definitions for BROWSE BRW-CAMPOS                                    */
&Scoped-define FIELDS-IN-QUERY-BRW-CAMPOS _Field._Field-name   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-CAMPOS   
&Scoped-define SELF-NAME BRW-CAMPOS
&Scoped-define QUERY-STRING-BRW-CAMPOS FOR EACH _Field OF _File
&Scoped-define OPEN-QUERY-BRW-CAMPOS OPEN QUERY {&SELF-NAME} FOR EACH _Field OF _File.
&Scoped-define TABLES-IN-QUERY-BRW-CAMPOS _Field
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-CAMPOS _Field


/* Definitions for BROWSE BRW-TABLAS                                    */
&Scoped-define FIELDS-IN-QUERY-BRW-TABLAS _File._File-name   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BRW-TABLAS   
&Scoped-define SELF-NAME BRW-TABLAS
&Scoped-define QUERY-STRING-BRW-TABLAS FOR EACH _File BY _File._File-name
&Scoped-define OPEN-QUERY-BRW-TABLAS OPEN QUERY {&SELF-NAME} FOR EACH _File BY _File._File-name.
&Scoped-define TABLES-IN-QUERY-BRW-TABLAS _File
&Scoped-define FIRST-TABLE-IN-QUERY-BRW-TABLAS _File


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BRW-CAMPOS}~
    ~{&OPEN-QUERY-BRW-TABLAS}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btn_generar Btn_OK BRW-TABLAS BRW-CAMPOS 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_generar 
     LABEL "&Generar" 
     SIZE 15 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BRW-CAMPOS FOR 
      _Field SCROLLING.

DEFINE QUERY BRW-TABLAS FOR 
      _File SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BRW-CAMPOS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-CAMPOS Dialog-Frame _FREEFORM
  QUERY BRW-CAMPOS DISPLAY
      _Field._Field-name COLUMN-LABEL "Nombre!Campo"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 61 BY 19.52
         TITLE "Campos de la tabla actual" EXPANDABLE.

DEFINE BROWSE BRW-TABLAS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BRW-TABLAS Dialog-Frame _FREEFORM
  QUERY BRW-TABLAS DISPLAY
      _File._File-name COLUMN-LABEL "Nombre!Tabla"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 61 BY 19.52
         TITLE "Tablas de la base de datos" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     btn_generar AT ROW 1.24 COL 51
     Btn_OK AT ROW 1.24 COL 115
     BRW-TABLAS AT ROW 2.67 COL 5
     BRW-CAMPOS AT ROW 2.67 COL 69
     SPACE(1.59) SKIP(2.28)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Generación automática de validaciones referenciales"
         DEFAULT-BUTTON Btn_OK.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BRW-TABLAS Btn_OK Dialog-Frame */
/* BROWSE-TAB BRW-CAMPOS BRW-TABLAS Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-CAMPOS
/* Query rebuild information for BROWSE BRW-CAMPOS
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH _Field OF _File.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BRW-CAMPOS */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BRW-TABLAS
/* Query rebuild information for BROWSE BRW-TABLAS
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH _File BY _File._File-name.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BRW-TABLAS */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Generación automática de validaciones referenciales */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-TABLAS
&Scoped-define SELF-NAME BRW-TABLAS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BRW-TABLAS Dialog-Frame
ON VALUE-CHANGED OF BRW-TABLAS IN FRAME Dialog-Frame /* Tablas de la base de datos */
DO:
  OPEN QUERY brw-campos FOR EACH _Field OF _File.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_generar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_generar Dialog-Frame
ON CHOOSE OF btn_generar IN FRAME Dialog-Frame /* Generar */
DO:
  RUN generar_validacion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BRW-CAMPOS
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
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  ENABLE btn_generar Btn_OK BRW-TABLAS BRW-CAMPOS 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE generar_validacion Dialog-Frame 
PROCEDURE generar_validacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    /*=================================================================================*/
    /*                                                                                 */
    /*  PRODUCE EN MEMORIA LA SENTENCIA DE VALIDACION DE BAJAS PARA UNA TABLA DADA     */
    /*  EN BASE AL USO DE UN CAMPO DETERMINADO                                         */
    /*                                                                                 */
    /*=================================================================================*/
    
    DEFINE VARIABLE linea     AS CHARACTER FORMAT "X(132)".
    DEFINE VARIABLE lin       AS CHARACTER FORMAT "X(132)" EXTENT 20.
    DEFINE VARIABLE izquierda AS CHARACTER FORMAT "X(32)".
    DEFINE VARIABLE derecha   AS CHARACTER FORMAT "X(32)".
    DEFINE VARIABLE que_tabla LIKE _File._File-name.
    DEFINE VARIABLE salida    AS CHARACTER FORMAT "X(32)" INITIAL "CPCAMPOS.I".
    DEFINE VARIABLE salida_clip AS LOGICAL VIEW-AS TOGGLE-BOX INITIAL YES.
    DEFINE VARIABLE lmaxi     AS INTEGER.
    DEFINE VARIABLE lmaxd     AS INTEGER.
    DEFINE VARIABLE li        AS INTEGER.
    DEFINE VARIABLE ld        AS INTEGER.
    DEFINE VARIABLE k         AS INTEGER.
    
    DEFINE VARIABLE que_campo AS CHARACTER FORMAT "X(32)" .
    DEFINE VARIABLE p-derecha   AS CHARACTER FORMAT "X(30)" INITIAL "~{~&DE-TABLA~}".
    
    FORM
       linea NO-LABEL
       WITH USE-TEXT FONT 2 WIDTH 260 FRAME bb DOWN.
    
    /*=================================================================================*/
    /*                      B L O Q U E     P R I N C I P A L                          */
    /*=================================================================================*/
    
    lin [ 01 ] = '/*=========================================================================================*/'.
    lin [ 02 ] = '/*                      VALIDACION DE BAJAS DE LA TABLA:&TABLA                             */'.
    lin [ 03 ] = '/*=========================================================================================*/'.
    lin [ 04 ] = '                                                                                             '.
    lin [ 05 ] = 'DEFINE INPUT  PARAMETER rid_&TABLA AS ROWID.                                           '.
    lin [ 06 ] = 'DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.                                               '.
    lin [ 07 ] = '                                                                                             '.
    lin [ 08 ] = 'FIND &TABLA WHERE ROWID(&TABLA) = rid_&TABLA NO-LOCK.                      '.
    lin [ 09 ] = 'RUN VALIDAR_BAJA.                                                                            '.
    lin [ 10 ] = '                                                                                             '.
    lin [ 11 ] = 'RETURN.                                                                                      '.
    lin [ 12 ] = '                                                                                             '.
    lin [ 13 ] = 'PROCEDURE VALIDAR_BAJA:                                                                      '.
    lin [ 14 ] = '                                                                                             '.
    lin [ 15 ] = '  hay_error = YES.                                                                           '.
    lin [ 16 ] = '                                                                                             '.
    
    SESSION:DATA-ENTRY-RETURN = YES.

    MESSAGE "Procedemos a generar validacion de la tabla " _File._File-name
             VIEW-AS ALERT-BOX MESSAGE TITLE "Inicia proceso de generacion".
    
    OUTPUT TO "CLIPBOARD".
    
    DO k = 1 TO 16:
       linea = REPLACE( lin [ k ] ,"&TABLA",_File._File-name).
       DISPLAY linea NO-LABEL
               WITH FRAME bb.
       DOWN WITH FRAME bb.
    END.
    
    ASSIGN que_campo = _Field._Field-name.
           que_tabla = _File._File-name.

    FOR EACH _Field WHERE _Field._Field-name BEGINS que_campo , _File OF _Field NO-LOCK
                         BREAK BY _Field._Field-name BY _File._File-name WITH FRAME bb:
                  
        IF _File._File-name <> que_tabla
        THEN DO:
        
             IF FIRST-OF(_Field._Field-name)
             THEN DO:
                  linea = "  IF CAN-FIND(FIRST " + 
                         _File._File-name + 
                         " WHERE " +
                         _File._File-name + "." + _Field._Field-name +
                         " = " + que_tabla + "." + que_campo + ") OR".
             END.
             ELSE IF LAST-OF(_Field._Field-name)
             THEN DO:
                  linea = "     CAN-FIND(FIRST " + 
                         _File._File-name + 
                         " WHERE " +
                         _File._File-name + "." + _Field._Field-name +
                         " = " + que_tabla + "." + que_campo + ")".
             END.
             ELSE DO:
                  linea = "     CAN-FIND(FIRST " + 
                         _File._File-name + 
                         " WHERE " +
                         _File._File-name + "." + _Field._Field-name +
                         " = " + que_tabla + "." + que_campo + ") OR".
             END.            
    
             DISPLAY linea NO-LABEL
                     WITH FRAME bb.
             DOWN WITH FRAME bb.
    
        END.             
        
    END.    
    
    linea = "     THEN RETURN.".
    DISPLAY linea NO-LABEL
            WITH FRAME bb.
    DOWN WITH FRAME bb.
    
    linea = " ".
    DISPLAY linea NO-LABEL
            WITH FRAME bb.
    DOWN WITH FRAME bb.
    
    linea = "  hay_error = NO.".
    DISPLAY linea NO-LABEL
            WITH FRAME bb.
    DOWN WITH FRAME bb.
    
    linea = " ".
    DISPLAY linea NO-LABEL
            WITH FRAME bb.
    DOWN WITH FRAME bb.
    
    linea = "END PROCEDURE.".
    DISPLAY linea NO-LABEL
            WITH FRAME bb.
    DOWN WITH FRAME bb.
    
    OUTPUT CLOSE.
    
        

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

