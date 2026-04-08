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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Contrato_hd
&Scoped-define FIRST-EXTERNAL-TABLE Contrato_hd


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Contrato_hd.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Contrato_hd.nro_cliente ~
Contrato_hd.nro_contrato 
&Scoped-define ENABLED-TABLES Contrato_hd
&Scoped-define FIRST-ENABLED-TABLE Contrato_hd
&Scoped-Define DISPLAYED-FIELDS Contrato_hd.nro_cliente ~
Contrato_hd.nro_contrato 
&Scoped-define DISPLAYED-TABLES Contrato_hd
&Scoped-define FIRST-DISPLAYED-TABLE Contrato_hd


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
nro_contrato|y|y|sic.Contrato_hd.nro_contrato
cdg_empresa|y|y|sic.Contrato_hd.cdg_empresa
nombre||y|sic.Contrato_hd.nombre
nro_area||y|sic.Contrato_hd.nro_area
cdg_banco||y|sic.Contrato_hd.cdg_banco
nro_cliente||y|sic.Contrato_hd.nro_cliente
cdg_condiva||y|sic.Contrato_hd.cdg_condiva
nro_cndventa||y|sic.Contrato_hd.nro_cndventa
cdg_consignatario||y|sic.Contrato_hd.cdg_consignatario
cdg_postal||y|sic.Contrato_hd.cdg_postal
cdg_formapago||y|sic.Contrato_hd.cdg_formapago
cdg_imputacion||y|sic.Contrato_hd.cdg_imputacion
cdg_lista||y|sic.Contrato_hd.cdg_lista
nro_moneda||y|sic.Contrato_hd.nro_moneda
nro_obra||y|sic.Contrato_hd.nro_obra
nro_persona||y|sic.Contrato_hd.nro_persona
cdg_planta||y|sic.Contrato_hd.cdg_planta
nro_plazo||y|sic.Contrato_hd.nro_plazo
cdg_provincia||y|sic.Contrato_hd.cdg_provincia
nro_remito||y|sic.Contrato_hd.nro_remito
cdg_solicitante||y|sic.Contrato_hd.cdg_solicitante
num_sucursal||y|sic.Contrato_hd.num_sucursal
cdg_embarque||y|sic.Contrato_hd.cdg_embarque
nro_usuario||y|sic.Contrato_hd.nro_usuario
nro_vendedor||y|sic.Contrato_hd.nro_vendedor
cdg_zonag||y|sic.Contrato_hd.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_contrato,cdg_empresa",
     Keys-Supplied = "nro_contrato,cdg_empresa,nombre,nro_area,cdg_banco,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,cdg_postal,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_obra,nro_persona,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,num_sucursal,cdg_embarque,nro_usuario,nro_vendedor,cdg_zonag"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Contrato_hd.nro_cliente AT ROW 1 COL 15 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN 
          SIZE 10.4 BY 1
     Contrato_hd.nro_contrato AT ROW 2 COL 15 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 10.4 BY 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Contrato_hd
   Allow: Basic,DB-Fields
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
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 2.19
         WIDTH              = 66.
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

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "SmartViewerCues" V-table-Win _INLINE
/* Actions: adecomm/_so-cue.w ? adecomm/_so-cued.p ? adecomm/_so-cuew.p */
/* SmartViewer,ab,49270
Destroy on next read */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
    WHEN 'nro_contrato':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Contrato_hd
           &WHERE = "WHERE Contrato_hd.nro_contrato eq INTEGER(key-value)"
       }
    WHEN 'cdg_empresa':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Contrato_hd
           &WHERE = "WHERE Contrato_hd.cdg_empresa eq key-value"
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
  {src/adm/template/row-list.i "Contrato_hd"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Contrato_hd"}

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
  {src/adm/template/sndkycas.i "nro_contrato" "Contrato_hd" "nro_contrato"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Contrato_hd" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nombre" "Contrato_hd" "nombre"}
  {src/adm/template/sndkycas.i "nro_area" "Contrato_hd" "nro_area"}
  {src/adm/template/sndkycas.i "cdg_banco" "Contrato_hd" "cdg_banco"}
  {src/adm/template/sndkycas.i "nro_cliente" "Contrato_hd" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Contrato_hd" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Contrato_hd" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Contrato_hd" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "cdg_postal" "Contrato_hd" "cdg_postal"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Contrato_hd" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Contrato_hd" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Contrato_hd" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Contrato_hd" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_obra" "Contrato_hd" "nro_obra"}
  {src/adm/template/sndkycas.i "nro_persona" "Contrato_hd" "nro_persona"}
  {src/adm/template/sndkycas.i "cdg_planta" "Contrato_hd" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Contrato_hd" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Contrato_hd" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Contrato_hd" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Contrato_hd" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "num_sucursal" "Contrato_hd" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_embarque" "Contrato_hd" "cdg_embarque"}
  {src/adm/template/sndkycas.i "nro_usuario" "Contrato_hd" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Contrato_hd" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Contrato_hd" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Contrato_hd"}

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

