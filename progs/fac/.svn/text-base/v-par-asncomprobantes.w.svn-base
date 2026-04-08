&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
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

  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-des_ptovta v-ver_resum v-gen_asiento ~
v-ver_movim v-has_ptovta v-lis_fecha v-lista_tipos v-fecha_contable RECT-1 ~
RECT-2 
&Scoped-Define DISPLAYED-OBJECTS v-des_ptovta v-ver_resum v-gen_asiento ~
v-ver_movim v-has_ptovta v-lis_fecha v-lista_tipos v-fecha_contable 

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
DEFINE VARIABLE v-lista_tipos AS CHARACTER FORMAT "X(256)":U 
     LABEL "Comprobante" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 48 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-des_ptovta AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Desde Pto.Vta." 
     VIEW-AS FILL-IN 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-fecha_contable AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 12 BY .77
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-has_ptovta AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Hasta Pto.Vta." 
     VIEW-AS FILL-IN 
     SIZE 12 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-gen_asiento AS CHARACTER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "No Generar", "No Generado",
"Resumido", "Resumido",
"Detallado", "Detallado"
     SIZE 13 BY 2.15 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 66 BY 3.77.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 22 BY 3.77.

DEFINE VARIABLE v-lis_fecha AS LOGICAL INITIAL no 
     LABEL "Fecha y Hora" 
     VIEW-AS TOGGLE-BOX
     SIZE 15 BY .5 NO-UNDO.

DEFINE VARIABLE v-ver_movim AS LOGICAL INITIAL no 
     LABEL "Ver Movimientos" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .5 NO-UNDO.

DEFINE VARIABLE v-ver_resum AS LOGICAL INITIAL no 
     LABEL "Ver Resumen" 
     VIEW-AS TOGGLE-BOX
     SIZE 15 BY .5 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-des_ptovta AT ROW 1.27 COL 16 COLON-ALIGNED
     v-ver_resum AT ROW 1.27 COL 36
     v-gen_asiento AT ROW 1.27 COL 76 NO-LABEL
     v-ver_movim AT ROW 2.08 COL 36
     v-has_ptovta AT ROW 2.62 COL 16 COLON-ALIGNED
     v-lis_fecha AT ROW 2.88 COL 36
     v-lista_tipos AT ROW 3.69 COL 16 COLON-ALIGNED
     v-fecha_contable AT ROW 3.69 COL 74 COLON-ALIGNED
     RECT-1 AT ROW 1 COL 1
     RECT-2 AT ROW 1 COL 68
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
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
         HEIGHT             = 6.08
         WIDTH              = 92.14.
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

&Scoped-define SELF-NAME v-fecha_contable
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_contable V-table-Win
ON MOUSE-MENU-DOWN OF v-fecha_contable IN FRAME F-Main /* Fecha */
DO:

  fecha_inicial = DATE(v-fecha_contable:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-fecha_contable 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-lista_tipos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-lista_tipos V-table-Win
ON VALUE-CHANGED OF v-lista_tipos IN FRAME F-Main /* Comprobante */
DO:
  ASSIGN v-lista_tipos.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-ver_movim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-ver_movim V-table-Win
ON VALUE-CHANGED OF v-ver_movim IN FRAME F-Main /* Ver Movimientos */
DO:
    IF NOT v-ver_movim:INPUT-VALUE 
    THEN DO:
        v-ver_resum = YES.
        DISPLAY v-ver_resum
                WITH FRAME {&FRAME-NAME}.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-ver_resum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-ver_resum V-table-Win
ON VALUE-CHANGED OF v-ver_resum IN FRAME F-Main /* Ver Resumen */
DO:
  IF NOT v-ver_resum:INPUT-VALUE 
  THEN DO:
      v-ver_movim = YES.
      DISPLAY v-ver_movim
              WITH FRAME {&FRAME-NAME}.
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE dar_rango V-table-Win 
PROCEDURE dar_rango :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-des_ptovta      AS INTEGER.
  DEFINE OUTPUT PARAMETER p-has_ptovta      AS INTEGER.
  DEFINE OUTPUT PARAMETER p-lista_tipos     AS CHARACTER.
  DEFINE OUTPUT PARAMETER p-lis_fecha       AS LOGICAL.
  DEFINE OUTPUT PARAMETER p-gen_asiento     AS CHARACTER.
  DEFINE OUTPUT PARAMETER p-ver_movim       AS LOGICAL.
  DEFINE OUTPUT PARAMETER p-ver_resum       AS LOGICAL.
  DEFINE OUTPUT PARAMETER p-fecha_contable  LIKE Asn_header.fecha.
  DEFINE OUTPUT PARAMETER error_rango       AS LOGICAL.

  error_rango = NO.
  
  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN 
        v-des_ptovta      
        v-has_ptovta
        v-lista_tipos      
        v-lis_fecha
        v-gen_asiento
        v-ver_movim
        v-ver_resum
        v-fecha_contable.

     IF v-des_ptovta > v-has_ptovta THEN error_rango = YES.

     ASSIGN
        p-des_ptovta     = v-des_ptovta    
        p-has_ptovta     = v-has_ptovta    
        p-lista_tipos    = v-lista_tipos    
        p-lis_fecha      = v-lis_fecha 
        p-gen_asiento    = v-gen_asiento
        p-ver_movim      = v-ver_movim
        p-ver_resum      = v-ver_resum
        p-fecha_contable = v-fecha_contable.

  END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fijar_lista V-table-Win 
PROCEDURE fijar_lista :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-lista AS CHARACTER.
  
  v-lista_tipos = p-lista.

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
  
   v-ver_movim = YES.
   v-ver_resum = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DEFINE VARIABLE x-lista AS CHARACTER.
   x-lista = "[Todos],*".
   FOR EACH Tipocomprobante WHERE Tipocomprobante.cdg_ciclocomercial = "Ventas":
       x-lista = x-lista + "," + Tipocomprobante.dsc_comprobante + "," + Tipocomprobante.cdg_comprobante.
   END.
   v-lista_tipos:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = x-lista.

   v-lista_tipos = ENTRY(2,v-lista_tipos:LIST-ITEM-PAIRS,",").
   DISPLAY v-lista_tipos
           v-ver_movim
           v-ver_resum
           WITH FRAME {&FRAME-NAME}.

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

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartViewer, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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

