&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
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

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

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
{resultados.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartV8Viewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES evento_protocolo
&Scoped-define FIRST-EXTERNAL-TABLE evento_protocolo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR evento_protocolo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS evento_protocolo.Fecha_toma ~
evento_protocolo.Analizo evento_protocolo.nro_certificado ~
evento_protocolo.extrajo evento_protocolo.fecha_entrega 
&Scoped-define ENABLED-TABLES evento_protocolo
&Scoped-define FIRST-ENABLED-TABLE evento_protocolo
&Scoped-Define DISPLAYED-FIELDS evento_protocolo.estado ~
evento_protocolo.nro_evento evento_protocolo.nro_protocolo ~
evento_protocolo.Fecha_toma evento_protocolo.Analizo ~
evento_protocolo.Laboratorio evento_protocolo.nro_certificado ~
evento_protocolo.extrajo evento_protocolo.fecha_analisis ~
evento_protocolo.fecha_entrega 
&Scoped-define DISPLAYED-TABLES evento_protocolo
&Scoped-define FIRST-DISPLAYED-TABLE evento_protocolo


/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_evento|y|y|sic.evento_protocolo.nro_evento
nro_protocolo||y|sic.evento_protocolo.nro_protocolo
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_evento",
     Keys-Supplied = "nro_evento,nro_protocolo"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     evento_protocolo.estado AT ROW 1 COL 10 COLON-ALIGNED NO-LABEL WIDGET-ID 24
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Sin Analizar","N",
                     "Anulado","A",
                     "Impreso","I",
                     "Procesado","P"
          DROP-DOWN-LIST
          SIZE 32 BY 1
     evento_protocolo.nro_evento AT ROW 1 COL 61 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 13.2 BY 1
     evento_protocolo.nro_protocolo AT ROW 1 COL 85 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     evento_protocolo.Fecha_toma AT ROW 1 COL 111 COLON-ALIGNED WIDGET-ID 12
          LABEL "F.Toma"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     evento_protocolo.Analizo AT ROW 1.95 COL 10 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     evento_protocolo.Laboratorio AT ROW 1.95 COL 61 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     evento_protocolo.nro_certificado AT ROW 1.95 COL 87 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
     evento_protocolo.extrajo AT ROW 2.91 COL 10 COLON-ALIGNED WIDGET-ID 6
          LABEL "Extrajo"
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     evento_protocolo.fecha_analisis AT ROW 2.91 COL 61 COLON-ALIGNED WIDGET-ID 8
          LABEL "F.Analisis"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     evento_protocolo.fecha_entrega AT ROW 2.91 COL 89 COLON-ALIGNED WIDGET-ID 10
          LABEL "F.Entrega"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartV8Viewer
   External Tables: sic.evento_protocolo
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: External-Tables
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 3.33
         WIDTH              = 128.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       evento_protocolo.Analizo:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR COMBO-BOX evento_protocolo.estado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.extrajo IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       evento_protocolo.extrajo:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN evento_protocolo.fecha_analisis IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
ASSIGN 
       evento_protocolo.fecha_analisis:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN evento_protocolo.fecha_entrega IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.Fecha_toma IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.Laboratorio IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       evento_protocolo.Laboratorio:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN evento_protocolo.nro_evento IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       evento_protocolo.nro_evento:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN evento_protocolo.nro_protocolo IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       evento_protocolo.nro_protocolo:READ-ONLY IN FRAME F-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME evento_protocolo.fecha_analisis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL evento_protocolo.fecha_analisis V-table-Win
ON MOUSE-MENU-CLICK OF evento_protocolo.fecha_analisis IN FRAME F-Main /* F.Analisis */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME evento_protocolo.fecha_entrega
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL evento_protocolo.fecha_entrega V-table-Win
ON MOUSE-MENU-CLICK OF evento_protocolo.fecha_entrega IN FRAME F-Main /* F.Entrega */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME evento_protocolo.Fecha_toma
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL evento_protocolo.Fecha_toma V-table-Win
ON MOUSE-MENU-CLICK OF evento_protocolo.Fecha_toma IN FRAME F-Main /* F.Toma */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEF VAR key-value AS CHAR NO-UNDO.
  DEF VAR row-avail-enabled AS LOGICAL NO-UNDO.

  /* LOCK status on the find depends on FIELDS-ENABLED. */
  RUN get-attribute ('FIELDS-ENABLED':U).
  row-avail-enabled = (RETURN-VALUE eq 'yes':U).
  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'nro_evento':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = evento_protocolo
           &WHERE = "WHERE evento_protocolo.nro_evento eq INTEGER(key-value)"
       }
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "evento_protocolo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "evento_protocolo"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR ldato AS LONGCHAR.
DEFINE VAR retok AS LOGICAL.
IF evento_protocolo.analizo:MODIFIED IN FRAME {&FRAME-NAME} OR evento_protocolo.fecha_analisis:MODIFIED OR evento_protocolo.estado:MODIFIED THEN DO:
    IF evento_protocolo.analizo:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""  THEN
    DO:
        MESSAGE "Complete datos de analizo" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
    IF evento_protocolo.fecha_analisis:INPUT-VALUE = ? THEN DO:
        MESSAGE "La fecha del analisis es invalida" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
END.

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  /*actualizar los resultados*/
    retOK = TEMP-TABLE resultados:WRITE-XML("longchar", 
                                    ldato,
                                    FALSE, 
                                    ?, 
                                    ?, 
                                    YES, 
                                    YES). 
    evento_protocolo.dato = ldato.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_evento" "evento_protocolo" "nro_evento"}
  {src/adm/template/sndkycas.i "nro_protocolo" "evento_protocolo" "nro_protocolo"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "evento_protocolo"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

