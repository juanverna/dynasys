&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
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
DEFINE VARIABLE buscar_por   AS CHARACTER.   
DEFINE VARIABLE clave_buscar AS CHARACTER.      
DEFINE VARIABLE rid_articulo AS ROWID.
DEFINE VARIABLE puso_ok      AS LOGICAL. 

&ELSE
DEFINE INPUT  PARAMETER buscar_por   AS CHARACTER.   
DEFINE INPUT  PARAMETER clave_buscar AS CHARACTER.  
DEFINE INPUT  PARAMETER uso AS CHAR.
DEFINE INPUT-OUTPUT PARAMETER rid_articulo AS ROWID.
DEFINE OUTPUT PARAMETER puso_ok      AS LOGICAL.  

&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE hay_observaciones AS LOGICAL.
DEFINE VARIABLE que_area LIKE Area.cdg_area.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
/*DEFINE VAR tcompras_sino AS LOGICAL NO-UNDO.
DEFINE VAR tinventario_sino AS LOGICAL NO-UNDO.
DEFINE VAR tventas_sino AS LOGICAL NO-UNDO.
DEFINE VAR tproduccion_sino AS LOGICAL NO-UNDO.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME br_articulos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Articulo

/* Definitions for BROWSE br_articulos                                  */
&Scoped-define FIELDS-IN-QUERY-br_articulos Articulo.cdg_articulo Articulo.descripcion Articulo.cdg_umed /* Articulo.a_granel Articulo.unidades_sino Articulo.cdg_ucompra Articulo.compras_sino Articulo.inventario_sino Articulo.produccion_sino Articulo.stock_sino Articulo.ventas_sino */ Articulo.detallada /* Articulo.detallada Articulo.cdg_motbaja Articulo.importe_cuota Articulo.cant_capitas Articulo.fecha_alta Articulo.tipo_compbte */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_articulos   
&Scoped-define SELF-NAME br_articulos
&Scoped-define OPEN-QUERY-br_articulos CASE buscar_por:          WHEN "NUMERO"          THEN DO:               que_numero = clave_buscar.               OPEN QUERY {&BROWSE-NAME}                    FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_articulo BEGINS que_numero                                                AND Articulo.cdg_estado = v-estado                                                AND Articulo.lista_sectores CONTAINS que_area                                                AND Articulo.lista_empresas CONTAINS que_empresa AND                   ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or                                                  (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or                                                  (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or                                                  (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )                                                by cdg_articulo.                BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.               que_numero = "".           END.           WHEN "NOMBRE"          THEN DO:               que_nombre = clave_buscar.               IF SUBSTRING(que_nombre, ~
      LENGTH(que_nombre), ~
      1) <> "*"                  THEN que_nombre = que_nombre + "*".               OPEN QUERY {&BROWSE-NAME}                    FOR EACH Articulo NO-LOCK WHERE Articulo.descripcion CONTAINS que_nombre                                                AND Articulo.cdg_estado = v-estado                                                AND Articulo.lista_sectores CONTAINS que_area                                                AND Articulo.lista_empresas CONTAINS que_empresa AND                   ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or                                                  (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or                                                  (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or                                                  (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )                                                by Articulo.descripcion.               BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.               que_nombre = "".            END.           OTHERWISE          DO:               OPEN QUERY {&BROWSE-NAME}                    FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_estado = v-estado                                                AND Articulo.lista_sectores CONTAINS que_area                                                AND Articulo.lista_empresas CONTAINS que_empresa AND                   ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or                                                  (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or                                                  (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or                                                  (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )                   BY articulo.cdg_articulo.                   BROWSE {&BROWSE-NAME}:TITLE = "".           END.      END CASE.
&Scoped-define TABLES-IN-QUERY-br_articulos Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-br_articulos Articulo


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-br_articulos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS tventas_sino Btn_OK que_nombre tcompras_sino ~
v-estado Btn_Cancel que_numero tinventario_sino btn_todos tproduccion_sino ~
br_articulos 
&Scoped-Define DISPLAYED-OBJECTS tventas_sino que_nombre tcompras_sino ~
v-estado que_numero tinventario_sino tproduccion_sino 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir" 
     SIZE 9 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Elegir" 
     SIZE 9 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_todos 
     LABEL "Ver &Todos los Artículos" 
     SIZE 30 BY .95.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Descripción" 
     VIEW-AS FILL-IN 
     SIZE 93 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Código" 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-estado AS CHARACTER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Habilitados", "",
"De Baja", "B"
     SIZE 16 BY 1.33 NO-UNDO.

DEFINE VARIABLE tcompras_sino AS LOGICAL INITIAL no 
     LABEL "Compras" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .76.

DEFINE VARIABLE tinventario_sino AS LOGICAL INITIAL no 
     LABEL "Inventario" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .76.

DEFINE VARIABLE tproduccion_sino AS LOGICAL INITIAL no 
     LABEL "Producción" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .76.

DEFINE VARIABLE tventas_sino AS LOGICAL INITIAL no 
     LABEL "Ventas" 
     VIEW-AS TOGGLE-BOX
     SIZE 17 BY .76.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_articulos FOR 
      Articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_articulos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_articulos Dialog-Frame _FREEFORM
  QUERY br_articulos NO-LOCK DISPLAY
      Articulo.cdg_articulo     COLUMN-LABEL "Número!Articulo" FORMAT "X(15)"
      Articulo.descripcion      COLUMN-LABEL "Descripcion!Asociada" FORMAT "X(65)"
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
    WITH NO-ROW-MARKERS SIZE 160 BY 18.1
         FONT 4
         TITLE "Artículos que satisfacen la condición de búsqueda".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     tventas_sino AT ROW 1 COL 130 WIDGET-ID 8
     Btn_OK AT ROW 1.19 COL 152
     que_nombre AT ROW 1.29 COL 12 COLON-ALIGNED
     tcompras_sino AT ROW 1.81 COL 130 WIDGET-ID 2
     v-estado AT ROW 2.43 COL 110 NO-LABEL
     Btn_Cancel AT ROW 2.43 COL 152
     que_numero AT ROW 2.62 COL 12 COLON-ALIGNED
     tinventario_sino AT ROW 2.62 COL 130 WIDGET-ID 4
     btn_todos AT ROW 2.67 COL 77
     tproduccion_sino AT ROW 3.43 COL 130 WIDGET-ID 6
     br_articulos AT ROW 4.57 COL 2
     "  Ver Productos" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 1.29 COL 109
          BGCOLOR 7 FGCOLOR 15 
     SPACE(36.00) SKIP(21.13)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Busqueda de Artículos"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
/* BROWSE-TAB br_articulos tproduccion_sino Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

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
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_articulo BEGINS que_numero
                                               AND Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa AND
                  ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or
                                                 (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or
                                                 (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or
                                                 (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )
                                               by cdg_articulo.

              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.
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
                                               AND Articulo.lista_empresas CONTAINS que_empresa AND
                  ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or
                                                 (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or
                                                 (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or
                                                 (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )
                                               by Articulo.descripcion.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
              que_nombre = "".


         END.

         OTHERWISE
         DO:

             OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa AND
                  ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or
                                                 (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or
                                                 (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or
                                                 (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )
                  BY articulo.cdg_articulo.
                  BROWSE {&BROWSE-NAME}:TITLE = "".

         END.

    END CASE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_articulos */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Busqueda de Artículos */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_articulos
&Scoped-define SELF-NAME br_articulos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_articulos Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF br_articulos IN FRAME Dialog-Frame /* Artículos que satisfacen la condición de búsqueda */
DO:
     APPLY "CHOOSE" TO Btn_OK IN FRAME {&FRAME-NAME}.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_articulos Dialog-Frame
ON RETURN OF br_articulos IN FRAME Dialog-Frame /* Artículos que satisfacen la condición de búsqueda */
DO:
     APPLY "CHOOSE" TO Btn_Ok IN FRAME {&FRAME-NAME}.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_articulos Dialog-Frame
ON ROW-DISPLAY OF br_articulos IN FRAME Dialog-Frame /* Artículos que satisfacen la condición de búsqueda */
DO:

   IF Articulo.stock_sino  
      THEN RUN poner_color ( INPUT 0, INPUT 15 ).
      ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Elegir */
DO:
    rid_articulo = ROWID(Articulo).
    puso_ok = YES.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_todos Dialog-Frame
ON CHOOSE OF btn_todos IN FRAME Dialog-Frame /* Ver Todos los Artículos */
DO:
  buscar_por = "".
  RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre Dialog-Frame
ON RETURN OF que_nombre IN FRAME Dialog-Frame /* Descripción */
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_numero Dialog-Frame
ON RETURN OF que_numero IN FRAME Dialog-Frame /* Código */
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


&Scoped-define SELF-NAME tcompras_sino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tcompras_sino Dialog-Frame
ON VALUE-CHANGED OF tcompras_sino IN FRAME Dialog-Frame /* Compras */
DO:
    ASSIGN FRAME {&FRAME-NAME} tcompras_sino.
    RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tinventario_sino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tinventario_sino Dialog-Frame
ON VALUE-CHANGED OF tinventario_sino IN FRAME Dialog-Frame /* Inventario */
DO:
       ASSIGN FRAME {&FRAME-NAME} tinventario_sino.
    RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tproduccion_sino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tproduccion_sino Dialog-Frame
ON VALUE-CHANGED OF tproduccion_sino IN FRAME Dialog-Frame /* Producción */
DO:
       ASSIGN FRAME {&FRAME-NAME} tproduccion_sino.
    RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tventas_sino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tventas_sino Dialog-Frame
ON VALUE-CHANGED OF tventas_sino IN FRAME Dialog-Frame /* Ventas */
DO:
   ASSIGN FRAME {&FRAME-NAME} tventas_sino.
  RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-estado Dialog-Frame
ON VALUE-CHANGED OF v-estado IN FRAME Dialog-Frame
DO:
  ASSIGN v-estado.
  RUN abrir_query.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

{findsector.i}
que_area = Area.cdg_area.

{findempresa.i}
que_empresa = Empresa.cdg_empresa.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
  tcompras_sino = INDEX(uso,"C") > 0.
  tinventario_sino = INDEX(uso,"I") > 0.
  tventas_sino = INDEX(uso,"V") > 0.
  tproduccion_sino = INDEX(uso,"P") > 0.
  DISPLAY tcompras_sino  tinventario_sino  tventas_sino tproduccion_sino WITH FRAME {&FRAME-NAME}.
  
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
RUN abrir_query.
    RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir_query Dialog-Frame 
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
                                               AND Articulo.lista_empresas CONTAINS que_empresa and
                                               ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or
                                                 (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or
                                                 (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or
                                                 (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )
                                               by cdg_articulo.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR CODIGO=" + clave_buscar.
              que_numero = "".
    
         END.
    
         WHEN "NOMBRE"
         THEN DO:
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.descripcion CONTAINS clave_buscar
                                               AND Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa and
                                               ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or
                                                 (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or
                                                 (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or
                                                 (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )
                  BY Articulo.descripcion.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: POR NOMBRE=" + clave_buscar.
              que_nombre = "".
    
    
         END.
    
         OTHERWISE
         DO:
    
              OPEN QUERY {&BROWSE-NAME}
                   FOR EACH Articulo NO-LOCK WHERE Articulo.cdg_estado = v-estado
                                               AND Articulo.lista_sectores CONTAINS que_area
                                               AND Articulo.lista_empresas CONTAINS que_empresa and
                                               ( (articulo.compras_sino = TRUE AND tcompras_sino = TRUE) or
                                                 (articulo.inventario_sino = TRUE AND tinventario_sino = TRUE ) or
                                                 (articulo.ventas_sino = TRUE AND tventas_sino = TRUE ) or
                                                 (articulo.produccion_sino = TRUE AND tproduccion_sino = TRUE ) )
                                                BY cdg_articulo.
              BROWSE {&BROWSE-NAME}:TITLE = "Artículos que satisfacen la condición de búsqueda: TODOS".
         END.
    
    END CASE.

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
  DISPLAY tventas_sino que_nombre tcompras_sino v-estado que_numero 
          tinventario_sino tproduccion_sino 
      WITH FRAME Dialog-Frame.
  ENABLE tventas_sino Btn_OK que_nombre tcompras_sino v-estado Btn_Cancel 
         que_numero tinventario_sino btn_todos tproduccion_sino br_articulos 
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

