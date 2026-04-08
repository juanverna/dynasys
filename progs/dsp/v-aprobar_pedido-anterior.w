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
{dfcamest.i}
DEFINE VARIABLE sino AS LOGICAL.

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
&Scoped-define EXTERNAL-TABLES Ped_header
&Scoped-define FIRST-EXTERNAL-TABLE Ped_header


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Ped_header.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS btn_aprobar btn_anular btn_rechazar ~
btn_acomercial btn_agerencia RECT-4 

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnpuede V-table-Win 
FUNCTION fnpuede RETURNS LOGICAL
  ( INPUT p-cdg_inicial AS CHARACTER, 
    INPUT p-cdg_final AS CHARACTER, 
    INPUT p-fecha AS DATE)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_acomercial 
     LABEL "A.&Comercial" 
     SIZE 18 BY 1.14
     FONT 4.

DEFINE BUTTON btn_agerencia 
     LABEL "A.&Gerencia" 
     SIZE 18 BY 1.14
     FONT 4.

DEFINE BUTTON btn_anular 
     LABEL "A&nular" 
     SIZE 18 BY 1.14
     FONT 4.

DEFINE BUTTON btn_aprobar 
     LABEL "&Aprobar" 
     SIZE 18 BY 1.14
     FONT 4.

DEFINE BUTTON btn_rechazar 
     LABEL "&Rechazar" 
     SIZE 18 BY 1.14
     FONT 4.

DEFINE VARIABLE v-observacion AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE .2 BY .1.

DEFINE VARIABLE v-observacion-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 1.6 BY .24.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 42 BY 4.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_aprobar AT ROW 1.24 COL 3.4
     btn_anular AT ROW 1.24 COL 22.4
     v-observacion-2 AT ROW 2.38 COL 21 NO-LABEL
     btn_rechazar AT ROW 2.67 COL 3.4
     btn_acomercial AT ROW 2.67 COL 22.4
     v-observacion AT ROW 3.86 COL 22.4 NO-LABEL
     btn_agerencia AT ROW 4.1 COL 3
     RECT-4 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Ped_header
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
         HEIGHT             = 5.38
         WIDTH              = 42.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{setsensitivo.i}
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
       FRAME F-Main:SCROLLABLE       = FALSE.

/* SETTINGS FOR FILL-IN v-observacion IN FRAME F-Main
   NO-DISPLAY NO-ENABLE ALIGN-L                                         */
ASSIGN 
       v-observacion:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN v-observacion-2 IN FRAME F-Main
   NO-DISPLAY NO-ENABLE ALIGN-L                                         */
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

&Scoped-define SELF-NAME btn_acomercial
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_acomercial V-table-Win
ON CHOOSE OF btn_acomercial IN FRAME F-Main /* A.Comercial */
DO:
    RUN procesar_pedidos IN THIS-PROCEDURE ( INPUT "IC" ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_agerencia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_agerencia V-table-Win
ON CHOOSE OF btn_agerencia IN FRAME F-Main /* A.Gerencia */
DO:
    RUN procesar_pedidos IN THIS-PROCEDURE ( INPUT "GE" ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular V-table-Win
ON CHOOSE OF btn_anular IN FRAME F-Main /* Anular */
DO:
    sino = NO.
    MESSAGE "Desea ANULAR este pedido" 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE sino.
    IF sino
    THEN DO:
        RUN procesar_pedidos IN THIS-PROCEDURE ( INPUT "ZZ" ).
    END.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_aprobar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_aprobar V-table-Win
ON CHOOSE OF btn_aprobar IN FRAME F-Main /* Aprobar */
DO:
    sino = NO.
    MESSAGE "Desea aprobar este pedido" 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE sino.
    IF sino
    THEN DO:
        RUN procesar_pedidos IN THIS-PROCEDURE ( INPUT "AA" ).
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar V-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar */
DO:
    RUN procesar_pedidos IN THIS-PROCEDURE ( INPUT "IR" ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK V-table-Win 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN dispatch IN THIS-PROCEDURE ('initialize':U).  
    v-observacion:HIDDEN IN FRAME {&FRAME-NAME} = YES.
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
  {src/adm/template/row-list.i "Ped_header"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Ped_header"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_botones V-table-Win 
PROCEDURE habilitar_botones :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
 DEFINE VARIABLE v-btn_aprobar    AS LOGICAL.
 DEFINE VARIABLE v-btn_rechazar   AS LOGICAL.
 DEFINE VARIABLE v-btn_anular     AS LOGICAL.
 DEFINE VARIABLE v-btn_acomercial AS LOGICAL. 
 DEFINE VARIABLE v-btn_agerencia  AS LOGICAL.           
 
  DO WITH FRAME {&FRAME-NAME}:
    IF AVAILABLE Ped_header 
    THEN DO:
        
        v-btn_aprobar = fnpuede( INPUT Ped_header.cdg_estado, INPUT "AA", INPUT Ped_header.fecha).
        v-btn_rechazar = fnpuede( INPUT Ped_header.cdg_estado, INPUT "IR", INPUT Ped_header.fecha).
        v-btn_anular = fnpuede( INPUT Ped_header.cdg_estado, INPUT "ZZ", INPUT Ped_header.fecha).
        v-btn_acomercial = fnpuede( INPUT Ped_header.cdg_estado, INPUT "IC", INPUT Ped_header.fecha).
        v-btn_agerencia =  fnpuede( INPUT Ped_header.cdg_estado, INPUT "GE", INPUT Ped_header.fecha).


        ASSIGN
            btn_aprobar:SENSITIVE = LOOKUP(Ped_header.cdg_estado, "IN/IR/IC/GE", "/") <> 0 
                                     AND v-btn_aprobar
            btn_rechazar:SENSITIVE = LOOKUP(Ped_header.cdg_estado, "IN/IC/GE", "/") <> 0  
                                     AND v-btn_rechazar
            btn_anular:SENSITIVE = LOOKUP(Ped_header.cdg_estado, "IN/IR/IC/GE", "/") <> 0 
                                   AND v-btn_anular
            btn_acomercial:SENSITIVE = LOOKUP(Ped_header.cdg_estado, "IN/IR/GE", "/") <> 0 
                                       AND v-btn_acomercial
            btn_agerencia:SENSITIVE = LOOKUP(Ped_header.cdg_estado, "IN/IR/IC", "/") <> 0  
                                      AND v-btn_agerencia.
/*             btn_revertir:SENSITIVE = NO. /*LOOKUP(Ped_header.cdg_estado, "OO", "/") <> 0.  */  */
    END.
    ELSE DO:
        ASSIGN
            btn_aprobar:SENSITIVE = NO
            btn_rechazar:SENSITIVE = NO
            btn_anular:SENSITIVE = NO
            btn_acomercial:SENSITIVE = NO
            btn_agerencia:SENSITIVE = NO.

/*             btn_revertir:SENSITIVE = NO.  */
    END.    
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

  RUN habilitar_botones.

  v-observacion:HIDDEN IN FRAME {&FRAME-NAME} = YES.

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


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procesar_pedidos V-table-Win 
PROCEDURE procesar_pedidos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-cdg_estado LIKE Ped_header.cdg_estado.

    DEFINE VARIABLE c-link-hdls AS CHARACTER. 
    DEFINE VARIABLE h-link-hdl  AS WIDGET-HANDLE. 

    RUN get-link-handle IN adm-broker-hdl ( INPUT THIS-PROCEDURE ,
                                            INPUT "Record-Source",
                                            OUTPUT c-link-hdls /* CHARACTER */).
    h-link-hdl = WIDGET-HANDLE(c-link-hdls).
    IF VALID-HANDLE(h-link-hdl)
        THEN RUN procesar_pedidos IN h-link-hdl ( INPUT p-cdg_estado ).


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
  {src/adm/template/snd-list.i "Ped_header"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnpuede V-table-Win 
FUNCTION fnpuede RETURNS LOGICAL
  ( INPUT p-cdg_inicial AS CHARACTER, 
    INPUT p-cdg_final AS CHARACTER, 
    INPUT p-fecha AS DATE) :  

   DEFINE VARIABLE rc AS LOGICAL.
 
{findempresa.i}  

  FIND FIRST Autoriza_transaccion OF Usuario
           WHERE Autoriza_transaccion.cdg_empresa =        Empresa.cdg_empresa
             AND Autoriza_transaccion.cdg_estado_inicial = p-cdg_inicial 
             AND Autoriza_transaccion.cdg_estado_final = p-cdg_final
             AND Autoriza_transaccion.rige_desde <= p-fecha 
             AND Autoriza_transaccion.rige_hasta >= p-fecha
             AND Autoriza_transaccion.tabla_comprobante = "Ped_header"
                 NO-LOCK NO-ERROR.

  rc = AVAILABLE Autoriza_transaccion.
  /*
  MESSAGE 
  Empresa.cdg_empresa  
  p-cdg_inicial        
  p-cdg_final            
  p-fecha                     
  Usuario.cdg_usuario "avai" rc
          VIEW-AS ALERT-BOX INFO BUTTONS OK.
  */

  RETURN rc.
             
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

