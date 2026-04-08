&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE SHARED TEMP-TABLE T-Fac_detalle NO-UNDO LIKE sic.Fac_detalle.
DEFINE SHARED TEMP-TABLE T-Fac_header NO-UNDO LIKE sic.Fac_header.


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

DEFINE INPUT PARAMETER rid_detalle AS INTEGER.

DEFINE VARIABLE ult_partida AS ROWID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Fac_detalle Articulo Partida

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame Articulo.cdg_articulo ~
Articulo.descripcion Articulo.cdg_umed Partida.cdg_partida ~
Partida.descripcion Partida.fecha_vencimiento T-Fac_detalle.cantidad ~
T-Fac_detalle.granel T-Fac_detalle.precio T-Fac_detalle.precio_cf ~
T-Fac_detalle.subtotal_bruto T-Fac_detalle.subtotal_bruto_cf ~
T-Fac_detalle.subtotal_neto T-Fac_detalle.subtotal_neto_cf 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame Partida.cdg_partida ~
T-Fac_detalle.cantidad T-Fac_detalle.granel T-Fac_detalle.precio ~
T-Fac_detalle.precio_cf 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame Partida T-Fac_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame Partida
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle

&Scoped-define FIELD-PAIRS-IN-QUERY-Dialog-Frame~
 ~{&FP1}cdg_partida ~{&FP2}cdg_partida ~{&FP3}~
 ~{&FP1}cantidad ~{&FP2}cantidad ~{&FP3}~
 ~{&FP1}granel ~{&FP2}granel ~{&FP3}~
 ~{&FP1}precio ~{&FP2}precio ~{&FP3}~
 ~{&FP1}precio_cf ~{&FP2}precio_cf ~{&FP3}
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Fac_detalle SHARE-LOCK, ~
      EACH Articulo WHERE TRUE /* Join to T-Fac_detalle incomplete */ SHARE-LOCK, ~
      EACH Partida OF Articulo SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle Articulo Partida
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Partida.cdg_partida T-Fac_detalle.cantidad ~
T-Fac_detalle.granel T-Fac_detalle.precio T-Fac_detalle.precio_cf 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_partida ~{&FP2}cdg_partida ~{&FP3}~
 ~{&FP1}cantidad ~{&FP2}cantidad ~{&FP3}~
 ~{&FP1}granel ~{&FP2}granel ~{&FP3}~
 ~{&FP1}precio ~{&FP2}precio ~{&FP3}~
 ~{&FP1}precio_cf ~{&FP2}precio_cf ~{&FP3}
&Scoped-define ENABLED-TABLES Partida T-Fac_detalle
&Scoped-define FIRST-ENABLED-TABLE Partida
&Scoped-define SECOND-ENABLED-TABLE T-Fac_detalle
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS Articulo.cdg_articulo Articulo.descripcion ~
Articulo.cdg_umed Partida.cdg_partida Partida.descripcion ~
Partida.fecha_vencimiento T-Fac_detalle.cantidad T-Fac_detalle.granel ~
T-Fac_detalle.precio T-Fac_detalle.precio_cf T-Fac_detalle.subtotal_bruto ~
T-Fac_detalle.subtotal_bruto_cf T-Fac_detalle.subtotal_neto ~
T-Fac_detalle.subtotal_neto_cf 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.15
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Fac_detalle, 
      Articulo, 
      Partida SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     Articulo.cdg_articulo AT ROW 1.54 COL 13 COLON-ALIGNED
          LABEL "Artículo"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Articulo.descripcion AT ROW 1.54 COL 29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 41 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Articulo.cdg_umed AT ROW 1.54 COL 71 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Partida.cdg_partida AT ROW 2.62 COL 13 COLON-ALIGNED
          LABEL "Partida"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
     Partida.descripcion AT ROW 2.62 COL 29 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 41 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Partida.fecha_vencimiento AT ROW 2.62 COL 71 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR 7 FGCOLOR 15 
     T-Fac_detalle.cantidad AT ROW 3.69 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.granel AT ROW 3.69 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.precio AT ROW 4.77 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.precio_cf AT ROW 4.77 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_bruto AT ROW 5.85 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_bruto_cf AT ROW 5.85 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_neto AT ROW 6.92 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_neto_cf AT ROW 6.92 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 8.54 COL 2
     Btn_Cancel AT ROW 8.54 COL 73
     SPACE(1.56) SKIP(0.22)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE NO-VALIDATE THREE-D  SCROLLABLE 
         FONT 4
         TITLE "Indique precio de venta y cantidad"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Fac_detalle T "SHARED" NO-UNDO sic Fac_detalle
      TABLE: T-Fac_header T "SHARED" NO-UNDO sic Fac_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE.

/* SETTINGS FOR FILL-IN Articulo.cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Partida.cdg_partida IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Articulo.cdg_umed IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Articulo.descripcion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Partida.descripcion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Partida.fecha_vencimiento IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_bruto IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_bruto_cf IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_neto IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_neto_cf IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Fac_detalle,sic.Articulo WHERE Temp-Tables.T-Fac_detalle ...,sic.Partida OF sic.Articulo"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Indique precio de venta y cantidad */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME}
     T-Fac_detalle.cantidad 
     T-Fac_detalle.granel 
     T-Fac_detalle.precio 
     T-Fac_detalle.precio_cf.
  T-Fac_detalle.nro_partida = Partida.nro_partida.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Partida.cdg_partida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Partida.cdg_partida Dialog-Frame
ON MOUSE-MENU-DOWN OF Partida.cdg_partida IN FRAME Dialog-Frame /* Partida */
OR "." OF Partida.cdg_partida  IN FRAME {&FRAME-NAME}
DO:

  RUN SELPARTDEP.P ( INPUT ROWID(Articulo),
                     INPUT ROWID(Deposito),
                     OUTPUT ult_partida ).
  IF ult_partida <> ?
  THEN DO:
     FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
     DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     RETURN NO-APPLY.
  END.

/*--------------------------------------------------------------------------


ON F7 OF Partida.cdg_partida  IN FRAME {&FRAME-NAME}
DO:
  HIDE FRAME {&FRAME-NAME}.
  ult_partida = ?.
  RUN ACTPARTI.P (INPUT 1).
  RUN PONER_SESION.
  IF ult_partida <> ?
  THEN DO:
     ant_ROWID = ?.
     FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
     DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
  END.
  ELSE DO:
     VIEW FRAME {&FRAME-NAME}.
     APPLY "ENTRY" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.
END.

ON F8 OF Partida.cdg_partida  IN FRAME {&FRAME-NAME}
DO:
  IF NOT AVAILABLE Partida
  THEN DO:
     RUN PONMENSJ.P (INPUT "HELP001").
  END.
  ELSE DO:
     HIDE FRAME {&FRAME-NAME}.
     ult_partida = ROWID(Partida).
     RUN ACTPARTI.P (INPUT 2).
     RUN PONER_SESION.
     IF ult_partida <> ?
     THEN DO:
        ant_ROWID = ?.
        FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
        DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
        APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     END.
     ELSE DO:
        VIEW FRAME {&FRAME-NAME}.
        APPLY "ENTRY" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     END.
  END.
  RETURN NO-APPLY.
END.


--------------------------------------------------------------------------*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Partida.cdg_partida Dialog-Frame
ON RETURN OF Partida.cdg_partida IN FRAME Dialog-Frame /* Partida */
OR TAB OF Partida.cdg_partida  IN FRAME {&FRAME-NAME}
DO:

   FIND FIRST Partida NO-LOCK OF Articulo 
        WHERE Partida.cdg_empresa = Empresa.cdg_empresa
              USING Partida.cdg_partida NO-ERROR.

   IF NOT AVAILABLE Partida
   THEN DO:
      BELL.
      MESSAGE "El codigo de partida indicado no existe en la tabla maestra"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.
   ELSE DO:
      DISPLAY Partida.descripcion 
              Partida.fecha_vencimiento
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

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

FIND FIRST T-Fac_header.
FIND Deposito OF T-Fac_header NO-LOCK.

FIND T-Fac_detalle WHERE T-Fac_detalle.nro_linea = rid_detalle EXCLUSIVE-LOCK.
FIND Articulo OF T-Fac_detalle NO-LOCK.
IF Articulo.hay_partida 
   THEN FIND Partida OF T-Fac_detalle NO-LOCK NO-ERROR.
   ELSE FIND FIRST Partida OF Articulo NO-LOCK NO-ERROR.

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  DISPLAY 
     T-Fac_detalle.cantidad 
     T-Fac_detalle.granel 
     T-Fac_detalle.precio 
     T-Fac_detalle.precio_cf
     Partida.cdg_partida WHEN AVAILABLE Partida
     Partida.fecha_vencimiento WHEN AVAILABLE Partida
     WITH FRAME {&FRAME-NAME}.
     
  ASSIGN 
     Partida.cdg_partida:SENSITIVE IN FRAME {&FRAME-NAME} = Articulo.hay_partida   
     T-Fac_detalle.granel:SENSITIVE IN FRAME {&FRAME-NAME} = Articulo.a_granel   
     T-Fac_detalle.precio:SENSITIVE IN FRAME {&FRAME-NAME} = SUBSTRING(T-Fac_header.tip_comprob,2,1) = "A"
     T-Fac_detalle.precio_cf:SENSITIVE IN FRAME {&FRAME-NAME} = SUBSTRING(T-Fac_header.tip_comprob,2,1) <> "A".
  
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame _DEFAULT-ENABLE
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
  IF AVAILABLE Articulo THEN 
    DISPLAY Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Partida THEN 
    DISPLAY Partida.cdg_partida Partida.descripcion Partida.fecha_vencimiento 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Fac_detalle THEN 
    DISPLAY T-Fac_detalle.cantidad T-Fac_detalle.granel T-Fac_detalle.precio 
          T-Fac_detalle.precio_cf T-Fac_detalle.subtotal_bruto 
          T-Fac_detalle.subtotal_bruto_cf T-Fac_detalle.subtotal_neto 
          T-Fac_detalle.subtotal_neto_cf 
      WITH FRAME Dialog-Frame.
  ENABLE Partida.cdg_partida T-Fac_detalle.cantidad T-Fac_detalle.granel 
         T-Fac_detalle.precio T-Fac_detalle.precio_cf Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


