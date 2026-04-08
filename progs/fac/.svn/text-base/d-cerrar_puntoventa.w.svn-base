&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-3 v-punto-venta btn_cerrar ~
v-fecha_cierre Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-punto-venta v-nom_desde v-fecha_cierre 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_cerrar 
     LABEL "Cerrar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE v-fecha_cierre AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha de Cierre" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-nom_desde AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 5 FGCOLOR 15 FONT 5 NO-UNDO.

DEFINE VARIABLE v-punto-venta AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Centro Preferido" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 5 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 81 BY 4.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-punto-venta AT ROW 2.19 COL 19 COLON-ALIGNED
     v-nom_desde AT ROW 2.19 COL 28 COLON-ALIGNED NO-LABEL
     btn_cerrar AT ROW 2.19 COL 68
     v-fecha_cierre AT ROW 3.62 COL 19 COLON-ALIGNED
     Btn_Cancel AT ROW 3.67 COL 68
     RECT-3 AT ROW 1.52 COL 4
     SPACE(3.56) SKIP(0.46)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Cierre de Centros Emisores"
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
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-nom_desde IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Cierre de Centros Emisores */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cerrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cerrar Dialog-Frame
ON CHOOSE OF btn_cerrar IN FRAME Dialog-Frame /* Cerrar */
DO:
  DEFINE VARIABLE sino AS LOGICAL.

  sino = NO.
  MESSAGE "Desea cerrar el centro emisor actual?" 
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmacion" UPDATE sino.

  IF sino
  THEN DO:
      
      ASSIGN FRAME {&FRAME-NAME} v-Punto-venta v-fecha_cierre.
      
      FIND Punto-venta WHERE Punto-venta.cdg_puntovta = v-Punto-venta NO-LOCK NO-ERROR.
      IF NOT AVAILABLE Punto-venta
      THEN DO:
           RUN ponmensj.p ( "LPRE011").
           RETURN NO-APPLY.
      END.
      v-nom_desde = Punto-venta.dsc_puntovta.
      DISPLAY v-nom_desde 
              WITH FRAME {&FRAME-NAME}.

      IF v-fecha_cierre = DATE("")
      THEN DO:
          RUN ponmensj.p ( INPUT "LPRE008").
          RETURN NO-APPLY.
      END.

      IF v-fecha_cierre <= Punto-venta.fch_cierre
      THEN DO:
          RUN ponmensj.p ( INPUT "LPRE008").
          RETURN NO-APPLY.
      END.

      IF v-fecha_cierre > TODAY
      THEN DO:
          MESSAGE "La fecha de cierre indicada es posterior a la fecha del sistema. Desea proceder?" 
                  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmacion" UPDATE sino.
          IF NOT sino THEN RETURN NO-APPLY.
      END.

      DO TRANSACTION:

          RUN cerrar_puntoventa.p ( INPUT ROWID(Punto-venta), INPUT v-fecha_cierre ).
          RELEASE Punto-venta.

      END.

      MESSAGE "El cierre centros emisores ha culminado"
        VIEW-AS ALERT-BOX MESSAGE TITLE "Proceso Concluido".


      DISPLAY " " @ v-Punto-venta
              " " @ v-fecha_cierre
              " " @ v-nom_desde
              WITH FRAME {&FRAME-NAME}.
  
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-punto-venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-punto-venta Dialog-Frame
ON LEAVE OF v-punto-venta IN FRAME Dialog-Frame /* Centro Preferido */
DO:
    ASSIGN v-Punto-venta.
    FIND Punto-venta WHERE Punto-venta.cdg_puntovta = v-Punto-venta NO-LOCK NO-ERROR.
    IF AVAILABLE Punto-venta
    THEN DO:
        v-nom_desde = Punto-venta.dsc_puntovta.
        v-fecha_cierre = Punto-venta.fch_cierre + 1.
        DISPLAY v-nom_desde 
                v-fecha_cierre
                WITH FRAME {&FRAME-NAME}.
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
  que_empresa = Empresa.cdg_empresa.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cerrar_puntoventa Dialog-Frame 
PROCEDURE cerrar_puntoventa :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
  DEFINE BUFFER B-Articulo_precio FOR Articulo_precio.

  DO TRANSACTION:

     FIND Vigencia_precios WHERE Vigencia_precios.cdg_ptoventa = v-hasta_lista
                             AND Vigencia_precios.fch_desde = v-hasta_fecha
                                 EXCLUSIVE-LOCK NO-ERROR.
     IF NOT AVAILABLE Vigencia_precios
     THEN DO:
          CREATE Vigencia_precios.
          ASSIGN Vigencia_precios.cdg_ptoventa = v-hasta_lista
                 Vigencia_precios.fch_desde = v-hasta_fecha.
     END.

     FOR EACH Articulo_precio WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                                AND Articulo_precio.cdg_ptoventa   = v-Punto-venta
                                AND Articulo_precio.fch_desde   = v-fecha_cierre
                                    NO-LOCK:

         FIND B-Articulo_precio
              WHERE B-Articulo_precio.cdg_empresa  = v-has_empresa
                AND B-Articulo_precio.nro_articulo = Articulo_precio.nro_articulo
                AND B-Articulo_precio.cdg_ptoventa    = v-hasta_lista
                AND B-Articulo_precio.fch_desde    = v-hasta_fecha
                    EXCLUSIVE-LOCK NO-ERROR.
         IF NOT AVAILABLE B-Articulo_precio
         THEN DO:
              CREATE B-Articulo_precio.
              ASSIGN B-Articulo_precio.cdg_empresa  = v-has_empresa
                     B-Articulo_precio.nro_articulo = Articulo_precio.nro_articulo
                     B-Articulo_precio.cdg_ptoventa    = v-hasta_lista
                     B-Articulo_precio.fch_desde    = v-hasta_fecha.
         END.           
         ASSIGN
            B-Articulo_precio.precio    = Articulo_precio.precio
            B-Articulo_precio.precio_cf = Articulo_precio.precio_cf.
 
     END.

  END.
*/  

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
  DISPLAY v-punto-venta v-nom_desde v-fecha_cierre 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-3 v-punto-venta btn_cerrar v-fecha_cierre Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

