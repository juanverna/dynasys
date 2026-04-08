&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS V-table-Win 
/*------------------------------------------------------------------------

  File:

  Description: from VIEWER.W - Template for SmartViewer Objects

  Input Parameters:
      <none>

  Output Parameters:
      <none>

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

DEFINE BUFFER B-Treemenu FOR Treemenu.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Treemenu
&Scoped-define FIRST-EXTERNAL-TABLE Treemenu


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Treemenu.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Treemenu.cdg_item Treemenu.titulo Treemenu.archivo_help 
&Scoped-define ENABLED-TABLES Treemenu
&Scoped-define FIRST-ENABLED-TABLE Treemenu
&Scoped-Define ENABLED-OBJECTS btn_ejecutar btn_copiar v-que_empresa ~
btn_heredar v-accion v-comprobante btn_archivos-2 RECT-2 
&Scoped-Define DISPLAYED-FIELDS Treemenu.cdg_item Treemenu.cdg_padre Treemenu.titulo ~
Treemenu.archivo_help Treemenu.permitidos Treemenu.descripcion 
&Scoped-define DISPLAYED-TABLES Treemenu
&Scoped-define FIRST-DISPLAYED-TABLE Treemenu
&Scoped-Define DISPLAYED-OBJECTS v-que_empresa v-accion v-comprobante ~
v-modo 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" V-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
THIS-PROCEDURE
</KEY-OBJECT>
<FOREIGN-KEYS>
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "",
     Keys-Supplied = ""':U).
/**************************
</EXECUTING-CODE> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_archivos 
     LABEL "&Archivos" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_archivos-2 
     LABEL "&Archivos" 
     SIZE 21 BY 1.

DEFINE BUTTON btn_copiar 
     LABEL "&Copiar a" 
     SIZE 10 BY 1.

DEFINE BUTTON btn_ejecutar 
     LABEL "&Comprobar Ejecución" 
     SIZE 24 BY 1.

DEFINE BUTTON btn_heredar 
     LABEL "&Heredar permisos" 
     SIZE 21 BY 1.14.

DEFINE VARIABLE v-comprobante AS CHARACTER FORMAT "X(256)":U 
     LABEL "Comprobante" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 106 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-modo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Modo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Sin Modo","X",
                     "Altas","0",
                     "Consultas","1",
                     "Modificaciones","5",
                     "Anulaciones","7",
                     "Emision","8"
     DROP-DOWN-LIST
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-accion AS CHARACTER FORMAT "X(80)" 
     LABEL "Acción" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 112 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-que_empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 157 BY 10.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Treemenu.cdg_item AT ROW 1.24 COL 16 COLON-ALIGNED FORMAT "X(40)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 40 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_ejecutar AT ROW 1.24 COL 60
     btn_copiar AT ROW 1.24 COL 134
     v-que_empresa AT ROW 1.24 COL 144 COLON-ALIGNED NO-LABEL
     Treemenu.cdg_padre AT ROW 1.29 COL 90 COLON-ALIGNED FORMAT "X(20)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 38 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.titulo AT ROW 2.43 COL 11.2
          VIEW-AS FILL-IN NATIVE 
          SIZE 112 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_heredar AT ROW 2.43 COL 133
     v-accion AT ROW 3.62 COL 16 COLON-ALIGNED
     btn_archivos AT ROW 3.62 COL 133
     v-comprobante AT ROW 4.81 COL 16 COLON-ALIGNED
     v-modo AT ROW 4.81 COL 131 COLON-ALIGNED
     Treemenu.archivo_help AT ROW 6 COL 16 COLON-ALIGNED FORMAT "X(90)"
          VIEW-AS FILL-IN 
          SIZE 112 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_archivos-2 AT ROW 6 COL 133
     Treemenu.permitidos AT ROW 7.19 COL 18 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 136 BY 1.62
          BGCOLOR 15 FGCOLOR 7 
     Treemenu.descripcion AT ROW 9.1 COL 18 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 136 BY 1.62
          BGCOLOR 15 FGCOLOR 7 
     RECT-2 AT ROW 1 COL 1
     "Descripción:" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 9.1 COL 5
     "Autorizados:" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 7.19 COL 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: despacho.Treemenu
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 11.14
         WIDTH              = 159.6.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Treemenu.archivo_help IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR BUTTON btn_archivos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Treemenu.cdg_item IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Treemenu.cdg_padre IN FRAME F-Main
   NO-ENABLE EXP-FORMAT                                                 */
/* SETTINGS FOR EDITOR Treemenu.descripcion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR Treemenu.permitidos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Treemenu.titulo IN FRAME F-Main
   ALIGN-L                                                              */
/* SETTINGS FOR COMBO-BOX v-modo IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_archivos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_archivos V-table-Win
ON CHOOSE OF btn_archivos IN FRAME F-Main /* Archivos */
DO:
  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE v-archivo AS CHARACTER.
  ASSIGN v-archivo = v-accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selprograma.p ( INPUT-OUTPUT v-archivo, INPUT ENTRY(1,Treemenu.cdg_item,"."),INPUT NO, OUTPUT ok ).
  IF ok 
     THEN DISPLAY v-archivo @ v-accion
                  WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_archivos-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_archivos-2 V-table-Win
ON CHOOSE OF btn_archivos-2 IN FRAME F-Main /* Archivos */
DO:
  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE x-help AS CHARACTER.
  ASSIGN x-help = Treemenu.archivo_help:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN selprograma.p ( INPUT-OUTPUT x-help, INPUT ENTRY(1,Treemenu.cdg_item,"."),INPUT NO, OUTPUT ok ).
  IF ok 
     THEN DISPLAY x-help @ Treemenu.archivo_help
                  WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_copiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copiar V-table-Win
ON CHOOSE OF btn_copiar IN FRAME F-Main /* Copiar a */
DO:
  DEFINE BUFFER B-Treemenu FOR Treemenu.
  
  ASSIGN v-que_empresa.
  DO TRANSACTION:
     FIND B-Treemenu WHERE B-Treemenu.cdg_empresa = v-que_empresa
                   AND B-Treemenu.cdg_item    = Treemenu.cdg_item
                       EXCLUSIVE-LOCK NO-ERROR.
     IF NOT AVAILABLE B-Treemenu 
        THEN CREATE B-Treemenu.
     BUFFER-COPY Treemenu TO B-Treemenu ASSIGN B-Treemenu.cdg_empresa = v-que_empresa.
     RELEASE B-Treemenu.
  END.
  DISPLAY "" @ v-que_empresa
          WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ejecutar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ejecutar V-table-Win
ON CHOOSE OF btn_ejecutar IN FRAME F-Main /* Comprobar Ejecución */
DO:
  DEFINE VARIABLE rid AS ROWID.
  
  IF v-accion <> ""
  THEN DO:
      IF SEARCH(v-accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}) <> ?
      THEN DO:
           IF v-modo = "X"
              THEN RUN VALUE(v-accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
              ELSE RUN VALUE(v-accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}) ( INPUT-OUTPUT rid, INPUT INTEGER(v-modo) ).
      END.     
      ELSE DO:
           MESSAGE "No se halló " v-accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                    VIEW-AS ALERT-BOX ERROR TITLE "No puede ejecutarse esta opción".
      END.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_heredar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_heredar V-table-Win
ON CHOOSE OF btn_heredar IN FRAME F-Main /* Heredar permisos */
DO:
  DEFINE VARIABLE j_padre AS INTEGER.
  DEFINE VARIABLE sino AS LOGICAL.

  sino = NO.
  MESSAGE "Desea copiar los permisos de este nodo a todos sus nodos dependientes"
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" SET sino.

  IF sino
  THEN DO:
      DO TRANSACTION:
          FOR EACH B-Treemenu WHERE B-Treemenu.cdg_item BEGINS Treemenu.cdg_item 
                            AND B-Treemenu.cdg_empresa = Treemenu.cdg_empresa
                                EXCLUSIVE-LOCK:
    
              DO j_padre = 1 TO NUM-ENTRIES(Treemenu.permitidos,","):
                  IF LOOKUP(ENTRY(j_padre,Treemenu.permitidos,","),B-Treemenu.permitidos,",") = 0 
                  THEN DO:
                      B-Treemenu.permitidos = B-Treemenu.permitidos + "," + ENTRY(j_padre,Treemenu.permitidos,",").
                  END.
              END.
              IF SUBSTRING(B-Treemenu.permitidos,1,1) = ","
                  THEN B-Treemenu.permitidos = SUBSTRING(B-Treemenu.permitidos,2).
    
          END.
          RELEASE B-Treemenu.
      END.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win  _ADM-ROW-AVAILABLE
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Treemenu"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Treemenu"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win  _DEFAULT-DISABLE
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
  HIDE FRAME F-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combo V-table-Win 
PROCEDURE inicia_combo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  {findempresa.i}

  DO WITH FRAME {&FRAME-NAME}:
      lista = "[Sin Comprobante]|Z".
      v-comprobante:DELIMITER = "|".
      FOR EACH Tipocomprobante NO-LOCK WHERE Tipocomprobante.cdg_empresa = Empresa.cdg_empresa BY Tipocomprobante.dsc_comprobante:
          lista = lista + "|" + TRIM(Tipocomprobante.dsc_comprobante) + " - " + STRING(Tipocomprobante.cdg_comprobante) + "|" + STRING(Tipocomprobante.cdg_comprobante).
      END.
      v-comprobante:LIST-ITEM-PAIRS = lista.
  END.          
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   ASSIGN FRAME {&FRAME-NAME} v-accion v-modo v-comprobante.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {findempresa.i}
   
   ASSIGN FRAME {&FRAME-NAME}
          Treemenu.permitidos
          Treemenu.descripcion.

   Treemenu.cdg_empresa = Empresa.cdg_empresa.
   
   DEFINE VARIABLE j-item AS INTEGER.
   
   Treemenu.cdg_padre = "".
   DO j-item = 1 TO NUM-ENTRIES(Treemenu.cdg_item,".") - 1:
      Treemenu.cdg_padre = Treemenu.cdg_padre + "." + ENTRY(j-item,Treemenu.cdg_item,".").         
   END.
   Treemenu.cdg_padre = SUBSTRING(Treemenu.cdg_padre,2).
   
   Treemenu.accion = v-accion + ":" + v-modo.
   IF v-comprobante <> "Z"
       THEN Treemenu.accion = Treemenu.accion + ":" + v-comprobante.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DO WITH FRAME {&FRAME-NAME}:
        btn_heredar:SENSITIVE     = YES. 
        btn_archivos:SENSITIVE     = NO. 
        Treemenu.descripcion:SENSITIVE = NO. 
        Treemenu.descripcion:FGCOLOR   = 7. 
        Treemenu.permitidos:SENSITIVE  = NO. 
        Treemenu.permitidos:FGCOLOR    = 7. 
        v-modo:SENSITIVE           = NO.
   END.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   IF AVAILABLE Treemenu
   THEN DO:
        IF Treemenu.accion <> ""
        THEN DO:
             v-accion = ENTRY(1,Treemenu.accion,":").
             v-modo = ENTRY(2,Treemenu.accion,":").
             IF NUM-ENTRIES(Treemenu.accion,":") > 2
                 THEN v-comprobante = ENTRY(3,Treemenu.accion,":").
                 ELSE v-comprobante = "Z".              
        END.
        ELSE DO:
             v-accion = "".
             v-modo = "X".
             v-comprobante = "Z".
        END.

        DISPLAY v-accion v-modo v-comprobante
                WITH FRAME {&FRAME-NAME}. 

       DO WITH FRAME {&FRAME-NAME}:
            btn_heredar:SENSITIVE      = YES. 
            btn_archivos:SENSITIVE     = YES. 
            Treemenu.descripcion:SENSITIVE = YES. 
            Treemenu.descripcion:FGCOLOR   = 9. 
            Treemenu.permitidos:SENSITIVE  = YES. 
            Treemenu.permitidos:FGCOLOR    = 9. 
            v-modo:SENSITIVE           = YES.
       END.
   END.
   ELSE DO:
       DO WITH FRAME {&FRAME-NAME}:
           btn_heredar:SENSITIVE      = NO. 
           btn_archivos:SENSITIVE     = NO. 
           Treemenu.descripcion:SENSITIVE = NO. 
           Treemenu.descripcion:FGCOLOR   = 9. 
           Treemenu.permitidos:SENSITIVE  = NO. 
           Treemenu.permitidos:FGCOLOR    = 9. 
           v-modo:SENSITIVE           = NO.
       END.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-enable-fields V-table-Win 
PROCEDURE local-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DO WITH FRAME {&FRAME-NAME}:
        btn_heredar:SENSITIVE      = YES. 
        btn_archivos:SENSITIVE     = YES. 
        Treemenu.descripcion:SENSITIVE = YES. 
        Treemenu.descripcion:FGCOLOR   = 9. 
        Treemenu.permitidos:SENSITIVE  = YES. 
        Treemenu.permitidos:FGCOLOR    = 9. 
        v-modo:SENSITIVE           = YES.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   RUN inicia_combo.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Treemenu"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed V-table-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE    NO-UNDO.
  DEFINE INPUT PARAMETER p-state      AS CHARACTER NO-UNDO.

  CASE p-state:
      /* Object instance CASEs can go here to replace standard behavior
         or add new cases. */
      {src/adm/template/vstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

