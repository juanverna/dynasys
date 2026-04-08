&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Administrador FOR Cliente.
DEFINE BUFFER B-Cliente FOR Cliente.



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

DEFINE VARIABLE rid_tabla     AS ROWID.
DEFINE VARIABLE combos_listos AS LOGICAL INITIAL NO.
DEFINE VARIABLE hay_error_interface AS LOGICAL.
{crystal_dyna.p}

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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.direccion Cliente.cdg_cliente ~
Cliente.nom_cliente Cliente.dfl_cdg_puntovta Cliente.cdg_postal ~
Cliente.localidad Cliente.cdg_provincia Cliente.cuit Cliente.cdg_famclie ~
Cliente.cdg_estado Cliente.telefonos Cliente.lista_mail ~
Cliente.cdg_tipoclie Cliente.mostrar_admin Cliente.permite_nominar 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-7 bVer b-resumen 
&Scoped-Define DISPLAYED-FIELDS Cliente.direccion Cliente.cdg_cliente ~
Cliente.nom_cliente Cliente.dfl_cdg_puntovta Cliente.cdg_postal ~
Cliente.localidad Cliente.cdg_provincia Cliente.cuit Cliente.cdg_famclie ~
Cliente.fecha_alta Cliente.fecha_baja Cliente.cdg_estado Cliente.telefonos ~
Cliente.lista_mail Cliente.cdg_tipoclie Cliente.mostrar_admin ~
Cliente.permite_nominar 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente
&Scoped-Define DISPLAYED-OBJECTS v-cdg_condicion_impos ~
v-dsc_condicion_impos v-cdg_condicion_venta v-dsc_condicion_venta ~
v-cdg_administrador v-dsc_administrador 

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
DEFINE BUTTON b-resumen 
     LABEL "&Resumen" 
     SIZE 10 BY 1 TOOLTIP "Resumen de Cobranza del administrador".

DEFINE BUTTON bVer 
     LABEL "Ver" 
     SIZE 10 BY 1.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER FORMAT "X(8)" 
     LABEL "Administ." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1 TOOLTIP "Deje el campo en blanco para los auto-administrados"
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_impos AS INTEGER FORMAT ">>>9" INITIAL 0 
     LABEL "Cond.Impos." 
     VIEW-AS FILL-IN NATIVE 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_condicion_venta AS CHARACTER FORMAT "X(8)" 
     LABEL "Cond. Venta" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_administrador AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_impos AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 41 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_condicion_venta AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 126 BY 12.86.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 33 BY 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cliente.direccion AT ROW 1.24 COL 13 COLON-ALIGNED
          LABEL "Dirección"
          VIEW-AS FILL-IN NATIVE 
          SIZE 85 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_cliente AT ROW 1.24 COL 110 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 2.43 COL 13 COLON-ALIGNED
          LABEL "R.Social"
          VIEW-AS FILL-IN NATIVE 
          SIZE 85 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.dfl_cdg_puntovta AT ROW 2.43 COL 115 COLON-ALIGNED WIDGET-ID 6
          LABEL "PVta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1 TOOLTIP "Punto de venta que lo atientde por default"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_postal AT ROW 3.62 COL 13 COLON-ALIGNED
          LABEL "C. P."
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.localidad AT ROW 3.62 COL 40 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Capital Federal,","Buenos Aires" 
          DROP-DOWN
          SIZE 37 BY 1
     Cliente.cdg_provincia AT ROW 3.62 COL 97 COLON-ALIGNED
          LABEL "Provincia"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item1","Item1"
          DROP-DOWN-LIST
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cuit AT ROW 4.81 COL 13 COLON-ALIGNED FORMAT "X(11)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1 TOOLTIP "No introduzca los ~"-~""
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_impos AT ROW 4.81 COL 65 COLON-ALIGNED
     v-dsc_condicion_impos AT ROW 4.81 COL 82 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.cdg_famclie AT ROW 6 COL 13 COLON-ALIGNED
          LABEL "Familia"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item1","Item1"
          DROP-DOWN-LIST
          SIZE 31 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_condicion_venta AT ROW 6 COL 59 COLON-ALIGNED
     v-dsc_condicion_venta AT ROW 6 COL 74 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Cliente.fecha_alta AT ROW 7.19 COL 13 COLON-ALIGNED
          LABEL "Alta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.fecha_baja AT ROW 7.19 COL 33 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_estado AT ROW 7.19 COL 90 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Activo","A",
                     "Inactivo","I",
                     "Potencial","P",
                     "Baja","B"
          DROP-DOWN-LIST
          SIZE 33 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.telefonos AT ROW 9.1 COL 13 COLON-ALIGNED
          LABEL "Teléfonos"
          VIEW-AS FILL-IN NATIVE 
          SIZE 56 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.lista_mail AT ROW 9.1 COL 79 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 44 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_administrador AT ROW 10.62 COL 13 COLON-ALIGNED
     Cliente.cdg_tipoclie AT ROW 10.62 COL 99 COLON-ALIGNED
          LABEL "Actividad"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 24 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     v-dsc_administrador AT ROW 10.67 COL 27 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     bVer AT ROW 10.67 COL 69.8
     b-resumen AT ROW 10.67 COL 80.4 WIDGET-ID 8
     Cliente.mostrar_admin AT ROW 12.43 COL 49 WIDGET-ID 2
          LABEL "Mostrar Admin"
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .81
     Cliente.permite_nominar AT ROW 12.57 COL 17
          LABEL "Nomina Comprobantes"
          VIEW-AS TOGGLE-BOX
          SIZE 24 BY .62
     RECT-2 AT ROW 1 COL 1
     RECT-7 AT ROW 12.33 COL 14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: Administrador B "?" ? sic Cliente
      TABLE: B-Cliente B "?" ? sic Cliente
   END-TABLES.
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
         HEIGHT             = 13.24
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_famclie IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_provincia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR COMBO-BOX Cliente.cdg_tipoclie IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.cuit IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.dfl_cdg_puntovta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.direccion IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.fecha_alta IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Cliente.fecha_baja IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR TOGGLE-BOX Cliente.mostrar_admin IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.nom_cliente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Cliente.permite_nominar IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.telefonos IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_administrador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_impos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_condicion_venta IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_administrador IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_impos IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_condicion_venta IN FRAME F-Main
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

&Scoped-define SELF-NAME b-resumen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-resumen V-table-Win
ON CHOOSE OF b-resumen IN FRAME F-Main /* Resumen */
DO:
  RUN resumen_cob.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bVer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bVer V-table-Win
ON CHOOSE OF bVer IN FRAME F-Main /* Ver */
DO:
  DEFINE BUFFER badminis FOR cliente.
  ASSIGN v-cdg_administrador.
  IF v-cdg_administrador <> "" AND
     v-cdg_administrador <> cliente.cdg_cliente THEN DO:
  FIND badminis WHERE badminis.cdg_cliente = v-cdg_administrador NO-LOCK NO-ERROR.
  RUN w-zoom_cliente.w ( INPUT ROWID(badminis) ).
  END.
  ELSE 
     RUN ponmensj.p ( INPUT "USR_015").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cliente.cuit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cliente.cuit V-table-Win
ON LEAVE OF Cliente.cuit IN FRAME F-Main /* C.U.I.T. */
DO:
    run validar_cuit_param.p ( INPUT FRAME {&FRAME-NAME} Cliente.cuit, ? ).
    if return-value <> "OK"
    THEN DO:
       RETURN NO-APPLY.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_administrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_administrador IN FRAME F-Main /* Administ. */
OR "." OF v-cdg_administrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_administrador IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Administrador" "cdg_cliente" "SELADMINIS.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador V-table-Win
ON RETURN OF v-cdg_administrador IN FRAME F-Main /* Administ. */
DO:
   {traducetabla.i "Administrador" "cdg_cliente" "nom_cliente"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_impos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_impos IN FRAME F-Main /* Cond.Impos. */
OR "." OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_impos IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Condicion_impos" "cdg_condiva" "SELCNDIV-v.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_impos V-table-Win
ON RETURN OF v-cdg_condicion_impos IN FRAME F-Main /* Cond.Impos. */
DO:
   {traducetabla.i "Condicion_impos" "cdg_condiva" "descripcion"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_condicion_venta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_condicion_venta IN FRAME F-Main /* Cond. Venta */
OR "." OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_condicion_venta IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Condicion_venta" "cdg_cndventa" "SELCNDVN.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_condicion_venta V-table-Win
ON RETURN OF v-cdg_condicion_venta IN FRAME F-Main /* Cond. Venta */
DO:
   {traducetabla.i "Condicion_venta" "cdg_cndventa" "descripcion"} 
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
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos V-table-Win 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Provincia &NOMBRE=nombre &CODIGO=cdg_provincia &OBJETO=Cliente.cdg_provincia}
/*   {levantacombo.i &TABLA=Familia_cliente &NOMBRE=dsc_famclie &CODIGO=cdg_famclie &OBJETO=Cliente.cdg_famclie}  */
     {levantacombo_empresa.i "Familia_cliente" "dsc_famclie" "cdg_famclie" "Cliente.cdg_famclie" "lista_empresas" Empresa.cdg_empresa}
     {levantacombo.i &TABLA=Tipo_cliente &NOMBRE=dsc_tipoclie &CODIGO=cdg_tipoclie &OBJETO=Cliente.cdg_tipoclie}


      END.          
                                             
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
   
   /*{blanqueacodigo.i "Lista_precios"}*/
   /*{blanqueacodigo.i "Vendedor"} */
   /*{blanqueacodigo.i "Cobrador"}*/
   /*{blanqueacodigo.i "Grupo-empresario"}*/
   {blanqueacodigo.i "Condicion_impos"}
   {blanqueacodigo.i "Condicion_venta"}
   /*{blanqueacodigo.i "Entidad"} */
   {blanqueacodigo.i "Administrador"} 
  
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
    
    IF INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = "" OR 
        INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "USR_009").
         RETURN ERROR.
    END.            
    IF INPUT FRAME {&FRAME-NAME} sic.Cliente.dfl_cdg_puntovta = 0 OR 
        INPUT FRAME {&FRAME-NAME} sic.Cliente.dfl_cdg_puntovta = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "USR_019").
         RETURN ERROR.
    END.            
    IF NEW cliente 
    THEN DO:
        
        IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente <> "" AND CAN-FIND(FIRST B-Cliente 
                           WHERE B-Cliente.cdg_cliente = 
                               INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente )
        THEN DO:
             RUN PONMENSJ.P (INPUT "USR_010").
             RETURN ERROR.
        END.
        IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente <> "" AND SUBSTRING(INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente,1,1) <> "C"
            THEN DO:
                 RUN PONMENSJ.P (INPUT "USR_017").
                 RETURN ERROR.
            END.

    END.
    ELSE DO:

        IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente <> "" AND CAN-FIND(FIRST B-Cliente 
                           WHERE B-Cliente.cdg_cliente = 
                               INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente  
                            AND ROWID(B-Cliente) <> ROWID(Cliente) )
        THEN DO:
             RUN PONMENSJ.P (INPUT "USR_010").
             RETURN ERROR.
        END.
        
    END.
    
    run validar_cuit_param.p ( INPUT FRAME {&FRAME-NAME} Cliente.cuit, ? ).
    if return-value <> "OK"
    THEN DO:
       RETURN ERROR.
    END.  


    IF CAN-FIND(FIRST B-Cliente
                       WHERE INPUT FRAME {&FRAME-NAME} Cliente.cuit <> "" AND 
                         B-Cliente.cuit = INPUT FRAME {&FRAME-NAME} Cliente.cuit
                         AND ROWID(B-Cliente) <> ROWID(Cliente) )
                         
    THEN DO:
         RUN PONMENSJ.P (INPUT "CLIE036").
         RETURN ERROR.
    END.

   &SCOPED-DEFINE TABLA-MAESTRA  Cliente

   /*{validartabla.i "Lista_precios" "cdg_lista" "descripcion" "CLIE008"} */
   /*{validartabla.i "Vendedor" "cdg_vendedor" "nombre" "CLIE003"} */
   /*{validartabla.i "Cobrador" "cdg_cobrador" "nom_cobrador" "CLIE003"} */
   /*{validartabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp" "CLIE009"}*/
   {validartabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "CLIE005"}
   {validartabla.i "Condicion_impos" "cdg_condiva" "descripcion" "CLIE006"}
   /*{validartabla.i "Entidad" "cdg_entidad" "dsc_entidad" "CLIE010"}*/

   IF v-cdg_administrador:INPUT-VALUE <> ""
   THEN DO:
       {validartabla.i "Administrador" "cdg_cliente" "nom_cliente" "CLIEXXX"}
   END.
   

   &UNDEFINE TABLA-MAESTRA

   IF NEW cliente 
   THEN DO:
       CREATE Hst_Cliente.
       BUFFER-COPY Cliente TO Hst_cliente.
       RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                                   OUTPUT Hst_cliente.fecha_cambio,
                                   OUTPUT Hst_cliente.hor_cambio,
                                   OUTPUT Hst_cliente.pc_cambio).
       ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
   END.


  /* Dispatch standard ADM method.                             */
  
   RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Cliente

   /*{asignartabla.i "Lista_precios" "cdg_lista" "dfl_lista"}*/
   /*{asignartabla.i "Vendedor" "nro_vendedor" "nro_vendedor"} */
   /*{asignartabla.i "Cobrador" "nro_cobrador" "nro_cobrador"} */
   /*{asignartabla.i "Grupo-empresario" "cdg_grupoemp" "cdg_grupoemp"}*/
   {asignartabla.i "Condicion_venta" "cdg_cndventa" "dfl_cndventa" }
   {asignartabla.i "Condicion_impos" "cdg_condiva" "cdg_condiva" }
   /*{asignartabla.i "Entidad" "nro_entidad" "nro_entidad"} */

   {findempresa.i}
   Cliente.lista_empresas = Empresa.cdg_empresa.
   Cliente.lista_sectores = Empresa.cdg_empresa.

   FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.
   Cliente.nro_entidad = Entidad.nro_entidad.

   FIND FIRST Lista_precios NO-LOCK.
   Cliente.dfl_lista = Lista_precios.cdg_lista.

   FIND FIRST Vendedor NO-LOCK.
   Cliente.nro_vendedor = Vendedor.nro_vendedor.

   FIND FIRST Cobrador NO-LOCK.
   Cliente.nro_cobrador = Cobrador.nro_cobrador.

   FIND FIRST Grupo-empresario NO-LOCK.
   Cliente.cdg_grupoemp = Grupo-empresario.cdg_grupoemp.


   &UNDEFINE TABLA-MAESTRA

   IF NEW Cliente
   THEN DO:
          ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
                  Cliente.fecha_alta  = TODAY
                  Cliente.hora_alta   = TIME.
          IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente = "" THEN
              ASSIGN cliente.cdg_cliente = "C" + STRING(Cliente.nro_cliente,"99999").
          ELSE ASSIGN cliente.cdg_cliente.
   END.

   IF v-cdg_administrador:INPUT-VALUE <> ""
    THEN DO:
       FIND administrador WHERE administrador.cdg_cliente = v-cdg_administrador:INPUT-VALUE.
       cliente.nro_administrador = administrador.nro_cliente.
    END.
    ELSE DO:
       Cliente.nro_administrador = cliente.nro_cliente.
    END.

   ASSIGN Cliente.fecha_grab = TODAY
          Cliente.hora_grab = TIME.

   IF SEARCH("sincronizar_cliente.p") <> ? OR
   SEARCH("sincronizar_cliente.r") <> ?
   THEN DO:
       RUN sincronizar_cliente.p ( INPUT Cliente.cdg_cliente,
                                   OUTPUT hay_error_interface).
   END.
   cliente.ult_domicilio = 1.    
   FIND FIRST domicilio OF cliente NO-ERROR.
   IF NOT AVAILABLE domicilio THEN DO:
       CREATE domicilio.
        ASSIGN  Domicilio.telefono = cliente.telefonos
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio" 
            Domicilio.localidad = cliente.localidad
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","")
            Domicilio.cdg_pais = 1.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-copy-record V-table-Win 
PROCEDURE local-copy-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

 

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
   RUN vlb-clientes.p ( INPUT ROWID(Cliente), OUTPUT baja_no ).
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

  /*{deshabcodigo.i "Lista_precios"} */
  /*{deshabcodigo.i "Entidad"}       */
  /*{deshabcodigo.i "Vendedor"}*/ 
  /*{deshabcodigo.i "Cobrador"}*/ 
  /*{deshabcodigo.i "Grupo-empresario"} */
  {deshabcodigo.i "Condicion_impos"} 
  {deshabcodigo.i "Condicion_venta"} 
  {deshabcodigo.i "Administrador"} 

  
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

  IF AVAILABLE Cliente
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Cliente
     
        /*{displaytabla.i "Lista_precios" "cdg_lista" "descripcion" "cdg_lista" "dfl_lista"} 
        {displaytabla.i "Vendedor" "cdg_vendedor" "nombre" "nro_vendedor" "nro_vendedor"}
        {displaytabla.i "Cobrador" "cdg_cobrador" "nom_cobrador" "nro_cobrador" "nro_cobrador"} 
        {displaytabla.i "Grupo-empresario" "cdg_grupoemp" "dsc_grupoemp" "cdg_grupoemp" "cdg_grupoemp"}*/
        {displaytabla.i "Condicion_impos" "cdg_condiva" "descripcion" "cdg_condiva" "cdg_condiva"} 
        {displaytabla.i "Condicion_venta" "cdg_cndventa" "descripcion" "cdg_cndventa" "dfl_cndventa"} 
        /*{displaytabla.i "Entidad" "cdg_entidad" "dsc_entidad" "nro_entidad" "nro_entidad"} */
        {displaytabla.i "Administrador" "cdg_cliente" "nom_cliente" "nro_cliente" "nro_administrador" }


        &UNDEFINE TABLA-MAESTRA
        

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

 
  
  /*{habilcodigo.i "Lista_precios"} 
  {habilcodigo.i "Vendedor"}
  {habilcodigo.i "Entidad"} 
  {habilcodigo.i "Cobrador"} 
  {habilcodigo.i "Grupo-empresario"}*/
  {habilcodigo.i "Condicion_impos"} 
  {habilcodigo.i "Condicion_venta"} 
  {habilcodigo.i "Administrador"} 

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

   {findempresa.i}

   RUN inicia_combos.
   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resumen_cob V-table-Win 
PROCEDURE resumen_cob :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.

  

  RUN prinresumenes.p ( INPUT Empresa.cdg_empresa,
                             INPUT v-cdg_administrador:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                             INPUT v-cdg_administrador:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                             INPUT TODAY ,
                             INPUT 01/01/3000 ,
                             INPUT "*", /*Todos los puntos de venta*/
                             INPUT 1,
                             OUTPUT xfile). 

ReportePath = "resumen_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.

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

