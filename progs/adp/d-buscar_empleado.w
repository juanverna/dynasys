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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME D-Dialog
&Scoped-define BROWSE-NAME br_grupos

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Empleado

/* Definitions for BROWSE br_grupos                                     */
&Scoped-define FIELDS-IN-QUERY-br_grupos Empleado.nro_legajo Empleado.nombre Empleado.nro_cuil Empleado.fecha_ingreso Empleado.fecha_baja /* Empleado.a_granel Empleado.unidades_sino Empleado.cdg_ucompra Empleado.compras_sino Empleado.inventario_sino Empleado.produccion_sino Empleado.stock_sino Empleado.ventas_sino Empleado.detallada Empleado.detallada Empleado.cdg_motbaja Empleado.importe_cuota Empleado.cant_capitas Empleado.fecha_alta Empleado.tipo_compbte */   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_grupos   
&Scoped-define SELF-NAME br_grupos
&Scoped-define OPEN-QUERY-br_grupos  CASE buscar_por:      WHEN "NUMERO"      THEN DO:            que_numero = INTEGER(clave_buscar).           OPEN QUERY br_grupos                FOR EACH Empleado WHERE Empleado.nro_legajo  = que_numero                                    AND Empleado.cdg_empresa = que_empresa                                        NO-LOCK.           br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR CODIGO=" + STRING(que_numero).           que_numero = 0.       END.        WHEN "NOMBRE"      THEN DO:            que_nombre = clave_buscar.           IF SUBSTRING(que_nombre, ~
      LENGTH(que_nombre), ~
      1) <> "*"              THEN que_nombre = que_nombre + "*".           OPEN QUERY br_grupos                FOR EACH Empleado WHERE Empleado.nombre CONTAINS que_nombre                                    AND Empleado.cdg_empresa = que_empresa                                        NO-LOCK.           br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.           que_nombre = "".        END.       OTHERWISE      DO:            OPEN QUERY {&SELF-NAME}                FOR EACH Empleado WHERE Empleado.cdg_empresa = que_empresa                                NO-LOCK INDEXED-REPOSITION.       END.   END CASE.
&Scoped-define TABLES-IN-QUERY-br_grupos Empleado
&Scoped-define FIRST-TABLE-IN-QUERY-br_grupos Empleado


/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-D-Dialog ~
    ~{&OPEN-QUERY-br_grupos}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS que_nombre Btn_OK que_numero que_nro_cuil ~
Btn_Todos Btn_Cancel br_grupos 
&Scoped-Define DISPLAYED-OBJECTS que_nombre que_numero que_nro_cuil 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "&Salir" 
     SIZE 20 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "&Elegir" 
     SIZE 20 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_Todos 
     LABEL "&Todos" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 59 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_nro_cuil AS CHARACTER FORMAT "X(256)":U 
     LABEL "C.U.I.L." 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE que_numero AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Código" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_grupos FOR 
      Empleado SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_grupos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_grupos D-Dialog _FREEFORM
  QUERY br_grupos NO-LOCK DISPLAY
      Empleado.nro_legajo       COLUMN-LABEL "Número!Empleado"
      Empleado.nombre           COLUMN-LABEL "Razón!Social"
      Empleado.nro_cuil         COLUMN-LABEL "C.U.I.T.!Empleado"  
      Empleado.fecha_ingreso    COLUMN-LABEL "Fecha!Alta"  
      Empleado.fecha_baja       COLUMN-LABEL "Fecha!Baja"  
      /*
      Empleado.a_granel         COLUMN-LABEL "Stock!A Granel"
      Empleado.unidades_sino    COLUMN-LABEL "Stock!En Unidades"
      Empleado.cdg_ucompra      COLUMN-LABEL "Unidad!De Compra"
      Empleado.compras_sino     COLUMN-LABEL "Habilitado!Compras"
      Empleado.inventario_sino  COLUMN-LABEL "Habilitado!Inventario"
      Empleado.produccion_sino  COLUMN-LABEL "Habilitado!Producción"
      Empleado.stock_sino       COLUMN-LABEL "Habilitado!Stock"
      Empleado.ventas_sino      COLUMN-LABEL "Habilitado!Ventas"
      
      Empleado.detallada        COLUMN-LABEL "Descripcion Detallada!u Observaciones"

      
      Empleado.detallada    COLUMN-LABEL "Fecha!Baja"
      Empleado.cdg_motbaja   COLUMN-LABEL "Mot!Baja"
      Empleado.importe_cuota COLUMN-LABEL "Importe!Cuota"
      Empleado.cant_capitas  COLUMN-LABEL "Cant.!Cápitas" FORMAT ">>>>9"
      Empleado.fecha_alta    COLUMN-LABEL "Fecha!Alta"
      Empleado.tipo_compbte  COLUMN-LABEL "Tip!Com" FORMAT "X(1)"
      */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 89 BY 18.33
         FONT 4
         TITLE "Clientes que satisfacen la condición de búsqueda".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     que_nombre AT ROW 1.29 COL 9 COLON-ALIGNED
     Btn_OK AT ROW 1.29 COL 71
     que_numero AT ROW 2.62 COL 9 COLON-ALIGNED
     que_nro_cuil AT ROW 2.67 COL 34 COLON-ALIGNED
     Btn_Todos AT ROW 2.67 COL 55
     Btn_Cancel AT ROW 2.67 COL 71
     br_grupos AT ROW 3.95 COL 2
     SPACE(1.39) SKIP(0.85)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Selección de Empleados"
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
                                                                        */
/* BROWSE-TAB br_grupos Btn_Cancel D-Dialog */
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

          que_numero = INTEGER(clave_buscar).
          OPEN QUERY br_grupos
               FOR EACH Empleado WHERE Empleado.nro_legajo  = que_numero
                                   AND Empleado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR CODIGO=" + STRING(que_numero).
          que_numero = 0.

     END.


     WHEN "NOMBRE"
     THEN DO:

          que_nombre = clave_buscar.
          IF SUBSTRING(que_nombre,LENGTH(que_nombre),1) <> "*"
             THEN que_nombre = que_nombre + "*".
          OPEN QUERY br_grupos
               FOR EACH Empleado WHERE Empleado.nombre CONTAINS que_nombre
                                   AND Empleado.cdg_empresa = que_empresa
                                       NO-LOCK.
          br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
          que_nombre = "".


     END.

     OTHERWISE
     DO:

          OPEN QUERY {&SELF-NAME}
               FOR EACH Empleado WHERE Empleado.cdg_empresa = que_empresa
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
ON WINDOW-CLOSE OF FRAME D-Dialog /* Selección de Empleados */
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

   IF Empleado.cdg_estado = "AA"  
      THEN RUN poner_color ( INPUT 9, INPUT 15 ).
      ELSE RUN poner_color ( INPUT 0, INPUT 8 ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK D-Dialog
ON CHOOSE OF Btn_OK IN FRAME D-Dialog /* Elegir */
DO:
  
  rid_cliente = ROWID(Empleado).
  puso_ok = YES.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Todos D-Dialog
ON CHOOSE OF Btn_Todos IN FRAME D-Dialog /* Todos */
DO:
     OPEN QUERY br_grupos
               FOR EACH Empleado WHERE Empleado.cdg_empresa = que_empresa NO-LOCK.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre D-Dialog
ON RETURN OF que_nombre IN FRAME D-Dialog /* Nombre */
DO:
  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_nombre.
     OPEN QUERY br_grupos 
          FOR EACH Empleado WHERE Empleado.nombre CONTAINS que_nombre 
                                  NO-LOCK.

     br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
     que_nombre = "".
     DISPLAY que_nombre.

  END.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nro_cuil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nro_cuil D-Dialog
ON RETURN OF que_nro_cuil IN FRAME D-Dialog /* C.U.I.L. */
DO:

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN que_nro_cuil.
          OPEN QUERY br_grupos 
               FOR EACH Empleado WHERE Empleado.nro_cuil = que_nro_cuil 
                                       NO-LOCK.
          br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR C.U.I.L. =" + que_nro_cuil.
          que_nro_cuil = "".

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
               FOR EACH Empleado WHERE Empleado.nro_legajo = que_numero 
                                       NO-LOCK.
          br_grupos:TITLE = "Empleados que satisfacen la condición de búsqueda: POR CODIGO=" + string(que_numero).
          que_numero = 0.

  END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */
{findempresa.i}
que_empresa = Empresa.cdg_empresa.
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
  DISPLAY que_nombre que_numero que_nro_cuil 
      WITH FRAME D-Dialog.
  ENABLE que_nombre Btn_OK que_numero que_nro_cuil Btn_Todos Btn_Cancel 
         br_grupos 
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
            Empleado.nro_legajo:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor
            Empleado.nombre:FGCOLOR IN BROWSE {&BROWSE-NAME}         = p-fgcolor
            Empleado.nro_cuil:FGCOLOR IN BROWSE {&BROWSE-NAME}       = p-fgcolor
            Empleado.fecha_ingreso:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor
            Empleado.fecha_baja:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor
            

            /*
            Empleado.detallada:FGCOLOR IN BROWSE {&BROWSE-NAME}      = p-fgcolor
            Empleado.cdg_motbaja:FGCOLOR IN BROWSE {&BROWSE-NAME}    = p-fgcolor
            Empleado.cant_capitas:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor 
            Empleado.importe_cuota:FGCOLOR IN BROWSE {&BROWSE-NAME}  = p-fgcolor 
            Empleado.fecha_alta:FGCOLOR IN BROWSE {&BROWSE-NAME}     = p-fgcolor 
            Empleado.tipo_compbte:FGCOLOR IN BROWSE {&BROWSE-NAME}   = p-fgcolor
            */.

      ASSIGN
            Empleado.nro_legajo:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor
            Empleado.nombre:BGCOLOR IN BROWSE {&BROWSE-NAME}         = p-bgcolor
            Empleado.nro_cuil:BGCOLOR IN BROWSE {&BROWSE-NAME}       = p-bgcolor
            Empleado.fecha_ingreso:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor
            Empleado.fecha_baja:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor
            
            /*
            Empleado.detallada:BGCOLOR IN BROWSE {&BROWSE-NAME}      = p-bgcolor
            Empleado.cdg_motbaja:BGCOLOR IN BROWSE {&BROWSE-NAME}    = p-bgcolor
            Empleado.cant_capitas:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor 
            Empleado.importe_cuota:BGCOLOR IN BROWSE {&BROWSE-NAME}  = p-bgcolor 
            Empleado.fecha_alta:BGCOLOR IN BROWSE {&BROWSE-NAME}     = p-bgcolor 
            Empleado.tipo_compbte:BGCOLOR IN BROWSE {&BROWSE-NAME}   = p-bgcolor
            */.
            
/*
      IF Empleado.observacion = ""
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
  {src/adm/template/snd-list.i "Empleado"}

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

