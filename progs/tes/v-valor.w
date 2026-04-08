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

   DEFINE VARIABLE v-fecha0 AS DATE.
   DEFINE VARIABLE v-ndias  AS INTEGER.
   DEFINE VARIABLE v-fecha1 AS DATE.

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
&Scoped-define EXTERNAL-TABLES Valor
&Scoped-define FIRST-EXTERNAL-TABLE Valor


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Valor.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Valor.numero_cuenta_val Valor.numero_cheque ~
Valor.Conciliado Valor.cdg_banco Valor.fecha_emision Valor.dias_clearing ~
Valor.observacion Valor.fecha_acredita 
&Scoped-define ENABLED-TABLES Valor
&Scoped-define FIRST-ENABLED-TABLE Valor
&Scoped-Define ENABLED-OBJECTS RECT-5 Bret 
&Scoped-Define DISPLAYED-FIELDS Valor.numero_cuenta_val Valor.cdg_empresa ~
Valor.numero_cheque Valor.Conciliado Valor.importe Valor.cdg_banco ~
Valor.cdg_sucurbanco Valor.fecha_recepcion Valor.cdg_caja ~
Valor.fecha_emision Valor.fecha_deposito Valor.cdg_cuenta_ban ~
Valor.fecha_salida Valor.dias_clearing Valor.observacion ~
Valor.fecha_acredita Valor.num_sucursal Valor.estado 
&Scoped-define DISPLAYED-TABLES Valor
&Scoped-define FIRST-DISPLAYED-TABLE Valor
&Scoped-Define DISPLAYED-OBJECTS v-dsc_banco v-dsc_caja v-cdg_cliente ~
v-dsc_cliente v-dsc_cuenta v-cdg_proveedor v-dsc_proveedor v-cdg_rubro 

/* Custom List Definitions                                              */
/* ADM-CREATE-FIELDS,ADM-ASSIGN-FIELDS,List-3,List-4,List-5,List-6      */
&Scoped-define ADM-ASSIGN-FIELDS v-cdg_rubro 

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
DEFINE BUTTON Bret 
     LABEL "RET" 
     SIZE 7 BY 1.14 TOOLTIP "Retener/Liberar el Cheque CUIDADO!!!!!!!".

DEFINE VARIABLE v-cdg_rubro AS CHARACTER FORMAT "X(256)" INITIAL "0" 
     LABEL "Rubro" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0","1"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cliente" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_proveedor AS CHARACTER FORMAT "X(256)":U 
     LABEL "Proveedor" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_banco AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_caja AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_proveedor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 115 BY 9.95.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Valor.numero_cuenta_val AT ROW 1.71 COL 65 COLON-ALIGNED WIDGET-ID 2
          LABEL "Cuenta"
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_empresa AT ROW 1.71 COL 95 COLON-ALIGNED
          LABEL "Empresa"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.numero_cheque AT ROW 1.81 COL 13 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.Conciliado AT ROW 1.81 COL 36 WIDGET-ID 10
          LABEL "Conciliado"
          VIEW-AS TOGGLE-BOX
          SIZE 18 BY .81
     Valor.importe AT ROW 2.76 COL 95 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_banco AT ROW 2.86 COL 13 COLON-ALIGNED
          LABEL "Banco"
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_sucurbanco AT ROW 2.86 COL 21 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_banco AT ROW 2.86 COL 28 COLON-ALIGNED NO-LABEL
     Valor.fecha_recepcion AT ROW 3.86 COL 95 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_caja AT ROW 3.95 COL 13 COLON-ALIGNED
          LABEL "Caja"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_caja AT ROW 3.95 COL 28 COLON-ALIGNED NO-LABEL
     Valor.fecha_emision AT ROW 4.95 COL 95 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cliente AT ROW 5.05 COL 13 COLON-ALIGNED
     v-dsc_cliente AT ROW 5.05 COL 28 COLON-ALIGNED NO-LABEL
     Valor.fecha_deposito AT ROW 6.05 COL 95 COLON-ALIGNED
          LABEL "Depósito" FORMAT "99/99/9999"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.cdg_cuenta_ban AT ROW 6.14 COL 13 COLON-ALIGNED
          LABEL "Cuenta"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_cuenta AT ROW 6.14 COL 28 COLON-ALIGNED NO-LABEL
     Valor.fecha_salida AT ROW 7.1 COL 95 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_proveedor AT ROW 7.19 COL 13 COLON-ALIGNED
     v-dsc_proveedor AT ROW 7.19 COL 28 COLON-ALIGNED NO-LABEL
     Valor.dias_clearing AT ROW 8.19 COL 95 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.observacion AT ROW 8.29 COL 13 COLON-ALIGNED
          LABEL "Obs."
          VIEW-AS FILL-IN 
          SIZE 70 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.fecha_acredita AT ROW 9.24 COL 95 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Valor.num_sucursal AT ROW 9.33 COL 13 COLON-ALIGNED
          LABEL "Sucursal"
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_rubro AT ROW 9.33 COL 35.4 COLON-ALIGNED HELP
          "Codigo de Rubro" WIDGET-ID 6
     Valor.estado AT ROW 9.33 COL 62.2 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Bret AT ROW 9.33 COL 78 WIDGET-ID 8
     RECT-5 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Valor
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
         HEIGHT             = 9.95
         WIDTH              = 116.6.
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

/* SETTINGS FOR FILL-IN Valor.cdg_banco IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Valor.cdg_caja IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Valor.cdg_cuenta_ban IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Valor.cdg_empresa IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Valor.cdg_sucurbanco IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX Valor.Conciliado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Valor.estado IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Valor.fecha_deposito IN FRAME F-Main
   NO-ENABLE EXP-LABEL EXP-FORMAT                                       */
/* SETTINGS FOR FILL-IN Valor.fecha_emision IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Valor.fecha_recepcion IN FRAME F-Main
   NO-ENABLE EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Valor.fecha_salida IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Valor.importe IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Valor.numero_cheque IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Valor.numero_cuenta_val IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Valor.num_sucursal IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Valor.observacion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cliente IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_proveedor IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-cdg_rubro IN FRAME F-Main
   NO-ENABLE 2                                                          */
ASSIGN 
       v-cdg_rubro:HIDDEN IN FRAME F-Main           = TRUE.

/* SETTINGS FOR FILL-IN v-dsc_banco IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_caja IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_proveedor IN FRAME F-Main
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

&Scoped-define SELF-NAME Bret
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bret V-table-Win
ON CHOOSE OF Bret IN FRAME F-Main /* RET */
DO:
  DEFINE VAR opt AS LOGICAL.
  IF valor.estado <> "00" AND valor.estado <> "20" THEN DO:
      MESSAGE "Solo estados 00 y 20 pueden retenerse" VIEW-AS ALERT-BOX ERROR.
  END.

  IF valor.estado = "00" THEN DO:
      MESSAGE "Desea Retener el Valor"VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
      IF opt THEN valor.estado:SCREEN-VALUE = "20".
  END.
  ELSE IF valor.estado = "20" THEN DO:
      MESSAGE "Desea Liberar el Valor"VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
      IF opt THEN valor.estado:SCREEN-VALUE = "00".
     
  END.
  FIND CURRENT valor EXCLUSIVE-LOCK.
  ASSIGN valor.estado.
  FIND CURRENT valor NO-LOCK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Valor.cdg_banco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Valor.cdg_banco V-table-Win
ON MOUSE-MENU-DOWN OF Valor.cdg_banco IN FRAME F-Main /* Banco */
OR "+" OF Valor.cdg_banco IN FRAME {&FRAME-NAME}
DO:
  
  &SCOPED-DEFINE ROWID_TABLA   rid_banco
  &SCOPED-DEFINE TABLA         Banco
  &SCOPED-DEFINE CDG_TABLA     cdg_banco
  &SCOPED-DEFINE DSC_TABLA     nombre
  &SCOPED-DEFINE SELECCION     SELBANCO.P
  &SCOPED-DEFINE CAMPO-FRAME   Valor.cdg_banco
  &SCOPED-DEFINE MOSTRAR_DSC   YES
  &SCOPED-DEFINE V-DSC_TABLA   v-dsc_banco

  {hlptabla.i}  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Valor.cdg_banco V-table-Win
ON RETURN OF Valor.cdg_banco IN FRAME F-Main /* Banco */
DO:

  &SCOPED-DEFINE ROWID_TABLA   rid_banco
  &SCOPED-DEFINE TABLA         Banco
  &SCOPED-DEFINE CDG_TABLA     cdg_banco
  &SCOPED-DEFINE DSC_TABLA     nombre
  &SCOPED-DEFINE CAMPO-FRAME   Valor.cdg_banco
  &SCOPED-DEFINE MOSTRAR_DSC   YES
  &SCOPED-DEFINE V-DSC_TABLA   v-dsc_banco

  {trdtabla.i}  
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Valor.dias_clearing
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Valor.dias_clearing V-table-Win
ON LEAVE OF Valor.dias_clearing IN FRAME F-Main /* Clearing */
DO:

   v-fecha0 = INPUT FRAME {&FRAME-NAME} Valor.fecha_deposito.
   v-ndias  = INPUT FRAME {&FRAME-NAME} Valor.dias_clearing.

   RUN sumar_dias ( INPUT-OUTPUT v-fecha0, INPUT v-ndias, OUTPUT v-fecha1).
   
   DISPLAY v-fecha0 @ Valor.fecha_deposito
           v-fecha1 @ Valor.fecha_acredita
           WITH FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Valor.fecha_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Valor.fecha_deposito V-table-Win
ON LEAVE OF Valor.fecha_deposito IN FRAME F-Main /* Depósito */
DO:

   v-fecha0 = INPUT FRAME {&FRAME-NAME} Valor.fecha_deposito.
   v-ndias  = INPUT FRAME {&FRAME-NAME} Valor.dias_clearing.

   RUN sumar_dias ( INPUT-OUTPUT v-fecha0, INPUT v-ndias, OUTPUT v-fecha1).
   
   DISPLAY v-fecha0 @ Valor.fecha_deposito
           v-fecha1 @ Valor.fecha_acredita
           WITH FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Valor.fecha_emision
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Valor.fecha_emision V-table-Win
ON LEAVE OF Valor.fecha_emision IN FRAME F-Main /* Pago */
DO:
  
   v-fecha0 = INPUT FRAME {&FRAME-NAME} Valor.fecha_emision.
   v-ndias  = INPUT FRAME {&FRAME-NAME} Valor.dias_clearing.

   RUN sumar_dias ( INPUT-OUTPUT v-fecha0, INPUT v-ndias, OUTPUT v-fecha1).
   
   DISPLAY v-fecha0 @ Valor.fecha_deposito
           v-fecha1 @ Valor.fecha_acredita
           WITH FRAME {&FRAME-NAME}.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Valor.numero_cheque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Valor.numero_cheque V-table-Win
ON CTRL-SHIFT-ENTER OF Valor.numero_cheque IN FRAME F-Main /* Número */
DO:
  MESSAGE "Nro interno " Valor.nro_valor VIEW-AS ALERT-BOX INFORMATION.
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
  {src/adm/template/row-list.i "Valor"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Valor"}

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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  valor.cdg_rubro = int(v-cdg_rubro).

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN FRAME {&FRAME-NAME} Valor.fecha_deposito.

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

  Valor.fecha_deposito:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  v-cdg_rubro:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

   IF AVAILABLE Valor
   THEN DO:
        v-cdg_rubro = STRING( valor.cdg_rubro ).
        FIND Banco OF Valor NO-LOCK.
        v-dsc_banco = Banco.nombre.
        
        FIND Caja  OF Valor NO-LOCK.
        v-dsc_caja  = Caja.nombre.
     
        FIND Cuenta_bancaria OF Valor NO-LOCK NO-ERROR.
        IF AVAILABLE Cuenta_bancaria
           THEN v-dsc_cuenta = Cuenta_bancaria.denominacion_cta.
           ELSE v-dsc_cuenta = "".
     
        FIND Cliente OF Valor NO-LOCK NO-ERROR.
        IF AVAILABLE Cliente
        THEN DO:
             v-dsc_cliente = Cliente.nom_cliente.
             v-cdg_cliente = Cliente.cdg_cliente.
        END.
        ELSE DO:
             v-dsc_cliente = "".
             v-cdg_cliente = "".
        END.
     
        FIND Proveedor OF Valor NO-LOCK NO-ERROR.
        IF AVAILABLE Proveedor
        THEN DO:
             v-dsc_proveedor = Proveedor.nombre.
             v-cdg_proveedor = Proveedor.cdg_proveedor.
        END.
        ELSE DO:
             v-dsc_proveedor = "".
             v-cdg_proveedor = "".
        END.
   END.
   ELSE DO:

        ASSIGN
            v-dsc_banco = ""
            v-dsc_caja  = ""
            v-dsc_cuenta = ""
            v-dsc_cliente = ""
            v-cdg_cliente = ""
            v-dsc_proveedor = ""
            v-cdg_proveedor = ""
            v-cdg_rubro = "0".

   END.

   DISPLAY
           v-dsc_banco
           v-dsc_caja
           v-dsc_cuenta
           v-dsc_cliente
           v-cdg_cliente
           v-dsc_proveedor
           v-cdg_proveedor
           v-cdg_rubro
           WITH FRAME {&FRAME-NAME}.

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
  
  Valor.fecha_deposito:SENSITIVE IN FRAME {&FRAME-NAME} = Valor.estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "00".
  v-cdg_rubro:SENSITIVE IN FRAME {&FRAME-NAME} = Valor.estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "00" .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR lista AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
lista = ",----,0".
FOR EACH rubro WHERE rubro.tipo = "V" :
    lista = lista + "," + Rubro.abrev + "," + STRING(Rubro.cdg_rubro).
END.
v-cdg_rubro:LIST-ITEM-PAIRS in FRAME {&FRAME-NAME} = substring(lista,2).
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .



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
  {src/adm/template/snd-list.i "Valor"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sumar_dias V-table-Win 
PROCEDURE sumar_dias :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE INPUT-OUTPUT PARAMETER p-fecha0 AS DATE.
   DEFINE INPUT        PARAMETER p-ndias  AS INTEGER.
   DEFINE OUTPUT       PARAMETER p-fecha1 AS DATE.

   IF TODAY - p-fecha0 > 30 
   THEN DO:
      RUN PONMENSJ.P ( INPUT "VALR004" ).
   END.

   IF WEEKDAY(p-fecha0) = 1 OR
      WEEKDAY(p-fecha0) = 7
   THEN DO:
      RUN PONMENSJ.P ( INPUT "VALR002" ).
   END.

   IF CAN-FIND(FIRST Feriado WHERE Feriado.fecha = p-fecha0)
   THEN DO:
      RUN PONMENSJ.P ( INPUT "VALR003" ).
   END.

   RUN fecvalor.p ( INPUT-OUTPUT p-fecha0, INPUT p-ndias, OUTPUT p-fecha1).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

