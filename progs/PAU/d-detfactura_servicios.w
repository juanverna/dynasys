&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Fac_detalle NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_detalle-bon NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE           p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE VARIABLE           p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
DEFINE VARIABLE           p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle-bon.
DEFINE INPUT   PARAMETER  p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE INPUT   PARAMETER  p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE OUTPUT  PARAMETER  p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

DEFINE VAR v-cdg_parametro LIKE Parametro.cdg_parametro NO-UNDO.
DEFINE VAR v-valor_c       LIKE Parametro.valor_c NO-UNDO. 
DEFINE VAR v-valor_d       LIKE Parametro.valor_d NO-UNDO. 
DEFINE VAR v-valor_l       LIKE Parametro.valor_l NO-UNDO. 
DEFINE VAR v-valor_n       LIKE Parametro.valor_n NO-UNDO. 
DEFINE VAR v-observacion   LIKE Parametro.observacion NO-UNDO.

DEF VAR  v-cdg_entidad AS CHAR INITIAL "P" NO-UNDO.
DEF VAR  v-cdg_obra AS INT INITIAL 1 NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Fac_detalle

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Fac_detalle.cantidad ~
T-Fac_detalle.precio T-Fac_detalle.precio_cf T-Fac_detalle.subtotal_neto_cf ~
T-Fac_detalle.subtotal_neto T-Fac_detalle.detallada 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Fac_detalle.cantidad ~
T-Fac_detalle.precio T-Fac_detalle.precio_cf T-Fac_detalle.detallada 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Fac_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Fac_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Fac_detalle.cantidad T-Fac_detalle.precio ~
T-Fac_detalle.precio_cf T-Fac_detalle.detallada 
&Scoped-define ENABLED-TABLES T-Fac_detalle
&Scoped-define FIRST-ENABLED-TABLE T-Fac_detalle
&Scoped-Define ENABLED-OBJECTS RECT-10 RECT-9 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Fac_detalle.cantidad T-Fac_detalle.precio ~
T-Fac_detalle.precio_cf T-Fac_detalle.subtotal_neto_cf ~
T-Fac_detalle.subtotal_neto T-Fac_detalle.detallada 
&Scoped-define DISPLAYED-TABLES T-Fac_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Fac_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 91 BY 11.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 91 BY 1.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Fac_detalle SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.43 COL 12 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.43 COL 31 COLON-ALIGNED NO-LABEL
     T-Fac_detalle.cantidad AT ROW 2.91 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.precio AT ROW 2.91 COL 41 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.precio_cf AT ROW 2.91 COL 71 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_neto_cf AT ROW 4.1 COL 71 COLON-ALIGNED
          LABEL "Neto C.F."
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_neto AT ROW 4.14 COL 41 COLON-ALIGNED
          LABEL "Neto"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.detallada AT ROW 5.52 COL 4 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 87 BY 6.29
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 12.1 COL 4
     Btn_Cancel AT ROW 12.1 COL 73
     RECT-10 AT ROW 2.67 COL 2
     RECT-9 AT ROW 1.24 COL 2
     SPACE(0.79) SKIP(11.23)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Facturas de Clientes"
         CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Fac_detalle T "?" NO-UNDO sic Fac_detalle
      TABLE: T-Fac_detalle-bon T "?" NO-UNDO sic Fac_detalle-bon
      TABLE: T-Fac_header T "?" NO-UNDO sic Fac_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_neto IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_neto_cf IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Fac_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Facturas de Clientes */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  IF p-modo-detalle = 0 THEN DELETE T-Fac_detalle.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME}
        T-Fac_detalle.detallada 
        T-Fac_detalle.cantidad 
        T-Fac_detalle.precio
        T-Fac_detalle.precio_cf.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Fac_header.ultima_linea     = T-Fac_header.ultima_linea + 1
                T-Fac_detalle.nro_factura     = T-Fac_header.nro_factura
                T-Fac_detalle.nro_linea       = T-Fac_header.ultima_linea.
        END.
        p-nro_linea-o = T-Fac_detalle.nro_linea.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_detalle.detallada
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_detalle.detallada Dialog-Frame
ON TAB OF T-Fac_detalle.detallada IN FRAME Dialog-Frame
DO:
      RUN ponmensj.p ( INPUT "DOCS018" ).
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_detalle.precio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_detalle.precio Dialog-Frame
ON LEAVE OF T-Fac_detalle.precio IN FRAME Dialog-Frame /* Precio */
DO:
  RUN calcular_valores(self:name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Fac_detalle.precio_cf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Fac_detalle.precio_cf Dialog-Frame
ON LEAVE OF T-Fac_detalle.precio_cf IN FRAME Dialog-Frame /* Precio C.F. */
DO:
  RUN calcular_valores(self:name).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  FIND FIRST T-Fac_header.
  IF p-modo-detalle = 0
  THEN DO:
       FIND Articulo WHERE Articulo.nro_articulo  = p-nro_articulo NO-LOCK.
       ASSIGN v-cdg_articulo = Articulo.cdg_articulo
              v-dsc_articulo = Articulo.descripcion.
       FIND Entidad WHERE Entidad.cdg_entidad = T-Fac_header.cdg_empresa NO-LOCK.
       CREATE T-Fac_detalle.
       ASSIGN T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
              T-Fac_detalle.nro_entidad  = T-Fac_header.nro_entidad
              T-Fac_detalle.nro_obra     = T-Fac_header.nro_obra
              T-Fac_detalle.nro_articulo = Articulo.nro_articulo
              T-Fac_detalle.a_granel     = Articulo.a_granel
              T-Fac_detalle.detallada    = Articulo.detallada
              T-Fac_detalle.costo        = Articulo.costo.

  END.
  ELSE DO:
       FIND FIRST T-Fac_detalle WHERE T-Fac_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
  END.     

  RUN traer_tablas.  
  
  RUN getparametro.p (  INPUT  "FACSCIVA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        T-Fac_detalle.cantidad 
        T-Fac_detalle.detallada 
        T-Fac_detalle.precio 
        T-Fac_detalle.precio_cf 
        T-Fac_detalle.subtotal_neto 
        T-Fac_detalle.subtotal_neto_cf
        WITH FRAME {&FRAME-NAME}.      

  RUN habilitar_campos.
 {&OPEN-QUERY-{&BROWSE-NAME}}
 
/*WAIT-FOR GO OF FRAME {&FRAME-NAME}.*/

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calcular_valores Dialog-Frame 
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

ASSIGN FRAME {&FRAME-NAME} T-Fac_detalle.precio_cf
       T-Fac_detalle.precio 
       T-Fac_detalle.cantidad.

IF T-Fac_detalle.cantidad = 0.0 THEN T-Fac_detalle.cantidad = 1.0.
IF campo = "precio" THEN
        T-Fac_detalle.precio_cf = truncate(T-Fac_detalle.precio * ( 1 + que_tasa / 100),2).
IF campo = "precio_cf" Then     
        T-Fac_detalle.precio = truncate(T-Fac_detalle.precio_cf / ( 1 + que_tasa / 100),2).

T-Fac_detalle.subtotal_neto = T-Fac_detalle.precio * T-Fac_detalle.cantidad.
T-Fac_detalle.subtotal_neto_cf = T-Fac_detalle.precio_cf * T-Fac_detalle.cantidad.
DISPLAY T-Fac_detalle.subtotal_neto  T-Fac_detalle.precio 
        T-Fac_detalle.subtotal_neto_cf T-Fac_detalle.precio_cf
        T-Fac_detalle.cantidad WITH FRAME {&FRAME-NAME}.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
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
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_articulo v-dsc_articulo 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Fac_detalle THEN 
    DISPLAY T-Fac_detalle.cantidad T-Fac_detalle.precio T-Fac_detalle.precio_cf 
          T-Fac_detalle.subtotal_neto_cf T-Fac_detalle.subtotal_neto 
          T-Fac_detalle.detallada 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-10 RECT-9 T-Fac_detalle.cantidad T-Fac_detalle.precio 
         T-Fac_detalle.precio_cf T-Fac_detalle.detallada Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos Dialog-Frame 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

    RUN hayobras.p ( OUTPUT hay_obras ).

    ASSIGN
        T-Fac_detalle.detallada:SENSITIVE         = NO 
        T-Fac_detalle.cantidad:SENSITIVE          = NO 
        T-Fac_detalle.precio:SENSITIVE            = NO 
        T-Fac_detalle.precio_cf:SENSITIVE         = NO.


    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            ASSIGN
                T-Fac_detalle.cantidad:SENSITIVE          = YES 
                T-Fac_detalle.detallada:SENSITIVE         = YES 
                T-Fac_detalle.precio:SENSITIVE            = false
                T-Fac_detalle.precio_cf:SENSITIVE         = true 
                Btn_OK:SENSITIVE                          = YES
                T-Fac_detalle.cantidad:FGCOLOR            = 9. 

        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_DEFINIDA               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_RELACION               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_READONLY               
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_CAMBIO                 
        THEN DO:
             /* nada habilitado */
        END.
        
        WHEN MD_GENERADO               
        THEN DO:
             /* nada habilitado */
        END.
         
        WHEN MD_ANULACION              
        THEN DO:
             /* nada habilitado */
        END.
         
        WHEN MD_EMISION                
        THEN DO:
             /* nada habilitado */
        END.

    END CASE.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE hallar_iva_detalle Dialog-Frame 
PROCEDURE hallar_iva_detalle :
DEFINE OUTPUT PARAMETER p-tasa LIKE Impuesto_condicion.tasa.
 
 p-tasa = 0.
 /*ver si el comprobante aplica impuestos o no*/
 FIND tipocomprobante OF t-fac_header NO-LOCK.
 IF Tipocomprobante.aplica_impuestos THEN DO:
      
     FIND Familia_impositiva OF Articulo NO-LOCK.
        
     FIND first Impuesto_condicion OF  Familia_impositiva 
           WHERE Impuesto_condicion.cdg_condiva = T-Fac_header.cdg_condiva
             AND Impuesto_condicion.cdg_empresa = T-Fac_header.cdg_empresa 
             AND Impuesto_condicion.fch_desde <= T-Fac_header.fecha_iva
             AND Impuesto_condicion.fch_hasta >= T-Fac_header.fecha_iva
             AND CAN-DO(Impuesto_condicion.lista_provincias,T-Fac_header.cdg_provincia) 
             AND CAN-FIND(FIRST Impuesto OF Impuesto_condicion WHERE Impuesto.es_iva) NO-LOCK NO-ERROR.
     IF AVAILABLE Impuesto_condicion THEN DO:
         FIND FIRST  Cliente_excencion OF Cliente 
                      WHERE Cliente_excencion.cdg_empresa  = T-Fac_header.cdg_empresa
                        AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                        AND Cliente_excencion.fch_desde <= T-Fac_header.fecha_iva
                        AND Cliente_excencion.fch_hasta >= T-Fac_header.fecha_iva NO-LOCK NO-ERROR.
        
         IF NOT AVAILABLE Cliente_excencion
             THEN p-tasa = Impuesto_condicion.tasa.
             ELSE p-tasa = Impuesto_condicion.tasa * ( 1 - Cliente_excencion.prc_excencion  / 100.0 ).
              
     END.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas Dialog-Frame 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Articulo OF T-Fac_detalle NO-LOCK.
  ASSIGN
        v-cdg_articulo = Articulo.cdg_articulo
        v-dsc_articulo = Articulo.descripcion.

  FIND Entidad OF T-Fac_detalle NO-LOCK NO-ERROR.
 
  FIND Obra OF T-Fac_detalle NO-LOCK NO-ERROR.
 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   hay_error = YES.

   IF T-Fac_detalle.detallada:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""
   THEN DO:
       RUN PONMENSJ.P ( INPUT "FACT033" ).
       RETURN.
   END.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Fac_detalle.nro_entidad = Entidad.nro_entidad.
   END.
   
/*
   IF T-Fac_detalle.valor_unitario = 0 AND T-Fac_detalle.unidades
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE018" ).
      RETURN.
   END.

   IF T-Fac_detalle.cambio = 0 AND T-Fac_detalle.bimonetario
   THEN DO:
      RUN PONMENSJ.P ( INPUT "ASIE019" ).
      RETURN.
   END.

   IF T-Fac_detalle.bimonetario
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Fac_detalle.debito  * T-Fac_detalle.cambio, 2)
            aux_credito = ROUND(T-Fac_detalle.credito * T-Fac_detalle.cambio, 2). 
      IF aux_debito  <> T-Fac_detalle.debito_div OR
         aux_credito <> T-Fac_detalle.credito_div
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE016" ).
         RETURN.
      END.
   END.      

   IF T-Fac_detalle.unidades
   THEN DO:
      ASSIGN
            aux_debito  = ROUND(T-Fac_detalle.debito_can  * T-Fac_detalle.valor_unitario, 2)
            aux_credito = ROUND(T-Fac_detalle.credito_can  * T-Fac_detalle.valor_unitario, 2).
      IF aux_debito  <> T-Fac_detalle.debito OR
         aux_credito <> T-Fac_detalle.credito
      THEN DO:   
         RUN PONMENSJ.P ( INPUT "ASIE015" ).
         RETURN.
      END.
   END.      
 
 
   IF Cuenta.entidades_validas <> "*"
   THEN DO:
        FIND Entidad OF T-Fac_detalle NO-LOCK.
        IF LOOKUP(Entidad.cdg_entidad,Cuenta.entidades_validas) = 0
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE024").
             RETURN.
        END.
   END.
   
   FIND Obra OF T-Fac_detalle NO-LOCK NO-ERROR.
   IF AVAILABLE Obra
   THEN DO:
        IF Obra.finalizada
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE025").
             RETURN.
        END.
        IF Obra.fecha_cierre < T-Fac_header.fecha OR
           Obra.fecha_apertura > T-Fac_header.fecha
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE026").
             RETURN.
        END.
   END.
*/   
   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

