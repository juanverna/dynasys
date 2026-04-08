&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
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

DEFINE VARIABLE v-estados AS CHARACTER INITIAL "AA/AM".
DEFINE VARIABLE sino_msg AS LOGICAL.
{dfcamest.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Ped_header Cliente Empresa

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Ped_header.cdg_empresa ~
Ped_header.fecha_alta Ped_header.fecha Cliente.cdg_cliente ~
Cliente.nom_cliente Ped_header.cdg_estado Ped_header.tip_comprob ~
Ped_header.prf_comprob Ped_header.nro_comprob 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Ped_header WHERE ~{&KEY-PHRASE} ~
      AND LOOKUP(Ped_header.cdg_estado,v-estados,"/") <> 0 NO-LOCK, ~
      EACH Cliente OF Ped_header NO-LOCK, ~
      EACH Empresa OF Ped_header NO-LOCK ~
    BY Ped_header.fecha ~
       BY Ped_header.fecha_alta ~
        BY Cliente.cdg_cliente
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Ped_header WHERE ~{&KEY-PHRASE} ~
      AND LOOKUP(Ped_header.cdg_estado,v-estados,"/") <> 0 NO-LOCK, ~
      EACH Cliente OF Ped_header NO-LOCK, ~
      EACH Empresa OF Ped_header NO-LOCK ~
    BY Ped_header.fecha ~
       BY Ped_header.fecha_alta ~
        BY Cliente.cdg_cliente.
&Scoped-define TABLES-IN-QUERY-br_table Ped_header Cliente Empresa
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Ped_header
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Cliente
&Scoped-define THIRD-TABLE-IN-QUERY-br_table Empresa


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
btn_renovar btn_cumplir btn_anular v-observacion br_table RECT-6 RECT-7 ~
RECT-8 
&Scoped-Define DISPLAYED-OBJECTS v-tip_comprob v-prf_comprob v-nro_comprob ~
v-observacion 

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
DEFINE BUTTON btn_anular 
     LABEL "&Anular" 
     SIZE 19 BY 1.14
     FONT 4.

DEFINE BUTTON btn_cumplir 
     LABEL "&Cumplir" 
     SIZE 19 BY 1.14
     FONT 4.

DEFINE BUTTON btn_renovar 
     LABEL "&Renovar Datos" 
     SIZE 19 BY 1.14
     FONT 4.

DEFINE VARIABLE v-observacion AS CHARACTER 
     VIEW-AS EDITOR
     SIZE 97 BY 2.14
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-nro_comprob AS INTEGER FORMAT "99999999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-prf_comprob AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-tip_comprob AS CHARACTER FORMAT "X(2)":U 
     LABEL "Pedido" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 7 BY 1
     BGCOLOR 14 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 101 BY 1.62.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 101 BY 3.76.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 101 BY 6.71.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Ped_header, 
      Cliente, 
      Empresa SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Ped_header.cdg_empresa COLUMN-LABEL "Em-!presa" FORMAT "X(2)":U
      Ped_header.fecha_alta FORMAT "99/99/99":U
      Ped_header.fecha COLUMN-LABEL "Fecha!Pedido" FORMAT "99/99/99":U
      Cliente.cdg_cliente FORMAT "X(8)":U
      Cliente.nom_cliente FORMAT "X(31)":U WIDTH 39.8
      Ped_header.cdg_estado COLUMN-LABEL "Es-!tado" FORMAT "X(2)":U
      Ped_header.tip_comprob COLUMN-LABEL "Tip!Ped" FORMAT "X(3)":U
      Ped_header.prf_comprob COLUMN-LABEL "Pre-!fijo" FORMAT "9999":U
      Ped_header.nro_comprob COLUMN-LABEL "Número!Pedido" FORMAT "ZZZZZZZ9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 97 BY 6.19
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 11 FGCOLOR 9 "Pedidos Activos".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-tip_comprob AT ROW 1.29 COL 8 COLON-ALIGNED
     v-prf_comprob AT ROW 1.29 COL 16 COLON-ALIGNED NO-LABEL
     v-nro_comprob AT ROW 1.29 COL 24 COLON-ALIGNED NO-LABEL
     btn_renovar AT ROW 1.29 COL 39
     btn_cumplir AT ROW 1.29 COL 60
     btn_anular AT ROW 1.29 COL 81
     v-observacion AT ROW 4.24 COL 3 NO-LABEL
     br_table AT ROW 7.19 COL 3
     RECT-6 AT ROW 1 COL 1
     RECT-7 AT ROW 2.86 COL 1
     RECT-8 AT ROW 6.91 COL 1
     "  Observaciones asociadas al cambio de estado" VIEW-AS TEXT
          SIZE 97 BY .81 AT ROW 3.14 COL 3
          BGCOLOR 5 FGCOLOR 15 
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
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 21.24
         WIDTH              = 108.8.
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
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-observacion F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Ped_header,sic.Cliente OF sic.Ped_header,sic.Empresa OF sic.Ped_header"
     _Options          = "NO-LOCK KEY-PHRASE"
     _TblOptList       = ",,"
     _OrdList          = "sic.Ped_header.fecha|yes,sic.Ped_header.fecha_alta|yes,sic.Cliente.cdg_cliente|yes"
     _Where[1]         = "LOOKUP(Ped_header.cdg_estado,v-estados,""/"") <> 0"
     _FldNameList[1]   > sic.Ped_header.cdg_empresa
"Ped_header.cdg_empresa" "Em-!presa" "X(2)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = sic.Ped_header.fecha_alta
     _FldNameList[3]   > sic.Ped_header.fecha
"Ped_header.fecha" "Fecha!Pedido" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   = sic.Cliente.cdg_cliente
     _FldNameList[5]   > sic.Cliente.nom_cliente
"Cliente.nom_cliente" ? "X(31)" "character" ? ? ? ? ? ? no ? no no "39.8" yes no no "U" "" ""
     _FldNameList[6]   > sic.Ped_header.cdg_estado
"Ped_header.cdg_estado" "Es-!tado" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Ped_header.tip_comprob
"Ped_header.tip_comprob" "Tip!Ped" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic.Ped_header.prf_comprob
"Ped_header.prf_comprob" "Pre-!fijo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sic.Ped_header.nro_comprob
"Ped_header.nro_comprob" "Número!Pedido" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Pedidos Activos */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Pedidos Activos */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Pedidos Activos */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular B-table-Win
ON CHOOSE OF btn_anular IN FRAME F-Main /* Anular */
DO:
    sino_msg = NO.
    MESSAGE "Desea marcar este pedido como Anulado?" 
        VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO TITLE "Confirmacion" SET sino_msg.
    IF sino_msg 
    THEN DO:
        RUN cambiar_estado_pedido ( INPUT "ZZ" ) . 
        RUN dispatch IN THIS-PROCEDURE ( 'open-query').
    END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cumplir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cumplir B-table-Win
ON CHOOSE OF btn_cumplir IN FRAME F-Main /* Cumplir */
DO:
    sino_msg = NO.
    MESSAGE "Desea marcar este pedido como Cumplido?" 
        VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO TITLE "Confirmacion" SET sino_msg.
    IF sino_msg 
    THEN DO:
        RUN cambiar_estado_pedido ( INPUT "CC" ) . 
        RUN dispatch IN THIS-PROCEDURE ( 'open-query').
    END.
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


&Scoped-define SELF-NAME v-nro_comprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob B-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-nro_comprob IN FRAME F-Main
OR MOUSE-MENU-DOWN,"." OF v-nro_comprob IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_pedido AS ROWID.

  RUN d-seleccionar_pedido_activo.w (INPUT "Selección de Pedidos Activos", INPUT "E", INPUT "P*", INPUT-OUTPUT rid_pedido).
  IF rid_pedido <> ?
  THEN DO:
     FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido NO-LOCK.
     DISPLAY Ped_header.tip_comprob @ v-tip_comprob 
             Ped_header.prf_comprob @ v-prf_comprob
             Ped_header.nro_comprob @ v-nro_comprob
             WITH FRAME {&FRAME-NAME}.
    REPOSITION {&BROWSE-NAME} TO ROWID ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}).
  END.  
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-nro_comprob B-table-Win
ON RETURN OF v-nro_comprob IN FRAME F-Main
DO:
    ASSIGN  FRAME {&FRAME-NAME} v-tip_comprob v-prf_comprob v-nro_comprob.
    FIND Ped_header WHERE Ped_header.tip_comprob = v-tip_comprob 
                      AND Ped_header.prf_comprob = v-prf_comprob
                      AND Ped_header.nro_comprob = v-nro_comprob
                          NO-LOCK NO-ERROR.
    IF AVAILABLE Ped_header 
        THEN REPOSITION {&BROWSE-NAME} TO ROWID ROWID({&FIRST-TABLE-IN-QUERY-{&BROWSE-NAME}}).
        ELSE MESSAGE "No existe el pedido indicado" VIEW-AS ALERT-BOX ERROR.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_estado_pedido B-table-Win 
PROCEDURE cambiar_estado_pedido :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-nuevo_estado LIKE Ped_header.cdg_estado.

    DO TRANSACTION:
    
       ASSIGN FRAME {&FRAME-NAME} v-observacion.
    
       FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.
       FIND CURRENT Ped_header EXCLUSIVE-LOCK.
       FOR EACH Ped_detalle OF Ped_header 
           WHERE Ped_detalle.cdg_estado = "AA" 
              OR Ped_detalle.cdg_estado = "AM" EXCLUSIVE-LOCK:
    
            Ped_detalle.cdg_estado = p-nuevo_estado.
            CREATE Hst_pedido.
            ASSIGN Hst_pedido.cdg_estado         = p-nuevo_estado
                   Hst_pedido.fch_cambio         = TODAY
                   Hst_pedido.hor_cambio         = TIME
                   Hst_pedido.hms_cambio         = STRING(Hst_pedido.hor_cambio,"HH:MM:SS")
                   Hst_pedido.nro_linea          = Ped_detalle.nro_linea
                   Hst_pedido.nro_pedido         = Ped_detalle.nro_pedido
                   Hst_pedido.nro_usuario        = Usuario.nro_usuario
                   Hst_pedido.observacion        = v-observacion.
    
       END.       
    
       ASSIGN
            Ped_header.org_estado = Ped_header.cdg_estado
            Ped_header.cdg_estado = p-nuevo_estado.

       RELEASE Hst_pedido.
       RELEASE Ped_detalle.   
    
    END.

    v-observacion = "".
    DISPLAY v-observacion
            WITH FRAME {&FRAME-NAME}.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  btn_anular:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Ped_header.
  btn_cumplir:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Ped_header.

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
  {src/adm/template/snd-list.i "Ped_header"}
  {src/adm/template/snd-list.i "Cliente"}
  {src/adm/template/snd-list.i "Empresa"}

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

