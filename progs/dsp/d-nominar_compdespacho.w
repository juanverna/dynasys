&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Rem_header NO-UNDO LIKE Rem_header.



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
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_header.
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

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Rem_header

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Rem_header.nombre ~
T-Rem_header.cuit T-Rem_header.direccion T-Rem_header.cdg_postal ~
T-Rem_header.localidad T-Rem_header.cdg_provincia ~
T-Rem_header.direccion_leg T-Rem_header.cdg_postal_leg ~
T-Rem_header.localidad_leg T-Rem_header.cdg_provincia_leg 
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Rem_header SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Rem_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Rem_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Rem_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-13 RECT-14 RECT-15 RECT-16 Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Rem_header.nombre T-Rem_header.cuit ~
T-Rem_header.direccion T-Rem_header.cdg_postal T-Rem_header.localidad ~
T-Rem_header.cdg_provincia T-Rem_header.direccion_leg ~
T-Rem_header.cdg_postal_leg T-Rem_header.localidad_leg ~
T-Rem_header.cdg_provincia_leg 
&Scoped-define DISPLAYED-TABLES T-Rem_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Rem_header


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

DEFINE BUTTON b_blank 
     LABEL "Blank" 
     SIZE 10 BY 1.

DEFINE BUTTON b_DupDom 
     LABEL "Duplica" 
     SIZE 10 BY 1.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 4.05.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 4.29.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 2.86.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Rem_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     b_blank AT ROW 1.24 COL 58 WIDGET-ID 6
     T-Rem_header.nombre AT ROW 2.76 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cuit AT ROW 3.95 COL 15 COLON-ALIGNED FORMAT "x(14)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.direccion AT ROW 7 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cdg_postal AT ROW 8.14 COL 15 COLON-ALIGNED
          LABEL "C.Postal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.localidad AT ROW 8.14 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 25 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cdg_provincia AT ROW 9.33 COL 15 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     b_DupDom AT ROW 11.05 COL 57.4 WIDGET-ID 2
     T-Rem_header.direccion_leg AT ROW 12.76 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY 1 TOOLTIP "Si seda estos datos en blanco se duplicaran de los anteriores"
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cdg_postal_leg AT ROW 13.86 COL 15 COLON-ALIGNED
          LABEL "C. Postal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.localidad_leg AT ROW 13.86 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 25 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Rem_header.cdg_provincia_leg AT ROW 15.05 COL 15 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 16.95 COL 3
     Btn_Cancel AT ROW 16.95 COL 48
     "   Datos de nominación del comprobante" VIEW-AS TEXT
          SIZE 55 BY 1 AT ROW 1.29 COL 2
          BGCOLOR 5 FGCOLOR 15 
     "   Domicilio de venta del comprobante" VIEW-AS TEXT
          SIZE 66 BY 1 AT ROW 5.52 COL 2
          BGCOLOR 5 FGCOLOR 15 
     "   Domicilio legal del cliente" VIEW-AS TEXT
          SIZE 54 BY 1 AT ROW 11 COL 2 WIDGET-ID 4
          BGCOLOR 5 FGCOLOR 15 
     RECT-13 AT ROW 6.71 COL 2
     RECT-14 AT ROW 12.19 COL 2
     RECT-15 AT ROW 2.43 COL 2
     RECT-16 AT ROW 16.71 COL 2
     SPACE(1.39) SKIP(0.14)
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
      TABLE: T-Rem_header T "?" NO-UNDO sic Rem_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON Btn_OK IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON b_blank IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON b_DupDom IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.cdg_postal IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Rem_header.cdg_postal_leg IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX T-Rem_header.cdg_provincia IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX T-Rem_header.cdg_provincia_leg IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.cuit IN FRAME Dialog-Frame
   NO-ENABLE EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN T-Rem_header.direccion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.direccion_leg IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.localidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.localidad_leg IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Rem_header.nombre IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Rem_header"
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
            T-Rem_header.nombre
            T-Rem_header.cuit 

            T-Rem_header.direccion 
            T-Rem_header.localidad 
            T-Rem_header.cdg_postal
            T-Rem_header.cdg_provincia 

            T-Rem_header.direccion_leg 
            T-Rem_header.localidad_leg
            T-Rem_header.cdg_postal_leg
            T-Rem_header.cdg_provincia_leg.

        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_blank
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_blank Dialog-Frame
ON CHOOSE OF b_blank IN FRAME Dialog-Frame /* Blank */
DO:
      ASSIGN
      T-Rem_header.cdg_postal = ""
      T-Rem_header.cdg_provincia  = provincia.cdg_provincia
      T-Rem_header.cuit = ""
      T-Rem_header.direccion = "" 
      T-Rem_header.localidad = ""
      T-Rem_header.nombre = ""

      T-Rem_header.cdg_postal_leg = ""
      T-Rem_header.cdg_provincia_leg = provincia.cdg_provincia
      T-Rem_header.direccion_leg = ""
      T-Rem_header.localidad_leg = "".

      DISPLAY 
            T-Rem_header.cdg_postal
            T-Rem_header.cdg_provincia 
            T-Rem_header.cuit 
            T-Rem_header.direccion 
            T-Rem_header.localidad 
            T-Rem_header.nombre

            T-Rem_header.cdg_postal_leg
            T-Rem_header.cdg_provincia_leg 
            T-Rem_header.direccion_leg 
            T-Rem_header.localidad_leg 
            WITH FRAME {&FRAME-NAME}.      

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_DupDom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_DupDom Dialog-Frame
ON CHOOSE OF b_DupDom IN FRAME Dialog-Frame /* Duplica */
DO:
    ASSIGN
  t-rem_header.cdg_postal_leg:SCREEN-VALUE = t-rem_header.cdg_postal:SCREEN-VALUE 
  t-rem_header.cdg_provincia_leg:SCREEN-VALUE = t-rem_header.cdg_provincia:SCREEN-VALUE
  t-rem_header.direccion_leg:SCREEN-VALUE = t-rem_header.direccion:SCREEN-VALUE
  t-rem_header.localidad_leg:SCREEN-VALUE = t-rem_header.localidad:SCREEN-VALUE.

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
  {findempresa.i}
  RUN inicia_combos.

  FIND FIRST t-rem_header.
  FIND provincia WHERE empresa.provincia = sic.Provincia.nombre.
  IF p-modo-cabecera = MD_ALTA
  THEN do:
      ENABLE
        t-rem_header.cdg_postal
        t-rem_header.cdg_provincia 
        t-rem_header.cuit 
        t-rem_header.direccion 
        t-rem_header.localidad 
        t-rem_header.nombre

        t-rem_header.cdg_postal_leg
        t-rem_header.cdg_provincia_leg 
        t-rem_header.direccion_leg 
        t-rem_header.localidad_leg 
        Btn_OK
        b_dupdom
        b_blank
        WITH FRAME {&FRAME-NAME}.      
  END.


  DISPLAY 
        t-rem_header.cdg_postal
        t-rem_header.cdg_provincia 
        t-rem_header.cuit 
        t-rem_header.direccion 
        t-rem_header.localidad 
        t-rem_header.nombre

        t-rem_header.cdg_postal_leg
        t-rem_header.cdg_provincia_leg 
        t-rem_header.direccion_leg 
        t-rem_header.localidad_leg 
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
  IF AVAILABLE T-Rem_header THEN 
    DISPLAY T-Rem_header.nombre T-Rem_header.cuit T-Rem_header.direccion 
          T-Rem_header.cdg_postal T-Rem_header.localidad 
          T-Rem_header.cdg_provincia T-Rem_header.direccion_leg 
          T-Rem_header.cdg_postal_leg T-Rem_header.localidad_leg 
          T-Rem_header.cdg_provincia_leg 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-13 RECT-14 RECT-15 RECT-16 Btn_Cancel 
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
     T-Rem_header.cdg_provincia:LIST-ITEM-PAIRS = SUBSTRING(lista,2).
     T-Rem_header.cdg_provincia_leg:LIST-ITEM-PAIRS = SUBSTRING(lista,2).

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

   IF NOT CAN-FIND(Provincia WHERE Provincia.cdg_provincia = INPUT FRAME {&FRAME-NAME} T-Rem_header.cdg_provincia)
   THEN DO:
        RUN ponmensj.p ( INPUT "FACT009" ).
        RETURN.
   END.

  IF t-rem_header.cdg_postal_leg:SCREEN-VALUE = "" THEN t-rem_header.cdg_postal_leg:SCREEN-VALUE    = t-rem_header.cdg_postal:SCREEN-VALUE. 
  IF t-rem_header.cdg_provincia_leg:SCREEN-VALUE = "" THEN t-rem_header.cdg_provincia_leg:SCREEN-VALUE = t-rem_header.cdg_provincia:SCREEN-VALUE.
  IF t-rem_header.direccion_leg:SCREEN-VALUE = "" THEN t-rem_header.direccion_leg:SCREEN-VALUE     = t-rem_header.direccion:SCREEN-VALUE.
  IF t-rem_header.localidad_leg:SCREEN-VALUE = ""  THEN t-rem_header.localidad_leg:SCREEN-VALUE     = t-rem_header.localidad:SCREEN-VALUE.


   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

