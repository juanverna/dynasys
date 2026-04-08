&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
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
DEFINE INPUT PARAMETER nro LIKE evento.nro_evento.
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
DEFINE TEMP-TABLE et
FIELD orden AS INT
FIELD clase AS CHAR LABEL "Clase"
FIELD tipo AS CHAR LABEL "Tipo" FORMAT "XX"
FIELD nro LIKE evento.nro_evento          
FIELD origen LIKE evento.origen
FIELD nro_identificacion LIKE evento.nro_identificacion
FIELD fasignado LIKE evento.fasignado
FIELD frealizado LIKE evento.frealizado
FIELD estado LIKE tarea.estado
INDEX orden orden.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog
&Scoped-define BROWSE-NAME BROWSE-3

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES et

/* Definitions for BROWSE BROWSE-3                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-3 orden clase tipo nro origen nro_identificacion fasignado frealizado estado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-3   
&Scoped-define SELF-NAME BROWSE-3
&Scoped-define QUERY-STRING-BROWSE-3 FOR EACH et
&Scoped-define OPEN-QUERY-BROWSE-3 OPEN QUERY {&SELF-NAME} FOR EACH et.
&Scoped-define TABLES-IN-QUERY-BROWSE-3 et
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-3 et


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-BROWSE-3}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-3 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-3 FOR 
      et SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-3 D-Dialog _FREEFORM
  QUERY BROWSE-3 DISPLAY
      orden
clase
tipo
nro
origen
nro_identificacion
fasignado
frealizado
estado
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 152 BY 8.33 ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     BROWSE-3 AT ROW 1 COL 1 WIDGET-ID 200
     SPACE(0.59) SKIP(0.28)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Traza de eventos LT" WIDGET-ID 100.


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
/* BROWSE-TAB BROWSE-3 1 D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-3
/* Query rebuild information for BROWSE BROWSE-3
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH et.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-3 */
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
ON WINDOW-CLOSE OF FRAME D-Dialog /* Traza de eventos LT */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-3
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crea_tabla D-Dialog 
PROCEDURE crea_tabla :
/*------------------------------------------------------------------------------
  Purpose: Crea tabla para la traza de eventos-tarea
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR i AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
EMPTY TEMP-TABLE et.
i=0.
FIND evento WHERE evento.nro_evento = nro.
FIND tarea WHERE tarea.cdg_tipotarea = "H" AND tarea.nro_identificacion = evento.nro_evento AND tarea.estado <> "D" NO-ERROR.
    IF AVAILABLE tarea THEN DO:
            CREATE et.
            ASSIGN et.orden = i
                   i = i + 1
                   et.clase = "TAREA"
                   et.tipo = tarea.cdg_tipotarea
                   et.nro = tarea.nro_tarea
                   et.origen = tarea.origen
                   et.nro_identificacion = tarea.nro_identificacion
                   et.fasignado = tarea.fecha_prevista
                   et.frealizado = tarea.fecha_resuelto
                   et.estado = tarea.estado.
            FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
            IF AVAILABLE bevento THEN do:
                FIND tipo_evento OF bevento no-lock.
                CREATE et.
                ASSIGN et.orden = i
                       i = i + 1
                       et.clase = "EVENTO"
                       et.tipo = tipo_evento.cdg_tipo_evento
                       et.nro = evento.nro_evento
                       et.origen = evento.origen
                       et.nro_identificacion = evento.nro_identificacion
                       et.fasignado = evento.fasignado
                       et.frealizado = evento.frealizado
                       et.estado = IF evento.anulado THEN "D" ELSE IF et.frealizado <> ? THEN "R" ELSE "".
                END.
    END.
    ELSE DO: /*camino largo*/
        IF AMBIGUOUS tarea THEN DO:
            CREATE et.
            ASSIGN et.orden = i
                   i = i + 1
                   et.clase = "TAREA"
                   et.tipo = "H"
                   et.nro = 0
                   et.origen = "DUPLICADA".
        END.
        ELSE do:
            FIND tarea WHERE tarea.cdg_tipotarea = "J" AND tarea.origen = "EVENTO" and tarea.nro_identificacion = evento.nro_evento AND tarea.estado <> "D" NO-ERROR.
            IF NOT AVAILABLE tarea THEN DO:
                IF AMBIGUOUS tarea THEN DO:
                    CREATE et.
                    ASSIGN et.orden = i
                           i = i + 1
                           et.clase = "TAREA"
                           et.tipo = "J"
                           et.nro = 0
                           et.origen = "DUPLICADA".
                END.
            END.
            ELSE do:
                CREATE et.
                ASSIGN et.orden = i
                       i = i + 1
                       et.clase = "TAREA"
                       et.tipo = tarea.cdg_tipotarea
                       et.nro = tarea.nro_tarea
                       et.origen = tarea.origen
                       et.nro_identificacion = tarea.nro_identificacion
                       et.fasignado = tarea.fecha_prevista
                       et.frealizado = tarea.fecha_resuelto
                       et.estado = tarea.estado.
                FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                IF AVAILABLE bevento THEN do:
                        FIND tipo_evento OF bevento no-lock.
                        CREATE et.
                        ASSIGN et.orden = i
                               i = i + 1
                               et.clase = "EVENTO"
                               et.tipo = tipo_evento.cdg_tipo_evento
                               et.nro = evento.nro_evento
                               et.origen = evento.origen
                               et.nro_identificacion = evento.nro_identificacion
                               et.fasignado = evento.fasignado
                               et.frealizado = evento.frealizado
                               et.estado = IF evento.anulado THEN "D" ELSE IF et.frealizado <> ? THEN "R" ELSE "".

                        IF tipo_evento.cdg_tipo_evento <> "EC" THEN DO:
                            FIND tarea WHERE tarea.cdg_tipotarea = "H" AND bevento.nro_evento = tarea.nro_identificacion AND tarea.estado <> "D" NO-ERROR.
                            IF AVAILABLE tarea THEN DO:
                                IF AMBIGUOUS tarea THEN DO:
                                    CREATE et.
                                    ASSIGN et.orden = i
                                           i = i + 1
                                           et.clase = "TAREA"
                                           et.tipo = "H"
                                           et.nro = 0
                                           et.origen = "DUPLICADA".
                                END.
                                ELSE do:
                                    CREATE et.
                                    ASSIGN et.orden = i
                                           i = i + 1
                                           et.clase = "TAREA"
                                           et.tipo = tarea.cdg_tipotarea
                                           et.nro = tarea.nro_tarea
                                           et.origen = tarea.origen
                                           et.nro_identificacion = tarea.nro_identificacion
                                           et.fasignado = tarea.fecha_prevista
                                           et.frealizado = tarea.fecha_resuelto
                                           et.estado = tarea.estado.
                                    FIND bevento WHERE bevento.nro_identificacion = tarea.nro_tarea AND bevento.origen = "TAREA" AND NOT bevento.anulado NO-ERROR.
                                    IF AVAILABLE bevento THEN do:
                                        FIND tipo_evento OF bevento no-lock.
                                        CREATE et.
                                        ASSIGN et.orden = i
                                               i = i + 1
                                               et.clase = "EVENTO"
                                               et.tipo = tipo_evento.cdg_tipo_evento
                                               et.nro = evento.nro_evento
                                               et.origen = evento.origen
                                               et.nro_identificacion = evento.nro_identificacion
                                               et.fasignado = evento.fasignado
                                               et.frealizado = evento.frealizado
                                               et.estado = IF evento.anulado THEN "D" ELSE IF et.frealizado <> ? THEN "R" ELSE "".
                                        END.
                                    END.
                                END.
                            END.
                        END.
                END.
              END.
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
  ENABLE BROWSE-3 
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

  /* Code placed here will execute PRIOR to standard behavior. */
  RUN crea_tabla.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "et"}

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

