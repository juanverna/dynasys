&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
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
DEFINE INPUT-OUTPUT PARAMETER ppcontrato LIKE contrato_hd.nro_contrato.
DEFINE INPUT PARAMETER pcliente LIKE cliente.nro_cliente.
/*DEFINE VAR ppcontrato LIKE contrato_hd.nro_contrato.
DEFINE VAR pcliente LIKE cliente.nro_cliente.
FIND FIRST cliente.
pcliente = cliente.nro_cliente.*/
FIND cliente WHERE cliente.nro_cliente = pcliente.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

&Scoped-define ADM-SUPPORTED-LINKS Record-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cliente

/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define QUERY-STRING-D-Dialog FOR EACH Cliente SHARE-LOCK
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Cliente SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Cliente


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD pcontrato D-Dialog 
FUNCTION pcontrato RETURNS INTEGER
  ( pc AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-detalle_contrato AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-solograba AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-cliente-contrato AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-contrato_consorcios AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-detalle_contrato1linea AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente AS HANDLE NO-UNDO.
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     SPACE(147.85) SKIP(23.96)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Crontrato-Presupuesto" WIDGET-ID 100.


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
   FRAME-NAME                                                           */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _TblList          = "sic.Cliente"
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Crontrato-Presupuesto */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  ppcontrato = DYNAMIC-FUNCTION("que_contrato" IN h_q-cliente-contrato ) .
  APPLY "END-ERROR":U TO SELF.
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
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente ).
       RUN set-position IN h_v-dsc_cliente ( 1.48 , 15.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-contrato_consorcios.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = ?':U ,
             OUTPUT h_v-contrato_consorcios ).
       RUN set-position IN h_v-contrato_consorcios ( 3.19 , 9.40 ) NO-ERROR.
       /* Size in UIB:  ( 10.95 , 125.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-solograba.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Save,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-solograba ).
       RUN set-position IN h_p-solograba ( 3.38 , 135.40 ) NO-ERROR.
       RUN set-size IN h_p-solograba ( 5.00 , 12.80 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-detalle_contrato.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-detalle_contrato ).
       RUN set-position IN h_b-detalle_contrato ( 14.57 , 2.00 ) NO-ERROR.
       RUN set-size IN h_b-detalle_contrato ( 10.00 , 31.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-detalle_contrato1linea.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-detalle_contrato1linea ).
       RUN set-position IN h_v-detalle_contrato1linea ( 14.57 , 33.80 ) NO-ERROR.
       /* Size in UIB:  ( 8.29 , 114.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa-2 ).
       RUN set-position IN h_p-updspa-2 ( 23.14 , 34.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa-2 ( 1.67 , 114.80 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-cliente-contrato.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-cliente-contrato ).
       RUN set-position IN h_q-cliente-contrato ( 1.24 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 10.80 ) */

       /* Links to SmartViewer h_v-dsc_cliente. */
       RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , 'Record':U , h_v-dsc_cliente ).

       /* Links to SmartViewer h_v-contrato_consorcios. */
       RUN add-link IN adm-broker-hdl ( h_p-solograba , 'TableIO':U , h_v-contrato_consorcios ).
       RUN add-link IN adm-broker-hdl ( h_q-cliente-contrato , 'Record':U , h_v-contrato_consorcios ).

       /* Links to SmartBrowser h_b-detalle_contrato. */
       RUN add-link IN adm-broker-hdl ( h_q-cliente-contrato , 'Record':U , h_b-detalle_contrato ).

       /* Links to SmartViewer h_v-detalle_contrato1linea. */
       RUN add-link IN adm-broker-hdl ( h_b-detalle_contrato , 'Record':U , h_v-detalle_contrato1linea ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa-2 , 'TableIO':U , h_v-detalle_contrato1linea ).

       /* Links to SmartQuery h_q-cliente-contrato. */
       RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , 'Record':U , h_q-cliente-contrato ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-contrato_consorcios ,
             h_v-dsc_cliente , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-solograba ,
             h_v-contrato_consorcios , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-detalle_contrato ,
             h_p-solograba , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-detalle_contrato1linea ,
             h_b-detalle_contrato , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa-2 ,
             h_v-detalle_contrato1linea , 'AFTER':U ).
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
  VIEW FRAME D-Dialog.
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
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
  /* Code placed here will execute AFTER standard behavior.    */
  ppcontrato = DYNAMIC-FUNCTION("pcontrato" IN  h_q-cliente-contrato, ppcontrato).
  IF ppcontrato <> ? THEN DO:
    FIND contrato_hd WHERE contrato_hd.nro_contrato = ppcontrato NO-LOCK NO-ERROR.
    IF AVAILABLE contrato_hd THEN DO:
        pcliente = contrato_hd.nro_cliente.
    END.
  END.
  IF ppcontrato = ? THEN RUN alta IN h_p-solograba.

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
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders D-Dialog 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.

   
    /*
    IF VALID-HANDLE(h_b-clientes)          THEN RUN set-sensitivo IN h_b-clientes          ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_b-bon_cliente)       THEN RUN set-sensitivo IN h_b-bon_cliente       ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-bon_xarticulo)     THEN RUN set-sensitivo IN h_b-bon_xarticulo     ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-cliente_condicion) THEN RUN set-sensitivo IN h_b-cliente_condicion ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-clientes)          THEN RUN set-sensitivo IN h_b-clientes          ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_b-domicilios)        THEN RUN set-sensitivo IN h_b-domicilios        ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updsav)            THEN RUN set-sensitivo IN h_p-updsav            ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_p-updspa)            THEN RUN set-sensitivo IN h_p-updspa            ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updspa-2)          THEN RUN set-sensitivo IN h_p-updspa-2          ( INPUT p-operacion = "HABILITAR" ). 
    IF VALID-HANDLE(h_p-updspa-3)          THEN RUN set-sensitivo IN h_p-updspa-3          ( INPUT p-operacion = "HABILITAR" ).
    IF VALID-HANDLE(h_p-updspa-4)          THEN RUN set-sensitivo IN h_p-updspa-4          ( INPUT p-operacion = "HABILITAR" ).
    */

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION pcontrato D-Dialog 
FUNCTION pcontrato RETURNS INTEGER
  ( pc AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  RETURN DYNAMIC-FUNCTION ( "pcontrato" IN h_q-cliente-contrato , pc ).
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

