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
DEFINE VARIABLE rid_cliente  AS ROWID.
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE INPUT  PARAMETER buscar_por   AS CHARACTER.   
DEFINE INPUT  PARAMETER clave_buscar AS CHARACTER.   
DEFINE INPUT-OUTPUT PARAMETER rid_cliente  AS ROWID.
DEFINE OUTPUT PARAMETER puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE hay_observaciones AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_grupos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cliente

/* Definitions for BROWSE br_grupos                                     */
&Scoped-define FIELDS-IN-QUERY-br_grupos Cliente.cdg_cliente Cliente.nom_cliente Cliente.cdg_condiva Cliente.credito_maximo Cliente.cuit /* Cliente.a_granel Cliente.unidades_sino Cliente.cdg_ucompra Cliente.compras_sino Cliente.inventario_sino Cliente.produccion_sino Cliente.stock_sino Cliente.ventas_sino Cliente.detallada Cliente.detallada Cliente.cdg_motbaja Cliente.importe_cuota Cliente.cant_capitas Cliente.fecha_alta Cliente.tipo_compbte */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_grupos   
&Scoped-define SELF-NAME br_grupos
&Scoped-define OPEN-QUERY-br_grupos  CASE buscar_por:      WHEN "NUMERO"      THEN DO:            que_numero = clave_buscar.           OPEN QUERY br_grupos                FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_numero                                   AND CAN-DO(Cliente.lista_empresas, ~
      que_empresa)                                        NO-LOCK.           br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.           que_numero = "".       END.        WHEN "NOMBRE"      THEN DO:           OPEN QUERY br_grupos                FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre                                   AND CAN-DO(Cliente.lista_empresas, ~
      que_empresa)                                        NO-LOCK.           br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.           que_nombre = "".        END.       OTHERWISE      DO:            OPEN QUERY {&SELF-NAME}                FOR EACH Cliente WHERE CAN-DO(Cliente.lista_empresas, ~
      que_empresa) NO-LOCK INDEXED-REPOSITION.       END.   END CASE.
&Scoped-define TABLES-IN-QUERY-br_grupos Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_grupos Cliente


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_grupos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_nombre Btn_Done que_numero que_cuit ~
Btn_Salir br_grupos 
&Scoped-Define DISPLAYED-OBJECTS que_nombre que_numero que_cuit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-br_afiliados 
       MENU-ITEM m_Con_Domicilio LABEL "&Con Domicilio"
       MENU-ITEM m_Sin_Domicilio LABEL "&Sin Domicilio".


/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Elegir" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Salir DEFAULT 
     LABEL "&Salir" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE que_cuit AS CHARACTER FORMAT "X(256)":U 
     LABEL "C.U.I.T." 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 14 FGCOLOR 12 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Código" 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_grupos FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_grupos C-Win _FREEFORM
  QUERY br_grupos NO-LOCK DISPLAY
      Cliente.cdg_cliente      COLUMN-LABEL "Número!Cliente"
      Cliente.nom_cliente      COLUMN-LABEL "Razón!Social"
      Cliente.cdg_condiva      COLUMN-LABEL "Condicion!Impositiva"
      Cliente.credito_maximo   COLUMN-LABEL "Crédito!Máximo"
      Cliente.cuit             COLUMN-LABEL "C.U.I.T.!Cliente"
      /*
      Cliente.a_granel         COLUMN-LABEL "Stock!A Granel"
      Cliente.unidades_sino    COLUMN-LABEL "Stock!En Unidades"
      Cliente.cdg_ucompra      COLUMN-LABEL "Unidad!De Compra"
      Cliente.compras_sino     COLUMN-LABEL "Habilitado!Compras"
      Cliente.inventario_sino  COLUMN-LABEL "Habilitado!Inventario"
      Cliente.produccion_sino  COLUMN-LABEL "Habilitado!Producción"
      Cliente.stock_sino       COLUMN-LABEL "Habilitado!Stock"
      Cliente.ventas_sino      COLUMN-LABEL "Habilitado!Ventas"
      
      Cliente.detallada        COLUMN-LABEL "Descripcion Detallada!u Observaciones"

      
      Cliente.detallada    COLUMN-LABEL "Fecha!Baja"
      Cliente.cdg_motbaja   COLUMN-LABEL "Mot!Baja"
      Cliente.importe_cuota COLUMN-LABEL "Importe!Cuota"
      Cliente.cant_capitas  COLUMN-LABEL "Cant.!Cápitas" FORMAT ">>>>9"
      Cliente.fecha_alta    COLUMN-LABEL "Fecha!Alta"
      Cliente.tipo_compbte  COLUMN-LABEL "Tip!Com" FORMAT "X(1)"
      */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 96 BY 18.33
         FONT 4
         TITLE "Clientes que satisfacen la condición de búsqueda" EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     que_nombre AT ROW 1.24 COL 12 COLON-ALIGNED
     Btn_Done AT ROW 1.48 COL 76
     que_numero AT ROW 2.62 COL 12 COLON-ALIGNED
     que_cuit AT ROW 2.62 COL 54 COLON-ALIGNED
     Btn_Salir AT ROW 2.67 COL 76
     br_grupos AT ROW 3.95 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.2 BY 25.86
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
         TITLE              = "Búsqueda de Clientes"
         HEIGHT             = 21.71
         WIDTH              = 99.2
         MAX-HEIGHT         = 25.86
         MAX-WIDTH          = 114.2
         VIRTUAL-HEIGHT     = 25.86
         VIRTUAL-WIDTH      = 114.2
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
   Custom                                                               */
/* BROWSE-TAB br_grupos Btn_Salir DEFAULT-FRAME */
ASSIGN 
       br_grupos:POPUP-MENU IN FRAME DEFAULT-FRAME             = MENU POPUP-MENU-br_afiliados:HANDLE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_grupos
/* Query rebuild information for BROWSE br_grupos
     _START_FREEFORM

CASE buscar_por:
     WHEN "NUMERO"
     THEN DO:

          que_numero = clave_buscar.
          OPEN QUERY br_grupos
               FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_numero
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                       NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.
          que_numero = "".

     END.


     WHEN "NOMBRE"
     THEN DO:
          OPEN QUERY br_grupos
               FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                       NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
          que_nombre = "".


     END.

     OTHERWISE
     DO:

          OPEN QUERY {&SELF-NAME}
               FOR EACH Cliente WHERE CAN-DO(Cliente.lista_empresas,que_empresa) NO-LOCK INDEXED-REPOSITION.

     END.


END CASE.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_grupos */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Búsqueda de Clientes */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Búsqueda de Clientes */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_grupos
&Scoped-define SELF-NAME br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos C-Win
ON MOUSE-SELECT-DBLCLICK OF br_grupos IN FRAME DEFAULT-FRAME /* Clientes que satisfacen la condición de búsqueda */
DO:
  APPLY "CHOOSE" TO Btn_Done IN FRAME {&FRAME-NAME}  .
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos C-Win
ON RETURN OF br_grupos IN FRAME DEFAULT-FRAME /* Clientes que satisfacen la condición de búsqueda */
DO:
  APPLY "CHOOSE" TO Btn_Done IN FRAME {&FRAME-NAME}  .  
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos C-Win
ON ROW-DISPLAY OF br_grupos IN FRAME DEFAULT-FRAME /* Clientes que satisfacen la condición de búsqueda */
DO:

   IF Cliente.cdg_estado = ""  
      THEN RUN poner_color ( INPUT 9, INPUT 15 ).
      ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done C-Win
ON CHOOSE OF Btn_Done IN FRAME DEFAULT-FRAME /* Elegir */
DO:
  
  rid_cliente = ROWID(Cliente).
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


&Scoped-define SELF-NAME m_Con_Domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Con_Domicilio C-Win
ON CHOOSE OF MENU-ITEM m_Con_Domicilio /* Con Domicilio */
DO:
  APPLY "CHOOSE" TO btn_salir IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Sin_Domicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Sin_Domicilio C-Win
ON CHOOSE OF MENU-ITEM m_Sin_Domicilio /* Sin Domicilio */
DO:
    APPLY "CHOOSE" TO btn_done IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_cuit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_cuit C-Win
ON RETURN OF que_cuit IN FRAME DEFAULT-FRAME /* C.U.I.T. */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_cuit.
          OPEN QUERY br_grupos 
               FOR EACH Cliente WHERE Cliente.cuit CONTAINS que_cuit 
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                       NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CUIT=" + que_cuit.
          que_numero = "".

  END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre C-Win
ON RETURN OF que_nombre IN FRAME DEFAULT-FRAME /* Nombre */
DO:
  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_nombre.
     OPEN QUERY br_grupos 
          FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre 
                             AND CAN-DO(Cliente.lista_empresas,que_empresa)   
                                  NO-LOCK.

     br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
     que_nombre = "".
     DISPLAY que_nombre.

  END.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_numero C-Win
ON RETURN OF que_numero IN FRAME DEFAULT-FRAME /* Código */
DO:

  DO WITH FRAME DEFAULT-FRAME:

     ASSIGN que_numero.
          OPEN QUERY br_grupos 
               FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_numero
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                       NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.
          que_numero = "".

  END.

  
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

{findempresa.i}
que_empresa = Empresa.cdg_empresa.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  APPLY "ENTRY" TO que_nombre IN FRAME {&FRAME-NAME}.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY que_nombre que_numero que_cuit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE que_nombre Btn_Done que_numero que_cuit Btn_Salir br_grupos 
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
            Cliente.cdg_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Cliente.nom_cliente:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Cliente.cdg_condiva:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Cliente.credito_maximo:FGCOLOR IN BROWSE {&BROWSE-NAME} = p-fgcolor
            Cliente.cuit:FGCOLOR IN BROWSE {&BROWSE-NAME}           = p-fgcolor

            /*
            Cliente.detallada:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fgcolor
            Cliente.cdg_motbaja:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Cliente.cant_capitas:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor 
            Cliente.importe_cuota:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor 
            Cliente.fecha_alta:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor 
            Cliente.tipo_compbte:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            */.

      ASSIGN
            Cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Cliente.nom_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Cliente.cdg_condiva:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Cliente.credito_maximo:BGCOLOR IN BROWSE {&BROWSE-NAME} = p-bgcolor
            Cliente.cuit:BGCOLOR IN BROWSE {&BROWSE-NAME}           = p-bgcolor
            /*
            Cliente.detallada:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bgcolor
            Cliente.cdg_motbaja:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Cliente.cant_capitas:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor 
            Cliente.importe_cuota:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor 
            Cliente.fecha_alta:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor 
            Cliente.tipo_compbte:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            */.
            
/*
      IF Cliente.observacion = ""
         THEN hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor.
         ELSE hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = 14.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

