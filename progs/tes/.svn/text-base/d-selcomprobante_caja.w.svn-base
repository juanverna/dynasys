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
DEFINE VARIABLE         titulo_w      AS CHARACTER INITIAL "Selección de Facturas".
DEFINE VARIABLE         lista_estados AS CHARACTER INITIAL "E".
DEFINE VARIABLE         lista_tipos   AS CHARACTER INITIAL "CJ".
DEFINE VARIABLE         rid_factura   AS ROWID.
&ELSE
DEFINE INPUT  PARAMETER titulo_w      AS CHARACTER.
DEFINE INPUT  PARAMETER lista_estados AS CHARACTER.
DEFINE INPUT  PARAMETER lista_tipos   AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER rid_factura   AS ROWID.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa      LIKE Empresa.cdg_empresa.
DEFINE VARIABLE fecha_inicial    AS DATE.
DEFINE VARIABLE fecha_elegida    AS DATE.
DEFINE VARIABLE que_moneda       LIKE Moneda.nro_moneda.
DEFINE VARIABLE que_caja         LIKE Caja.cdg_caja.
DEFINE VARIABLE que_usuario      LIKE Usuario.cdg_usuario.

DEFINE BUFFER B-Caja FOR Caja.

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
&Scoped-define INTERNAL-TABLES Caj_header Caja

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 Caj_header.tip_comprob Caj_header.prf_comprob Caj_header.nro_comprob Caj_header.estado Caj_header.fecha Caj_header.importe Caja.cdg_caja Caja.nombre   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define OPEN-QUERY-BROWSE-2    IF por_caja    THEN DO:       OPEN QUERY {&SELF-NAME}            FOR EACH Caj_header                           WHERE Caj_header.cdg_empresa = que_empresa                             AND Caj_header.tip_comprob MATCHES lista_tipos                             AND Caj_header.cdg_caja = que_caja                             AND Caj_header.fecha >= v-des_fecha                             AND Caj_header.fecha <= v-has_fecha                             AND CAN-DO(lista_estados, ~
      Caj_header.estado), ~
                                       FIRST Caja OF Caj_header.    END.    ELSE DO:       OPEN QUERY {&SELF-NAME}            FOR EACH Caj_header                           WHERE Caj_header.cdg_empresa = que_empresa                             AND Caj_header.tip_comprob MATCHES lista_tipos                             AND Caj_header.fecha >= v-des_fecha                             AND Caj_header.fecha <= v-has_fecha                             AND CAN-DO(lista_estados, ~
      Caj_header.estado), ~
                                       FIRST Caja OF Caj_header                                       WHERE CAN-DO(Caja.lista_usuarios, ~
      que_usuario).    END.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 Caj_header Caja
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 Caj_header
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 Caja


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS por_caja v-des_fecha v-has_fecha Btn_OK ~
Btn_Cancel BROWSE-2 RECT-1 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS por_caja v-des_fecha v-has_fecha ~
v-cdg_caja v-dsc_caja 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancelar" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Elegir" 
     SIZE 15 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_caja AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Caja" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE por_caja AS LOGICAL 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Si", yes,
"No", no
     SIZE 14 BY .95 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 102 BY 1.71.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 102 BY 1.38.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      Caj_header, 
      Caja SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 D-Dialog _FREEFORM
  QUERY BROWSE-2 DISPLAY
      Caj_header.tip_comprob COLUMN-LABEL "Ti-!po"
      Caj_header.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999"
      Caj_header.nro_comprob COLUMN-LABEL "Número!Compbte" FORMAT "99999999"
      Caj_header.estado      COLUMN-LABEL "S!T"
      Caj_header.fecha       COLUMN-LABEL "Fecha!Emisión"
      Caj_header.importe     COLUMN-LABEL "Importe!Total"
      Caja.cdg_caja          COLUMN-LABEL "Código!Caja"
      Caja.nombre            COLUMN-LABEL "Denominación!Caja" FORMAT "X(35)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 101 BY 9.43 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     por_caja AT ROW 1.48 COL 14 NO-LABEL
     v-des_fecha AT ROW 1.48 COL 31 COLON-ALIGNED
     v-has_fecha AT ROW 1.48 COL 51 COLON-ALIGNED
     Btn_OK AT ROW 1.48 COL 70
     Btn_Cancel AT ROW 1.48 COL 87
     v-cdg_caja AT ROW 3.14 COL 12 COLON-ALIGNED
     v-dsc_caja AT ROW 3.14 COL 28 COLON-ALIGNED NO-LABEL
     BROWSE-2 AT ROW 5.05 COL 2
     RECT-1 AT ROW 2.86 COL 2
     RECT-9 AT ROW 1.29 COL 2
     "Por Caja:" VIEW-AS TEXT
          SIZE 10 BY .81 AT ROW 1.48 COL 4
     SPACE(92.42) SKIP(12.66)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Seleccion de comprobantes de clientes"
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
/* BROWSE-TAB BROWSE-2 v-dsc_caja D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_caja IN FRAME D-Dialog
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME D-Dialog
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
   IF por_caja
   THEN DO:
      OPEN QUERY {&SELF-NAME}
           FOR EACH Caj_header
                          WHERE Caj_header.cdg_empresa = que_empresa
                            AND Caj_header.tip_comprob MATCHES lista_tipos
                            AND Caj_header.cdg_caja = que_caja
                            AND Caj_header.fecha >= v-des_fecha
                            AND Caj_header.fecha <= v-has_fecha
                            AND CAN-DO(lista_estados,Caj_header.estado),
                                FIRST Caja OF Caj_header.
   END.
   ELSE DO:
      OPEN QUERY {&SELF-NAME}
           FOR EACH Caj_header
                          WHERE Caj_header.cdg_empresa = que_empresa
                            AND Caj_header.tip_comprob MATCHES lista_tipos
                            AND Caj_header.fecha >= v-des_fecha
                            AND Caj_header.fecha <= v-has_fecha
                            AND CAN-DO(lista_estados,Caj_header.estado),
                                FIRST Caja OF Caj_header
                                      WHERE CAN-DO(Caja.lista_usuarios,que_usuario).
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
ON WINDOW-CLOSE OF FRAME D-Dialog /* Seleccion de comprobantes de clientes */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 D-Dialog
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME D-Dialog
OR RETURN OF BROWSE-2 IN FRAME {&FRAME-NAME}
DO:
   IF AVAILABLE Caj_header
   THEN DO:
        APPLY "CHOOSE" TO Btn_OK IN FRAME {&FRAME-NAME}.
   END.
   ELSE DO:
        BELL.
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel D-Dialog
ON CHOOSE OF Btn_Cancel IN FRAME D-Dialog /* Cancelar */
DO:
  rid_factura = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* Elegir */
DO:
  rid_factura = ROWID(Caj_header).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME por_caja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL por_caja D-Dialog
ON VALUE-CHANGED OF por_caja IN FRAME D-Dialog
DO:
  ASSIGN por_caja.
  IF por_caja
  THEN DO:
      v-cdg_caja:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.
  ELSE DO:
      ASSIGN v-cdg_caja:SENSITIVE IN FRAME {&FRAME-NAME} = NO
             v-cdg_caja = 0
             v-dsc_caja = "".

      DISPLAY v-cdg_caja
              v-dsc_caja 
          WITH FRAME {&FRAME-NAME}.
  END.

  RUN color_codigo.
  {&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_caja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja D-Dialog
ON LEAVE OF v-cdg_caja IN FRAME D-Dialog /* Caja */
DO:
   APPLY "RETURN" TO SELF.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja D-Dialog
ON LEFT-MOUSE-DBLCLICK OF v-cdg_caja IN FRAME D-Dialog /* Caja */
OR "+" OF v-cdg_Caja IN FRAME {&FRAME-NAME}
OR "MOUSE-MENU-DOWN" OF v-cdg_Caja IN FRAME {&FRAME-NAME}
DO:
  
  DEFINE VARIABLE rid_Caja AS ROWID.
  RUN selncaja.p ( INPUT-OUTPUT rid_Caja, INPUT YES).
  IF rid_Caja <> ?
  THEN DO:
       FIND B-Caja WHERE ROWID(B-Caja) = rid_Caja NO-LOCK.
       DISPLAY B-Caja.cdg_Caja @ v-cdg_Caja
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
       RETURN NO-APPLY.
  END.             
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja D-Dialog
ON RETURN OF v-cdg_caja IN FRAME D-Dialog /* Caja */
DO:

  FIND B-Caja WHERE B-Caja.cdg_caja = INPUT FRAME {&FRAME-NAME} v-cdg_caja NO-LOCK NO-ERROR.
  IF NOT AVAILABLE B-Caja 
  THEN DO:
       RUN PONMENSJ.P ( INPUT "CLIE000" ).
       DISPLAY v-cdg_caja
           WITH FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.
  END.
  ELSE DO:
      IF NOT CAN-DO(B-Caja.lista_usuarios,Usuario.cdg_usuario)
      THEN DO:
          RUN ponmensj.p ( INPUT "CLIE028" ).
          DISPLAY v-cdg_caja
              WITH FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.
      END.
  END.
  
  v-dsc_caja = B-Caja.nombre.
  DISPLAY v-dsc_caja 
          WITH FRAME {&FRAME-NAME}.     
          
  que_caja = B-Caja.cdg_caja.
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

  IF por_caja
  THEN DO:
       v-cdg_caja:FGCOLOR  IN FRAME {&FRAME-NAME} = 9.
       v-cdg_caja:BGCOLOR  IN FRAME {&FRAME-NAME} = 11.
  END.
  ELSE DO:
       v-cdg_caja:FGCOLOR IN FRAME {&FRAME-NAME} = 15.
       v-cdg_caja:BGCOLOR IN FRAME {&FRAME-NAME} = 7.
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
  DISPLAY por_caja v-des_fecha v-has_fecha v-cdg_caja v-dsc_caja 
      WITH FRAME D-Dialog.
  ENABLE por_caja v-des_fecha v-has_fecha Btn_OK Btn_Cancel BROWSE-2 RECT-1 
         RECT-9 
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
   que_usuario = Usuario.cdg_usuario.
   
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
  {src/adm/template/snd-list.i "Caj_header"}
  {src/adm/template/snd-list.i "Caja"}

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

