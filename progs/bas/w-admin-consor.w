&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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

{nrorelea.i}
{tiempo.i}
DEFINE VARIABLE txn_activa AS LOGICAL.


DEFINE TEMP-TABLE tt
FIELD nro_administrador AS INT
FIELD nro_consorcio AS INT
FIELD cdg_consorcio LIKE cliente.cdg_cliente
FIELD cdg_administrador LIKE cliente.cdg_cliente
FIELD ult-limpieza AS DATE
FIELD contratos AS CHAR FORMAT "X(40)"
FIELD direccion LIKE cliente.direccion
FIELD nom_cliente LIKE Cliente.nom_cliente
FIELD email LIKE sic.Persona.email
FIELD contacto LIKE persona.nombre
FIELD ptel1 AS CHAR FORMAT "X(30)"
FIELD ptel2 AS CHAR FORMAT "X(30)"
INDEX nro_administrador nro_administrador nro_consorcio
INDEX nom_cliente nom_cliente direccion .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 cdg_administrador nom_cliente contacto email ptel1 ptel2 cdg_consorcio direccion ult-limpieza contratos   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH tt BY tt.nom_cliente
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH tt BY tt.nom_cliente.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 tt


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Cestado BROWSE-2 Btn-excel fencont 
&Scoped-Define DISPLAYED-OBJECTS Cestado fencont 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn-excel 
     IMAGE-UP FILE "excel.gif":U NO-FOCUS
     LABEL "&Modifica" 
     SIZE 9 BY 1.33 TOOLTIP "Modifica el registro actual"
     FONT 4.

DEFINE VARIABLE Cestado AS CHARACTER FORMAT "X(256)":U INITIAL "A" 
     LABEL "Estado" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Aprobado","A",
                     "Todos","*"
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE fencont AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Encontrados" 
      VIEW-AS TEXT 
     SIZE 14 BY .62 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      tt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 DISPLAY
      cdg_administrador
nom_cliente
contacto
email
ptel1
ptel2
cdg_consorcio
direccion
ult-limpieza
contratos
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 120 BY 19.05 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cestado AT ROW 1.48 COL 25 COLON-ALIGNED WIDGET-ID 6
     BROWSE-2 AT ROW 2.91 COL 4 WIDGET-ID 100
     Btn-excel AT ROW 1.33 COL 2 WIDGET-ID 2
     fencont AT ROW 1.71 COL 65 COLON-ALIGNED WIDGET-ID 10
     "Administrador-Consorcio-Contratos" VIEW-AS TEXT
          SIZE 37 BY 1.19 AT ROW 1.33 COL 87 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 128.8 BY 21.86.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Modelo"
         HEIGHT             = 21.86
         WIDTH              = 128.8
         MAX-HEIGHT         = 26.62
         MAX-WIDTH          = 159.6
         VIRTUAL-HEIGHT     = 26.62
         VIRTUAL-WIDTH      = 159.6
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-2 Cestado F-Main */
ASSIGN 
       fencont:READ-ONLY IN FRAME F-Main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt BY tt.nom_cliente
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Modelo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Modelo */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
  DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.


  RUN verificar_txn ( OUTPUT txn_activa ).
  IF NOT txn_activa
  THEN DO: 
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
  END.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-MINIMIZED OF W-Win /* Modelo */
DO:
  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No debe minimizar esta ventana con una actualización pendiente"
               VIEW-AS ALERT-BOX WARNING TITLE "CUIDADO!!!".
       {&WINDOW-NAME}:WINDOW-STATE = 1.
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-excel W-Win
ON CHOOSE OF Btn-excel IN FRAME F-Main /* Modifica */
DO:
    run excel-export ( {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME} ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga W-Win 
PROCEDURE carga :
/*------------------------------------------------------------------------------
  Purpose:   cargar la tt para el listado de relaciones de administradores con consorcios  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER administrador FOR cliente.
DEFINE VAR ii AS INT.
DEFINE VAR kk AS INT.
DEFINE VAR almenos AS LOGICAL.
DEFINE VAR cc AS INT.
ASSIGN FRAME {&FRAME-NAME} cestado.
FIND cargo_persona WHERE cargo_persona.cdg_cargo = "ADM" NO-LOCK NO-ERROR.
FIND tipo_evento WHERE cdg_tipo_evento = "LT".
fencont = 0.
SESSION:IMMEDIATE-DISPLAY = YES.
FOR EACH administrador BREAK BY nro_administrador:
  fencont = fencont + 1.
  DISPLAY fencont WITH FRAME {&FRAME-NAME}.
  FOR EACH cliente WHERE cliente.nro_administrador = administrador.nro_cliente:
    CREATE tt.

    ASSIGN tt.nro_administrador = administrador.nro_cliente
           tt.nro_consorcio = cliente.nro_cliente
           tt.cdg_consorcio = cliente.cdg_cliente
           tt.cdg_administrador = administrador.cdg_cliente
           tt.direccion = cliente.direccion
           tt.nom_cliente = administrador.nom_cliente.
    FOR EACH contrato_hd OF cliente WHERE (cestado = "*" OR cestado = contrato_hd.estado ) AND ( Contrato_hd.rige_desde <= today 
      AND Contrato_hd.rige_hasta >= today )
      AND ( Contrato_hd.cant_periodos = 0  OR Contrato_hd.cant_periodos <> Contrato_hd.resto_periodos ),
      FIRST contrato_dt OF contrato_hd, articulo OF contrato_dt:
       tt.contratos = tt.contratos + "," + Articulo.cdg_tipoart + ":" + string(contrato_hd.nro_contrato,">>>>>9").
    END.
    tt.contratos = SUBSTRING(tt.contratos,2).
    FOR EACH evento OF cliente WHERE evento.nro_tipo_evento = tipo_evento.nro_tipo_evento and
                          NOT evento.anulado AND evento.frealizado <> ? BY evento.frealizado DESC:
       tt.ult-limpieza = evento.frealizado.
    END.
    FIND domicilio OF administrador NO-LOCK.
    IF AVAILABLE domicilio THEN DO:
          FOR EACH cliente-contacto OF domicilio WHERE Cliente-contacto.cdg_cargo = cargo_persona.cdg_cargo,
                FIRST Persona OF cliente-contacto NO-LOCK.
                tt.contacto = persona.nombre.
                ptel1 = "".
                ptel2 = "".
                DO ii = 1 TO NUM-ENTRIES(persona.numeros_telefono,"|"):
                   IF entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!") <> "" THEN DO:
                       IF kk = 0 THEN DO:
                          ptel1 = entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!").
                          kk = 1.
                       END.
                       ELSE
                          ptel2 = entry(2,ENTRY(ii,persona.numeros_telefono,"|"),"!").
                   END.
                END.
        
                IF index("0123456789-. " , substring( persona.nombre , 1 , 1 )) = 0 and ( LENGTH( ptel1 ) <> 0 OR LENGTH( ptel2 ) <> 0 ) AND emailcheck(Persona.email) THEN do:
                    almenos=true.
                    LEAVE.
                END.
           END.
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
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
  DISPLAY Cestado fencont 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Cestado BROWSE-2 Btn-excel fencont 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/

  RUN verificar_txn ( OUTPUT txn_activa ).
  IF txn_activa
  THEN DO:
       RETURN NO-APPLY.
  END.     
  ELSE DO:
       APPLY "CLOSE":U TO THIS-PROCEDURE.
       RETURN.
  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
RUN carga.
{&OPEN-BROWSERS-IN-QUERY-{&FRAME-NAME}}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view W-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {setwintit.i "SIC/FAC" "Relacion Administrador - Consorcios"}


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "tt"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.
/*
    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).

    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE verificar_txn W-Win 
PROCEDURE verificar_txn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-estado AS LOGICAL.

  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No puede salir de esta pantalla con una actualización pendiente"
               VIEW-AS ALERT-BOX ERROR.
       p-estado = YES.
  END.
  ELSE DO:
       p-estado = NO.   /* Function return value. */
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

