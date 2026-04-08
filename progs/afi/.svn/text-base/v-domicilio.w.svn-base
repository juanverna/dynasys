&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          padron           PROGRESS
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

DEFINE VARIABLE rid_tabla AS ROWID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Grupo-domicilio Grupofam
&Scoped-define FIRST-EXTERNAL-TABLE Grupo-domicilio


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Grupo-domicilio, Grupofam.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Grupo-domicilio.num_domicilio ~
Grupo-domicilio.calle Grupo-domicilio.nropta Grupo-domicilio.piso ~
Grupo-domicilio.depto Grupo-domicilio.casa Grupo-domicilio.barrio ~
Grupo-domicilio.monoblk Grupo-domicilio.prefijotel Grupo-domicilio.telefono ~
Grupo-domicilio.cdg_zonag Grupo-domicilio.entre1 Grupo-domicilio.cdg_postal ~
Grupo-domicilio.entre2 Grupo-domicilio.cdg_provincia Grupo-domicilio.refer 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}num_domicilio ~{&FP2}num_domicilio ~{&FP3}~
 ~{&FP1}calle ~{&FP2}calle ~{&FP3}~
 ~{&FP1}nropta ~{&FP2}nropta ~{&FP3}~
 ~{&FP1}piso ~{&FP2}piso ~{&FP3}~
 ~{&FP1}depto ~{&FP2}depto ~{&FP3}~
 ~{&FP1}casa ~{&FP2}casa ~{&FP3}~
 ~{&FP1}barrio ~{&FP2}barrio ~{&FP3}~
 ~{&FP1}monoblk ~{&FP2}monoblk ~{&FP3}~
 ~{&FP1}prefijotel ~{&FP2}prefijotel ~{&FP3}~
 ~{&FP1}telefono ~{&FP2}telefono ~{&FP3}~
 ~{&FP1}cdg_zonag ~{&FP2}cdg_zonag ~{&FP3}~
 ~{&FP1}entre1 ~{&FP2}entre1 ~{&FP3}~
 ~{&FP1}cdg_postal ~{&FP2}cdg_postal ~{&FP3}~
 ~{&FP1}entre2 ~{&FP2}entre2 ~{&FP3}~
 ~{&FP1}cdg_provincia ~{&FP2}cdg_provincia ~{&FP3}~
 ~{&FP1}refer ~{&FP2}refer ~{&FP3}
&Scoped-define ENABLED-TABLES Grupo-domicilio
&Scoped-define FIRST-ENABLED-TABLE Grupo-domicilio
&Scoped-Define ENABLED-OBJECTS RECT-4 v-cdg_localidad 
&Scoped-Define DISPLAYED-FIELDS Grupo-domicilio.num_domicilio ~
Grupo-domicilio.calle Grupo-domicilio.nropta Grupo-domicilio.piso ~
Grupo-domicilio.depto Grupo-domicilio.casa Grupo-domicilio.barrio ~
Grupo-domicilio.monoblk Grupo-domicilio.prefijotel Grupo-domicilio.telefono ~
Grupo-domicilio.cdg_zonag Grupo-domicilio.entre1 Grupo-domicilio.cdg_postal ~
Grupo-domicilio.entre2 Grupo-domicilio.cdg_provincia Grupo-domicilio.refer 
&Scoped-Define DISPLAYED-OBJECTS v-tipo v-cdg_localidad v-dsc_localidad 

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
DEFINE VARIABLE v-tipo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS " "
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_localidad AS CHARACTER FORMAT "X(25)" 
     LABEL "Localidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY .81
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_localidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .81
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 63 BY 10.23.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Grupo-domicilio.num_domicilio AT ROW 1.27 COL 11 COLON-ALIGNED
          LABEL "Nro."
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     v-tipo AT ROW 1.27 COL 44 COLON-ALIGNED
     Grupo-domicilio.calle AT ROW 2.35 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.nropta AT ROW 2.35 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.piso AT ROW 3.42 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.depto AT ROW 3.42 COL 33 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.casa AT ROW 3.42 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.barrio AT ROW 4.5 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 27 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.monoblk AT ROW 4.5 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.prefijotel AT ROW 5.58 COL 11 COLON-ALIGNED
          LABEL "Tel."
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.telefono AT ROW 5.58 COL 20 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.cdg_zonag AT ROW 5.58 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_localidad AT ROW 6.65 COL 11 COLON-ALIGNED
     v-dsc_localidad AT ROW 6.65 COL 20 COLON-ALIGNED NO-LABEL
     Grupo-domicilio.entre1 AT ROW 7.73 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 26.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.cdg_postal AT ROW 7.73 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.entre2 AT ROW 8.81 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 26.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.cdg_provincia AT ROW 8.81 COL 50 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupo-domicilio.refer AT ROW 9.88 COL 11 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY .81
          BGCOLOR 15 FGCOLOR 9 
     RECT-4 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: padron.Grupo-domicilio,padron.Grupofam
   Allow: Basic,DB-Fields
   Frames: 1
   Add Fields to: EXTERNAL-TABLES
   Other Settings: PERSISTENT-ONLY COMPILE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT."
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW V-table-Win ASSIGN
         HEIGHT             = 12.85
         WIDTH              = 63.72.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW V-table-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE Size-to-Fit                                              */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Grupo-domicilio.num_domicilio IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupo-domicilio.prefijotel IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-dsc_localidad IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-tipo IN FRAME F-Main
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

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Grupo-domicilio.cdg_zonag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Grupo-domicilio.cdg_zonag V-table-Win
ON LEAVE OF Grupo-domicilio.cdg_zonag IN FRAME F-Main /* Zona */
DO:
  DO WITH FRAME {&FRAME-NAME}:
     IF LENGTH(Grupo-domicilio.cdg_zona:SCREEN-VALUE) < 4
     THEN DO:
          Grupo-domicilio.cdg_zonag:SCREEN-VALUE = 
                    Grupofam.cdg_empresa + 
                    STRING(INTEGER(Grupo-domicilio.cdg_zonag:SCREEN-VALUE), "999").
     END.
  END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_localidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_localidad V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_localidad IN FRAME F-Main /* Localidad */
OR "." OF v-cdg_localidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_localidad IN FRAME {&FRAME-NAME}
DO:
   {helptabla.i "Localidad" "cdg_localidad" "SELLOCAL.P"}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_localidad V-table-Win
ON RETURN OF v-cdg_localidad IN FRAME F-Main /* Localidad */
DO:
    {traducetabla.i "Localidad" "cdg_localidad" "dsc_localidad"} 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE actualizar_domicilio V-table-Win 
PROCEDURE actualizar_domicilio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

        FIND Cliente OF Grupofam EXCLUSIVE-LOCK.
        FIND FIRST Domicilio OF Cliente EXCLUSIVE-LOCK NO-ERROR.
        IF NOT AVAILABLE Domicilio 
           THEN CREATE Domicilio.

        ASSIGN Domicilio.cdg_pais       = 1
               Domicilio.cdg_postal     = Grupo-domicilio.cdg_postal
               Domicilio.cdg_provincia  = Grupo-domicilio.cdg_provincia
               Domicilio.cdg_recorrido  = "1"
               Domicilio.cdg_zonag      = Grupo-domicilio.cdg_zonag
               Domicilio.dias_entrega   = ""
               Domicilio.direccion      = Grupo-domicilio.calle +
                                          " " +
                                          Grupo-domicilio.nropta + 
                                          " " +
                                          Grupo-domicilio.piso + 
                                          " " +
                                          Grupo-domicilio.depto 
                                          
               Domicilio.email          = ""
               Domicilio.envio          = YES
               Domicilio.factura        = YES /*
               Domicilio.localidad      = Grupo-domicilio.*/
               Domicilio.nombre         = Grupofam.nom_grupofam
               Domicilio.nro_cliente    = Cliente.nro_cliente
               Domicilio.nro_domicilio  = 1
               Domicilio.telefono       = Grupo-domicilio.prefijotel + 
                                          "-" +
                                          Grupo-domicilio.telefono
                                          
               Cliente.ult_domicilio    = 1.

        FIND CURRENT Grupofam EXCLUSIVE-LOCK.
        Grupofam.cdg_zonag = Grupo-domicilio.cdg_zonag.
        FIND CURRENT Grupofam NO-LOCK.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available V-table-Win _ADM-ROW-AVAILABLE
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
  {src/adm/template/row-list.i "Grupo-domicilio"}
  {src/adm/template/row-list.i "Grupofam"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Grupo-domicilio"}
  {src/adm/template/row-find.i "Grupofam"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI V-table-Win _DEFAULT-DISABLE
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

  v-dsc_localidad = "".
  v-cdg_localidad = "".

  DISPLAY v-dsc_localidad
          v-cdg_localidad = ""
          WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE BUFFER B-Domicilio FOR Grupo-domicilio.

  /* Code placed here will execute PRIOR to standard behavior. */

    IF CAN-FIND(FIRST B-Domicilio OF Grupofam
              WHERE ROWID(B-Domicilio) <> ROWID(Grupo-domicilio)
                    AND B-Domicilio.num_domicilio = INTEGER(Grupo-domicilio.num_domicilio:SCREEN-VALUE IN FRAME {&FRAME-NAME}))
    THEN DO:
        RUN ponmensj.p ( INPUT "GRUF015").
        RETURN ERROR.
    END.                      

    FIND Tipodom WHERE v-tipo:SCREEN-VALUE IN FRAME {&FRAME-NAME}= Tipodom.dsc_tipodom NO-LOCK.
    
    IF Tipodom.cdg_tipodom <> "C" 
    THEN DO:
          IF NOT CAN-FIND(FIRST B-Domicilio OF Grupofam 
                                WHERE B-Domicilio.cdg_tipodom = "C" 
                                  AND ROWID(B-Domicilio) <> ROWID(Grupo-domicilio))
          THEN DO:
               RUN ponmensj.p ( INPUT "GRUF016").
               RETURN ERROR.
          END.
    END.
    ELSE DO:
          IF CAN-FIND(FIRST B-Domicilio OF Grupofam 
                            WHERE B-Domicilio.cdg_tipodom = "C" 
                              AND ROWID(B-Domicilio) <> ROWID(Grupo-domicilio))
          THEN DO:
               RUN ponmensj.p ( INPUT "GRUF017").
               RETURN ERROR.
          END.
    END.
    
    
    IF NOT CAN-FIND(FIRST Localidad 
                      WHERE Localidad.cdg_localidad = v-cdg_localidad:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF012").
         RETURN ERROR.
    END.                      
    
    
    IF NOT CAN-FIND(FIRST Provincia 
                      WHERE Provincia.cdg_provincia = Grupo-domicilio.cdg_provincia:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF013").
         RETURN ERROR.
    END.                      

    IF NOT CAN-FIND(FIRST Zona_cobranza 
                      WHERE Zona_cobranza.cdg_zonag = Grupo-domicilio.cdg_zonag:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF018").
         RETURN ERROR.
    END.                      

    {creahistoria.i &MAESTRO=Grupo-domicilio &HISTORICA=Hst_domicilio}

  /* Dispatch standard ADM method.                             */
    RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    IF NEW Grupo-domicilio
    THEN DO:
         ASSIGN
              Grupo-domicilio.cdg_empresa   = Grupofam.cdg_empresa
              Grupo-domicilio.cdg_grupofam  = Grupofam.cdg_grupofam.
    END.
    
    Grupo-domicilio.cdg_tipodom   = Tipodom.cdg_tipodom.
    Grupo-domicilio.cdg_localidad = v-cdg_localidad:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    IF Tipodom.cdg_tipodom = "C" 
       THEN RUN actualizar_domicilio.

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

  v-tipo:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  v-cdg_localidad:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  IF AVAILABLE Grupo-domicilio
  THEN DO:
       FIND Tipodom WHERE Tipodom.cdg_tipodom = Grupo-domicilio.cdg_tipodom NO-LOCK.
       IF v-tipo:LIST-ITEMS IN FRAME {&FRAME-NAME} <> ? 
          THEN v-tipo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Tipodom.dsc_tipodom.
       FIND Localidad WHERE Localidad.cdg_localidad = Grupo-domicilio.cdg_localidad NO-LOCK NO-ERROR.
       IF AVAILABLE Localidad
       THEN DO:
             v-dsc_localidad = Localidad.dsc_localidad.
             v-cdg_localidad = Localidad.cdg_localidad.
             DISPLAY v-dsc_localidad
                     v-cdg_localidad
                     WITH FRAME {&FRAME-NAME}.
       END.      
  END.
  ELSE DO:

       v-dsc_localidad = "".
       v-cdg_localidad = "".
       DISPLAY v-dsc_localidad
               v-cdg_localidad
               WITH FRAME {&FRAME-NAME}.

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

  v-tipo:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
  v-cdg_localidad:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE xx AS CHARACTER.
 
  DO WITH FRAME {&FRAME-NAME}:

     OPEN QUERY q_tipo FOR EACH Tipodom.
     GET FIRST q_tipo.
     xx = Tipodom.dsc_tipodom. /* Guarda el primero para usar como default */

     ASSIGN v-tipo:DELIMITER = "!".
            
     DO WHILE AVAILABLE Tipodom:
        ok = v-tipo:ADD-LAST(Tipodom.dsc_tipodom).
        GET NEXT q_tipo.
     END.

     ASSIGN v-tipo:SCREEN-VALUE = xx.

  END.          


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records V-table-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Grupo-domicilio"}
  {src/adm/template/snd-list.i "Grupofam"}

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


