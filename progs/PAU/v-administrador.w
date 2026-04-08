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
DEFINE VAR h_geocli AS WIDGET-HANDLE NO-UNDO.
{crystal_dyna.p}
{geoLibrary.i}
{tiempo.i}

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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.HAT Cliente.Cod_docu Cliente.cuit ~
Cliente.cdg_cliente Cliente.cdg_estado Cliente.mostrar_admin ~
Cliente.dfl_lista Cliente.nom_cliente Cliente.geolat Cliente.direccion ~
Cliente.geolong Cliente.cdg_postal Cliente.localidad Cliente.cdg_provincia ~
Cliente.horario_de_atencion Cliente.contacto_pago Cliente.texto 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS RECT-9 BUTTON-11 Brestricciones Bbasura ~
b-observ 
&Scoped-Define DISPLAYED-FIELDS Cliente.HAT Cliente.Cod_docu Cliente.cuit ~
Cliente.cdg_cliente Cliente.cdg_estado Cliente.mostrar_admin ~
Cliente.dfl_lista Cliente.nom_cliente Cliente.geolat Cliente.direccion ~
Cliente.geolong Cliente.cdg_postal Cliente.localidad Cliente.cdg_provincia ~
Cliente.horario_de_atencion Cliente.contacto_pago Cliente.texto 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente
&Scoped-Define DISPLAYED-OBJECTS v-observacion 

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
cdg_cliente|y|y|sic.Cliente.cdg_cliente
nro_cliente|y|y|sic.Cliente.nro_cliente
nro_cobrador||y|sic.Cliente.nro_cobrador
cdg_condiva||y|sic.Cliente.cdg_condiva
cdg_condibr||y|sic.Cliente.cdg_condibr
cdg_postal||y|sic.Cliente.cdg_postal
nro_entidad||y|sic.Cliente.nro_entidad
cdg_estado||y|sic.Cliente.cdg_estado
cdg_famclie||y|sic.Cliente.cdg_famclie
cdg_grupoemp||y|sic.Cliente.cdg_grupoemp
cdg_pais||y|sic.Cliente.cdg_pais
nro_proveedor||y|sic.Cliente.nro_proveedor
cdg_provincia||y|sic.Cliente.cdg_provincia
num_sucursal||y|sic.Cliente.num_sucursal
cdg_tipoclie||y|sic.Cliente.cdg_tipoclie
nro_usuario||y|sic.Cliente.nro_usuario
nro_vendedor||y|sic.Cliente.nro_vendedor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_cliente,nro_cliente",
     Keys-Supplied = "cdg_cliente,nro_cliente,nro_cobrador,cdg_condiva,cdg_condibr,cdg_postal,nro_entidad,cdg_estado,cdg_famclie,cdg_grupoemp,cdg_pais,nro_proveedor,cdg_provincia,num_sucursal,cdg_tipoclie,nro_usuario,nro_vendedor"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-observ 
     IMAGE-UP FILE "iconos16/text.jpg":U
     IMAGE-INSENSITIVE FILE "iconos16i/text.jpg":U
     LABEL "Observ" 
     SIZE 4.8 BY 1 TOOLTIP "Observaciones internas solo para el contrato".

DEFINE BUTTON Bbasura 
     LABEL "BASURA" 
     SIZE 15 BY 1.

DEFINE BUTTON Brestricciones 
     LABEL "Restricciones" 
     SIZE 14 BY 1.

DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5.2 BY 2.05.

DEFINE VARIABLE v-observacion AS CHARACTER FORMAT "X(200)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 61 BY 1 TOOLTIP "Observaciones Cobranzas"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 111 BY 8.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cliente.HAT AT ROW 1.29 COL 53.6 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.Cod_docu AT ROW 1.29 COL 69.8 COLON-ALIGNED WIDGET-ID 52
          LABEL "Doc"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Item 1" 
          DROP-DOWN-LIST
          SIZE 16 BY 1 TOOLTIP "Elija un tipo"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cuit AT ROW 1.29 COL 86 COLON-ALIGNED NO-LABEL FORMAT "X(11)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1 TOOLTIP "No introduzca los guiones"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_cliente AT ROW 1.33 COL 11 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 11 BY 1 TOOLTIP "En el alta lo asigna directamente Dynasys si lo deja en blanco"
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     Cliente.cdg_estado AT ROW 1.33 COL 30.6 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Activo","A",
                     "Inactivo","I",
                     "Potencial","P"
          DROP-DOWN-LIST
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.mostrar_admin AT ROW 1.33 COL 45.6 WIDGET-ID 4
          LABEL ""
          VIEW-AS TOGGLE-BOX
          SIZE 4 BY .81 TOOLTIP "Si se muestra el Administrador o no en los comprobantes de venta"
     Cliente.dfl_lista AT ROW 2.43 COL 100 COLON-ALIGNED WIDGET-ID 50
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1 TOOLTIP "Lista de precios por defecto"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 2.52 COL 11 COLON-ALIGNED
          LABEL "Razón" FORMAT "X(80)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 82 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.geolat AT ROW 3.67 COL 89.2 COLON-ALIGNED WIDGET-ID 12 FORMAT "->9.999999"
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BUTTON-11 AT ROW 3.67 COL 105 WIDGET-ID 36
     Cliente.direccion AT ROW 3.71 COL 11 COLON-ALIGNED WIDGET-ID 38
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Item 1" 
          SIMPLE
          SIZE 69 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.geolong AT ROW 4.76 COL 89.4 COLON-ALIGNED WIDGET-ID 16 FORMAT "->9.999999"
          VIEW-AS FILL-IN 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_postal AT ROW 4.81 COL 11 COLON-ALIGNED
          LABEL "C. P"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.localidad AT ROW 4.81 COL 30 COLON-ALIGNED
          LABEL "Loc."
          VIEW-AS FILL-IN NATIVE 
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_provincia AT ROW 4.81 COL 62 COLON-ALIGNED WIDGET-ID 40
          LABEL "Prov."
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item1","Item1"
          DROP-DOWN-LIST
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.horario_de_atencion AT ROW 6 COL 54 COLON-ALIGNED
          LABEL "Horario" FORMAT "X(80)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 55 BY 1 TOOLTIP "Formato xxxx:yyyy;zzzz:wwww"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.contacto_pago AT ROW 6.05 COL 11 COLON-ALIGNED HELP
          "" WIDGET-ID 14
          LABEL "Cto Pago"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Item 1" 
          DROP-DOWN-LIST
          SIZE 42 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Brestricciones AT ROW 7.19 COL 13 WIDGET-ID 42
     Bbasura AT ROW 7.19 COL 28 WIDGET-ID 48
     b-observ AT ROW 7.19 COL 44 WIDGET-ID 46
     v-observacion AT ROW 7.19 COL 48 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     Cliente.texto AT ROW 8.38 COL 2.8 WIDGET-ID 54
          LABEL "Cobranza" FORMAT "X(250)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 98 BY 1 TOOLTIP "Aparecera en el resumen de cobranza"
          BGCOLOR 15 FGCOLOR 9 
     RECT-9 AT ROW 1 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente
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
         HEIGHT             = 8.95
         WIDTH              = 114.
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

/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_provincia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.Cod_docu IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.contacto_pago IN FRAME F-Main
   EXP-LABEL EXP-HELP                                                   */
/* SETTINGS FOR FILL-IN Cliente.cuit IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.geolat IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.geolong IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.horario_de_atencion IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Cliente.localidad IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cliente.mostrar_admin IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.nom_cliente IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Cliente.texto IN FRAME F-Main
   ALIGN-L EXP-LABEL EXP-FORMAT                                         */
/* SETTINGS FOR FILL-IN v-observacion IN FRAME F-Main
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

&Scoped-define SELF-NAME b-observ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-observ V-table-Win
ON CHOOSE OF b-observ IN FRAME F-Main /* Observ */
DO:
   DEFINE VARIABLE puso_ok AS LOGICAL.
   ASSIGN v-observacion.
   RUN c-edttexto.w ( INPUT-OUTPUT v-observacion,
                      INPUT "Observaciónes del administrador",
                      INPUT (IF v-observacion:SENSITIVE THEN 0 ELSE 4),
                      OUTPUT puso_ok).
   DISPLAY v-observacion WITH FRAME {&FRAME-NAME}.
   IF NOT puso_ok THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bbasura
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bbasura V-table-Win
ON CHOOSE OF Bbasura IN FRAME F-Main /* BASURA */
DO:
   
   DEFINE VARIABLE puso_ok AS LOGICAL.
DEFINE VAR v-basura AS CHAR.
   v-basura = cliente.migra.
   RUN c-edttexto.w ( INPUT-OUTPUT v-basura,
                      INPUT "Basura a depurar",
                      0,
                      OUTPUT puso_ok).
   IF NOT puso_ok THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Brestricciones
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Brestricciones V-table-Win
ON CHOOSE OF Brestricciones IN FRAME F-Main /* Restricciones */
DO:
  RUN d-cliente_restriccion.w( cliente.nro_cliente ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 V-table-Win
ON CHOOSE OF BUTTON-11 IN FRAME F-Main /* b-geocli */
DO:
  IF NOT VALID-HANDLE( h_geocli ) THEN DO:
      RUN w-geocli.w PERSISTENT SET h_geocli ( ROWID(cliente)).
      RUN dispatch IN h_geocli ( INPUT 'initialize':U ) .
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cliente.cuit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cliente.cuit V-table-Win
ON LEAVE OF Cliente.cuit IN FRAME F-Main /* C.U.I.T. */
DO:
    run validar_cuit_param.p ( INPUT FRAME {&FRAME-NAME} Cliente.cuit,? ).
    if return-value <> "OK"
    THEN DO:
       RETURN NO-APPLY.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cliente.horario_de_atencion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cliente.horario_de_atencion V-table-Win
ON LEAVE OF Cliente.horario_de_atencion IN FRAME F-Main /* Horario */
DO:
IF NOT validahorario ( SELF:INPUT-VALUE,TRUE ) THEN RETURN NO-APPLY.
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
    WHEN 'cdg_cliente':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Cliente
           &WHERE = "WHERE Cliente.cdg_cliente eq key-value"
       }
    WHEN 'nro_cliente':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Cliente
           &WHERE = "WHERE Cliente.nro_cliente eq INTEGER(key-value)"
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
  Cliente.contacto_pago:LIST-ITEMS IN FRAME {&FRAME-NAME}= "".
  Cliente.contacto_pago:SCREEN-VALUE = "".

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
    DEF VAR hay_error_interface AS LOGICAL NO-UNDO.
    DEF BUFFER  b-cliente FOR cliente.
    DEFINE VAR v-geolat LIKE cliente.geolat.
    DEFINE VAR v-geolong LIKE cliente.geolong.
    DEFINE VARIABLE oldnf AS CHAR NO-UNDO.
    DEFINE VAR i AS INT NO-UNDO.
    DEFINE VAR v-extra AS CHAR NO-UNDO.
    DEFINE VAR rok AS LOGICAL NO-UNDO.
    DEFINE VAR pcdireccion AS CHAR.
    DEFINE VAR pclocalidad AS CHAR.
    DEFINE VAR pcprovincia AS CHAR.
    DEFINE VAR pcpais AS CHAR.
    DEFINE VAR pdlat AS DECIMAL.
    DEFINE VAR pdlong AS DECIMAL.
  /* Code placed here will execute PRIOR to standard behavior. */

    IF INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = "" OR 
        INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "USR_009").
         RETURN ERROR.
    END.            
    IF INPUT FRAME {&FRAME-NAME} Cliente.direccion = "" THEN
    DO:
        MESSAGE "Direccion en blanco" view-as alert-box error.
            RETURN ERROR.
    END.
    FIND FIRST B-Cliente WHERE B-Cliente.nom_cliente = INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente AND
                ROWID(b-cliente) <> ROWID(cliente) NO-LOCK NO-ERROR.
    IF AVAILABLE b-cliente THEN DO:
     MESSAGE "Ya existe cliente con el mismo nombre" SKIP ROWID(b-cliente) "   " ROWID(cliente) SKIP  
       b-cliente.cdg_cliente cliente.cdg_cliente
       VIEW-AS ALERT-BOX ERROR.
     RETURN ERROR.
    END. 
      
    IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente <> "" AND CAN-FIND(FIRST B-Cliente 
                       WHERE B-Cliente.cdg_cliente = INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente  
                        AND ROWID(B-Cliente) <> ROWID(Cliente) )
    THEN DO:
          MESSAGE "El cliente " b-cliente.cdg_cliente " tiene el mismo cuit"
                 VIEW-AS ALERT-BOX ERROR.
         RETURN ERROR.
    END.
    
    IF NOT validahorario ( INPUT FRAME {&FRAME-NAME} cliente.horario_de_atencion , FALSE ) THEN DO:
        MESSAGE "El horario de atencion es incorrecto" SKIP "no puede proseguir hasta corregirlo" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
    IF INPUT FRAME {&FRAME-NAME} Cliente.cod_docu = "" THEN DO:
        MESSAGE "Elija un tipo de documento" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
    IF INPUT FRAME {&FRAME-NAME} Cliente.cod_docu <> "NO"  THEN DO:
        run validar_cuit_param.p ( INPUT FRAME {&FRAME-NAME} Cliente.cuit ,?).
        if return-value <> "OK"
        THEN DO:
           RETURN ERROR.
        END.  
        FIND FIRST B-Cliente
                           WHERE INPUT FRAME {&FRAME-NAME} Cliente.cuit <> "" AND 
                             B-Cliente.cuit = INPUT FRAME {&FRAME-NAME} Cliente.cuit
                             AND ROWID(B-Cliente) <> ROWID(Cliente) NO-LOCK NO-ERROR.
        IF AVAILABLE b-cliente THEN DO:
             MESSAGE "El cliente " b-cliente.cdg_cliente " tiene el mismo cuit"
                     VIEW-AS ALERT-BOX ERROR.
             RETURN ERROR.
        END.
    END.

       /*geocodificacion*/
   IF cliente.geolat:input-value IN FRAME {&FRAME-NAME}= 0 
       OR cliente.direccion:MODIFIED THEN DO:
        FIND provincia WHERE provincia.cdg_provincia = cliente.cdg_provincia:INPUT-VALUE NO-LOCK NO-ERROR.
        
        pcdireccion = toxAL(cliente.direccion:INPUT-VALUE,OUTPUT v-extra).
        pclocalidad = cliente.localidad:INPUT-VALUE.
        pcprovincia = provincia.nombre.
        pcpais = "Argentina".  
        RUN geoloc.p (INPUT-OUTPUT pcDireccion, INPUT-OUTPUT pcLocalidad, INPUT-OUTPUT pcProvincia, INPUT-OUTPUT pcPais, OUTPUT v-geolat, OUTPUT v-geolong) NO-ERROR.
        IF RETURN-VALUE <> "" OR v-geolat = 0  THEN DO:
           MESSAGE RETURN-VALUE VIEW-AS ALERT-BOX ERROR.
           RETURN ERROR.
        END.

        cliente.geolat:SCREEN-VALUE = STRING(v-geolat,"->9.999999").
        cliente.geolong:SCREEN-VALUE = STRING(v-geolong,"->9.999999").
        cliente.direccion:SCREEN-VALUE = upper(pcDireccion) + " " + v-extra.
        cliente.localidad:SCREEN-VALUE = upper(pcLocalidad).
   END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .
  cliente.observacion = v-observacion:INPUT-VALUE.
  /* Code placed here will execute AFTER standard behavior.    */
  IF NEW Cliente
     THEN DO:
         ASSIGN  Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
                 Cliente.fecha_alta  = TODAY
                 Cliente.hora_alta   = TIME.
         IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente = "" THEN
             ASSIGN cliente.cdg_cliente = "A" + STRING(Cliente.nro_cliente,"99999").
         ASSIGN  cliente.cdg_pais = 1
                cliente.cdg_grupo = "1"
                cliente.lista_empresas = "P"
                cliente.lista_sectores = "P"
                cliente.tiene_ctacte = TRUE
                cliente.nro_entidad = 0
                cliente.nro_vendedor = 1
                cliente.cdg_tipoclie = "1"
                cliente.dfl_cndventa = "00"
                cliente.cdg_condiva = 2  /*le fuerzo consumidores finales a todos*/
                cliente.dfl_lista = 1
                cliente.max_chrechazados  = 3
                cliente.lista_mail = "ADM"
                cliente.num_sucursal = "C"
                Cliente.cdg_famclie = "1"
                cliente.nro_cobrador = 1
                cliente.nro_administrador = cliente.nro_cliente.
         RUN crea_tarea.p( 0,cliente.nro_cliente,"B", "Nueva Administracion " + cliente.nom_cliente,"Creada el " + STRING( cliente.fecha_alta ),TODAY,"*",OUTPUT rok).
         IF NOT rok THEN DO:
             MESSAGE "Error al crear la tarea por error en los usuario/recurso".
             RETURN ERROR.
         END.
  END.
             
  IF NEW Cliente
     THEN DO:
    CREATE Hst_Cliente.
    BUFFER-COPY Cliente TO Hst_cliente.
    RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                                OUTPUT Hst_cliente.fecha_cambio,
                                OUTPUT Hst_cliente.hor_cambio,
                                OUTPUT Hst_cliente.pc_cambio).
    ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
  END.
  
   IF SEARCH("sincronizar_cliente.p") <> ? OR
   SEARCH("sincronizar_cliente.r") <> ?
   THEN DO:
       RUN sincronizar_cliente.p ( INPUT Cliente.cdg_cliente,
                                   OUTPUT hay_error_interface).
   END.

    /*geocodificacion*/
   IF cliente.geolat <> 0 THEN DO:
     cliente.geoX = X(cliente.geolat,cliente.geolong).
     cliente.geoY = Y(cliente.geolat,cliente.geolong).
   END.
   
   cliente.ult_domicilio = 1.    
   FIND FIRST domicilio OF cliente NO-ERROR.
   IF NOT AVAILABLE domicilio THEN DO:
       CREATE domicilio.
        ASSIGN  Domicilio.telefono = cliente.telefonos
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio" 
            Domicilio.localidad = cliente.localidad
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","")
            Domicilio.cdg_pais = 1.
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
DEFINE BUFFER cc FOR cliente.
DEFINE VAR senal AS LOGICAL NO-UNDO.
DEFINE VAR totdeuda AS DECIMAL NO-UNDO.
FIND FIRST cc WHERE cc.nro_admin = cliente.nro_cliente AND
ROWID(cc) <> ROWID(cliente) NO-LOCK NO-ERROR.
IF AVAILABLE cc THEN DO:
    MESSAGE "No se puede borrar la administracion tiene consorcios relacionados" VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.

senal = FALSE.
totdeuda = 0.0.
FOR EACH Cta_cte NO-LOCK
                WHERE cta_cte.nro_cliente = cliente.nro_cliente
                  AND Cta_cte.cdg_empresa     = empresa.cdg_empresa
                  AND cta_cte.fecha_vencimiento <= 01/01/3000
                  /*AND Cta_cte.fecha_emision  <= p-has_fecha*/
                  AND Cta_cte.debito <> Cta_cte.credito 
                       BY cta_cte.fecha_emision:
                senal = TRUE.
                totdeuda = totdeuda + Cta_cte.debito - Cta_cte.credito.
    
END. /* De los movimientos de un administador */
IF senal OR totdeuda > 0 THEN DO:
    MESSAGE "administracion con deuda de " totdeuda SKIP
"cancele o transfiera antes de proseguir" VIEW-AS ALERT-BOX INFORMATION.
RETURN ERROR.

END.



  /* Code placed here will execute PRIOR to standard behavior. */

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
  v-observacion:SENSITIVE IN FRAME {&FRAME-NAME}= FALSE.
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR LISTA AS CHAR NO-UNDO.
DEF VAR v-preferido AS CHAR NO-UNDO.  
/* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */

lista = "".
v-preferido = "".

IF AVAILABLE cliente THEN DO:
bbasura:HIDDEN IN FRAME {&FRAME-NAME}= cliente.migra = "". 
    v-observacion = cliente.observacion.
    FOR EACH domicilio OF cliente no-lock, 
            EACH cliente-contacto OF domicilio  WHERE 
            ( des_fecha = ? OR des_fecha <= TODAY )
             AND ( has_fecha = ? OR has_fecha >= TODAY ),
            EACH Persona OF Cliente-contacto NO-LOCK :
            lista = lista + "," + persona.nombre.
            IF  can-do(Cliente-contacto.canal-email,"*") THEN v-preferido = persona.nombre.
    END.
    
    IF LOOKUP(cliente.contacto_pago:SCREEN-VALUE IN FRAME {&FRAME-NAME},contacto_pago:LIST-ITEMS) = 0 THEN cliente.contacto_pago:SCREEN-VALUE.
    
    IF lista <> "" THEN lista = SUBSTRING(lista,2).
    IF LOOKUP(cliente.contacto_pago,lista) = 0 THEN DO:
            FIND CURRENT cliente EXCLUSIVE-LOCK.
        ASSIGN cliente.contacto_pago = v-preferido.
        FIND CURRENT cliente NO-LOCK.
    END.
    contacto_pago:LIST-ITEMS IN FRAME {&FRAME-NAME} = lista.
    
    DISPLAY cliente.contacto_pago WITH FRAME {&FRAME-NAME}.
END.

 RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) . 

IF VALID-HANDLE(h_geocli) AND AVAILABLE cliente THEN
            DYNAMIC-FUNCTION ( "muestracli" IN h_geocli , ROWID(cliente)).

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
  v-observacion:SENSITIVE IN FRAME {&FRAME-NAME}= TRUE.
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR LISTA AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
{findempresa.i}
  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Provincia &NOMBRE=nombre &CODIGO=cdg_provincia &OBJETO=Cliente.cdg_provincia}
  END.
     lista = "".

/*     FIND usuario WHERE usuario.cdg_usuario = USERID("sic") NO-LOCK.
     FIND Usuario_funcion OF usuario WHERE Usuario_funcion.cdg_funcion = "EFAC" AND usuario_funcion.permiso =  "A"
                AND Usuario_funcion.cdg_empresa = empresa.cdg_empresa NO-LOCK NO-ERROR. */
     FOR EACH tipo_documento BY tipo_documento.cdg_afip:
         /*IF tipo_documento.cod_docu = "NO" AND NOT AVAILABLE Usuario_funcion THEN NEXT.*/
         lista = lista + "," + tipo_documento.cod_docu.
     END.
     cliente.cod_docu:LIST-ITEMS = SUBSTRING(lista,2).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resumen_cob V-table-Win 
PROCEDURE resumen_cob :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 

DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.

  RUN prinresumenes.p ( INPUT Empresa.cdg_empresa,
                             INPUT cliente.cdg_cliente,
                             INPUT cliente.cdg_cliente,
                             INPUT TODAY,
                             INPUT 01/01/3000,
                             INPUT "*", /*todos los puntos de venta*/
                             INPUT 1,
                             OUTPUT xfile). 

ReportePath = "resumen_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').

RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.


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
  {src/adm/template/sndkycas.i "cdg_cliente" "Cliente" "cdg_cliente"}
  {src/adm/template/sndkycas.i "nro_cliente" "Cliente" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_cobrador" "Cliente" "nro_cobrador"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Cliente" "cdg_condiva"}
  {src/adm/template/sndkycas.i "cdg_condibr" "Cliente" "cdg_condibr"}
  {src/adm/template/sndkycas.i "cdg_postal" "Cliente" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_entidad" "Cliente" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Cliente" "cdg_estado"}
  {src/adm/template/sndkycas.i "cdg_famclie" "Cliente" "cdg_famclie"}
  {src/adm/template/sndkycas.i "cdg_grupoemp" "Cliente" "cdg_grupoemp"}
  {src/adm/template/sndkycas.i "cdg_pais" "Cliente" "cdg_pais"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cliente" "nro_proveedor"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Cliente" "cdg_provincia"}
  {src/adm/template/sndkycas.i "num_sucursal" "Cliente" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_tipoclie" "Cliente" "cdg_tipoclie"}
  {src/adm/template/sndkycas.i "nro_usuario" "Cliente" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Cliente" "nro_vendedor"}

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
  {src/adm/template/snd-list.i "Cliente"}

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

