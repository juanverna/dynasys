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

  DEFINE VARIABLE x-lista AS CHARACTER.
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.estado Tarea.cdg_tipotarea ~
Tarea.nro_predecesora Tarea.prioridad Tarea.titulo Tarea.cdg_proyecto ~
Tarea.cdg_recurso Tarea.reportado_por Tarea.fecha_reportado ~
Tarea.version-reporte Tarea.horas_estimadas Tarea.reportado_ref ~
Tarea.fecha_prevista Tarea.fecha_resuelto Tarea.version-arreglo ~
Tarea.horas_reales Tarea.descripcion Tarea.accion 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Tarea.nro_tarea Tarea.estado ~
Tarea.cdg_tipotarea Tarea.nro_predecesora Tarea.prioridad Tarea.titulo ~
Tarea.cdg_proyecto Tarea.cdg_recurso Tarea.reportado_por ~
Tarea.fecha_reportado Tarea.fecha_alta Tarea.hora_alta ~
Tarea.version-reporte Tarea.horas_estimadas Tarea.reportado_ref ~
Tarea.fecha_prevista Tarea.fecha_resuelto Tarea.version-arreglo ~
Tarea.horas_reales Tarea.descripcion Tarea.accion 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea


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
     SIZE 149 BY 20.95.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Tarea.nro_tarea AT ROW 1.24 COL 13 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.estado AT ROW 1.24 COL 31 COLON-ALIGNED NO-LABEL
          VIEW-AS COMBO-BOX SORT INNER-LINES 5
          LIST-ITEM-PAIRS "Abierto","A",
                     "Resuelto","R",
                     "Descartado","D",
                     "Control Calidad","Q",
                     "Tratado","T"
          DROP-DOWN-LIST
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.cdg_tipotarea AT ROW 1.24 COL 68 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 30 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.nro_predecesora AT ROW 1.24 COL 115 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.prioridad AT ROW 1.24 COL 139 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.titulo AT ROW 2.43 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 132 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.cdg_proyecto AT ROW 3.62 COL 13 COLON-ALIGNED
          LABEL "Proyecto"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 55 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.cdg_recurso AT ROW 3.62 COL 83 COLON-ALIGNED
          LABEL "Recurso"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 62 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.reportado_por AT ROW 6.24 COL 13 COLON-ALIGNED
          LABEL "Solicita"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.fecha_reportado AT ROW 6.24 COL 51 COLON-ALIGNED
          LABEL "Fecha"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.fecha_alta AT ROW 6.24 COL 83 COLON-ALIGNED
          LABEL "Fecha/Hora"
          VIEW-AS FILL-IN 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.hora_alta AT ROW 6.24 COL 100 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.version-reporte AT ROW 7.43 COL 13 COLON-ALIGNED
          LABEL "Versión"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.horas_estimadas AT ROW 7.43 COL 51 COLON-ALIGNED
          LABEL "Estimado"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.reportado_ref AT ROW 8.62 COL 13 COLON-ALIGNED
          LABEL "Referencia"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.fecha_prevista AT ROW 8.62 COL 51 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.fecha_resuelto AT ROW 8.62 COL 83 COLON-ALIGNED
          LABEL "Fecha"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Tarea.version-arreglo AT ROW 8.62 COL 109 COLON-ALIGNED
          LABEL "Versión"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.horas_reales AT ROW 8.62 COL 132 COLON-ALIGNED
          LABEL "Horas"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Tarea.descripcion AT ROW 11.24 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 67 BY 10.24
          BGCOLOR 15 FGCOLOR 7 
     Tarea.accion AT ROW 11.24 COL 74 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 72 BY 10.24
          BGCOLOR 15 FGCOLOR 7 
     "    Alta de la tarea:Usuario, fecha , hora y puesto" VIEW-AS TEXT
          SIZE 72 BY 1 AT ROW 5.05 COL 74
          BGCOLOR 5 FGCOLOR 15 
     "    Datos de la solicitud" VIEW-AS TEXT
          SIZE 67 BY 1 AT ROW 5.05 COL 3
          BGCOLOR 5 FGCOLOR 15 
     "    Resolución de la tarea" VIEW-AS TEXT
          SIZE 72 BY 1 AT ROW 7.43 COL 74
          BGCOLOR 5 FGCOLOR 15 
     "    Comentarios adicionales" VIEW-AS TEXT
          SIZE 72 BY 1 AT ROW 10.05 COL 74
          BGCOLOR 5 FGCOLOR 15 
     "    Descripción de la tarea" VIEW-AS TEXT
          SIZE 67 BY 1 AT ROW 10.05 COL 3
          BGCOLOR 5 FGCOLOR 15 
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tarea
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
         HEIGHT             = 21.14
         WIDTH              = 151.8.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR COMBO-BOX Tarea.cdg_proyecto IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Tarea.cdg_recurso IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.fecha_alta IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Tarea.fecha_reportado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.fecha_resuelto IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.horas_estimadas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.horas_reales IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.hora_alta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Tarea.nro_tarea IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Tarea.reportado_por IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.reportado_ref IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.version-arreglo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.version-reporte IN FRAME F-Main
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

&Scoped-define SELF-NAME Tarea.cdg_tipotarea
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.cdg_tipotarea V-table-Win
ON VALUE-CHANGED OF Tarea.cdg_tipotarea IN FRAME F-Main /* Tipo */
DO:
  RUN inicia_recursos.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.fecha_prevista
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.fecha_prevista V-table-Win
ON MOUSE-MENU-DOWN OF Tarea.fecha_prevista IN FRAME F-Main /* Previsto */
DO:
    fecha_inicial = DATE(Tarea.fecha_prevista:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
    IF fecha_inicial = ? THEN fecha_inicial = TODAY.
    RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
    IF fecha_elegida <> ?
    THEN DO:
         DISPLAY fecha_elegida @ Tarea.fecha_prevista 
                 WITH FRAME {&FRAME-NAME}.
         APPLY "TAB" TO SELF.        
    END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.fecha_reportado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.fecha_reportado V-table-Win
ON MOUSE-MENU-DOWN OF Tarea.fecha_reportado IN FRAME F-Main /* Fecha */
DO:
    fecha_inicial = DATE(Tarea.fecha_reportado:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
    IF fecha_inicial = ? THEN fecha_inicial = TODAY.
    RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
    IF fecha_elegida <> ?
    THEN DO:
         DISPLAY fecha_elegida @ Tarea.fecha_reportado 
                 WITH FRAME {&FRAME-NAME}.
         APPLY "TAB" TO SELF.        
    END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.fecha_resuelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.fecha_resuelto V-table-Win
ON MOUSE-MENU-DOWN OF Tarea.fecha_resuelto IN FRAME F-Main /* Fecha */
DO:
  fecha_inicial = DATE(Tarea.fecha_resuelto:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ Tarea.fecha_resuelto 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
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
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tarea"}

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

  RUN inicia_proyectos.
  RUN inicia_tipotareas.
  RUN inicia_recursos. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_proyectos V-table-Win 
PROCEDURE inicia_proyectos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  x-lista = "[Indique Proyecto],*".
  FOR EACH Proyecto BY Proyecto.cdg_proyecto:
    x-lista = x-lista +  "," + Proyecto.dsc_proyecto + "," + Proyecto.cdg_proyecto.
  END.
  Tarea.cdg_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_recursos V-table-Win 
PROCEDURE inicia_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR i AS INT NO-UNDO.
DEF VAR mm AS LOGICAL NO-UNDO.
x-lista = "[Indique Recurso],*".
FIND tipo_tarea WHERE cdg_tipotarea = tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
IF AVAILABLE tipo_tarea THEN DO:
  FOR EACH Recurso BY Recurso.cdg_recurso :
      mm = TRUE.
/*    mm = FALSE.
    DO i = 1 TO num-entries(tipo_tarea.habilidades):
        IF CAN-DO(recurso.habilidades, entry(i,tipo_tarea.habilidades )) THEN DO:
           mm = TRUE.
           LEAVE.
        END.
    END. */
    IF mm THEN
        x-lista = x-lista +  "," + Recurso.nom_recurso + "," + Recurso.cdg_recurso.
  END.
  Tarea.cdg_recurso:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_tipotareas V-table-Win 
PROCEDURE inicia_tipotareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  x-lista = "[Indique Tipo de Tarea],".
  FOR EACH Tipo_tarea NO-LOCK BY Tipo_tarea.cdg_tipotarea:
    x-lista = x-lista +  "," + Tipo_tarea.dsc_tipotarea + "," + Tipo_tarea.cdg_tipotarea.
  END.
  Tarea.cdg_tipotarea:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(x-lista,1).

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


  Tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME} = " ".

  DEFINE VARIABLE x-browse AS CHARACTER.
  DEFINE VARIABLE h-browse AS HANDLE.
  DEFINE VARIABLE x-valor  AS CHARACTER.

  RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT "RECORD-SOURCE":U /* CHARACTER */,
      OUTPUT x-browse /* CHARACTER */).

  h-browse = WIDGET-HANDLE(x-browse).
  IF VALID-HANDLE(h-browse)
  THEN DO:
      RUN valor_proyecto IN h-browse ( OUTPUT x-valor ).
      Tarea.cdg_proyecto:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-valor. 

      RUN valor_recurso IN h-browse ( OUTPUT x-valor ).
      Tarea.cdg_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-valor. 

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

  IF Tarea.cdg_proyecto:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""
  THEN DO:
      MESSAGE "No indicó el proyecto al que se refiere la tarea"
          VIEW-AS ALERT-BOX ERROR TITLE "TARE001".
      RETURN ERROR.
  END.

  IF Tarea.cdg_tipotarea:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""
  THEN DO:
      MESSAGE "No indicó el tipo de tarea al que se refiere la tarea"
          VIEW-AS ALERT-BOX ERROR TITLE "TARE002".
      RETURN ERROR.
  END.

  IF Tarea.cdg_recurso:INPUT-VALUE IN FRAME {&FRAME-NAME} = ""
  THEN DO:
      MESSAGE "No indicó el recurso al que se refiere la tarea"
          VIEW-AS ALERT-BOX ERROR TITLE "TARE003".
      RETURN ERROR.
  END.

  IF Tarea.fecha_reportado:INPUT-VALUE IN FRAME {&FRAME-NAME} = DATE("")
  THEN DO:
      MESSAGE "No indicó la fecha de reporte"
          VIEW-AS ALERT-BOX ERROR TITLE "TARE004".
      RETURN ERROR.
  END.

  IF Tarea.fecha_prevista:INPUT-VALUE IN FRAME {&FRAME-NAME} = DATE("")
  THEN DO:
      MESSAGE "No indicó la fecha de necesidad" SKIP
              " Se prosigue la grabacion "
          VIEW-AS ALERT-BOX INFORMATION TITLE "TARE005".
  END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF NEW Tarea
  THEN DO:

      DEFINE VARIABLE hora AS INTEGER.

      ASSIGN Tarea.nro_tarea  = NEXT-VALUE(proxima_tarea)
             Tarea.estado     = "A".

      RUN completar_auditoria.p ( OUTPUT Tarea.cdg_usuario,
                                  OUTPUT Tarea.fecha_alta,
                                  OUTPUT hora,
                                  OUTPUT Tarea.pc_name ).
      Tarea.hora_alta  = STRING(hora,"HH:MM:SS").

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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  Tarea.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.
  Tarea.accion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

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

  IF AVAILABLE Tarea
  THEN DO:
      IF Tarea.nro_predecesora:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0
      THEN DO:
          Tarea.nro_predecesora:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
      END.
      ELSE DO:
          IF CAN-FIND(FIRST Tarea WHERE Tarea.nro_tarea = Tarea.nro_predecesora:INPUT-VALUE IN FRAME {&FRAME-NAME}
                                    AND Tarea.estado = "A")
          THEN DO:
              Tarea.nro_predecesora:BGCOLOR IN FRAME {&FRAME-NAME} = 14.
          END.
          ELSE DO:
              Tarea.nro_predecesora:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
          END.
    
      END.
  END.
  ELSE DO:
      Tarea.nro_predecesora:BGCOLOR IN FRAME {&FRAME-NAME} = 15.
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

  Tarea.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.
  Tarea.accion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_proyectos V-table-Win 
PROCEDURE refrescar_proyectos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-lista AS CHARACTER.

  Tarea.cdg_proyecto:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = p-lista.
/*
  x-proyecto = Tarea.cdg_proyecto:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN inicia_proyectos.
  Tarea.cdg_proyecto:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-proyecto.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_recursos V-table-Win 
PROCEDURE refrescar_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-recurso AS CHARACTER.

  x-recurso = Tarea.cdg_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN inicia_recursos.
  Tarea.cdg_recurso:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-recurso.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_tipotareas V-table-Win 
PROCEDURE refrescar_tipotareas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE x-tipotarea AS CHARACTER.

  x-tipotarea = Tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  RUN inicia_tipotareas.
  Tarea.cdg_tipotarea:SCREEN-VALUE IN FRAME {&FRAME-NAME} = x-tipotarea.


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
  {src/adm/template/snd-list.i "Tarea"}

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

