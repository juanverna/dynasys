&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE buscar_por   AS CHARACTER.   
DEFINE VARIABLE clave_buscar AS CHARACTER.      
DEFINE VARIABLE rid_articulo AS ROWID.
DEFINE VARIABLE puso_ok      AS LOGICAL. 

&ELSE
DEFINE INPUT  PARAMETER buscar_por   AS CHARACTER.   
DEFINE INPUT  PARAMETER clave_buscar AS CHARACTER.  
DEFINE INPUT-OUTPUT PARAMETER rid_articulo AS ROWID.
DEFINE OUTPUT PARAMETER puso_ok      AS LOGICAL.  



&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE hay_observaciones AS LOGICAL.
DEFINE VARIABLE que_area LIKE Area.cdg_area.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_articulos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Articulo

/* Definitions for BROWSE br_articulos                                  */
&Scoped-define FIELDS-IN-QUERY-br_articulos Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed /* Articulo.a_granel Articulo.unidades_sino Articulo.cdg_ucompra Articulo.compras_sino Articulo.inventario_sino Articulo.produccion_sino Articulo.stock_sino Articulo.ventas_sino */ Articulo.detallada /* Articulo.detallada Articulo.cdg_motbaja Articulo.importe_cuota Articulo.cant_capitas Articulo.fecha_alta Articulo.tipo_compbte */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_articulos   
&Scoped-define SELF-NAME br_articulos
&Scoped-define OPEN-QUERY-br_articulos     CASE buscar_por:          WHEN "NUMERO"          THEN DO:               que_numero = clave_buscar.               OPEN QUERY br_grupos                    FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_articulo BEGINS que_numero                                                AND Articulo.cdg_estado = v-estado                                                AND Articulo.lista_sectores CONTAINS que_area                                                AND Articulo.lista_empresas CONTAINS que_empresa.     /*          BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NRO.AFILIADO=" + que_numero.*/               que_numero = "".           END.           WHEN "NOMBRE"          THEN DO:               que_nombre = clave_buscar.               IF SUBSTRING(que_nombre, ~
      LENGTH(que_nombre), ~
      1) <> "*"                  THEN que_nombre = que_nombre + "*".               OPEN QUERY {&BROWSE-NAME}                    FOR EACH Articulo NO-LOCK WHERE Articulo.descripcion CONTAINS que_nombre                                                AND Articulo.cdg_estado = v-estado                                                AND Articulo.lista_sectores CONTAINS que_area                                                AND Articulo.lista_empresas CONTAINS que_empresa.     /*          BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.*/               que_nombre = "".            END.           OTHERWISE          DO:                OPEN QUERY {&BROWSE-NAME}                    FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_estado = v-estado                                                AND Articulo.lista_sectores CONTAINS que_area                                                AND Articulo.lista_empresas CONTAINS que_empresa.           END.      END CASE.
&Scoped-define TABLES-IN-QUERY-br_articulos Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-br_articulos Articulo


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_articulos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_nombre Btn_Done-2 v-estado que_numero ~
Btn_Salir btn_todos br_articulos 
&Scoped-Define DISPLAYED-OBJECTS que_nombre v-estado que_numero 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Done-2 DEFAULT 
     LABEL "&Elegir" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_todos 
     LABEL "&Todos" 
     SIZE 11 BY .95.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Descripción" 
     VIEW-AS FILL-IN 
     SIZE 56 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Código" 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Habilitados", "",
"De Baja", "B"
     SIZE 16 BY 1.33 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_articulos FOR 
      Articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_articulos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_articulos C-Win _FREEFORM
  QUERY br_articulos NO-LOCK DISPLAY
      Articulo.cdg_articulo     COLUMN-LABEL "Número!Articulo" FORMAT "X(15)"
      Articulo.descripcion      COLUMN-LABEL "Descripcion!Asociada"
      Articulo.cdg_umed         COLUMN-LABEL "Unidad de!Medida"
      /*
      Articulo.a_granel         COLUMN-LABEL "Stock!A Granel"
      Articulo.unidades_sino    COLUMN-LABEL "Stock!En Unidades"
      Articulo.cdg_ucompra      COLUMN-LABEL "Unidad!De Compra"
      Articulo.compras_sino     COLUMN-LABEL "Habilitado!Compras"
      Articulo.inventario_sino  COLUMN-LABEL "Habilitado!Inventario"
      Articulo.produccion_sino  COLUMN-LABEL "Habilitado!Producción"
      Articulo.stock_sino       COLUMN-LABEL "Habilitado!Stock"
      Articulo.ventas_sino      COLUMN-LABEL "Habilitado!Ventas"
      */
      Articulo.detallada        COLUMN-LABEL "Descripcion Detallada!u Observaciones"

      /*
      Articulo.detallada    COLUMN-LABEL "Fecha!Baja"
      Articulo.cdg_motbaja   COLUMN-LABEL "Mot!Baja"
      Articulo.importe_cuota COLUMN-LABEL "Importe!Cuota"
      Articulo.cant_capitas  COLUMN-LABEL "Cant.!Cápitas" FORMAT ">>>>9"
      Articulo.fecha_alta    COLUMN-LABEL "Fecha!Alta"
      Articulo.tipo_compbte  COLUMN-LABEL "Tip!Com" FORMAT "X(1)"
      */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 112 BY 18.33
         FONT 4
         TITLE "Artículos que satisfacen la condición de búsqueda".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_nombre AT ROW 1.29 COL 12 COLON-ALIGNED
     Btn_Done-2 AT ROW 1.29 COL 92
     v-estado AT ROW 2.43 COL 73 NO-LABEL
     que_numero AT ROW 2.62 COL 12 COLON-ALIGNED
     Btn_Salir AT ROW 2.62 COL 92
     btn_todos AT ROW 2.67 COL 59
     br_articulos AT ROW 3.95 COL 2
     "  Ver Productos" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 1.29 COL 72
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 117.8 BY 21.86
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Búsqueda de Artículos"
         HEIGHT             = 22.14
         WIDTH              = 116.8
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 160
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
/* BROWSE-TAB br_articulos btn_todos DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_articulos
/* Query rebuild information for BROWSE br_articulos
     _START_FREEFORM
    CASE buscar_por:
         WHEN "NUMERO"
         THEN DO:
              que_numero = clave_buscar.
              OPEN QUERY br_grupos
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_articulo BEGINS que_numero
                                               AND Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa.
    /*          BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NRO.AFILIADO=" + que_numero.*/
              que_numero = "".

         END.

         WHEN "NOMBRE"
         THEN DO:
              que_nombre = clave_buscar.
              IF SUBSTRING(que_nombre,LENGTH(que_nombre),1) <> "*"
                 THEN que_nombre = que_nombre + "*".
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.descripcion CONTAINS que_nombre
                                               AND Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa.
    /*          BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.*/
              que_nombre = "".


         END.

         OTHERWISE
         DO:

              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa.

         END.

    END CASE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_articulos */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Búsqueda de Artículos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Búsqueda de Artículos */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_articulos
&Scoped-define SELF-NAME br_articulos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_articulos C-Win
ON MOUSE-SELECT-DBLCLICK OF br_articulos IN FRAME DEFAULT-FRAME /* Artículos que satisfacen la condición de búsqueda */
DO:
     APPLY "CHOOSE" TO Btn_Done-2 IN FRAME {&FRAME-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_articulos C-Win
ON RETURN OF br_articulos IN FRAME DEFAULT-FRAME /* Artículos que satisfacen la condición de búsqueda */
DO:
     APPLY "CHOOSE" TO Btn_Done-2 IN FRAME {&FRAME-NAME}.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_articulos C-Win
ON ROW-DISPLAY OF br_articulos IN FRAME DEFAULT-FRAME /* Artículos que satisfacen la condición de búsqueda */
DO:

   IF Articulo.stock_sino  
      THEN RUN poner_color ( INPUT 0, INPUT 15 ).
      ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done-2 C-Win
ON CHOOSE OF Btn_Done-2 IN FRAME DEFAULT-FRAME /* Elegir */
DO:
  
  rid_articulo = ROWID(Articulo).
  puso_ok = YES.
  
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Salir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Salir C-Win
ON CHOOSE OF Btn_Salir IN FRAME DEFAULT-FRAME /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todos C-Win
ON CHOOSE OF btn_todos IN FRAME DEFAULT-FRAME /* Todos */
DO:
  buscar_por = "".
  RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre C-Win
ON RETURN OF que_nombre IN FRAME DEFAULT-FRAME /* Descripción */
DO:
  ASSIGN FRAME {&FRAME-NAME} que_nombre.
  ASSIGN buscar_por   = "NOMBRE"
         clave_buscar = que_nombre.
  RUN abrir_query.
  que_nombre = "".
  DISPLAY que_nombre WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_numero C-Win
ON RETURN OF que_numero IN FRAME DEFAULT-FRAME /* Código */
DO:
  ASSIGN FRAME {&FRAME-NAME} que_numero.
  ASSIGN buscar_por   = "NUMERO"
         clave_buscar = que_numero.
  RUN abrir_query.
  que_numero = "".
  DISPLAY que_numero WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-estado C-Win
ON VALUE-CHANGED OF v-estado IN FRAME DEFAULT-FRAME
DO:
  ASSIGN v-estado.
  RUN abrir_query.
  /*
  MESSAGE "Inicie otra busqueda para el nuevo estado indicado" VIEW-AS ALERT-BOX MESSAGE.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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

{findsector.i}
que_area = Area.cdg_area.

{findempresa.i}
que_empresa = Empresa.cdg_empresa.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  {&WINDOW-NAME}:TITLE = "Búsqueda de Artículos por Sector:" + Area.cdg_area.
  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir_query C-Win 
PROCEDURE abrir_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    CASE buscar_por:
         WHEN "NUMERO"
         THEN DO:
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_articulo BEGINS clave_buscar
                                               AND Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR CODIGO=" + clave_buscar.
              que_numero = "".
    
         END.
    
         WHEN "NOMBRE"
         THEN DO:
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.descripcion CONTAINS clave_buscar
                                               AND Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NOMBRE=" + clave_buscar.
              que_nombre = "".
    
    
         END.
    
         OTHERWISE
         DO:
    
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: TODOS".
         END.
    
    END CASE.

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
  DISPLAY que_nombre v-estado que_numero 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_nombre Btn_Done-2 v-estado que_numero Btn_Salir btn_todos 
         br_articulos 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color C-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      DEFINE INPUT PARAMETER p-fgcolor AS INTEGER.
      DEFINE INPUT PARAMETER p-bgcolor AS INTEGER.
      
      ASSIGN
            Articulo.cdg_articulo:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            Articulo.descripcion:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Articulo.cdg_umed:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fgcolor
            Articulo.detallada:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fgcolor
            /*
            Articulo.cdg_motbaja:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Articulo.cant_capitas:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor 
            Articulo.importe_cuota:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor 
            Articulo.fecha_alta:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor 
            Articulo.tipo_compbte:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            */.

      ASSIGN
            Articulo.cdg_articulo:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            Articulo.descripcion:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Articulo.cdg_umed:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bgcolor
            Articulo.detallada:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bgcolor
            /*
            Articulo.cdg_motbaja:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Articulo.cant_capitas:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor 
            Articulo.importe_cuota:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor 
            Articulo.fecha_alta:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor 
            Articulo.tipo_compbte:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            */.
            
/*
      IF Articulo.observacion = ""
         THEN hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor.
         ELSE hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = 14.
*/

     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

