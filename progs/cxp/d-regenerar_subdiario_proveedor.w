&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
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

   DEFINE TEMP-TABLE T-Fac_header_prv           NO-UNDO LIKE Fac_header_prv.
   DEFINE TEMP-TABLE T-Fac_detalle_prv          NO-UNDO LIKE Fac_detalle_prv.
   DEFINE TEMP-TABLE T-Sub_header_prv           NO-UNDO LIKE Sub_header_prv.
   DEFINE TEMP-TABLE T-Sub_detalle_prv          NO-UNDO LIKE Sub_detalle_prv.
   DEFINE TEMP-TABLE T-Fac_header_prv_bon       NO-UNDO LIKE Fac_header_prv_bon.
   DEFINE TEMP-TABLE T-Fac_detalle_prv_bon      NO-UNDO LIKE Fac_detalle_prv_bon.
   DEFINE TEMP-TABLE T-Fac_header_prv_impuesto  NO-UNDO LIKE Fac_header_prv_impuesto.
   DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto NO-UNDO LIKE Fac_detalle_prv_impuesto.
   DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
   DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
   DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.

   DEFINE VARIABLE v-cdg_empresa LIKE Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-cdg_proveedor v-tip_comprob v-prf_comprob ~
v-nro_comprob btn_hacer Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_proveedor v-tip_comprob ~
v-prf_comprob v-nro_comprob 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_hacer 
     LABEL "&Hacer" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)":U 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(256)":U 
     LABEL "Comprobante" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_proveedor AT ROW 1.24 COL 17 COLON-ALIGNED
     v-tip_comprob AT ROW 2.67 COL 17 COLON-ALIGNED
     v-prf_comprob AT ROW 2.67 COL 26 COLON-ALIGNED NO-LABEL
     v-nro_comprob AT ROW 2.67 COL 37 COLON-ALIGNED NO-LABEL
     btn_hacer AT ROW 4.33 COL 19
     Btn_Cancel AT ROW 4.33 COL 38
     SPACE(4.99) SKIP(0.71)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Regenerar Subdiario Proveedores"
         CANCEL-BUTTON Btn_Cancel.


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
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Regenerar Subdiario Proveedores */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_hacer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_hacer Dialog-Frame
ON CHOOSE OF btn_hacer IN FRAME Dialog-Frame /* Hacer */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-cdg_proveedor v-tip_comprob v-prf_comprob v-nro_comprob .
  FIND Proveedor WHERE Proveedor .cdg_proveedor = v-cdg_proveedor NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Proveedor
  THEN DO:
      MESSAGE "No existe el proveedor indicado" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.
  ELSE DO:
      FIND Fac_header_prv
          WHERE Fac_header_prv.cdg_empresa = v-cdg_empresa 
            AND Fac_header_prv.tip_comprob = v-tip_comprob
            AND Fac_header_prv.prf_comprob = v-prf_comprob
            AND Fac_header_prv.nro_comprob = v-nro_comprob
            AND Fac_header_prv.nro_proveedor = Proveedor.nro_proveedor
                NO-ERROR.
      IF NOT AVAILABLE Fac_header_prv
      THEN DO:
          MESSAGE "No existe el comprobante indicado" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-APPLY.
      END.
      ELSE DO:
          RUN rehacer_subdiario.
          MESSAGE "El subdiario ha sido reconstruido" VIEW-AS ALERT-BOX INFORMATION .
      END.
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

{findempresa.i}
v-cdg_empresa = Empresa.cdg_empresa.

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
  DISPLAY v-cdg_proveedor v-tip_comprob v-prf_comprob v-nro_comprob 
      WITH FRAME Dialog-Frame.
  ENABLE v-cdg_proveedor v-tip_comprob v-prf_comprob v-nro_comprob btn_hacer 
         Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE rehacer_subdiario Dialog-Frame 
PROCEDURE rehacer_subdiario :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE T-Fac_header_prv.
    EMPTY TEMP-TABLE T-Fac_detalle_prv.
    EMPTY TEMP-TABLE T-Sub_header_prv.
    EMPTY TEMP-TABLE T-Sub_detalle_prv.
    EMPTY TEMP-TABLE T-Fac_header_prv_bon.
    EMPTY TEMP-TABLE T-Fac_detalle_prv_bon.
    EMPTY TEMP-TABLE T-Fac_header_prv_impuesto.
    EMPTY TEMP-TABLE T-Fac_detalle_prv_impuesto.
    EMPTY TEMP-TABLE T-Asn_header.
    EMPTY TEMP-TABLE T-Asn_detalle.
    EMPTY TEMP-TABLE T-Asn_totales.

    DO TRANSACTION:

        CREATE T-Fac_header_prv.
        BUFFER-COPY Fac_header_prv TO T-Fac_header_prv.

        FOR EACH Fac_detalle_prv OF Fac_header_prv:
            CREATE T-Fac_detalle_prv.
            BUFFER-COPY Fac_detalle_prv TO T-Fac_detalle_prv.
        END.

        FOR EACH Fac_header_prv_bon OF Fac_header_prv:
            CREATE T-Fac_header_prv_bon.
            BUFFER-COPY Fac_header_prv_bon TO T-Fac_header_prv_bon.
        END.

        FOR EACH Fac_detalle_prv_bon OF Fac_header_prv:
            CREATE T-Fac_detalle_prv_bon.
            BUFFER-COPY Fac_detalle_prv_bon TO T-Fac_detalle_prv_bon.
        END.

        FOR EACH Fac_header_prv_impuesto OF Fac_header_prv:
            CREATE T-Fac_header_prv_impuesto.
            BUFFER-COPY Fac_header_prv_impuesto TO T-Fac_header_prv_impuesto.
        END.

        FOR EACH Fac_detalle_prv_impuesto OF Fac_header_prv:
            CREATE T-Fac_detalle_prv_impuesto.
            BUFFER-COPY Fac_detalle_prv_impuesto TO T-Fac_detalle_prv_impuesto.
        END.
    
        FOR EACH Sub_header_prv
              WHERE Sub_header_prv.cdg_empresa = Fac_header_prv.cdg_empresa 
                AND Sub_header_prv.tip_comprob = Fac_header_prv.tip_comprob
                AND Sub_header_prv.prf_comprob = Fac_header_prv.prf_comprob
                AND Sub_header_prv.nro_comprob = Fac_header_prv.nro_comprob
                AND Sub_header_prv.nro_proveedor = Fac_header_prv.nro_proveedor EXCLUSIVE-LOCK:

            FOR EACH Sub_detalle_prv OF Sub_header_prv:
                DELETE Sub_detalle_prv.
            END.

            DELETE Sub_header_prv.

        END.

        RUN calcular_comprobante_proveedor.p (
                         INPUT-OUTPUT TABLE T-Fac_header_prv,
                         INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                         INPUT-OUTPUT TABLE T-Sub_header_prv,
                         INPUT-OUTPUT TABLE T-Sub_detalle_prv,
                         INPUT-OUTPUT TABLE T-Fac_header_prv_bon,
                         INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,
                         INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto,
                         INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto,
                         INPUT-OUTPUT TABLE T-Asn_header,
                         INPUT-OUTPUT TABLE T-Asn_detalle,
                         INPUT-OUTPUT TABLE T-Asn_totales).

        FIND FIRST T-Sub_header_prv.
        CREATE Sub_header_prv.
        BUFFER-COPY T-Sub_header_prv TO Sub_header_prv.

        FOR EACH T-Sub_detalle_prv OF T-Sub_header_prv:
            CREATE Sub_detalle_prv.
            BUFFER-COPY T-Sub_detalle_prv TO Sub_detalle_prv.
        END.

        RELEASE Sub_header_prv.
        RELEASE Sub_detalle_prv.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

