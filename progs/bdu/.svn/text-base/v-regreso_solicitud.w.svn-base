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

DEFINE BUFFER B-Sre_header  FOR Sre_header.
DEFINE BUFFER B-Sre_detalle FOR Sre_detalle.

DEFINE VARIABLE es_alta AS LOGICAL.

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
&Scoped-define EXTERNAL-TABLES Regreso_solicitud Sre_detalle
&Scoped-define FIRST-EXTERNAL-TABLE Regreso_solicitud


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Regreso_solicitud, Sre_detalle.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Regreso_solicitud.fecha_retorno ~
Regreso_solicitud.cantidad Regreso_solicitud.granel ~
Regreso_solicitud.modo_cumplimiento Regreso_solicitud.tip_comprob ~
Regreso_solicitud.prf_comprob Regreso_solicitud.nro_comprob ~
Regreso_solicitud.nro_ocm 
&Scoped-define ENABLED-TABLES Regreso_solicitud
&Scoped-define FIRST-ENABLED-TABLE Regreso_solicitud
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Regreso_solicitud.fecha_retorno ~
Regreso_solicitud.cantidad Regreso_solicitud.granel ~
Regreso_solicitud.modo_cumplimiento Regreso_solicitud.tip_comprob ~
Regreso_solicitud.prf_comprob Regreso_solicitud.nro_comprob ~
Regreso_solicitud.nro_ocm 
&Scoped-define DISPLAYED-TABLES Regreso_solicitud
&Scoped-define FIRST-DISPLAYED-TABLE Regreso_solicitud


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
tip_comprob||y|sic.Regreso_solicitud.tip_comprob
nro_solicitud||y|sic.Regreso_solicitud.nro_solicitud
nro_usuario||y|sic.Regreso_solicitud.nro_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "tip_comprob,nro_solicitud,nro_usuario"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 58 BY 11.43.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Regreso_solicitud.fecha_retorno AT ROW 2.67 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Regreso_solicitud.cantidad AT ROW 2.67 COL 39 COLON-ALIGNED
          LABEL "Cantidad"
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Regreso_solicitud.granel AT ROW 3.86 COL 39 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Regreso_solicitud.modo_cumplimiento AT ROW 6 COL 10 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Cumplido", "C":U,
"Finalizado", "D":U
          SIZE 47 BY .95
     Regreso_solicitud.tip_comprob AT ROW 8.19 COL 13 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN NATIVE 
          SIZE 8.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Regreso_solicitud.prf_comprob AT ROW 8.19 COL 23 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Regreso_solicitud.nro_comprob AT ROW 8.19 COL 32 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Regreso_solicitud.nro_ocm AT ROW 11.1 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 42 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-7 AT ROW 1 COL 1
     "        Comprobante con el que se cumple la solicitud" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 7.1 COL 2
          BGCOLOR 5 FGCOLOR 15 
     "        Orden de Compra con la que se relaciona el ingreso" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 9.71 COL 2
          BGCOLOR 5 FGCOLOR 15 
     "             Retorno de artículos de la solicitud seleccionada" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 1.48 COL 2
          BGCOLOR 5 FGCOLOR 15 
     "                            Modo de cumplimiento" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 5.05 COL 2
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Regreso_solicitud,sic.Sre_detalle
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
         HEIGHT             = 13.19
         WIDTH              = 66.
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

/* SETTINGS FOR FILL-IN Regreso_solicitud.cantidad IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Regreso_solicitud.tip_comprob IN FRAME F-Main
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

&Scoped-define SELF-NAME Regreso_solicitud.fecha_retorno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Regreso_solicitud.fecha_retorno V-table-Win
ON MOUSE-MENU-DOWN OF Regreso_solicitud.fecha_retorno IN FRAME F-Main /* Regresa el */
DO:
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

  fecha_inicial = DATE(Regreso_solicitud.fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ Regreso_solicitud.fecha_retorno 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Regreso_solicitud.fecha_retorno V-table-Win
ON RETURN OF Regreso_solicitud.fecha_retorno IN FRAME F-Main /* Regresa el */
DO:
  IF DATE(Regreso_solicitud.fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME}) = DATE("")
  THEN DO:
       Regreso_solicitud.fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(TODAY).
/*        DISPLAY Regreso_solicitud.fecha_retorno */
/*                WITH FRAME {&FRAME-NAME}.       */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE actualizar-browse V-table-Win 
PROCEDURE actualizar-browse :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE v-handle AS CHARACTER.
  DEFINE VARIABLE h_handle AS HANDLE.

  RUN get-link-handle IN adm-broker-hdl (THIS-PROCEDURE,'container-source',OUTPUT v-handle).

  h_handle = WIDGET-HANDLE(v-handle).

  IF VALID-HANDLE(h_handle) THEN
      RUN actualizar-browse IN h_handle.      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE actualizar-estado V-table-Win 
PROCEDURE actualizar-estado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE v-handle AS CHARACTER.
  DEFINE VARIABLE h_handle AS HANDLE.

  RUN get-link-handle IN adm-broker-hdl (THIS-PROCEDURE,'container-source',OUTPUT v-handle).

  h_handle = WIDGET-HANDLE(v-handle).

  IF VALID-HANDLE(h_handle) THEN
      RUN actualizar-estado IN h_handle (INPUT YES).      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  {src/adm/template/row-list.i "Regreso_solicitud"}
  {src/adm/template/row-list.i "Sre_detalle"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Regreso_solicitud"}
  {src/adm/template/row-find.i "Sre_detalle"}

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

  /* Code placed here will execute PRIOR to standard behavior. */

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

  DEFINE BUFFER B-Regreso_solicitud FOR Regreso_solicitud.
  DEFINE VARIABLE v-cantidad AS INTEGER.
  DEFINE VARIABLE v-granel   AS DECIMAL.

  IF Regreso_solicitud.fecha_retorno:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
  THEN DO:
       RUN PONMENSJ.P (INPUT "CUSO001").
       RETURN ERROR.
  END.

  IF INPUT FRAME {&FRAME-NAME} Regreso_solicitud.cantidad = 0
      AND INPUT FRAME {&FRAME-NAME} Regreso_solicitud.granel = 0
  THEN DO:
       RUN PONMENSJ.P (INPUT "CUSO002").
       RETURN ERROR.
  END.

  FOR EACH B-Regreso_solicitud WHERE B-Regreso_solicitud.nro_solicitud = Sre_detalle.nro_solicitud
                                 AND B-Regreso_solicitud.nro_linea = Sre_detalle.nro_linea:
        v-cantidad = v-cantidad + B-Regreso_solicitud.cantidad.
        v-granel   = v-granel + B-Regreso_solicitud.granel.
  END.

  IF es_alta 
  THEN DO: 
      v-cantidad = v-cantidad + INPUT FRAME {&FRAME-NAME} Regreso_solicitud.cantidad.
      v-granel   = v-granel + INPUT FRAME {&FRAME-NAME} Regreso_solicitud.granel.
  END.
  ELSE DO:
      v-cantidad = v-cantidad - Regreso_solicitud.cantidad + INPUT FRAME {&FRAME-NAME} Regreso_solicitud.cantidad.
      v-granel   = v-granel - Regreso_solicitud.granel + INPUT FRAME {&FRAME-NAME} Regreso_solicitud.granel.
  END.

  IF v-cantidad > Sre_detalle.cantidad OR
       v-granel > Sre_detalle.granel
  THEN DO:
       RUN PONMENSJ.P (INPUT "CUSO003").
       RETURN ERROR.
  END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN
    Regreso_solicitud.nro_solicitud = Sre_detalle.nro_solicitud
    Regreso_solicitud.nro_linea     = Sre_detalle.nro_linea.

  FIND CURRENT Sre_detalle EXCLUSIVE-LOCK.
  IF v-cantidad = Sre_detalle.cantidad AND v-granel = Sre_detalle.granel 
  THEN DO:
      Sre_detalle.cumplido = YES.
      Sre_detalle.cdg_estado = "CU".
  END.
  ELSE DO:
      Sre_detalle.cumplido = NO.
      Sre_detalle.cdg_estado = "PR".
  END.

  FIND CURRENT Sre_detalle NO-LOCK.

  FIND Sre_header OF Sre_detalle EXCLUSIVE-LOCK.
  IF NOT CAN-FIND(Sre_detalle OF Sre_header WHERE NOT Sre_detalle.cumplido)
  THEN DO:
      Sre_header.cumplido = YES.
      Sre_header.cdg_estado = "CU".
      
      FIND Articulo OF Sre_detalle NO-LOCK NO-ERROR.
      IF Articulo.es_registrable THEN DO:
          FOR EACH Registrable-solicitud OF Sre_detalle:
                  FIND Registrable OF Registrable-solicitud EXCLUSIVE-LOCK.
                  Registrable.disponible = YES.
                  CREATE Hst_estadoregis.
                  ASSIGN 
                      Hst_estadoregis.cdg_estadoregis = "00001"
                      Hst_estadoregis.fch_cambio      = TODAY
                      Hst_estadoregis.hms_cambio      = STRING(TIME,"HH:MM:SS")
                      Hst_estadoregis.hor_cambio      = TIME
                      Hst_estadoregis.nro_registrable = Registrable.nro_registrable
                      Hst_estadoregis.nro_usuario     = Usuario.nro_usuario.

                  FIND Registrable OF Registrable-solicitud NO-LOCK.
          END.
      END.
  END.
  ELSE DO:
      Sre_header.cumplido = NO.
      Sre_header.cdg_estado = "PR".

      FIND Articulo OF Sre_detalle NO-LOCK NO-ERROR.
      IF Articulo.es_registrable THEN DO:
          FOR EACH Registrable-solicitud OF Sre_detalle:
                  FIND Registrable OF Registrable-solicitud EXCLUSIVE-LOCK.
                  Registrable.disponible = NO.
                  CREATE Hst_estadoregis.
                  ASSIGN 
                      Hst_estadoregis.cdg_estadoregis = "00002"
                      Hst_estadoregis.fch_cambio      = TODAY
                      Hst_estadoregis.hms_cambio      = STRING(TIME,"HH:MM:SS")
                      Hst_estadoregis.hor_cambio      = TIME
                      Hst_estadoregis.nro_registrable = Registrable.nro_registrable
                      Hst_estadoregis.nro_usuario     = Usuario.nro_usuario.

                  FIND Registrable OF Registrable-solicitud NO-LOCK.
          END.
      END.
  END.
  FIND Sre_header OF Sre_detalle NO-LOCK.

  RUN actualizar-estado.

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

  FIND CURRENT Sre_detalle EXCLUSIVE-LOCK.
  Sre_detalle.cumplido = NO.
  Sre_detalle.cdg_estado = "PR".
  FIND CURRENT Sre_detalle NO-LOCK.

  FIND Sre_header OF Sre_detalle EXCLUSIVE-LOCK.
  Sre_header.cumplido = NO.
  Sre_header.cdg_estado = "PR".
  FIND Sre_header OF Sre_detalle NO-LOCK.

  FIND Articulo OF Sre_detalle NO-LOCK NO-ERROR.
  IF Articulo.es_registrable THEN DO:
      FOR EACH Registrable-solicitud OF Sre_detalle:
              FIND Registrable OF Registrable-solicitud EXCLUSIVE-LOCK.
              Registrable.disponible = NO.
              CREATE Hst_estadoregis.
              ASSIGN 
                  Hst_estadoregis.cdg_estadoregis = "00002"
                  Hst_estadoregis.fch_cambio      = TODAY
                  Hst_estadoregis.hms_cambio      = STRING(TIME,"HH:MM:SS")
                  Hst_estadoregis.hor_cambio      = TIME
                  Hst_estadoregis.nro_registrable = Registrable.nro_registrable
                  Hst_estadoregis.nro_usuario     = Usuario.nro_usuario.

              FIND Registrable OF Registrable-solicitud NO-LOCK.
      END.
  END.
           
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN actualizar-estado.

  RUN actualizar-browse.

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
  
  es_alta = NO.

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

   FIND Articulo OF Sre_detalle NO-LOCK NO-ERROR.

   IF Articulo.granel_pesado THEN  

       ASSIGN
            Regreso_solicitud.granel:SENSITIVE IN FRAME {&FRAME-NAME}   = YES
            Regreso_solicitud.cantidad:SENSITIVE IN FRAME {&FRAME-NAME} = NO
            Regreso_solicitud.cantidad:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
     

   ELSE 
       ASSIGN
            Regreso_solicitud.granel:SENSITIVE IN FRAME {&FRAME-NAME}   = NO
            Regreso_solicitud.cantidad:SENSITIVE IN FRAME {&FRAME-NAME} = YES
            Regreso_solicitud.granel:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       

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

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {findempresa.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "tip_comprob" "Regreso_solicitud" "tip_comprob"}
  {src/adm/template/sndkycas.i "nro_solicitud" "Regreso_solicitud" "nro_solicitud"}
  {src/adm/template/sndkycas.i "nro_usuario" "Regreso_solicitud" "nro_usuario"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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
  {src/adm/template/snd-list.i "Regreso_solicitud"}
  {src/adm/template/snd-list.i "Sre_detalle"}

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

