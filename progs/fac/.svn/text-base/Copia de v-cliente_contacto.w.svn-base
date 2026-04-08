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

DEFINE VARIABLE v-nro_persona LIKE Persona.nro_persona.

DEFINE BUFFER B-Cliente-contacto FOR Cliente-contacto.

/* Temp-Table and Buffer definitions                                    */
/*DEFINE TEMP-TABLE t-Persona NO-UNDO LIKE Persona.*/


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
&Scoped-define EXTERNAL-TABLES Cliente-contacto Domicilio
&Scoped-define FIRST-EXTERNAL-TABLE Cliente-contacto


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente-contacto, Domicilio.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Persona.nombre T-Persona.direccion ~
T-Persona.cdg_postal T-Persona.localidad T-Persona.provincia ~
T-Persona.numeros_telefono T-Persona.email Cliente-contacto.cdg_cargo ~
T-Persona.fecha_grab T-Persona.observacion 
&Scoped-define ENABLED-TABLES T-Persona Cliente-contacto
&Scoped-define FIRST-ENABLED-TABLE T-Persona
&Scoped-define SECOND-ENABLED-TABLE Cliente-contacto
&Scoped-Define ENABLED-OBJECTS RECT-2 
&Scoped-Define DISPLAYED-FIELDS T-Persona.nombre T-Persona.direccion ~
T-Persona.cdg_postal T-Persona.localidad T-Persona.provincia ~
T-Persona.numeros_telefono T-Persona.email Cliente-contacto.cdg_cargo ~
T-Persona.fecha_grab T-Persona.observacion 
&Scoped-define DISPLAYED-TABLES T-Persona Cliente-contacto
&Scoped-define FIRST-DISPLAYED-TABLE T-Persona
&Scoped-define SECOND-DISPLAYED-TABLE Cliente-contacto


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
DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 6.43.


/* ************************  Frame Definitions  *********************** */
DEFINE TEMP-TABLE t-Persona NO-UNDO LIKE Persona.
DEFINE FRAME F-Main
     T-Persona.nombre AT ROW 1.24 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.direccion AT ROW 1.24 COL 75 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.cdg_postal AT ROW 2.43 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.localidad AT ROW 2.43 COL 36 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 26 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.provincia AT ROW 2.43 COL 75 COLON-ALIGNED FORMAT "X(25)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.numeros_telefono AT ROW 3.62 COL 10 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 117 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.email AT ROW 4.81 COL 10 COLON-ALIGNED
          LABEL "E-mail"
          VIEW-AS FILL-IN NATIVE 
          SIZE 52 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente-contacto.cdg_cargo AT ROW 4.81 COL 75 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.fecha_grab AT ROW 4.81 COL 111 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Persona.observacion AT ROW 6 COL 10 COLON-ALIGNED
          LABEL "Obs." FORMAT "X(120)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 117 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-2 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente-contacto,sic.Domicilio
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
         HEIGHT             = 6.67
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

/* SETTINGS FOR FILL-IN T-Persona.email IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Persona.observacion IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN T-Persona.provincia IN FRAME F-Main
   EXP-FORMAT                                                           */
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

&Scoped-define SELF-NAME T-Persona.nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Persona.nombre V-table-Win
ON HELP OF T-Persona.nombre IN FRAME F-Main /* Nombre */
DO:
  APPLY "MOUSE-MENU-DOWN" TO SELF.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Persona.nombre V-table-Win
ON MOUSE-MENU-DOWN OF T-Persona.nombre IN FRAME F-Main /* Nombre */
DO:
  DEFINE VARIABLE rid_persona AS ROWID.
  DEFINE VARIABLE puso_ok     AS LOGICAL.

  RUN d-buscar_persona.w ( INPUT-OUTPUT rid_persona, OUTPUT puso_ok ).
  IF puso_ok
  THEN DO:
      FIND Persona WHERE ROWID(Persona) = rid_persona NO-LOCK.
      BUFFER-COPY Persona TO T-Persona.
      RUN mostrar_persona.
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
  {src/adm/template/row-list.i "Domicilio"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente-contacto"}
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
     {levantacombo.i &TABLA=Cargo_persona &NOMBRE=dsc_cargo &CODIGO=cdg_cargo &OBJETO=Cliente-contacto.cdg_cargo}
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
         /*
  ASSIGN v-nombre = ""
         v-nro_persona = 0.

  DISPLAY v-nombre
      WITH FRAME {&FRAME-NAME}.
           */

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

  IF NOT CAN-FIND(Cargo_persona WHERE Cargo_persona.cdg_cargo = Cliente-contacto.cdg_cargo:INPUT-VALUE IN FRAME {&FRAME-NAME})
  THEN DO:
      RUN ponmensj.p ( INPUT "CLIE908" ).
      RETURN NO-APPLY.
  END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
 
/*MESSAGE "Despues del SB, va a asignar T-Persona"
          "cdg_cargo           " Cliente-contacto.cdg_cargo        SKIP
          "des_fecha           " Cliente-contacto.des_fecha        SKIP
          "has_fecha           " Cliente-contacto.has_fecha        SKIP
          "nro_cliente         " Cliente-contacto.nro_cliente      SKIP
          "nro_domicilio       " Cliente-contacto.nro_domicilio    SKIP
          "nro_persona         " Cliente-contacto.nro_persona      SKIP
          "observaciones       " Cliente-contacto.observaciones    SKIP
          "preferido           " Cliente-contacto.preferido        SKIP
          "Nuevo               " NEW Cliente-contacto
          VIEW-AS ALERT-BOX INFO BUTTONS OK.*/

  ASSIGN FRAME {&FRAME-NAME}
          T-Persona.cdg_postal 
          T-Persona.direccion 
          T-Persona.email 
          T-Persona.fecha_grab 
          T-Persona.localidad 
          T-Persona.nombre 
          T-Persona.observacion 
          T-Persona.numeros_telefono
          T-Persona.provincia.

  IF Cliente-contacto.nro_cliente = 0 AND Cliente-contacto.nro_domicilio = 0
  THEN DO:

        IF v-debug THEN MESSAGE "NUEVO cliente-contacto, busca la persona" T-Persona.nombre
            VIEW-AS ALERT-BOX INFO BUTTONS OK.

      
      FIND FIRST Persona WHERE Persona.nombre = T-Persona.nombre NO-ERROR.
      IF AVAILABLE Persona
      THEN DO:
             IF v-debug THEN MESSAGE "Encontro persona, pregunta si la asigna"
                 VIEW-AS ALERT-BOX INFO BUTTONS OK.
          RUN d-persona_ambigua.w ( INPUT T-Persona.nombre, INPUT-OUTPUT rid_persona ).
          IF rid_persona = ?
          THEN DO:
              CREATE Persona.
              BUFFER-COPY T-Persona TO Persona
                  ASSIGN Persona.nro_persona = NEXT-VALUE(proxima_persona)
                         Persona.fecha_grab  = TODAY.
              ASSIGN Cliente-contacto.nro_persona = Persona.nro_persona .
          END.
          ELSE DO:
              ASSIGN Cliente-contacto.nro_persona = Persona.nro_persona .
          END.

      END.
      ELSE DO:
             IF v-debug THEN MESSAGE "No la encontró, la crea y la asigna"
                 VIEW-AS ALERT-BOX INFO BUTTONS OK.
          CREATE Persona.
          BUFFER-COPY T-Persona TO Persona
              ASSIGN Persona.nro_persona = NEXT-VALUE(proxima_persona)
                     Persona.fecha_grab  = TODAY.
          ASSIGN Cliente-contacto.nro_persona = Persona.nro_persona .
      END.

  END.
  ELSE DO:
         IF v-debug THEN MESSAGE "Cliente-contacto no es nuevo, actualiza datos de Persona" 
             VIEW-AS ALERT-BOX INFO BUTTONS OK.
      FIND FIRST Persona WHERE Persona.nro_persona = T-Persona.nro_persona EXCLUSIVE-LOCK.
      BUFFER-COPY T-Persona TO Persona
          ASSIGN Persona.fecha_grab  = TODAY.

  END.

  ASSIGN Cliente-contacto.nro_cliente   = Domicilio.nro_cliente
         Cliente-contacto.nro_domicilio = Domicilio.nro_domicilio.

  IF Cliente-contacto.preferido
  THEN DO:
      FOR EACH B-Cliente-contacto OF Cliente WHERE ROWID(B-Cliente-contacto) <> ROWID(B-Cliente-contacto) EXCLUSIVE-LOCK:
          Cliente-contacto.preferido = NO.
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

  IF AVAILABLE Cliente-contacto
  THEN DO:
    /*MESSAGE "cdg_cargo           " Cliente-contacto.cdg_cargo        SKIP
              "des_fecha           " Cliente-contacto.des_fecha        SKIP
              "has_fecha           " Cliente-contacto.has_fecha        SKIP
              "nro_cliente         " Cliente-contacto.nro_cliente      SKIP
              "nro_domicilio       " Cliente-contacto.nro_domicilio    SKIP
              "nro_persona         " Cliente-contacto.nro_persona      SKIP
              "observaciones       " Cliente-contacto.observaciones    SKIP
              "preferido           " Cliente-contacto.preferido        SKIP
          VIEW-AS ALERT-BOX INFO BUTTONS OK.*/
      FIND Persona OF Cliente-contacto NO-LOCK.
      CREATE T-Persona.
      BUFFER-COPY Persona TO T-Persona.
      RUN mostrar_persona.
  END.
  ELSE DO:
      /*v-nombre = "".*/
  END.
  /*
  DISPLAY v-nombre
      WITH FRAME {&FRAME-NAME}.*/

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

  RUN inicia_combos.
  
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  

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

      DISPLAY T-Persona.cdg_postal 
              T-Persona.direccion 
              T-Persona.email 
              T-Persona.fecha_grab 
              T-Persona.localidad 
              T-Persona.nombre 
              T-Persona.observacion 
              T-Persona.numeros_telefono
              T-Persona.provincia
              WITH FRAME {&FRAME-NAME}.


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

