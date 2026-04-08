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

DEFINE VARIABLE rid_tabla AS ROWID.
DEF VAR hcproc AS CHAR NO-UNDO.
DEF VAR hproc AS HANDLE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Contrato_dt Contrato_hd
&Scoped-define FIRST-EXTERNAL-TABLE Contrato_dt


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Contrato_dt, Contrato_hd.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Contrato_dt.cantidad Contrato_dt.precio ~
Contrato_dt.precio_cf Contrato_dt.Descrenov Contrato_dt.descuento ~
Contrato_dt.anticipo Contrato_dt.anticipo_cf Contrato_dt.solocuota1 ~
Contrato_dt.detallada Contrato_dt.documental 
&Scoped-define ENABLED-TABLES Contrato_dt
&Scoped-define FIRST-ENABLED-TABLE Contrato_dt
&Scoped-Define ENABLED-OBJECTS RECT-9 v-cdg_articulo Rdescrip 
&Scoped-Define DISPLAYED-FIELDS Contrato_dt.cantidad Contrato_dt.precio ~
Contrato_dt.precio_cf Contrato_dt.Descrenov Contrato_dt.descuento ~
Contrato_dt.anticipo Contrato_dt.anticipo_cf Contrato_dt.solocuota1 ~
Contrato_dt.detallada Contrato_dt.documental 
&Scoped-define DISPLAYED-TABLES Contrato_dt
&Scoped-define FIRST-DISPLAYED-TABLE Contrato_dt
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo incl_iva ~
c_precio_cf c_precio Rdescrip 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */
&Scoped-define ADM-CREATE-FIELDS v-cdg_articulo Contrato_dt.cantidad 
&Scoped-define ADM-ASSIGN-FIELDS v-cdg_articulo Contrato_dt.cantidad 

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
DEFINE VARIABLE c_precio AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Precio" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE c_precio_cf AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Precio C.F" 
     VIEW-AS FILL-IN 
     SIZE 18.6 BY 1
     BGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 52 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE Rdescrip AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "FAC", 1,
"PRE", 2
     SIZE 8 BY 1.19 TOOLTIP "Tipo de descripcion" NO-UNDO.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 112 BY 3.57.

DEFINE VARIABLE incl_iva AS LOGICAL INITIAL yes 
     LABEL "Iva Incluido" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 TOOLTIP "Si es verdadero permite ingresar los precios con el iva incluido" NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_articulo AT ROW 1.24 COL 9 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.24 COL 29 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     Contrato_dt.cantidad AT ROW 1.24 COL 91 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_dt.precio AT ROW 2.43 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_dt.precio_cf AT ROW 2.43 COL 91 COLON-ALIGNED WIDGET-ID 8
          VIEW-AS FILL-IN NATIVE 
          SIZE 18.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     incl_iva AT ROW 2.52 COL 8 WIDGET-ID 6
     Contrato_dt.Descrenov AT ROW 2.52 COL 26 WIDGET-ID 20
          VIEW-AS TOGGLE-BOX
          SIZE 16 BY .81
     Contrato_dt.descuento AT ROW 3.43 COL 32 COLON-ALIGNED WIDGET-ID 22
          LABEL "Desc%" FORMAT ">9.9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_dt.anticipo AT ROW 3.48 COL 56 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1 TOOLTIP "Anticipo es en valor monetario"
          BGCOLOR 15 FGCOLOR 9 
     Contrato_dt.anticipo_cf AT ROW 3.48 COL 91 COLON-ALIGNED WIDGET-ID 10
          LABEL "Anticipo C.F."
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Contrato_dt.solocuota1 AT ROW 3.62 COL 8 WIDGET-ID 12
          LABEL "Cuota1"
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY .81 TOOLTIP "Si este concepto se facturara en la primer cuota"
     c_precio_cf AT ROW 4.67 COL 91.4 COLON-ALIGNED WIDGET-ID 26
     c_precio AT ROW 4.71 COL 56 COLON-ALIGNED WIDGET-ID 28
     Contrato_dt.detallada AT ROW 5.95 COL 1.6 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 105 BY 3.43 TOOLTIP "Se puede utilizar &MES &ANO &CUOTA &DECUOTA &TANQUE &DETALLADA &DESC"
          BGCOLOR 15 FGCOLOR 7 
     Contrato_dt.documental AT ROW 6.05 COL 2 NO-LABEL WIDGET-ID 18
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 105 BY 3.19 TOOLTIP "Descripcion Documental"
          BGCOLOR 11 
     Rdescrip AT ROW 7 COL 107 NO-LABEL WIDGET-ID 14
     "No se aplican descuentos sobre anticipos" VIEW-AS TEXT
          SIZE 41 BY .71 AT ROW 4.81 COL 3 WIDGET-ID 30
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Contrato_dt,sic.Contrato_hd
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
         HEIGHT             = 8.52
         WIDTH              = 115.4.
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
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Contrato_dt.anticipo_cf IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Contrato_dt.cantidad IN FRAME F-Main
   1 2                                                                  */
/* SETTINGS FOR FILL-IN c_precio IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       c_precio:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN c_precio_cf IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       c_precio_cf:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Contrato_dt.descuento IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
ASSIGN 
       Contrato_dt.documental:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR TOGGLE-BOX incl_iva IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Contrato_dt.solocuota1 IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME F-Main
   1 2                                                                  */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK KEEP-EMPTY"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Contrato_dt.descuento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_dt.descuento V-table-Win
ON LEAVE OF Contrato_dt.descuento IN FRAME F-Main /* Desc% */
DO:
    RUN calcular_valores ( IF incl_iva THEN "precio_cf" ELSE "precio" ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME incl_iva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL incl_iva V-table-Win
ON VALUE-CHANGED OF incl_iva IN FRAME F-Main /* Iva Incluido */
DO:
  ASSIGN incl_iva.
  IF AVAILABLE contrato_dt THEN DO:
  
  FIND lista_precios WHERE lista_precios.cdg_lista = contrato_hd.cdg_lista NO-LOCK NO-ERROR.
  IF NOT AVAILABLE lista_precios THEN DO:
      contrato_dt.precio:SENSITIVE            = NOT incl_iva.
      contrato_dt.precio_cf:SENSITIVE         = incl_iva.
  END.
  ELSE DO:
      contrato_dt.precio:SENSITIVE            = FALSE.
      contrato_dt.precio_cf:SENSITIVE         = FALSE.
  END.
  contrato_dt.anticipo:SENSITIVE          = NOT incl_iva AND NOT solocuota1.
  contrato_dt.anticipo_cf:SENSITIVE       = incl_iva AND NOT solocuota1.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Rdescrip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Rdescrip V-table-Win
ON VALUE-CHANGED OF Rdescrip IN FRAME F-Main
DO:
    ASSIGN rdescrip.
    IF rdescrip = 1 THEN DO:
      contrato_dt.detallada:HIDDEN = FALSE.
      contrato_dt.documental:HIDDEN = TRUE.
      contrato_dt.detallada:SENSITIVE = v-cdg_articulo:SENSITIVE.
        
    END.
    ELSE DO:
      contrato_dt.detallada:HIDDEN = TRUE.
      contrato_dt.documental:HIDDEN = FALSE.
      contrato_dt.documental:SENSITIVE =  v-cdg_articulo:SENSITIVE.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Contrato_dt.solocuota1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Contrato_dt.solocuota1 V-table-Win
ON VALUE-CHANGED OF Contrato_dt.solocuota1 IN FRAME F-Main /* Cuota1 */
DO:
  IF {&SELF-NAME}:CHECKED THEN DO:
        anticipo_cf:SCREEN-VALUE = "0,00".
        anticipo:SCREEN-VALUE = "0,00".
        anticipo:SENSITIVE = FALSE.
        anticipo_cf:SENSITIVE = FALSE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON LEAVE OF v-cdg_articulo IN FRAME F-Main /* Artículo */
DO:
 IF v-cdg_articulo:SCREEN-VALUE <> "" THEN RUN poner_articulo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_articulo IN FRAME F-Main /* Artículo */
OR "." OF v-cdg_articulo IN FRAME {&FRAME-NAME}
OR "*" OF v-cdg_articulo IN FRAME {&FRAME-NAME}
OR F1 OF v-cdg_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_articulo IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE rid_articulo AS ROWID.

  RUN selartic.p ( INPUT-OUTPUT rid_articulo, 
                   "V",
                   INPUT YES ).

  IF rid_articulo <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
       DISPLAY Articulo.cdg_articulo  @ v-cdg_articulo
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_articulo IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON RETURN OF v-cdg_articulo IN FRAME F-Main /* Artículo */
DO:
RUN poner_articulo.
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
  {src/adm/template/row-list.i "Contrato_dt"}
  {src/adm/template/row-list.i "Contrato_hd"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Contrato_dt"}
  {src/adm/template/row-find.i "Contrato_hd"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE blockpanel V-table-Win 
PROCEDURE blockpanel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM blk AS LOGICAL NO-UNDO.

RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "TableIO-source",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
        IF blk THEN
         RUN set-buttons IN hproc ( 'disable-all' ).
        ELSE 
         RUN set-buttons IN hproc ( 'initial' ).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_valores V-table-Win 
PROCEDURE calcular_valores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER campo AS char NO-UNDO.
DEFINE VARIABLE que_tasa LIKE Impuesto_condicion.tasa.
/* --------------------------------------------------- */
          /*  El precio a CF es el precio + impuestos. SI no hay */
          /*  impuestos, el precio_cf quedará igual al precio    */
          /* --------------------------------------------------- */


IF NOT AVAILABLE articulo THEN DO:
            MESSAGE "Articulo no seleccionado" VIEW-AS ALERT-BOX ERROR.
            RETURN ERROR.
END.
RUN hallar_iva_detalle ( OUTPUT que_tasa ).
IF contrato_dt.cantidad:INPUT-VALUE IN FRAME {&FRAME-NAME}= 0.0 THEN contrato_dt.cantidad:SCREEN-VALUE = "1".


/*vemos si es por lista de precios o no*/
FIND lista_precios WHERE lista_precios.cdg_lista = contrato_hd.cdg_lista AND 
         Lista_Precios.rige_desde <= contrato_hd.rige_desde AND 
         Lista_Precios.rige_hasta >= contrato_hd.rige_desde NO-LOCK NO-ERROR.
IF AVAILABLE lista_precios THEN DO:
     FOR FIRST articulo_precio OF articulo NO-LOCK WHERE 
                  articulo_precio.cdg_lista = lista_precios.cdg_lista AND
                  Articulo_precio.desde_cantidad <= INPUT contrato_dt.cantidad AND 
                  Articulo_precio.hasta_cantidad >= INPUT contrato_dt.cantidad AND
                  Articulo_precio.fch_desde <= contrato_hd.rige_desde  BY  sic.Articulo_precio.fch_desde DESC:
          contrato_dt.precio_cf:SCREEN-VALUE = string(articulo_precio.precio_cf).
          campo = "precio_cf".
          incl_iva = TRUE.
     END.
END.

IF campo = "precio" THEN 
        ASSIGN contrato_dt.precio_cf:SCREEN-VALUE = string(contrato_dt.precio:INPUT-VALUE * ( 1 + que_tasa / 100))
               contrato_dt.anticipo_cf:SCREEN-VALUE = string(contrato_dt.anticipo:INPUT-VALUE * ( 1 + que_tasa / 100)).
IF campo = "precio_cf" Then     
        ASSIGN contrato_dt.precio:SCREEN-VALUE = string(contrato_dt.precio_cf:INPUT-VALUE / ( 1 + que_tasa / 100))
               contrato_dt.anticipo:SCREEN-VALUE = string(contrato_dt.anticipo_cf:INPUT-VALUE / ( 1 + que_tasa / 100)).

c_precio =  contrato_dt.precio:INPUT-VALUE * contrato_dt.cantidad:INPUT-VALUE * ( 1 - contrato_dt.descuento:INPUT-VALUE / 100 ) + contrato_dt.anticipo:INPUT-VALUE.
c_precio_cf =  contrato_dt.precio_cf:INPUT-VALUE * contrato_dt.cantidad:INPUT-VALUE * ( 1 - contrato_dt.descuento:INPUT-VALUE / 100 ) + contrato_dt.anticipo_cf:INPUT-VALUE.
DISPLAY c_precio c_precio_cf WITH FRAME {&FRAME-NAME}.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE hallar_iva_detalle V-table-Win 
PROCEDURE hallar_iva_detalle :
DEFINE OUTPUT PARAMETER p-tasa LIKE Impuesto_condicion.tasa.
DEFINE VAR comprobante AS CHAR NO-UNDO. 

 p-tasa = 0.
 /*ver si el comprobante aplica impuestos o no*/
 /*El contrato se va a facturar y depende del punto de venta si es una empresa ( FACTUCLI )
 o un monotributista (FACTUCLM) los impuestos a aplicarles*/
 FIND Punto-venta NO-LOCK WHERE Punto-venta.cdg_puntovta = contrato_hd.prf_contrato.
       comprobante = IF Punto-venta.TP = "E" THEN "FACTUCLI" ELSE "FACTUCLM".

 FIND tipocomprobante WHERE Tipocomprobante.cdg_comprobante = comprobante and
     tipocomprobante.cdg_empresa = contrato_hd.cdg_empresa NO-LOCK.
 IF Tipocomprobante.aplica_impuestos THEN DO:
      
     FIND Familia_impositiva OF Articulo NO-LOCK.
        
     FIND first Impuesto_condicion OF  Familia_impositiva 
           WHERE Impuesto_condicion.cdg_condiva = contrato_hd.cdg_condiva
             AND Impuesto_condicion.cdg_empresa = contrato_hd.cdg_empresa 
             AND Impuesto_condicion.fch_desde <= contrato_hd.rige_hasta
             AND Impuesto_condicion.fch_hasta >= contrato_hd.rige_desde
             AND CAN-DO(Impuesto_condicion.lista_provincias,contrato_hd.cdg_provincia) 
             AND CAN-FIND(FIRST Impuesto OF Impuesto_condicion WHERE Impuesto.es_iva) NO-LOCK NO-ERROR.
     IF AVAILABLE Impuesto_condicion THEN DO:
         FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = contrato_hd.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= contrato_hd.rige_hasta
                        AND Cliente_excencion.fch_hasta >= contrato_hd.rige_desde NO-LOCK NO-ERROR.
        
         IF NOT AVAILABLE Cliente_excencion
             THEN p-tasa = Impuesto_condicion.tasa.
             ELSE p-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
              
     END.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
   /* Code placed here will execute PRIOR to standard behavior. */
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
 
  {blanqueacodigo.i "Articulo"}

   rdescrip = 1.
   DISPLAY rdescrip contrato_dt.detallada contrato_dt.documental 
       WITH FRAME {&FRAME-NAME}.
   contrato_dt.detallada:HIDDEN = FALSE.
   contrato_dt.documental:HIDDEN = TRUE.
   
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN FRAME {&FRAME-NAME} v-cdg_articulo .

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .
  IF NEW Contrato_dt
   THEN DO:
       FIND CURRENT Contrato_hd EXCLUSIVE-LOCK.  
       ASSIGN Contrato_hd.ultima_linea = Contrato_hd.ultima_linea + 1
              Contrato_dt.nro_contrato = Contrato_hd.nro_contrato
              Contrato_dt.nro_linea = Contrato_hd.ultima_linea.
       FIND CURRENT Contrato_hd NO-LOCK.
   END.
  /* Code placed here will execute AFTER standard behavior.    */
   
ASSIGN FRAME {&FRAME-NAME} contrato_dt.detallada contrato_dt.documental.
   &SCOPED-DEFINE TABLA-MAESTRA  Contrato_dt

   {asignartabla.i "Articulo" "nro_articulo" "nro_articulo"} 

   RUN calcular_valores ( IF incl_iva THEN "precio_cf" ELSE "precio" ).

   ASSIGN contrato_dt.precio_cf contrato_dt.precio contrato_dt.anticipo contrato_dt.anticipo_cf.

   &UNDEFINE TABLA-MAESTRA
   
   ASSIGN contrato_dt.cantidad = IF contrato_dt.cantidad = 0 THEN 1 ELSE contrato_dt.cantidad.

   ASSIGN 
          contrato_dt.subtotal_neto =  contrato_dt.precio * contrato_dt.cantidad  * ( 1 - contrato_dt.descuento / 100 ) + contrato_dt.anticipo
          contrato_dt.subtotal_neto_cf =  contrato_dt.precio_cf * contrato_dt.cantidad  *  ( 1 - contrato_dt.descuento / 100 ) + contrato_dt.anticipo_cf
          contrato_dt.subtotal_bruto = contrato_dt.subtotal_neto
          contrato_dt.subtotal_gral = contrato_dt.subtotal_neto_cf
          contrato_dt.subtotal_bruto_cf = contrato_dt.subtotal_neto_cf.

   RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "refresco-target",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
         RUN dispatch IN hproc ( INPUT 'totales':U).
    END.
   END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-delete-record V-table-Win 
PROCEDURE local-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

   RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "refresco-target",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
         RUN dispatch IN hproc ( INPUT 'totales':U).
    END.

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

  {deshabcodigo.i "Articulo"}

  contrato_dt.precio:SENSITIVE            = FALSE.
  contrato_dt.precio_cf:SENSITIVE         = FALSE.
  contrato_dt.anticipo:SENSITIVE          = FALSE.
  contrato_dt.anticipo_cf:SENSITIVE       = FALSE.
  incl_iva:SENSITIVE = FALSE.
  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "refresco-target",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
         RUN blockpanel IN hproc ( FALSE ).
    END.

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
  IF AVAILABLE Contrato_dt
  THEN DO:
        &SCOPED-DEFINE TABLA-MAESTRA  Contrato_dt
        {displaytabla.i "Articulo" "cdg_articulo" "descripcion" "nro_articulo" "nro_articulo"} 
        &UNDEFINE TABLA-MAESTRA
        IF rdescrip = 1 THEN DO:
              contrato_dt.detallada:HIDDEN = FALSE.
              contrato_dt.documental:HIDDEN = TRUE.
            END.
            ELSE DO:
              contrato_dt.detallada:HIDDEN = TRUE.
              contrato_dt.documental:HIDDEN = FALSE.
            END.
        
            /*RUN calcular_valores ( "precio_cf").*/
  END.
  ELSE DO:
      rdescrip = 1.
      {blanqueacodigo.i "Articulo"}
  END.
  
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

  {habilcodigo.i "Articulo"}
  FIND lista_precios WHERE lista_precios.cdg_lista = contrato_hd.cdg_lista NO-LOCK NO-ERROR.
  IF NOT AVAILABLE lista_precios THEN DO:
      contrato_dt.precio:SENSITIVE            = NOT incl_iva.
      contrato_dt.precio_cf:SENSITIVE         = incl_iva.
  END.
  ELSE DO:
      contrato_dt.precio:SENSITIVE            = FALSE.
      contrato_dt.precio_cf:SENSITIVE         = FALSE.
  END.
      contrato_dt.anticipo:SENSITIVE          = NOT incl_iva AND NOT INPUT solocuota1.
      contrato_dt.anticipo_cf:SENSITIVE       = incl_iva AND NOT INPUT solocuota1.
  
  incl_iva:SENSITIVE = TRUE.

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "refresco-target",
      OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN 
    do:
         RUN blockpanel IN hproc ( true ).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_articulo V-table-Win 
PROCEDURE poner_articulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       

------------------------------------------------------------------------------*/
  IF NOT AVAILABLE contrato_hd THEN DO:
            MESSAGE "No tiene un contrato seleccionado o no creo la cabecera del mismo"
            VIEW-as ALERT-BOX ERROR.
            RETURN ERROR.
   END.
   &SCOPED-DEFINE PONER-TABLA 
     {traducetabla.i "Articulo" "cdg_articulo" "descripcion"} 
   &UNDEFINE PONER-TABLA
  
  FIND articulo WHERE articulo.cdg_articulo = INPUT v-cdg_articulo NO-LOCK NO-ERROR.
  IF NOT AVAILABLE articulo THEN DO:
        MESSAGE "Articulo invalido" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
  END.
     contrato_dt.documental:SCREEN-VALUE = articulo.documental.
     contrato_dt.detallada:SCREEN-VALUE = articulo.detallada.
     
      FIND lista_precios WHERE lista_precios.cdg_lista = contrato_hd.cdg_lista NO-LOCK NO-ERROR.
      IF NOT AVAILABLE lista_precios THEN DO:
             contrato_dt.precio:SENSITIVE            = NOT incl_iva.
             contrato_dt.precio_cf:SENSITIVE         = incl_iva.
      END.
      ELSE DO:
               FIND LAST Articulo_precio OF Articulo 
               WHERE Articulo_precio.cdg_lista   = Lista_precios.cdg_lista 
                 AND Articulo_precio.cdg_empresa = contrato_hd.cdg_empresa
                 AND Articulo_precio.fch_desde <= contrato_hd.rige_desde
                   NO-LOCK NO-ERROR.
               IF NOT AVAILABLE articulo_precio THEN
                   MESSAGE "El articulo no tiene precio en la lista designada" VIEW-AS ALERT-BOX INFORMATION.
               ELSE DO:
                  contrato_dt.precio:SCREEN-VALUE IN FRAME {&FRAME-NAME} = string(Articulo_precio.precio).
                  contrato_dt.precio_cf:SCREEN-VALUE = string(Articulo_precio.precio_cf).
               END.
               contrato_dt.precio:SENSITIVE            = NOT incl_iva.
               contrato_dt.precio_cf:SENSITIVE         = incl_iva.
      END.
      contrato_dt.anticipo:SENSITIVE          = NOT incl_iva.
      contrato_dt.anticipo_cf:SENSITIVE       = incl_iva.
      incl_iva:SENSITIVE = TRUE.
      RUN calcular_valores ( IF incl_iva THEN "precio_cf" ELSE "precio" ).

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
  {src/adm/template/snd-list.i "Contrato_dt"}
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

