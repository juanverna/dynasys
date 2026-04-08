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
&Scoped-define EXTERNAL-TABLES Rem_detalle
&Scoped-define FIRST-EXTERNAL-TABLE Rem_detalle


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Rem_detalle.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Rem_detalle.precio_cf Rem_detalle.precio 
&Scoped-define ENABLED-TABLES Rem_detalle
&Scoped-define FIRST-ENABLED-TABLE Rem_detalle
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Rem_detalle.cantidad Rem_detalle.precio_cf ~
Rem_detalle.precio Rem_detalle.detallada 
&Scoped-define DISPLAYED-TABLES Rem_detalle
&Scoped-define FIRST-DISPLAYED-TABLE Rem_detalle


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
DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 93 BY 8.57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Rem_detalle.cantidad AT ROW 1.24 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rem_detalle.precio_cf AT ROW 1.24 COL 48 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1 TOOLTIP "Precio mas impuestos"
          BGCOLOR 15 FGCOLOR 9 
     Rem_detalle.precio AT ROW 1.24 COL 73 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Rem_detalle.detallada AT ROW 2.62 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 89 BY 6.48
          BGCOLOR 15 FGCOLOR 7 
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: SIC.Rem_detalle
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
         HEIGHT             = 8.76
         WIDTH              = 102.8.
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

/* SETTINGS FOR FILL-IN Rem_detalle.cantidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR Rem_detalle.detallada IN FRAME F-Main
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

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Rem_detalle.precio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Rem_detalle.precio V-table-Win
ON LEAVE OF Rem_detalle.precio IN FRAME F-Main /* Precio */
DO:
   RUN calcular_valores(self:name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Rem_detalle.precio_cf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Rem_detalle.precio_cf V-table-Win
ON LEAVE OF Rem_detalle.precio_cf IN FRAME F-Main /* Precio C.F. */
DO:
   RUN calcular_valores(self:name).
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
  {src/adm/template/row-list.i "Rem_detalle"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Rem_detalle"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

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

RUN hallar_iva_detalle ( OUTPUT que_tasa ).
DO WITH FRAME {&FRAME-NAME}:
    IF Rem_detalle.cantidad:INPUT-VALUE = 0.0 THEN Rem_detalle.cantidad:SCREEN-VALUE = "1.0".
    IF campo = "precio" THEN
            Rem_detalle.precio_cf:SCREEN-VALUE = string(Rem_detalle.precio:INPUT-VALUE * ( 1 + que_tasa / 100)).
    IF campo = "precio_cf" Then     
            Rem_detalle.precio:SCREEN-VALUE = string(Rem_detalle.precio_cf:INPUT-VALUE / ( 1 + que_tasa / 100)).
END.
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
 
 p-tasa = 0.
 /*ver si el comprobante aplica impuestos o no*/
FIND rem_header OF rem_detalle NO-LOCK.
FIND articulo OF rem_detalle NO-LOCK.
 FIND tipocomprobante OF Rem_header NO-LOCK.
 IF Tipocomprobante.aplica_impuestos THEN DO:
      
     FIND Familia_impositiva OF Articulo NO-LOCK.
        
     FIND first Impuesto_condicion OF  Familia_impositiva 
           WHERE Impuesto_condicion.cdg_condiva = Rem_header.cdg_condiva
             AND Impuesto_condicion.cdg_empresa = Rem_header.cdg_empresa 
             AND Impuesto_condicion.fch_desde <= Rem_header.fecha_iva
             AND Impuesto_condicion.fch_hasta >= Rem_header.fecha_iva
             AND CAN-DO(Impuesto_condicion.lista_provincias,Rem_header.cdg_provincia) 
             AND CAN-FIND(FIRST Impuesto OF Impuesto_condicion WHERE Impuesto.es_iva) NO-LOCK NO-ERROR.
     IF AVAILABLE Impuesto_condicion THEN DO:
         FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = Rem_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= Rem_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= Rem_header.fecha_iva NO-LOCK NO-ERROR.
        
         IF NOT AVAILABLE Cliente_excencion
             THEN p-tasa = Impuesto_condicion.tasa.
             ELSE p-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
              
     END.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN FRAME {&FRAME-NAME} Rem_detalle.detallada
    Rem_detalle.subtotal_neto = Rem_detalle.precio:INPUT-VALUE * Rem_detalle.cantidad:INPUT-VALUE.
    Rem_detalle.subtotal_neto_cf = Rem_detalle.precio_cf:INPUT-VALUE * Rem_detalle.cantidad:INPUT-VALUE.


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

  ASSIGN Rem_detalle.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 7
         Rem_detalle.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  ASSIGN Rem_detalle.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 9
         Rem_detalle.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = YES.


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
  {src/adm/template/snd-list.i "Rem_detalle"}

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

