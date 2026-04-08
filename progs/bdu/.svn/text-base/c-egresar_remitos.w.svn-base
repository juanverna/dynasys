&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Encabezado_salida NO-UNDO LIKE Rem_header.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
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
/*          This .W file was created with the Progress AppBuilder.      */
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

{findempresa.i}

DEFINE TEMP-TABLE T-Detalle_salida NO-UNDO
    FIELD cdg_articulo    AS CHARACTER FORMAT "X(15)"    COLUMN-LABEL "Cdg!Articulo"
    FIELD dsc_articulo    AS CHARACTER FORMAT "X(50)"    COLUMN-LABEL "Dsc!Articulo"
    FIELD cdg_registrable AS CHARACTER FORMAT "X(20)"    COLUMN-LABEL "Cdg!Registrable"
    FIELD cantidad        AS DECIMAL   FORMAT ">>>>9.99" COLUMN-LABEL "Cantidad!Remito"
    FIELD ingresado       AS DECIMAL   FORMAT ">>>>9.99" COLUMN-LABEL "Cantidad!Ingresada"
    FIELD nro_serie       AS CHARACTER FORMAT "X(20)"    COLUMN-LABEL "Número!Serie"
    FIELD num_etiqueta    AS CHARACTER FORMAT "X(12)"    COLUMN-LABEL "Número!Etiqueta"
    FIELD linea           AS INTEGER  /*lo utilizo solo para posicionar la selección de la linea del browse*/
    FIELD cumplido        AS LOGICAL.

DEFINE VARIABLE v-que_remito AS CHARACTER FORMAT "X".
DEFINE VARIABLE puede_finalizar   AS LOGICAL INITIAL NO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Detalle_salida T-Encabezado_salida

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 T-Detalle_salida.cdg_articulo T-Detalle_salida.dsc_articulo T-detalle_salida.cantidad T-detalle_salida.cdg_registrable T-detalle_salida.nro_serie T-detalle_salida.num_etiqueta T-detalle_salida.ingresado   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH T-Detalle_salida NO-LOCK     WHERE T-Detalle_salida.cantidad > T-Detalle_salida.ingresado INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH T-Detalle_salida NO-LOCK     WHERE T-Detalle_salida.cantidad > T-Detalle_salida.ingresado INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 T-Detalle_salida
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 T-Detalle_salida


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define FIELDS-IN-QUERY-DEFAULT-FRAME ~
T-Encabezado_salida.tip_comprob T-Encabezado_salida.prf_comprob ~
T-Encabezado_salida.nro_comprob T-Encabezado_salida.fecha ~
T-Encabezado_salida.nombre T-Encabezado_salida.nom_transportista ~
T-Encabezado_salida.direccion T-Encabezado_salida.patente ~
T-Encabezado_salida.cuit_transportista T-Encabezado_salida.precintos ~
T-Encabezado_salida.chofer T-Encabezado_salida.dni_transportista 
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-BROWSE-2}
&Scoped-define QUERY-STRING-DEFAULT-FRAME FOR EACH T-Encabezado_salida SHARE-LOCK
&Scoped-define OPEN-QUERY-DEFAULT-FRAME OPEN QUERY DEFAULT-FRAME FOR EACH T-Encabezado_salida SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-DEFAULT-FRAME T-Encabezado_salida
&Scoped-define FIRST-TABLE-IN-QUERY-DEFAULT-FRAME T-Encabezado_salida


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-remito Btn_cancelar BROWSE-2 RECT-1 RECT-2 ~
RECT-3 RECT-4 
&Scoped-Define DISPLAYED-FIELDS T-Encabezado_salida.tip_comprob ~
T-Encabezado_salida.prf_comprob T-Encabezado_salida.nro_comprob ~
T-Encabezado_salida.fecha T-Encabezado_salida.nombre ~
T-Encabezado_salida.nom_transportista T-Encabezado_salida.direccion ~
T-Encabezado_salida.patente T-Encabezado_salida.cuit_transportista ~
T-Encabezado_salida.precintos T-Encabezado_salida.chofer ~
T-Encabezado_salida.dni_transportista 
&Scoped-define DISPLAYED-TABLES T-Encabezado_salida
&Scoped-define FIRST-DISPLAYED-TABLE T-Encabezado_salida
&Scoped-Define DISPLAYED-OBJECTS v-remito v-codetiqueta 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_aprobar 
     LABEL "&Aprobar Todo" 
     SIZE 22 BY 1.14.

DEFINE BUTTON Btn_cancelar 
     LABEL "Cancelar Operación en Curso" 
     SIZE 30 BY 1.14.

DEFINE BUTTON Btn_finalizar 
     LABEL "&Finalizar Operación" 
     SIZE 22 BY 1.14.

DEFINE VARIABLE v-codetiqueta AS CHARACTER FORMAT "X(50)":U 
     LABEL "Etiqueta" 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-remito AS CHARACTER FORMAT "X(15)":U 
     LABEL "Remito" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 77 BY 7.14.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 76 BY 7.14.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 77 BY 1.67.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 76 BY 1.67.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      T-Detalle_salida SCROLLING.

DEFINE QUERY DEFAULT-FRAME FOR 
      T-Encabezado_salida SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 C-Win _FREEFORM
  QUERY BROWSE-2 NO-LOCK DISPLAY
      T-Detalle_salida.cdg_articulo
      T-Detalle_salida.dsc_articulo
      T-detalle_salida.cantidad
      T-detalle_salida.cdg_registrable
      T-detalle_salida.nro_serie
      T-detalle_salida.num_etiqueta 
      T-detalle_salida.ingresado
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 154 BY 16.48 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     v-remito AT ROW 2.19 COL 17 COLON-ALIGNED
     T-Encabezado_salida.tip_comprob AT ROW 2.19 COL 97 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.prf_comprob AT ROW 2.19 COL 105 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.nro_comprob AT ROW 2.19 COL 113 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.fecha AT ROW 2.19 COL 138 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 15 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.nombre AT ROW 4.81 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 55 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.nom_transportista AT ROW 4.81 COL 97 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 56 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.direccion AT ROW 6 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 55 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.patente AT ROW 6 COL 97 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.cuit_transportista AT ROW 6 COL 136 COLON-ALIGNED
          LABEL "CUIT"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.precintos AT ROW 7.19 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 55 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.chofer AT ROW 7.19 COL 97 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Encabezado_salida.dni_transportista AT ROW 7.19 COL 136 COLON-ALIGNED
          LABEL "DNI"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16.8 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     v-codetiqueta AT ROW 9.1 COL 17 COLON-ALIGNED
     Btn_aprobar AT ROW 9.1 COL 82.2
     Btn_cancelar AT ROW 9.1 COL 104.6
     Btn_finalizar AT ROW 9.1 COL 135
     BROWSE-2 AT ROW 11.24 COL 5
     RECT-1 AT ROW 1.43 COL 3.6
     RECT-2 AT ROW 1.43 COL 81.6
     RECT-3 AT ROW 8.81 COL 3.6
     RECT-4 AT ROW 8.81 COL 81.6
     "   Datos del Transportista" VIEW-AS TEXT
          SIZE 56 BY .81 AT ROW 3.86 COL 99
          BGCOLOR 7 FGCOLOR 15 
     "   Datos del Destinatario" VIEW-AS TEXT
          SIZE 55 BY .81 AT ROW 3.86 COL 19
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 160 BY 27.67.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Encabezado_salida T "?" NO-UNDO sic Rem_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Remitos a Egresar"
         HEIGHT             = 26.33
         WIDTH              = 160
         MAX-HEIGHT         = 34.05
         MAX-WIDTH          = 204.8
         VIRTUAL-HEIGHT     = 34.05
         VIRTUAL-WIDTH      = 204.8
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* BROWSE-TAB BROWSE-2 Btn_finalizar DEFAULT-FRAME */
/* SETTINGS FOR BUTTON Btn_aprobar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON Btn_finalizar IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.chofer IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.cuit_transportista IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.direccion IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.dni_transportista IN FRAME DEFAULT-FRAME
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.fecha IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.nombre IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.nom_transportista IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.nro_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.patente IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.precintos IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.prf_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Encabezado_salida.tip_comprob IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-codetiqueta IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH T-Detalle_salida NO-LOCK
    WHERE T-Detalle_salida.cantidad > T-Detalle_salida.ingresado INDEXED-REPOSITION.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME DEFAULT-FRAME
/* Query rebuild information for FRAME DEFAULT-FRAME
     _TblList          = "Temp-Tables.T-Encabezado_salida"
     _Query            is OPENED
*/  /* FRAME DEFAULT-FRAME */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Remitos a Egresar */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Remitos a Egresar */
DO:
  /* This event will close the window and terminate the procedure.  */

  IF v-remito:SENSITIVE IN FRAME {&FRAME-NAME} = YES THEN APPLY "CLOSE":U TO THIS-PROCEDURE.
  ELSE MESSAGE "No puede salir de esta pantalla con una actualización pendiente" VIEW-AS ALERT-BOX ERROR.

  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_aprobar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_aprobar C-Win
ON CHOOSE OF Btn_aprobar IN FRAME DEFAULT-FRAME /* Aprobar Todo */
DO:
    RUN aprobar_todo.
    btn_finalizar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    btn_aprobar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.  
    APPLY "ENTRY":U TO btn_finalizar IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_cancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_cancelar C-Win
ON CHOOSE OF Btn_cancelar IN FRAME DEFAULT-FRAME /* Cancelar Operación en Curso */
DO:
    RUN cancelar_operacion.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_finalizar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_finalizar C-Win
ON CHOOSE OF Btn_finalizar IN FRAME DEFAULT-FRAME /* Finalizar Operación */
DO:
  DEFINE VARIABLE sino            AS LOGICAL.

  MESSAGE "Desea realizar el egreso del remito?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación"
           SET sino.
  IF sino 
  THEN DO:
      RUN finalizar_operacion.
      APPLY "CHOOSE":U TO btn_cancelar IN FRAME {&FRAME-NAME}.
      APPLY "ENTRY":U TO v-remito IN FRAME {&FRAME-NAME}.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-codetiqueta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-codetiqueta C-Win
ON RETURN OF v-codetiqueta IN FRAME DEFAULT-FRAME /* Etiqueta */
DO:
  {trgetiqueta.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-remito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-remito C-Win
ON RETURN OF v-remito IN FRAME DEFAULT-FRAME /* Remito */
DO: 
    DEFINE VARIABLE v-prefijo AS INTEGER.
    DEFINE VARIABLE v-numero  AS INTEGER.

    DEFINE VARIABLE v-linea AS INTEGER. /*la utilizo solo para seleccionar el detalle del BROWSE-2*/

    {findempresa.i}

    ASSIGN v-remito.

    IF NUM-ENTRIES(v-remito,"-") = 2
        THEN ASSIGN v-prefijo = INTEGER(ENTRY(1,v-remito,"-"))
                    v-numero  = INTEGER(ENTRY(2,v-remito,"-")) NO-ERROR.
        ELSE ASSIGN v-prefijo = INTEGER(SUBSTRING(v-remito,1,4))
                    v-numero  = INTEGER(SUBSTRING(v-remito,5,8)) NO-ERROR.
        IF ERROR-STATUS:ERROR
        THEN DO:
             RUN PONMENSJ.P (INPUT "EGRE000"). /*Tipo de datos incorrecto*/
             DISPLAY " " @  v-remito WITH FRAME {&FRAME-NAME}.
             APPLY "ENTRY" TO v-remito IN FRAME {&FRAME-NAME}.
             RETURN NO-APPLY.
        END.

           /*Determino a quién pertenece el remito*/

        FIND Rem_header      /*Es Cliente?*/
            WHERE Rem_header.cdg_empresa = Empresa.cdg_empresa
              AND Rem_header.tip_comprob = "RM"
              AND Rem_header.prf_comprob = v-prefijo
              AND Rem_header.nro_comprob = v-numero
              AND Rem_header.cdg_estado  = "RE"
              AND Rem_header.anulado = NO
                  NO-LOCK NO-ERROR.
        IF AVAILABLE Rem_header
        THEN DO:
            v-que_remito = "C".
            &SCOPED-DEFINE TABLA Rem_header
            &SCOPED-DEFINE CAMPO nro_remito
            &SCOPED-DEFINE TABLA2 Rem_detalle
            &SCOPED-DEFINE TABLA3 Registrable-remito
            &SCOPED-DEFINE TABLA_AUX Rem_header
               {Muestra-remito.i}
            &UNDEFINE TABLA
            &UNDEFINE CAMPO
            &UNDEFINE TABLA2
            &UNDEFINE TABLA3
            &UNDEFINE TABLA_AUX
        {Tiene_precinto.i}    
        END.
        ELSE DO:
            FIND Rem_header_prv      /*Es Proveedor?*/
                WHERE Rem_header_prv.cdg_empresa = Empresa.cdg_empresa
                  AND Rem_header_prv.tip_comprob = "RM"
                  AND Rem_header_prv.prf_comprob = v-prefijo
                  AND Rem_header_prv.nro_comprob = v-numero
                  AND Rem_header_prv.cdg_estado  = "RE"
                  AND Rem_header_prv.anulado = NO
                      NO-LOCK NO-ERROR.
            IF AVAILABLE Rem_header_prv
            THEN DO:
                v-que_remito = "P".
                &SCOPED-DEFINE TABLA Rem_header_prv
                &SCOPED-DEFINE CAMPO nro_remprov
                &SCOPED-DEFINE TABLA2 Rem_detalle_prv
                &SCOPED-DEFINE TABLA3 Registrable-remprov
                &SCOPED-DEFINE TABLA_AUX Rem_header_prv
                   {Muestra-remito.i}
                &UNDEFINE TABLA
                &UNDEFINE CAMPO
                &UNDEFINE TABLA2
                &UNDEFINE TABLA3
                &UNDEFINE TABLA_AUX
                {Tiene_precinto.i}
            END.
            ELSE DO:
                FIND Transdep_hd        /*Es Depósito?*/
                    WHERE Transdep_hd.cdg_empresa = Empresa.cdg_empresa
                      AND Transdep_hd.tip_comprob = "RM"
                      AND Transdep_hd.prf_comprob = v-prefijo
                      AND Transdep_hd.nro_comprob = v-numero
                      AND Transdep_hd.cdg_estado  = "RE"
                      AND Transdep_hd.anulado = NO
                          NO-LOCK NO-ERROR.
                IF AVAILABLE Transdep_hd
                THEN DO:
                    v-que_remito = "D".

                    FIND Deposito OF Transdep_hd NO-LOCK.

                    &SCOPED-DEFINE TABLA Transdep_hd
                    &SCOPED-DEFINE CAMPO nro_transdep
                    &SCOPED-DEFINE TABLA2 Transdep_dt
                    &SCOPED-DEFINE TABLA3 Registrable-transdep
                    &SCOPED-DEFINE TABLA_AUX Deposito
                       {Muestra-remito.i}
                    &UNDEFINE TABLA
                    &UNDEFINE CAMPO
                    &UNDEFINE TABLA2
                    &UNDEFINE TABLA3
                    &UNDEFINE TABLA_AUX
                    {Tiene_precinto.i}
                END.

                ELSE DO:
                    RUN PONMENSJ.P (INPUT "EGRE001").
                    DISPLAY " " @  v-remito WITH FRAME {&FRAME-NAME}.
                    APPLY "ENTRY" TO v-remito IN FRAME {&FRAME-NAME}.
                    RETURN NO-APPLY.
                END.
            END.
        END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

  {setwintit.i "SIC/BDU" "Egreso de Remitos de Planta"}.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE aprobar_todo C-Win 
PROCEDURE aprobar_todo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FOR EACH T-Detalle_salida:
        T-Detalle_salida.ingresado = T-Detalle_salida.cantidad.
    END.
        
    {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cancelar_operacion C-Win 
PROCEDURE cancelar_operacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    v-remito:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
    v-codetiqueta:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    RUN vaciar_temp-tables.

    RUN vaciar_campos.

    {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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

  {&OPEN-QUERY-DEFAULT-FRAME}
  GET FIRST DEFAULT-FRAME.
  DISPLAY v-remito v-codetiqueta 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  IF AVAILABLE T-Encabezado_salida THEN 
    DISPLAY T-Encabezado_salida.tip_comprob T-Encabezado_salida.prf_comprob 
          T-Encabezado_salida.nro_comprob T-Encabezado_salida.fecha 
          T-Encabezado_salida.nombre T-Encabezado_salida.nom_transportista 
          T-Encabezado_salida.direccion T-Encabezado_salida.patente 
          T-Encabezado_salida.cuit_transportista T-Encabezado_salida.precintos 
          T-Encabezado_salida.chofer T-Encabezado_salida.dni_transportista 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE v-remito Btn_cancelar BROWSE-2 RECT-1 RECT-2 RECT-3 RECT-4 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE finalizar_operacion C-Win 
PROCEDURE finalizar_operacion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE x-nro_solicitud AS INTEGER.

    DO TRANSACTION:
      
          CASE v-que_remito:
              WHEN "C" THEN DO:
                  FIND Rem_header WHERE Rem_header.nro_remito = T-Encabezado_salida.nro_remito EXCLUSIVE-LOCK.
                  ASSIGN
                       Rem_header.fecha_embarque = TODAY
                       Rem_header.cdg_estado = "FI"
                       x-nro_solicitud = Rem_header.nro_solicitud.
                  RELEASE Rem_header.
              END.
              WHEN "P" THEN DO:
                  FIND Rem_header_prv WHERE Rem_header_prv.nro_remprov = T-Encabezado_salida.nro_remito EXCLUSIVE-LOCK.
                  ASSIGN
                       Rem_header_prv.fecha_embarque = TODAY
                       Rem_header_prv.cdg_estado = "FI"
                       x-nro_solicitud = Rem_header_prv.nro_solicitud.
                  RELEASE Rem_header_prv.
              END.
              WHEN "D" THEN DO:
                  FIND Transdep_hd WHERE Transdep_hd.nro_transdep = T-Encabezado_salida.nro_remito EXCLUSIVE-LOCK.
                  ASSIGN
                       Transdep_hd.cdg_estado = "FI"
                       x-nro_solicitud = Transdep_hd.nro_solicitud.
                  RELEASE Transdep_hd.
              END.
          END CASE.
    
          FIND Sre_header WHERE Sre_header.nro_solicitud = x-nro_solicitud EXCLUSIVE-LOCK.
          FIND Motivo_retiro OF Sre_header NO-LOCK.
          IF Motivo_retiro.con_regreso THEN Sre_header.cdg_estado = "PR".
          ELSE Sre_header.cdg_estado = "FI".
          Sre_header.fecha_retiro = TODAY.
          RELEASE Sre_header.

   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE vaciar_campos C-Win 
PROCEDURE vaciar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   ASSIGN
        v-remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        v-codetiqueta:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.tip_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.prf_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.nro_comprob:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.nom_transportista:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.chofer:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.patente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.dni_transportista:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.cuit_transportista:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.nombre:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.direccion:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
        T-Encabezado_salida.precintos:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".

   btn_finalizar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   
   APPLY "ENTRY":U TO v-remito IN FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE vaciar_temp-tables C-Win 
PROCEDURE vaciar_temp-tables :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    EMPTY TEMP-TABLE T-Encabezado_salida.
    EMPTY TEMP-TABLE T-Detalle_salida.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

