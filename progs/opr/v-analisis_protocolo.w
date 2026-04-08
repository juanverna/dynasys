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
{extrae.i}
DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso 
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL".

{crystal_dyna.p}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartV8Viewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-2

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES evento_protocolo
&Scoped-define FIRST-EXTERNAL-TABLE evento_protocolo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR evento_protocolo.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES resultados

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 resultados.Determinacion resultados.valor1   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2 resultados.valor1   
&Scoped-define ENABLED-TABLES-IN-QUERY-BROWSE-2 resultados
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-BROWSE-2 resultados
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH resultados EXCLUSIVE-LOCK
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH resultados EXCLUSIVE-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 resultados
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 resultados


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS evento_protocolo.estado ~
evento_protocolo.nro_evento evento_protocolo.nro_protocolo ~
evento_protocolo.LetraPrefijo evento_protocolo.tipo_certif ~
evento_protocolo.nro_certificado evento_protocolo.Analizo ~
evento_protocolo.Laboratorio evento_protocolo.extrajo ~
evento_protocolo.fecha_analisis evento_protocolo.fecha_entrega ~
evento_protocolo.Fecha_toma 
&Scoped-define ENABLED-TABLES evento_protocolo
&Scoped-define FIRST-ENABLED-TABLE evento_protocolo
&Scoped-Define ENABLED-OBJECTS b_infoadic tnro_identificacion tsub_evento ~
BROWSE-2 
&Scoped-Define DISPLAYED-FIELDS evento_protocolo.estado ~
evento_protocolo.nro_evento evento_protocolo.nro_protocolo ~
evento_protocolo.LetraPrefijo evento_protocolo.tipo_certif ~
evento_protocolo.nro_certificado evento_protocolo.Analizo ~
evento_protocolo.Laboratorio evento_protocolo.extrajo ~
evento_protocolo.fecha_analisis evento_protocolo.fecha_entrega ~
evento_protocolo.Fecha_toma 
&Scoped-define DISPLAYED-TABLES evento_protocolo
&Scoped-define FIRST-DISPLAYED-TABLE evento_protocolo
&Scoped-Define DISPLAYED-OBJECTS tnro_identificacion tsub_evento 

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
DEFINE BUTTON b_infoadic 
     IMAGE-UP FILE "iconos16/box.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/box.jpg":U
     LABEL "Inf.Adicional" 
     SIZE 4 BY .95 TOOLTIP "Informacion adicional sobre el item".

DEFINE VARIABLE tnro_identificacion LIKE Evento.nro_identificacion
     LABEL "Identif." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE tsub_evento LIKE Evento.sub_evento
     LABEL "/" 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      resultados SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 V-table-Win _FREEFORM
  QUERY BROWSE-2 DISPLAY
      resultados.Determinacion FORMAT "X(60)"
      resultados.valor1 
  ENABLE
      resultados.valor1
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 119 BY 5.48 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     evento_protocolo.estado AT ROW 1 COL 9.2 COLON-ALIGNED NO-LABEL WIDGET-ID 24
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Sin Analizar","N",
                     "Anulado","A",
                     "Impreso","I",
                     "Procesado","P"
          DROP-DOWN-LIST
          SIZE 32 BY 1
     evento_protocolo.nro_evento AT ROW 1 COL 53.6 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN 
          SIZE 13.2 BY 1
     b_infoadic AT ROW 1 COL 73 RIGHT-ALIGNED WIDGET-ID 94
     evento_protocolo.nro_protocolo AT ROW 1 COL 82.4 COLON-ALIGNED WIDGET-ID 18
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     evento_protocolo.LetraPrefijo AT ROW 1 COL 105 COLON-ALIGNED WIDGET-ID 126
          LABEL "LP"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
     evento_protocolo.tipo_certif AT ROW 1 COL 125 COLON-ALIGNED WIDGET-ID 128
          LABEL "Tipo"
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
     evento_protocolo.nro_certificado AT ROW 1.91 COL 116.2 COLON-ALIGNED WIDGET-ID 124
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
     evento_protocolo.Analizo AT ROW 1.95 COL 9 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     evento_protocolo.Laboratorio AT ROW 1.95 COL 53.8 COLON-ALIGNED WIDGET-ID 22
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
     tnro_identificacion AT ROW 1.95 COL 82.4 COLON-ALIGNED HELP
          "" WIDGET-ID 120
          LABEL "Identif."
     tsub_evento AT ROW 1.95 COL 98.8 COLON-ALIGNED HELP
          "" WIDGET-ID 122
          LABEL "/"
     evento_protocolo.extrajo AT ROW 2.91 COL 9 COLON-ALIGNED WIDGET-ID 6
          LABEL "Extrajo"
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
     evento_protocolo.fecha_analisis AT ROW 2.91 COL 53.8 COLON-ALIGNED WIDGET-ID 8
          LABEL "F.Analisis"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     evento_protocolo.fecha_entrega AT ROW 2.91 COL 82.2 COLON-ALIGNED WIDGET-ID 10
          LABEL "F.Entrega"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     evento_protocolo.Fecha_toma AT ROW 2.91 COL 110 COLON-ALIGNED WIDGET-ID 12
          LABEL "F.Toma"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
     BROWSE-2 AT ROW 4.57 COL 5 WIDGET-ID 200
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
         HEIGHT             = 9.71
         WIDTH              = 132.4.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB BROWSE-2 Fecha_toma F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON b_infoadic IN FRAME F-Main
   ALIGN-R                                                              */
/* SETTINGS FOR FILL-IN evento_protocolo.extrajo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.fecha_analisis IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.fecha_entrega IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.Fecha_toma IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.LetraPrefijo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN evento_protocolo.tipo_certif IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN tnro_identificacion IN FRAME F-Main
   LIKE = sic.Evento.nro_identificacion EXP-LABEL EXP-SIZE              */
ASSIGN 
       tnro_identificacion:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN tsub_evento IN FRAME F-Main
   LIKE = sic.Evento.sub_evento EXP-LABEL EXP-SIZE                      */
ASSIGN 
       tsub_evento:READ-ONLY IN FRAME F-Main        = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH resultados EXCLUSIVE-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 V-table-Win
ON VALUE-CHANGED OF BROWSE-2 IN FRAME F-Main
DO:
    {src/adm/template/brschnge.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME b_infoadic
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_infoadic V-table-Win
ON CHOOSE OF b_infoadic IN FRAME F-Main /* Inf.Adicional */
DO:
  RUN d-contrato_restriccion.w ( INPUT evento.nro_identificacion).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
    FIND evento WHERE evento.nro_evento = evento_protocolo.nro_evento.
    evento.nro_certif = evento_protocolo.nro_certif.
    evento.letraprefijo = evento_protocolo.letraprefijo.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR retok AS LOGICAL.
  DEFINE VAR ldato AS LONGCHAR.
  browse-2:READ-ONLY IN FRAME {&FRAME-NAME}= TRUE.  
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
  browse-2:SENSITIVE IN FRAME {&FRAME-NAME}= FALSE.

  IF AVAILABLE evento_protocolo THEN DO:
      ldato = evento_protocolo.dato.
      IF ldato <> "" THEN DO:
          retOK = TEMP-TABLE resultados:READ-XML( "LONGCHAR" , 
                       ldato, 
                       "EMPTY", 
                       ?, 
                       ?, 
                       ?, 
                       ?).
          FIND FIRST resultados WHERE resultados.valor1 = "" NO-ERROR.
          IF AVAILABLE resultados THEN resultados.valor1 = string(RANDOM(5,20)).
          {&OPEN-QUERY-BROWSE-2}
          browse-2:READ-ONLY IN FRAME {&FRAME-NAME}= FALSE.          
      END.
  END.
  FIND evento OF evento_protocolo NO-LOCK.
  tsub_evento:SCREEN-VALUE = string(evento.sub_evento).
  tnro_identificacion:SCREEN-VALUE = string(evento.nro_identificacion).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR dd AS DATE.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .



  /* Code placed here will execute AFTER standard behavior.    */
/*   IF NOT browse-2:HIDDEN IN FRAME {&FRAME-NAME} THEN       */
/*           browse-2:SENSITIVE IN FRAME {&FRAME-NAME}= TRUE. */
  dd =  evento_protocolo.fecha_toma + 5.
    IF WEEKDAY( dd ) = 1 THEN 
        dd = dd + 1.
  evento_protocolo.fecha_analisis:SCREEN-VALUE IN FRAME {&FRAME-NAME}= string(IF evento_protocolo.fecha_analisis = ? THEN dd ELSE evento_protocolo.fecha_analisis).
  evento_protocolo.Analizo:SCREEN-VALUE = string(IF evento_protocolo.Analizo = "" THEN "FS" ELSE evento_protocolo.Analizo).
  evento_protocolo.estado:SCREEN-VALUE = "P".
  
BROWSE-2:SENSITIVE = TRUE.


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
  {src/adm/template/snd-list.i "resultados"}

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

