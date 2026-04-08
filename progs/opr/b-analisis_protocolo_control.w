&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
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

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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
DEFINE BUFFER administrador FOR cliente.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES evento_protocolo Evento Cliente ~
administrador

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table evento_protocolo.estado evento_protocolo.laboratorio evento_protocolo.Fecha_analisis evento_protocolo.Fecha_entrega Evento.FRealizado evento_protocolo.nro_certificado evento_protocolo.letraprefijo evento_protocolo.nro_protocolo Cliente.nom_cliente Cliente.direccion evento.recursos evento_protocolo.nro_evento administrador.cdg_cliente administrador.nom_cliente   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table /*OPEN QUERY {&SELF-NAME} FOR EACH evento_protocolo  , ~
       FIRST Evento OF evento_protocolo NO-LOCK, ~
             FIRST Cliente OF Evento , ~
       first administrador of cliente  NO-LOCK BY evento.frealizado DESC     ~{&SORTBY-PHRASE}.*/ APPLY "return" TO que_nombre IN FRAME {&FRAME-NAME}.
&Scoped-define TABLES-IN-QUERY-br_table evento_protocolo Evento Cliente ~
administrador
&Scoped-define FIRST-TABLE-IN-QUERY-br_table evento_protocolo
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Evento
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Cliente
&Scoped-define FOURTH-TABLE-IN-QUERY-br_table administrador


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-2 Cestado que_nombre Buscar Relegir ~
br_table 
&Scoped-Define DISPLAYED-OBJECTS Cestado que_nombre tcertif Relegir 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS></FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = ':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Buscar 
     LABEL "Buscar" 
     SIZE 10 BY 1.

DEFINE BUTTON BUTTON-2 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/excel.gif":U
     LABEL "Button 2" 
     SIZE 6 BY 1.14.

DEFINE VARIABLE Cestado AS CHARACTER FORMAT "X(256)":U INITIAL "P" 
     LABEL "Est." 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "P","I","N","*" 
     DROP-DOWN-LIST
     SIZE 8 BY 1 NO-UNDO.

DEFINE VARIABLE tcertif AS CHARACTER FORMAT "X(256)":U INITIAL "L" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "LT" 
     DROP-DOWN-LIST
     SIZE 8 BY 1 TOOLTIP "Tipo de certificado" NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY 1 NO-UNDO.

DEFINE VARIABLE Relegir AS CHARACTER INITIAL "1" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Consorcio", "1",
"Administ.", "2",
"Codigo", "3",
"Contrato", "4",
"Evento", "5"
     SIZE 62.6 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      evento_protocolo, 
      Evento, 
      Cliente, 
      administrador SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      evento_protocolo.estado FORMAT "x":U COLUMN-LABEL "ES"
      evento_protocolo.laboratorio FORMAT "9" COLUMN-LABEL "LA"
      evento_protocolo.Fecha_analisis FORMAT "99/99/9999":U COLUMN-LABEL "Analisis"
      evento_protocolo.Fecha_entrega FORMAT "99/99/9999":U COLUMN-LABEL "Entregado"
      Evento.FRealizado FORMAT "99/99/9999":U COLUMN-LABEL "Realizado"
      evento_protocolo.nro_certificado
      evento_protocolo.letraprefijo
      evento_protocolo.nro_protocolo
      Cliente.nom_cliente FORMAT "X(40)":U
      Cliente.direccion FORMAT "X(45)":U
      evento.recursos
      evento_protocolo.nro_evento
      administrador.cdg_cliente COLUMN-LABEL "Admin" 
      administrador.nom_cliente FORMAT "X(40)":U COLUMN-LABEL "Administrador Nombre"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 153 BY 9.52 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-2 AT ROW 1.14 COL 133.2 WIDGET-ID 16
     Cestado AT ROW 1.19 COL 143.8 COLON-ALIGNED WIDGET-ID 14
     que_nombre AT ROW 1.24 COL 2 NO-LABEL WIDGET-ID 12
     Buscar AT ROW 1.24 COL 47 WIDGET-ID 4
     tcertif AT ROW 1.24 COL 56.8 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     Relegir AT ROW 1.24 COL 68.4 NO-LABEL WIDGET-ID 6
     br_table AT ROW 2.43 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 10.95
         WIDTH              = 154.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table Relegir F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN que_nombre IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR COMBO-BOX tcertif IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM
/*OPEN QUERY {&SELF-NAME} FOR EACH evento_protocolo  , FIRST Evento OF evento_protocolo NO-LOCK,
      FIRST Cliente OF Evento , first administrador of cliente  NO-LOCK BY evento.frealizado DESC
    ~{&SORTBY-PHRASE}.*/
APPLY "return" TO que_nombre IN FRAME {&FRAME-NAME}.
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Buscar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Buscar B-table-Win
ON CHOOSE OF Buscar IN FRAME F-Main /* Buscar */
DO:
  APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 B-table-Win
ON CHOOSE OF BUTTON-2 IN FRAME F-Main /* Button 2 */
DO:
  run excel-export ( {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME} ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cestado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cestado B-table-Win
ON VALUE-CHANGED OF Cestado IN FRAME F-Main /* Est. */
DO:
  APPLY "return" TO que_nombre IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre B-table-Win
ON Return OF que_nombre IN FRAME F-Main
DO:
    ASSIGN FRAME {&FRAME-NAME} tcertif .
    IF tcertif = "LT" THEN RUN conevprot.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Relegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Relegir B-table-Win
ON VALUE-CHANGED OF Relegir IN FRAME F-Main
DO:
  APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tcertif
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tcertif B-table-Win
ON VALUE-CHANGED OF tcertif IN FRAME F-Main
DO:
    APPLY "return" TO que_nombre.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE conevPROT B-table-Win 
PROCEDURE conevPROT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEF VAR rr AS HANDLE.
    DEF VAR rowcli AS rowid NO-UNDO.
    DEF VAR nrolimpieza LIKE tipo_evento.nro_tipo_evento NO-UNDO.
    FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = tcertif NO-LOCK.
    nrolimpieza = tipo_evento.nro_tipo_evento.

    ASSIGN FRAME {&FRAME-NAME} que_nombre relegir cestado .
    IF relegir = "4" THEN DO:
        FIND contrato_hd WHERE contrato_hd.nro_contrato = INT(que_nombre) NO-ERROR.
        FIND cliente OF contrato_hd NO-ERROR.
        rowcli = IF AVAILABLE cliente THEN ROWID(cliente) ELSE ?.
    END.
    IF relegir = "5" THEN DO:
        FIND evento WHERE evento.nro_evento = INT(que_nombre) NO-ERROR.
        FIND cliente OF evento NO-ERROR.
        rowcli = IF AVAILABLE cliente THEN ROWID(cliente) ELSE ?.
    END.
    
    IF que_nombre <> "" THEN DO:
        IF Relegir = "1" THEN
              OPEN QUERY  {&BROWSE-NAME}  FOR EACH evento_protocolo,first evento OF evento_protocolo WHERE evento.nro_tipo_evento = nrolimpieza AND CAN-DO(cestado,evento_protocolo.estado), FIRST cliente OF evento WHERE
              Cliente.cdg_cliente BEGINS "C"  AND 
              cliente.direccion CONTAINS que_nombre NO-LOCK,
              FIRST Administrador WHERE
              Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
              BY evento.frealizado DESC BY Cliente.nom_cliente.
        ELSE IF Relegir = "2" THEN
            OPEN QUERY {&BROWSE-NAME}  FOR EACH evento_protocolo ,first evento OF evento_protocolo WHERE evento.nro_tipo_evento = nrolimpieza AND CAN-DO(cestado,evento_protocolo.estado) , FIRST cliente OF evento   WHERE
                Cliente.cdg_cliente BEGINS "C"  NO-LOCK,
              FIRST Administrador WHERE
              Administrador.nro_cliente = Cliente.nro_administrador and
                administrador.nom_cliente CONTAINS que_nombre NO-LOCK
              BY evento.frealizado DESC BY Administrador.nom_cliente.
        ELSE IF Relegir = "3" THEN
            OPEN QUERY {&BROWSE-NAME}  FOR EACH evento_protocolo ,first evento OF evento_protocolo WHERE evento.nro_tipo_evento = nrolimpieza AND CAN-DO(cestado,evento_protocolo.estado), FIRST cliente OF evento WHERE
                Cliente.cdg_cliente BEGINS que_nombre  NO-LOCK,
                FIRST Administrador WHERE
              Administrador.nro_cliente = Cliente.nro_administrador
              BY evento.frealizado DESC BY cliente.cdg_cliente .
        ELSE
            OPEN QUERY {&BROWSE-NAME}  FOR EACH evento_protocolo ,first evento OF evento_protocolo WHERE evento.nro_tipo_evento = nrolimpieza AND CAN-DO(cestado,evento_protocolo.estado), FIRST cliente OF evento  NO-LOCK WHERE
                Cliente.cdg_cliente BEGINS "C"  AND  ROWID(cliente) = rowcli,
                FIRST Administrador WHERE
              Administrador.nro_cliente = Cliente.nro_administrador
              BY evento.frealizado DESC BY cliente.cdg_cliente.
    
        RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
    END.
    ELSE DO:
            que_nombre:screen-VALUE IN FRAME {&FRAME-NAME} = "".
            IF Relegir = "1" THEN
                OPEN QUERY  {&BROWSE-NAME}  FOR EACH evento_protocolo ,first evento OF evento_protocolo WHERE evento.nro_tipo_evento = nrolimpieza AND CAN-DO(cestado,evento_protocolo.estado), FIRST cliente OF evento NO-LOCK WHERE
                  Cliente.cdg_cliente BEGINS "C" ,
                  FIRST Administrador WHERE
                  Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
                  BY evento.frealizado DESC.
            ELSE
                OPEN QUERY {&BROWSE-NAME}  FOR EACH evento_protocolo ,first evento OF evento_protocolo WHERE evento.nro_tipo_evento = nrolimpieza AND CAN-DO(cestado,evento_protocolo.estado), FIRST cliente OF evento NO-LOCK  WHERE
                    Cliente.cdg_cliente BEGINS "C" ,
                  FIRST Administrador WHERE
                  Administrador.nro_cliente = Cliente.nro_administrador NO-LOCK
                  BY evento.frealizado DESC BY Administrador.nom_cliente .
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
cestado = "P".
tcertif = "LT".
DISPLAY cestado tcertif WITH FRAME {&FRAME-NAME}.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* There are no foreign keys supplied by this SmartObject. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
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
  {src/adm/template/snd-list.i "Evento"}
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "administrador"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

