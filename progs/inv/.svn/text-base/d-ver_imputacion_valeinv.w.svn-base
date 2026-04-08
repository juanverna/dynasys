&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Sub_detalle_inv NO-UNDO LIKE Sub_detalle_inv.
DEFINE TEMP-TABLE T-Sub_header_inv NO-UNDO LIKE Sub_header_inv.


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

DEFINE INPUT PARAMETER TABLE FOR T-Sub_header_inv.
DEFINE INPUT PARAMETER TABLE FOR T-Sub_detalle_inv.

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE v-debito  AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE v-credito AS CHARACTER FORMAT "X(16)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-10

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Asn_detalle Cuenta Entidad Obra

/* Definitions for BROWSE BROWSE-10                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-10 Cuenta.cdg_cuenta ~
Cuenta.nombre_cta Entidad.cdg_entidad Obra.cdg_obra ~
fn-importe (T-Asn_detalle.debito) @ v-debito ~
fn-importe(T-Asn_detalle.credito) @ v-credito 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-10 
&Scoped-define QUERY-STRING-BROWSE-10 FOR EACH T-Asn_detalle NO-LOCK, ~
      EACH Cuenta OF T-Asn_detalle NO-LOCK, ~
      EACH Entidad OF T-Asn_detalle NO-LOCK, ~
      EACH Obra OF T-Asn_detalle OUTER-JOIN NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-10 OPEN QUERY BROWSE-10 FOR EACH T-Asn_detalle NO-LOCK, ~
      EACH Cuenta OF T-Asn_detalle NO-LOCK, ~
      EACH Entidad OF T-Asn_detalle NO-LOCK, ~
      EACH Obra OF T-Asn_detalle OUTER-JOIN NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-10 T-Asn_detalle Cuenta Entidad Obra
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-10 T-Asn_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-10 Cuenta
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-10 Entidad
&Scoped-define FOURTH-TABLE-IN-QUERY-BROWSE-10 Obra


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-10}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-10 RECT-12 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fn-importe Dialog-Frame 
FUNCTION fn-importe RETURNS CHARACTER
  ( INPUT p-importe AS DECIMAL)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 6 GRAPHIC-EDGE  NO-FILL 
     SIZE 132 BY 9.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-10 FOR 
      T-Asn_detalle, 
      Cuenta, 
      Entidad, 
      Obra SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-10 Dialog-Frame _STRUCTURED
  QUERY BROWSE-10 NO-LOCK DISPLAY
      Cuenta.cdg_cuenta FORMAT "X(8)":U WIDTH 13.2
      Cuenta.nombre_cta COLUMN-LABEL "Nombre!Cuenta" FORMAT "X(28)":U
            WIDTH 41.4
      Entidad.cdg_entidad FORMAT "X(8)":U WIDTH 11
      Obra.cdg_obra FORMAT "X(8)":U WIDTH 12.2
      fn-importe (T-Asn_detalle.debito) @ v-debito COLUMN-LABEL "Importe!Débitos" FORMAT "X(15)":U
            WIDTH 20.2
      fn-importe(T-Asn_detalle.credito) @ v-credito COLUMN-LABEL "Importe!Créditos" FORMAT "X(15)":U
            WIDTH 20.2
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 127 BY 8.1
         BGCOLOR 15 FGCOLOR 9 FONT 2.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     BROWSE-10 AT ROW 1.81 COL 5
     RECT-12 AT ROW 1.29 COL 3
     SPACE(2.19) SKIP(0.32)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Imputación contable del vale actual".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Asn_detalle T "?" NO-UNDO sic Asn_detalle
      TABLE: T-Sub_detalle_inv T "?" NO-UNDO sic Sub_detalle_inv
      TABLE: T-Sub_header_inv T "?" NO-UNDO sic Sub_header_inv
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-10 1 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-10
/* Query rebuild information for BROWSE BROWSE-10
     _TblList          = "Temp-Tables.T-Asn_detalle,sic.Cuenta OF Temp-Tables.T-Asn_detalle,sic.Entidad OF Temp-Tables.T-Asn_detalle,sic.Obra OF Temp-Tables.T-Asn_detalle"
     _Options          = "NO-LOCK"
     _TblOptList       = ",,, OUTER"
     _FldNameList[1]   > sic.Cuenta.cdg_cuenta
"Cuenta.cdg_cuenta" ? ? "character" ? ? ? ? ? ? no ? no no "13.2" yes no no "U" "" ""
     _FldNameList[2]   > sic.Cuenta.nombre_cta
"Cuenta.nombre_cta" "Nombre!Cuenta" "X(28)" "character" ? ? ? ? ? ? no ? no no "41.4" yes no no "U" "" ""
     _FldNameList[3]   > sic.Entidad.cdg_entidad
"Entidad.cdg_entidad" ? ? "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" ""
     _FldNameList[4]   > sic.Obra.cdg_obra
"Obra.cdg_obra" ? ? "character" ? ? ? ? ? ? no ? no no "12.2" yes no no "U" "" ""
     _FldNameList[5]   > "_<CALC>"
"fn-importe (T-Asn_detalle.debito) @ v-debito" "Importe!Débitos" "X(15)" ? ? ? ? ? ? ? no ? no no "20.2" yes no no "U" "" ""
     _FldNameList[6]   > "_<CALC>"
"fn-importe(T-Asn_detalle.credito) @ v-credito" "Importe!Créditos" "X(15)" ? ? ? ? ? ? ? no ? no no "20.2" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-10 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Imputación contable del vale actual */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-10
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
  RUN armar_asiento.
  {&OPEN-QUERY-{&BROWSE-NAME}}          
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_asiento Dialog-Frame 
PROCEDURE armar_asiento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    
    DEFINE VARIABLE nl AS INTEGER.

    nl = 1.
    FOR EACH T-Sub_detalle_inv BY T-Sub_detalle_inv.tipo:
    
        CREATE T-Asn_detalle.
        ASSIGN T-Asn_detalle.nro_cuenta  = T-Sub_detalle_inv.nro_cuenta
               T-Asn_detalle.nro_entidad = T-Sub_detalle_inv.nro_entidad
               T-Asn_detalle.nro_obra    = T-Sub_detalle_inv.nro_obra
               T-Asn_detalle.nro_linea   = nl
               nl                        = nl + 1.
    
        IF T-Sub_detalle_inv.tipo = 1
           THEN ASSIGN
                   T-Asn_detalle.debito  = T-Sub_detalle_inv.valor
                   T-Asn_detalle.credito = 0.
           ELSE ASSIGN
                   T-Asn_detalle.credito = T-Sub_detalle_inv.valor
                   T-Asn_detalle.debito  = 0.
    
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
  ENABLE BROWSE-10 RECT-12 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fn-importe Dialog-Frame 
FUNCTION fn-importe RETURNS CHARACTER
  ( INPUT p-importe AS DECIMAL) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-campo AS CHARACTER.
  
  IF p-importe <> 0
     THEN v-campo = STRING(p-importe,"->>,>>>,>>9.99").
     ELSE v-campo = "".

  RETURN v-campo.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

