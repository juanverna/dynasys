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
&Scoped-define EXTERNAL-TABLES Rem_header
&Scoped-define FIRST-EXTERNAL-TABLE Rem_header


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Rem_header.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Rem_header.sin_cargo 
&Scoped-define ENABLED-TABLES Rem_header
&Scoped-define FIRST-ENABLED-TABLE Rem_header
&Scoped-Define DISPLAYED-FIELDS Rem_header.sin_cargo 
&Scoped-define DISPLAYED-TABLES Rem_header
&Scoped-define FIRST-DISPLAYED-TABLE Rem_header
&Scoped-Define DISPLAYED-OBJECTS T_nf 

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
nro_remito|y|y|sic.Rem_header.nro_remito
nombre||y|sic.Rem_header.nombre
nro_area||y|sic.Rem_header.nro_area
nro_cliente||y|sic.Rem_header.nro_cliente
tip_comprob||y|sic.Rem_header.tip_comprob
cdg_condiva||y|sic.Rem_header.cdg_condiva
nro_cndventa||y|sic.Rem_header.nro_cndventa
cdg_consignatario||y|sic.Rem_header.cdg_consignatario
nro_contrato||y|sic.Rem_header.nro_contrato
mes||y|sic.Rem_header.mes
cdg_postal||y|sic.Rem_header.cdg_postal
nro_deposito||y|sic.Rem_header.nro_deposito
cdg_empresa||y|sic.Rem_header.cdg_empresa
nro_entidad||y|sic.Rem_header.nro_entidad
cdg_estado||y|sic.Rem_header.cdg_estado
nro_factura||y|sic.Rem_header.nro_factura
fecha||y|sic.Rem_header.fecha
cdg_formapago||y|sic.Rem_header.cdg_formapago
cdg_imputacion||y|sic.Rem_header.cdg_imputacion
cdg_librocontable||y|sic.Rem_header.cdg_librocontable
cdg_lista||y|sic.Rem_header.cdg_lista
nro_moneda||y|sic.Rem_header.nro_moneda
nro_pedido||y|sic.Rem_header.nro_pedido
cdg_planta||y|sic.Rem_header.cdg_planta
nro_plazo||y|sic.Rem_header.nro_plazo
cdg_provincia||y|sic.Rem_header.cdg_provincia
cdg_solicitante||y|sic.Rem_header.cdg_solicitante
nro_solicitud||y|sic.Rem_header.nro_solicitud
num_sucursal||y|sic.Rem_header.num_sucursal
cdg_utran||y|sic.Rem_header.cdg_utran
nro_usuario||y|sic.Rem_header.nro_usuario
nro_vendedor||y|sic.Rem_header.nro_vendedor
cdg_zonag||y|sic.Rem_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "nro_remito",
     Keys-Supplied = "nro_remito,nombre,nro_area,nro_cliente,tip_comprob,cdg_condiva,nro_cndventa,cdg_consignatario,nro_contrato,mes,cdg_postal,nro_deposito,cdg_empresa,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_librocontable,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,cdg_solicitante,nro_solicitud,num_sucursal,cdg_utran,nro_usuario,nro_vendedor,cdg_zonag"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE T_nf AS LOGICAL INITIAL no 
     LABEL "No Facturar" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Rem_header.sin_cargo AT ROW 1 COL 14 WIDGET-ID 2
          VIEW-AS TOGGLE-BOX
          SIZE 14.2 BY .81
     T_nf AT ROW 1 COL 41 WIDGET-ID 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Rem_header
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
         HEIGHT             = .91
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

/* SETTINGS FOR TOGGLE-BOX T_nf IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
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
    WHEN 'nro_remito':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Rem_header
           &WHERE = "WHERE Rem_header.nro_remito eq INTEGER(key-value)"
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
  {src/adm/template/row-list.i "Rem_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Rem_header"}

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
ASSIGN FRAME {&FRAME-NAME} T_nf.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .
IF t_nf THEN
    rem_header.estado = "-".

  /* Code placed here will execute AFTER standard behavior.    */

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
  t_nf:SENSITIVE IN FRAME {&FRAME-NAME}= FALSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
IF AVAILABLE rem_header THEN 
   t_nf:checked IN FRAME {&FRAME-NAME}= rem_header.estado = "-".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
    t_nf:SENSITIVE IN FRAME {&FRAME-NAME}= TRUE.

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
  {src/adm/template/sndkycas.i "nro_remito" "Rem_header" "nro_remito"}
  {src/adm/template/sndkycas.i "nombre" "Rem_header" "nombre"}
  {src/adm/template/sndkycas.i "nro_area" "Rem_header" "nro_area"}
  {src/adm/template/sndkycas.i "nro_cliente" "Rem_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "tip_comprob" "Rem_header" "tip_comprob"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Rem_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Rem_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Rem_header" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "nro_contrato" "Rem_header" "nro_contrato"}
  {src/adm/template/sndkycas.i "mes" "Rem_header" "mes"}
  {src/adm/template/sndkycas.i "cdg_postal" "Rem_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_deposito" "Rem_header" "nro_deposito"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Rem_header" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_entidad" "Rem_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Rem_header" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_factura" "Rem_header" "nro_factura"}
  {src/adm/template/sndkycas.i "fecha" "Rem_header" "fecha"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Rem_header" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Rem_header" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_librocontable" "Rem_header" "cdg_librocontable"}
  {src/adm/template/sndkycas.i "cdg_lista" "Rem_header" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Rem_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_pedido" "Rem_header" "nro_pedido"}
  {src/adm/template/sndkycas.i "cdg_planta" "Rem_header" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Rem_header" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Rem_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Rem_header" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "nro_solicitud" "Rem_header" "nro_solicitud"}
  {src/adm/template/sndkycas.i "num_sucursal" "Rem_header" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_utran" "Rem_header" "cdg_utran"}
  {src/adm/template/sndkycas.i "nro_usuario" "Rem_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Rem_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Rem_header" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Rem_header"}

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

