&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.
DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.



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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE                modo           AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caja-imputacion.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cheque.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valor.
DEFINE INPUT        PARAMETER  modo           AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

{VRSHARED.I "NEW"}

{nrorelea.i}
{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.

DEFINE VARIABLE sino-msg                  AS LOGICAL NO-UNDO.
DEFINE VARIABLE st_seleccionado           AS CHARACTER.

DEFINE VARIABLE rid_tabla                 AS ROWID.

DEFINE VARIABLE v-nro_linea               AS INTEGER.
DEFINE VARIABLE aux_importe               AS DECIMAL.
DEFINE VARIABLE v-debug                   AS LOGICAL INITIAL NO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-8

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Caj_detalle Rubro T-Caj_header

/* Definitions for BROWSE BROWSE-8                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-8 Rubro.cdg_rubro Rubro.nombre ~
T-Caj_detalle.importe T-Caj_detalle.tipo_mov T-Caj_detalle.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-8 
&Scoped-define QUERY-STRING-BROWSE-8 FOR EACH T-Caj_detalle OF T-Caj_header NO-LOCK, ~
      EACH Rubro OF T-Caj_detalle NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-8 OPEN QUERY BROWSE-8 FOR EACH T-Caj_detalle OF T-Caj_header NO-LOCK, ~
      EACH Rubro OF T-Caj_detalle NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-8 T-Caj_detalle Rubro
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-8 T-Caj_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-8 Rubro


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.ingreso T-Caj_header.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Caj_header.fecha ~
T-Caj_header.observacion 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Caj_header
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Caj_header
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-8}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Caj_header SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Caj_header SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Caj_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Caj_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Caj_header.fecha T-Caj_header.observacion 
&Scoped-define ENABLED-TABLES T-Caj_header
&Scoped-define FIRST-ENABLED-TABLE T-Caj_header
&Scoped-Define ENABLED-OBJECTS BROWSE-8 Btn_salir RECT-7 RECT-8 RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Caj_header.tip_comprob ~
T-Caj_header.prf_comprob T-Caj_header.nro_comprob T-Caj_header.fecha ~
T-Caj_header.importe T-Caj_header.ingreso T-Caj_header.observacion 
&Scoped-define DISPLAYED-TABLES T-Caj_header
&Scoped-define FIRST-DISPLAYED-TABLE T-Caj_header
&Scoped-Define DISPLAYED-OBJECTS v-cdg_rubro v-tipomov v-dsc_caja ~
v-cdg_caja imp_no_imp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 14 BY 2.86.

DEFINE BUTTON Btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 14 BY 1.29
     BGCOLOR 8 .

DEFINE BUTTON btn_valores 
     LABEL "&Seleccionar Valores de Cartera" 
     SIZE 58 BY 1.

DEFINE VARIABLE imp_no_imp AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     LABEL "Pendiente" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 7 FGCOLOR 14  NO-UNDO.

DEFINE VARIABLE v-cdg_caja AS INTEGER FORMAT "->,>>>,>>9" INITIAL 0 
     LABEL "Caja" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_rubro AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Rubro" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 6 NO-UNDO.

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-tipomov AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 1.91.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 125 BY 5.19.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 3.33.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-8 FOR 
      T-Caj_detalle, 
      Rubro SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      T-Caj_header SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-8 Dialog-Frame _STRUCTURED
  QUERY BROWSE-8 NO-LOCK DISPLAY
      Rubro.cdg_rubro COLUMN-LABEL "Código!Rubro" FORMAT ">>9":U
      Rubro.nombre COLUMN-LABEL "Descripción!Rubro" FORMAT "X(35)":U
            WIDTH 47.8
      T-Caj_detalle.importe COLUMN-LABEL "Importe!Rubro" FORMAT "->>>,>>>,>>9.99":U
      T-Caj_detalle.tipo_mov COLUMN-LABEL "I!E" FORMAT "X(1)":U
      T-Caj_detalle.observacion COLUMN-LABEL "Observacion!Asocida" FORMAT "X(49)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS MULTIPLE SIZE 142 BY 16.1
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Composición del presente movimiento" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     BROWSE-8 AT ROW 6.71 COL 3
     v-cdg_rubro AT ROW 5.29 COL 17 COLON-ALIGNED
     btn_grabar AT ROW 1.48 COL 130
     T-Caj_header.tip_comprob AT ROW 1.71 COL 17 COLON-ALIGNED
          LABEL "Comprobante"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.prf_comprob AT ROW 1.71 COL 25 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.nro_comprob AT ROW 1.71 COL 33 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.fecha AT ROW 1.71 COL 75 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-tipomov AT ROW 1.71 COL 105 COLON-ALIGNED NO-LABEL
     v-dsc_caja AT ROW 2.91 COL 33 COLON-ALIGNED NO-LABEL
     T-Caj_header.importe AT ROW 2.91 COL 105 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_header.ingreso AT ROW 4.1 COL 105 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 20 BY 1
          BGCOLOR 7 FGCOLOR 14 
     v-cdg_caja AT ROW 2.91 COL 17 COLON-ALIGNED NO-TAB-STOP 
     Btn_salir AT ROW 4.81 COL 130
     btn_valores AT ROW 5.29 COL 35
     imp_no_imp AT ROW 5.29 COL 105 COLON-ALIGNED
     T-Caj_header.observacion AT ROW 4.1 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 74 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     RECT-7 AT ROW 4.57 COL 129
     RECT-8 AT ROW 1.29 COL 3
     RECT-9 AT ROW 1.24 COL 129
     SPACE(3.59) SKIP(18.52)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de valores asociados".


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Caja-imputacion T "?" NO-UNDO sic Caja-imputacion
      TABLE: T-Caj_detalle T "?" NO-UNDO sic Caj_detalle
      TABLE: T-Caj_header T "?" NO-UNDO sic Caj_header
      TABLE: T-Cheque T "?" NO-UNDO sic Cheque
      TABLE: T-Valor T "?" NO-UNDO sic Valor
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB BROWSE-8 1 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_grabar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_valores IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.importe IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN imp_no_imp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.ingreso IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.nro_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.prf_comprob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_header.tip_comprob IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cdg_caja IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_rubro IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-tipomov IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-8
/* Query rebuild information for BROWSE BROWSE-8
     _TblList          = "Temp-Tables.T-Caj_detalle OF Temp-Tables.T-Caj_header,sic.Rubro OF Temp-Tables.T-Caj_detalle"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > sic.Rubro.cdg_rubro
"Rubro.cdg_rubro" "Código!Rubro" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic.Rubro.nombre
"Rubro.nombre" "Descripción!Rubro" ? "character" ? ? ? ? ? ? no ? no no "47.8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > Temp-Tables.T-Caj_detalle.importe
"T-Caj_detalle.importe" "Importe!Rubro" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > Temp-Tables.T-Caj_detalle.tipo_mov
"T-Caj_detalle.tipo_mov" "I!E" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > Temp-Tables.T-Caj_detalle.observacion
"T-Caj_detalle.observacion" "Observacion!Asocida" "X(49)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE BROWSE-8 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Caj_header"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de valores asociados */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-8
&Scoped-define SELF-NAME BROWSE-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-8 Dialog-Frame
ON DELETE-CHARACTER OF BROWSE-8 IN FRAME Dialog-Frame /* Composición del presente movimiento */
DO:
    IF modo = MD_ALTA
    THEN DO:
        IF AVAILABLE T-Caj_detalle
        THEN DO:
            sino-msg = NO.
            MESSAGE "Desea eliminar este renglón de detalle?" 
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
            IF sino-msg
            THEN DO:
                 FIND CURRENT T-Caj_detalle EXCLUSIVE-LOCK.
                 DELETE T-Caj_detalle.
                 {&OPEN-QUERY-{&BROWSE-NAME}}
                 RUN calculos.
            END.
        END.
        ELSE DO:
            MESSAGE "No hay valores que puedan eliminarse" 
                    VIEW-AS ALERT-BOX ERROR.
        END.

    END.
    ELSE DO:
        BELL.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-8 Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BROWSE-8 IN FRAME Dialog-Frame /* Composición del presente movimiento */
OR RETURN OF BROWSE-8 IN FRAME {&FRAME-NAME}
DO:
  IF AVAILABLE  T-Caj_detalle
  THEN DO:
       RUN corregir_detalle.
       {&OPEN-QUERY-{&BROWSE-NAME}}
  END.
  ELSE DO:
       BELL.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar Dialog-Frame
ON CHOOSE OF btn_grabar IN FRAME Dialog-Frame /* Grabar */
DO:

  ASSIGN FRAME {&FRAME-NAME}
        T-Caj_header.fecha 
        T-Caj_header.importe 
        T-Caj_header.observacion.
         
  RUN validar_datos ( OUTPUT hay_error ).
  IF NOT hay_error
  THEN DO:
     
       /*

       IF NOT T-Caj_header.anulado /* No es una anulación */
       THEN DO:
            act_caj_head = ROWID(T-Caj_header).
            RUN c-valores_movimiento.w (INPUT act_caj_head).
            FIND T-Caj_header WHERE ROWID(T-Caj_header) = act_caj_head EXCLUSIVE-LOCK.
            IF T-Caj_header.importe <> T-Caj_header.ingreso THEN RETURN NO-APPLY.
       END.
     
       RUN grabar_datos.

       */
        
       ASSIGN codigo_salir = CD_GRABAR.
       APPLY "U1" TO THIS-PROCEDURE.
  
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_salir Dialog-Frame
ON CHOOSE OF Btn_salir IN FRAME Dialog-Frame /* Salir */
DO:

    sino-msg = NO.
    MESSAGE "Desea abandonar esta función?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
    IF sino-msg
    THEN DO:
        &IF DEFINED (adm-panel) <> 0 &THEN
            RUN dispatch IN THIS-PROCEDURE ('exit').
        &ELSE
/*          APPLY "CLOSE":U TO THIS-PROCEDURE.*/
            ASSIGN codigo_salir = CD_SALIR.
            APPLY "U1":U TO THIS-PROCEDURE.

        &ENDIF

    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_valores
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_valores Dialog-Frame
ON CHOOSE OF btn_valores IN FRAME Dialog-Frame /* Seleccionar Valores de Cartera */
DO:
  RUN d-selcarteraval.w ( INPUT v-cdg_caja, INPUT-OUTPUT TABLE T-Valor).
  RUN ARMAR_DETALLE_VALORES.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_caja
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_caja IN FRAME Dialog-Frame /* Caja */
OR "." OF v-cdg_caja IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_caja IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "caja" "cdg_caja" "SELNCAJA.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_caja Dialog-Frame
ON RETURN OF v-cdg_caja IN FRAME Dialog-Frame /* Caja */
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_caja.
   {traducetabla.i "caja" "cdg_caja" "nombre"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_rubro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_rubro Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_rubro IN FRAME Dialog-Frame /* Rubro */
OR MOUSE-MENU-DOWN,"." OF v-cdg_rubro IN FRAME {&FRAME-NAME}
DO:

  DEFINE VARIABLE rid_rubro AS ROWID.
  {helptabla.i "rubro" "cdg_rubro" "SELRUBRO.P"}


  IF rid_rubro <> ?
  THEN DO:

       FIND Rubro WHERE ROWID(Rubro) = rid_rubro NO-LOCK.
       DISPLAY Rubro.cdg_rubro  @ v-cdg_rubro
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO v-cdg_rubro IN FRAME {&FRAME-NAME}.
  END.
  
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_rubro Dialog-Frame
ON RETURN OF v-cdg_rubro IN FRAME Dialog-Frame /* Rubro */
DO:

   ASSIGN FRAME {&FRAME-NAME}
         v-cdg_rubro.

   FIND Rubro WHERE Rubro.cdg_rubro = v-cdg_rubro NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Rubro
   THEN DO:
        RUN PONMENSJ.P (INPUT "CAJA026").
   END.
   ELSE DO:
        IF ( Rubro.habilitado <> "A" AND Rubro.habilitado <> T-Caj_header.tipo_mov ) AND
           T-Caj_header.tipo_mov <> "C"
        THEN DO:
             RUN PONMENSJ.P ( INPUT "CAJA009" ).
        END.
        ELSE DO:
             RUN crear_detalle.
        END.
   END.
   
   DISPLAY " " @ v-cdg_rubro
           WITH FRAME {&FRAME-NAME}.
   APPLY "ENTRY" TO v-cdg_rubro  IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

{findempresa.i}

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
FIND Caja OF T-Caj_header NO-LOCK.
ASSIGN  v-cdg_caja = Caja.cdg_caja
        v-dsc_caja = Caja.nombre.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
REPEAT 
       ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
       ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  CLEAR FRAME {&FRAME-NAME} ALL.

  IF T-Caj_header.tipo_mov = "I"
      THEN ASSIGN v-tipomov = "      INGRESO"
                  v-tipomov:BGCOLOR = 2
                  v-tipomov:FGCOLOR = 15.
      ELSE ASSIGN v-tipomov = "      EGRESO"
                  v-tipomov:BGCOLOR = 12
                  v-tipomov:FGCOLOR = 15.      

  DISPLAY
        T-Caj_header.fecha 
        T-Caj_header.importe 
        T-Caj_header.ingreso 
        T-Caj_header.nro_comprob 
        T-Caj_header.observacion 
        T-Caj_header.prf_comprob 
        T-Caj_header.tip_comprob 
        v-tipomov
        v-cdg_caja
        v-dsc_caja
        WITH FRAME {&FRAME-NAME}.
  RUN calculos.
  RUN frame_sensitiva ( INPUT YES ).  
  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR THEN LEAVE.
  END CASE.
   
END.
APPLY "CLOSE" TO THIS-PROCEDURE. /* hay que ver si realmente hace falta */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_detalle_valores Dialog-Frame 
PROCEDURE armar_detalle_valores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND FIRST Rubro WHERE Rubro.tipo = "V" NO-LOCK.

  FOR EACH T-Valor WHERE NOT CAN-FIND(T-Caj_detalle WHERE T-Caj_detalle.nro_valor = T-Valor.nro_valor):

        CREATE T-Caj_detalle.
        ASSIGN T-Caj_header.ultima_linea      = T-Caj_header.ultima_linea + 1
               T-Caj_detalle.nro_transaccion  = T-Caj_header.nro_transaccion
               T-Caj_detalle.nro_linea        = T-Caj_header.ultima_linea
               T-Caj_detalle.tipo_mov         = T-Caj_header.tipo_mov
               T-Caj_detalle.cdg_rubro        = Rubro.cdg_rubro
               T-Caj_detalle.nro_valor        = T-Valor.nro_valor
               T-Caj_detalle.importe          = T-Valor.importe
               T-caj_detalle.observacion      = STRING(T-Valor.cdg_banco,"999") + " " + STRING(T-Valor.numero_cheque,"99999999") .

  END.

  FOR EACH T-Caj_detalle WHERE T-Caj_detalle.nro_valor <> 0 AND NOT CAN-FIND(T-Valor WHERE T-Valor.nro_valor = T-Caj_detalle.nro_valor):
      DELETE T-Caj_detalle.
  END.

  {&OPEN-QUERY-{&BROWSE-NAME}} 
  
  RUN CALCULOS.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE calculos Dialog-Frame 
PROCEDURE calculos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  T-Caj_header.ingreso = 0.
  FOR EACH T-Caj_detalle OF T-Caj_header:
      T-Caj_header.ingreso = T-Caj_header.ingreso + T-Caj_detalle.importe.
  END. 
  imp_no_imp = T-Caj_header.importe - T-Caj_header.ingreso.  
  
  DISPLAY imp_no_imp
          T-Caj_header.ingreso
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE corregir_detalle Dialog-Frame 
PROCEDURE corregir_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
 RUN d-detalle_valor.w ( INPUT-OUTPUT TABLE T-Caj_header,
                            INPUT-OUTPUT TABLE T-Caj_detalle,
                            INPUT-OUTPUT TABLE T-Cheque,
                            INPUT-OUTPUT TABLE T-Valor,
                            INPUT Rubro.cdg_rubro,
                            INPUT T-Caj_detalle.nro_linea, 
                            INPUT  modo,
                            INPUT  1, /* modo detalle = CORREGIR */
                            INPUT v-cdg_caja,
                            OUTPUT v-nro_linea ).

    FIND FIRST T-Caj_header EXCLUSIVE-LOCK.

    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_detalle Dialog-Frame 
PROCEDURE crear_detalle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    RUN d-detalle_valor.w ( INPUT-OUTPUT TABLE T-Caj_header,
                            INPUT-OUTPUT TABLE T-Caj_detalle,
                            INPUT-OUTPUT TABLE T-Cheque,
                            INPUT-OUTPUT TABLE T-Valor,
                            INPUT Rubro.cdg_rubro,
                            INPUT 0, 
                            INPUT  modo,
                            INPUT  0, /* modo detalle = CREAR */
                            INPUT v-cdg_caja,
                            OUTPUT v-nro_linea ).

    FIND FIRST T-Caj_header EXCLUSIVE-LOCK.

    IF v-nro_linea <> 0
    THEN DO:
         RUN calculos.
         {&OPEN-QUERY-{&BROWSE-NAME}}
    END.

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
  DISPLAY v-cdg_rubro v-tipomov v-dsc_caja v-cdg_caja imp_no_imp 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Caj_header THEN 
    DISPLAY T-Caj_header.tip_comprob T-Caj_header.prf_comprob 
          T-Caj_header.nro_comprob T-Caj_header.fecha T-Caj_header.importe 
          T-Caj_header.ingreso T-Caj_header.observacion 
      WITH FRAME Dialog-Frame.
  ENABLE BROWSE-8 T-Caj_header.fecha Btn_salir T-Caj_header.observacion RECT-7 
         RECT-8 RECT-9 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE frame_sensitiva Dialog-Frame 
PROCEDURE frame_sensitiva :
/*------------------------------------------------------------------------------
  Purpose: habilita o deshabilita los campos de la frame para el estado inicial
           de la misma que se da cuando comienza el ciclo de transaccion. El es-
           tado definitivo de los campos lo ajusta la rutina habilitar_campos ( INPUT YES ).   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER habilitado AS LOGICAL.

  DO WITH FRAME {&FRAME-NAME}:

      ASSIGN
            btn_grabar:SENSITIVE                    = NO
            
            T-Caj_header.tip_comprob:SENSITIVE      = NO
            T-Caj_header.prf_comprob:SENSITIVE      = NO
            T-Caj_header.nro_comprob:SENSITIVE      = NO
            T-Caj_header.fecha:SENSITIVE            = NO
            T-Caj_header.observacion:SENSITIVE      = NO
            T-Caj_header.importe:SENSITIVE          = NO
            btn_valores:SENSITIVE                   = NO
            v-cdg_rubro:SENSITIVE                   = NO
            v-cdg_caja:SENSITIVE                    = NO.

     IF habilitado
     THEN DO:
        CASE modo:
   
            WHEN MD_ALTA          
            THEN DO:
                 ASSIGN
                    btn_grabar:SENSITIVE                    = YES
                    
                    T-Caj_header.observacion:SENSITIVE      = YES
                    v-cdg_caja:SENSITIVE                    = YES     
                    v-cdg_rubro:SENSITIVE                   = YES
                    btn_valores:SENSITIVE                   = T-Caj_header.tipo_mov <> "I".
            END.
            WHEN MD_MULTIPLE      
            THEN DO:

            END.
            WHEN MD_DEFINIDA      
            THEN DO:
     
            END.
            WHEN MD_RELACION      
            THEN DO:
     
            END.
            WHEN MD_READONLY      
            THEN DO:
     
            END.
            WHEN MD_CAMBIO        
            THEN DO:

            END.
            WHEN MD_ANULACION        
            THEN DO:

            END.
            WHEN MD_EMISION        
            THEN DO:

            END.
   
        END CASE.     
     END.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_caja Dialog-Frame 
PROCEDURE poner_caja :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  IF NOT CAN-DO(Caja.lista_usuarios,Usuario.cdg_usuario)
  THEN DO:
      no_aplicar = YES.
      RUN ponmensj.p ( INPUT "CAJA028" ).
      RETURN ERROR.

  END.
  
  ASSIGN
      v-cdg_caja    = Caja.cdg_caja
      v-cdg_caja    = Caja.cdg_caja.

  DISPLAY  v-cdg_caja 
           v-dsc_caja

           WITH FRAME {&FRAME-NAME}.

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

    DEFINE OUTPUT PARAMETER hubo_error AS LOGICAL.
    
    hubo_error = YES.

    {validartabla.i "Caja"              "cdg_caja"        "nombre"         "CAJA021"}

    IF T-Caj_header.importe = 0
    THEN DO:
/*
       RUN PONMENSJ.P (INPUT "FACT027").
       RETURN. */
    END.  

    IF NOT CAN-DO(Caja.lista_usuarios,Usuario.cdg_usuario)
    THEN DO:
        no_aplicar = YES.
        RUN ponmensj.p ( INPUT "CAJA028" ).
        RETURN ERROR.
    END.
  
    ASSIGN v-cdg_caja    = Caja.cdg_caja
           v-cdg_caja    = Caja.cdg_caja.

    DISPLAY  v-cdg_caja 
             v-dsc_caja
             WITH FRAME {&FRAME-NAME}.
    /*
    IF NOT CAN-FIND(FIRST T-Caja-imputacion WHERE T-Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion)
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT028").
       RETURN.
    END.  
    
    IF imp_no_imp <> 0
    THEN DO:
       RUN PONMENSJ.P (INPUT "FACT029").
       RETURN.
    END.  
    */
    hubo_error = NO.

    &SCOPED-DEFINE TABLA-MAESTRA  T-Caj_header

    {asignartabla.i "Caja" "cdg_caja" "cdg_caja" }
 
    &UNDEFINE TABLA-MAESTRA


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

