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

DEFINE VARIABLE rid_tabla     AS ROWID.
DEFINE VARIABLE combos_listos AS LOGICAL INITIAL NO.

DEFINE VARIABLE hay_error_interface AS LOGICAL.
DEFINE VARIABLE que_cambio_domicilio AS CHARACTER.

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
&Scoped-define EXTERNAL-TABLES Domicilio Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Domicilio


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Domicilio, Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Domicilio.nro_domicilio Domicilio.envio ~
Domicilio.factura Domicilio.retira Domicilio.nombre Domicilio.direccion ~
Domicilio.localidad Domicilio.cdg_postal Domicilio.cdg_pais ~
Domicilio.cdg_subclasezng Domicilio.orden_recorrido Domicilio.telefono ~
Domicilio.dias_entrega Domicilio.email 
&Scoped-define ENABLED-TABLES Domicilio
&Scoped-define FIRST-ENABLED-TABLE Domicilio
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Domicilio.nro_domicilio Domicilio.envio ~
Domicilio.factura Domicilio.retira Domicilio.nombre Domicilio.direccion ~
Domicilio.localidad Domicilio.cdg_postal Domicilio.cdg_pais ~
Domicilio.cdg_subclasezng Domicilio.orden_recorrido Domicilio.telefono ~
Domicilio.dias_entrega Domicilio.email 
&Scoped-define DISPLAYED-TABLES Domicilio
&Scoped-define FIRST-DISPLAYED-TABLE Domicilio
&Scoped-Define DISPLAYED-OBJECTS v-cdg_provincia v-dsc_zona_geografica ~
v-cdg_recorrido v-dsc_recorrido v-dsc_municipio v-cdg_municipio 

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
DEFINE BUTTON btn_clase 
     LABEL "&Elegir" 
     SIZE 11 BY 1.

DEFINE VARIABLE v-cdg_provincia AS CHARACTER FORMAT "X(256)":U 
     LABEL "Provincia" 
     VIEW-AS COMBO-BOX INNER-LINES 8
     LIST-ITEMS "[Ninguna]","BUENOS AIRES","CAPITAL FEDERAL","CATAMARCA","CHACO","CHUBUT","CORDOBA","CORRIENTES","ENTRE RIOS","FORMOSA","JUJUY","LA PAMPA","LA RIOJA","MENDOZA","MISIONES","NEUQUEN","RIO NEGRO","SALTA","SAN JUAN","SAN LUIS","SANTA CRUZ","SANTA FE","SGO. DEL ESTERO","TIERRA D. FUEGO","TUCUMAN","X-EXTRANJERO" 
     DROP-DOWN-LIST
     SIZE 36 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_municipio AS CHARACTER FORMAT "X(8)" 
     LABEL "Municipio" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_recorrido AS CHARACTER FORMAT "X(8)" 
     LABEL "Recorrido" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_municipio AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_recorrido AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 34 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_zona_geografica AS CHARACTER FORMAT "X(35)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 34 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 84 BY 13.33.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Domicilio.nro_domicilio AT ROW 1.48 COL 13 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.envio AT ROW 1.71 COL 28
          LABEL "Hab.Remitos"
          VIEW-AS TOGGLE-BOX
          SIZE 17 BY .76
     Domicilio.factura AT ROW 1.71 COL 50
          LABEL "Hab. Facturas"
          VIEW-AS TOGGLE-BOX
          SIZE 19 BY .76
     Domicilio.retira AT ROW 1.71 COL 73
          LABEL "Retira"
          VIEW-AS TOGGLE-BOX
          SIZE 10 BY .76
     Domicilio.nombre AT ROW 2.67 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.direccion AT ROW 3.86 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.localidad AT ROW 5.05 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 36 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.cdg_postal AT ROW 5.05 COL 62 COLON-ALIGNED
          LABEL "C.Postal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_provincia AT ROW 6.24 COL 13 COLON-ALIGNED
     Domicilio.cdg_pais AT ROW 6.24 COL 62 COLON-ALIGNED
          LABEL "Pais"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "0",1
          DROP-DOWN-LIST
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.cdg_subclasezng AT ROW 7.43 COL 13 COLON-ALIGNED
          LABEL "Zona" FORMAT "X(20)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_zona_geografica AT ROW 7.43 COL 35 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     btn_clase AT ROW 7.43 COL 72
     v-cdg_recorrido AT ROW 8.62 COL 13 COLON-ALIGNED HELP
          "Código del recorrido"
     v-dsc_recorrido AT ROW 8.62 COL 35 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     Domicilio.orden_recorrido AT ROW 8.62 COL 73 COLON-ALIGNED
          LABEL "#" FORMAT "999999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.telefono AT ROW 9.71 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.dias_entrega AT ROW 10.76 COL 13 COLON-ALIGNED
          LABEL "Entregas"
          VIEW-AS FILL-IN NATIVE 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Domicilio.email AT ROW 11.86 COL 13 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 68 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-dsc_municipio AT ROW 12.91 COL 28 COLON-ALIGNED HELP
          "Denominacion" NO-LABEL
     v-cdg_municipio AT ROW 12.95 COL 13 COLON-ALIGNED HELP
          "Código del recorrido"
     RECT-7 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE NO-VALIDATE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Domicilio,sic.Cliente
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
         HEIGHT             = 13.86
         WIDTH              = 86.8.
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

/* SETTINGS FOR BUTTON btn_clase IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX Domicilio.cdg_pais IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Domicilio.cdg_postal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Domicilio.cdg_subclasezng IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Domicilio.dias_entrega IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Domicilio.envio IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Domicilio.factura IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Domicilio.nro_domicilio IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Domicilio.orden_recorrido IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR TOGGLE-BOX Domicilio.retira IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_municipio IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-cdg_provincia IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_recorrido IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_municipio IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_recorrido IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_zona_geografica IN FRAME F-Main
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

&Scoped-define SELF-NAME btn_clase
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_clase V-table-Win
ON CHOOSE OF btn_clase IN FRAME F-Main /* Elegir */
DO:

   DEFINE VARIABLE v-cdg_subclase LIKE Domicilio.cdg_subclasezng.
   DEFINE VARIABLE puso_ok AS LOGICAL.
   
   RUN d-abmclasezonag.w ( OUTPUT v-cdg_subclase , OUTPUT puso_ok ).
   IF puso_ok
   THEN DO:
      DISPLAY v-cdg_subclase @ Domicilio.cdg_subclasezng
              WITH FRAME {&FRAME-NAME}.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Domicilio.cdg_subclasezng
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Domicilio.cdg_subclasezng V-table-Win
ON MOUSE-MENU-DOWN OF Domicilio.cdg_subclasezng IN FRAME F-Main /* Zona */
DO:
  &SCOPED-DEFINE ROWID_TABLA        rid_deszona
  &SCOPED-DEFINE SELECCION          SELZONAG.P
  &SCOPED-DEFINE TABLA              Zona_geografica
  &SCOPED-DEFINE CDG_TABLA          cdg_zonag
  &SCOPED-DEFINE DSC_TABLA          nombre
  &SCOPED-DEFINE V-DSC_TABLA        v-dsc_zona_geografica
  &SCOPED-DEFINE V-CDG_TABLA        Domicilio.cdg_subclasezng:SCREEN-VALUE IN FRAME {&FRAME-NAME}
  &SCOPED-DEFINE MOSTRAR_DSC        YES

  {hlptabla-var.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Domicilio.cdg_subclasezng V-table-Win
ON RETURN OF Domicilio.cdg_subclasezng IN FRAME F-Main /* Zona */
DO:
    IF SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
        THEN FIND Zona_geografica WHERE Zona_geografica.cdg_zonag = SELF:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR.
        ELSE FIND FIRST Zona_geografica NO-LOCK NO-ERROR.
    
    IF AVAILABLE Zona_geografica 
    THEN DO:
         v-dsc_zona_geografica     = Zona_geografica.nombre.
         Domicilio.cdg_subclasezng:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Zona_geografica.cdg_zonag.
    END.
    ELSE DO:
         v-dsc_zona_geografica = "???".
    END.

    DISPLAY v-dsc_zona_geografica Domicilio.cdg_subclasezng WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_municipio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_municipio V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_municipio IN FRAME F-Main /* Municipio */
OR "." OF v-cdg_municipio IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_municipio IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Municipio" "cdg_municipio" "SELMUNICIPIO.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_municipio V-table-Win
ON RETURN OF v-cdg_municipio IN FRAME F-Main /* Municipio */
DO:
   {traducetabla.i "Municipio" "cdg_municipio" "dsc_municipio"} 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_recorrido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_recorrido V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_recorrido IN FRAME F-Main /* Recorrido */
OR "." OF v-cdg_recorrido IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_recorrido IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Recorrido" "cdg_recorrido" "SELRECOR.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_recorrido V-table-Win
ON RETURN OF v-cdg_recorrido IN FRAME F-Main /* Recorrido */
DO:
   {traducetabla.i "Recorrido" "cdg_recorrido" "dsc_recorrido"} 
  
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
  {src/adm/template/row-list.i "Domicilio"}
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Domicilio"}
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

   v-cdg_provincia:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "[Ninguna]".

   {blanqueacodigo.i "Municipio"}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE BUFFER B-Domicilio FOR Domicilio.

   FIND Provincia WHERE Provincia.nombre = v-cdg_provincia:SCREEN-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR. 
   IF NOT AVAILABLE Provincia
   THEN DO:
        RUN ponmensj.p ( INPUT "XXXX999").
        RETURN ERROR.
   END.

/*    IF NOT CAN-FIND(FIRST C_Postal WHERE  C_Postal.cdg_postal = Domicilio.cdg_postal:INPUT-VALUE IN FRAME {&FRAME-NAME}) */
/*    THEN DO:                                                                                                             */
/*         RUN ponmensj.p ( INPUT "DOMI005").                                                                              */
/*         RETURN ERROR.                                                                                                   */
/*    END.                                                                                                                 */

   &SCOPED-DEFINE TABLA-MAESTRA  Domicilio

/*    {validartabla.i "Zona_geografica" "cdg_zonag" "nombre" "DOMI001"}  */
   {validartabla.i "Recorrido" "cdg_recorrido" "dsc_recorrido" "DOMI002"}
/*    {validartabla.i "municipio" "cdg_municipio" "dsc_municipio" "DOMI003"}  */
   /* 
   {validartabla.i "Provincia" "cdg_provincia" "dsc_provincia" "DOMI002"} 
   {validartabla.i "Pais" "cdg_pais" "dsc_pais" "DOMI002"} 
   */ 


  FIND Zona_geografica WHERE Zona_geografica.cdg_zonag = INPUT FRAME {&FRAME-NAME} Domicilio.cdg_subclasezng NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Zona_geografica 
  THEN DO:
        RUN PONMENSJ.P ( INPUT "DOMI001" ).
        RETURN ERROR.
  END.

  v-dsc_zona_geografica = Zona_geografica.nombre.
  DISPLAY v-dsc_zona_geografica WITH FRAME {&FRAME-NAME}.     


   FIND Pais WHERE Pais.cdg_pais = Domicilio.cdg_pais:INPUT-VALUE IN FRAME {&FRAME-NAME} NO-LOCK NO-ERROR. 
   IF NOT AVAILABLE Pais
   THEN DO:
        RUN ponmensj.p ( INPUT "DOMI004").
        RETURN ERROR.
   END.

   &UNDEFINE TABLA-MAESTRA

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   &SCOPED-DEFINE TABLA-MAESTRA  Domicilio
   Domicilio.cdg_subclasezng = Zona_geografica.cdg_zonag.
   Domicilio.cdg_zonag = Zona_geografica.cdg_zonag.
/*    {asignartabla.i "Zona_geografica" "cdg_zonag" "cdg_zonag"  }  */
   {asignartabla.i "Recorrido" "cdg_recorrido" "cdg_recorrido" } 
/*    {asignartabla.i "municipio" "cdg_municipio" "cdg_municipio" }  */

   &UNDEFINE TABLA-MAESTRA

   Domicilio.nro_cliente   = Cliente.nro_cliente.
   Domicilio.cdg_provincia = Provincia.cdg_provincia.

   que_cambio_domicilio = "".
   IF Domicilio.retira
   THEN DO:
       DEFINE VARIABLE n-cambios AS INTEGER.
       n-cambios = 0.
       FOR EACH B-Domicilio OF Cliente WHERE ROWID(B-Domicilio) <> ROWID(Domicilio) AND B-Domicilio.retira:
           B-Domicilio.retira = NO.
           n-cambios = n-cambios + 1.
       END.
       IF n-cambios <> 0
       THEN DO:
           que_cambio_domicilio = "Se cambió el domicilio de retiro de planta".
       END.
       ELSE DO:
           que_cambio_domicilio = "Se asignó a este domicilio como retiro de planta".
       END.

   END.

   IF (SEARCH("sincronizar_domicilio.p") <> ? OR
       SEARCH("sincronizar_domicilio.r") <> ?) AND
       NOT Domicilio.retira
   THEN DO:
       RUN sincronizar_domicilio.p ( INPUT Cliente.cdg_cliente,
                                     INPUT Domicilio.nro_domicilio,
                                     OUTPUT hay_error_interface).
   END.

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
   RUN vlb-domicilios.p ( INPUT ROWID(Domicilio), OUTPUT baja_no ).
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

  /*{deshabcodigo.i "Zona_geografica"} */
  {deshabcodigo.i "Recorrido"} 
  {deshabcodigo.i "Municipio"}

   v-cdg_provincia:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   btn_clase:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

   IF NOT TRANSACTION
   THEN DO:
       IF que_cambio_domicilio <> ""
           THEN MESSAGE que_cambio_domicilio VIEW-AS ALERT-BOX WARNING TITLE "AVISO !!!".
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

  IF AVAILABLE Domicilio
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Domicilio
  
        {displaytabla.i "Recorrido" "cdg_recorrido" "dsc_recorrido" "cdg_recorrido" "cdg_recorrido"} 
        {displaytabla.i "municipio" "cdg_municipio" "dsc_municipio" "cdg_municipio" "cdg_municipio"} 
        /*{displaytabla.i "Zona_geografica" "cdg_zonag" "nombre" "cdg_zonag" "cdg_zonag"} */

       FIND Provincia OF Domicilio NO-LOCK.
       v-cdg_provincia:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Provincia.nombre.
  END.
  ELSE DO:
       v-cdg_provincia:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
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

  /*{habilcodigo.i "Zona_geografica"} */
  {habilcodigo.i "Recorrido"} 
  {habilcodigo.i "Municipio"}
   v-cdg_provincia:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   btn_clase:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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

    DEFINE VARIABLE xx AS CHARACTER.

    xx = "".
    FOR EACH Pais:
        xx = xx + CHR(1) + Pais.nombre + CHR(1) + STRING(Pais.cdg_pais).
    END.
    Domicilio.cdg_pais:DELIMITER IN FRAME {&FRAME-NAME} = CHR(1).
    Domicilio.cdg_pais:LIST-ITEM-PAIRS IN FRAME {&FRAME-NAME} = SUBSTRING(xx,2).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "Domicilio"}
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

