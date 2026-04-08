&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE BUFFER Usuario FOR Usuario.



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
&Scoped-define EXTERNAL-TABLES Empleado
&Scoped-define FIRST-EXTERNAL-TABLE Empleado


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Empleado.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Empleado.nro_legajo Empleado.nro_cuil ~
Empleado.nombre Empleado.cdg_sexo Empleado.nacionalid Empleado.calle ~
Empleado.numero Empleado.piso Empleado.depto Empleado.localidad ~
Empleado.telefono Empleado.cdg_postal Empleado.cdg_forma ~
Empleado.cdg_est_civil Empleado.fecha_ingreso Empleado.fecha_baja ~
Empleado.autorizante Empleado.solicitante Empleado.fecha_nac ~
Empleado.lugar_nac Empleado.nom_madre Empleado.nom_padre Empleado.tipo_doc ~
Empleado.numero_doc Empleado.expedido_por Empleado.e-mail 
&Scoped-define ENABLED-TABLES Empleado
&Scoped-define FIRST-ENABLED-TABLE Empleado
&Scoped-Define ENABLED-OBJECTS RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 
&Scoped-Define DISPLAYED-FIELDS Empleado.nro_legajo Empleado.nro_cuil ~
Empleado.nombre Empleado.cdg_sexo Empleado.nacionalid Empleado.calle ~
Empleado.numero Empleado.piso Empleado.depto Empleado.localidad ~
Empleado.telefono Empleado.cdg_postal Empleado.cdg_forma ~
Empleado.cdg_provincia Empleado.cdg_est_civil Empleado.cdg_banco ~
Empleado.fecha_ingreso Empleado.fecha_baja Empleado.cuenta_nro ~
Empleado.cdg_estado Empleado.autorizante Empleado.solicitante ~
Empleado.fecha_nac Empleado.lugar_nac Empleado.nom_madre Empleado.nom_padre ~
Empleado.tipo_doc Empleado.numero_doc Empleado.expedido_por Empleado.e-mail 
&Scoped-define DISPLAYED-TABLES Empleado
&Scoped-define FIRST-DISPLAYED-TABLE Empleado
&Scoped-Define DISPLAYED-OBJECTS v-cdg_area v-dsc_area v-cdg_usuario ~
v-dsc_usuario 

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
DEFINE VARIABLE v-cdg_area AS CHARACTER FORMAT "X(10)":U 
     LABEL "Sector" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_usuario AS CHARACTER FORMAT "X(256)" 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_area AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_usuario AS CHARACTER FORMAT "X(25)" 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE IMAGE i-foto4x4
     FILENAME "iconos21/photo_portrait.jpg":U CONVERT-3D-COLORS
     STRETCH-TO-FIT
     SIZE 28 BY 6.48.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 130 BY 18.81.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16 BY 1.86.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 38.6 BY 4.57.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL   
     SIZE 32 BY 7.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16.6 BY 1.86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Empleado.nro_legajo AT ROW 1.48 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nro_cuil AT ROW 1.48 COL 62 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nombre AT ROW 2.62 COL 23 COLON-ALIGNED
          LABEL "Apellido y Nombre"
          VIEW-AS FILL-IN 
          SIZE 59 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_sexo AT ROW 2.91 COL 88 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Masculino", "M":U,
"Femenino", "F":U
          SIZE 14 BY 1.33
     Empleado.nacionalid AT ROW 2.91 COL 111 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Argentino", "A":U,
"Extranjero", "E":U
          SIZE 13 BY 1.33
     Empleado.calle AT ROW 3.81 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 29 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.numero AT ROW 3.86 COL 70 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.piso AT ROW 5 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.depto AT ROW 5 COL 38 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.localidad AT ROW 5.05 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 28 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.telefono AT ROW 6.19 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_postal AT ROW 6.24 COL 65 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_forma AT ROW 6.52 COL 89 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Efvo.", "E":U,
"Cheque", "C":U,
"Banco", "A":U
          SIZE 35 BY .81
     Empleado.cdg_provincia AT ROW 7.38 COL 23 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          DROP-DOWN-LIST
          SIZE 32 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_est_civil AT ROW 7.43 COL 62 COLON-ALIGNED
          LABEL "E.C." FORMAT "X(10)"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "SOLTERO","SOL",
                     "CASADO","CAS",
                     "VIUDO","VIU",
                     "DIVORCIADO","DIV",
                     "SEPARADO","SEP",
                     "OTROS","OTR"
          DROP-DOWN-LIST
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_banco AT ROW 7.62 COL 94 COLON-ALIGNED
          LABEL "Banco"
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item1",001
          DROP-DOWN-LIST
          SIZE 26.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.fecha_ingreso AT ROW 8.57 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.fecha_baja AT ROW 8.62 COL 66 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Empleado.cuenta_nro AT ROW 8.95 COL 94 COLON-ALIGNED
          LABEL "Cuenta"
          VIEW-AS FILL-IN 
          SIZE 26.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.cdg_estado AT ROW 9.76 COL 23 COLON-ALIGNED
          LABEL "Estado"
          VIEW-AS COMBO-BOX INNER-LINES 5
          DROP-DOWN-LIST
          SIZE 59 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.autorizante AT ROW 10.76 COL 90
          VIEW-AS TOGGLE-BOX
          SIZE 15 BY 1
     Empleado.solicitante AT ROW 10.76 COL 111
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY 1
     v-cdg_area AT ROW 11 COL 23 COLON-ALIGNED
     v-dsc_area AT ROW 11 COL 42 COLON-ALIGNED NO-LABEL
     v-cdg_usuario AT ROW 12.19 COL 23 COLON-ALIGNED HELP
          "Identificacion del usuario"
     v-dsc_usuario AT ROW 12.19 COL 42 COLON-ALIGNED HELP
          "Nombre" NO-LABEL
     Empleado.fecha_nac AT ROW 13.38 COL 23 COLON-ALIGNED
          LABEL "Fecha Nacim."
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.lugar_nac AT ROW 13.43 COL 48 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 34 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nom_madre AT ROW 14.57 COL 23 COLON-ALIGNED
          LABEL "Nombre de la Madre"
          VIEW-AS FILL-IN 
          SIZE 59 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.nom_padre AT ROW 15.76 COL 23 COLON-ALIGNED
          LABEL "Nombre del Padre"
          VIEW-AS FILL-IN 
          SIZE 59 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.tipo_doc AT ROW 16.95 COL 23 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "DNI","CI","LE","LC","PASAP" 
          DROP-DOWN-LIST
          SIZE 12 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.numero_doc AT ROW 17 COL 45 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.expedido_por AT ROW 17 COL 74 COLON-ALIGNED
          LABEL "Exp."
          VIEW-AS FILL-IN 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Empleado.e-mail AT ROW 18.19 COL 23 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 59 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "                  Sexo  y  Nacionalidad" VIEW-AS TEXT
          SIZE 39 BY 1 AT ROW 1.48 COL 87
          BGCOLOR 5 FGCOLOR 15 
     "            Modo de Cobro de Haberes" VIEW-AS TEXT
          SIZE 39 BY 1 AT ROW 4.81 COL 87
          BGCOLOR 5 FGCOLOR 15 
     i-foto4x4 AT ROW 12.43 COL 94
     RECT-4 AT ROW 1 COL 1
     RECT-5 AT ROW 2.67 COL 110
     RECT-6 AT ROW 6 COL 87
     RECT-7 AT ROW 12.19 COL 92
     RECT-8 AT ROW 2.67 COL 87
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Empleado
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: Usuario B "?" ? sic Usuario
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
         HEIGHT             = 26.33
         WIDTH              = 134.
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

/* SETTINGS FOR COMBO-BOX Empleado.cdg_banco IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX Empleado.cdg_estado IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR COMBO-BOX Empleado.cdg_est_civil IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR COMBO-BOX Empleado.cdg_provincia IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Empleado.cuenta_nro IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Empleado.expedido_por IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Empleado.fecha_baja IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Empleado.fecha_nac IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR IMAGE i-foto4x4 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Empleado.nombre IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Empleado.nom_madre IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Empleado.nom_padre IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_area IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_usuario IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_area IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_usuario IN FRAME F-Main
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

&Scoped-define SELF-NAME Empleado.cdg_forma
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Empleado.cdg_forma V-table-Win
ON VALUE-CHANGED OF Empleado.cdg_forma IN FRAME F-Main /* Form.pago */
DO:
   Empleado.cdg_banco:SENSITIVE = Empleado.cdg_forma:SCREEN-VALUE = "A".
   Empleado.cuenta_nro:SENSITIVE = Empleado.cdg_banco:SENSITIVE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_area
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_area V-table-Win
ON MOUSE-MENU-DOWN OF v-cdg_area IN FRAME F-Main /* Sector */
OR "." OF v-cdg_area IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_area IN FRAME {&FRAME-NAME}
DO:

 {helptabla.i "Area" "cdg_area" "selsectr.p"}        
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_area V-table-Win
ON RETURN OF v-cdg_area IN FRAME F-Main /* Sector */
DO:
   {traducetabla.i "Area" "cdg_area" "denominacion"} 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_usuario
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_usuario V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_usuario IN FRAME F-Main /* Usuario */
OR "." OF v-cdg_usuario IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_usuario IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "usuario" "cdg_usuario" "SELUSUAR.P"} 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_usuario V-table-Win
ON RETURN OF v-cdg_usuario IN FRAME F-Main /* Usuario */
DO:
  /* {traducetabla.i "Usuario" "nro_usuario" "nombre"}  */
        
  IF v-cdg_usuario:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
  THEN DO:
          
        FIND usuario WHERE usuario.cdg_usuario = INPUT FRAME {&FRAME-NAME} v-cdg_usuario 
             NO-LOCK NO-ERROR.
        IF NOT AVAILABLE usuario 
        THEN DO:
             RUN PONMENSJ.P ( 'EMP006' ).
             RETURN NO-APPLY.
        END.
        
        v-dsc_usuario = usuario.nombre.
        DISPLAY v-dsc_usuario 
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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Empleado"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Empleado"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_foto V-table-Win 
PROCEDURE cargar_foto :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    /*
    FIND Parametro "DIRECIMG" NO-LOCK.
    nom_imagen = Parametro.valor_c + "im" + STRING(Empleado.nro_legajo,"999999") + ".bmp".
    */
    
    DEFINE VARIABLE nom_imagen AS CHARACTER.
    DEFINE VARIABLE como_fue   AS LOGICAL.
    
    i-foto4x4:VISIBLE IN FRAME {&FRAME-NAME} = NO.    

    IF AVAILABLE Empleado
    THEN DO:
        IF FRAME {&FRAME-NAME}:VISIBLE = YES
        THEN DO:
            nom_imagen = "../imagenes/" + "im" + STRING(Empleado.nro_legajo,"999999") + ".bmp".    
            IF SEARCH(nom_imagen) <> ?
            THEN DO:
                 como_fue = i-foto4x4:LOAD-IMAGE(nom_imagen,0,0,196,168) IN FRAME {&FRAME-NAME} NO-ERROR.
                 IF NOT como_fue 
                 THEN DO:
                     IF SEARCH(nom_imagen) <> ?
                     THEN DO:
                         nom_imagen = "../imagenes/dummy4x4.bmp".    
                         como_fue = i-foto4x4:LOAD-IMAGE(nom_imagen,0,0,196,168) IN FRAME {&FRAME-NAME}.
                     END.
                 END.   
                 IF como_fue 
                     THEN i-foto4x4:VISIBLE IN FRAME {&FRAME-NAME} = YES.    
            END.
          /*  ELSE DO:
                 nom_imagen = "../imagenes/dummy4x4.bmp".    
                 IF SEARCH(nom_imagen) <> ?
                 THEN DO:
                     como_fue = i-foto4x4:LOAD-IMAGE(nom_imagen,0,0,196,168) IN FRAME {&FRAME-NAME}.
                     IF como_fue 
                         THEN i-foto4x4:VISIBLE IN FRAME {&FRAME-NAME} = YES.    
                 END.

            END.*/
        END.
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
     {levantacombo.i &TABLA=Provincia &NOMBRE=nombre &CODIGO=cdg_provincia &OBJETO=Empleado.cdg_provincia}
     {levantacombo.i &TABLA=Banco &NOMBRE=nombre &CODIGO=cdg_banco &OBJETO=Empleado.cdg_banco}
     {levantacombo.i &TABLA=Estado &NOMBRE=descripcion &CODIGO=cdg_estado &OBJETO=Empleado.cdg_estado}
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
/*   {blanqueacodigo.i "Area"} */
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {blanqueacodigo.i "Usuario" }

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
  DEFINE BUFFER B-Empleado FOR Empleado.

  IF INPUT FRAME {&FRAME-NAME} Empleado.nro_legajo = 0
  THEN DO:
       RUN PONMENSJ.P (INPUT "EMPL000").
       RETURN ERROR.
  END.
  
  IF INPUT FRAME {&FRAME-NAME} Empleado.nombre = ""
  THEN DO:
       RUN PONMENSJ.P (INPUT "EMPL001").
       RETURN ERROR.
  END.            

  IF CAN-FIND(FIRST B-Empleado 
                     WHERE B-Empleado.nro_legajo = 
                         INPUT FRAME {&FRAME-NAME} Empleado.nro_legajo  
                      AND ROWID(B-Empleado) <> ROWID(Empleado) )
  THEN DO:
       RUN PONMENSJ.P (INPUT "EMPL002").
       RETURN ERROR.
  END.

   &SCOPED-DEFINE TABLA-MAESTRA  Empleado
   
   {validartabla.i "Area" "cdg_area" "denominacion" "SRET001"}.
   /*no todos los empresados son usuarios */
   
   IF trim( v-cdg_usuario:SCREEN-VALUE ) <> "" THEN DO:
      {validartabla.i "Usuario" "cdg_usuario" "nombre" "SRET0099"}.
   END.
    
   &UNDEFINE TABLA-MAESTRA


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   
   &SCOPED-DEFINE TABLA-MAESTRA  Empleado
       
   {asignartabla.i "Area" "cdg_area" "cdg_seccion"}   
   IF v-cdg_usuario:SCREEN-VALUE <> "" THEN
      {asignartabla.i "Usuario" "nro_usuario" "nro_usuario"}   
    
   &UNDEFINE TABLA-MAESTRA

   {findempresa.i}

   IF NEW Empleado
      THEN ASSIGN Empleado.nro_empleado = NEXT-VALUE(proximo_empleado)
                  Empleado.cdg_empresa = Empresa.cdg_empresa.

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
   RUN vlb-empleados.p ( INPUT ROWID(Empleado), OUTPUT baja_no ).
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

  Empleado.cuenta_nro:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  {deshabcodigo.i "Area"}
  {deshabcodigo.i "Usuario"}

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

  IF AVAILABLE Empleado
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Empleado
                                                                         
        {displaytabla.i "Area" "cdg_area" "denominacion" "cdg_area" "cdg_seccion" }
        {displaytabla.i "Usuario" "cdg_usuario" "nombre" "nro_usuario" "nro_usuario" }
        
        &UNDEFINE TABLA-MAESTRA

        RUN cargar_foto.

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

  IF Empleado.cdg_forma:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "A"
  THEN DO:
        Empleado.cuenta_nro:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  END.

  {habilcodigo.i "Area"}
  {habilcodigo.i "Usuario"}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view V-table-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  RUN cargar_foto.


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
  {src/adm/template/snd-list.i "Empleado"}

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

