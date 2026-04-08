&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
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

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Evento Cliente

/* Definitions for FRAME F-Main                                         */
&Scoped-define SELF-NAME F-Main
&Scoped-define OPEN-QUERY-F-Main ASSIGN p_nro_evento. OPEN QUERY {&SELF-NAME} FOR EACH Evento       WHERE evento.nro_evento = p_nro_evento IN FRAME {&FRAME-NAME} SHARE-LOCK, ~
             FIRST Cliente OF evento SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-F-Main Evento Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-F-Main Evento
&Scoped-define SECOND-TABLE-IN-QUERY-F-Main Cliente


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS p_nro_evento 
&Scoped-Define DISPLAYED-OBJECTS p_nro_evento 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_b-cliente_contacto AS HANDLE NO-UNDO.
DEFINE VARIABLE h_b-observacion-cli AS HANDLE NO-UNDO.
DEFINE VARIABLE h_folder AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-soloalta AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-solograba-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updsav AS HANDLE NO-UNDO.
DEFINE VARIABLE h_p-updspa AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-cliente_otros_datos AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-domicilio AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-evento AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-cliente_contacto AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente-2 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente-3 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_cliente-4 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-dsc_unico-domicilio AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-evento AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-observacion-cli AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-otros_datos1 AS HANDLE NO-UNDO.
DEFINE VARIABLE h_vo-eventos AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE p_nro_evento AS INTEGER FORMAT ">>>>>>>9" INITIAL 0 
     LABEL "Evento" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Evento a buscar".

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY F-Main FOR 
      Evento, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     p_nro_evento AT ROW 1.24 COL 9.2 COLON-ALIGNED WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 164 BY 28.67 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Design Page: 1
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Recepcion de Ordenes de Trabajo"
         HEIGHT             = 27.95
         WIDTH              = 148.8
         MAX-HEIGHT         = 29.52
         MAX-WIDTH          = 164
         VIRTUAL-HEIGHT     = 29.52
         VIRTUAL-WIDTH      = 164
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _START_FREEFORM
ASSIGN p_nro_evento.
OPEN QUERY {&SELF-NAME} FOR EACH Evento
      WHERE evento.nro_evento = p_nro_evento IN FRAME {&FRAME-NAME} SHARE-LOCK,
      FIRST Cliente OF evento SHARE-LOCK.
     _END_FREEFORM
     _TblOptList       = ","
     _Where[1]         = "evento.nro_evento = p_nro_evento"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Recepcion de Ordenes de Trabajo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Recepcion de Ordenes de Trabajo */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME F-Main
&Scoped-define SELF-NAME p_nro_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL p_nro_evento W-Win
ON LEAVE OF p_nro_evento IN FRAME F-Main /* Evento */
OR "RETURN" OF p_nro_evento
    OR "tab" OF p_nro_evento
DO:
 ASSIGN p_nro_evento.
 IF p_nro_evento <> 0 AND NOT DYNAMIC-FUNCTION("pevento" IN h_q-evento , p_nro_evento ) THEN DO:
     MESSAGE "Evento no registrado".
 END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
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
             INPUT  'adm/objects/folder.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'FOLDER-LABELS = ':U + 'Recepcion|Observacion|Contactos|Edilicio' + ',
                     FOLDER-TAB-TYPE = 1':U ,
             OUTPUT h_folder ).
       RUN set-position IN h_folder ( 2.43 , 2.00 ) NO-ERROR.
       RUN set-size IN h_folder ( 26.19 , 147.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-evento.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-evento ).
       RUN set-position IN h_q-evento ( 1.24 , 93.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 10.80 ) */

       /* Links to SmartFolder h_folder. */
       RUN add-link IN adm-broker-hdl ( h_folder , 'Page':U , THIS-PROCEDURE ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_folder ,
             p_nro_evento:HANDLE IN FRAME F-Main , 'AFTER':U ).
    END. /* Page 0 */
    WHEN 1 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente ).
       RUN set-position IN h_v-dsc_cliente ( 4.57 , 19.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-evento1.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-evento ).
       RUN set-position IN h_v-evento ( 6.48 , 9.00 ) NO-ERROR.
       /* Size in UIB:  ( 20.52 , 114.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-solograba.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-solograba-2 ).
       RUN set-position IN h_p-solograba-2 ( 6.48 , 126.00 ) NO-ERROR.
       RUN set-size IN h_p-solograba-2 ( 4.76 , 18.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'vo-eventos.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_vo-eventos ).
       RUN set-position IN h_vo-eventos ( 12.43 , 126.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.38 , 18.00 ) */

       /* Links to SmartViewer h_v-dsc_cliente. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-dsc_cliente ).

       /* Links to SmartViewer h_v-evento. */
       RUN add-link IN adm-broker-hdl ( h_p-solograba-2 , 'TableIO':U , h_v-evento ).
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-evento ).

       /* Links to SmartVortex h_vo-eventos. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_vo-eventos ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-evento ,
             h_v-dsc_cliente , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-solograba-2 ,
             h_v-evento , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_vo-eventos ,
             h_p-solograba-2 , 'AFTER':U ).
    END. /* Page 1 */
    WHEN 2 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  './fac/v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente-3 ).
       RUN set-position IN h_v-dsc_cliente-3 ( 4.10 , 16.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  './cxc/b-observacion-cli.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_b-observacion-cli ).
       RUN set-position IN h_b-observacion-cli ( 6.00 , 11.00 ) NO-ERROR.
       RUN set-size IN h_b-observacion-cli ( 9.67 , 131.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  './cxc/v-observacion-cli.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-observacion-cli ).
       RUN set-position IN h_v-observacion-cli ( 16.29 , 13.00 ) NO-ERROR.
       /* Size in UIB:  ( 7.38 , 125.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  './bas/p-soloalta.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloalta ).
       RUN set-position IN h_p-soloalta ( 24.48 , 28.60 ) NO-ERROR.
       RUN set-size IN h_p-soloalta ( 1.91 , 92.00 ) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_cliente-3. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-dsc_cliente-3 ).

       /* Links to SmartViewer h_v-observacion-cli. */
       RUN add-link IN adm-broker-hdl ( h_b-observacion-cli , 'Record':U , h_v-observacion-cli ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente-3 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-observacion-cli ,
             h_v-dsc_cliente-3 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-observacion-cli ,
             h_b-observacion-cli , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloalta ,
             h_v-observacion-cli , 'AFTER':U ).
    END. /* Page 2 */
    WHEN 3 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'fac/v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente-2 ).
       RUN set-position IN h_v-dsc_cliente-2 ( 4.10 , 11.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_unico-domicilio.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_unico-domicilio ).
       RUN set-position IN h_v-dsc_unico-domicilio ( 5.76 , 16.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.67 , 107.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  './fac/b-cliente_contacto.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ,
                     SortBy-Case = nombre':U ,
             OUTPUT h_b-cliente_contacto ).
       RUN set-position IN h_b-cliente_contacto ( 7.67 , 4.00 ) NO-ERROR.
       RUN set-size IN h_b-cliente_contacto ( 6.91 , 143.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  './fac/v-cliente_contacto.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-cliente_contacto ).
       RUN set-position IN h_v-cliente_contacto ( 14.81 , 10.00 ) NO-ERROR.
       /* Size in UIB:  ( 11.43 , 130.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Save,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updsav ).
       RUN set-position IN h_p-updsav ( 26.48 , 34.00 ) NO-ERROR.
       RUN set-size IN h_p-updsav ( 1.76 , 90.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-domicilio.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-domicilio ).
       RUN set-position IN h_q-domicilio ( 1.48 , 120.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 10.80 ) */

       /* Links to SmartViewer h_v-dsc_cliente-2. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-dsc_cliente-2 ).

       /* Links to SmartViewer h_v-dsc_unico-domicilio. */
       RUN add-link IN adm-broker-hdl ( h_q-domicilio , 'Record':U , h_v-dsc_unico-domicilio ).

       /* Links to SmartBrowser h_b-cliente_contacto. */
       RUN add-link IN adm-broker-hdl ( h_q-domicilio , 'Record':U , h_b-cliente_contacto ).

       /* Links to SmartViewer h_v-cliente_contacto. */
       RUN add-link IN adm-broker-hdl ( h_b-cliente_contacto , 'Record':U , h_v-cliente_contacto ).
       RUN add-link IN adm-broker-hdl ( h_p-updsav , 'TableIO':U , h_v-cliente_contacto ).

       /* Links to SmartQuery h_q-domicilio. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_q-domicilio ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente-2 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_unico-domicilio ,
             h_v-dsc_cliente-2 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_b-cliente_contacto ,
             h_v-dsc_unico-domicilio , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-cliente_contacto ,
             h_b-cliente_contacto , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updsav ,
             h_v-cliente_contacto , 'AFTER':U ).
    END. /* Page 3 */
    WHEN 4 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-dsc_cliente.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-dsc_cliente-4 ).
       RUN set-position IN h_v-dsc_cliente-4 ( 4.33 , 18.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.43 , 122.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-otros_datos1.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-otros_datos1 ).
       RUN set-position IN h_v-otros_datos1 ( 6.71 , 19.80 ) NO-ERROR.
       /* Size in UIB:  ( 17.86 , 114.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  './bas/p-updspa.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-updspa ).
       RUN set-position IN h_p-updspa ( 25.29 , 35.60 ) NO-ERROR.
       RUN set-size IN h_p-updspa ( 1.76 , 81.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-cliente_otros_datos.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-cliente_otros_datos ).
       RUN set-position IN h_q-cliente_otros_datos ( 1.48 , 121.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.86 , 10.80 ) */

       /* Initialize other pages that this page requires. */
       RUN init-pages IN THIS-PROCEDURE ('2':U) NO-ERROR.

       /* Links to SmartViewer h_v-dsc_cliente-4. */
       RUN add-link IN adm-broker-hdl ( h_p-soloalta , 'TableIO':U , h_v-dsc_cliente-4 ).
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_v-dsc_cliente-4 ).

       /* Links to SmartViewer h_v-otros_datos1. */
       RUN add-link IN adm-broker-hdl ( h_p-updspa , 'TableIO':U , h_v-otros_datos1 ).
       RUN add-link IN adm-broker-hdl ( h_q-cliente_otros_datos , 'Record':U , h_v-otros_datos1 ).

       /* Links to SmartQuery h_q-cliente_otros_datos. */
       RUN add-link IN adm-broker-hdl ( h_q-evento , 'Record':U , h_q-cliente_otros_datos ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-dsc_cliente-4 ,
             h_folder , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-otros_datos1 ,
             h_v-dsc_cliente-4 , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-updspa ,
             h_v-otros_datos1 , 'AFTER':U ).
    END. /* Page 4 */

  END CASE.
  /* Select a Startup page. */
  IF adm-current-page eq 0 
  THEN RUN select-page IN THIS-PROCEDURE ( 1 ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
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
  DISPLAY p_nro_evento 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE p_nro_evento 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Evento"}
  {src/adm/template/snd-list.i "Cliente"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.

    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).


    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
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

