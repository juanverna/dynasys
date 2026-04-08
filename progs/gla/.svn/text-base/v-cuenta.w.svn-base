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

DEFINE BUFFER Sobregiro FOR Cuenta.
DEFINE VARIABLE rid_tabla AS ROWID.

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
&Scoped-define EXTERNAL-TABLES Cuenta
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cuenta.grupo_pat Cuenta.cdg_cuenta ~
Cuenta.nombre_cta Cuenta.entidades_validas Cuenta.lista_empresas ~
Cuenta.fecha_alta Cuenta.fecha_baja Cuenta.tipo_saldo Cuenta.es_monetaria ~
Cuenta.modo_subcuenta Cuenta.cta_cte Cuenta.revaluable Cuenta.unidades ~
Cuenta.modo_iva Cuenta.ajuste Cuenta.sobregiro Cuenta.esta_restringida 
&Scoped-define ENABLED-TABLES Cuenta
&Scoped-define FIRST-ENABLED-TABLE Cuenta
&Scoped-Define ENABLED-OBJECTS RECT-18 RECT-19 RECT-20 RECT-21 RECT-3 
&Scoped-Define DISPLAYED-FIELDS Cuenta.grupo_pat Cuenta.cdg_cuenta ~
Cuenta.nombre_cta Cuenta.entidades_validas Cuenta.lista_empresas ~
Cuenta.fecha_alta Cuenta.fecha_baja Cuenta.tipo_saldo Cuenta.es_monetaria ~
Cuenta.modo_subcuenta Cuenta.cta_cte Cuenta.revaluable Cuenta.unidades ~
Cuenta.modo_iva Cuenta.ajuste Cuenta.sobregiro Cuenta.esta_restringida 
&Scoped-define DISPLAYED-TABLES Cuenta
&Scoped-define FIRST-DISPLAYED-TABLE Cuenta
&Scoped-Define DISPLAYED-OBJECTS v-cdg_sobregiro v-dsc_sobregiro 

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
DEFINE BUTTON btn_elegir 
     LABEL "Elegir" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_elegir-2 
     LABEL "Elegir" 
     SIZE 15 BY 1.

DEFINE VARIABLE v-cdg_sobregiro AS CHARACTER FORMAT "X(10)":U 
     LABEL "Sobregiro" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_sobregiro AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 54.8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 2.14.

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 83 BY 4.57.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 29 BY 2.95.

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 83 BY 1.67.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 83 BY 8.57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cuenta.grupo_pat AT ROW 1.48 COL 45 COLON-ALIGNED
          LABEL "Grupo Patrimonial"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Activo (A)","A",
                     "Pasivo (P)","P",
                     "Ganancias (+)","+",
                     "Pérdidas (-)","-",
                     "Capital (C)","C",
                     "Resultado Ejercicio (R)","R",
                     "Exposición a la Inflación (I)","I"
          DROP-DOWN-LIST
          SIZE 34 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuenta.cdg_cuenta AT ROW 1.52 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuenta.nombre_cta AT ROW 2.62 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuenta.entidades_validas AT ROW 3.67 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir AT ROW 3.67 COL 66
     Cuenta.lista_empresas AT ROW 4.81 COL 11 COLON-ALIGNED
          LABEL "Empresas"
          VIEW-AS FILL-IN 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_elegir-2 AT ROW 4.81 COL 66
     Cuenta.fecha_alta AT ROW 6 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuenta.fecha_baja AT ROW 6 COL 34 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuenta.tipo_saldo AT ROW 7.1 COL 13 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Deudor", "D":U,
"Acreedor", "A":U,
"Indistinto", "I":U
          SIZE 14 BY 2.14
     Cuenta.es_monetaria AT ROW 7.38 COL 36
          VIEW-AS TOGGLE-BOX
          SIZE 14 BY .76
     Cuenta.modo_subcuenta AT ROW 7.38 COL 53 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "No hay Subcuentas", "N":U,
"Si hay Subcuentas", "S":U
          SIZE 26 BY 1.62
     Cuenta.cta_cte AT ROW 8.43 COL 36
          VIEW-AS TOGGLE-BOX
          SIZE 12 BY .76
     Cuenta.revaluable AT ROW 10.1 COL 13
          LABEL "Recibe Revalúo"
          VIEW-AS TOGGLE-BOX
          SIZE 26 BY .76
     Cuenta.unidades AT ROW 10.91 COL 13
          LABEL "Acepta Asientos con Unidades"
          VIEW-AS TOGGLE-BOX
          SIZE 35 BY .76
     Cuenta.modo_iva AT ROW 11.43 COL 53 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "No es IVA", "N":U,
"Es IVA Débito", "D":U,
"Es IVA Crédito", "C":U
          SIZE 19 BY 2.43
     Cuenta.ajuste AT ROW 11.71 COL 13
          LABEL "Recibe Ajuste por Inflación"
          VIEW-AS TOGGLE-BOX
          SIZE 33 BY .76
     Cuenta.sobregiro AT ROW 12.52 COL 13
          LABEL "Compensa Sobregiros"
          VIEW-AS TOGGLE-BOX
          SIZE 33 BY .76
     Cuenta.esta_restringida AT ROW 13.33 COL 13
          VIEW-AS TOGGLE-BOX
          SIZE 29 BY .76
     v-cdg_sobregiro AT ROW 14.86 COL 11 COLON-ALIGNED
     v-dsc_sobregiro AT ROW 14.86 COL 24 COLON-ALIGNED NO-LABEL
     "Saldo:" VIEW-AS TEXT
          SIZE 6 BY .62 AT ROW 7.1 COL 7
     "            Modo Subcuentas" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6 COL 52
          BGCOLOR 7 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     "          Relación con el IVA" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 10.1 COL 52
          BGCOLOR 7 FGCOLOR 15 
     RECT-18 AT ROW 7.1 COL 52
     RECT-19 AT ROW 9.81 COL 1
     RECT-20 AT ROW 11.14 COL 52
     RECT-21 AT ROW 14.57 COL 1
     RECT-3 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cuenta
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
         HEIGHT             = 16.05
         WIDTH              = 96.8.
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

/* SETTINGS FOR TOGGLE-BOX Cuenta.ajuste IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR BUTTON btn_elegir IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_elegir-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX Cuenta.grupo_pat IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cuenta.lista_empresas IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cuenta.revaluable IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cuenta.sobregiro IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cuenta.unidades IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_sobregiro IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_sobregiro IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_elegir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir V-table-Win
ON CHOOSE OF btn_elegir IN FRAME F-Main /* Elegir */
DO:
{ELEGIR.I "Cuenta" "entidades_validas" "Entidad" "cdg_entidad" "dsc_entidad" "SELECENT.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_elegir-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_elegir-2 V-table-Win
ON CHOOSE OF btn_elegir-2 IN FRAME F-Main /* Elegir */
DO:
{ELEGIR.I "Cuenta" "lista_empresas" "Empresa" "cdg_empresa" "nombre" "SELECEMP.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cuenta.sobregiro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cuenta.sobregiro V-table-Win
ON VALUE-CHANGED OF Cuenta.sobregiro IN FRAME F-Main /* Compensa Sobregiros */
DO:
  IF INPUT Cuenta.sobregiro 
  THEN DO:
       v-cdg_sobregiro:SENSITIVE    = YES.
  END.
  ELSE DO:
       v-cdg_sobregiro:SENSITIVE    = NO.
       v-cdg_sobregiro:SCREEN-VALUE = "".
       v-dsc_sobregiro:SCREEN-VALUE = "".
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_sobregiro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_sobregiro V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_sobregiro IN FRAME F-Main /* Sobregiro */
OR "." OF v-cdg_sobregiro IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_sobregiro IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Sobregiro" "cdg_cuenta" "SELCUENT.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_sobregiro V-table-Win
ON RETURN OF v-cdg_sobregiro IN FRAME F-Main /* Sobregiro */
DO:
   {traducetabla.i "Sobregiro" "cdg_cuenta" "nombre_cta"} 
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
  {src/adm/template/row-list.i "Cuenta"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuenta"}

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

   ASSIGN
       v-cdg_sobregiro:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
       v-dsc_sobregiro:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".


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

    DEFINE BUFFER B-Cuenta FOR Cuenta.

    IF INPUT FRAME {&FRAME-NAME} Cuenta.nombre_cta = "" OR 
        INPUT FRAME {&FRAME-NAME} Cuenta.nombre_cta = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "CUEN001").
         RETURN ERROR.
    END.            

    IF CAN-FIND(FIRST B-Cuenta 
                       WHERE B-Cuenta.cdg_cuenta = 
                           INPUT FRAME {&FRAME-NAME} Cuenta.cdg_cuenta  
                        AND ROWID(B-Cuenta) <> ROWID(Cuenta) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "CUEN002").
         RETURN ERROR.
    END.            

    IF INPUT Cuenta.sobregiro
    THEN DO:
        FIND Sobregiro WHERE Sobregiro.cdg_cuenta = INPUT FRAME {&FRAME-NAME} v-cdg_sobregiro EXCLUSIVE-LOCK NO-ERROR.
        IF NOT AVAILABLE Sobregiro
        THEN DO:
            RUN PONMENSJ.P (INPUT "CUEN005").
            RETURN ERROR.
        END.
        ELSE DO:
            IF es_alta
            THEN DO:
                IF Sobregiro.nro_cuenta-sobregiro <> 0 
                THEN DO:
                     RUN PONMENSJ.P (INPUT "CUEN006").
                     RETURN ERROR.
                END.
            END.
            ELSE DO:
                IF Sobregiro.nro_cuenta-sobregiro <> Cuenta.nro_cuenta AND Sobregiro.nro_cuenta-sobregiro <> 0
                THEN DO:
                    RUN PONMENSJ.P (INPUT "CUEN007").
                    RETURN ERROR.
                END.
            END.
        END.
    END.

    IF Cuenta.lista_empresas:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" THEN DO: 
        RUN PONMENSJ.P (INPUT "CUEN120").
        RETURN ERROR.
    END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  IF NEW Cuenta
  THEN DO:
      Cuenta.nro_cuenta = NEXT-VALUE(proxima_cuenta).
      FIND FIRST Moneda WHERE Moneda.es_local.
      CREATE Cuenta-moneda.
      ASSIGN Cuenta-moneda.nro_cuenta = Cuenta.nro_cuenta
             Cuenta-moneda.nro_moneda = Moneda.nro_moneda
             Cuenta-moneda.reexpresa_saldos   = YES
             Cuenta-moneda.admite_movimientos = YES.
  END.

  IF INPUT Cuenta.sobregiro
  THEN DO:

       Cuenta.nro_cuenta-sobregiro    = Sobregiro.nro_cuenta.
       Sobregiro.nro_cuenta-sobregiro = Cuenta.nro_cuenta.
       Sobregiro.sobregiro = YES.

  END.
  ELSE DO:    

       IF Cuenta.nro_cuenta-sobregiro <> 0
       THEN DO:
            FIND Sobregiro WHERE Sobregiro.nro_cuenta = Cuenta.nro_cuenta-sobregiro EXCLUSIVE-LOCK.
            Cuenta.nro_cuenta-sobregiro    = 0.
            Sobregiro.nro_cuenta-sobregiro = 0.
            Sobregiro.sobregiro = NO.
       END.
  
  END.  

  RELEASE Sobregiro.

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

   DEFINE VARIABLE baja_no AS LOGICAL.
   RUN vlb-cuentas.p ( INPUT ROWID(Cuenta), OUTPUT baja_no ).
   IF baja_no 
   THEN DO:
        RUN PONMENSJ.P ( "IREF001" ).
        RETURN ERROR.
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

  ASSIGN
     btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = NO
     btn_elegir-2:SENSITIVE IN FRAME {&FRAME-NAME} = NO
     v-cdg_sobregiro:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
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

  v-cdg_sobregiro = "".
  v-dsc_sobregiro = "".

  IF AVAILABLE Cuenta
  THEN DO:
      IF INPUT FRAME {&FRAME-NAME} Cuenta.sobregiro 
      THEN DO:
           FIND Sobregiro WHERE Sobregiro.nro_cuenta = Cuenta.nro_cuenta-sobregiro NO-LOCK. 
           v-cdg_sobregiro = Sobregiro.cdg_cuenta.
           v-dsc_sobregiro = Sobregiro.nombre_cta.
      END.
  END.

  DISPLAY 
     v-cdg_sobregiro
     v-dsc_sobregiro
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

  ASSIGN
     btn_elegir:SENSITIVE IN FRAME {&FRAME-NAME} = YES
     btn_elegir-2:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

  IF INPUT Cuenta.sobregiro 
  THEN DO:
       v-cdg_sobregiro:SENSITIVE    = YES.
  END.
  ELSE DO:
       v-cdg_sobregiro:SENSITIVE    = NO.
  END.

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
  {src/adm/template/snd-list.i "Cuenta"}

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

