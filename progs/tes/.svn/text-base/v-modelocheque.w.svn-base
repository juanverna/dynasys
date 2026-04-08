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

DEFINE VARIABLE x-secuencia AS CHARACTER.
DEFINE BUFFER B-Modelocheque FOR Modelocheque.

DEFINE VARIABLE es_por_copia AS LOGICAL    NO-UNDO.
DEFINE VARIABLE codigo_modelo_anterior LIKE sic.Modelocheque.cdg_modelocheque.

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
&Scoped-define EXTERNAL-TABLES Modelocheque
&Scoped-define FIRST-EXTERNAL-TABLE Modelocheque


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Modelocheque.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Modelocheque.cdg_impresora ~
Modelocheque.dsc_modelocheque Modelocheque.cant_renglones ~
Modelocheque.secuenciainit Modelocheque.tipo_impresora 
&Scoped-define ENABLED-TABLES Modelocheque
&Scoped-define FIRST-ENABLED-TABLE Modelocheque
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Modelocheque.cdg_modelocheque ~
Modelocheque.cdg_impresora Modelocheque.dsc_modelocheque ~
Modelocheque.cant_renglones Modelocheque.secuenciainit ~
Modelocheque.tipo_impresora 
&Scoped-define DISPLAYED-TABLES Modelocheque
&Scoped-define FIRST-DISPLAYED-TABLE Modelocheque


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
DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 136 BY 4.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Modelocheque.cdg_modelocheque AT ROW 1.48 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Modelocheque.cdg_impresora AT ROW 1.48 COL 50 COLON-ALIGNED
          LABEL "Impresora"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1",0
          DROP-DOWN-LIST
          SIZE 84 BY 1
          BGCOLOR 15 FGCOLOR 9 FONT 4
     Modelocheque.dsc_modelocheque AT ROW 2.67 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 88 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Modelocheque.cant_renglones AT ROW 2.67 COL 127 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Modelocheque.secuenciainit AT ROW 3.86 COL 17 COLON-ALIGNED FORMAT "X(150)"
          VIEW-AS FILL-IN 
          SIZE 88 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Modelocheque.tipo_impresora AT ROW 3.86 COL 114 COLON-ALIGNED
          LABEL "Tipo"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Caracter","Pixeles" 
          DROP-DOWN-LIST
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Modelocheque
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
         HEIGHT             = 5.14
         WIDTH              = 146.2.
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

/* SETTINGS FOR COMBO-BOX Modelocheque.cdg_impresora IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Modelocheque.cdg_modelocheque IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Modelocheque.secuenciainit IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR COMBO-BOX Modelocheque.tipo_impresora IN FRAME F-Main
   EXP-LABEL                                                            */
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

&Scoped-define SELF-NAME Modelocheque.secuenciainit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Modelocheque.secuenciainit V-table-Win
ON MOUSE-MENU-DOWN OF Modelocheque.secuenciainit IN FRAME F-Main /* Secuencia Init */
OR SHIFT-F1 OF Modelocheque.secuenciainit IN FRAME {&FRAME-NAME}
DO:
  x-secuencia = Modelocheque.secuenciainit.
  RUN selectar_secuencias.p ( INPUT-OUTPUT  x-secuencia, INPUT Modelocheque.cdg_impresora:INPUT-VALUE IN FRAME {&FRAME-NAME} ).
  DISPLAY x-secuencia @ Modelocheque.secuenciainit 
      WITH FRAME {&FRAME-NAME}.
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
  {src/adm/template/row-list.i "Modelocheque"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Modelocheque"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  es_por_copia = NO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
 DEFINE VARIABLE codigo_actual LIKE Modelocheque.cdg_modelocheque.
 DEFINE BUFFER b_Campo_modelocheque FOR Campo_modelocheque.

  /* Code placed here will execute PRIOR to standard behavior. */

  
  IF Modelocheque.cdg_modelocheque:INPUT-VALUE IN FRAME {&FRAME-NAME} = "" 
  THEN DO:
      RUN ponmensj.p ( INPUT "MDCH005" ).
      RETURN ERROR.    
  END.

  codigo_actual = Modelocheque.cdg_modelocheque:INPUT-VALUE IN FRAME {&FRAME-NAME}.

  IF Modelocheque.dsc_modelocheque:INPUT-VALUE IN FRAME {&FRAME-NAME} = "" 
  THEN DO:
      RUN ponmensj.p ( INPUT "MDCH006" ).
      RETURN ERROR.    
  END.
   
  IF CAN-FIND(B-Modelocheque WHERE B-Modelocheque.cdg_modelocheque = Modelocheque.cdg_modelocheque:INPUT-VALUE IN FRAME {&FRAME-NAME}
                               AND ROWID(B-Modelocheque) <> ROWID(Modelocheque))
  THEN DO:
      RUN ponmensj.p ( INPUT "MDCH007" ).
      RETURN ERROR.    
  END.

  IF Modelocheque.cant_renglones:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 
  THEN DO:
      RUN ponmensj.p ( INPUT "MDCH004" ).
      RETURN ERROR.    
  END.

  DEFINE VARIABLE cambio_impresora AS LOGICAL.  
  cambio_impresora = Modelocheque.tipo_impresora:INPUT-VALUE IN FRAME {&FRAME-NAME} <> Modelocheque.tipo_impresora.
  
  IF cambio_impresora AND Modelocheque.tipo_impresora:INPUT-VALUE IN FRAME {&FRAME-NAME} = "Caracter"
  THEN DO:
      DEFINE VARIABLE sino AS LOGICAL.
      MESSAGE "Redefinir una impresora de PIXELES como CARACTER puede afectar la representación de los campos del cheque."
              "Desea de todas maneras realizar este cambio?"
          VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO TITLE "AVISO" SET sino .
      IF NOT sino THEN RETURN ERROR.
  END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN FRAME {&FRAME-NAME}  Modelocheque.secuenciainit.
  ASSIGN modelocheque.cdg_modelocheque = codigo_actual.


  IF cambio_impresora AND Modelocheque.tipo_impresora = "Caracter"
  THEN DO:
      FOR EACH Campo_modelocheque OF Modelocheque:
          Campo_modelocheque.x_campomodelo = ROUND(Campo_modelocheque.x_campomodelo,0).
          Campo_modelocheque.y_campomodelo = ROUND(Campo_modelocheque.y_campomodelo,0).
      END.
  END.


  IF adm-new-record THEN
  DO:
      IF es_por_copia = YES THEN
      DO:
          FOR EACH Campo_modelocheque 
             WHERE Campo_modelocheque.cdg_modelocheque = codigo_modelo_anterior
             NO-LOCK :
             CREATE b_Campo_modelocheque.
             BUFFER-COPY Campo_modelocheque EXCEPT   Campo_modelocheque.cdg_modelocheque
                                            TO     b_Campo_modelocheque.
             ASSIGN b_Campo_modelocheque.cdg_modelocheque = codigo_actual.

         END.
      END.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  ASSIGN
  es_por_copia           = YES
  codigo_modelo_anterior = Modelocheque.cdg_modelocheque.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-delete-record V-table-Win 
PROCEDURE local-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE codigo_actual LIKE Campo_modelocheque.cdg_modelocheque.

  /* Code placed here will execute PRIOR to standard behavior. */
  IF AVAILABLE Modelocheque THEN
  codigo_actual = Modelocheque.cdg_modelocheque.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  FOR EACH Campo_modelocheque 
             WHERE  Campo_modelocheque.cdg_modelocheque = codigo_actual :
             DELETE Campo_modelocheque.
  END.
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
   DISABLE Modelocheque.cdg_modelocheque WITH FRAME {&FRAME-NAME}.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  Modelocheque.secuenciainit:SENSITIVE IN FRAME {&FRAME-NAME}  = NO.
  Modelocheque.secuenciainit:FGCOLOR IN FRAME {&FRAME-NAME}  = 7.

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

  IF adm-new-record  THEN
     ENABLE Modelocheque.cdg_modelocheque WITH FRAME {&FRAME-NAME}.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  Modelocheque.secuenciainit:SENSITIVE IN FRAME {&FRAME-NAME}  = YES.
  Modelocheque.secuenciainit:FGCOLOR IN FRAME {&FRAME-NAME}  = 9.

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

  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
   /*{levantacombo.i &TABLA=Rubro &NOMBRE=nombre &CODIGO=cdg_rubro &OBJETO=T-Lote_pago.cdg_rubro &CONDICION="Rubro.tipo = 'P' OR Rubro.tipo = 'B'"}*/
     {levantacombo.i &TABLA=Impresora &NOMBRE=nombre &CODIGO=cdg_impresora &OBJETO=Modelocheque.cdg_impresora}
/*     {levantacombo.i &TABLA=Cuenta_bancaria &NOMBRE=denominacion_cta &CODIGO=cdg_cuenta_ban &OBJETO=T-Lote_pago.cdg_cuenta_ban}*/
  END.          


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
  {src/adm/template/snd-list.i "Modelocheque"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tomo_modelo_cheque V-table-Win 
PROCEDURE tomo_modelo_cheque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE OUTPUT PARAMETER codigo_modelo LIKE sic.Modelocheque.cdg_modelocheque.
codigo_modelo = Modelocheque.cdg_modelocheque.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

