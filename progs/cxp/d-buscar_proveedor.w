&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM SmartDialog Template

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
DEFINE VARIABLE rid_proveedor  AS ROWID.
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE INPUT  PARAMETER buscar_por   AS CHARACTER.   
DEFINE INPUT  PARAMETER clave_buscar AS CHARACTER.   
DEFINE INPUT-OUTPUT PARAMETER rid_proveedor  AS ROWID.
DEFINE OUTPUT PARAMETER puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog
&Scoped-define BROWSE-NAME br_grupos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Proveedor

/* Definitions for BROWSE br_grupos                                     */
&Scoped-define FIELDS-IN-QUERY-br_grupos Proveedor.cdg_proveedor Proveedor.nombre Proveedor.cdg_condiva Proveedor.credito_maximo Proveedor.cuit /* Proveedor.a_granel Proveedor.unidades_sino Proveedor.cdg_ucompra Proveedor.compras_sino Proveedor.inventario_sino Proveedor.produccion_sino Proveedor.stock_sino Proveedor.ventas_sino Proveedor.detallada Proveedor.detallada Proveedor.cdg_motbaja Proveedor.importe_cuota Proveedor.cant_capitas Proveedor.fecha_alta Proveedor.tipo_compbte */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_grupos   
&Scoped-define SELF-NAME br_grupos
&Scoped-define OPEN-QUERY-br_grupos  br_grupos:TITLE = "Proveedores que satisfacen la condición de búsqueda: por " + buscar_por + ":" + clave_buscar.  CASE buscar_por:      WHEN "NUMERO"      THEN DO:          IF LENGTH(clave_buscar) > 0 THEN           IF SUBSTRING(clave_buscar, ~
      LENGTH(clave_buscar), ~
      1) <> "*"              THEN clave_buscar = clave_buscar + "*".           ELSE clave_buscar = "*".           OPEN QUERY br_grupos                FOR EACH Proveedor  NO-LOCK WHERE Proveedor.cdg_proveedor BEGINS clave_buscar BY Proveedor.cdg_proveedor INDEXED-REPOSITION.      END.      WHEN "NOMBRE"      THEN DO:          IF LENGTH(clave_buscar) <> 0 THEN              OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK WHERE Proveedor.nombre CONTAINS clave_buscar BY Proveedor.nombre INDEXED-REPOSITION.          ELSE              OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK BY Proveedor.nombre INDEXED-REPOSITION.      END.      WHEN "CUIT"      THEN DO:          IF LENGTH(clave_buscar) <> 0 THEN           OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK WHERE Proveedor.cuit CONTAINS clave_buscar BY Proveedor.cuit INDEXED-REPOSITION.          ELSE           OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK BY Proveedor.cuit INDEXED-REPOSITION.      END.      OTHERWISE      DO:           OPEN QUERY {&SELF-NAME}                FOR EACH Proveedor NO-LOCK BY Proveedor.nombre  INDEXED-REPOSITION.      END. END CASE. clave_buscar = "".
&Scoped-define TABLES-IN-QUERY-br_grupos Proveedor
&Scoped-define FIRST-TABLE-IN-QUERY-br_grupos Proveedor


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-br_grupos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_nombre Btn_OK que_numero que_cuit Balta ~
br_grupos 
&Scoped-Define DISPLAYED-OBJECTS que_nombre que_numero que_cuit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Balta AUTO-GO 
     LABEL "Alta" 
     SIZE 19 BY .95.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir" 
     SIZE 19 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE que_cuit AS CHARACTER FORMAT "X(256)":U 
     LABEL "C.U.I.T." 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Código" 
     VIEW-AS FILL-IN 
     SIZE 34 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_grupos FOR 
      Proveedor SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_grupos D-Dialog _FREEFORM
  QUERY br_grupos NO-LOCK DISPLAY
      Proveedor.cdg_proveedor      COLUMN-LABEL "Número!Proveedor"
      Proveedor.nombre      COLUMN-LABEL "Razón!Social"
      Proveedor.cdg_condiva      COLUMN-LABEL "Condicion!Impositiva"
      Proveedor.credito_maximo   COLUMN-LABEL "Crédito!Máximo"
      Proveedor.cuit             COLUMN-LABEL "C.U.I.T.!Proveedor"
      /*
      Proveedor.a_granel         COLUMN-LABEL "Stock!A Granel"
      Proveedor.unidades_sino    COLUMN-LABEL "Stock!En Unidades"
      Proveedor.cdg_ucompra      COLUMN-LABEL "Unidad!De Compra"
      Proveedor.compras_sino     COLUMN-LABEL "Habilitado!Compras"
      Proveedor.inventario_sino  COLUMN-LABEL "Habilitado!Inventario"
      Proveedor.produccion_sino  COLUMN-LABEL "Habilitado!Producción"
      Proveedor.stock_sino       COLUMN-LABEL "Habilitado!Stock"
      Proveedor.ventas_sino      COLUMN-LABEL "Habilitado!Ventas"
      
      Proveedor.detallada        COLUMN-LABEL "Descripcion Detallada!u Observaciones"

      
      Proveedor.detallada    COLUMN-LABEL "Fecha!Baja"
      Proveedor.cdg_motbaja   COLUMN-LABEL "Mot!Baja"
      Proveedor.importe_cuota COLUMN-LABEL "Importe!Cuota"
      Proveedor.cant_capitas  COLUMN-LABEL "Cant.!Cápitas" FORMAT ">>>>9"
      Proveedor.fecha_alta    COLUMN-LABEL "Fecha!Alta"
      Proveedor.tipo_compbte  COLUMN-LABEL "Tip!Com" FORMAT "X(1)"
      */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 95 BY 18.43
         FONT 4
         TITLE "Proveedores que satisfacen la condición de búsqueda" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     que_nombre AT ROW 1.24 COL 9 COLON-ALIGNED
     Btn_OK AT ROW 1.24 COL 76
     que_numero AT ROW 2.43 COL 9 COLON-ALIGNED
     que_cuit AT ROW 2.43 COL 55 COLON-ALIGNED
     Balta AT ROW 2.43 COL 76 WIDGET-ID 2
     br_grupos AT ROW 3.86 COL 2
     SPACE(2.39) SKIP(0.22)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de Proveedor"
         DEFAULT-BUTTON Balta.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   FRAME-NAME                                                           */
/* BROWSE-TAB br_grupos Balta D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_grupos
/* Query rebuild information for BROWSE br_grupos
     _START_FREEFORM

br_grupos:TITLE = "Proveedores que satisfacen la condición de búsqueda: por " + buscar_por + ":" + clave_buscar.

CASE buscar_por:
     WHEN "NUMERO"
     THEN DO:
         IF LENGTH(clave_buscar) > 0 THEN
          IF SUBSTRING(clave_buscar,LENGTH(clave_buscar),1) <> "*"
             THEN clave_buscar = clave_buscar + "*".
          ELSE clave_buscar = "*".
          OPEN QUERY br_grupos
               FOR EACH Proveedor  NO-LOCK WHERE Proveedor.cdg_proveedor BEGINS clave_buscar BY Proveedor.cdg_proveedor INDEXED-REPOSITION.
     END.
     WHEN "NOMBRE"
     THEN DO:
         IF LENGTH(clave_buscar) <> 0 THEN
             OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK WHERE Proveedor.nombre CONTAINS clave_buscar BY Proveedor.nombre INDEXED-REPOSITION.
         ELSE
             OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK BY Proveedor.nombre INDEXED-REPOSITION.
     END.
     WHEN "CUIT"
     THEN DO:
         IF LENGTH(clave_buscar) <> 0 THEN
          OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK WHERE Proveedor.cuit CONTAINS clave_buscar BY Proveedor.cuit INDEXED-REPOSITION.
         ELSE
          OPEN QUERY br_grupos FOR EACH Proveedor NO-LOCK BY Proveedor.cuit INDEXED-REPOSITION.
     END.
     OTHERWISE
     DO:
          OPEN QUERY {&SELF-NAME}
               FOR EACH Proveedor NO-LOCK BY Proveedor.nombre  INDEXED-REPOSITION.
     END.
END CASE.
clave_buscar = "".
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_grupos */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Selección de Proveedor */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Balta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Balta D-Dialog
ON CHOOSE OF Balta IN FRAME D-Dialog /* Alta */
DO:
  DEFINE VAR cc LIKE proveedor.cdg_proveedor NO-UNDO.
  RUN w-altaproveedor.w(OUTPUT cc).
  IF cc <> ? THEN DO:
      FIND proveedor WHERE empresa.cdg_empresa = proveedor.cdg_empresa AND
          proveedor.cdg_proveedor = cc NO-LOCK.
      rid_proveedor = ROWID(Proveedor).
      puso_ok = YES.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_grupos
&Scoped-define SELF-NAME br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos D-Dialog
ON MOUSE-SELECT-DBLCLICK OF br_grupos IN FRAME D-Dialog /* Proveedores que satisfacen la condición de búsqueda */
DO:
  APPLY "CHOOSE" TO Btn_OK IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos D-Dialog
ON RETURN OF br_grupos IN FRAME D-Dialog /* Proveedores que satisfacen la condición de búsqueda */
DO:
    APPLY "CHOOSE" TO Btn_OK IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos D-Dialog
ON ROW-DISPLAY OF br_grupos IN FRAME D-Dialog /* Proveedores que satisfacen la condición de búsqueda */
DO:
/*
   IF Proveedor.cdg_estado = ""  
      THEN RUN poner_color ( INPUT 9, INPUT 15 ).
      ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
*/  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* Elegir */
DO:
  
  rid_proveedor = ROWID(Proveedor).
  puso_ok = YES.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_cuit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_cuit D-Dialog
ON ENTRY OF que_cuit IN FRAME D-Dialog /* C.U.I.T. */
DO:
  buscar_por = "CUIT".
  {&OPEN-BROWSERS-IN-QUERY-{&FRAME-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_cuit D-Dialog
ON RETURN OF que_cuit IN FRAME D-Dialog /* C.U.I.T. */
DO:

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_cuit
     buscar_por = "CUIT".
     clave_buscar = que_cuit.
     {&OPEN-QUERY-{&BROWSE-NAME}}

  END.


  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre D-Dialog
ON ENTRY OF que_nombre IN FRAME D-Dialog /* Nombre */
DO:
  buscar_por = "NOMBRE".
  {&OPEN-BROWSERS-IN-QUERY-{&FRAME-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre D-Dialog
ON RETURN OF que_nombre IN FRAME D-Dialog /* Nombre */
DO:
  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_nombre
     buscar_por = "NOMBRE".
     clave_buscar = que_nombre.
     {&OPEN-QUERY-{&BROWSE-NAME}}

  END.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_numero D-Dialog
ON ENTRY OF que_numero IN FRAME D-Dialog /* Código */
DO:
  buscar_por = "NUMERO".
  {&OPEN-BROWSERS-IN-QUERY-{&FRAME-NAME}}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_numero D-Dialog
ON RETURN OF que_numero IN FRAME D-Dialog /* Código */
DO:

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_numero
     buscar_por = "NUMERO".
     clave_buscar = que_numero.
     {&OPEN-QUERY-{&BROWSE-NAME}}

  END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
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
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
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
      WITH FRAME D-Dialog.
  ENABLE que_nombre Btn_OK que_numero que_cuit Balta br_grupos 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color D-Dialog 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      DEFINE INPUT PARAMETER p-fgcolor AS INTEGER.
      DEFINE INPUT PARAMETER p-bgcolor AS INTEGER.
      
      ASSIGN
            Proveedor.cdg_proveedor:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Proveedor.nombre:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Proveedor.cdg_condiva:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Proveedor.credito_maximo:FGCOLOR IN BROWSE {&BROWSE-NAME} = p-fgcolor
            Proveedor.cuit:FGCOLOR IN BROWSE {&BROWSE-NAME}           = p-fgcolor

            /*
            Proveedor.detallada:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fgcolor
            Proveedor.cdg_motbaja:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Proveedor.cant_capitas:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor 
            Proveedor.importe_cuota:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor 
            Proveedor.fecha_alta:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor 
            Proveedor.tipo_compbte:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            */.

      ASSIGN
            Proveedor.cdg_proveedor:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Proveedor.nombre:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Proveedor.cdg_condiva:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Proveedor.credito_maximo:BGCOLOR IN BROWSE {&BROWSE-NAME} = p-bgcolor
            Proveedor.cuit:BGCOLOR IN BROWSE {&BROWSE-NAME}           = p-bgcolor
            /*
            Proveedor.detallada:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bgcolor
            Proveedor.cdg_motbaja:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Proveedor.cant_capitas:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor 
            Proveedor.importe_cuota:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor 
            Proveedor.fecha_alta:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor 
            Proveedor.tipo_compbte:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            */.
            
/*
      IF Proveedor.observacion = ""
         THEN hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor.
         ELSE hay_observaciones:BGCOLOR IN BROWSE {&BROWSE-NAME}     = 14.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Proveedor"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
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

