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

DEFINE VARIABLE es_alta AS LOGICAL.
{findempresa.i}

DEFINE TEMP-TABLE lis
    FIELD cdg_puntovta LIKE punto-venta.cdg_puntovta
    FIELD dsc_puntovta LIKE punto-venta.dsc_puntovta
    FIELD aanual AS DECIMAL COLUMN-LABEL "A.Anual"
    FIELD ames AS DECIMAL COLUMN-LABEL "A.Mes"
    FIELD acuatri AS DECIMAL COLUMN-LABEL "A.Cuat"
    FIELD restanmes AS DECIMAL COLUMN-LABEL "Restan Mes"
    FIELD restancuatri AS DECIMAL COLUMN-LABEL "Restan Cuat".

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
&Scoped-define EXTERNAL-TABLES Punto-venta
&Scoped-define FIRST-EXTERNAL-TABLE Punto-venta


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Punto-venta.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Punto-venta.fch_cierre Punto-venta.impresor ~
Punto-venta.cuit-real Punto-venta.prf_real Punto-venta.dsc_puntovta ~
Punto-venta.direccion Punto-venta.codigo_postal Punto-venta.localidad ~
Punto-venta.provincia Punto-venta.telefono Punto-venta.modo_fecha ~
Punto-venta.Habilitado Punto-venta.TP Punto-venta.categoria 
&Scoped-define ENABLED-TABLES Punto-venta
&Scoped-define FIRST-ENABLED-TABLE Punto-venta
&Scoped-Define ENABLED-OBJECTS RECT-1 AcumAnual AcumMes prorateoMes ~
AcumCuatri prorateocuatri 
&Scoped-Define DISPLAYED-FIELDS Punto-venta.cdg_puntovta ~
Punto-venta.fch_cierre Punto-venta.impresor Punto-venta.cuit-real ~
Punto-venta.prf_real Punto-venta.dsc_puntovta Punto-venta.direccion ~
Punto-venta.codigo_postal Punto-venta.localidad Punto-venta.provincia ~
Punto-venta.telefono Punto-venta.modo_fecha Punto-venta.Habilitado ~
Punto-venta.TP Punto-venta.categoria 
&Scoped-define DISPLAYED-TABLES Punto-venta
&Scoped-define FIRST-DISPLAYED-TABLE Punto-venta
&Scoped-Define DISPLAYED-OBJECTS AcumAnual AcumMes prorateoMes AcumCuatri ~
prorateocuatri 

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
DEFINE VARIABLE AcumAnual AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "A.Anual" 
     VIEW-AS FILL-IN 
     SIZE 14.6 BY 1 TOOLTIP "Acumulado Anual" NO-UNDO.

DEFINE VARIABLE AcumCuatri AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "A.Cuat" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 TOOLTIP "Acumulado Cuatrimestral" NO-UNDO.

DEFINE VARIABLE AcumMes AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "A.Mes" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1 TOOLTIP "Acumulado Mensual" NO-UNDO.

DEFINE VARIABLE prorateocuatri AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Restan" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Prorateo vs maximos Cuatrimestrales" NO-UNDO.

DEFINE VARIABLE prorateoMes AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Restan" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Prorateo vs maximos Mensuales" NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 107 BY 8.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Punto-venta.cdg_puntovta AT ROW 1.24 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.fch_cierre AT ROW 1.24 COL 30.6 COLON-ALIGNED
          LABEL "Ult.Cier."
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1 TOOLTIP "Ultimo Cierre"
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.impresor AT ROW 1.24 COL 49.4 COLON-ALIGNED
          LABEL "PI"
          VIEW-AS FILL-IN 
          SIZE 10 BY 1 TOOLTIP "Posfijo Impresor"
     Punto-venta.cuit-real AT ROW 1.24 COL 69.8 COLON-ALIGNED WIDGET-ID 20
          LABEL "CUITR"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.prf_real AT ROW 1.24 COL 98.8 COLON-ALIGNED WIDGET-ID 18
          LABEL "Prf Real"
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.dsc_puntovta AT ROW 2.43 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 91 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.direccion AT ROW 3.62 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 91 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.codigo_postal AT ROW 4.81 COL 14.2 COLON-ALIGNED
          LABEL "C.P. y Local."
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.localidad AT ROW 4.81 COL 25 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 42 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.provincia AT ROW 4.81 COL 78 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 27 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.telefono AT ROW 6 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 35 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.modo_fecha AT ROW 6 COL 86 COLON-ALIGNED
          LABEL "Toma Fecha"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Del Sistema","S",
                     "De la Tabla","T"
          DROP-DOWN-LIST
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Punto-venta.Habilitado AT ROW 6.1 COL 56 WIDGET-ID 2
          VIEW-AS TOGGLE-BOX
          SIZE 15 BY .81
     Punto-venta.TP AT ROW 7.19 COL 14.2 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN 
          SIZE 3 BY 1
     Punto-venta.categoria AT ROW 7.19 COL 23 COLON-ALIGNED WIDGET-ID 6
          LABEL "Cat"
          VIEW-AS FILL-IN 
          SIZE 4 BY 1 TOOLTIP "Categoria de Mono si corresponde"
     AcumAnual AT ROW 7.19 COL 36.4 COLON-ALIGNED WIDGET-ID 8
     AcumMes AT ROW 7.19 COL 61 COLON-ALIGNED WIDGET-ID 14
     prorateoMes AT ROW 7.19 COL 90.4 COLON-ALIGNED WIDGET-ID 12
     AcumCuatri AT ROW 8.38 COL 36 COLON-ALIGNED WIDGET-ID 10
     prorateocuatri AT ROW 8.38 COL 90.4 COLON-ALIGNED WIDGET-ID 16
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Punto-venta
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
         HEIGHT             = 11.48
         WIDTH              = 108.6.
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

ASSIGN 
       AcumAnual:HIDDEN IN FRAME F-Main           = TRUE
       AcumAnual:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       AcumCuatri:HIDDEN IN FRAME F-Main           = TRUE
       AcumCuatri:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       AcumMes:HIDDEN IN FRAME F-Main           = TRUE
       AcumMes:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN Punto-venta.categoria IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Punto-venta.cdg_puntovta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Punto-venta.codigo_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Punto-venta.cuit-real IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Punto-venta.fch_cierre IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Punto-venta.impresor IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Punto-venta.modo_fecha IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Punto-venta.prf_real IN FRAME F-Main
   EXP-LABEL                                                            */
ASSIGN 
       prorateocuatri:HIDDEN IN FRAME F-Main           = TRUE
       prorateocuatri:READ-ONLY IN FRAME F-Main        = TRUE.

ASSIGN 
       prorateoMes:HIDDEN IN FRAME F-Main           = TRUE
       prorateoMes:READ-ONLY IN FRAME F-Main        = TRUE.

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
  {src/adm/template/row-list.i "Punto-venta"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Punto-venta"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   es_alta = YES.
   Punto-venta.cdg_puntovta:SENSITIVE IN FRAME {&FRAME-NAME} = YES.



  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  
  DEFINE BUFFER B-Punto-venta FOR Punto-venta.
  
   {findempresa.i}

  IF es_alta
  THEN DO:
      IF CAN-FIND(Punto-venta WHERE Punto-venta.cdg_puntovta = Punto-venta.cdg_puntovta:INPUT-VALUE IN FRAME {&FRAME-NAME}
                                AND Punto-venta.cdg_empresa  = Empresa.cdg_empresa)
      THEN DO:
          RUN ponmensj.p ( INPUT "PVTA004").
          RETURN ERROR.
      END.

    IF INPUT FRAME {&FRAME-NAME} Punto-venta.cdg_puntovta = "0000" 
    THEN DO:
         RUN PONMENSJ.P (INPUT "PVTA005").
         RETURN ERROR.
    END.                    
    
    IF INPUT FRAME {&FRAME-NAME} Punto-venta.dsc_puntovta = ""  
    THEN DO:
         RUN PONMENSJ.P (INPUT "PVTA006").
         RETURN ERROR.
    END.   

  END.
  ELSE DO:
      IF CAN-FIND(B-Punto-venta WHERE B-Punto-venta.cdg_puntovta = Punto-venta.cdg_puntovta:INPUT-VALUE IN FRAME {&FRAME-NAME}
                                  AND B-Punto-venta.cdg_empresa  = Empresa.cdg_empresa
                                  AND ROWID(B-Punto-venta) <> ROWID(B-Punto-venta))
      THEN DO:
          RUN ponmensj.p ( INPUT "PVTA004").
          RETURN ERROR.
      END.
  END.
  IF INPUT FRAME {&FRAME-NAME} Punto-venta.categoria <> ""  
  THEN DO:
         FIND categmono WHERE categmono.categoria = Punto-venta.categoria:INPUT-VALUE NO-LOCK NO-ERROR.
         IF NOT AVAILABLE categmono THEN DO:
             MESSAGE "Ingrese la gategoria del monotributista" VIEW-AS ALERT-BOX ERROR.
             RETURN ERROR.
         END.
  END.   


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   ASSIGN FRAME {&FRAME-NAME} Punto-venta.cdg_puntovta.
   
   {findempresa.i}
   Punto-venta.cdg_empresa = Empresa.cdg_empresa.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   es_alta = YES.
   Punto-venta.cdg_puntovta:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

   {validabaja.i "Punto-venta" "vlb-puntoventa.p"}
   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

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

  es_alta = NO.
  Punto-venta.cdg_puntovta:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  AcumAnual:SENSITIVE = no.
  AcumCuatri:SENSITIVE = no.
  AcumMes:SENSITIVE = no.
  prorateoCuatri:SENSITIVE = no.
  prorateoMes:SENSITIVE = no.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR aca AS DECIMAL NO-UNDO.
DEFINE VAR acc AS DECIMAL NO-UNDO.
DEFINE VAR acm AS DECIMAL NO-UNDO.
DEFINE VAR periodo AS INT NO-UNDO.
DEFINE VAR peranu AS INT NO-UNDO.
DEFINE VAR percua AS INT NO-UNDO.

/*esto tiene errores ya que no contempla cambios de los montos 
por categoria durante el periodo de calculo*/

  /* Code placed here will execute PRIOR to standard behavior. */
    AcumAnual:HIDDEN IN FRAME {&FRAME-NAME} = punto-venta.tp <> "M".
    AcumCuatri:HIDDEN = punto-venta.tp <> "M".
    AcumMes:HIDDEN = punto-venta.tp <> "M".
    prorateocuatri:HIDDEN = punto-venta.tp <> "M".
    prorateomes:HIDDEN = punto-venta.tp <> "M".

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  aca = 0.
IF punto-venta.tp = "M" THEN DO:
    periodo = YEAR(TODAY) * 100 + MONTH(TODAY).
    peranu =  YEAR(TODAY) * 100 + 1.
    IF MONTH(TODAY) <= 3 THEN percua = ( YEAR(TODAY) - 1 ) * 100 + MONTH(TODAY) - 4.
    ELSE percua = YEAR(TODAY) * 100 + MONTH(TODAY) - 3.

    FOR EACH  Acumulado_punto_venta NO-LOCK WHERE Acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND
                    Acumulado_punto_venta.cdg_puntovta = punto-venta.cdg_puntovta AND 
                     Acumulado_punto_venta.periodo >= peranu:
        aca = aca + Acumulado_punto_venta.importe.
    END.
    acc = 0.
    FOR EACH  Acumulado_punto_venta NO-LOCK WHERE Acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND
                    Acumulado_punto_venta.cdg_puntovta = punto-venta.cdg_puntovta AND 
                     Acumulado_punto_venta.periodo >= percua:
        acc = acc + Acumulado_punto_venta.importe.
    END.
    acm = 0.
    FIND Acumulado_punto_venta WHERE Acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND
                    Acumulado_punto_venta.cdg_puntovta = punto-venta.cdg_puntovta AND 
                     Acumulado_punto_venta.periodo = periodo NO-LOCK NO-ERROR.
    IF AVAILABLE  Acumulado_punto_venta THEN
        acm = Acumulado_punto_venta.importe.
    aca = - aca. 
    acc = - acc.
    acm = - acm.
    DISPLAY aca @ AcumAnual
            acc @ AcumCuatri
            acm @ AcumMes 
                WITH FRAME {&FRAME-NAME}.
    FIND categmono WHERE categmono.categoria = punto-venta.categoria NO-LOCK NO-ERROR.
    IF AVAILABLE categmono THEN 
        DISPLAY (categMono.limiteCuatrimestre  - acc) @ prorateocuatri
                (categMono.limiteCuatrimestre / 4 - acm) @ prorateomes
            WITH FRAME {&FRAME-NAME}.
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
    AcumAnual:HIDDEN IN FRAME {&FRAME-NAME} = punto-venta.tp <> "M".
    AcumCuatri:HIDDEN = punto-venta.tp <> "M".
    AcumMes:HIDDEN = punto-venta.tp <> "M".
    prorateoMes:HIDDEN = punto-venta.tp <> "M".
    prorateoCuatri:HIDDEN = punto-venta.tp <> "M".
    AcumAnual:SENSITIVE IN FRAME {&FRAME-NAME} = punto-venta.tp = "M".
    AcumCuatri:SENSITIVE = punto-venta.tp = "M".
    AcumMes:SENSITIVE = punto-venta.tp = "M".
    prorateoCuatri:SENSITIVE = punto-venta.tp = "M".
    prorateoMes:SENSITIVE = punto-venta.tp = "M".


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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE lstimprime V-table-Win 
PROCEDURE lstimprime :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bpunto-venta FOR punto-venta.
    DEFINE VAR aca AS DECIMAL NO-UNDO.
    DEFINE VAR acc AS DECIMAL NO-UNDO.
    DEFINE VAR acm AS DECIMAL NO-UNDO.
    DEFINE VAR periodo AS INT NO-UNDO.
    DEFINE VAR peranu AS INT NO-UNDO.
    DEFINE VAR percua AS INT NO-UNDO.

    /*esto tiene errores ya que no contempla cambios de los montos 
    por categoria durante el periodo de calculo*/
FOR EACH bpunto-venta NO-LOCK WHERE bpunto-venta.habilitado:
     CREATE lis.
     BUFFER-COPY bpunto-venta TO lis.
      aca = 0.
    IF bpunto-venta.tp = "M" THEN DO:
        periodo = YEAR(TODAY) * 100 + MONTH(TODAY).
        peranu =  YEAR(TODAY) * 100 + 1.
        IF MONTH(TODAY) <= 3 THEN percua = ( YEAR(TODAY) - 1 ) * 100 + MONTH(TODAY) - 4.
        ELSE percua = YEAR(TODAY) * 100 + MONTH(TODAY) - 3.

        FOR EACH  Acumulado_punto_venta NO-LOCK WHERE Acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND
                        Acumulado_punto_venta.cdg_puntovta = bpunto-venta.cdg_puntovta AND 
                         Acumulado_punto_venta.periodo >= peranu:
            aca = aca + Acumulado_punto_venta.importe.
        END.
        acc = 0.
        FOR EACH  Acumulado_punto_venta NO-LOCK WHERE Acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND
                        Acumulado_punto_venta.cdg_puntovta = bpunto-venta.cdg_puntovta AND 
                         Acumulado_punto_venta.periodo >= percua:
            acc = acc + Acumulado_punto_venta.importe.
        END.
        acm = 0.
        FIND Acumulado_punto_venta WHERE Acumulado_punto_venta.cdg_empresa = empresa.cdg_empresa AND
                        Acumulado_punto_venta.cdg_puntovta = bpunto-venta.cdg_puntovta AND 
                         Acumulado_punto_venta.periodo = periodo NO-LOCK NO-ERROR.
        IF AVAILABLE  Acumulado_punto_venta THEN
            acm = Acumulado_punto_venta.importe.
        aca = - aca. 
        acc = - acc.
        acm = - acm.
        ASSIGN lis.aanual = aca
               lis.acuatri = acc
               lis.ames = acm.
                
        FIND categmono WHERE categmono.categoria = bpunto-venta.categoria NO-LOCK NO-ERROR.
        IF AVAILABLE categmono THEN 
            ASSIGN lis.restanmes = (categMono.limiteCuatrimestre  - acc)
                   lis.restancuatri = ( categMono.limiteCuatrimestre / 4 - acm ).
    END.
END.
OUTPUT TO c:\temp\listamono.csv.
EXPORT DELIMITER ";" "PRF" "Descripcion" "A.Anual" "A.Mes" "A.Cuat" "RestoMes" "RestoCuat".
FOR EACH lis:
    EXPORT DELIMITER ";" lis.
END.
OUTPUT CLOSE.
MESSAGE "Listado generado en c:\temp\listmono.csv" VIEW-AS ALERT-BOX INFORMATION.
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
  {src/adm/template/snd-list.i "Punto-venta"}

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

