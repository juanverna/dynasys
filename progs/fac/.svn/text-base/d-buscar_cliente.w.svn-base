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
DEFINE VARIABLE rid_cliente  AS ROWID.
DEFINE VARIABLE puso_ok      AS LOGICAL.   
&ELSE
DEFINE INPUT  PARAMETER buscar_por   AS CHARACTER.   
DEFINE INPUT  PARAMETER clave_buscar AS CHARACTER.   
DEFINE INPUT-OUTPUT PARAMETER rid_cliente  AS ROWID.
DEFINE OUTPUT PARAMETER puso_ok      AS LOGICAL.   
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.

DEFINE VARIABLE que_sector LIKE Area.cdg_area.

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
&Scoped-define INTERNAL-TABLES Cliente

/* Definitions for BROWSE br_grupos                                     */
&Scoped-define FIELDS-IN-QUERY-br_grupos Cliente.cdg_cliente Cliente.nom_cliente Cliente.cdg_condiva Cliente.credito_maximo Cliente.cuit /* Cliente.a_granel Cliente.unidades_sino Cliente.cdg_ucompra Cliente.compras_sino Cliente.inventario_sino Cliente.produccion_sino Cliente.stock_sino Cliente.ventas_sino Cliente.detallada Cliente.detallada Cliente.cdg_motbaja Cliente.importe_cuota Cliente.cant_capitas Cliente.fecha_alta Cliente.tipo_compbte */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_grupos   
&Scoped-define SELF-NAME br_grupos
&Scoped-define OPEN-QUERY-br_grupos  CASE buscar_por:      WHEN "NUMERO"      THEN DO:            que_numero = clave_buscar.           OPEN QUERY br_grupos                FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_numero                                   AND CAN-DO(Cliente.lista_empresas, ~
      que_empresa)                                   AND Cliente.lista_sectores CONTAINS que_sector                                        NO-LOCK.           br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.           que_numero = "".       END.        WHEN "NOMBRE"      THEN DO:            que_nombre = clave_buscar.           OPEN QUERY br_grupos                FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre                                   AND CAN-DO(Cliente.lista_empresas, ~
      que_empresa)                                   AND Cliente.lista_sectores CONTAINS que_sector                                   NO-LOCK.           br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.           que_nombre = "".        END.       OTHERWISE      DO:            OPEN QUERY {&SELF-NAME}                FOR EACH Cliente WHERE                                 CAN-DO(Cliente.lista_empresas, ~
      que_empresa)                                 AND Cliente.lista_sectores CONTAINS que_sector                                 NO-LOCK INDEXED-REPOSITION.       END.   END CASE.
&Scoped-define TABLES-IN-QUERY-br_grupos Cliente
&Scoped-define FIRST-TABLE-IN-QUERY-br_grupos Cliente


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-br_grupos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-fantasia que_nombre Btn_OK Btn_Cancel ~
que_numero que_cuit br_grupos 
&Scoped-Define DISPLAYED-OBJECTS v-fantasia que_nombre que_numero que_cuit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir" 
     SIZE 22 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE que_cuit AS CHARACTER FORMAT "X(256)":U 
     LABEL "C.U.I.T." 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS CHARACTER FORMAT "X(256)":U 
     LABEL "Código" 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-fantasia AS LOGICAL INITIAL no 
     LABEL "Fantasía" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY 1.05 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_grupos FOR 
      Cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_grupos D-Dialog _FREEFORM
  QUERY br_grupos NO-LOCK DISPLAY
      Cliente.cdg_cliente      COLUMN-LABEL "Número!Cliente" FORMAT "X(15)"
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
    WITH NO-ROW-MARKERS SIZE 101 BY 18.33
         FONT 4
         TITLE "Clientes que satisfacen la condición de búsqueda" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     v-fantasia AT ROW 1.24 COL 65
     que_nombre AT ROW 1.29 COL 9 COLON-ALIGNED
     Btn_OK AT ROW 1.24 COL 81
     Btn_Cancel AT ROW 2.48 COL 81
     que_numero AT ROW 2.62 COL 9 COLON-ALIGNED
     que_cuit AT ROW 2.67 COL 60 COLON-ALIGNED
     br_grupos AT ROW 3.95 COL 2
     SPACE(1.19) SKIP(0.85)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de Clientes"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


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
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_grupos que_cuit D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

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
                                  AND Cliente.lista_sectores CONTAINS que_sector
                                       NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.
          que_numero = "".

     END.


     WHEN "NOMBRE"
     THEN DO:

          que_nombre = clave_buscar.
          OPEN QUERY br_grupos
               FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                  AND Cliente.lista_sectores CONTAINS que_sector
                                  NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
          que_nombre = "".


     END.

     OTHERWISE
     DO:

          OPEN QUERY {&SELF-NAME}
               FOR EACH Cliente WHERE
                                CAN-DO(Cliente.lista_empresas,que_empresa)
                                AND Cliente.lista_sectores CONTAINS que_sector
                                NO-LOCK INDEXED-REPOSITION.

     END.


END CASE.
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
ON WINDOW-CLOSE OF FRAME D-Dialog /* Selección de Clientes */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_grupos
&Scoped-define SELF-NAME br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos D-Dialog
ON MOUSE-SELECT-DBLCLICK OF br_grupos IN FRAME D-Dialog /* Clientes que satisfacen la condición de búsqueda */
DO:
  APPLY "CHOOSE" TO Btn_OK IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos D-Dialog
ON RETURN OF br_grupos IN FRAME D-Dialog /* Clientes que satisfacen la condición de búsqueda */
DO:
    APPLY "CHOOSE" TO Btn_OK IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_grupos D-Dialog
ON ROW-DISPLAY OF br_grupos IN FRAME D-Dialog /* Clientes que satisfacen la condición de búsqueda */
DO:

   IF Cliente.cdg_estado = ""  
      THEN RUN poner_color ( INPUT 9, INPUT 15 ).
      ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* Elegir */
DO:
  
  rid_cliente = ROWID(Cliente).
  puso_ok = YES.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_cuit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_cuit D-Dialog
ON RETURN OF que_cuit IN FRAME D-Dialog /* C.U.I.T. */
DO:

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_cuit.
          OPEN QUERY br_grupos 
               FOR EACH Cliente WHERE Cliente.cuit CONTAINS que_cuit 
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                  AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                      NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR C.U.I.T. =" + que_cuit.
          que_cuit = "".

  END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre D-Dialog
ON RETURN OF que_nombre IN FRAME D-Dialog /* Nombre */
DO:
  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_nombre v-fantasia.
     IF NOT v-fantasia
     THEN DO:
         OPEN QUERY br_grupos 
              FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre 
                                 AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                 AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                     NO-LOCK.

         br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
     END.
     ELSE DO:
         OPEN QUERY br_grupos 
              FOR EACH Cliente WHERE Cliente.nom_fantasia CONTAINS que_nombre 
                                 AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                 AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                     NO-LOCK.

         br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOM FANTASIA=" + que_nombre.
     END.
     que_nombre = "".
     DISPLAY que_nombre.

  END.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_numero
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_numero D-Dialog
ON RETURN OF que_numero IN FRAME D-Dialog /* Código */
DO:

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_numero.
          OPEN QUERY br_grupos 
               FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_numero 
                                  AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                  AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                       NO-LOCK.
          br_grupos:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_numero.
          que_numero = "".

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
  DISPLAY v-fantasia que_nombre que_numero que_cuit 
      WITH FRAME D-Dialog.
  ENABLE v-fantasia que_nombre Btn_OK Btn_Cancel que_numero que_cuit br_grupos 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.
   {findsector.i}
   que_sector = Area.cdg_area.


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Cliente"}

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

