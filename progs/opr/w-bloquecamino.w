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
{GeoLibrary.I}
{restricciones.i}
DEFINE VARIABLE txn_activa AS LOGICAL.

DEFINE TEMP-TABLE bloque
FIELD nro_contrato LIKE contrato_hd.nro_contrato COLUMN-LABEL "Contrato"
FIELD sub_evento AS INT COLUMN-LABEL "SE"
FIELD nro_padre LIKE contrato_hd.nro_contrato COLUMN-LABEL "Padre"
FIELD sub_evento_padre AS INT COLUMN-LABEL "SP"
FIELD turno AS CHAR FORMAT "XX" COLUMN-LABEL "TU"
FIELD durac AS INT COLUMN-LABEL "Durac"
FIELD tipoblk AS CHAR FORMAT "X(10)" COLUMN-LABEL "TIPO" 
FIELD dist AS DECIMAL FORMAT ">>>>>>9" COLUMN-LABEL "Dist"
FIELD direccion LIKE cliente.direccion
field Restricciones AS CHAR FORMAT "x(70)"
INDEX pp nro_padre turno .

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
&Scoped-define INTERNAL-TABLES bloque

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 bloque.nro_contrato bloque.sub_evento bloque.nro_padre bloque.sub_evento_padre bloque.turno bloque.durac bloque.tipoblk bloque.dist bloque.direccion bloque.restricciones   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH bloque
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH bloque.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 bloque
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 bloque


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Paso BUTTON-13 BUTTON-1 BROWSE-2 
&Scoped-Define DISPLAYED-OBJECTS Paso 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD duref W-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rdur W-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rest W-Win 
FUNCTION rest RETURNS CHARACTER
  ( nro AS INT, sub AS INT)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "Button 1" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-13 
     LABEL "excel" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE Paso AS CHARACTER FORMAT "X(256)":U 
     LABEL "Paso" 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      bloque SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 DISPLAY
      bloque.nro_contrato
bloque.sub_evento
bloque.nro_padre
bloque.sub_evento_padre
bloque.turno
bloque.durac
bloque.tipoblk
bloque.dist
bloque.direccion
bloque.restricciones
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 163.8 BY 25.24 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Paso AT ROW 1.24 COL 17 COLON-ALIGNED WIDGET-ID 6
     BUTTON-13 AT ROW 1.24 COL 88 WIDGET-ID 8
     BUTTON-1 AT ROW 1.24 COL 117 WIDGET-ID 2
     BROWSE-2 AT ROW 2.43 COL 2 WIDGET-ID 100
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 164.8 BY 28.29.


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
         HEIGHT             = 28.29
         WIDTH              = 164.8
         MAX-HEIGHT         = 28.29
         MAX-WIDTH          = 164.8
         VIRTUAL-HEIGHT     = 28.29
         VIRTUAL-WIDTH      = 164.8
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
/* BROWSE-TAB BROWSE-2 BUTTON-1 F-Main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH bloque.
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


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 W-Win
ON CHOOSE OF BUTTON-1 IN FRAME F-Main /* Button 1 */
DO:
RUN llena.
{&OPEN-QUERY-{&BROWSE-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 W-Win
ON CHOOSE OF BUTTON-13 IN FRAME F-Main /* excel */
DO:
  RUN excel-export2( {&BROWSE-NAME}:HANDLE , 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1').
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE chequeaerrores W-Win 
PROCEDURE chequeaerrores :
/*------------------------------------------------------------------------------
  Purpose:   den contrato vigente  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER rcontrato AS rowid.
DEFINE BUFFER bcontrato_hd for contrato_hd.
DEFINE BUFFER bcontrato_restriccion FOR contrato_restriccion.
DEFINE VAR miraerrores AS LOGICAL.
FIND contrato_hd WHERE ROWID(contrato_hd) = rcontrato NO-LOCK.
FIND restriccion WHERE restriccion.evaluar and
               Restriccion.nro_tipo_evento = evento.nro_tipo_evento AND
               CAN-DO("BLOQ*",Restriccion.cdg_restriccion) NO-LOCK NO-ERROR.

      IF AVAILABLE restriccion THEN do:
          FOR each contrato_restriccion WHERE 
           contrato_restriccion.nro_contrato = contrato_hd.nro_contrato AND
           contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK: 
           FIND bcontrato_hd WHERE  bcontrato_hd.nro_contrato = INT( entry( 1 , contrato_restriccion.valor , "|" ) )
                     AND bcontrato_hd.numero_eventos >= int( entry( 2 , contrato_restriccion.valor , "|" ) ) NO-LOCK NO-ERROR.
               IF NOT AVAILABLE bcontrato_hd THEN DO:
                     OUTPUT TO value("c:\sic-temp\erroresplanBLOQUE.txt" ) APPEND.
                     PUT UNFORMATTED "BLOQUE PARA " contrato_restriccion.nro_contrato "|" contrato_restriccion.sub_evento " No existe Padre " ENTRY( 1, contrato_restriccion.valor,"|") "|" ENTRY( 2, contrato_restriccion.valor,"|") SKIP.
                     OUTPUT CLOSE.
                     miraerrores = TRUE.
               END.
               ELSE DO:
                  /*que el padre exista y este activo*/
                  IF NOT (bcontrato_hd.estado = "A" AND bcontrato_hd.fecha_baja = ?  AND bcontrato_hd.rige_hasta > TODAY AND
                    ( bcontrato_hd.cant_periodos  = bcontrato_hd.resto_periodos OR
                      bcontrato_hd.resto_periodos > 0 )) THEN DO:
                         OUTPUT TO value("c:\sic-temp\erroresplanBLOQUE.txt" ) APPEND.
                         PUT UNFORMATTED "BLOQUE PARA " contrato_restriccion.nro_contrato "|" contrato_restriccion.sub_evento " No existe Padre " ENTRY( 1, contrato_restriccion.valor,"|") "|" ENTRY( 2, contrato_restriccion.valor,"|") SKIP.
                         OUTPUT CLOSE.
                  END.
                  /*que el padre no sea hijo en otro bloque*/
                  /*el padre no puede tener ninguna restristrccion de bloque*/
                  FIND FIRST bcontrato_restriccion WHERE 
                    bcontrato_restriccion.nro_contrato = bcontrato_hd.nro_contrato AND
                    bcontrato_restriccion.nro_restriccion = restriccion.nro_restriccion  NO-LOCK no-error.
                  IF AVAILABLE bcontrato_restriccion THEN DO: 
                        miraerrores = TRUE.
                        OUTPUT TO value("c:\sic-temp\erroresplanBLOQUE.txt" ) APPEND.
                        PUT UNFORMATTED "BLOQUE PARA " contrato_restriccion.nro_contrato "|" contrato_restriccion.sub_evento " Tiene como Padre " ENTRY( 1, contrato_restriccion.valor,"|") "|" ENTRY( 2, contrato_restriccion.valor,"|") " que es hijo en " ENTRY( 1, bcontrato_restriccion.valor,"|") "|" ENTRY( 2, bcontrato_restriccion.valor,"|") SKIP.
                        OUTPUT CLOSE.
                  END.
               END.
          END.
     END.
END.

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
  DISPLAY Paso 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Paso BUTTON-13 BUTTON-1 BROWSE-2 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE llena W-Win 
PROCEDURE llena :
/*------------------------------------------------------------------------------
  Purpose:     llenar la tabla con los bloques y sus distancias.
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR ddd AS DATE INITIAL 11/01/2011 NO-UNDO.   
DEFINE VAR hhh AS DATE INITIAL 11/30/2011 NO-UNDO.
DEFINE VAR pperiodo AS INT NO-UNDO.
DEFINE VAR c_nro_tipo_evento AS INT INITIAL 1.
DEFINE VAR v-ciclo_facturacion AS INT NO-UNDO.
DEFINE VAR  v-transcurridos AS INT NO-UNDO.
DEFINE VAR ii AS INT NO-UNDO.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR temprdur AS INT NO-UNDO.
DEFINE VAR OPRDDTA AS INT NO-UNDO.
DEFINE BUFFER bcontrato_hd FOR contrato_hd.
DEFINE BUFFER bcliente FOR cliente.
DEF VAR pgeox AS DECIMAL NO-UNDO.
DEF VAR pgeoy AS DECIMAL NO-UNDO.
RUN getparametro_n.p ( "OPRDDTA" , OUTPUT OPRDDTA ).
pperiodo = YEAR(ddd) * 100 + MONTH(ddd).
paso:SCREEN-VALUE IN FRAME {&FRAME-NAME}= "Recopilando".
FOR EACH contrato_hd NO-LOCK WHERE contrato_hd.estado = "A" AND contrato_hd.rige_hasta >= ddd AND
      contrato_hd.rige_desde <= hhh AND
      ( contrato_hd.cant_periodos = 0 )
      AND year(contrato_hd.rige_desde) * 100 + month(contrato_hd.rige_desde)  <= pperiodo and 
      not Contrato_hd.anulado and  ( contrato_hd.fecha_baja = ? OR year(contrato_hd.fecha_baja) * 100 + MONTH(contrato_hd.fecha_baja) > pperiodo )
      AND contrato_hd.nro_tipo_evento = c_nro_tipo_evento
      ,FIRST cliente NO-LOCK OF contrato_hd :
      ii = ii + 1.
       v-ciclo_facturacion = INTEGER(Contrato_hd.modo_facturacion).

       IF contrato_hd.primer_mes = 0 THEN
       v-transcurridos = (year(ddd) - year(Contrato_hd.rige_desde )) * 12 + 
                         month(ddd) - month(Contrato_hd.rige_hasta ).
       ELSE
       v-transcurridos = (year(ddd) - Contrato_hd.primer_ano) * 12 + 
                         month(ddd) - contrato_hd.primer_mes.

       IF v-transcurridos MOD v-ciclo_facturacion <> 0 THEN NEXT.

       DO i = 1 TO contrato_hd.numero_eventos:
          find first contrato_restriccion NO-LOCK where contrato_restriccion.nro_contrato = contrato_hd.nro_contrato and contrato_restriccion.sub_evento = i and contrato_restriccion.nro_restriccion = 16 no-error. 
          temprdur = ?.
          FOR EACH evento NO-LOCK WHERE evento.nro_identificacion = contrato_hd.nro_contrato AND
                                evento.sub_evento = i AND frealizado <> ? AND
                                evento.nro_tipo_evento = c_nro_tipo_evento BY frealizado DESC:
              temprdur = rdur(Evento.nro_evento).
              LEAVE.
          END.
          CREATE bloque.
          ASSIGN bloque.nro_contrato = contrato_hd.nro_contrato
                 bloque.sub_evento = i
                 bloque.Durac = IF available contrato_restriccion THEN int(contrato_restriccion.valor) ELSE OPRDDTA.
                 bloque.direccion = cliente.direccion.
                 bloque.restriccion = rest(contrato_hd.nro_contrato, i).
          IF temprdur <> ? THEN bloque.durac = temprdur.
      END.
  END.

  FOR EACH bloque :
/*bloques*/
paso:SCREEN-VALUE = "Bloques".
    FIND restriccion WHERE restriccion.evaluar and
                   Restriccion.nro_tipo_evento = c_nro_tipo_evento AND
                   CAN-DO("BLOQ*",Restriccion.cdg_restriccion) NO-LOCK NO-ERROR.
          IF AVAILABLE restriccion THEN do:
              FIND contrato_restriccion WHERE 
               contrato_restriccion.nro_contrato = bloque.nro_contrato AND
               contrato_restriccion.sub_evento = bloque.sub_evento AND
               contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR. 
              IF AVAILABLE contrato_restriccion THEN do:
                  bloque.nro_padre = int(entry(1,contrato_restriccion.valor, "|")).
                  bloque.sub_evento = int(entry(2,contrato_restriccion.valor, "|")).
                  bloque.tipoblk = "BLOQUE".
                  FIND bcontrato_hd WHERE bcontrato_hd.nro_contrato = bloque.nro_padre AND
                                          bcontrato_hd.estado = "A" AND bcontrato_hd.rige_hasta >= ddd AND
                                          bcontrato_hd.rige_desde <= hhh AND
                                          ( bcontrato_hd.cant_periodos = 0 ) AND 
                                          year(bcontrato_hd.rige_desde) * 100 + month(bcontrato_hd.rige_desde)  <= pperiodo and 
                                          not bContrato_hd.anulado and  ( bcontrato_hd.fecha_baja = ? OR year(bcontrato_hd.fecha_baja) * 100 + MONTH(bcontrato_hd.fecha_baja) > pperiodo )
                                          AND bcontrato_hd.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE bcontrato_hd THEN DO:
                    MESSAGE "Error en " bloque.nro_contrato " ablocado a " bloque.nro_padre VIEW-AS ALERT-BOX ERROR.
                    bloque.tipoblk = "ERROR".
                    NEXT.
                  END.
              END.
          END.
/*turnos*/
paso:SCREEN-VALUE = "Turnos".
         FIND restriccion WHERE restriccion.evaluar AND 
                                Restriccion.nro_tipo_evento = c_nro_tipo_evento 
                                AND Restriccion.cdg_restriccion BEGINS "TURNO" NO-LOCK NO-ERROR .
         IF AVAILABLE restriccion  THEN DO:
              FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato =bloque.nro_contrato AND
                   contrato_restriccion.sub_evento = bloque.sub_evento  AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
              IF AVAILABLE contrato_restriccion THEN do:
                  bloque.turno = ( IF entry(1,contrato_restriccion.valor,"|") = "" THEN "M" ELSE entry(1,contrato_restriccion.valor,"|")) + entry(2,contrato_restriccion.valor,"|").
              END.
              ELSE bloque.turno = "M*".
         END.
         ELSE bloque.turno = "M*".
  END.
/*bloques virtuales*/
paso:SCREEN-VALUE = "Virtuales".
    FIND restriccion WHERE restriccion.evaluar AND 
                                Restriccion.nro_tipo_evento = c_nro_tipo_evento AND 
                                Restriccion.cdg_restriccion BEGINS "dfEV" NO-LOCK NO-ERROR.
         IF AVAILABLE restriccion THEN DO:
             FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = bloque.nro_contrato AND
                   contrato_restriccion.sub_evento = bloque.sub_evento  AND contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
             IF AVAILABLE contrato_restriccion THEN do:
                bloque.nro_padre = int(entry(1,contrato_restriccion.valor, "|")).
                bloque.sub_evento = int(entry(2,contrato_restriccion.valor, "|")).
                bloque.tipoblk = "dfEV".
                  FIND bcontrato_hd WHERE bcontrato_hd.nro_contrato = bloque.nro_padre AND
                                          bcontrato_hd.estado = "A" AND bcontrato_hd.rige_hasta >= ddd AND
                                          bcontrato_hd.rige_desde <= hhh AND
                                          ( bcontrato_hd.cant_periodos = 0 ) AND 
                                          year(bcontrato_hd.rige_desde) * 100 + month(bcontrato_hd.rige_desde)  <= pperiodo and 
                                          not bContrato_hd.anulado and  ( bcontrato_hd.fecha_baja = ? OR year(bcontrato_hd.fecha_baja) * 100 + MONTH(bcontrato_hd.fecha_baja) > pperiodo )
                                          AND bcontrato_hd.nro_tipo_evento = c_nro_tipo_evento NO-LOCK NO-ERROR.
                  IF NOT AVAILABLE bcontrato_hd THEN DO:
                    MESSAGE "Error en " bloque.nro_contrato " ablocado a " bloque.nro_padre VIEW-AS ALERT-BOX ERROR.
                    bloque.tipoblk = "ERROR".
                    NEXT.
                  END.
             END.
         END.
/*padre de si mismo para unificacion*/
paso:SCREEN-VALUE = "Padres".
FOR EACH bloque:
    IF bloque.nro_padre = 0 THEN do:
        bloque.nro_padre = bloque.nro_contrato.
        bloque.sub_evento_padre = bloque.sub_evento.
        bloque.tipo = "PADRE".
    END.
END.
/*calculando distancias segun camino*/

paso:SCREEN-VALUE = "Distancias".
FOR EACH bloque,FIRST contrato_hd NO-LOCK WHERE contrato_hd.nro_contrato = bloque.nro_contrato, cliente NO-LOCK OF contrato_hd   BREAK BY bloque.nro_padre BY bloque.turno:
 IF FIRST-OF(bloque.nro_padre) THEN do: 
    bloque.dist = 0. 
    pgeox = cliente.geoX.
    pgeoy = cliente.geoY.
    NEXT. 
 END.
 bloque.dist = distGeodesicaUTM(cliente.geoX , cliente.geoY ,
                                       pgeoX , pgeoY ).
 pgeox = cliente.geoX.
 pgeoy = cliente.geoY.
 
END.
        
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view W-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */
SESSION:IMMEDIATE-DISPLAY = TRUE.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {setwintit.i "SIC/BAS" "Analisis de Bloques segun camino"}


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
  {src/adm/template/snd-list.i "bloque"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION duref W-Win 
FUNCTION duref RETURNS INT
  ( d AS CHAR, h AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR hh1 AS DECIMAL NO-UNDO.
DEFINE VAR mm1 AS DECIMAL NO-UNDO.
DEFINE VAR hh2 AS DECIMAL NO-UNDO.
DEFINE VAR mm2 AS DECIMAL NO-UNDO.


h = REPLACE(h,":","").
d = REPLACE(d,":","").
hh1 = INT(h).
h = STRING(hh1,"9999").
hh1 = INT(d).
d = STRING(hh1,"9999").

hh1 = INT( SUBSTRING(d,1,2) ).
mm1 = INT( SUBSTRING(d,3,2) ).
hh2 = INT( SUBSTRING(h,1,2) ).
mm2 = INT( SUBSTRING(h,3,2) ).

mm1 = mm1 / 60.
mm2 = mm2 / 60.
hh1 = hh1 + mm1.
hh2 = hh2 + mm2.

RETURN INT((hh2 - hh1) * 60 ).   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rdur W-Win 
FUNCTION rdur RETURNS INTEGER
  ( rr AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  Duracion media
    Notes:  Se tiene en cuenta de descartar valores  alejados +- 20% de la media
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
DEFINE VAR pp1 AS INT NO-UNDO.
DEFINE VAR media AS INT NO-UNDO.
DEFINE VAR suma AS INT NO-UNDO.
DEFINE VAR pp AS INT INITIAL 5 NO-UNDO. /*cantidad de periodos maximos de analisis*/
DEFINE BUFFER bevento FOR evento.
DEFINE BUFFER weve FOR evento.
pp1 = 0.
suma = 0.
FIND weve WHERE weve.nro_evento = rr NO-LOCK.
CASE weve.origen:
WHEN "CONTRATO" THEN DO:
    FOR EACH bevento NO-LOCK WHERE bevento.origen = weve.origen AND 
        bevento.nro_identificacion = weve.nro_identificacion AND
        bevento.sub_evento = weve.sub_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        kk = abs(duref(bevento.hora_desde, bevento.hora_hasta)).
        IF kk = 0 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + kk.
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    pp1 = 0.
    suma = 0.
        FOR EACH bevento NO-LOCK WHERE bevento.origen = weve.origen AND 
        bevento.nro_identificacion = weve.nro_identificacion AND
        bevento.sub_evento = weve.sub_evento AND
         NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = duref(bevento.hora_desde, bevento.hora_hasta).
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END.
WHEN "COBRANZA" THEN DO:
    FOR EACH bevento NO-LOCK WHERE bevento.nro_cliente = weve.nro_cliente AND 
        bevento.nro_tipo_evento = weve.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
        kk = abs(duref(bevento.hora_desde, bevento.hora_hasta)).
        IF kk = 0 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + kk.
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    pp1 = 0.
    suma = 0.
        FOR EACH bevento NO-LOCK WHERE bevento.nro_cliente = weve.nro_cliente AND 
        bevento.nro_tipo_evento = weve.nro_tipo_evento AND
        NOT bevento.anulado AND bevento.frealizado<>? BY bevento.fasignado DESCENDING:
            kk = duref(bevento.hora_desde, bevento.hora_hasta).
            IF kk <= media * .8 OR kk >= media * 1.2 THEN NEXT.
        pp1 = pp1 + 1.
        suma = suma + duref(bevento.hora_desde, bevento.hora_hasta).
        IF pp1 > pp THEN LEAVE.
    END.
    media = suma / pp1.
    RETURN media.
END.
OTHERWISE RETURN ?.
END.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rest W-Win 
FUNCTION rest RETURNS CHARACTER
  ( nro AS INT, sub AS INT) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR rr AS CHAR NO-UNDO.
        rr = "".
        FOR EACH contrato_restriccion WHERE contrato_restriccion.nro_contrato = nro AND
          contrato_restriccion.sub_evento = sub NO-LOCK,
          restriccion OF contrato_restriccion NO-LOCK BY Restriccion.nro_tipo_evento BY restriccion.prioridad BY restriccion.cdg_restriccion:
          rr = rr + " " + restriccion.cdg_restriccion + "[" + contrato_restriccion.valor + "]".
        END.
        rr = rr + hijos(nro).
        RETURN SUBSTRING(rr,2).
  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

