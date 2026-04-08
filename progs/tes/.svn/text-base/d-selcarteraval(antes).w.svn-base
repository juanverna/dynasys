&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Cartera NO-UNDO LIKE Valor.
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

&IF DEFINED(UIB_is_Running)
&THEN
DEFINE VARIABLE p-cdg_caja LIKE Caja.cdg_caja INITIAL 1.
&ELSE
DEFINE INPUT PARAMETER p-cdg_caja LIKE Caja.cdg_caja.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valor.
&ENDIF

/*{vrshared.i "new"}*/
{nrorelea.i}

DEFINE VARIABLE fecha_inicial AS DATE.
DEFINE VARIABLE fecha_elegida AS DATE.
DEFINE VARIABLE nuevo_select  LIKE Valor.selectado.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Cartera Banco Cliente

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 Banco.cdg_banco Banco.abrevia ~
T-Cartera.numero_cheque T-Cartera.fecha_emision T-Cartera.importe ~
Cliente.cdg_cliente Cliente.nom_cliente 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH T-Cartera NO-LOCK, ~
      EACH Banco OF T-Cartera OUTER-JOIN NO-LOCK, ~
      EACH Cliente OF T-Cartera NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH T-Cartera NO-LOCK, ~
      EACH Banco OF T-Cartera OUTER-JOIN NO-LOCK, ~
      EACH Cliente OF T-Cartera NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 T-Cartera Banco Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 T-Cartera
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-1 Banco
&Scoped-define THIRD-TABLE-IN-QUERY-BROWSE-1 Cliente


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS des_fecha has_fecha Btn_OK Btn_Cancel ~
btn_todos btn_vercheque btn_listar BROWSE-1 RECT-1 RECT-2 RECT-3 RECT-4 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_caja v-dsc_caja des_fecha has_fecha ~
v-subtotal 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Cancelar y Salir" 
     SIZE 23 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_listar 
     LABEL "&Listado" 
     SIZE 23 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir y Salir" 
     SIZE 23 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_todos 
     LABEL "Desmarcar &Todos" 
     SIZE 23 BY 1.14.

DEFINE BUTTON btn_vercheque 
     LABEL "&Ver Valor" 
     SIZE 23 BY 1.14.

DEFINE VARIABLE des_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Desde Fecha" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Hasta Fecha" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_caja AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Caja" 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 84 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-subtotal AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     LABEL "Importe Total" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 73 BY 3.38.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 122 BY 1.43.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 122 BY 1.62.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 48 BY 3.38.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      T-Cartera, 
      Banco, 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 Dialog-Frame _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      Banco.cdg_banco COLUMN-LABEL "Código!Banco" FORMAT "999":U
      Banco.abrevia COLUMN-LABEL "Sigla!Banco" FORMAT "X(8)":U
      T-Cartera.numero_cheque FORMAT ">>>>>>>9":U
      T-Cartera.fecha_emision FORMAT "99/99/99":U
      T-Cartera.importe FORMAT "->>,>>>,>>9.99":U
      Cliente.cdg_cliente FORMAT "X(10)":U
      Cliente.nom_cliente FORMAT "X(38)":U WIDTH 46.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH SEPARATORS SIZE 122 BY 15.62
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Valores Disponibles en Cartera" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_caja AT ROW 1.48 COL 21 COLON-ALIGNED
     v-dsc_caja AT ROW 1.52 COL 39 COLON-ALIGNED NO-LABEL
     des_fecha AT ROW 4.57 COL 21 COLON-ALIGNED
     has_fecha AT ROW 4.57 COL 54 COLON-ALIGNED
     v-subtotal AT ROW 4.57 COL 103 COLON-ALIGNED
     Btn_OK AT ROW 6.71 COL 6
     Btn_Cancel AT ROW 6.71 COL 30
     btn_todos AT ROW 6.71 COL 54
     btn_vercheque AT ROW 6.71 COL 78
     btn_listar AT ROW 6.71 COL 102
     BROWSE-1 AT ROW 8.38 COL 4
     RECT-1 AT ROW 2.86 COL 4
     RECT-2 AT ROW 1.24 COL 4
     RECT-3 AT ROW 6.48 COL 4
     RECT-4 AT ROW 2.91 COL 78
     "   Rango de fechas de emisión de los valores a considerar:" VIEW-AS TEXT
          SIZE 71 BY 1 AT ROW 3.14 COL 5
          BGCOLOR 5 FGCOLOR 15 
     "       Importe de valores seleccionados" VIEW-AS TEXT
          SIZE 46 BY 1 AT ROW 3.14 COL 79
          BGCOLOR 5 FGCOLOR 15 
     SPACE(4.39) SKIP(21.85)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Seleccion de Valores en Cartera"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Cartera T "?" NO-UNDO sic Valor
      TABLE: T-Valor T "?" NO-UNDO sic Valor
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-1 btn_listar Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-cdg_caja IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-subtotal IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "Temp-Tables.T-Cartera,sic.Banco OF Temp-Tables.T-Cartera,sic.Cliente OF Temp-Tables.T-Cartera"
     _Options          = "NO-LOCK"
     _TblOptList       = ", OUTER,,"
     _FldNameList[1]   > sic.Banco.cdg_banco
"sic.Banco.cdg_banco" "Código!Banco" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Banco.abrevia
"sic.Banco.abrevia" "Sigla!Banco" "X(8)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   = Temp-Tables.T-Cartera.numero_cheque
     _FldNameList[4]   = Temp-Tables.T-Cartera.fecha_emision
     _FldNameList[5]   = Temp-Tables.T-Cartera.importe
     _FldNameList[6]   > sic.Cliente.cdg_cliente
"sic.Cliente.cdg_cliente" ? "X(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic.Cliente.nom_cliente
"sic.Cliente.nom_cliente" ? "X(38)" "character" ? ? ? ? ? ? no ? no no "46.6" yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Seleccion de Valores en Cartera */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF BROWSE-1 IN FRAME Dialog-Frame /* Valores Disponibles en Cartera */
OR "RETURN" OF {&BROWSE-NAME} IN FRAME {&FRAME-NAME}
DO:

   IF NOT AVAILABLE T-Cartera 
   THEN DO:
      BELL.
      MESSAGE "No hay cheques que puedan seleccionarse"
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
      RETURN NO-APPLY.
   END.
   ELSE DO:

        FIND T-Valor WHERE T-Valor.nro_valor = T-Cartera.nro_valor NO-ERROR.
        IF AVAILABLE T-Valor 
        THEN DO:
            T-Cartera.selectado = NO.
            DELETE T-Valor.
            RUN poner_color.
        END.
        ELSE DO:
            T-Cartera.selectado = YES.
            CREATE T-Valor.
            BUFFER-COPY T-Cartera TO T-Valor.
            RUN poner_color.
        END.     

        RUN sumar_valores.

   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 Dialog-Frame
ON ROW-DISPLAY OF BROWSE-1 IN FRAME Dialog-Frame /* Valores Disponibles en Cartera */
DO:
  RUN poner_color.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancelar y Salir */
DO:
  RUN desmarcar_todos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listar Dialog-Frame
ON CHOOSE OF btn_listar IN FRAME Dialog-Frame /* Listado */
DO:

   RUN NOESTA.P.
  /*
   MESSAGE "Confirme con OK que desea emitir el listado"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK-CANCEL TITLE "Se pide confirmacion"
           SET sino AS LOGICAL.
   IF sino 
   THEN DO:
        RUN lsselcarteraval.p.
   END.  
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todos Dialog-Frame
ON CHOOSE OF btn_todos IN FRAME Dialog-Frame /* Desmarcar Todos */
DO:
    RUN desmarcar_todos.
/*
   GET FIRST {&BROWSE-NAME}.
   nuevo_select = NOT Valor.selectado.
   DO WHILE AVAILABLE(Valor):
      FIND B-Valor WHERE ROWID(B-Valor) = ROWID(Valor) EXCLUSIVE-LOCK.
      B-Valor.selectado = nuevo_select.
      IF B-Valor.selectado
        THEN B-Valor.estado = stchq_usuario.
        ELSE B-Valor.estado = stchq_encarte.

      GET NEXT {&BROWSE-NAME}.
   END.
   RUN ABRE_QUERY.
*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_vercheque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_vercheque Dialog-Frame
ON CHOOSE OF btn_vercheque IN FRAME Dialog-Frame /* Ver Valor */
DO:
  FIND Valor WHERE Valor.nro_valor = T-Cartera.nro_valor NO-LOCK.
  RUN d-muestra_valor.w ( INPUT ROWID(Valor)).

/*
   IF NOT AVAILABLE Valor 
   THEN DO:
        BELL.
        MESSAGE "No hay cheques que puedan consultarse"
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
   END.
   ELSE DO:
        ult_valor = ROWID(Valor).
        HIDE FRAME frm-cheques NO-PAUSE.
        RUN ACTVALOR.P (INPUT 2).
        RUN PONER_SESION.
        VIEW FRAME frm-cheques.
        RUN ABRE_QUERY.
   END.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha Dialog-Frame
ON MOUSE-MENU-DOWN OF des_fecha IN FRAME Dialog-Frame /* Desde Fecha */
DO:

  fecha_inicial = DATE(des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL des_fecha Dialog-Frame
ON RETURN OF des_fecha IN FRAME Dialog-Frame /* Desde Fecha */
OR "TAB" OF des_fecha IN FRAME {&FRAME-NAME}
DO:
  
     IF INPUT des_fecha = ? OR INPUT has_fecha = ? 
     THEN DO:
        BELL.
        MESSAGE "No puede indicarse una fecha en blanco"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
     END. 


     IF NOT AVAILABLE Caja
     THEN DO:
        BELL.
        MESSAGE "No se ha indicado la caja a consultar"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
     END.        


     ASSIGN FRAME {&FRAME-NAME} 
            des_fecha
            has_fecha.

     RUN abre_query.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha Dialog-Frame
ON MOUSE-MENU-DOWN OF has_fecha IN FRAME Dialog-Frame /* Hasta Fecha */
DO:

  fecha_inicial = DATE(has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL has_fecha Dialog-Frame
ON RETURN OF has_fecha IN FRAME Dialog-Frame /* Hasta Fecha */
OR "TAB" OF has_fecha IN FRAME {&FRAME-NAME}
DO:
  
     IF INPUT des_fecha = ? OR INPUT has_fecha = ? 
     THEN DO:
        BELL.
        MESSAGE "No puede indicarse una fecha en blanco"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
     END. 


     IF NOT AVAILABLE Caja
     THEN DO:
        BELL.
        MESSAGE "No se ha indicado la caja a consultar"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
     END.        


     ASSIGN FRAME {&FRAME-NAME} 
            des_fecha
            has_fecha.

     RUN abre_query.
  
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

{findempresa.i}

FIND FIRST Caja WHERE Caja.cdg_caja = p-cdg_caja NO-LOCK.
v-cdg_caja = Caja.cdg_caja.
v-dsc_caja = Caja.nombre.
des_fecha = TODAY.
has_fecha = des_fecha + 90.

RUN cargar_cartera.

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
  
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abre_query Dialog-Frame 
PROCEDURE abre_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    {&OPEN-QUERY-{&BROWSE-NAME}}
     RUN sumar_valores.
     DISPLAY v-subtotal WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_cartera Dialog-Frame 
PROCEDURE cargar_cartera :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Cartera.

  FOR EACH Valor WHERE Valor.cdg_caja = p-cdg_caja AND Valor.estado = "00":
      CREATE T-Cartera.
      BUFFER-COPY Valor TO T-Cartera.
  END.

  FOR EACH T-Valor:
      FIND T-Cartera WHERE T-Cartera.nro_valor = T-Valor.nro_valor.
      T-Cartera.selectado = YES.
  END.
  RUN sumar_valores.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE desmarcar_todos Dialog-Frame 
PROCEDURE desmarcar_todos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  EMPTY TEMP-TABLE T-Valor.
  RUN sumar_valores.

  FOR EACH T-Cartera WHERE T-Cartera.selectado:
      T-Cartera.selectado = NO.
  END.

  {&OPEN-QUERY-{&BROWSE-NAME}}

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
  DISPLAY v-cdg_caja v-dsc_caja des_fecha has_fecha v-subtotal 
      WITH FRAME Dialog-Frame.
  ENABLE des_fecha has_fecha Btn_OK Btn_Cancel btn_todos btn_vercheque 
         btn_listar BROWSE-1 RECT-1 RECT-2 RECT-3 RECT-4 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color Dialog-Frame 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE VARIABLE fg_selectado AS INTEGER INITIAL 0.
 DEFINE VARIABLE bg_selectado AS INTEGER INITIAL 7.

 DEFINE VARIABLE fg_disponible AS INTEGER INITIAL 9.
 DEFINE VARIABLE bg_disponible AS INTEGER INITIAL 15.

 IF T-Cartera.selectado
 THEN DO:   
     ASSIGN Banco.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado
            Banco.cdg_banco:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado 
            Cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado 
            Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado 
            T-Cartera.fecha_emision:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado 
            T-Cartera.importe:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado 
            T-Cartera.numero_cheque:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_selectado
            Banco.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado
            Banco.cdg_banco:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado 
            Cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado 
            Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado 
            T-Cartera.fecha_emision:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado 
            T-Cartera.importe:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado 
            T-Cartera.numero_cheque:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_selectado.
 END.       
 ELSE DO:   
     ASSIGN Banco.abrevia:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible
            Banco.cdg_banco:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible 
            Cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible 
            Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible 
            T-Cartera.fecha_emision:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible 
            T-Cartera.importe:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible 
            T-Cartera.numero_cheque:FGCOLOR IN BROWSE {&BROWSE-NAME} = fg_disponible
            Banco.abrevia:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible
            Banco.cdg_banco:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible 
            Cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible 
            Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible 
            T-Cartera.fecha_emision:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible 
            T-Cartera.importe:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible 
            T-Cartera.numero_cheque:BGCOLOR IN BROWSE {&BROWSE-NAME} = bg_disponible.
 END.       


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sumar_valores Dialog-Frame 
PROCEDURE sumar_valores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-subtotal = 0.
  FOR EACH T-Valor:
      v-subtotal = v-subtotal + T-Valor.Importe.
  END.
  DISPLAY v-subtotal
      WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

