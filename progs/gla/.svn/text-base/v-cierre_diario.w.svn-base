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
&Scoped-define EXTERNAL-TABLES Cierre_diario
&Scoped-define FIRST-EXTERNAL-TABLE Cierre_diario


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cierre_diario.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cierre_diario.cdg_estado_cierre 
&Scoped-define ENABLED-TABLES Cierre_diario
&Scoped-define FIRST-ENABLED-TABLE Cierre_diario
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Cierre_diario.cdg_sigla-sic ~
Cierre_diario.fch_cierre Cierre_diario.cdg_estado_cierre 
&Scoped-define DISPLAYED-TABLES Cierre_diario
&Scoped-define FIRST-DISPLAYED-TABLE Cierre_diario
&Scoped-Define DISPLAYED-OBJECTS v-forzado 

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
     SIZE 73 BY 5.48.

DEFINE VARIABLE v-forzado AS LOGICAL INITIAL no 
     LABEL "Forzar Cambio" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .95 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cierre_diario.cdg_sigla-sic AT ROW 2.67 COL 3 NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 70 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cierre_diario.fch_cierre AT ROW 5.05 COL 3 NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cierre_diario.cdg_estado_cierre AT ROW 5.05 COL 19 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "a","a"
          DROP-DOWN-LIST
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-forzado AT ROW 5.05 COL 55
     "  Módulo con el que se relaciona el cierre" VIEW-AS TEXT
          SIZE 70 BY 1 AT ROW 1.48 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "  Fecha del cierre y estado del mismo" VIEW-AS TEXT
          SIZE 70 BY 1 AT ROW 3.86 COL 3
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cierre_diario
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
         HEIGHT             = 5.71
         WIDTH              = 96.4.
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

/* SETTINGS FOR COMBO-BOX Cierre_diario.cdg_sigla-sic IN FRAME F-Main
   NO-ENABLE ALIGN-L EXP-LABEL                                          */
/* SETTINGS FOR FILL-IN Cierre_diario.fch_cierre IN FRAME F-Main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR TOGGLE-BOX v-forzado IN FRAME F-Main
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
  {src/adm/template/row-list.i "Cierre_diario"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cierre_diario"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos V-table-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Modulo-sic &NOMBRE=descripcion &CODIGO=cdg_sigla-sic &OBJETO=Cierre_diario.cdg_sigla-sic
                     &CONDICION=Modulo-sic.presente AND Modulo-sic.activo}
     {levantacombo.i &TABLA=estado_cierre &NOMBRE=dsc_estado_cierre &CODIGO=cdg_estado_cierre &OBJETO=cierre_diario.cdg_estado_cierre }                     

  END.          
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-add-record V-table-Win 
PROCEDURE local-add-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN Cierre_diario.cdg_estado_cierre:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "0".

  ASSIGN Cierre_diario.fch_cierre:SENSITIVE IN FRAME {&FRAME-NAME} = YES
         Cierre_diario.cdg_sigla-sic:SENSITIVE IN FRAME {&FRAME-NAME} = YES.


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

  DEFINE VARIABLE cierre_ok AS INTEGER.
  DEFINE BUFFER B-Cierre_diario FOR Cierre_diario.

  ASSIGN FRAME {&FRAME-NAME} v-forzado.

  {findempresa.i}
  
  IF Cierre_diario.cdg_estado_cierre = "3"
  THEN DO:
      RUN ponmensj.p ( INPUT "CIER008" ).
      RETURN ERROR.
  END.

  IF Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME} = DATE("")
  THEN DO:
      RUN ponmensj.p ( INPUT "CIER001" ).
      RETURN ERROR.
  END.

  RUN GET-ATTRIBUTE ("ADM-NEW-RECORD").
  IF RETURN-VALUE = "YES"
  THEN DO:
      IF CAN-FIND(FIRST Cierre_diario 
                        WHERE Cierre_diario.cdg_empresa = Empresa.cdg_empresa
                          AND Cierre_diario.cdg_sigla-sic = Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME}
                          AND Cierre_diario.fch_cierre = Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME})
      THEN DO:
          RUN ponmensj.p ( INPUT "CIER002" ).
          RETURN ERROR.
      END.
      ELSE DO:
          IF Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME} <> "0" 
          THEN DO:
              RUN ponmensj.p ( INPUT "CIER004" ).
              RETURN ERROR.
          END.
          ELSE DO:
              IF CAN-FIND(FIRST Cierre_diario 
                            WHERE Cierre_diario.cdg_empresa = Empresa.cdg_empresa
                              AND Cierre_diario.cdg_sigla-sic = Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME}
                              AND Cierre_diario.fch_cierre > Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
                              AND Cierre_diario.cdg_estado_cierre > Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME})
              THEN DO:
                  RUN ponmensj.p ( INPUT "CIER005" ).
                  RETURN ERROR.
              END.
              ELSE DO:
                  IF CAN-FIND(FIRST Cierre_diario 
                                WHERE Cierre_diario.cdg_empresa = Empresa.cdg_empresa
                                  AND Cierre_diario.cdg_sigla-sic = Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME}
                                  AND Cierre_diario.fch_cierre < Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
                                  AND Cierre_diario.cdg_estado_cierre < Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME})
                  THEN DO:
                      RUN ponmensj.p ( INPUT "CIER006" ).
                      RETURN ERROR.
                  END.
              
              END.
          END.
      END.
  END.
  ELSE DO: /* Modificacion */
      IF Cierre_diario.cdg_estado_cierre = Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
      THEN DO:
          RUN ponmensj.p ( INPUT "CIER003" ).
          RETURN ERROR.
      END.
      ELSE DO:
          IF CAN-FIND(FIRST B-Cierre_diario 
                        WHERE B-Cierre_diario.cdg_empresa = Empresa.cdg_empresa
                          AND B-Cierre_diario.cdg_sigla-sic = Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME}
                          AND B-Cierre_diario.fch_cierre > Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
                          AND B-Cierre_diario.cdg_estado_cierre > Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
                          AND ROWID(B-Cierre_diario) <> ROWID(Cierre_diario))
          THEN DO:
              RUN ponmensj.p ( INPUT "CIER005" ).
              RETURN ERROR.
          END.
          ELSE DO:
              IF CAN-FIND(FIRST B-Cierre_diario 
                            WHERE B-Cierre_diario.cdg_empresa = Empresa.cdg_empresa
                              AND B-Cierre_diario.cdg_sigla-sic = Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME}
                              AND B-Cierre_diario.fch_cierre < Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
                              AND B-Cierre_diario.cdg_estado_cierre < Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME}
                              AND ROWID(B-Cierre_diario) <> ROWID(Cierre_diario))
              THEN DO:
                  RUN ponmensj.p ( INPUT "CIER006" ).
                  RETURN ERROR.
              END.
          
          END.
      END.

      IF NOT v-forzado
      THEN DO:
          IF Cierre_diario.cdg_estado_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME} > "0"
          THEN DO:
              RUN verificar_cierre_posible.p ( INPUT Empresa.cdg_empresa,
                                               INPUT Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME},
                                               INPUT Cierre_diario.fch_cierre:INPUT-VALUE IN FRAME {&FRAME-NAME},
                                               OUTPUT cierre_ok).
            
              IF cierre_ok <> 0
              THEN DO:
                  RUN ponmensj.p ( INPUT "Z" + INPUT Cierre_diario.cdg_sigla-sic:INPUT-VALUE IN FRAME {&FRAME-NAME} + STRING(cierre_ok,"999")).
                  RETURN ERROR.
              END.
          END.
      END.

  END.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN FRAME {&FRAME-NAME} Cierre_diario.fch_cierre Cierre_diario.cdg_sigla-sic.

  IF NEW Cierre_diario
  THEN DO:
      Cierre_diario.cdg_empresa = Empresa.cdg_empresa.
  END.
  
  CREATE Hst_cierre_diario.
  BUFFER-COPY Cierre_diario TO Hst_cierre_diario
      ASSIGN Hst_cierre_diario.forzado = v-forzado.
 
  RUN completar_auditoria.p ( OUTPUT Hst_cierre_diario.nro_usuario,
                              OUTPUT Hst_cierre_diario.fecha_grab,
                              OUTPUT Hst_cierre_diario.hora_grab,
                              OUTPUT Hst_cierre_diario.pc_name).

  Hst_cierre_diario.hms_grab = STRING(Hst_cierre_diario.hora_grab,"HH:MM:SS").

  IF Cierre_diario.cdg_sigla-sic = "TES" 
  THEN DO:
      FOR EACH Cierre_diariocaja
         WHERE Cierre_diariocaja.cdg_empresa = Cierre_diario.cdg_empresa
           AND Cierre_diariocaja.fch_cierre  = Cierre_diario.fch_cierre :

          ASSIGN Cierre_diariocaja.cdg_estado_cierre = "3".

      END.
  END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-delete-record V-table-Win 
PROCEDURE local-delete-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

/*  RUN ponmensj.p ( INPUT "CIER009"). /* No se permite la eliminación de registros de cierre */
  RETURN ERROR.
  */
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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

  ASSIGN Cierre_diario.fch_cierre:SENSITIVE IN FRAME {&FRAME-NAME} = NO
         Cierre_diario.fch_cierre:SENSITIVE IN FRAME {&FRAME-NAME} = NO
         Cierre_diario.cdg_sigla-sic:SENSITIVE IN FRAME {&FRAME-NAME} = NO
         v-forzado:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

   v-forzado = NO.
   DISPLAY v-forzado 
       WITH FRAME {&FRAME-NAME}.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  v-forzado:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-end-update V-table-Win 
PROCEDURE local-end-update :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-c AS CHARACTER.
  DEFINE VARIABLE v-h AS HANDLE.
  
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'end-update':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE ,
      INPUT "Record-Target",
      OUTPUT v-c).
  v-h = WIDGET-HANDLE(v-c).
  IF VALID-HANDLE(v-h)
      THEN RUN dispatch IN v-h ( INPUT "open-query" ).

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

   RUN inicia_combos.

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
  {src/adm/template/snd-list.i "Cierre_diario"}

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

