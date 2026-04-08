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

  DEFINE VARIABLE x-lista AS CHARACTER.
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

DEFINE VAR geolat AS DECIMAL.
DEFINE VAR geolong AS DECIMAL.
DEFINE VAR geoX AS DECIMAL.
DEFINE VAR geoY AS DECIMAL.

DEFINE VAR h_geocli AS WIDGET-HANDLE NO-UNDO.
{geoLibrary.i}
DEFINE TEMP-TABLE ott LIKE internal-ttgeo.
DEFINE VAR rowtt AS INT.

DEFINE VAR h_geoTT AS HANDLE.

DEFINE TEMP-TABLE ttgeo NO-UNDO
    FIELD ttind AS INT
    FIELD ttgeolat AS DECIMAL
    FIELD ttgeolong AS DECIMAL
    FIELD tttipo AS INT
    FIELD tturl AS CHARACTER
    INDEX ind AS PRIMARY ttind.

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
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.cdg_tipotarea 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS BUTTON-11 Tnombre 
&Scoped-Define DISPLAYED-FIELDS Tarea.nom_cliente Tarea.direccion ~
Tarea.cdg_tipotarea 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS Tnombre 

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_administrador V-table-Win 
FUNCTION que_administrador RETURNS INTEGER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "C:/Dynasys10/progs/img/earth_location.jpg":U
     LABEL "b-geocli" 
     SIZE 5 BY 1.24.

DEFINE VARIABLE Tnombre AS LOGICAL INITIAL yes 
     LABEL "Razon" 
     VIEW-AS TOGGLE-BOX
     SIZE 11 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-11 AT ROW 1 COL 2.6 WIDGET-ID 46
     Tarea.nom_cliente AT ROW 1.05 COL 15.6 COLON-ALIGNED WIDGET-ID 50
          LABEL "Razon"
          VIEW-AS FILL-IN NATIVE 
          SIZE 95 BY 1 TOOLTIP "Para salir deje el la razon en blanco"
          BGCOLOR 15 FGCOLOR 9 
     Tarea.direccion AT ROW 1.1 COL 15.6 COLON-ALIGNED WIDGET-ID 16
          VIEW-AS FILL-IN NATIVE 
          SIZE 95 BY 1 TOOLTIP "Para salir deje el la direccion en blanco"
          BGCOLOR 15 FGCOLOR 9 
     Tarea.cdg_tipotarea AT ROW 1.14 COL 124 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 12
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tnombre AT ROW 1.24 COL 114 WIDGET-ID 48
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tarea
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
         HEIGHT             = 1.24
         WIDTH              = 149.4.
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

/* SETTINGS FOR FILL-IN Tarea.direccion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.nom_cliente IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
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

&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 V-table-Win
ON CHOOSE OF BUTTON-11 IN FRAME F-Main /* b-geocli */
DO:
    DEFINE VARIABLE oldnf AS CHAR NO-UNDO.

    IF geolat = 0 THEN DO:
        RUN geocod.
    END.
    IF geolat = 0 THEN DO:
        MESSAGE "Geocodificacion incorrecta, especifique".
        RETURN NO-APPLY.
    END.

    EMPTY TEMP-TABLE ttgeo.
    
    oldnf = SESSION:NUMERIC-FORMAT.
    SESSION:NUMERIC-FORMAT = "AMERICAN".
    CREATE ttgeo.
    ASSIGN ttgeo.ttgeolat = geolat
        ttgeo.ttgeolong = geolong
        tttipo = 1 
        tturl = "Direccion:" + tarea.direccion:INPUT-VALUE .
    SESSION:NUMERIC-FORMAT=oldnf.

    IF NOT VALID-HANDLE( h_geoTT ) THEN DO:
      RUN w-geoTT.w PERSISTENT SET h_geoTT.
      IF VALID-HANDLE( h_geoTT ) THEN
          RUN dispatch IN h_geoTT ( INPUT 'initialize':U ) .
    END.    
    IF VALID-HANDLE( h_geoTT ) THEN
      DYNAMIC-FUNCTION( "mostrar"  IN h_geoTT,  INPUT TABLE ttgeo ).
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.cdg_tipotarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.cdg_tipotarea V-table-Win
ON VALUE-CHANGED OF Tarea.cdg_tipotarea IN FRAME F-Main /* Tipo!Problema */
DO:
  DEFINE VAR hproc AS HANDLE NO-UNDO.
  DEFINE VAR hcproc AS CHAR NO-UNDO.
  DEFINE VAR ii AS INT NO-UNDO.

IF Tarea.cdg_tipotarea:INPUT-VALUE IN FRAME {&FRAME-NAME} <> "" THEN DO: 

  RUN cambia_template (tarea.cdg_tipotarea:INPUT-VALUE).
  RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "Record-Target",
        OUTPUT hcproc ).
    /* Code placed here will execute PRIOR to standard behavior. */

    REPEAT ii = 1 TO NUM-ENTRIES(hcproc):
    hproc = WIDGET-HANDLE(entry(ii,hcproc)).
    IF VALID-HANDLE(hproc) THEN
      RUN cambia_cliente IN hproc ( rowid(cliente) ) NO-ERROR.
    END.
  IF tarea.cdg_tipotarea:INPUT-VALUE <> "" THEN DO:
        tarea.nom_cliente:SENSITIVE = TRUE.
        tarea.direccion:SENSITIVE = TRUE.
  END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.direccion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.direccion V-table-Win
ON LEAVE OF Tarea.direccion IN FRAME F-Main /* Direccion */
DO:
  DEFINE VAR v-cdg_cliente LIKE cliente.cdg_cliente.

  IF {&SELF-NAME}:SCREEN-VALUE <> "" THEN DO:
      IF {&SELF-NAME}:MODIFIED THEN DO:
        IF AVAILABLE cliente THEN DO:
            IF NOT {&SELF-NAME}:SCREEN-VALUE BEGINS cliente.direccion THEN DO:
             RELEASE cliente NO-ERROR.
             v-cdg_cliente = ?.
             geolat = 0.
            END.
        END.
        IF NOT AVAILABLE cliente THEN DO:
          geolat = 0.
          RUN d-buscacliente_super.w (INPUT {&SELF-NAME}:SCREEN-VALUE,INPUT-OUTPUT v-cdg_cliente).
          IF v-cdg_cliente <> ? THEN DO:
             FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
             RUN poner_cliente({&SELF-NAME}:SCREEN-VALUE).
          END.
          ELSE do:
              RUN geocod.
              IF ERROR-STATUS:ERROR THEN DO:
                  MESSAGE "La dirección indicada no es correcta" SKIP
                          "Verifique la Direccion, alturas, " SKIP 
                          "Localidad y Provincia" VIEW-AS ALERT-BOX ERROR.
              RETURN NO-APPLY.
              END.
          END.
        END.
        IF geolat = 0 AND NOT AVAILABLE cliente THEN do:
            MESSAGE "Ingrese algun dato del clientem debe estar dado de alta previamente" SKIP
                "Reintente o deje el campo en blanco para salir"
                VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.direccion V-table-Win
ON MOUSE-MENU-CLICK OF Tarea.direccion IN FRAME F-Main /* Direccion */
DO:
    DEFINE VAR v-cdg_cliente LIKE cliente.cdg_cliente.
    IF {&SELF-NAME}:SCREEN-VALUE = "" THEN DO:
        MESSAGE "Indique algun patron" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    RUN d-buscacliente_super.w (INPUT {&SELF-NAME}:SCREEN-VALUE,INPUT-OUTPUT v-cdg_cliente).
    IF v-cdg_cliente <> "" THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
        RUN poner_cliente.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.direccion V-table-Win
ON RETURN OF Tarea.direccion IN FRAME F-Main /* Direccion */
DO:
    APPLY "LEAVE" TO {&self-name}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.nom_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.nom_cliente V-table-Win
ON LEAVE OF Tarea.nom_cliente IN FRAME F-Main /* Razon */
DO:
    DEFINE VAR hproc AS HANDLE NO-UNDO.
    DEFINE VAR hcproc AS CHAR NO-UNDO.
    DEFINE VAR v-cdg_cliente LIKE cliente.cdg_cliente.
    IF {&SELF-NAME}:SCREEN-VALUE = "" THEN DO:
        MESSAGE "Indique algun patron" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.

    IF {&SELF-NAME}:MODIFIED THEN DO:
        IF AVAILABLE cliente THEN DO:
            IF Cliente.nom_cliente <> tarea.nom_cliente:SCREEN-VALUE THEN 
              RELEASE cliente NO-ERROR.
        END.
        ELSE DO:
            RUN d-buscacliente_super.w (INPUT {&SELF-NAME}:SCREEN-VALUE,INPUT-OUTPUT v-cdg_cliente).
            IF v-cdg_cliente <> "" THEN DO:
                FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
                IF AVAILABLE cliente THEN
                    RUN poner_cliente({&SELF-NAME}:SCREEN-VALUE).
                ELSE DO:
                MESSAGE "No ha ingresado un dato valido" SKIP
                "Reintente o deje el campo en blanco para salir"
                VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
                END.
            END.
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.nom_cliente V-table-Win
ON MOUSE-MENU-CLICK OF Tarea.nom_cliente IN FRAME F-Main /* Razon */
DO:
    DEFINE VAR v-cdg_cliente LIKE cliente.cdg_cliente.
    IF {&SELF-NAME}:SCREEN-VALUE = "" THEN DO:
        MESSAGE "Indique algun patron" VIEW-AS ALERT-BOX INFORMATION.
        RETURN NO-APPLY.
    END.
    RUN d-buscacliente_super.w (INPUT {&SELF-NAME}:SCREEN-VALUE,INPUT-OUTPUT v-cdg_cliente).
    IF v-cdg_cliente <> "" THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-LOCK.
        RUN poner_cliente.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.nom_cliente V-table-Win
ON RETURN OF Tarea.nom_cliente IN FRAME F-Main /* Razon */
DO:
  APPLY "LEAVE" TO {&self-name}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tnombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tnombre V-table-Win
ON VALUE-CHANGED OF Tnombre IN FRAME F-Main /* Razon */
DO:
  ASSIGN tnombre.
  tarea.nom_cliente:HIDDEN = NOT tnombre.
  tarea.direccion:HIDDEN = tnombre.
/*  tarea.nom_cliente:SENSITIVE = tarea.cdg_tipotarea:SENSITIVE.
  tarea.direccion:SENSITIVE = tarea.cdg_tipotarea:SENSITIVE.*/
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
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tarea"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambia_template V-table-Win 
PROCEDURE cambia_template :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER ppar LIKE tarea.cdg_tipotarea.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR hcproc AS CHAR NO-UNDO.
    RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "CONTAINER-source",
          OUTPUT hcproc ).
    hproc = WIDGET-HANDLE(hcproc).
    IF VALID-HANDLE(hProc) THEN DO:
        RUN template IN hproc (ppar).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE damecliente V-table-Win 
PROCEDURE damecliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER p AS ROWID.
p = IF AVAILABLE cliente THEN ROWID(cliente) ELSE ?.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE damegeo V-table-Win 
PROCEDURE damegeo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAM plat LIKE geolat.
DEFINE OUTPUT PARAM plong LIKE geolong.
plat = geolat.
plong = geolong.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE dametipo V-table-Win 
PROCEDURE dametipo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER ptipo LIKE tarea.cdg_tipotarea.
ptipo = tarea.cdg_tipotarea:INPUT-VALUE IN FRAME {&FRAME-NAME}.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE geocod V-table-Win 
PROCEDURE geocod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR oldnf AS CHAR NO-UNDO.
   DEFINE VAR i AS INT NO-UNDO.
   DEFINE VAR v-extra AS CHAR NO-UNDO.
   IF tarea.direccion:input-value  IN FRAME {&FRAME-NAME} = "" THEN DO:
       MESSAGE "Ingrese direccion".
       RETURN NO-APPLY.
   END.
   RUN w-geoOPT.w ( toxAL(tarea.direccion:INPUT-VALUE , OUTPUT v-extra )
                         , OUTPUT TABLE ott,
             OUTPUT rowtt).
        IF rowtt = ? THEN DO:
            RETURN "".
        END.
        oldnf = SESSION:NUMERIC-FORMAT.
        SESSION:NUMERIC-FORMAT = "AMERICAN".
        FIND ott WHERE ott.pid = rowtt.
        geolat= decimal(entry(2, ott.coordinates)).
        geolong = decimal(entry(1, ott.coordinates)).
        SESSION:NUMERIC-FORMAT = oldnf.
        tarea.direccion:SCREEN-VALUE = upper( entry(1 , ott.xal ) + " " + v-extra ).
        RETURN string(rowtt) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_tipotareas V-table-Win 
PROCEDURE inicia_tipotareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR xs LIKE Tipo_tarea.cdg_tipotarea.
xs = Tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  x-lista = "[Indique Tipo de Tarea],".
  FOR EACH Tipo_tarea NO-LOCK BY Tipo_tarea.cdg_tipotarea:
    x-lista = x-lista +  "," + Tipo_tarea.dsc_tipotarea + "," + Tipo_tarea.cdg_tipotarea.
  END.
  Tarea.cdg_tipotarea:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).
  Tarea.cdg_tipotarea:SCREEN-VALUE = xs.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR hproc AS HANDLE NO-UNDO.
  DEFINE VAR hcproc AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
  tarea.direccion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  tarea.nom_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
  Tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME} = " ".
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER btarea FOR tarea.
  /* Code placed here will execute PRIOR to standard behavior. */

  IF Tarea.cdg_tipotarea:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""
  THEN DO:
      MESSAGE "No indicó el tipo de tarea al que se refiere la tarea"
          VIEW-AS ALERT-BOX ERROR TITLE "TARE002".
      RETURN ERROR.
  END.

  IF tarea.estado = "Z" THEN DO:
      FIND btarea WHERE btarea.nro_predecesora = tarea.nro_tarea NO-LOCK NO-ERROR.
      IF NOT AVAILABLE  btarea THEN DO:
          MESSAGE "ERROR interno en tareas predecesoras".
          RETURN ERROR.
      END.
      MESSAGE "La tarea " btarea.nro_tarea " sucede a esta" SKIP
          "Por lo que no puede modificarse" VIEW-AS ALERT-BOX ERROR.
      RETURN ERROR.
  END.

  IF tarea.estado = "R" THEN DO:
      MESSAGE "Tarea resuelta no puede modificarse sin reabrirla" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
  END.


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  ASSIGN tarea.geolat = geolat
         tarea.geolong = geolong.
  IF tarea.geolat <> 0 THEN DO:
     tarea.geoX = X(tarea.geolat,tarea.geolong).
     tarea.geoY = Y(tarea.geolat,tarea.geolong).
 END.

  /* Code placed here will execute AFTER standard behavior.    */
  ASSIGN tarea.direccion.
  Tarea.nom_cliente = IF AVAILABLE cliente THEN Cliente.nom_cliente ELSE 
                          tarea.direccion.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-cancel-record V-table-Win 
PROCEDURE local-cancel-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VAR hproc AS HANDLE NO-UNDO.
  DEFINE VAR hcproc AS CHAR NO-UNDO.

  tarea.direccion:SCREEN-VALUE  IN FRAME {&FRAME-NAME}= "".
  tarea.nom_cliente:SCREEN-VALUE = "".
  
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'cancel-record':U ) .
  
  RUN get-link-handle IN adm-broker-hdl
        ( INPUT THIS-PROCEDURE,
          INPUT "CONTAINER-source",
          OUTPUT hcproc ).
  hproc = WIDGET-HANDLE(hcproc).
  IF VALID-HANDLE(hProc) THEN DO:
        RUN select-page IN hproc (1).
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
MESSAGE "No puede borrar Tareas" SKIP
        "utilize la opcion de descartar".
RETURN ERROR.

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
    tarea.direccion:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
    tarea.nom_cliente:SENSITIVE = FALSE.

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
  tnombre:CHECKED IN FRAME {&FRAME-NAME} = AVAILABLE cliente AND cliente.cdg_cliente BEGINS "A".
  geolong = IF AVAILABLE tarea THEN tarea.geolong ELSE geolong.
  geolat = IF AVAILABLE tarea THEN tarea.geolat ELSE geolat.
  tarea.nom_cliente:HIDDEN = tnombre.
  tarea.direccion:HIDDEN = NOT tnombre.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  IF AVAILABLE tarea THEN 
      IF int(tarea.nro_destino) <> 0 AND tarea.estado = "R" THEN DO:
        MESSAGE "Existe una accion posterior no puede reeditarse/reabrirse".
        RETURN ERROR.
      END.

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> "" THEN DO:
    tarea.direccion:SENSITIVE = tarea.cdg_tipotarea:SENSITIVE.
    tarea.nom_cliente:SENSITIVE = tarea.cdg_tipotarea:SENSITIVE.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE lista AS CHARACTER.
  RUN inicia_tipotareas.

  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  IF AVAILABLE tarea THEN
    RUN cambia_template ( tarea.cdg_tipotarea ).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view V-table-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN cambia_template ( IF AVAILABLE tarea THEN tarea.cdg_tipotarea ELSE "").
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_cliente V-table-Win 
PROCEDURE poner_cliente :
/*------------------------------------------------------------------------------
  Purpose:  Pone los valores extraidos del cliente seleccionado el el viewer
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM ppatron AS CHAR.
DEFINE VAR lista AS CHAR NO-UNDO.
DEFINE VAR preferido AS CHAR NO-UNDO.
DEFINE VAR auxcargo AS CHAR NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.
DEFINE VAR hcproc AS CHAR NO-UNDO.

DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
DEFINE VAR v-extra AS CHAR NO-UNDO.
DEF VAR ii AS INT NO-UNDO.

RUN decodir(ppatron,OUTPUT v-calle, OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
Tarea.direccion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = cliente.direccion + " " + v-extra.
Tarea.nom_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = cliente.nom_cliente.
geolat = cliente.geolat.
geolong = cliente.geolong.


RUN get-link-handle IN adm-broker-hdl
      ( INPUT THIS-PROCEDURE,
        INPUT "Record-Target",
        OUTPUT hcproc ).
    /* Code placed here will execute PRIOR to standard behavior. */

REPEAT ii = 1 TO NUM-ENTRIES(hcproc):
    hproc = WIDGET-HANDLE(entry(ii,hcproc)).
    IF VALID-HANDLE(hproc) THEN
      RUN cambia_cliente IN hproc ( rowid(cliente) ) NO-ERROR.
END.
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
  {src/adm/template/snd-list.i "Tarea"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_administrador V-table-Win 
FUNCTION que_administrador RETURNS INTEGER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  IF AVAILABLE cliente THEN RETURN cliente.nro_administrador.
  RETURN ?.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

