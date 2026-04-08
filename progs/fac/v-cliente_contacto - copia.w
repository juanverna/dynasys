&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE t-Persona NO-UNDO LIKE Persona.



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

DEFINE VARIABLE v-nro_persona LIKE Persona.nro_persona.

DEFINE BUFFER B-Cliente-contacto FOR Cliente-contacto.

DEFINE VAR estado AS CHAR.

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
&Scoped-define EXTERNAL-TABLES Cliente-contacto Persona Domicilio
&Scoped-define FIRST-EXTERNAL-TABLE Cliente-contacto


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente-contacto, Persona, Domicilio.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS t-Persona.tratamiento t-Persona.nombre ~
t-Persona.cdg_postal t-Persona.localidad t-Persona.direccion ~
t-Persona.provincia t-Persona.email Cliente-contacto.cdg_cargo ~
Cliente-contacto.preferido t-Persona.observacion t-Persona.palabras ~
Cliente-contacto.observaciones t-Persona.fecha_grab 
&Scoped-define ENABLED-TABLES t-Persona Cliente-contacto
&Scoped-define FIRST-ENABLED-TABLE t-Persona
&Scoped-define SECOND-ENABLED-TABLE Cliente-contacto
&Scoped-Define ENABLED-OBJECTS RECT-2 BUTTON-6 te-1 vte-1 BUTTON-11 te-2 ~
vte-2 te-3 vte-3 BUTTON-12 te-4 vte-4 BUTTON-13 
&Scoped-Define DISPLAYED-FIELDS t-Persona.tratamiento t-Persona.nombre ~
t-Persona.cdg_postal t-Persona.localidad t-Persona.direccion ~
t-Persona.provincia t-Persona.email Cliente-contacto.cdg_cargo ~
Cliente-contacto.preferido t-Persona.observacion t-Persona.palabras ~
Cliente-contacto.observaciones t-Persona.fecha_grab 
&Scoped-define DISPLAYED-TABLES t-Persona Cliente-contacto
&Scoped-define FIRST-DISPLAYED-TABLE t-Persona
&Scoped-define SECOND-DISPLAYED-TABLE Cliente-contacto
&Scoped-Define DISPLAYED-OBJECTS te-1 vte-1 te-2 vte-2 te-3 vte-3 te-4 ~
vte-4 

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD thandle V-table-Win 
FUNCTION thandle RETURNS HANDLE
  ( ppar AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 11" 
     SIZE 5 BY 1.14.

DEFINE BUTTON BUTTON-12 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 12" 
     SIZE 5 BY 1.14.

DEFINE BUTTON BUTTON-13 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 13" 
     SIZE 5 BY 1.14.

DEFINE BUTTON BUTTON-6 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 6" 
     SIZE 5 BY 1.14.

DEFINE VARIABLE te-1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 36.4 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 36.4 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 36.2 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 36.4 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130 BY 11.43.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     t-Persona.tratamiento AT ROW 1.24 COL 10.4 COLON-ALIGNED WIDGET-ID 20
          LABEL "Trat."
          VIEW-AS FILL-IN NATIVE 
          SIZE 15.6 BY 1 TOOLTIP "Sr.,Sra.,Ing,Dr....."
          BGCOLOR 15 FGCOLOR 9 
     t-Persona.nombre AT ROW 1.24 COL 36 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 91 BY 1 TOOLTIP "Nombre del contacto"
          BGCOLOR 15 FGCOLOR 9 
     t-Persona.cdg_postal AT ROW 2.43 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1 TOOLTIP "Codigo Postal"
          BGCOLOR 15 FGCOLOR 9 
     t-Persona.localidad AT ROW 2.43 COL 36 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
     t-Persona.direccion AT ROW 2.43 COL 74 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 53 BY 1 TOOLTIP "Direccion Particular"
          BGCOLOR 15 FGCOLOR 9 
     BUTTON-6 AT ROW 3.62 COL 58.6 WIDGET-ID 96
     t-Persona.provincia AT ROW 3.62 COL 74 COLON-ALIGNED FORMAT "X(25)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 53 BY 1 TOOLTIP "Provincia"
          BGCOLOR 15 FGCOLOR 9 
     te-1 AT ROW 3.71 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     vte-1 AT ROW 3.71 COL 19.6 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     BUTTON-11 AT ROW 4.71 COL 58.6 WIDGET-ID 106
     te-2 AT ROW 4.76 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     vte-2 AT ROW 4.76 COL 19.6 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     t-Persona.email AT ROW 4.91 COL 74 COLON-ALIGNED
          LABEL "E-mail" FORMAT "X(256)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 53 BY 1 TOOLTIP "Email particular"
          BGCOLOR 15 FGCOLOR 9 
     te-3 AT ROW 5.81 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     vte-3 AT ROW 5.81 COL 19.8 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     BUTTON-12 AT ROW 5.81 COL 58.8 WIDGET-ID 108
     Cliente-contacto.cdg_cargo AT ROW 6.48 COL 75 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 25 BY 1
          BGCOLOR 15 FGCOLOR 9 
     te-4 AT ROW 6.81 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     vte-4 AT ROW 6.81 COL 19.6 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     BUTTON-13 AT ROW 6.86 COL 58.8 WIDGET-ID 110
     Cliente-contacto.preferido AT ROW 6.95 COL 111 WIDGET-ID 22
          VIEW-AS TOGGLE-BOX
          SIZE 13.4 BY .81
     t-Persona.observacion AT ROW 8.14 COL 15 COLON-ALIGNED
          LABEL "Obs.Persona" FORMAT "X(256)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 113 BY .95
          BGCOLOR 15 FGCOLOR 9 
     t-Persona.palabras AT ROW 9.52 COL 15 COLON-ALIGNED WIDGET-ID 26 FORMAT "X(256)"
          VIEW-AS FILL-IN 
          SIZE 113 BY 1
     Cliente-contacto.observaciones AT ROW 10.91 COL 3 WIDGET-ID 24
          LABEL "Obs.Relacion" FORMAT "X(80)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 113 BY 1
          BGCOLOR 15 FGCOLOR 9 
     t-Persona.fecha_grab AT ROW 6.24 COL 109 COLON-ALIGNED
          LABEL "Grab."
           VIEW-AS TEXT 
          SIZE 17 BY .62
     RECT-2 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente-contacto,sic.Persona,sic.Domicilio
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
   Temp-Tables and Buffers:
      TABLE: t-Persona T "?" NO-UNDO sic Persona
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
         HEIGHT             = 11.81
         WIDTH              = 130.4.
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

/* SETTINGS FOR FILL-IN t-Persona.email IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN t-Persona.fecha_grab IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN t-Persona.observacion IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Cliente-contacto.observaciones IN FRAME F-Main
   ALIGN-L EXP-LABEL EXP-FORMAT                                         */
/* SETTINGS FOR FILL-IN t-Persona.palabras IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN t-Persona.provincia IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN t-Persona.tratamiento IN FRAME F-Main
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

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 V-table-Win
ON CHOOSE OF BUTTON-11 IN FRAME F-Main /* Button 11 */
DO:
    OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-2:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-12 V-table-Win
ON CHOOSE OF BUTTON-12 IN FRAME F-Main /* Button 12 */
DO:
  OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-3:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 V-table-Win
ON CHOOSE OF BUTTON-13 IN FRAME F-Main /* Button 13 */
DO:
  OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-4:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-6 V-table-Win
ON CHOOSE OF BUTTON-6 IN FRAME F-Main /* Button 6 */
DO:
  OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-1:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME t-Persona.email
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL t-Persona.email V-table-Win
ON LEAVE OF t-Persona.email IN FRAME F-Main /* E-mail */
DO:
  IF t-persona.email:INPUT-VALUE <> "" THEN do:
      IF num-entries(t-persona.email:INPUT-VALUE,"@") <> 2 THEN DO:
          RUN ponmensj.p ( INPUT "EMAIL01" ).
          RETURN NO-APPLY.
      END.
      IF NUM-ENTRIES( entry( 2 , t-persona.email:INPUT-VALUE , "@" ) , ".") < 2 THEN DO:
          RUN ponmensj.p (INPUT "EMAIL02").
          RETURN NO-APPLY.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME t-Persona.nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL t-Persona.nombre V-table-Win
ON HELP OF t-Persona.nombre IN FRAME F-Main /* Nombre */
DO:
  APPLY "MOUSE-MENU-DOWN" TO SELF.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL t-Persona.nombre V-table-Win
ON MOUSE-MENU-DOWN OF t-Persona.nombre IN FRAME F-Main /* Nombre */
DO:
  DEFINE VARIABLE rid_persona AS ROWID.
  DEFINE VARIABLE puso_ok     AS LOGICAL.

  RUN d-buscar_persona.w ( INPUT-OUTPUT rid_persona, OUTPUT puso_ok ).
  IF puso_ok
  THEN DO:
      FIND Persona WHERE ROWID(Persona) = rid_persona NO-LOCK NO-ERROR.
      IF AVAILABLE persona THEN DO:
        BUFFER-COPY Persona TO T-Persona.
        RUN mostrar_persona.
      END.
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
  {src/adm/template/row-list.i "Cliente-contacto"}
  {src/adm/template/row-list.i "Persona"}
  {src/adm/template/row-list.i "Domicilio"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente-contacto"}
  {src/adm/template/row-find.i "Persona"}
  {src/adm/template/row-find.i "Domicilio"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos V-table-Win 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAM YY AS LOGICAL NO-UNDO.
DO WITH FRAME {&FRAME-NAME}:
    te-1:SENSITIVE = yy.
    te-2:SENSITIVE = yy.
    te-3:SENSITIVE = yy.
    te-4:SENSITIVE = yy.
    vte-1:SENSITIVE = yy.
    vte-2:SENSITIVE = yy.
    vte-3:SENSITIVE = yy.
    vte-4:SENSITIVE = yy.
    cliente-contacto.cdg_cargo:SENSITIVE = yy.
END.
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
     {levantacombo.i &TABLA=Cargo_persona &NOMBRE=dsc_cargo &CODIGO=cdg_cargo &OBJETO=cliente-contacto.cdg_cargo}.
     FIND FIRST cargo_persona NO-LOCK NO-ERROR.
     IF AVAILABLE cargo_persona THEN
         cliente-contacto.cdg_cargo:SCREEN-VALUE = Cargo_persona.cdg_cargo.
     &SCOPED-DEFINE  CONDICION tipo_dato.Tipo="T"
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-1  }.
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-2  }.
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-3  }.
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-4  }.
     
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
     FIND FIRST cargo_persona NO-lock.
     IF AVAILABLE cargo_persona THEN
         cliente-contacto.cdg_cargo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Cargo_persona.cdg_cargo.
      FIND provincia OF Domicilio NO-LOCK NO-ERROR.
      ASSIGN t-persona.tratamiento = ""
             t-persona.nombre = ""
             t-persona.direccion = Domicilio.direccion
             t-persona.localidad = Domicilio.localidad
             t-persona.cdg_postal = Domicilio.cdg_postal
             t-persona.observacion = ""
             t-persona.email = ""
             t-persona.provincia = IF AVAILABLE provincia THEN provincia.nombre ELSE ""
             vte-1 = ""
             vte-2 = ""
             vte-3 = ""
             vte-4 = "".

display t-persona.tratamiento
          t-persona.nombre
          t-persona.direccion
          t-persona.localidad
          t-persona.observacion
          t-persona.email 
          t-persona.cdg_postal 
          vte-1 
          vte-2 
          vte-3 
          vte-4 
          WITH FRAME {&FRAME-NAME}.
estado="A".
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
  
  DEFINE VARIABLE sino    AS LOGICAL.
  DEFINE VARIABLE v-debug AS LOGICAL INITIAL NO.
  DEFINE VARIABLE rid_persona AS ROWID.
  DEFINE VARIABLE rpersona AS ROWID NO-UNDO.
  DEFINE VAR i AS INT NO-UNDO.
  IF t-persona.nombre:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" THEN DO:
      RUN ponmensj.p ( INPUT "CLIE909" ).
      RETURN ERROR.
  END.

  IF NOT CAN-FIND(Cargo_persona WHERE Cargo_persona.cdg_cargo = cliente-contacto.cdg_cargo:INPUT-VALUE IN FRAME {&FRAME-NAME})
  THEN DO:
      RUN ponmensj.p ( INPUT "CLIE908" ).
      RETURN .
  END.

/* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
 
ASSIGN FRAME {&FRAME-NAME}
          cliente-contacto.cdg_cargo
          t-persona.tratamiento
          T-Persona.cdg_postal 
          T-Persona.direccion 
          T-Persona.email 
          T-Persona.fecha_grab 
          T-Persona.localidad 
          T-Persona.nombre 
          T-Persona.observacion 
          T-Persona.provincia
          te-1
          te-2
          te-3
          te-4
          vte-1
          vte-2
          vte-3
          vte-4
          cliente-contacto.preferido.

T-Persona.numeros_telefono = "".
DO i = 1 TO 4:
    T-Persona.numeros_telefono = T-Persona.numeros_telefono + "|" +
                                 STRING(thandle("te-" + STRING(i,"9")):SCREEN-VALUE ) +
                                 "!" +
                                 STRING(thandle("vte-" + STRING(i,"9")):SCREEN-VALUE ).
END.
T-Persona.numeros_telefono = SUBSTRING(T-Persona.numeros_telefono,2 ).
rpersona = ROWID(persona).

/*FIND FIRST Persona WHERE Persona.nombre = T-Persona.nombre AND rowid(persona) <> rpersona NO-LOCK NO-ERROR.
IF AVAILABLE Persona
THEN DO:
          RUN d-persona_ambigua.w ( INPUT T-Persona.nombre, INPUT-OUTPUT rid_persona ).
          IF rid_persona = ?
          THEN DO:
              CREATE Persona.
              BUFFER-COPY T-Persona TO Persona
                  ASSIGN Persona.nro_persona = NEXT-VALUE(proxima_persona)
                         Persona.fecha_grab  = TODAY
                         t-Persona.fecha_grab  = TODAY.
          END.
          ELSE RUN mostrar_persona.
END.
ELSE DO:
    CREATE Persona.
    BUFFER-COPY T-Persona TO Persona
            ASSIGN Persona.nro_persona = NEXT-VALUE(proxima_persona)
                    Persona.fecha_grab  = TODAY
                    t-Persona.fecha_grab  = TODAY.
    rid_persona = ROWID(persona).
END.*/

FIND persona WHERE rowid(persona) = rid_persona NO-ERROR.
IF NOT AVAILABLE persona THEN DO:
    CREATE Persona.
    BUFFER-COPY T-Persona TO Persona
                ASSIGN Persona.nro_persona = NEXT-VALUE(proxima_persona)
                        Persona.fecha_grab  = TODAY
                        t-Persona.fecha_grab  = TODAY.
END.
ASSIGN 
    Persona.cdg_agenda = T-Persona.cdg_agenda  
    Persona.cdg_postal           = T-Persona.cdg_postal             
    Persona.direccion            = T-Persona.direccion              
    Persona.email                = T-Persona.email                  
    Persona.fecha_grab           = T-Persona.fecha_grab             
    Persona.hora_grab            = T-Persona.hora_grab              
    Persona.localidad            = T-Persona.localidad              
    Persona.nombre               = T-Persona.nombre                 
    Persona.numeros_telefono     = T-Persona.numeros_telefono       
    Persona.observacion          = T-Persona.observacion            
    Persona.pais                 = T-Persona.pais                   
    Persona.palabras             = T-Persona.palabras               
    Persona.pc_name              = T-Persona.pc_name                
    Persona.provincia            = T-Persona.provincia              
    Persona.secretaria           = T-Persona.secretaria             
    Persona.tratamiento          = T-Persona.tratamiento.
FIND CURRENT persona no-lock.


ASSIGN Cliente-contacto.nro_cliente   = Domicilio.nro_cliente
       Cliente-contacto.nro_Domicilio = Domicilio.nro_Domicilio
       Cliente-contacto.nro_persona = Persona.nro_persona
       Cliente-contacto.cdg_cargo.
         
         

  IF Cliente-contacto.preferido
  THEN DO:
      FOR EACH B-Cliente-contacto OF Cliente WHERE ROWID(B-Cliente-contacto) <> ROWID(Cliente-contacto):
          b-Cliente-contacto.preferido = NO.
      END.
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
/*voy a verificar que nadie mas esta utilizando esa persona en ese caso se borrara*/
/* Code placed here will execute PRIOR to standard behavior. */
DEFINE VARIABLE rid_persona AS ROWID.
rid_persona = ?.
FIND FIRST Persona WHERE Cliente-contacto.nro_persona = Persona.nro_persona NO-LOCK NO-ERROR.
IF AVAILABLE persona THEN 
DO:
    FIND FIRST B-Cliente-contacto WHERE B-Cliente-contacto.nro_persona = Persona.nro_persona AND ROWID(B-Cliente-contacto) <> ROWID(Cliente-contacto) NO-LOCK NO-ERROR.
    IF NOT AVAILABLE b-cliente-contacto THEN DO:
        MESSAGE "Esta persona no figura relacionada con ningun otro contacto" skip(1)
            "Desea eliminarla del sistema?"
                  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
                        TITLE "" UPDATE choice AS LOGICAL.
          IF choice THEN rid_persona = ROWID(persona).
    END.
END.
/* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'delete-record':U ) .
  IF rid_persona <> ? THEN DO:
    FIND persona WHERE rowid(persona) = rid_persona.
    DELETE persona.
  END.
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
  RUN habilitar_campos(FALSE).
  /* Code placed here will execute AFTER standard behavior.    */
  
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
  
  EMPTY TEMP-TABLE T-Persona.
  FIND Persona OF Cliente-contacto NO-LOCK NO-ERROR.
  IF AVAILABLE persona THEN DO:

      CREATE T-Persona.
      
      BUFFER-COPY Persona TO T-Persona.
  END.
  RUN mostrar_persona.
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
  RUN habilitar_campos(TRUE).
  /* Code placed here will execute AFTER standard behavior.    */

  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-end-update V-table-Win 
PROCEDURE local-end-update :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'end-update':U ) .
RUN new-state ('refrescar':U).
  /* Code placed here will execute AFTER standard behavior.    */

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
DEF VAR i AS INT NO-UNDO.
DEF VAR aux AS CHAR NO-UNDO.
RUN inicia_combos.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    DO i = 1 TO 4:
      RUN getparametro_c.p ("CDG-TE" + STRING(i,"9"),OUTPUT aux).
      thandle("te-" + STRING(i,"9")):SCREEN-VALUE = aux.
      thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = "".
  END.
  RUN habilitar_campos(FALSE).
  estado="".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE mostrar_persona V-table-Win 
PROCEDURE mostrar_persona :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR i AS INT NO-UNDO.
DEF VAR aux AS CHAR NO-UNDO.
/*elimina los posible errores de migraciones y/o cargas*/
IF NOT AVAILABLE t-persona THEN RETURN.
IF INDEX(t-persona.numeros_telefono,"!") = 0 THEN DO:
    RUN getparametro_c.p ("CDG-TE1",OUTPUT aux).
    t-persona.numeros_telefono = replace(aux + "!" + t-persona.numeros_telefono,"|","%").

END.

DO i = 1 TO 4:
     IF i <= NUM-ENTRIES(t-persona.numeros_telefono,"|") THEN DO:
          thandle("te-" + STRING(i,"9")):SCREEN-VALUE = entry(1,ENTRY(i,t-persona.numeros_telefono,"|"),"!").
          thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = entry(2,ENTRY(i,t-persona.numeros_telefono,"|"),"!").
     END.
     ELSE DO:
          RUN getparametro_c.p ("CDG-TE" + STRING(i,"9"),OUTPUT aux).
          thandle("te-" + STRING(i,"9")):SCREEN-VALUE = aux.
          thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = "".
          
     END.
END. 
      display T-Persona.cdg_postal 
              T-Persona.tratamiento
              T-Persona.direccion 
              T-Persona.email 
              T-Persona.fecha_grab 
              T-Persona.localidad 
              T-Persona.nombre 
              T-Persona.observacion 
              T-Persona.provincia
              t-Persona.fecha_grab 
              t-Persona.palabras
              t-persona.observacion
              cliente-contacto.preferido WITH FRAME {&FRAME-NAME}.
              
      IF AVAILABLE cargo_persona THEN
              DISPLAY cliente-contacto.cdg_cargo WITH FRAME {&FRAME-NAME}.
      /*ASSIGN FRAME {&FRAME-NAME} te-1 te-2 te-3 te-4 vte-1 vte-2 vte-3 vte-4.*/
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
  {src/adm/template/snd-list.i "Cliente-contacto"}
  {src/adm/template/snd-list.i "Persona"}
  {src/adm/template/snd-list.i "Domicilio"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION thandle V-table-Win 
FUNCTION thandle RETURNS HANDLE
  ( ppar AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

CASE ppar:
    WHEN "te-1" THEN RETURN te-1:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "te-2" THEN RETURN te-2:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "te-3" THEN RETURN te-3:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "te-4" THEN RETURN te-4:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-1" THEN RETURN vte-1:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-2" THEN RETURN vte-2:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-3" THEN RETURN vte-3:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-4" THEN RETURN vte-4:HANDLE IN FRAME {&FRAME-NAME}.

    OTHERWISE do: RETURN ?. END.
END CASE.


  RETURN ?.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

