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
&Scoped-define EXTERNAL-TABLES Articulo Lista_Precios Articulo_precio
&Scoped-define FIRST-EXTERNAL-TABLE Articulo


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Articulo, Lista_Precios, Articulo_precio.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Articulo_precio.desde_cantidad ~
Articulo_precio.hasta_cantidad Articulo_precio.fch_desde ~
Articulo_precio.precio_cf 
&Scoped-define ENABLED-TABLES Articulo_precio
&Scoped-define FIRST-ENABLED-TABLE Articulo_precio
&Scoped-Define DISPLAYED-FIELDS Articulo_precio.desde_cantidad ~
Articulo_precio.hasta_cantidad Articulo_precio.fch_desde ~
Articulo_precio.precio_cf 
&Scoped-define DISPLAYED-TABLES Articulo_precio
&Scoped-define FIRST-DISPLAYED-TABLE Articulo_precio


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
cdg_articulo|y|y|sic.Articulo.cdg_articulo
nro_articulo|y|y|sic.Articulo.nro_articulo
descripcion||y|sic.Articulo.descripcion
cdg_envases||y|sic.Articulo.cdg_envases
cdg_estado||y|sic.Articulo.cdg_estado
nro_familia||y|sic.Articulo.nro_familia
cdg_famganancias||y|sic.Articulo.cdg_famganancias
nro_familimpos||y|sic.Articulo.nro_familimpos
cdg_famretibr||y|sic.Articulo.cdg_famretibr
cdg_famretiva||y|sic.Articulo.cdg_famretiva
cdg_famretsuss||y|sic.Articulo.cdg_famretsuss
cdg_grupoabasto||y|sic.Articulo.cdg_grupoabasto
cdg_linea||y|sic.Articulo.cdg_linea
cdg_marcacom||y|sic.Articulo.cdg_marcacom
nro_procedimiento||y|sic.Articulo.nro_procedimiento
cdg_tipoart||y|sic.Articulo.cdg_tipoart
nro_tipo_evento||y|sic.Articulo.nro_tipo_evento
cdg_umed||y|sic.Articulo.cdg_umed
nro_usuario||y|sic.Articulo.nro_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = "cdg_articulo,nro_articulo",
     Keys-Supplied = "cdg_articulo,nro_articulo,descripcion,cdg_envases,cdg_estado,nro_familia,cdg_famganancias,nro_familimpos,cdg_famretibr,cdg_famretiva,cdg_famretsuss,cdg_grupoabasto,cdg_linea,cdg_marcacom,nro_procedimiento,cdg_tipoart,nro_tipo_evento,cdg_umed,nro_usuario"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Articulo_precio.desde_cantidad AT ROW 1 COL 1
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo_precio.hasta_cantidad AT ROW 2.19 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo_precio.fch_desde AT ROW 1 COL 39 COLON-ALIGNED WIDGET-ID 2
          VIEW-AS FILL-IN NATIVE 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Articulo_precio.precio_cf AT ROW 1 COL 74 COLON-ALIGNED WIDGET-ID 4
          VIEW-AS FILL-IN NATIVE 
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Articulo,sic.Lista_Precios,sic.Articulo_precio
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
         HEIGHT             = 2.43
         WIDTH              = 99.6.
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
   NOT-VISIBLE Size-to-Fit L-To-R,COLUMNS                               */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Articulo_precio.desde_cantidad IN FRAME F-Main
   ALIGN-L                                                              */
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

&Scoped-define SELF-NAME Articulo_precio.fch_desde
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Articulo_precio.fch_desde V-table-Win
ON MOUSE-MENU-CLICK OF Articulo_precio.fch_desde IN FRAME F-Main /* Desde */
DO:
  {selfecha.i}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-find-using-key V-table-Win  adm/support/_key-fnd.p
PROCEDURE adm-find-using-key :
/*------------------------------------------------------------------------------
  Purpose:     Finds the current record using the contents of
               the 'Key-Name' and 'Key-Value' attributes.
  Parameters:  <none>
------------------------------------------------------------------------------*/
  DEF VAR key-value AS CHAR NO-UNDO.
  DEF VAR row-avail-enabled AS LOGICAL NO-UNDO.

  /* LOCK status on the find depends on FIELDS-ENABLED. */
  RUN get-attribute ('FIELDS-ENABLED':U).
  row-avail-enabled = (RETURN-VALUE eq 'yes':U).
  /* Look up the current key-value. */
  RUN get-attribute ('Key-Value':U).
  key-value = RETURN-VALUE.

  /* Find the current record using the current Key-Name. */
  RUN get-attribute ('Key-Name':U).
  CASE RETURN-VALUE:
    WHEN 'cdg_articulo':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Articulo
           &WHERE = "WHERE Articulo.cdg_articulo eq key-value"
       }
    WHEN 'nro_articulo':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Articulo
           &WHERE = "WHERE Articulo.nro_articulo eq INTEGER(key-value)"
       }
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  {src/adm/template/row-list.i "Articulo"}
  {src/adm/template/row-list.i "Lista_Precios"}
  {src/adm/template/row-list.i "Articulo_precio"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Articulo"}
  {src/adm/template/row-find.i "Lista_Precios"}
  {src/adm/template/row-find.i "Articulo_precio"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i}
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  ASSIGN
     articulo_precio.cdg_empresa = empresa.cdg_empresa
     Articulo_precio.nro_articulo = Articulo.nro_articulo
     Articulo_precio.cdg_lista    = Lista_precios.cdg_lista.
     articulo_precio.precio = articulo_precio.precio_cf / 1.21.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key V-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_articulo" "Articulo" "cdg_articulo"}
  {src/adm/template/sndkycas.i "nro_articulo" "Articulo" "nro_articulo"}
  {src/adm/template/sndkycas.i "descripcion" "Articulo" "descripcion"}
  {src/adm/template/sndkycas.i "cdg_envases" "Articulo" "cdg_envases"}
  {src/adm/template/sndkycas.i "cdg_estado" "Articulo" "cdg_estado"}
  {src/adm/template/sndkycas.i "nro_familia" "Articulo" "nro_familia"}
  {src/adm/template/sndkycas.i "cdg_famganancias" "Articulo" "cdg_famganancias"}
  {src/adm/template/sndkycas.i "nro_familimpos" "Articulo" "nro_familimpos"}
  {src/adm/template/sndkycas.i "cdg_famretibr" "Articulo" "cdg_famretibr"}
  {src/adm/template/sndkycas.i "cdg_famretiva" "Articulo" "cdg_famretiva"}
  {src/adm/template/sndkycas.i "cdg_famretsuss" "Articulo" "cdg_famretsuss"}
  {src/adm/template/sndkycas.i "cdg_grupoabasto" "Articulo" "cdg_grupoabasto"}
  {src/adm/template/sndkycas.i "cdg_linea" "Articulo" "cdg_linea"}
  {src/adm/template/sndkycas.i "cdg_marcacom" "Articulo" "cdg_marcacom"}
  {src/adm/template/sndkycas.i "nro_procedimiento" "Articulo" "nro_procedimiento"}
  {src/adm/template/sndkycas.i "cdg_tipoart" "Articulo" "cdg_tipoart"}
  {src/adm/template/sndkycas.i "nro_tipo_evento" "Articulo" "nro_tipo_evento"}
  {src/adm/template/sndkycas.i "cdg_umed" "Articulo" "cdg_umed"}
  {src/adm/template/sndkycas.i "nro_usuario" "Articulo" "nro_usuario"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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
  {src/adm/template/snd-list.i "Articulo"}
  {src/adm/template/snd-list.i "Lista_Precios"}
  {src/adm/template/snd-list.i "Articulo_precio"}

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

