&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
/*------------------------------------------------------------------------

  File:  

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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


  DEFINE VARIABLE que_empresa   LIKE Empresa.cdg_empresa.
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

  DEFINE VARIABLE sino          AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cuenta_bancaria
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta_bancaria


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta_bancaria.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cta_cte_bco

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cta_cte_bco.fecha_movimto ~
Cta_cte_bco.tip_comprob Cta_cte_bco.nro_comprob Cta_cte_bco.credito ~
Cta_cte_bco.debito Cta_cte_bco.leyenda 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Cta_cte_bco OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte_bco.nro_conciliacion <> 0 ~
 AND Cta_cte_bco.fecha_movimto >= v-des_fecha ~
 AND Cta_cte_bco.fecha_movimto <= v-has_fecha NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cta_cte_bco OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cta_cte_bco.nro_conciliacion <> 0 ~
 AND Cta_cte_bco.fecha_movimto >= v-des_fecha ~
 AND Cta_cte_bco.fecha_movimto <= v-has_fecha NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Cta_cte_bco
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cta_cte_bco


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-6 RECT-9 v-des_fecha v-has_fecha ~
btn_anular br_table 
&Scoped-Define DISPLAYED-OBJECTS v-des_fecha v-has_fecha 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
nro_transaccion||y|sic.Cta_cte_bco.nro_transaccion
nro_cheque||y|sic.Cta_cte_bco.nro_cheque
nro_regcta||y|sic.Cta_cte_bco.nro_regcta
nro_cuenta||y|sic.Cta_cte_bco.nro_cuenta
cdg_cuenta_ban||y|sic.Cta_cte_bco.cdg_cuenta_ban
nro_valor||y|sic.Cta_cte_bco.nro_valor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_transaccion,nro_cheque,nro_regcta,nro_cuenta,cdg_cuenta_ban,nro_valor"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_anular 
     LABEL "&Anular Conciliación" 
     SIZE 20 BY 1.19.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "Del" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/9999":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 12  NO-UNDO.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 91 BY 1.62.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 94 BY 21.43.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cta_cte_bco SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cta_cte_bco.fecha_movimto COLUMN-LABEL "Fecha!Movmto" FORMAT "99/99/99":U
      Cta_cte_bco.tip_comprob COLUMN-LABEL "Ti-!po" FORMAT "X(3)":U
            WIDTH 4.2
      Cta_cte_bco.nro_comprob COLUMN-LABEL "Número!Compbte" FORMAT "ZZZZZZZ9":U
      Cta_cte_bco.credito FORMAT "->,>>>,>>9.99":U WIDTH 15.8
      Cta_cte_bco.debito FORMAT "->,>>>,>>9.99":U WIDTH 16.2
      Cta_cte_bco.leyenda FORMAT "X(15)":U WIDTH 27.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN NO-ROW-MARKERS SIZE 91 BY 18.81
         BGCOLOR 15 FGCOLOR 9  EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-des_fecha AT ROW 1.48 COL 7 COLON-ALIGNED
     v-has_fecha AT ROW 1.48 COL 30 COLON-ALIGNED
     btn_anular AT ROW 1.48 COL 72
     br_table AT ROW 3.14 COL 2
     RECT-6 AT ROW 1.29 COL 2
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cuenta_bancaria
   Allow: Basic,Browse
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 22.76
         WIDTH              = 118.6.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{setsensitivo.i}
{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table btn_anular F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cta_cte_bco OF sic.Cuenta_bancaria"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Cta_cte_bco.nro_conciliacion <> 0
 AND Cta_cte_bco.fecha_movimto >= v-des_fecha
 AND Cta_cte_bco.fecha_movimto <= v-has_fecha"
     _FldNameList[1]   > sic.Cta_cte_bco.fecha_movimto
"Cta_cte_bco.fecha_movimto" "Fecha!Movmto" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Cta_cte_bco.tip_comprob
"Cta_cte_bco.tip_comprob" "Ti-!po" ? "character" ? ? ? ? ? ? no ? no no "4.2" yes no no "U" "" ""
     _FldNameList[3]   > sic.Cta_cte_bco.nro_comprob
"Cta_cte_bco.nro_comprob" "Número!Compbte" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Cta_cte_bco.credito
"Cta_cte_bco.credito" ? ? "decimal" ? ? ? ? ? ? no ? no no "15.8" yes no no "U" "" ""
     _FldNameList[5]   > sic.Cta_cte_bco.debito
"Cta_cte_bco.debito" ? ? "decimal" ? ? ? ? ? ? no ? no no "16.2" yes no no "U" "" ""
     _FldNameList[6]   > sic.Cta_cte_bco.leyenda
"Cta_cte_bco.leyenda" ? ? "character" ? ? ? ? ? ? no ? no no "27.6" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_anular
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_anular B-table-Win
ON CHOOSE OF btn_anular IN FRAME F-Main /* Anular Conciliación */
DO:
  IF AVAILABLE Cta_cte_bco
  THEN DO:
       sino = NO.
       MESSAGE "Realmente desea anular esta conciliación?" 
               VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
               TITLE "Se pide confirmación" UPDATE sino.
       IF sino 
       THEN DO:
            RUN anular_conciliacion.p ( INPUT Cta_cte_bco.nro_conciliacion ).
            RUN refrescar_browses.
            RUN dispatch IN THIS-PROCEDURE ('open-query':U).
       END.
  END.
  ELSE DO:
       RUN PONMENSJ.P ( INPUT "CONC005" ).
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME F-Main /* Del */
DO:

  fecha_inicial = DATE(v-des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON RETURN OF v-des_fecha IN FRAME F-Main /* Del */
DO:
  ASSIGN v-des_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME F-Main /* al */
DO:

  fecha_inicial = DATE(v-has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON RETURN OF v-has_fecha IN FRAME F-Main /* al */
DO:
  ASSIGN v-has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Cuenta_bancaria"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuenta_bancaria"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE listar_movimientos B-table-Win 
PROCEDURE listar_movimientos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  MESSAGE "Esta opción no está disponible"
          VIEW-AS ALERT-BOX MESSAGE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   v-des_fecha = TODAY.
   v-has_fecha = TODAY.
   
   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.

   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DISPLAY v-des_fecha
           v-has_fecha
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color B-table-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER fg_color AS INTEGER.
  DEFINE INPUT PARAMETER bg_color AS INTEGER.

  Cta_cte_bco.tip_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME}       = fg_color.
  Cta_cte_bco.nro_comprob:FGCOLOR IN BROWSE {&BROWSE-NAME}       = fg_color.
  Cta_cte_bco.fecha_movimto:FGCOLOR IN BROWSE {&BROWSE-NAME}     = fg_color.
  Cta_cte_bco.credito:FGCOLOR IN BROWSE {&BROWSE-NAME}           = fg_color.
  Cta_cte_bco.debito:FGCOLOR IN BROWSE {&BROWSE-NAME}            = fg_color.

  Cta_cte_bco.tip_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME}       = bg_color.
  Cta_cte_bco.nro_comprob:BGCOLOR IN BROWSE {&BROWSE-NAME}       = bg_color.
  Cta_cte_bco.fecha_movimto:BGCOLOR IN BROWSE {&BROWSE-NAME}     = bg_color.
  Cta_cte_bco.credito:BGCOLOR IN BROWSE {&BROWSE-NAME}           = bg_color.
  Cta_cte_bco.debito:BGCOLOR IN BROWSE {&BROWSE-NAME}            = bg_color.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refrescar_browses B-table-Win 
PROCEDURE refrescar_browses :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE h_smo AS HANDLE  NO-UNDO.  
    DEFINE VARIABLE ch    AS CHAR    NO-UNDO.
    DEFINE VARIABLE i     AS INTEGER NO-UNDO.
    
    RUN get-link-handle IN adm-broker-hdl (INPUT THIS-PROCEDURE, /* Source  */
                                           INPUT 'REFRESCAR-TARGET':U, /* Link Type */
                                           OUTPUT ch).                 /* Link List */
    DO i = 1 TO NUM-ENTRIES(ch):
    
      /* ch is a comma delimited list of SmartObject handles. */
      h_smo = WIDGET-HANDLE (ENTRY(i, ch)).
    
      /* Set the state of all SmartBrowsers. */
      RUN dispatch IN h_smo ('open-query':U).
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "nro_transaccion" "Cta_cte_bco" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cheque" "Cta_cte_bco" "nro_cheque"}
  {src/adm/template/sndkycas.i "nro_regcta" "Cta_cte_bco" "nro_regcta"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Cta_cte_bco" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_cuenta_ban" "Cta_cte_bco" "cdg_cuenta_ban"}
  {src/adm/template/sndkycas.i "nro_valor" "Cta_cte_bco" "nro_valor"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Cuenta_bancaria"}
  {src/adm/template/snd-list.i "Cta_cte_bco"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

