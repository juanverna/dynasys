&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic           PROGRESS
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Afiliado Grupofam
&Scoped-define FIRST-EXTERNAL-TABLE Afiliado


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Afiliado, Grupofam.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Afiliado.num_integrante Afiliado.cdg_afiliado ~
Afiliado.num_carnet Afiliado.nom_afiliado Afiliado.cdg_categoria ~
Afiliado.calle_emr Afiliado.nropta_emr Afiliado.piso_emr Afiliado.depto_emr ~
Afiliado.casa_emr Afiliado.barrio_emr Afiliado.monoblk_emr ~
Afiliado.prefijotel_emr Afiliado.telefono_emr Afiliado.sexo ~
Afiliado.cdg_localidad Afiliado.cdg_postal Afiliado.cdg_provincia ~
Afiliado.entre1_emr Afiliado.entre2_emr Afiliado.refer_emr ~
Afiliado.num_documento Afiliado.fecha_nac Afiliado.fecha_alta ~
Afiliado.fecha_baja Afiliado.titular Afiliado.cdg_estado 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}num_integrante ~{&FP2}num_integrante ~{&FP3}~
 ~{&FP1}cdg_afiliado ~{&FP2}cdg_afiliado ~{&FP3}~
 ~{&FP1}num_carnet ~{&FP2}num_carnet ~{&FP3}~
 ~{&FP1}nom_afiliado ~{&FP2}nom_afiliado ~{&FP3}~
 ~{&FP1}cdg_categoria ~{&FP2}cdg_categoria ~{&FP3}~
 ~{&FP1}calle_emr ~{&FP2}calle_emr ~{&FP3}~
 ~{&FP1}nropta_emr ~{&FP2}nropta_emr ~{&FP3}~
 ~{&FP1}piso_emr ~{&FP2}piso_emr ~{&FP3}~
 ~{&FP1}depto_emr ~{&FP2}depto_emr ~{&FP3}~
 ~{&FP1}casa_emr ~{&FP2}casa_emr ~{&FP3}~
 ~{&FP1}barrio_emr ~{&FP2}barrio_emr ~{&FP3}~
 ~{&FP1}monoblk_emr ~{&FP2}monoblk_emr ~{&FP3}~
 ~{&FP1}prefijotel_emr ~{&FP2}prefijotel_emr ~{&FP3}~
 ~{&FP1}telefono_emr ~{&FP2}telefono_emr ~{&FP3}~
 ~{&FP1}cdg_localidad ~{&FP2}cdg_localidad ~{&FP3}~
 ~{&FP1}cdg_postal ~{&FP2}cdg_postal ~{&FP3}~
 ~{&FP1}cdg_provincia ~{&FP2}cdg_provincia ~{&FP3}~
 ~{&FP1}entre1_emr ~{&FP2}entre1_emr ~{&FP3}~
 ~{&FP1}entre2_emr ~{&FP2}entre2_emr ~{&FP3}~
 ~{&FP1}refer_emr ~{&FP2}refer_emr ~{&FP3}~
 ~{&FP1}num_documento ~{&FP2}num_documento ~{&FP3}~
 ~{&FP1}fecha_nac ~{&FP2}fecha_nac ~{&FP3}~
 ~{&FP1}fecha_alta ~{&FP2}fecha_alta ~{&FP3}~
 ~{&FP1}fecha_baja ~{&FP2}fecha_baja ~{&FP3}
&Scoped-define ENABLED-TABLES Afiliado
&Scoped-define FIRST-ENABLED-TABLE Afiliado
&Scoped-Define ENABLED-OBJECTS RECT-9 btn_credencial 
&Scoped-Define DISPLAYED-FIELDS Afiliado.num_integrante ~
Afiliado.cdg_afiliado Afiliado.num_carnet Afiliado.nom_afiliado ~
Afiliado.cdg_categoria Afiliado.calle_emr Afiliado.nropta_emr ~
Afiliado.piso_emr Afiliado.depto_emr Afiliado.casa_emr Afiliado.barrio_emr ~
Afiliado.monoblk_emr Afiliado.prefijotel_emr Afiliado.telefono_emr ~
Afiliado.sexo Afiliado.cdg_localidad Afiliado.cdg_postal ~
Afiliado.cdg_provincia Afiliado.entre1_emr Afiliado.entre2_emr ~
Afiliado.refer_emr Afiliado.num_documento Afiliado.fecha_nac ~
Afiliado.fecha_alta Afiliado.fecha_baja Afiliado.titular ~
Afiliado.cdg_estado 

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
DEFINE BUTTON btn_copdomicilio 
     LABEL "&Copiar Domicilio" 
     SIZE 18 BY .81.

DEFINE BUTTON btn_credencial 
     LABEL "&Pedir Credencial" 
     SIZE 18 BY .81.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 67 BY 13.19.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Afiliado.num_integrante AT ROW 1.27 COL 12 COLON-ALIGNED
          LABEL "Integrante"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.cdg_afiliado AT ROW 1.27 COL 28 COLON-ALIGNED
          LABEL "Código" FORMAT "X(15)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.num_carnet AT ROW 1.27 COL 51 COLON-ALIGNED
          LABEL "Carnet" FORMAT "X(14)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 12 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.nom_afiliado AT ROW 2.35 COL 12 COLON-ALIGNED
          LABEL "Nombre"
          VIEW-AS FILL-IN NATIVE 
          SIZE 38 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.cdg_categoria AT ROW 2.35 COL 55 COLON-ALIGNED
          LABEL "Cat." FORMAT ">>9"
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.calle_emr AT ROW 3.42 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 30 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.nropta_emr AT ROW 3.42 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.piso_emr AT ROW 4.5 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.depto_emr AT ROW 4.5 COL 37 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.casa_emr AT ROW 4.5 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.barrio_emr AT ROW 5.58 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 30 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.monoblk_emr AT ROW 5.58 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.prefijotel_emr AT ROW 6.65 COL 12 COLON-ALIGNED
          LABEL "Tel."
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.telefono_emr AT ROW 6.65 COL 21 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN NATIVE 
          SIZE 21 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.sexo AT ROW 6.65 COL 49 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Masc.", "M":U,
"Fem.", "F":U
          SIZE 16 BY .81
     Afiliado.cdg_localidad AT ROW 7.73 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.cdg_postal AT ROW 7.73 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.cdg_provincia AT ROW 7.73 COL 55 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.entre1_emr AT ROW 8.81 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 30 BY .81
          BGCOLOR 15 FGCOLOR 9 
     btn_copdomicilio AT ROW 8.81 COL 47
     Afiliado.entre2_emr AT ROW 9.88 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 30 BY .81
          BGCOLOR 15 FGCOLOR 9 
.
/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     btn_credencial AT ROW 9.88 COL 47
     Afiliado.refer_emr AT ROW 10.96 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 30 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.num_documento AT ROW 10.96 COL 53 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.fecha_nac AT ROW 12.04 COL 12 COLON-ALIGNED
          LABEL "Nacimiento"
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.fecha_alta AT ROW 12.04 COL 32 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.fecha_baja AT ROW 12.04 COL 53 COLON-ALIGNED
          LABEL "Baja"
          VIEW-AS FILL-IN NATIVE 
          SIZE 9.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Afiliado.titular AT ROW 13.12 COL 14
          VIEW-AS TOGGLE-BOX
          SIZE 11.72 BY .77
     Afiliado.cdg_estado AT ROW 13.12 COL 33 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Activo", "A":U,
"Baja", "B":U,
"Suspendido", "S":U
          SIZE 32 BY .81
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Afiliado,sic.Grupofam
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
         HEIGHT             = 14.96
         WIDTH              = 75.
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

/* SETTINGS FOR BUTTON btn_copdomicilio IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Afiliado.cdg_afiliado IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Afiliado.cdg_categoria IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Afiliado.fecha_baja IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Afiliado.fecha_nac IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Afiliado.nom_afiliado IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Afiliado.num_carnet IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Afiliado.num_integrante IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Afiliado.prefijotel_emr IN FRAME F-Main
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

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB V-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/viewer.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME btn_copdomicilio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_copdomicilio V-table-Win
ON CHOOSE OF btn_copdomicilio IN FRAME F-Main /* Copiar Domicilio */
DO:
  FIND FIRST Grupo-domicilio OF Grupofam WHERE Grupo-domicilio.cdg_tipodom = "P" NO-LOCK NO-ERROR.
  IF AVAILABLE Grupo-domicilio
  THEN DO:
       RUN copiar_domicilio.
  END.
  ELSE DO:
        FIND FIRST Grupo-domicilio OF Grupofam 
             WHERE Grupo-domicilio.cdg_tipodom = "C" NO-LOCK NO-ERROR.
 
        IF NOT AVAILABLE Grupo-domicilio
        THEN DO:
             MESSAGE "No se halló el domicilio de Prestación ni el de Cobranza"
                     VIEW-AS ALERT-BOX ERROR.
             RETURN NO-APPLY.      
        END.
        ELSE DO:
             RUN copiar_domicilio.
        END.

  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_credencial
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_credencial V-table-Win
ON CHOOSE OF btn_credencial IN FRAME F-Main /* Pedir Credencial */
DO:
  RUN pedir_credencial.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE actualizar_cliente V-table-Win 
PROCEDURE actualizar_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Cliente OF Grupofam /*WHERE Cliente.cdg_cliente  = 
                     Grupofam.cdg_empresa + Grupofam.cdg_grupofam */
                     EXCLUSIVE-LOCK.
  ASSIGN Cliente.nom_cliente  = Grupofam.nom_grupofam.


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
  {src/adm/template/row-list.i "Afiliado"}
  {src/adm/template/row-list.i "Grupofam"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Afiliado"}
  {src/adm/template/row-find.i "Grupofam"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE copiar_domicilio V-table-Win 
PROCEDURE copiar_domicilio :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:
  
     ASSIGN
        Afiliado.barrio_emr:SCREEN-VALUE = Grupo-domicilio.barrio 
        Afiliado.calle_emr:SCREEN-VALUE = Grupo-domicilio.calle 
        Afiliado.casa_emr:SCREEN-VALUE = Grupo-domicilio.casa 
        Afiliado.cdg_localidad:SCREEN-VALUE = Grupo-domicilio.cdg_localidad  
        Afiliado.cdg_postal:SCREEN-VALUE = Grupo-domicilio.cdg_postal  
        Afiliado.cdg_provincia:SCREEN-VALUE = Grupo-domicilio.cdg_provincia  
        Afiliado.depto_emr:SCREEN-VALUE = Grupo-domicilio.depto 
        Afiliado.entre1_emr:SCREEN-VALUE = Grupo-domicilio.entre1 
        Afiliado.entre2_emr:SCREEN-VALUE = Grupo-domicilio.entre2 
        Afiliado.monoblk_emr:SCREEN-VALUE = Grupo-domicilio.monoblk 
        Afiliado.nropta_emr:SCREEN-VALUE = Grupo-domicilio.nropta 
        Afiliado.piso_emr:SCREEN-VALUE = Grupo-domicilio.piso 
        Afiliado.prefijotel_emr:SCREEN-VALUE = Grupo-domicilio.prefijotel 
        Afiliado.refer_emr:SCREEN-VALUE = Grupo-domicilio.refer 
        Afiliado.telefono_emr:SCREEN-VALUE = Grupo-domicilio.telefono.
  
  END.


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

  Afiliado.cdg_estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "A".

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

    DEFINE BUFFER B-Afiliado FOR Afiliado.
    DEFINE VARIABLE v-num_integrante LIKE Afiliado.num_integrante.
     
      
    IF CAN-FIND(FIRST B-Afiliado 
                      WHERE ROWID(B-Afiliado) <> ROWID(Afiliado)
                        AND B-Afiliado.cdg_afiliado = Afiliado.cdg_afiliado:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                        AND B-Afiliado.cdg_empresa  = Grupofam.cdg_empresa)
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF011").
         RETURN ERROR.
    END.                      

    /*
    IF NOT CAN-FIND(FIRST Localidad 
                      WHERE Localidad.cdg_localidad = Afiliado.cdg_localidad:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF012").
         RETURN ERROR.
    END.                      
    */

    IF NOT CAN-FIND(FIRST Provincia 
                      WHERE Provincia.cdg_provincia = Afiliado.cdg_provincia:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF013").
         RETURN ERROR.
    END.                      
    
    FIND LAST B-Afiliado OF Grupofam USE-INDEX por_grupo NO-LOCK NO-ERROR.
    IF AVAILABLE B-Afiliado 
       THEN v-num_integrante = B-Afiliado.num_integrante + 1.
       ELSE v-num_integrante = 1.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    IF NEW Afiliado
    THEN DO:
         ASSIGN
              Afiliado.cdg_grupofam   = Grupofam.cdg_grupofam
              Afiliado.cdg_empresa    = Grupofam.cdg_empresa
              Afiliado.nro_afiliado   = NEXT-VALUE(proximo_afiliado)
              Afiliado.num_integrante = v-num_integrante.
    
         Afiliado.cdg_afiliado = Grupofam.cdg_grupofam + "-" + 
                                 STRING(Afiliado.num_integrante,"9999").
    
         IF Afiliado.num_carnet:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
            THEN Afiliado.num_carnet = Afiliado.cdg_afiliado.
    
         RUN pedir_credencial.       
    
    END.
    /*
    IF Afiliado.titular
    THEN DO:
         IF NOT Grupofam.nombre_fijo
         THEN DO:
              FIND CURRENT Grupofam EXCLUSIVE-LOCK.
              Grupofam.nom_grupofam = Afiliado.nom_afiliado.
              FIND CURRENT Grupofam NO-LOCK.
         END.
         RUN actualizar_cliente.
    END.
    */
    
    IF Afiliado.cdg_estado = "B"
    THEN DO:
         FOR EACH Pedido_credencial OF Afiliado 
             WHERE Pedido_credencial.cumplido <> "C" EXCLUSIVE-LOCK:
             DELETE Pedido_credencial.
         END.
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

  /* Code placed here will execute AFTER standard behavior.    */

  btn_copdomicilio:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  IF AVAILABLE Afiliado
    THEN btn_credencial:SENSITIVE IN FRAME {&FRAME-NAME} = 
         NOT CAN-FIND(FIRST Pedido_credencial OF Afiliado WHERE Pedido_credencial.cumplido = "").
    ELSE btn_credencial:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  btn_copdomicilio:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pedir_credencial V-table-Win 
PROCEDURE pedir_credencial :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO ON ERROR UNDO, RETURN ERROR:
  
     CREATE Pedido_credencial.
     ASSIGN Pedido_credencial.fecha_alta    = TODAY
            Pedido_credencial.hms_alta      = STRING(TIME,"HH:MM:SS")
            Pedido_credencial.nro_afiliado  = Afiliado.nro_afiliado
            Pedido_credencial.cdg_empresa   = Afiliado.cdg_empresa
            /*Pedido_credencial.Usuario  = USERID("sic")*/.
     UPDATE Pedido_credencial.observacion NO-LABEL FGCOLOR 9 BGCOLOR 15
            VIEW-AS EDITOR SIZE 50 BY 4
            WITH FRAME f-observación VIEW-AS DIALOG-BOX THREE-D
                 TITLE "Ingrese observaciones y Oprima F2".
                        
     MESSAGE "Pedido de credenciales registrado"
             VIEW-AS ALERT-BOX MESSAGE TITLE "Confirmación".
  
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
  {src/adm/template/snd-list.i "Afiliado"}
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


