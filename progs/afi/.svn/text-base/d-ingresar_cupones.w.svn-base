&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
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

/* Local Variable Definitions ---                                       */
{nrorelea.i}

&IF DEFINED(UIB_is_Running) NE 0
&THEN 
DEFINE VARIABLE rid_rendicion AS ROWID.
FIND FIRST Rendicion_hd WHERE Rendicion_hd.abierta NO-LOCK.
rid_rendicion = ROWID(Rendicion_hd).
               MESSAGE "Levanta Rendicion:" string(Rendicion_hd.nro_rendicion,">>>>9")
                     VIEW-AS ALERT-BOX MESSAGE TITLE "d-ingresar_cupones.w".

&ELSE
DEFINE INPUT PARAMETER rid_rendicion AS ROWID.
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME D-Dialog

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btn_cerrar Btn_Cancel RECT-3 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-comprobante_rendicion-ing AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-navico AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-rendicion_hd AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-rendicion-ingreso AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancelar" 
     SIZE 23 BY 1
     BGCOLOR 8 .

DEFINE BUTTON btn_cerrar 
     LABEL "&Cerrar Rendición" 
     SIZE 23 BY 1.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 2.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     btn_cerrar AT ROW 1.76 COL 97
     Btn_Cancel AT ROW 2.81 COL 97
     RECT-3 AT ROW 1.48 COL 96
     SPACE(1.99) SKIP(20.84)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         FONT 6
         TITLE "Ingreso de Cupones de Cobranza"
         CANCEL-BUTTON Btn_Cancel.


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
                                                                        */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Ingreso de Cupones de Cobranza */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  MESSAGE "Para salir oprima CERRAR RENDICION o bien CANCELAR" 
          VIEW-AS ALERT-BOX MESSAGE.
  /*APPLY "END-ERROR":U TO SELF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cerrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cerrar D-Dialog
ON CHOOSE OF btn_cerrar IN FRAME D-Dialog /* Cerrar Rendición */
DO:
  
  DEFINE VARIABLE sino AS LOGICAL.
  sino = NO.
  MESSAGE "Se dispone a cerrar la Rendición. Luego no podrán ingresarse mas recibos en la misma."
          "Confirma que desa cerrar esta rendición? " VIEW-AS ALERT-BOX 
          BUTTONS YES-NO SET sino.
  IF sino
  THEN DO:
       DO TRANSACTION:
  /*        RUN cierrarendicion.p ( INPUT rid_rendicion).*/

       END.   
      APPLY "END-ERROR":U TO SELF.
  END.          

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
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.

  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  ASSIGN adm-current-page = INTEGER(RETURN-VALUE).

  CASE adm-current-page: 

    WHEN 0 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-rendicion-ingreso.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rendicion-ingreso ).
       RUN set-position IN h_v-rendicion-ingreso ( 1.48 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.67 , 75.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'adm/objects/p-navico.r':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = NAV-ICON,
                     Right-to-Left = First-On-Left':U ,
             OUTPUT h_p-navico ).
       RUN set-position IN h_p-navico ( 1.48 , 77.00 ) NO-ERROR.
       RUN set-size IN h_p-navico ( 2.67 , 19.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-comprobante_rendicion-ing.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-comprobante_rendicion-ing ).
       RUN set-position IN h_b-comprobante_rendicion-ing ( 4.52 , 2.00 ) NO-ERROR.
       RUN set-size IN h_b-comprobante_rendicion-ing ( 16.95 , 119.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-rendicion_hd.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-rendicion_hd ).
       RUN set-position IN h_q-rendicion_hd ( 3.14 , 107.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.76 , 8.20 ) */

       /* Links to SmartViewer h_v-rendicion-ingreso. */
       RUN add-link IN adm-broker-hdl ( h_q-rendicion_hd , 'Record':U , h_v-rendicion-ingreso ).

       /* Links to SmartBrowser h_b-comprobante_rendicion-ing. */
       RUN add-link IN adm-broker-hdl ( h_q-rendicion_hd , 'Record':U , h_b-comprobante_rendicion-ing ).

       /* Links to SmartQuery h_q-rendicion_hd. */
       RUN add-link IN adm-broker-hdl ( h_p-navico , 'Navigation':U , h_q-rendicion_hd ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rendicion-ingreso ,
             btn_cerrar:HANDLE , 'BEFORE':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-navico ,
             h_v-rendicion-ingreso , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-comprobante_rendicion-ing ,
             Btn_Cancel:HANDLE , 'AFTER':U ).
    END. /* Page 0 */

  END CASE.

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
  ENABLE btn_cerrar Btn_Cancel RECT-3 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view D-Dialog 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  FIND Rendicion_hd WHERE ROWID(Rendicion_hd) = rid_rendicion NO-LOCK.
  
               MESSAGE "Levanta Rendicion:" string(Rendicion_hd.nro_rendicion,">>>>9")
                     VIEW-AS ALERT-BOX MESSAGE TITLE "d-ingresar_cupones.w".

  
  FIND Empresa OF Rendicion_hd NO-LOCK.
  {&WINDOW-NAME}:TITLE = "SIC/AFI " + NRO_RELEASE + " Ingreso de Cupones:" +
                         Rendicion_hd.cdg_empresa + Rendicion_hd.tipo.

  RUN posicionar_query IN h_q-rendicion_hd (INPUT rid_rendicion).

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

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartDialog, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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

