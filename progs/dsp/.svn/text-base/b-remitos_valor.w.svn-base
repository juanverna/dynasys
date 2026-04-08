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
DEF VAR listaArticulo AS CHAR NO-UNDO FORMAT "X(8)" LABEL "Tipo".

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

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rem_header

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Rem_header.FAsignado ~
Rem_header.direccion_leg Rem_header.anulado listaArticulo() @ listaArticulo ~
Rem_header.nro_tipo_evento Rem_header.estado Rem_header.conformado ~
Rem_header.fecha Rem_header.tip_comprob Rem_header.prf_comprob ~
Rem_header.nro_comprob Rem_header.hora_desde Rem_header.hora_hasta ~
Rem_header.Recursos Rem_header.imp_total Rem_header.nro_contrato ~
Rem_header.origen 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table Rem_header.nro_contrato 
&Scoped-define ENABLED-TABLES-IN-QUERY-br_table Rem_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br_table Rem_header
&Scoped-define QUERY-STRING-br_table FOR EACH Rem_header OF Cliente WHERE ~{&KEY-PHRASE} NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rem_header OF Cliente WHERE ~{&KEY-PHRASE} NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Rem_header
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rem_header


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS des_fecha has_fecha br_table 
&Scoped-Define DISPLAYED-OBJECTS des_fecha has_fecha 

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
<FOREIGN-KEYS>
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
cdg_lista||y|sic.Rem_header.cdg_lista
nro_moneda||y|sic.Rem_header.nro_moneda
nro_pedido||y|sic.Rem_header.nro_pedido
cdg_planta||y|sic.Rem_header.cdg_planta
nro_plazo||y|sic.Rem_header.nro_plazo
cdg_provincia||y|sic.Rem_header.cdg_provincia
nro_remito||y|sic.Rem_header.nro_remito
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
    'Keys-Accepted = ,
     Keys-Supplied = "nombre,nro_area,nro_cliente,tip_comprob,cdg_condiva,nro_cndventa,cdg_consignatario,nro_contrato,mes,cdg_postal,nro_deposito,cdg_empresa,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,nro_solicitud,num_sucursal,cdg_utran,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
fecha|y||sic.Rem_header.fecha|no
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = "':U + 'fecha' + '",
     SortBy-Case = ':U + 'fecha').

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).

/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD listaArticulo B-table-Win 
FUNCTION listaArticulo RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Del" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rem_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Rem_header.FAsignado FORMAT "99/99/9999":U
      Rem_header.direccion_leg FORMAT "X(45)":U
      Rem_header.anulado FORMAT "Si/No":U
      listaArticulo() @ listaArticulo COLUMN-LABEL "Tipo!Articulo"
      Rem_header.nro_tipo_evento FORMAT ">>9":U
      Rem_header.estado FORMAT "X(1)":U
      Rem_header.conformado FORMAT "yes/no":U
      Rem_header.fecha FORMAT "99/99/99":U
      Rem_header.tip_comprob FORMAT "X(3)":U
      Rem_header.prf_comprob FORMAT "9999":U
      Rem_header.nro_comprob FORMAT "ZZZZZZZ9":U
      Rem_header.hora_desde FORMAT "99:99":U
      Rem_header.hora_hasta FORMAT "99:99":U
      Rem_header.Recursos FORMAT "X(8)":U
      Rem_header.imp_total COLUMN-LABEL "Importe!Total" FORMAT "->>>,>>9.99":U
      Rem_header.nro_contrato COLUMN-LABEL "Numero!Contrato" FORMAT "ZZZZZ9":U
      Rem_header.origen FORMAT "X(1)":U
  ENABLE
      Rem_header.nro_contrato
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN NO-ROW-MARKERS SEPARATORS SIZE 156 BY 15
         BGCOLOR 15 FGCOLOR 9  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     des_fecha AT ROW 1 COL 4.2 COLON-ALIGNED WIDGET-ID 2
     has_fecha AT ROW 1 COL 22.2 COLON-ALIGNED WIDGET-ID 4
     br_table AT ROW 2.19 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cliente
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
         HEIGHT             = 20.76
         WIDTH              = 160.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table has_fecha F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rem_header OF sic.Cliente"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _FldNameList[1]   = sic.Rem_header.FAsignado
     _FldNameList[2]   = sic.Rem_header.direccion_leg
     _FldNameList[3]   = sic.Rem_header.anulado
     _FldNameList[4]   > "_<CALC>"
"listaArticulo() @ listaArticulo" "Tipo!Articulo" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sic.Rem_header.nro_tipo_evento
"Rem_header.nro_tipo_evento" ? ">>9" "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = sic.Rem_header.estado
     _FldNameList[7]   = sic.Rem_header.conformado
     _FldNameList[8]   = sic.Rem_header.fecha
     _FldNameList[9]   = sic.Rem_header.tip_comprob
     _FldNameList[10]   = sic.Rem_header.prf_comprob
     _FldNameList[11]   = sic.Rem_header.nro_comprob
     _FldNameList[12]   = sic.Rem_header.hora_desde
     _FldNameList[13]   = sic.Rem_header.hora_hasta
     _FldNameList[14]   = sic.Rem_header.Recursos
     _FldNameList[15]   > sic.Rem_header.imp_total
"Rem_header.imp_total" "Importe!Total" "->>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > sic.Rem_header.nro_contrato
"Rem_header.nro_contrato" "Numero!Contrato" ? "integer" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   = sic.Rem_header.origen
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
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
DO:
DEF VAR act_rem_head AS ROWID NO-UNDO.
IF AVAILABLE Rem_header
     THEN DO:                  
          act_rem_head = ROWID(Rem_header).
          /*RUN ocultar_window.*/
          RUN c-comprobante_despacho.w ( INPUT-OUTPUT act_Rem_head , INPUT 2, INPUT Rem_header.cdg_comprobante ).
          /*RUN mostrar_window.*/
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
  IF AVAILABLE rem_header THEN
        RUN cambiar_color.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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


&Scoped-define SELF-NAME des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF des_fecha IN FRAME F-Main /* Del */
DO:
  DEF VAR fecha_elegida AS DATE NO-UNDO.
  ASSIGN des_fecha.
  IF des_fecha = ? THEN des_fecha = TODAY + 5.
  RUN d-calendario.w ( INPUT des_fecha, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha B-table-Win
ON RETURN OF des_fecha IN FRAME F-Main /* Del */
DO:
  ASSIGN des_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF has_fecha IN FRAME F-Main /* al */
DO:
    DEF VAR fecha_elegida AS DATE NO-UNDO.
    ASSIGN has_fecha.
    IF has_fecha = ? THEN has_fecha = TODAY + 5.
    RUN d-calendario.w ( INPUT has_fecha, OUTPUT fecha_elegida).
    IF fecha_elegida <> ?
    THEN DO:
         DISPLAY fecha_elegida @ has_fecha 
                 WITH FRAME {&FRAME-NAME}.
         APPLY "RETURN" TO SELF.        
    END.               

           
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha B-table-Win
ON RETURN OF has_fecha IN FRAME F-Main /* al */
DO:
  ASSIGN has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
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

  RUN get-attribute ('SortBy-Case':U).
  CASE RETURN-VALUE:
    WHEN 'fecha':U THEN DO:
      &Scope SORTBY-PHRASE BY Rem_header.fecha DESCENDING
      {&OPEN-QUERY-{&BROWSE-NAME}}
    END.
    OTHERWISE DO:
      &Undefine SORTBY-PHRASE
      {&OPEN-QUERY-{&BROWSE-NAME}}
    END. /* OTHERWISE...*/
  END CASE.

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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_color B-table-Win 
PROCEDURE cambiar_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   DEF VAR cfNormal AS INT INITIAL 9 NO-UNDO.
   DEF VAR cBNormal AS INT INITIAL 15 NO-UNDO.
   DEF VAR cfCritico AS INT INITIAL 0 NO-UNDO.
   DEF VAR cBCritico AS INT INITIAL 14 NO-UNDO.
   DEF VAR cfMal AS INT INITIAL 0 NO-UNDO.
   DEF VAR cBMal AS INT INITIAL 12 NO-UNDO.
   
IF rem_header.fasignado >= TODAY + 2 AND NOT rem_header.conformado THEN
DO:
    rem_header.fasignado:fGCOLOR IN BROWSE {&BROWSE-NAME} = cfMal. 
    rem_header.fasignado:bGCOLOR IN BROWSE {&BROWSE-NAME} = cBMal.
END.
ELSE IF rem_header.fasignado >= TODAY + 1 AND NOT rem_header.conformado THEN
    DO:
        rem_header.fasignado:fGCOLOR IN BROWSE {&BROWSE-NAME} = cfCritico. 
        rem_header.fasignado:bGCOLOR IN BROWSE {&BROWSE-NAME} = cbCritico.
    END.
ELSE DO:    
        rem_header.fasignado:fGCOLOR IN BROWSE {&BROWSE-NAME} = cfNormal. 
        rem_header.fasignado:bGCOLOR IN BROWSE {&BROWSE-NAME} = cbNormal.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
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
  {src/adm/template/sndkycas.i "cdg_lista" "Rem_header" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Rem_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_pedido" "Rem_header" "nro_pedido"}
  {src/adm/template/sndkycas.i "cdg_planta" "Rem_header" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Rem_header" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Rem_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "nro_remito" "Rem_header" "nro_remito"}
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
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Rem_header"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION listaArticulo B-table-Win 
FUNCTION listaArticulo RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR listaArticulo AS CHAR NO-UNDO.
listaArticulo = "".
FOR EACH rem_detalle OF rem_header,articulo OF rem_detalle:
    listaArticulo = listaArticulo + "," + articulo.cdg_articulo.
  END.
  
  RETURN substr(listaArticulo,2).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

