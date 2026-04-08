&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
          custom           PROGRESS
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

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Tanques Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Tanques


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tanques, Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tanques.cdg_tanque Tanques.tipo_tanque ~
Tanques.Alto Tanques.Ancho Tanques.Profundidad Tanques.Desagote ~
Tanques.Estado_Colector Tanques.Automatico Tanques.Medida_Valvula_Limpieza ~
Tanques.Flotante Tanques.Observaciones 
&Scoped-define ENABLED-TABLES Tanques
&Scoped-define FIRST-ENABLED-TABLE Tanques
&Scoped-Define ENABLED-OBJECTS RECT-1 
&Scoped-Define DISPLAYED-FIELDS Tanques.cdg_tanque Tanques.tipo_tanque ~
Tanques.Alto Tanques.Ancho Tanques.Profundidad Tanques.Desagote ~
Tanques.Estado_Colector Tanques.Automatico Tanques.Medida_Valvula_Limpieza ~
Tanques.Flotante Tanques.Observaciones 
&Scoped-define DISPLAYED-TABLES Tanques
&Scoped-define FIRST-DISPLAYED-TABLE Tanques


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
nro_cliente||y|sic.Tanques.nro_cliente
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_cliente"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 82 BY 7.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Tanques.cdg_tanque AT ROW 1.14 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.4 BY 1 TOOLTIP "Identificación del tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.tipo_tanque AT ROW 1.14 COL 44 COLON-ALIGNED
          VIEW-AS COMBO-BOX 
          LIST-ITEM-PAIRS "Cisterna","C",
                     "Reserva","R",
                     "Intermediario","I"
          DROP-DOWN-LIST
          SIZE 34.6 BY 1 TOOLTIP "Tipo de tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Alto AT ROW 2.1 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.4 BY 1 TOOLTIP "Altura del tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Ancho AT ROW 2.1 COL 44 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.4 BY 1 TOOLTIP "Ancho del tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Profundidad AT ROW 2.1 COL 68 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10.4 BY 1 TOOLTIP "Profundidad del tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Desagote AT ROW 3.14 COL 19 COLON-ALIGNED
          VIEW-AS COMBO-BOX 
          LIST-ITEM-PAIRS "Sin Especificar","-",
                     "Bomba y Manguera Larga","BO",
                     "Calle","CA",
                     "Cloaca","CL",
                     "Pozo de Achique","PO"
          DROP-DOWN-LIST
          SIZE 32 BY 1 TOOLTIP "Tipo de desagote del tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Estado_Colector AT ROW 3.14 COL 65 COLON-ALIGNED
          VIEW-AS COMBO-BOX 
          LIST-ITEMS "-","Bueno","Malo" 
          DROP-DOWN-LIST
          SIZE 13.6 BY 1 TOOLTIP "Estado del colector"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Automatico AT ROW 4.19 COL 19 COLON-ALIGNED
          VIEW-AS COMBO-BOX 
          LIST-ITEM-PAIRS "Sin Auto","-",
                     "Varilla","VA",
                     "Tanza","TA",
                     "Bocha","BO"
          DROP-DOWN-LIST
          SIZE 12.6 BY 1 TOOLTIP "Mecanismo de accionamiento del automático"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Medida_Valvula_Limpieza AT ROW 4.19 COL 47 COLON-ALIGNED
          LABEL "Medida Válv."
          VIEW-AS FILL-IN NATIVE 
          SIZE 9 BY 1 TOOLTIP "Medida de la válvula de limpieza del tanque"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Flotante AT ROW 4.19 COL 68 COLON-ALIGNED
          VIEW-AS COMBO-BOX 
          LIST-ITEMS "-","1/2","3/4","1","1 1/2","2","2 1/2","3" 
          DROP-DOWN-LIST
          SIZE 10.6 BY 1 TOOLTIP "Medida del flotante"
          BGCOLOR 15 FGCOLOR 9 
     Tanques.Observaciones AT ROW 5.24 COL 2 NO-LABEL WIDGET-ID 4
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 79 BY 3.33
          BGCOLOR 15 FGCOLOR 8 
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tanques,sic.Cliente
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
         HEIGHT             = 8
         WIDTH              = 82.8.
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

/* SETTINGS FOR FILL-IN Tanques.Medida_Valvula_Limpieza IN FRAME F-Main
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

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
  &ENDIF         
  
  /************************ INTERNAL PROCEDURES ********************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  {src/adm/template/row-list.i "Tanques"}
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tanques"}
  {src/adm/template/row-find.i "Cliente"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
 DEFINE VARIABLE hubo_error      AS LOGICAL.
 DEFINE BUFFER B-Tanques FOR Tanques.   
    IF INPUT FRAME {&FRAME-NAME} Tanques.cdg_tanque = ""  
    THEN DO:
         RUN PONMENSJ.P (INPUT "USR_011").
         RETURN ERROR.
    END.    
    IF NEW tanques
    THEN DO:
      IF CAN-FIND(FIRST B-Tanques WHERE b-tanques.nro_cliente = cliente.nro_cliente AND B-Tanques.cdg_tanque = 
                           INPUT FRAME {&FRAME-NAME} Tanques.cdg_tanque )
        THEN DO:
             RUN PONMENSJ.P (INPUT "USR_007").
             RETURN ERROR.
        END.
    END.

    IF  DECIMAL( INPUT FRAME {&FRAME-NAME} Tanques.alto ) = 0  OR
        DECIMAL( INPUT FRAME {&FRAME-NAME} Tanques.ancho ) = 0 OR
        DECIMAL( INPUT FRAME {&FRAME-NAME} Tanques.profundidad ) = 0 
    THEN DO:
         RUN PONMENSJ.P (INPUT "USR_012").
         RETURN ERROR.
    END.          

  /* Code placed here will execute PRIOR to standard behavior. */
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  IF NEW tanques THEN
     ASSIGN tanques.nro_tanque = NEXT-VALUE(proximo_nro_tanque)
                            tanques.nro_cliente = cliente.nro_cliente.
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
DEF VAR opt AS LOGICAL NO-UNDO.
MESSAGE "Esta Seguro de dar de Baja este Tanque"
    VIEW-AS ALERT-BOX INFO BUTTONS OK UPDATE opt.
IF NOT opt  THEN  RETURN NO-APPLY.
    
FOR EACH tanque_tapa WHERE tanques.nro_tanque = tanque_tapa.nro_tanque:
     DELETE tanque_tapa.
END.


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
  Tanques.observaciones:FGCOLOR IN FRAME {&FRAME-NAME} = 8.
  Tanques.observaciones:SENSITIVE = NO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR h_estado AS HANDLE NO-UNDO.
DEF VAR ch_estado AS character NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
     RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE,
      INPUT "estado-target",
      OUTPUT ch_estado ).
     h_estado = WIDGET-HANDLE( ch_estado ).
     IF VALID-HANDLE(h_estado) THEN 
                  RUN set-sensitivo IN h_estado ( INPUT AVAILABLE tanques ).
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
  Tanques.observaciones:FGCOLOR IN FRAME {&FRAME-NAME} = 9.
  Tanques.observaciones:SENSITIVE = YES.
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
  {src/adm/template/sndkycas.i "nro_cliente" "Tanques" "nro_cliente"}

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
  {src/adm/template/snd-list.i "Tanques"}
  {src/adm/template/snd-list.i "Cliente"}

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

