&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
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

  DEFINE VARIABLE h AS HANDLE NO-UNDO.
  DEFINE VARIABLE c AS CHAR   NO-UNDO.

  DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
  
  {vrshared.i "NEW"}

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
&Scoped-define EXTERNAL-TABLES Ped_detalle Ped_header
&Scoped-define FIRST-EXTERNAL-TABLE Ped_detalle


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Ped_detalle, Ped_header.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Ped_detalle.cantidad Ped_detalle.precio ~
Ped_detalle.cantidad_ult Ped_detalle.granel_ult 
&Scoped-define ENABLED-TABLES Ped_detalle
&Scoped-define FIRST-ENABLED-TABLE Ped_detalle
&Scoped-Define ENABLED-OBJECTS BUTTON-1 RECT-10 RECT-11 RECT-12 
&Scoped-Define DISPLAYED-FIELDS Ped_detalle.cantidad Ped_detalle.precio ~
Ped_detalle.cantidad_ult Ped_detalle.granel_ult 
&Scoped-define DISPLAYED-TABLES Ped_detalle
&Scoped-define FIRST-DISPLAYED-TABLE Ped_detalle


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
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "&Adquirir Pesada" 
     SIZE 27 BY 1.14.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 3.91.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 1.33.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 1.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Ped_detalle.cantidad AT ROW 1.24 COL 5.2
          LABEL "Pendiente"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Ped_detalle.precio AT ROW 2.67 COL 14 COLON-ALIGNED
          LABEL "Precio Venta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Ped_detalle.cantidad_ult AT ROW 3.71 COL 14 COLON-ALIGNED
          LABEL "Esta Entrega"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Ped_detalle.granel_ult AT ROW 4.81 COL 14 COLON-ALIGNED
          LABEL "Kilaje Entrega"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BUTTON-1 AT ROW 6.48 COL 2
     RECT-10 AT ROW 2.33 COL 1
     RECT-11 AT ROW 1 COL 1
     RECT-12 AT ROW 6.24 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Ped_detalle,sic.Ped_header
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
         HEIGHT             = 11.71
         WIDTH              = 73.
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

/* SETTINGS FOR FILL-IN Ped_detalle.cantidad IN FRAME F-Main
   ALIGN-L EXP-LABEL                                                    */
/* SETTINGS FOR FILL-IN Ped_detalle.cantidad_ult IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Ped_detalle.granel_ult IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Ped_detalle.precio IN FRAME F-Main
   EXP-LABEL                                                            */
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

&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 V-table-Win
ON CHOOSE OF BUTTON-1 IN FRAME F-Main /* Adquirir Pesada */
DO:
  MESSAGE "Interface NO CONTESTA"
      VIEW-AS ALERT-BOX ERROR BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Ped_detalle.cantidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Ped_detalle.cantidad V-table-Win
ON LEAVE OF Ped_detalle.cantidad IN FRAME F-Main /* Pendiente */
DO:
  DISPLAY INPUT Ped_detalle.cantidad @ Ped_detalle.cantidad_ult
          WITH FRAME {&FRAME-NAME}.
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
  {src/adm/template/row-list.i "Ped_detalle"}
  {src/adm/template/row-list.i "Ped_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Ped_detalle"}
  {src/adm/template/row-find.i "Ped_header"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_remito_dt V-table-Win 
PROCEDURE crear_remito_dt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  Rem_header.ultima_linea = Rem_header.ultima_linea + 1.
  CREATE Rem_detalle.
  ASSIGN Rem_detalle.nro_remito    = Rem_header.nro_remito
         Rem_detalle.nro_linea     = Rem_header.ultima_linea
         Rem_detalle.nro_articulo  = Articulo.nro_articulo
         Rem_detalle.a_granel      = Articulo.a_granel
         Rem_detalle.precio        = Ped_detalle.precio
         Rem_detalle.cantidad      = 0 /* Luego se suma aqui Ped_detalle.cantidad_ult */
         Rem_detalle.granel        = 0
         Rem_detalle.nro_partida   = Ped_detalle.nro_partida.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_remito_hd V-table-Win 
PROCEDURE crear_remito_hd :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE VARIABLE cotiza_dolar LIKE Moneda.cambio.
   DEFINE VARIABLE codigo_dolar LIKE Moneda.cdg_moneda.
   DEFINE VARIABLE pto_venta LIKE Rem_header.prf_comprob.

   {parlocales.i}

   RUN getptovta.p ( INPUT "REM",
                     OUTPUT pto_venta).

   RUN getparametro.p (  INPUT  "DFNROCAJ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
 
   FIND Caja WHERE Caja.cdg_caja = v-valor_n NO-LOCK.
   act_caja = ROWID(Caja).

   RUN getparametro.p (  INPUT  "CDGDOLAR",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   codigo_dolar = v-valor_c.
   FIND Moneda WHERE Moneda.cdg_moneda = codigo_dolar NO-LOCK.
   cotiza_dolar = Moneda.cambio.

   RUN getparametro.p (  INPUT  "DFMONEDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
   act_moneda = ROWID(Moneda).

   RUN getparametro.p (  INPUT  "DFCNREMT",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.

  {findempresa.i}

   CREATE Rem_header.
   ASSIGN Rem_header.cdg_empresa      = Empresa.cdg_empresa
          Rem_header.cdg_imputacion   = Imputacion.cdg_imputacion
          Rem_header.cambio_dolar     = cotiza_dolar
          Rem_header.nro_moneda       = Moneda.nro_moneda
          Rem_header.cambio           = Moneda.cambio
          Rem_header.nro_cliente      = Ped_header.nro_cliente
          Rem_header.nro_domicilio    = Ped_header.nro_domicilio
          Rem_header.nro_cndventa     = Ped_header.nro_cndventa
          Rem_header.nro_vendedor     = Ped_header.nro_vendedor
          Rem_header.cdg_lista        = Ped_header.cdg_lista
          Rem_header.cdg_condiva      = Ped_header.cdg_condiva
          Rem_header.nro_deposito     = Deposito.nro_deposito
          Rem_header.nro_pedido       = Ped_header.nro_pedido  
          Rem_header.fecha            = TODAY
          Rem_header.nro_comprob      = NEXT-VALUE(proxima_transaccion)
          Rem_header.nro_entidad      = Ped_header.nro_entidad
          Rem_header.nro_remito       = Rem_header.nro_comprob
          Rem_header.nro_usuario      = Usuario.nro_usuario
          Rem_header.origen           = "A"
          Rem_header.prf_comprob      = pto_venta
          Rem_header.tip_comprob      = "RM"
          Rem_header.ultima_linea     = 0
          Rem_header.estado           = "X".
 
  /*
  Parametro.valor_n = Parametro.valor_n + 1.
  RELEASE Parametro.
  */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
/*
  IF AVAILABLE Ped_detalle 
     THEN ASSIGN
                v-cantidad = Ped_detalle.cantidad - Ped_detalle.cantidad_cum 
                v-precio   = Ped_detalle.precio.
*/        
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
/*
  IF AVAILABLE Ped_detalle
  THEN DO:
       ASSIGN btn_incluir-v:SENSITIVE IN FRAME {&FRAME-NAME}  = NOT Ped_detalle.cumplido
              btn_excluir-v:SENSITIVE IN FRAME {&FRAME-NAME}  = Ped_detalle.cumplido.
       ASSIGN Ped_detalle.cantidad_ult:SENSITIVE IN FRAME {&FRAME-NAME} = btn_incluir-v:SENSITIVE
              Ped_detalle.granel_ult:SENSITIVE IN FRAME {&FRAME-NAME}   = btn_incluir-v:SENSITIVE.
              
  END.              
  ELSE DO:
       ASSIGN btn_incluir-v:SENSITIVE IN FRAME {&FRAME-NAME}  = NO
              btn_excluir-v:SENSITIVE IN FRAME {&FRAME-NAME}  = NO.
  END.              
*/
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

  {findempresa.i}
  que_empresa = Empresa.cdg_empresa.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Ped_detalle"}
  {src/adm/template/snd-list.i "Ped_header"}

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

