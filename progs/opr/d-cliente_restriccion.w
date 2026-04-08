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

/* Local Variable Definitions ---                                       */

DEF VAR lista_restriciones AS CHARACTER NO-UNDO.
  /*
    DEFINE VAR t_nro_cliente LIKE cliente.nro_cliente NO-UNDO.
    t_nro_cliente = 974.
*/
    DEF INPUT PARAMETER p-nro_cliente LIKE cliente.nro_cliente NO-UNDO.

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
&Scoped-define QUERY-STRING-D-Dialog FOR EACH Cliente ~
      WHERE Cliente.nro_cliente = p-nro_cliente SHARE-LOCK
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Cliente ~
      WHERE Cliente.nro_cliente = p-nro_cliente SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 Btn_OK Btn_Cancel Btn_Help 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_lista_restriccion D-Dialog 
FUNCTION que_lista_restriccion RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-restcont AS HANDLE NO-UNDO.
DEFINE VARIABLE h_f-restric AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-id-cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-restcli1 AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 10 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Help 
     LABEL "&Help" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 10 BY 1.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 83 BY 11.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     Btn_OK AT ROW 1.24 COL 125
     Btn_Cancel AT ROW 2.43 COL 125
     Btn_Help AT ROW 4.52 COL 104.6
     RECT-2 AT ROW 8.19 COL 20 WIDGET-ID 2
     SPACE(33.19) SKIP(0.23)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Restricciones a los clientes"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


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
     _Where[1]         = "sic.Cliente.nro_cliente = p-nro_cliente"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Restricciones a los clientes */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Help D-Dialog
ON CHOOSE OF Btn_Help IN FRAME D-Dialog /* Help */
OR HELP OF FRAME {&FRAME-NAME}
DO: /* Call Help Function (or a simple message). */
MESSAGE "Help for File: {&FILE-NAME}":U VIEW-AS ALERT-BOX INFORMATION.
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
             OUTPUT h_v-id-cliente ).
       RUN set-position IN h_v-id-cliente ( 1.62 , 1.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-restcli1_cli.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Initial-Lock = NO-LOCK,
                     Hide-on-Init = no,
                     Disable-on-Init = no,
                     Layout = ,
                     Create-On-Add = No':U ,
             OUTPUT h_v-restcli1 ).
       RUN set-position IN h_v-restcli1 ( 4.62 , 21.00 ) NO-ERROR.
       /* Size in UIB:  ( 3.33 , 74.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'b-restcliente.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-restcont ).
       RUN set-position IN h_b-restcont ( 4.81 , 3.00 ) NO-ERROR.
       RUN set-size IN h_b-restcont ( 15.05 , 16.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa ).
       RUN set-position IN h_p-updspa ( 6.48 , 105.00 ) NO-ERROR.
       RUN set-size IN h_p-updspa ( 12.62 , 15.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'f-restric_cli.w':U ,
             INPUT  FRAME D-Dialog:HANDLE ,
             INPUT  'Layout = ,
                     Hide-on-Init = yes':U ,
             OUTPUT h_f-restric ).
       RUN set-position IN h_f-restric ( 8.67 , 22.00 ) NO-ERROR.
       /* Size in UIB:  ( 10.24 , 79.60 ) */

       /* Links to SmartViewer h_v-id-cliente. */
       RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , 'Record':U , h_v-id-cliente ).

       /* Links to SmartViewer h_v-restcli1. */
       RUN add-link IN adm-broker-hdl ( h_b-restcont , 'Record':U , h_v-restcli1 ).
       RUN add-link IN adm-broker-hdl ( h_p-updspa , 'TableIO':U , h_v-restcli1 ).

       /* Links to SmartBrowser h_b-restcont. */
       RUN add-link IN adm-broker-hdl ( THIS-PROCEDURE , 'Record':U , h_b-restcont ).

       /* Links to SmartFrame h_f-restric. */
       RUN add-link IN adm-broker-hdl ( h_v-restcli1 , 'Record':U , h_f-restric ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-id-cliente ,
             Btn_OK:HANDLE , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-restcli1 ,
             Btn_Help:HANDLE , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-restcont ,
             h_v-restcli1 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa ,
             h_b-restcont , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_f-restric ,
             h_p-updspa , 'AFTER':U ).
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
  ENABLE RECT-2 Btn_OK Btn_Cancel Btn_Help 
      WITH FRAME D-Dialog.
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
 /* DEF VAR i AS INT NO-UNDO.
  DEF VAR xx AS CHAR NO-UNDO.
  DEF VAR gr AS CHAR NO-UNDO.
  DEFINE BUFFER b FOR restriccion.
  /* Code placed here will execute PRIOR to standard behavior. */
    FIND cliente WHERE cliente.nro_cliente = p-nro_cliente NO-LOCK. 
    gr = "".
    FOR EACH  tipo_evento WHERE can-do("CO,EV,LT,RL,--",tipo_evento.cdg_tipo_evento) NO-LOCK: 
      FOR EACH restriccion WHERE restriccion.nro_tipo_evento = tipo_evento.nro_tipo_evento AND restriccion.tipo = "B" NO-LOCK.
        IF restriccion.etag <> "" THEN gr = gr + "," + restriccion.etag.
    END.
    END.
    xx="".
    FOR EACH  tipo_evento WHERE can-do("CO,EV,LT,RL,--",tipo_evento.cdg_tipo_evento) NO-LOCK: 
      FOR EACH restriccion WHERE restriccion.nro_tipo_evento = tipo_evento.nro_tipo_evento AND restriccion.tipo = "B" NO-LOCK.
      /*que no este repetida*/
      FIND FIRST cliente_restriccion WHERE
          cliente_restriccion.nro_restriccion = restriccion.nro_restriccion AND
          cliente_restriccion.nro_cliente = cliente.nro_cliente NO-LOCK NO-ERROR.
      IF AVAILABLE cliente_restriccion THEN NEXT.
      /*que no exista otra del mismo grupo exclusivo*/
      FIND b OF cliente_restriccion NO-LOCK NO-ERROR.
      IF AVAILABLE b THEN
          IF LOOKUP(b.etag,gr) <> 0 THEN NEXT.
      xx = xx + "," + restriccion.cdg_restriccion + "," + STRING(restriccion.nro_restriccion).
      END.
      IF xx = "" THEN xx=",Nada,0".
      lista_restriciones = substring(xx,2).
    END.
   */
 
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

RUN adm-row-available.

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
    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).

    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_lista_restriccion D-Dialog 
FUNCTION que_lista_restriccion RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR i AS INT NO-UNDO.
  DEF VAR xx AS CHAR NO-UNDO.
  DEF VAR gr AS CHAR NO-UNDO.
  DEFINE BUFFER b FOR restriccion.
  DEFINE BUFFER c FOR cliente_restriccion.
  lista_restriciones = "".
  /* Code placed here will execute PRIOR to standard behavior. */
    FIND cliente WHERE cliente.nro_cliente = p-nro_cliente NO-LOCK. 
    gr = "".
    xx = "".
    FOR EACH  c OF cliente NO-LOCK,b OF c: 
      xx = xx + "," + b.cdg_restriccion + "," + STRING(b.nro_restriccion).
      IF b.etag <> "" AND lookup( b.etag,gr) = 0 THEN gr = gr + "," + b.etag.
    END.
    gr = SUBSTRING(gr,2).
    FOR EACH  tipo_evento WHERE can-do("CO,EV,LT,RL,--",tipo_evento.cdg_tipo_evento) NO-LOCK: 
      FOR EACH b WHERE b.nro_tipo_evento = tipo_evento.nro_tipo_evento AND b.tipo = "B" NO-LOCK.
      /*que no este repetida*/
      IF LOOKUP(b.cdg_restriccion,xx) <> 0 THEN NEXT.
      IF LOOKUP(b.etag,gr) <> 0 THEN NEXT.
      xx = xx + "," + b.cdg_restriccion + "," + STRING(b.nro_restriccion).
      END.
      
      lista_restriciones = substring(xx,2).
    END.
IF xx = "" THEN xx=",Nada,0".
RETURN lista_restriciones.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

