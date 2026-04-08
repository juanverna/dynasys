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

DEFINE VARIABLE rid_tabla AS ROWID.
DEFINE VARIABLE v-lista_empresas LIKE Usuario.lista_empresas.

DEFINE VAR hcproc AS CHARACTER NO-UNDO.
DEFINE VAR hproc AS HANDLE NO-UNDO.

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
&Scoped-define EXTERNAL-TABLES Usuario
&Scoped-define FIRST-EXTERNAL-TABLE Usuario


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Usuario.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Usuario.cdg_grupousr Usuario.cdg_empresa ~
Usuario.estado Usuario.nombre Usuario.observacion Usuario.seguimiento ~
Usuario.dias_clave Usuario.nivel_confidencial Usuario.cant_loginerroneos ~
Usuario.dias_inactivo Usuario.cant_clavesrepetidas Usuario.mostrar_frase 
&Scoped-define ENABLED-TABLES Usuario
&Scoped-define FIRST-ENABLED-TABLE Usuario
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Usuario.cdg_usuario Usuario.cdg_grupousr ~
Usuario.cdg_empresa Usuario.estado Usuario.nombre Usuario.fch_ultimologin ~
Usuario.observacion Usuario.seguimiento Usuario.estaciones_habilitadas ~
Usuario.cambiar_clave Usuario.fch_ultimaclave Usuario.dias_clave ~
Usuario.nivel_confidencial Usuario.cant_loginerroneos Usuario.dias_inactivo ~
Usuario.cant_clavesrepetidas Usuario.mostrar_frase 
&Scoped-define DISPLAYED-TABLES Usuario
&Scoped-define FIRST-DISPLAYED-TABLE Usuario
&Scoped-Define DISPLAYED-OBJECTS v-resetear v-clave 

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
DEFINE VARIABLE v-clave AS CHARACTER FORMAT "X(16)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 14 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 122 BY 13.1.

DEFINE VARIABLE v-resetear AS LOGICAL INITIAL no 
     LABEL "Asignar al usuario esta clave ----->" 
     VIEW-AS TOGGLE-BOX
     SIZE 36 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-resetear AT ROW 9.1 COL 19
     Usuario.cdg_usuario AT ROW 1.52 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.cdg_grupousr AT ROW 1.48 COL 44 COLON-ALIGNED
          LABEL "Grupo"
          VIEW-AS FILL-IN NATIVE 
          SIZE 19 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.cdg_empresa AT ROW 1.48 COL 78 COLON-ALIGNED
          LABEL "Emp.Actual"
          VIEW-AS FILL-IN NATIVE 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.estado AT ROW 1.48 COL 100 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Activo","A",
                     "Suspendido","S",
                     "Inactivo","I"
          DROP-DOWN-LIST
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.nombre AT ROW 2.67 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 69 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.fch_ultimologin AT ROW 2.67 COL 100 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.observacion AT ROW 3.86 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 100 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.seguimiento AT ROW 6.24 COL 19
          LABEL "Registrar el uso de items de menú del usuario"
          VIEW-AS TOGGLE-BOX
          SIZE 48 BY .81
     Usuario.estaciones_habilitadas AT ROW 6.24 COL 71 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 48 BY 7.38
          BGCOLOR 15 FGCOLOR 7 
     Usuario.cambiar_clave AT ROW 8.14 COL 19
          LABEL "El usuario debe cambiar la clave en próximo login"
          VIEW-AS TOGGLE-BOX
          SIZE 51 BY .81
     v-clave AT ROW 9.1 COL 54 COLON-ALIGNED NO-LABEL BLANK 
     Usuario.fch_ultimaclave AT ROW 10.29 COL 17 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.dias_clave AT ROW 11.48 COL 17 COLON-ALIGNED
          LABEL "Vigencia"
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.nivel_confidencial AT ROW 10.29 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.cant_loginerroneos AT ROW 12.67 COL 17 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.dias_inactivo AT ROW 11.48 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.cant_clavesrepetidas AT ROW 12.67 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Usuario.mostrar_frase AT ROW 7.19 COL 19
          LABEL "Mostrar frase de bienvenida en el login"
          VIEW-AS TOGGLE-BOX
          SIZE 51 BY .81
     "dias" VIEW-AS TEXT
          SIZE 8 BY .86 AT ROW 11.48 COL 26
     "veces" VIEW-AS TEXT
          SIZE 8 BY .86 AT ROW 12.67 COL 26
     "          Estaciones habilitadas para este usuario" VIEW-AS TEXT
          SIZE 48 BY 1 AT ROW 5.05 COL 71
          BGCOLOR 5 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     "                   Datos de la clave y acceso" VIEW-AS TEXT
          SIZE 51 BY 1 AT ROW 5.05 COL 19
          BGCOLOR 5 FGCOLOR 15 
     RECT-7 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Usuario
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
         HEIGHT             = 13.33
         WIDTH              = 123.2.
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
   NOT-VISIBLE FRAME-NAME Size-to-Fit Custom                            */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR TOGGLE-BOX Usuario.cambiar_clave IN FRAME F-Main
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN Usuario.cdg_empresa IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Usuario.cdg_grupousr IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Usuario.cdg_usuario IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Usuario.dias_clave IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR EDITOR Usuario.estaciones_habilitadas IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Usuario.fch_ultimaclave IN FRAME F-Main
   NO-ENABLE EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Usuario.fch_ultimologin IN FRAME F-Main
   NO-ENABLE EXP-FORMAT                                                 */
/* SETTINGS FOR TOGGLE-BOX Usuario.mostrar_frase IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Usuario.seguimiento IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-clave IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX v-resetear IN FRAME F-Main
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

&Scoped-define SELF-NAME v-resetear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-resetear V-table-Win
ON VALUE-CHANGED OF v-resetear IN FRAME F-Main /* Asignar al usuario esta clave -----> */
DO:
  ASSIGN v-resetear.
  RUN habilitar_cambio_clave ( INPUT v-resetear ).
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
  {src/adm/template/row-list.i "Usuario"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Usuario"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_usuario V-table-Win 
PROCEDURE cambiar_usuario :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE INPUT PARAMETER p-cdg_usuario LIKE Usuario.cdg_usuario.
   DEFINE INPUT PARAMETER p-nombre      LIKE Usuario.nombre.
   DEFINE INPUT PARAMETER p-clave       LIKE Usuario.clave.

   FIND _User WHERE _User._Userid = p-cdg_usuario EXCLUSIVE-LOCK.
   DELETE _User.
   CREATE _User.
   ASSIGN _User._Userid    = p-cdg_usuario
          _User._User-name = p-nombre
          _User._password  = p-clave.
   RELEASE _User.       


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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_cambio_clave V-table-Win 
PROCEDURE habilitar_cambio_clave :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-habilitar AS LOGICAL.

  v-clave:BGCOLOR IN FRAME {&FRAME-NAME} = IF p-habilitar THEN 15 ELSE 7.
  v-clave:SENSITIVE IN FRAME {&FRAME-NAME} = p-habilitar.
  /*v-resetear:SENSITIVE IN FRAME {&FRAME-NAME} = p-habilitar.*/

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
  
  RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=ADD" ).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  Usuario.cdg_usuario:SENSITIVE IN FRAME {&FRAME-NAME} = YES.


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
    DEFINE VARIABLE hubo_error AS LOGICAL.
    DEFINE BUFFER B-Usuario FOR Usuario.
    DEFINE BUFFER b-user_empresa FOR user_empresa.
    DEFINE BUFFER b-usuario_funcion FOR usuario_funcion.
    DEFINE BUFFER b-usuario_programa FOR usuario_programa.
    DEF VAR ant_rid AS ROWID NO-UNDO.
    IF CAN-FIND(FIRST B-Usuario 
                       WHERE B-Usuario.cdg_usuario = 
                           INPUT FRAME {&FRAME-NAME} Usuario.cdg_usuario
                        AND ROWID(B-Usuario) <> ROWID(Usuario) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "USID001").
         RETURN ERROR.
    END.    
    
    IF INPUT FRAME {&FRAME-NAME} Usuario.cdg_usuario = "" 
    THEN DO:
         RUN PONMENSJ.P (INPUT "USID002").
         RETURN ERROR.
    END.                    
    
    IF INPUT FRAME {&FRAME-NAME} Usuario.nombre = ""  
    THEN DO:
         RUN PONMENSJ.P (INPUT "USID003").
         RETURN ERROR.
    END.                    

    RUN valida_grupo_usr.p ( INPUT  Usuario.cdg_grupousr:SCREEN-VALUE IN FRAME {&FRAME-NAME},
                                   INPUT  hubo_error,
                                   OUTPUT hubo_error).
    IF hubo_error THEN
        RETURN ERROR.


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   ASSIGN FRAME {&FRAME-NAME} Usuario.estaciones_habilitadas Usuario.cambiar_clave v-resetear.
 
   IF NEW Usuario
   THEN DO:
       ASSIGN FRAME {&FRAME-NAME} Usuario.cdg_usuario v-clave.
       Usuario.clave = ENCODE(v-clave).
       Usuario.nro_usuario = NEXT-VALUE(proximo_usuario).
       IF CAN-FIND(FIRST _User WHERE _User._Userid = Usuario.cdg_usuario)
       THEN DO:
           RUN cambiar_usuario ( INPUT Usuario.cdg_usuario,
                                      INPUT Usuario.nombre,
                                      INPUT Usuario.clave).
       END.
       ELSE DO:
           CREATE _User.
           ASSIGN _User._Userid    = Usuario.cdg_usuario
                  _User._User-name = Usuario.nombre
                  _User._password  = Usuario.clave.
           RELEASE _User.       
       END.

   END.
   ELSE DO:
       IF v-resetear
       THEN DO:
           ASSIGN FRAME {&FRAME-NAME} v-clave.
           Usuario.clave = ENCODE(v-clave).
           /*Usuario.cambiar_clave = YES.*/
           FIND _User WHERE _User._Userid = Usuario.cdg_usuario EXCLUSIVE-LOCK.
           RUN cambiar_usuario ( INPUT Usuario.cdg_usuario,
                                 INPUT Usuario.nombre,
                                 INPUT Usuario.clave).
           RELEASE _User.
       END.
  END.

  RUN get-attribute IN adm-broker-hdl ( INPUT  "modo-cambio" ).
  IF RETURN-VALUE = "COPY" THEN DO:
      RUN get-attribute IN adm-broker-hdl ( INPUT  "ant_rid" ).
      ant_rid = TO-ROWID(RETURN-VALUE).
      FIND b-usuario WHERE ROWID(b-usuario ) = ant_rid.
      FIND b-USER_empresa OF b-usuario.
      CREATE USER_empresa.
      BUFFER-COPY b-user_empresa TO USER_empresa 
          ASSIGN user_empresa.nro_usuario = usuario.nro_usuario.
      FOR each b-usuario_funcion OF b-usuario:
         CREATE usuario_funcion.
         BUFFER-COPY b-usuario_funcion TO usuario_funcion 
             ASSIGN usuario_funcion.nro_usuario = USER_empresa.nro_usuario.
      END.
      FOR each b-usuario_programa OF usuario_programa:
         CREATE usuario_programa.
         BUFFER-COPY b-usuario_programa TO usuario_programa 
             ASSIGN usuario_funcion.nro_usuario = USER_empresa.nro_usuario.
      END.

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

  RUN set-attribute-list IN adm-broker-hdl ( "ant_rid=" + string( rowid(usuario) ) ).
  RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=COPY" ).
  
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'copy-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  Usuario.cdg_usuario:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
    RUN vlb-Usuario.p ( INPUT ROWID(Usuario), OUTPUT baja_no ).
    IF baja_no 
    THEN DO:
         RUN PONMENSJ.P ( "IREF001" ).
         RETURN ERROR.
    END.
    ELSE DO:
        FOR EACH Usuario_funcion OF Usuario:
            DELETE Usuario_funcion.
        END.
        FOR EACH Usuario_programa OF Usuario:
            DELETE Usuario_programa.
        END.
        FOR EACH Hst_claves OF Usuario:
            DELETE Hst_claves.
        END.
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

   Usuario.cdg_usuario:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
   Usuario.estaciones_habilitadas:FGCOLOR IN FRAME {&FRAME-NAME} = 7.
   Usuario.cambiar_clave:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

   RUN habilitar_cambio_clave ( INPUT NO ).
   v-resetear = NO.
   DISPLAY v-resetear WITH FRAME {&FRAME-NAME}.
   v-resetear:sensitive IN FRAME {&FRAME-NAME} = NO.

   RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=MODIFY" ).

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

  v-resetear = NO.
  DISPLAY v-resetear WITH FRAME {&FRAME-NAME}.

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

  RUN get-attribute IN adm-broker-hdl ( "modo-cambio" ).
  CASE RETURN-VALUE:
      WHEN "add" 
      THEN DO:
          Usuario.cambiar_clave:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
          Usuario.cambiar_clave:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "YES" .

          v-resetear = YES.
          DISPLAY v-resetear WITH FRAME {&FRAME-NAME}.
          v-resetear:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
          RUN habilitar_cambio_clave ( INPUT YES ).
      END.
      WHEN "copy" 
      THEN DO:
          Usuario.cambiar_clave:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
          Usuario.cambiar_clave:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "YES" .

          v-resetear = YES.
          DISPLAY v-resetear WITH FRAME {&FRAME-NAME}.
          v-resetear:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
          RUN habilitar_cambio_clave ( INPUT YES ).
      END.
      WHEN "modify" 
      THEN DO:
          Usuario.cambiar_clave:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
          Usuario.cambiar_clave:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "NO" .

          v-resetear = NO.
          DISPLAY v-resetear WITH FRAME {&FRAME-NAME}.
          v-resetear:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
          RUN habilitar_cambio_clave ( INPUT NO ).
      END.
  END CASE.

  Usuario.estaciones_habilitadas:FGCOLOR IN FRAME {&FRAME-NAME} = 9.

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

  RUN set-attribute-list IN adm-broker-hdl ( "modo-cambio=MODIFY" ).

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-update-record V-table-Win 
PROCEDURE local-update-record :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'update-record':U ) .

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
  {src/adm/template/snd-list.i "Usuario"}

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

