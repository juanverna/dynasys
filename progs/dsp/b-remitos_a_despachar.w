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

DEFINE NEW SHARED VARIABLE codigo_iva     AS INTEGER INITIAL 1.
DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL LABEL "Emitir remito".
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL LABEL "Emitir" INITIAL YES.

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

{parlocales.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Rem_header Cliente

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cliente.cdg_cliente ~
Cliente.nom_cliente 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define FIELD-PAIRS-IN-QUERY-br_table
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Rem_header WHERE ~{&KEY-PHRASE} ~
      AND Rem_header.estado = "X" NO-LOCK, ~
      EACH Cliente OF Rem_header NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Rem_header Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Rem_header


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-6 btn_cerrar btn_imprimir btn_borrar ~
br_table 
&Scoped-Define DISPLAYED-OBJECTS v-ocupado 

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
nro_area||y|sic.Rem_header.nro_area
nombre||y|sic.Rem_header.nombre
nro_cliente||y|sic.Rem_header.nro_cliente
cdg_condiva||y|sic.Rem_header.cdg_condiva
nro_cndventa||y|sic.Rem_header.nro_cndventa
cdg_consignatario||y|sic.Rem_header.cdg_consignatario
cdg_postal||y|sic.Rem_header.cdg_postal
nro_deposito||y|sic.Rem_header.nro_deposito
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
     Keys-Supplied = "nro_area,nombre,nro_cliente,cdg_condiva,nro_cndventa,cdg_consignatario,cdg_postal,nro_deposito,nro_entidad,cdg_estado,nro_factura,fecha,cdg_formapago,cdg_imputacion,cdg_lista,nro_moneda,nro_pedido,cdg_planta,nro_plazo,cdg_provincia,nro_remito,cdg_solicitante,nro_usuario,nro_vendedor,cdg_zonag"':U).

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
DEFINE BUTTON btn_borrar 
     LABEL "&Borrar" 
     SIZE 14 BY 1.12
     FONT 4.

DEFINE BUTTON btn_cerrar 
     LABEL "&Cerrar" 
     SIZE 14 BY 1.12
     FONT 4.

DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 14 BY 1.12
     FONT 4.

DEFINE VARIABLE v-ocupado AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 53 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Rem_header, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cliente.cdg_cliente COLUMN-LABEL "Cliente!Código"
      Cliente.nom_cliente
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 53 BY 6.73
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Remitos Incluidos en el Presente Despacho".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_cerrar AT ROW 1.27 COL 2
     btn_imprimir AT ROW 1.27 COL 17
     btn_borrar AT ROW 1.27 COL 32
     v-ocupado AT ROW 1.27 COL 46 COLON-ALIGNED NO-LABEL
     br_table AT ROW 2.88 COL 1
     RECT-6 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


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
         WIDTH              = 103.14.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-ocupado F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-ocupado IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Rem_header,sic.Cliente OF sic.Rem_header"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Rem_header.estado = ""X"""
     _FldNameList[1]   > sic.Cliente.cdg_cliente
"Cliente.cdg_cliente" "Cliente!Código" ? "character" ? ? ? ? ? ? no ?
     _FldNameList[2]   = sic.Cliente.nom_cliente
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

{setsensitivo.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Remitos Incluidos en el Presente Despacho */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Remitos Incluidos en el Presente Despacho */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Remitos Incluidos en el Presente Despacho */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_borrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_borrar B-table-Win
ON CHOOSE OF btn_borrar IN FRAME F-Main /* Borrar */
DO:
     IF AVAILABLE Rem_header
     THEN DO:
          v-ocupado:BGCOLOR IN FRAME {&FRAME-NAME} = 12.
          RUN borrar_remito.
          RUN dispatch IN THIS-PROCEDURE ('open-query':U).
          v-ocupado:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
     END.
     ELSE DO:
          MESSAGE "No hay remitos que puedan cerrarse"
                  VIEW-AS ALERT-BOX ERROR.
     END.     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cerrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cerrar B-table-Win
ON CHOOSE OF btn_cerrar IN FRAME F-Main /* Cerrar */
DO:
     IF AVAILABLE Rem_header
     THEN DO:
          v-ocupado:BGCOLOR IN FRAME {&FRAME-NAME} = 12.
          RUN cerrar_remito.
          RUN dispatch IN THIS-PROCEDURE ('open-query':U).
          v-ocupado:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
     END.
     ELSE DO:
          MESSAGE "No hay remitos que puedan cerrarse"
                  VIEW-AS ALERT-BOX ERROR.
     END.     
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir */
DO:
     IF AVAILABLE Rem_header
     THEN DO:
            v-ocupado:BGCOLOR IN FRAME {&FRAME-NAME} = 12.
            RUN imprimir_remito.p (INPUT ROWID(Rem_header)).
            v-ocupado:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
     END.
     ELSE DO:
            MESSAGE "No hay remitos que puedan imprimirse"
                  VIEW-AS ALERT-BOX ERROR.
     END.     
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borrar_remito B-table-Win 
PROCEDURE borrar_remito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FOR EACH Rem_detalle OF Rem_header:
      DELETE Rem_detalle.
  END.    

  FOR EACH Remito-pedido WHERE Remito-pedido.nro_remito = Rem_header.nro_remito:
      DELETE Remito-pedido.
  END.
 
  DELETE Rem_header.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cerrar_remito B-table-Win 
PROCEDURE cerrar_remito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE a-ncopias AS INTEGER.
  DEFINE VARIABLE b-ncopias AS INTEGER.

  DO TRANSACTION:

        DEFINE VARIABLE que_pedido LIKE Ped_header.nro_pedido.
      
        FIND CURRENT Rem_header EXCLUSIVE-LOCK.
      
        {findempresa.i}
      
        FIND Parametro 
             WHERE Parametro.cdg_parametro = "PREM" + STRING(Rem_header.prf_comprob,"9999") 
               AND Parametro.cdg_empresa = Empresa.cdg_empresa
                   EXCLUSIVE-LOCK.
        ASSIGN Rem_header.estado       = "E"
               Rem_header.tip_comprob  = "RM"
               Rem_header.nro_comprob  = Parametro.valor_n
               Parametro.valor_n       = Parametro.valor_n + 1.
        RELEASE Parametro.
      
        FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK, Articulo OF Rem_detalle NO-LOCK: 
      
            FOR EACH Remito-pedido WHERE Remito-pedido.nro_remito     = Rem_detalle.nro_remito
                                     AND Remito-pedido.nro_linea-rem  = Rem_detalle.nro_linea NO-LOCK:
      
                FIND Ped_detalle WHERE Ped_detalle.nro_pedido = Remito-pedido.nro_pedido
                                   AND Ped_detalle.nro_linea  = Remito-pedido.nro_linea-ped EXCLUSIVE-LOCK.
                                     
                ASSIGN
                       Ped_detalle.cdg_estado  = "CC"
                       Ped_detalle.cumplido    = YES.
   
                FIND Ped_header OF Ped_detalle EXCLUSIVE-LOCK.
                IF NOT CAN-FIND(FIRST Ped_detalle OF Ped_header 
                                WHERE LOOKUP(Ped_detalle.cdg_estado, "AN/CC/IR/RE", "/") = 0 )
                   THEN Ped_header.cdg_estado = "CC". 

            END.

        END.

        RELEASE Ped_header.
                
        RUN SRWREMIHD.P ( INPUT ROWID(Rem_header) ). /* Ajusta variables SHARED que necesitan los procesos */

        /* Pone en CERO la cantidad de copias de factura para que no salgan */
        RUN getparametro.p (  INPUT  "NCOPIAFA",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).
        a-ncopias = v-valor_n.
        RUN setparametro.p (  INPUT  "NCOPIAFA",
                              INPUT  v-valor_c,
                              INPUT  v-valor_d,
                              INPUT  v-valor_l,
                              INPUT  0,
                              INPUT  v-observacion ).
         
        RUN getparametro.p (  INPUT  "NCOPIAFB",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).
        b-ncopias = v-valor_n.
        RUN setparametro.p (  INPUT  "NCOPIAFB",
                              INPUT  v-valor_c,
                              INPUT  v-valor_d,
                              INPUT  v-valor_l,
                              INPUT  0,
                              INPUT  v-observacion ).
                
        RUN emitir_remito.p ( INPUT ROWID(Rem_header) ).
        FIND CURRENT Rem_header NO-LOCK.

        RUN getparametro.p (  INPUT  "NCOPIAFA",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).
        RUN setparametro.p (  INPUT  "NCOPIAFA",
                              INPUT  v-valor_c,
                              INPUT  v-valor_d,
                              INPUT  v-valor_l,
                              INPUT  a-ncopias,
                              INPUT  v-observacion ).
         
        RUN getparametro.p (  INPUT  "NCOPIAFB",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).
        RUN setparametro.p (  INPUT  "NCOPIAFB",
                              INPUT  v-valor_c,
                              INPUT  v-valor_d,
                              INPUT  v-valor_l,
                              INPUT  b-ncopias,
                              INPUT  v-observacion ).

  END.

  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.
  
  RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Renovar-Target':U, OUTPUT c).
  IF NUM-ENTRIES (c) eq 1 THEN DO:
    h = WIDGET-HANDLE (c).
    RUN dispatch IN h ('open-query':U).
  END.

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  {findempresa.i}
  que_empresa = Empresa.cdg_empresa.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view B-table-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  RUN dispatch IN THIS-PROCEDURE ('row-changed':U).

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
  {src/adm/template/sndkycas.i "nro_area" "Rem_header" "nro_area"}
  {src/adm/template/sndkycas.i "nombre" "Rem_header" "nombre"}
  {src/adm/template/sndkycas.i "nro_cliente" "Rem_header" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Rem_header" "cdg_condiva"}
  {src/adm/template/sndkycas.i "nro_cndventa" "Rem_header" "nro_cndventa"}
  {src/adm/template/sndkycas.i "cdg_consignatario" "Rem_header" "cdg_consignatario"}
  {src/adm/template/sndkycas.i "cdg_postal" "Rem_header" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_deposito" "Rem_header" "nro_deposito"}
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
  {src/adm/template/sndkycas.i "nro_usuario" "Rem_header" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Rem_header" "nro_vendedor"}
  {src/adm/template/sndkycas.i "cdg_zonag" "Rem_header" "cdg_zonag"}

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
  {src/adm/template/snd-list.i "Rem_header"}
  {src/adm/template/snd-list.i "Cliente"}

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


