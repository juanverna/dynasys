&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Opg_header NO-UNDO LIKE Opg_header.


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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
&ELSE
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Opg_header.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Opg_header

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Opg_header.nombre ~
T-Opg_header.direccion T-Opg_header.cdg_postal T-Opg_header.localidad ~
T-Opg_header.cuit T-Opg_header.cdg_provincia 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Opg_header.nombre ~
T-Opg_header.direccion T-Opg_header.cdg_postal T-Opg_header.localidad ~
T-Opg_header.cuit T-Opg_header.cdg_provincia 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Opg_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Opg_header
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Opg_header SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Opg_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Opg_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Opg_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Opg_header.nombre T-Opg_header.direccion ~
T-Opg_header.cdg_postal T-Opg_header.localidad T-Opg_header.cuit ~
T-Opg_header.cdg_provincia 
&Scoped-define ENABLED-TABLES T-Opg_header
&Scoped-define FIRST-ENABLED-TABLE T-Opg_header
&Scoped-Define ENABLED-OBJECTS RECT-15 RECT-16 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Opg_header.nombre T-Opg_header.direccion ~
T-Opg_header.cdg_postal T-Opg_header.localidad T-Opg_header.cuit ~
T-Opg_header.cdg_provincia 
&Scoped-define DISPLAYED-TABLES T-Opg_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Opg_header


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 68 BY 6.48.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 68 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Opg_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     T-Opg_header.nombre AT ROW 2.91 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
     T-Opg_header.direccion AT ROW 4.1 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
     T-Opg_header.cdg_postal AT ROW 5.29 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     T-Opg_header.localidad AT ROW 5.29 COL 44 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 25 BY 1
     T-Opg_header.cuit AT ROW 6.48 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
     T-Opg_header.cdg_provincia AT ROW 7.67 COL 17 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 52 BY 1
     Btn_OK AT ROW 9.57 COL 5
     Btn_Cancel AT ROW 9.57 COL 51
     "   Datos de nominación de la Orden de Pago" VIEW-AS TEXT
          SIZE 68 BY 1 AT ROW 1.48 COL 4
          BGCOLOR 5 FGCOLOR 15 
     RECT-15 AT ROW 2.62 COL 4
     RECT-16 AT ROW 9.33 COL 4
     SPACE(2.19) SKIP(0.33)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos de Nominación del Comprobante Actual"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Opg_header T "?" NO-UNDO sic Opg_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Opg_header"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Datos de Nominación del Comprobante Actual */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        ASSIGN FRAME {&FRAME-NAME}
            T-Opg_header.nombre
            T-Opg_header.cuit 

            T-Opg_header.direccion 
            T-Opg_header.localidad 
            T-Opg_header.cdg_postal
            T-Opg_header.cdg_provincia.


        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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

  RUN inicia_combos.

  FIND FIRST T-Opg_header.
  DISPLAY 
        T-Opg_header.cdg_postal
        T-Opg_header.cdg_provincia 
        T-Opg_header.cuit 
        T-Opg_header.direccion 
        T-Opg_header.localidad 
        T-Opg_header.nombre
        WITH FRAME {&FRAME-NAME}.      

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  IF AVAILABLE T-Opg_header THEN 
    DISPLAY T-Opg_header.nombre T-Opg_header.direccion T-Opg_header.cdg_postal 
          T-Opg_header.localidad T-Opg_header.cuit T-Opg_header.cdg_provincia 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-15 RECT-16 T-Opg_header.nombre T-Opg_header.direccion 
         T-Opg_header.cdg_postal T-Opg_header.localidad T-Opg_header.cuit 
         T-Opg_header.cdg_provincia Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos Dialog-Frame 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
            
     lista = "".
     FOR EACH Provincia NO-LOCK BY Provincia.nombre:
         lista = lista + "," + TRIM(Provincia.nombre) + "," + Provincia.cdg_provincia.
     END.
     T-Opg_header.cdg_provincia:LIST-ITEM-PAIRS = SUBSTRING(lista,2).

  END.          
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   hay_error = YES.

   IF NOT CAN-FIND(Provincia WHERE Provincia.cdg_provincia = INPUT FRAME {&FRAME-NAME} T-Opg_header.cdg_provincia)
   THEN DO:
        RUN ponmensj.p ( INPUT "FACT009" ).
        RETURN.
   END.

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

