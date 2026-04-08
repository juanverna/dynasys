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

{vrhelpfecha.i}

DEFINE VARIABLE rid_articulo AS ROWID.
DEFINE VARIABLE rid_cliente  AS ROWID.

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
&Scoped-define EXTERNAL-TABLES Registrable
&Scoped-define FIRST-EXTERNAL-TABLE Registrable


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Registrable.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Registrable.cdg_registrable ~
Registrable.dsc_registrable Registrable.fch_alta Registrable.fch_baja ~
Registrable.fch_desgarantia Registrable.fch_hasgarantia ~
Registrable.fch_entrega Registrable.fch_instalacion ~
Registrable.instalado_por Registrable.nro_serie Registrable.nro_parte ~
Registrable.descripcion 
&Scoped-define ENABLED-TABLES Registrable
&Scoped-define FIRST-ENABLED-TABLE Registrable
&Scoped-Define ENABLED-OBJECTS RECT-7 
&Scoped-Define DISPLAYED-FIELDS Registrable.cdg_registrable ~
Registrable.dsc_registrable Registrable.fch_alta Registrable.fch_baja ~
Registrable.fch_desgarantia Registrable.fch_hasgarantia ~
Registrable.fch_entrega Registrable.fch_instalacion ~
Registrable.instalado_por Registrable.nro_serie Registrable.nro_parte ~
Registrable.descripcion 
&Scoped-define DISPLAYED-TABLES Registrable
&Scoped-define FIRST-DISPLAYED-TABLE Registrable
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo ~
v-cdg_cliente v-dsc_cliente 

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
DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(12)" 
     LABEL "Artículo" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(10)" 
     LABEL "Cliente" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 22 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(55)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_cliente AS CHARACTER FORMAT "X(55)" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 49 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 19.76.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Registrable.cdg_registrable AT ROW 1.71 COL 19 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.dsc_registrable AT ROW 3.05 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 72 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_articulo AT ROW 4.33 COL 19 COLON-ALIGNED
     v-dsc_articulo AT ROW 4.33 COL 42 COLON-ALIGNED NO-LABEL
     Registrable.fch_alta AT ROW 5.76 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.fch_baja AT ROW 5.76 COL 69 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.fch_desgarantia AT ROW 7.19 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.fch_hasgarantia AT ROW 7.19 COL 69 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.fch_entrega AT ROW 8.62 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.fch_instalacion AT ROW 8.62 COL 69 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cliente AT ROW 10.05 COL 19 COLON-ALIGNED
     v-dsc_cliente AT ROW 10.05 COL 42 COLON-ALIGNED NO-LABEL
     Registrable.instalado_por AT ROW 11.48 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 72 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.nro_serie AT ROW 12.91 COL 19 COLON-ALIGNED
          LABEL "Nro. Serie"
          VIEW-AS FILL-IN NATIVE 
          SIZE 30 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.nro_parte AT ROW 12.91 COL 69 COLON-ALIGNED
          LABEL "Nro. Parte"
          VIEW-AS FILL-IN NATIVE 
          SIZE 22 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Registrable.descripcion AT ROW 14.33 COL 21 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 72 BY 5.67
          BGCOLOR 15 FGCOLOR 9 
     RECT-7 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Registrable
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
         HEIGHT             = 20.19
         WIDTH              = 97.2.
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

/* SETTINGS FOR FILL-IN Registrable.cdg_registrable IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Registrable.nro_parte IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Registrable.nro_serie IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cliente IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cliente IN FRAME F-Main
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

&Scoped-define SELF-NAME v-cdg_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_articulo IN FRAME F-Main /* Artículo */
OR "." OF v-cdg_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_articulo IN FRAME {&FRAME-NAME}

DO:

  RUN SELARTIC_SECTOR.P ( INPUT-OUTPUT rid_articulo, INPUT YES, INPUT Area.nro_area ).
  IF rid_articulo <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
       v-cdg_articulo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Articulo.cdg_articulo.
       APPLY "RETURN" TO SELF.
  END.       
  RETURN NO-APPLY.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo V-table-Win
ON RETURN OF v-cdg_articulo IN FRAME F-Main /* Artículo */
DO:

  IF v-cdg_articulo:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
  THEN DO:
        FIND Articulo WHERE Articulo.cdg_articulo = INPUT FRAME {&FRAME-NAME} v-cdg_articulo NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Articulo 
        THEN DO:
             RUN PONMENSJ.P ( "REGI005" ).
             RETURN NO-APPLY.
        END.
        ELSE DO:
            IF NOT Articulo.es_registrable 
            THEN DO:
                RUN PONMENSJ.P ( "REGI006" ).
                RETURN NO-APPLY.
            END.
        END.

        v-dsc_articulo = Articulo.descripcion.
        DISPLAY v-dsc_articulo 
                WITH FRAME {&FRAME-NAME}.     
  END.          
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cliente IN FRAME F-Main /* Cliente */
OR "." OF v-cdg_cliente IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME {&FRAME-NAME}

DO:

  RUN SELCLIEN.P ( INPUT-OUTPUT rid_cliente, INPUT YES ).
  IF rid_cliente <> ?
  THEN DO:
       FIND Cliente WHERE ROWID(Cliente) = rid_cliente NO-LOCK.
       v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Cliente.cdg_cliente.
       APPLY "RETURN" TO SELF.
  END.       

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON RETURN OF v-cdg_cliente IN FRAME F-Main /* Cliente */
DO:

  FIND Cliente WHERE Cliente.cdg_cliente = INPUT FRAME F-Main v-cdg_cliente
                 AND CAN-DO(Cliente.lista_empresas, Empresa.cdg_empresa) NO-LOCK NO-ERROR.
  IF NOT AVAILABLE Cliente
  THEN DO:
       RUN PONMENSJ.P ( "REGI007" ).
       RETURN NO-APPLY.
  END.

  v-dsc_cliente = Cliente.nom_cliente.
  DISPLAY v-dsc_cliente
          WITH FRAME F-Main.

  
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
  {src/adm/template/row-list.i "Registrable"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Registrable"}

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


   {blanqueacodigo.i "Articulo"}
   {blanqueacodigo.i "Cliente"}

   v-cdg_articulo:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
   v-cdg_cliente:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

  /* Dispatch standard ADM method.    
                           */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'add-record':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


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

    DEFINE VARIABLE act_registrable AS ROWID.
    DEFINE BUFFER B-Registrable FOR Registrable.

    IF INPUT FRAME {&FRAME-NAME} Registrable.cdg_registrable = "" 
    THEN DO:
         RUN PONMENSJ.P (INPUT "REGI001").
         RETURN ERROR.
    END.            

    IF INPUT FRAME {&FRAME-NAME} Registrable.dsc_registrable = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "REGI002").
         RETURN ERROR.
    END.            

    IF CAN-FIND(FIRST B-Registrable 
                       WHERE B-Registrable.cdg_registrable = 
                           INPUT FRAME {&FRAME-NAME} Registrable.cdg_registrable  
                        AND ROWID(B-Registrable) <> ROWID(Registrable) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "REGI003").
         RETURN ERROR.
    END.            


    FIND Articulo WHERE Articulo.cdg_articulo = INPUT FRAME {&FRAME-NAME} v-cdg_articulo NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Articulo
    THEN DO:
         RUN PONMENSJ.P ( INPUT "REGI005" ).
         RETURN ERROR.
    END.
    ELSE DO:
        IF NOT Articulo.es_registrable
        THEN DO:
             RUN PONMENSJ.P ( INPUT "REGI006" ).
             RETURN ERROR.
        END.

    END.
    
    IF NOT INPUT FRAME {&FRAME-NAME} v-cdg_cliente = ""
        THEN DO:

        FIND Cliente WHERE Cliente.cdg_cliente = INPUT FRAME {&FRAME-NAME} v-cdg_cliente
                       AND CAN-DO(Cliente.lista_empresas, Empresa.cdg_empresa) NO-LOCK NO-ERROR.
        IF NOT AVAILABLE Cliente
        THEN DO:
             RUN PONMENSJ.P ( INPUT "REGI007" ).
             RETURN ERROR.
        END.
    END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
    
    IF NEW Registrable
    THEN DO:

        Registrable.nro_registrable = NEXT-VALUE(proximo_registrable).
        Registrable.cdg_empresa     = Empresa.cdg_empresa.
    END.
    
    ASSIGN
        Registrable.nro_articulo    = Articulo.nro_articulo.

    IF NOT INPUT FRAME {&FRAME-NAME} v-cdg_cliente = "" 
        THEN Registrable.nro_cliente = Cliente.nro_cliente.
    ELSE Registrable.nro_cliente     = 0.


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
   RUN vlb-registrable.p ( INPUT ROWID(Registrable), OUTPUT baja_no ).
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


   {deshabcodigo.i "Articulo"} 
   {deshabcodigo.i "Cliente"} 

   Registrable.descripcion:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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

  IF AVAILABLE Registrable
  THEN DO:

        &SCOPED-DEFINE TABLA-MAESTRA  Registrable

        {displaytabla.i "Articulo" "cdg_articulo" "descripcion" "nro_articulo" "nro_articulo"} 
        {displaytabla.i "Cliente" "cdg_cliente" "nom_cliente" "nro_cliente" "nro_cliente"} 

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

    {habilcodigo.i "Articulo"}
    {habilcodigo.i "Cliente"}

    Registrable.descripcion:SENSITIVE IN FRAME {&FRAME-NAME} = YES.

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
  {findsector.i}

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


  Registrable.descripcion:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

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
  {src/adm/template/snd-list.i "Registrable"}

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

