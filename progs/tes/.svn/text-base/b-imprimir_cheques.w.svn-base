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

  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

  DEFINE VARIABLE cambio_cuenta AS LOGICAL INITIAL NO.
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
&Scoped-define INTERNAL-TABLES Cheque

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cheque.numero_cheque Cheque.orden ~
Cheque.fecha_emision Cheque.fecha_salida Cheque.importe Cheque.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table Cheque.orden 
&Scoped-define ENABLED-TABLES-IN-QUERY-br_table Cheque
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br_table Cheque
&Scoped-define QUERY-STRING-br_table FOR EACH Cheque OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cheque.numero_cheque <= v-has_ncheque ~
 AND Cheque.numero_cheque >= v-des_ncheque NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cheque OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cheque.numero_cheque <= v-has_ncheque ~
 AND Cheque.numero_cheque >= v-des_ncheque NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Cheque
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cheque


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 br_table 
&Scoped-Define DISPLAYED-OBJECTS v-des_ncheque v-has_ncheque 

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
cdg_caja||y|sic.Cheque.cdg_caja
nro_transaccion||y|sic.Cheque.nro_transaccion
nro_cheque||y|sic.Cheque.nro_cheque
nro_cuenta||y|sic.Cheque.nro_cuenta
cdg_cuenta_ban||y|sic.Cheque.cdg_cuenta_ban
nro_proveedor||y|sic.Cheque.nro_proveedor
num_sucursal||y|sic.Cheque.num_sucursal
nro_titular-pag||y|sic.Cheque.nro_titular-pag
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_caja,nro_transaccion,nro_cheque,nro_cuenta,cdg_cuenta_ban,nro_proveedor,num_sucursal,nro_titular-pag"':U).

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
DEFINE BUTTON btn_imprimir 
     LABEL "&Imprimir" 
     SIZE 14 BY 1.33.

DEFINE BUTTON btn_listar 
     LABEL "&Listado" 
     SIZE 14 BY 1.33.

DEFINE BUTTON btn_rango 
     LABEL "&Rango" 
     SIZE 14 BY 1.33.

DEFINE BUTTON btn_vercheque 
     LABEL "&Ver Cheque" 
     SIZE 14 BY 1.33.

DEFINE VARIABLE v-des_ncheque AS INTEGER FORMAT "99999999":U INITIAL 0 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-has_ncheque AS INTEGER FORMAT "99999999":U INITIAL 0 
     LABEL "Hasta" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 146 BY 1.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cheque SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cheque.numero_cheque FORMAT ">>>>>>>9":U
      Cheque.orden COLUMN-LABEL "Orden!Del Cheque" FORMAT "X(50)":U
      Cheque.fecha_emision FORMAT "99/99/99":U
      Cheque.fecha_salida FORMAT "99/99/99":U
      Cheque.importe FORMAT ">>,>>>,>>9.99":U WIDTH 18.8
      Cheque.observacion FORMAT "X(40)":U WIDTH 46.8
  ENABLE
      Cheque.orden
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 146 BY 15.48
         BGCOLOR 15 FGCOLOR 9 
         TITLE BGCOLOR 15 FGCOLOR 9 "Cheques pendientes de impresión de la actual cuenta bancaria" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     btn_vercheque AT ROW 1.24 COL 87
     btn_listar AT ROW 1.24 COL 102
     btn_rango AT ROW 1.24 COL 117
     btn_imprimir AT ROW 1.24 COL 132
     v-des_ncheque AT ROW 1.48 COL 7 COLON-ALIGNED
     v-has_ncheque AT ROW 1.48 COL 31 COLON-ALIGNED
     br_table AT ROW 3.14 COL 1
     RECT-2 AT ROW 1 COL 1
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
         HEIGHT             = 17.81
         WIDTH              = 147.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table v-has_ncheque F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_imprimir IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_listar IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_rango IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_vercheque IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-des_ncheque IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-has_ncheque IN FRAME F-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cheque OF sic.Cuenta_bancaria"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Cheque.numero_cheque <= v-has_ncheque
 AND Cheque.numero_cheque >= v-des_ncheque"
     _FldNameList[1]   = sic.Cheque.numero_cheque
     _FldNameList[2]   > sic.Cheque.orden
"Cheque.orden" "Orden!Del Cheque" ? "character" ? ? ? ? ? ? yes ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic.Cheque.fecha_emision
"Cheque.fecha_emision" ? "99/99/99" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic.Cheque.fecha_salida
"Cheque.fecha_salida" ? "99/99/99" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic.Cheque.importe
"Cheque.importe" ? ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "18.8" yes no no "U" "" ""
     _FldNameList[6]   > sic.Cheque.observacion
"Cheque.observacion" ? ? "character" ? ? ? ? ? ? no ? no no "38.8" yes no no "U" "" ""
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
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Cheques pendientes de impresión de la actual cuenta bancaria */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Cheques pendientes de impresión de la actual cuenta bancaria */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Cheques pendientes de impresión de la actual cuenta bancaria */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_imprimir B-table-Win
ON CHOOSE OF btn_imprimir IN FRAME F-Main /* Imprimir */
DO:
  MESSAGE "Confirma que desa proceder a imprimir los cheques"
          VIEW-AS ALERT-BOX MESSAGE BUTTONS YES-NO TITLE "Confirmación" SET sino.

  IF sino
  THEN DO:
       RUN imprimir_cheques.
       RUN dispatch IN THIS-PROCEDURE ('open-query':U).
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listar B-table-Win
ON CHOOSE OF btn_listar IN FRAME F-Main /* Listado */
DO:
    RUN lschequespendientes.p ( INPUT Cuenta_bancaria.cdg_cuenta_ban,
                                INPUT v-des_ncheque,
                                INPUT v-has_ncheque ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rango
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rango B-table-Win
ON CHOOSE OF btn_rango IN FRAME F-Main /* Rango */
DO:

   v-has_ncheque = Cheque.numero_cheque.
   DISPLAY v-has_ncheque
           WITH FRAME {&FRAME-NAME}.
   RUN dispatch IN THIS-PROCEDURE ('open-query':U).                 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_vercheque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_vercheque B-table-Win
ON CHOOSE OF btn_vercheque IN FRAME F-Main /* Ver Cheque */
DO:
  IF AVAILABLE Cheque
     THEN RUN d-muestra_cheque.w ( INPUT ROWID(Cheque)).
     ELSE BELL.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_ncheque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_ncheque B-table-Win
ON RETURN OF v-has_ncheque IN FRAME F-Main /* Hasta */
OR "TAB" OF v-has_ncheque IN FRAME {&FRAME-NAME}
DO:

     IF INPUT FRAME {&FRAME-NAME} v-has_ncheque = ?
     THEN DO:
          BELL.
          MESSAGE "No puede indicarse este valor en blanco"
                  VIEW-AS ALERT-BOX ERROR BUTTONS OK.
          RETURN NO-APPLY.
     END.


     IF INPUT FRAME {&FRAME-NAME} v-has_ncheque < v-des_ncheque
     THEN DO:
          BELL.
          MESSAGE "Se indica un rango inválido de números de cheque."
                  VIEW-AS ALERT-BOX ERROR BUTTONS OK.
          DISPLAY v-has_ncheque
                  WITH FRAME {&FRAME-NAME}.   
          RETURN NO-APPLY.
     END.

     ASSIGN v-has_ncheque.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE imprimir_cheques B-table-Win 
PROCEDURE imprimir_cheques :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  RUN prcheques.p ( INPUT Cuenta_bancaria.cdg_cuenta_ban,
                    INPUT v-des_ncheque,
                    INPUT v-has_ncheque ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   IF cambio_cuenta THEN RUN primero_y_ultimo.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    btn_imprimir:SENSITIVE IN FRAME {&FRAME-NAME}  = AVAILABLE Cheque.
    btn_listar:SENSITIVE IN FRAME {&FRAME-NAME}    = AVAILABLE Cheque.
    btn_rango:SENSITIVE IN FRAME {&FRAME-NAME}     = AVAILABLE Cheque. 
    btn_vercheque:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Cheque.
    v-has_ncheque:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Cheque.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-row-available B-table-Win 
PROCEDURE local-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

    cambio_cuenta = YES.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'row-available':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    cambio_cuenta = NO.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE primero_y_ultimo B-table-Win 
PROCEDURE primero_y_ultimo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND FIRST Cheque OF Cuenta_bancaria WHERE Cheque.estado = "PP" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Cheque
    THEN DO:
         MESSAGE "La cuenta " Cuenta_bancaria.denominacion_cta  
                  "no registra cheques pendientes de imprimir".
         v-des_ncheque = 0.
         v-has_ncheque = 0.
    END.
    ELSE DO:
         v-des_ncheque = Cheque.numero_cheque.
         FIND LAST Cheque OF Cuenta_bancaria WHERE Cheque.estado = "PP" NO-LOCK NO-ERROR.
         v-has_ncheque = Cheque.numero_cheque.
    END.
   
    DISPLAY v-des_ncheque
            v-has_ncheque
            WITH FRAME {&FRAME-NAME}.


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
  {src/adm/template/sndkycas.i "cdg_caja" "Cheque" "cdg_caja"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Cheque" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cheque" "Cheque" "nro_cheque"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Cheque" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_cuenta_ban" "Cheque" "cdg_cuenta_ban"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cheque" "nro_proveedor"}
  {src/adm/template/sndkycas.i "num_sucursal" "Cheque" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_titular-pag" "Cheque" "nro_titular-pag"}

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
  {src/adm/template/snd-list.i "Cheque"}

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

