&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
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


DEFINE VARIABLE fgcolor_inc AS INTEGER INITIAL 14.
DEFINE VARIABLE bgcolor_inc AS INTEGER INITIAL 2.

DEFINE VARIABLE fgcolor_pen AS INTEGER INITIAL 9.
DEFINE VARIABLE bgcolor_pen AS INTEGER INITIAL 11.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Recorrido Deposito
&Scoped-define FIRST-EXTERNAL-TABLE Recorrido


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Recorrido, Deposito.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Ped_header Cliente Ped_detalle Articulo

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Ped_header.fecha ~
Ped_header.tip_comprob Ped_header.nro_comprob Cliente.cdg_cliente ~
Cliente.nom_cliente Articulo.cdg_articulo Articulo.descripcion ~
Ped_detalle.cantidad Ped_detalle.granel 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Ped_header OF Recorrido WHERE ~{&KEY-PHRASE} NO-LOCK, ~
      EACH Cliente OF Ped_header NO-LOCK, ~
      EACH Ped_detalle OF Ped_header ~
      WHERE LOOKUP(Ped_detalle.cdg_estado,V-ESTADOS, "/") <> 0   NO-LOCK, ~
      EACH Articulo OF Ped_detalle NO-LOCK ~
    BY Cliente.cdg_cliente.
&Scoped-define TABLES-IN-QUERY-br_table Ped_header Cliente Ped_detalle ~
Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Ped_header


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table RECT-8 v-estados btn_renovar 
&Scoped-Define DISPLAYED-OBJECTS v-estados 

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
nro_area||y|sic.Ped_header.nro_area
nombre||y|sic.Ped_header.nombre
cdg_banco||y|sic.Ped_header.cdg_banco
nro_cliente||y|sic.Ped_header.nro_cliente
cdg_condiva||y|sic.Ped_header.cdg_condiva
nro_cndventa||y|sic.Ped_header.nro_cndventa
cdg_consignatario||y|sic.Ped_header.cdg_consignatario
cdg_postal||y|sic.Ped_header.cdg_postal
nro_deposito||y|sic.Ped_header.nro_deposito
nro_entidad||y|sic.Ped_header.nro_entidad
cdg_estado||y|sic.Ped_header.cdg_estado
nro_factura||y|sic.Ped_header.nro_factura
fecha||y|sic.Ped_header.fecha
cdg_formapago||y|sic.Ped_header.cdg_formapago
cdg_imputacion||y|sic.Ped_header.cdg_imputacion
cdg_lista||y|sic.Ped_header.cdg_lista
nro_moneda||y|sic.Ped_header.nro_moneda
nro_pedido||y|sic.Ped_header.nro_pedido
cdg_planta||y|sic.Ped_header.cdg_planta
nro_plazo||y|sic.Ped_header.nro_plazo
cdg_provincia||y|sic.Ped_header.cdg_provincia
cdg_recorrido||y|sic.Ped_header.cdg_recorrido
nro_remito||y|sic.Ped_header.nro_remito
cdg_solicitante||y|sic.Ped_header.cdg_solicitante
nro_usuario||y|sic.Ped_header.nro_usuario
nro_vendedor||y|sic.Ped_header.nro_vendedor
cdg_zonag||y|sic.Ped_header.cdg_zonag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_area,nombre,cdg_banco,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,cdg_postal,nro_deposito,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,cdg_recorrido,nro_remito,cdg_solicitante,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE BUTTON btn_renovar 
     LABEL "&Renovar Datos" 
     SIZE 21 BY 1.12
     FONT 4.

DEFINE VARIABLE v-estados AS CHARACTER INITIAL "AA/AM" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Pendientes", "AA/AM",
"Despachados", "DE"
     SIZE 30 BY 1
     FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 107 BY 1.77.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Ped_header, 
      Cliente, 
      Ped_detalle, 
      Articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Ped_header.fecha COLUMN-LABEL "Fecha!Alta"
      Ped_header.tip_comprob COLUMN-LABEL "Tipo!Pedido"
      Ped_header.nro_comprob COLUMN-LABEL "Número!Pedido"
      Cliente.cdg_cliente COLUMN-LABEL "Código!Cliente"
      Cliente.nom_cliente COLUMN-LABEL "Razon!Social"
      Articulo.cdg_articulo
      Articulo.descripcion
      Ped_detalle.cantidad
      Ped_detalle.granel
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 107 BY 6.73
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Pedidos Pendientes de Despachar".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
     v-estados AT ROW 8.42 COL 3 NO-LABEL
     btn_renovar AT ROW 8.42 COL 86
     RECT-8 AT ROW 8 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Recorrido,sic.Deposito
   Allow: Basic,Browse
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 8.92
         WIDTH              = 112.14.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Ped_header OF sic.Recorrido,sic.Cliente OF sic.Ped_header,sic.Ped_detalle OF sic.Ped_header,sic.Articulo OF sic.Ped_detalle"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,,"
     _OrdList          = "sic.Cliente.cdg_cliente|yes"
     _Where[3]         = "LOOKUP(Ped_detalle.cdg_estado,V-ESTADOS, ""/"") <> 0  "
     _FldNameList[1]   > sic.Ped_header.fecha
"Ped_header.fecha" "Fecha!Alta" ? "date" ? ? ? ? ? ? no ?
     _FldNameList[2]   > sic.Ped_header.tip_comprob
"Ped_header.tip_comprob" "Tipo!Pedido" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[3]   > sic.Ped_header.nro_comprob
"Ped_header.nro_comprob" "Número!Pedido" ? "integer" ? ? ? ? ? ? no ?
     _FldNameList[4]   > sic.Cliente.cdg_cliente
"Cliente.cdg_cliente" "Código!Cliente" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[5]   > sic.Cliente.nom_cliente
"Cliente.nom_cliente" "Razon!Social" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[6]   = sic.Articulo.cdg_articulo
     _FldNameList[7]   = sic.Articulo.descripcion
     _FldNameList[8]   = sic.Ped_detalle.cantidad
     _FldNameList[9]   = sic.Ped_detalle.granel
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main /* Pedidos Pendientes de Despachar */
DO:
    IF Ped_Detalle.ult_remito <> 0 
       THEN RUN poner_incluido.
       ELSE RUN poner_excluido.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Pedidos Pendientes de Despachar */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Pedidos Pendientes de Despachar */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Pedidos Pendientes de Despachar */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_renovar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_renovar B-table-Win
ON CHOOSE OF btn_renovar IN FRAME F-Main /* Renovar Datos */
DO:
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-estados
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-estados B-table-Win
ON VALUE-CHANGED OF v-estados IN FRAME F-Main
DO:
  ASSIGN FRAME {&FRAME-NAME} v-estados.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win adm/support/_adm-opn.p
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Recorrido"}
  {src/adm/template/row-list.i "Deposito"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Recorrido"}
  {src/adm/template/row-find.i "Deposito"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_excluido B-table-Win 
PROCEDURE poner_excluido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


ASSIGN
    Ped_header.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Ped_header.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Ped_header.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Cliente.cdg_cliente :FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Ped_detalle.cantidad:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen
    Ped_detalle.granel:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_pen 

    Ped_header.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Ped_header.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Ped_header.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Cliente.cdg_cliente :BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Ped_detalle.cantidad:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen
    Ped_detalle.granel:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_pen. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_incluido B-table-Win 
PROCEDURE poner_incluido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    Ped_header.fecha:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Ped_header.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Ped_header.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Cliente.cdg_cliente :FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Ped_detalle.cantidad:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc
    Ped_detalle.granel:FGCOLOR IN BROWSE {&BROWSE-NAME} = fgcolor_inc 

    Ped_header.fecha:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Ped_header.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Ped_header.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Cliente.cdg_cliente :BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Ped_detalle.cantidad:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc
    Ped_detalle.granel:BGCOLOR IN BROWSE {&BROWSE-NAME} = bgcolor_inc. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browse B-table-Win 
PROCEDURE refrescar_browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_area" "Ped_header" "nro_area"}
  {src/adm/template/sndkycas.i "nombre" "Ped_header" "nombre"}
  {src/adm/template/sndkycas.i "cdg_banco" "Ped_header" "cdg_banco"}
  {src/adm/template/sndkycas.i "nro_cliente" "Ped_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Ped_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Ped_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Ped_header" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "cdg_postal" "Ped_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_deposito" "Ped_header" "nro_deposito"}
  {src/adm/template/sndkycas.i "nro_entidad" "Ped_header" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Ped_header" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_factura" "Ped_header" "nro_factura"}
  {src/adm/template/sndkycas.i "fecha" "Ped_header" "fecha"}
  {src/adm/template/sndkycas.i "cdg_formapago" "Ped_header" "cdg_formapago"}
  {src/adm/template/sndkycas.i "cdg_imputacion" "Ped_header" "cdg_imputacion"}
  {src/adm/template/sndkycas.i "cdg_lista" "Ped_header" "cdg_lista"}
  {src/adm/template/sndkycas.i "nro_moneda" "Ped_header" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_pedido" "Ped_header" "nro_pedido"}
  {src/adm/template/sndkycas.i "cdg_planta" "Ped_header" "cdg_planta"}
  {src/adm/template/sndkycas.i "nro_plazo" "Ped_header" "nro_plazo"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Ped_header" "cdg_provincia"}
  {src/adm/template/sndkycas.i "cdg_recorrido" "Ped_header" "cdg_recorrido"}
  {src/adm/template/sndkycas.i "nro_remito" "Ped_header" "nro_remito"}
  {src/adm/template/sndkycas.i "cdg_solicitante" "Ped_header" "cdg_solicitante"}
  {src/adm/template/sndkycas.i "nro_usuario" "Ped_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Ped_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Ped_header" "cdg_zonag"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Recorrido"}
  {src/adm/template/snd-list.i "Deposito"}
  {src/adm/template/snd-list.i "Ped_header"}
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Ped_detalle"}
  {src/adm/template/snd-list.i "Articulo"}

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


