&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
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
DEFINE VARIABLE         titulo_w      AS CHARACTER INITIAL "Selección de Ordenes de Pago Emitidas".
DEFINE VARIABLE         lista_estados AS CHARACTER INITIAL "E".
DEFINE VARIABLE         rid_remprov   AS ROWID.
&ELSE
DEFINE INPUT  PARAMETER titulo_w      AS CHARACTER.
DEFINE INPUT  PARAMETER lista_estados AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER rid_remprov   AS ROWID.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa      LIKE Empresa.cdg_empresa.
DEFINE VARIABLE fecha_inicial    AS DATE.
DEFINE VARIABLE fecha_elegida    AS DATE.
DEFINE VARIABLE que_moneda       LIKE Moneda.nro_moneda.
DEFINE VARIABLE que_proveedor    LIKE Proveedor.nro_proveedor.

DEFINE BUFFER B-Proveedor FOR Proveedor.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME D-Dialog
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rem_header_prv Proveedor Deposito

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 Rem_header_prv.tip_comprob Rem_header_prv.prf_comprob Rem_header_prv.nro_comprob Rem_header_prv.estado Rem_header_prv.fecha Deposito.cdg_deposito Proveedor.cdg_proveedor Proveedor.nombre   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define OPEN-QUERY-BROWSE-2    IF por_proveedor    THEN DO:       OPEN QUERY {&SELF-NAME}            FOR EACH Rem_header_prv                           WHERE Rem_header_prv.cdg_empresa = que_empresa                             AND (Rem_header_prv.tip_comprob = "RP" OR Rem_header_prv.tip_comprob = "RM")                             AND Rem_header_prv.nro_proveedor = que_proveedor                             AND Rem_header_prv.fecha >= v-des_fecha                             AND Rem_header_prv.fecha <= v-has_fecha                             AND LOOKUP(Rem_header_prv.estado, ~
      lista_estados) <> 0, ~
                                       FIRST Proveedor OF Rem_header_prv, ~
                                       FIRST Deposito OF Rem_header_prv.    END.    ELSE DO:       OPEN QUERY {&SELF-NAME}            FOR EACH Rem_header_prv                           WHERE Rem_header_prv.cdg_empresa = que_empresa                             AND (Rem_header_prv.tip_comprob = "RP" OR Rem_header_prv.tip_comprob = "RM")                             AND Rem_header_prv.fecha >= v-des_fecha                             AND Rem_header_prv.fecha <= v-has_fecha                             AND LOOKUP(Rem_header_prv.estado, ~
      lista_estados) <> 0, ~
                                       FIRST Proveedor OF Rem_header_prv                                       WHERE Proveedor.titular_oxp_sino = FALSE, ~
                                             FIRST Deposito OF Rem_header_prv.    END.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 Rem_header_prv Proveedor Deposito
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 Rem_header_prv
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 Proveedor
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-2 Deposito


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel v-has_fecha v-des_fecha ~
por_proveedor v-cdg_proveedor BROWSE-2 RECT-1 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS v-has_fecha v-des_fecha por_proveedor ~
v-cdg_proveedor v-nombre 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancelar" 
     SIZE 16 BY 1.67
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Elegir" 
     SIZE 16 BY 1.67
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(8)" 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 17 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-nombre AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE por_proveedor AS LOGICAL 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Si", yes,
"No", no
     SIZE 12 BY .62 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 101 BY 1.71.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 67 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      Rem_header_prv, 
      Proveedor, 
      Deposito SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 D-Dialog _FREEFORM
  QUERY BROWSE-2 DISPLAY
      Rem_header_prv.tip_comprob COLUMN-LABEL "Ti-!po"
      Rem_header_prv.prf_comprob COLUMN-LABEL "Pre-!fijo"
      Rem_header_prv.nro_comprob COLUMN-LABEL "Número!Compbte"
      Rem_header_prv.estado      COLUMN-LABEL "S!T"
      Rem_header_prv.fecha       COLUMN-LABEL "Fecha!Ingreso"
      Deposito.cdg_deposito      COLUMN-LABEL "Depó-!sito" 
      Proveedor.cdg_proveedor    COLUMN-LABEL "Código!Proveedor"
      Proveedor.nombre           COLUMN-LABEL "Razón!Social"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 101 BY 9.67 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     Btn_OK AT ROW 1.24 COL 70
     Btn_Cancel AT ROW 1.24 COL 87
     v-has_fecha AT ROW 1.48 COL 51 COLON-ALIGNED
     v-des_fecha AT ROW 1.52 COL 34 COLON-ALIGNED
     por_proveedor AT ROW 1.71 COL 18 NO-LABEL
     v-cdg_proveedor AT ROW 3.43 COL 13 COLON-ALIGNED
     v-nombre AT ROW 3.43 COL 32 COLON-ALIGNED NO-LABEL
     BROWSE-2 AT ROW 5.1 COL 2
     RECT-1 AT ROW 3.14 COL 2
     RECT-9 AT ROW 1.29 COL 2
     "Por Proveedor:" VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 1.71 COL 3
     SPACE(86.79) SKIP(12.66)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Seleccion de facturas de proveedor"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   NOT-VISIBLE                                                          */
/* BROWSE-TAB BROWSE-2 v-nombre D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-nombre IN FRAME D-Dialog
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
   IF por_proveedor
   THEN DO:
      OPEN QUERY {&SELF-NAME}
           FOR EACH Rem_header_prv
                          WHERE Rem_header_prv.cdg_empresa = que_empresa
                            AND (Rem_header_prv.tip_comprob = "RP" OR Rem_header_prv.tip_comprob = "RM")
                            AND Rem_header_prv.nro_proveedor = que_proveedor
                            AND Rem_header_prv.fecha >= v-des_fecha
                            AND Rem_header_prv.fecha <= v-has_fecha
                            AND LOOKUP(Rem_header_prv.estado,lista_estados) <> 0,
                                FIRST Proveedor OF Rem_header_prv,
                                FIRST Deposito OF Rem_header_prv.
   END.
   ELSE DO:
      OPEN QUERY {&SELF-NAME}
           FOR EACH Rem_header_prv
                          WHERE Rem_header_prv.cdg_empresa = que_empresa
                            AND (Rem_header_prv.tip_comprob = "RP" OR Rem_header_prv.tip_comprob = "RM")
                            AND Rem_header_prv.fecha >= v-des_fecha
                            AND Rem_header_prv.fecha <= v-has_fecha
                            AND LOOKUP(Rem_header_prv.estado,lista_estados) <> 0,
                                FIRST Proveedor OF Rem_header_prv
                                      WHERE Proveedor.titular_oxp_sino = FALSE,
                                      FIRST Deposito OF Rem_header_prv.
   END.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Seleccion de facturas de proveedor */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 D-Dialog
ON ROW-DISPLAY OF BROWSE-2 IN FRAME D-Dialog
DO:
    IF Rem_header_prv.anulado 
        THEN RUN poner_color ( INPUT 7, INPUT 15).
        ELSE RUN poner_color ( INPUT 9, INPUT 15).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel D-Dialog
ON CHOOSE OF Btn_Cancel IN FRAME D-Dialog /* Cancelar */
DO:
  rid_remprov = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* Elegir */
DO:
  rid_remprov = ROWID(Rem_header_prv).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME por_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL por_proveedor D-Dialog
ON VALUE-CHANGED OF por_proveedor IN FRAME D-Dialog
DO:
  ASSIGN por_proveedor.
  RUN color_codigo.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_proveedor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor D-Dialog
ON LEAVE OF v-cdg_proveedor IN FRAME D-Dialog /* Proveedor */
DO:
   APPLY "RETURN" TO SELF.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor D-Dialog
ON LEFT-MOUSE-DBLCLICK OF v-cdg_proveedor IN FRAME D-Dialog /* Proveedor */
OR "+" OF v-cdg_proveedor IN FRAME {&FRAME-NAME}
DO:
  
  DEFINE VARIABLE rid_proveedor AS ROWID.
  RUN selprove.p ( INPUT-OUTPUT rid_proveedor, INPUT YES).
  IF rid_proveedor <> ?
  THEN DO:
       FIND Proveedor WHERE ROWID(Proveedor) = rid_proveedor NO-LOCK.
       DISPLAY Proveedor.cdg_proveedor @ v-cdg_proveedor
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
       RETURN NO-APPLY.
  END.             
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor D-Dialog
ON MOUSE-MENU-DOWN OF v-cdg_proveedor IN FRAME D-Dialog /* Proveedor */
DO:
  APPLY "LEFT-MOUSE-DBLCLICK" TO v-cdg_proveedor IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_proveedor D-Dialog
ON RETURN OF v-cdg_proveedor IN FRAME D-Dialog /* Proveedor */
DO:

  FIND B-Proveedor WHERE B-Proveedor.cdg_proveedor = INPUT FRAME {&FRAME-NAME} v-cdg_proveedor NO-LOCK NO-ERROR.
  IF NOT AVAILABLE B-Proveedor 
  THEN DO:
       RUN PONMENSJ.P ( '1036' ).
       RETURN NO-APPLY.
  END.
  
  v-nombre = B-Proveedor.nombre.
  DISPLAY v-nombre 
          WITH FRAME {&FRAME-NAME}.     
  que_proveedor = B-Proveedor.nro_proveedor.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha D-Dialog
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME D-Dialog /* Del */
DO:

  fecha_inicial = DATE(v-des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha D-Dialog
ON RETURN OF v-des_fecha IN FRAME D-Dialog /* Del */
DO:
  ASSIGN v-des_fecha.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  /*
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha D-Dialog
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME D-Dialog /* al */
DO:

  fecha_inicial = DATE(v-has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha D-Dialog
ON RETURN OF v-has_fecha IN FRAME D-Dialog /* al */
DO:
  ASSIGN v-has_fecha.
  {&OPEN-QUERY-{&BROWSE-NAME}}
  /*
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE color_codigo D-Dialog 
PROCEDURE color_codigo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF por_proveedor
  THEN DO:
       v-cdg_proveedor:FGCOLOR  IN FRAME {&FRAME-NAME} = 9.
       v-cdg_proveedor:BGCOLOR  IN FRAME {&FRAME-NAME} = 11.
  END.
  ELSE DO:
       v-cdg_proveedor:FGCOLOR IN FRAME {&FRAME-NAME} = 15.
       v-cdg_proveedor:BGCOLOR IN FRAME {&FRAME-NAME} = 7.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
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
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
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
  DISPLAY v-has_fecha v-des_fecha por_proveedor v-cdg_proveedor v-nombre 
      WITH FRAME D-Dialog.
  ENABLE Btn_OK Btn_Cancel v-has_fecha v-des_fecha por_proveedor 
         v-cdg_proveedor BROWSE-2 RECT-1 RECT-9 
      WITH FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   v-has_fecha = TODAY.
   v-des_fecha = TODAY - 30.
   
   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.
   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DISPLAY
        v-des_fecha
        v-has_fecha
        WITH FRAME {&FRAME-NAME}.

   FRAME {&FRAME-NAME}:TITLE = titulo_w.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color D-Dialog 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-fg AS INTEGER.
  DEFINE INPUT PARAMETER p-bg AS INTEGER.

  ASSIGN 
      Rem_header_prv.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = p-fg
      Rem_header_prv.prf_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = p-fg
      Rem_header_prv.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = p-fg
      Rem_header_prv.estado:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fg
      Rem_header_prv.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fg
      Deposito.cdg_deposito:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fg
      Proveedor.cdg_proveedor:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fg
      Proveedor.nombre:FGCOLOR IN BROWSE {&BROWSE-NAME}           = p-fg


      Rem_header_prv.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = p-bg
      Rem_header_prv.prf_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = p-bg
      Rem_header_prv.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = p-bg
      Rem_header_prv.estado:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bg
      Rem_header_prv.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bg
      Deposito.cdg_deposito:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bg
      Proveedor.cdg_proveedor:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bg
      Proveedor.nombre:BGCOLOR IN BROWSE {&BROWSE-NAME}           = p-bg.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Rem_header_prv"}
  {src/adm/template/snd-list.i "Proveedor"}
  {src/adm/template/snd-list.i "Deposito"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

