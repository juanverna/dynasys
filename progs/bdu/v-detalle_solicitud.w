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

DEFINE VARIABLE rid_tabla       AS ROWID.
DEFINE VARIABLE v-detalle_linea AS INTEGER.
DEFINE VARIABLE rc              AS INTEGER.

DEFINE VARIABLE v-refrescar     AS LOGICAL.
DEFINE VARIABLE es_alta         AS LOGICAL.

DEFINE VARIABLE v-contar_displ-flds AS INTEGER.
DEFINE VARIABLE v-modificar         AS LOGICAL.

DEFINE VARIABLE articulo_error  AS LOGICAL.

{findsector.i}
{findempresa.i}

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
&Scoped-define EXTERNAL-TABLES Sre_detalle Sre_header Articulo
&Scoped-define FIRST-EXTERNAL-TABLE Sre_detalle


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Sre_detalle, Sre_header, Articulo.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Sre_detalle.cantidad Sre_detalle.granel ~
Sre_detalle.num_pedido Sre_detalle.fecha_retorno 
&Scoped-define ENABLED-TABLES Sre_detalle
&Scoped-define FIRST-ENABLED-TABLE Sre_detalle
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Sre_detalle.cantidad Sre_detalle.granel ~
Sre_detalle.num_pedido Sre_detalle.cdg_estado Sre_detalle.fecha_retorno ~
Sre_detalle.modo_etiquetas Sre_detalle.observacion Sre_detalle.detallada 
&Scoped-define DISPLAYED-TABLES Sre_detalle
&Scoped-define FIRST-DISPLAYED-TABLE Sre_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo 

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
DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 21.2 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 92 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 129.8 BY 10.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-cdg_articulo AT ROW 1.24 COL 12.2 COLON-ALIGNED
     Sre_detalle.cantidad AT ROW 2.67 COL 12 COLON-ALIGNED
          LABEL "Cantidad"
          VIEW-AS FILL-IN NATIVE 
          SIZE 21.2 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Sre_detalle.granel AT ROW 2.67 COL 43 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Sre_detalle.num_pedido AT ROW 2.67 COL 84 COLON-ALIGNED FORMAT "99999999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 21.2 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Sre_detalle.cdg_estado AT ROW 2.67 COL 117 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_articulo AT ROW 1.24 COL 35 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     Sre_detalle.fecha_retorno AT ROW 4.14 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 21.4 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Sre_detalle.modo_etiquetas AT ROW 4.33 COL 97 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Juntas", "J":U,
"Independientes", "I":U
          SIZE 32 BY .67
     Sre_detalle.observacion AT ROW 6.71 COL 4 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 60 BY 4
          BGCOLOR 15 FGCOLOR 7 
     Sre_detalle.detallada AT ROW 6.71 COL 67 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 62 BY 4
          BGCOLOR 15 FGCOLOR 7 
     RECT-1 AT ROW 1 COL 1.2
     "   Modo de Generación de Etiquetas:" VIEW-AS TEXT
          SIZE 36 BY 1 AT ROW 4.14 COL 60
     "    Observaciones del item de solicitud" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 5.52 COL 4
          BGCOLOR 5 FGCOLOR 15 
     "    Descripción detallada del bien" VIEW-AS TEXT
          SIZE 62 BY 1 AT ROW 5.52 COL 67
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Sre_detalle,sic.Sre_header,sic.Articulo
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
         HEIGHT             = 10.62
         WIDTH              = 132.
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
   NOT-VISIBLE Size-to-Fit Custom                                       */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Sre_detalle.cantidad IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Sre_detalle.cdg_estado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR EDITOR Sre_detalle.detallada IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET Sre_detalle.modo_etiquetas IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Sre_detalle.num_pedido IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR EDITOR Sre_detalle.observacion IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME F-Main
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

&Scoped-define SELF-NAME Sre_detalle.cantidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Sre_detalle.cantidad V-table-Win
ON LEAVE OF Sre_detalle.cantidad IN FRAME F-Main /* Cantidad */
DO:
  IF NOT es_alta THEN DO:

      DEFINE VARIABLE x-cantidad LIKE Sre_detalle.cantidad.
      DEFINE VARIABLE x-granel   LIKE Sre_detalle.granel.
    
      IF Articulo.granel_pesado
      THEN DO:
           x-cantidad = INPUT FRAME {&FRAME-NAME} Sre_detalle.cantidad.
           x-granel = x-cantidad * Articulo.relacion_granel.
           DISPLAY x-granel @ Sre_detalle.granel
               WITH FRAME {&FRAME-NAME}.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_articulo IN FRAME F-Main /* Artículo */
OR "." OF v-cdg_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_articulo IN FRAME {&FRAME-NAME}
DO:
  
  RUN SELARTIC_SECTOR.P  ( INPUT-OUTPUT rid_tabla, 
                           INPUT YES, 
                           INPUT Sre_header.nro_area ).
  IF rid_tabla <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_tabla NO-LOCK.
       DISPLAY Articulo.cdg_articulo @ v-cdg_articulo
               WITH  FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
  END.       
  RETURN NO-APPLY.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON RETURN OF v-cdg_articulo IN FRAME F-Main /* Artículo */
DO:
    DEFINE VARIABLE hay_error AS LOGICAL.

    RUN validar_articulo ( OUTPUT articulo_error ).
    IF NOT articulo_error
    THEN DO:
        RUN poner_articulo.
        v-cdg_articulo:SENSITIVE IN FRAME {&FRAME-NAME} = NO. 
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
  {src/adm/template/row-list.i "Sre_detalle"}
  {src/adm/template/row-list.i "Sre_header"}
  {src/adm/template/row-list.i "Articulo"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Sre_detalle"}
  {src/adm/template/row-find.i "Sre_header"}
  {src/adm/template/row-find.i "Articulo"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cantidad-granel V-table-Win 
PROCEDURE cantidad-granel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ASSIGN Sre_detalle.granel:SENSITIVE IN FRAME {&FRAME-NAME} = Articulo.granel_pesado .

  IF NOT Sre_detalle.granel:SENSITIVE IN FRAME {&FRAME-NAME} 
      THEN Sre_detalle.granel:SCREEN-VALUE = "".

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

  /* Code placed here will execute PRIOR to standard behavior. */

  {blanqueacodigo.i "Articulo"}

  Sre_detalle.modo_etiquetas:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
 
  es_alta = YES.

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

  /* Code placed here will execute PRIOR to standard behavior. */
  
   DEFINE BUFFER B-Sre_detalle FOR Sre_detalle.
  
   DEFINE VARIABLE hay_error AS LOGICAL.


   IF NOT NEW Sre_detalle 
   THEN DO:
       FIND Articulo OF Sre_detalle NO-LOCK.
       IF Articulo.cdg_articulo <> INPUT FRAME {&FRAME-NAME} v-cdg_articulo 
       THEN DO:
           IF Articulo.es_registrable 
           THEN DO:
               FIND FIRST Registrable-solicitud WHERE Registrable-solicitud.nro_linea = Sre_detalle.nro_linea AND
                                                      Registrable-solicitud.nro_solicitud = Sre_detalle.nro_solicitud NO-LOCK NO-ERROR.
               IF AVAILABLE Registrable-solicitud
               THEN DO:
                   RUN PONMENSJ.P (INPUT "SRET030").
                   RETURN ERROR.
               END.
           END.
       END.
   END.

  RUN validar_articulo ( OUTPUT articulo_error ).
  IF articulo_error THEN RETURN ERROR.

  IF CAN-FIND(FIRST B-Sre_detalle
                     WHERE B-Sre_detalle.nro_articulo    = Articulo.nro_articulo
                       AND B-Sre_detalle.nro_solicitud   = Sre_header.nro_solicitud
                       AND ROWID(B-Sre_detalle) <> ROWID(Sre_detalle))
  THEN DO:
       RUN PONMENSJ.P (INPUT "SRET000").
       RETURN ERROR.
  END.

   IF INPUT FRAME {&FRAME-NAME} Sre_detalle.cantidad = 0 
       AND INPUT FRAME {&FRAME-NAME} Sre_detalle.granel = 0 THEN DO:
         RUN PONMENSJ.P (INPUT "SRET020").
         RETURN ERROR.
   END.

   FIND Motivo_retiro OF Sre_header. 
   
   IF INPUT FRAME {&FRAME-NAME} Sre_detalle.fecha_retorno = "" AND Motivo_retiro.con_regreso = YES              
   THEN DO:
      
         RUN PONMENSJ.P (INPUT "SRET010").
         RETURN ERROR.
   END. 

   RUN validar_fechas.p ( INPUT Sre_header.fecha_retiro,
                                INPUT INPUT FRAME {&FRAME-NAME} Sre_detalle.fecha_retorno,
                                INPUT "SRET007,SRET017",
                                OUTPUT rc ).
   IF rc <> 0 THEN RETURN ERROR.


   FIND LAST B-Sre_detalle WHERE B-Sre_detalle.nro_solicitud = Sre_header.nro_solicitud NO-LOCK NO-ERROR.

   IF AVAILABLE B-Sre_detalle THEN
        v-detalle_linea = B-Sre_detalle.nro_linea + 1.
   ELSE v-detalle_linea = 1.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   IF NEW Sre_detalle THEN DO:
      ASSIGN
      Sre_detalle.nro_solicitud = Sre_header.nro_solicitud
      Sre_detalle.nro_linea     = v-detalle_linea
      Sre_detalle.cdg_estado = "XX".

   END.
   ELSE v-modificar = YES.

   &SCOPED-DEFINE TABLA-MAESTRA  Sre_detalle

   {asignartabla.i "Articulo" "nro_articulo" "nro_articulo"} 

   &UNDEFINE TABLA-MAESTRA

   ASSIGN 
       Sre_detalle.observacion
       Sre_detalle.detallada
       Sre_detalle.modo_etiquetas.

      v-refrescar = YES.

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


   IF CAN-FIND(FIRST Registrable-solicitud 
                     WHERE Registrable-solicitud.nro_solicitud = Sre_detalle.nro_solicitud
                       AND Registrable-solicitud.nro_linea     = Sre_detalle.nro_linea) THEN DO:
        RUN PONMENSJ.P ( "SRET005" ).
        RETURN ERROR.
   END.     

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

      DEFINE VARIABLE page-hdl      AS HANDLE.
      DEFINE VARIABLE c-handle      AS CHARACTER.
    
      RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'CONTAINER-SOURCE',OUTPUT c-handle).
    
      page-hdl = WIDGET-HANDLE(c-handle).
    
      IF VALID-HANDLE(page-hdl)
      THEN DO:

              FIND FIRST Sre_detalle OF Sre_header NO-LOCK NO-ERROR.
              IF NOT AVAILABLE Sre_detalle THEN 
                  RUN set-estado-registrables IN page-hdl ( NO ).
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

  {deshabcodigo.i "Articulo"} 

   Sre_detalle.observacion:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   Sre_detalle.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

   Sre_detalle.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   Sre_detalle.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

   Sre_detalle.modo_etiquetas:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

   es_alta = NO.

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

  IF AVAILABLE Sre_detalle
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Sre_detalle

        {displaytabla.i "Articulo" "cdg_articulo" "descripcion" "nro_articulo" "nro_articulo"} 

  END.

/*------------------------------------------------------------------------*/

  IF v-refrescar THEN DO:  /*Lo habilito en assign-statment*/

  v-contar_displ-flds = v-contar_displ-flds + 1.

      IF v-contar_displ-flds = 3 OR
         v-modificar THEN DO:  /*nesecito ingresar la 3ra. vez que ejecuta el display-fields (es cuando estoy parado sobre el registro que deseo)*/

          DEFINE VARIABLE es_header AS LOGICAL INITIAL NO. /*el include difiere en el código si es Sre_header o Sre_detalle*/
          {hab_panel_folder.i}

          v-refrescar = NO.
          v-contar_displ-flds = 0.
          v-modificar = NO.
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

  {habilcodigo.i "Articulo"}

  IF NOT es_alta
  THEN DO:
      Sre_detalle.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = Articulo.extendida.
      Sre_detalle.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = IF Articulo.extendida THEN 9 ELSE 7.
      Sre_detalle.modo_etiquetas:SENSITIVE IN FRAME {&FRAME-NAME} = Articulo.modo_etiquetas = "I".
      RUN cantidad-granel.
  END.

  FIND Motivo_retiro OF Sre_header NO-LOCK NO-ERROR.
  Sre_detalle.fecha_retorno:SENSITIVE IN FRAME {&FRAME-NAME} = Motivo_retiro.con_regreso.
   
  Sre_detalle.observacion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  Sre_detalle.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_articulo V-table-Win 
PROCEDURE poner_articulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   
   Sre_detalle.modo_etiquetas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Articulo.modo_etiquetas.
   Sre_detalle.modo_etiquetas:SENSITIVE IN FRAME {&FRAME-NAME} = Articulo.modo_etiquetas = "I".
   IF Articulo.extendida 
   THEN DO:
       Sre_detalle.detallada:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Articulo.detallada.
       Sre_detalle.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
       Sre_detalle.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 9.
   END.
   ELSE DO:
       Sre_detalle.detallada:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       Sre_detalle.detallada:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
       Sre_detalle.detallada:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

   END.
   RUN cantidad-granel.

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
  {src/adm/template/snd-list.i "Sre_detalle"}
  {src/adm/template/snd-list.i "Sre_header"}
  {src/adm/template/snd-list.i "Articulo"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_articulo V-table-Win 
PROCEDURE validar_articulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-error AS LOGICAL.

  FIND Articulo WHERE Articulo.cdg_articulo = INPUT FRAME {&FRAME-NAME} v-cdg_Articulo NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Articulo 
  THEN DO:
        RUN PONMENSJ.P ( INPUT "SRET014" ).
        p-error = YES.
        RETURN ERROR.
  END.
  ELSE DO:
      IF NOT CAN-DO(Articulo.lista_empresas, Empresa.cdg_empresa) 
      THEN DO:
            RUN PONMENSJ.P ( INPUT "SRET031" ).
            p-error = YES.
            RETURN ERROR.
      END.

      IF NOT CAN-DO(Articulo.lista_sectores, Area.cdg_area) 
      THEN DO:
            RUN PONMENSJ.P ( INPUT "SRET031" ).
            p-error = YES.
            RETURN ERROR.
      END.
  END.
        
  v-dsc_Articulo = Articulo.descripcion.
  DISPLAY v-dsc_articulo WITH FRAME {&FRAME-NAME}.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

