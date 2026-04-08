&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
/*------------------------------------------------------------------------

  File:  

  Description: from BROWSER.W - Basic SmartBrowser Object Template

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


DEF VAR ddd AS DATE NO-UNDO.
DEF VAR hhh AS DATE NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cliente contrato_hd

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cliente.cdg_cliente Cliente.nom_cliente Cliente.direccion Cliente.localidad Cliente.cuit   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table   
&Scoped-define SELF-NAME br_table
&Scoped-define OPEN-QUERY-br_table  /*OPEN QUERY {&BROWSE-NAME}     FOR EACH Cliente WHERE CAN-DO(Cliente.lista_empresas, ~
      empresa.cdg_empresa)                                , ~
       FIRST contrato_hd OF cliente  NO-LOCK    */.
&Scoped-define TABLES-IN-QUERY-br_table Cliente contrato_hd
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cliente
&Scoped-define SECOND-TABLE-IN-QUERY-br_table contrato_hd


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-br_table}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-9 que_nombre v-fantasia Bok vacti ~
Cestado v-periodo br_table 
&Scoped-Define DISPLAYED-OBJECTS que_nombre v-fantasia vacti Cestado ~
v-periodo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Foreign Keys" B-table-Win _INLINE
/* Actions: ? adm/support/keyedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<FOREIGN-KEYS>
cdg_cliente||y|sic.Cliente.cdg_cliente
nro_cliente||y|sic.Cliente.nro_cliente
nro_cobrador||y|sic.Cliente.nro_cobrador
cdg_condiva||y|sic.Cliente.cdg_condiva
cdg_condibr||y|sic.Cliente.cdg_condibr
cdg_postal||y|sic.Cliente.cdg_postal
nro_entidad||y|sic.Cliente.nro_entidad
cdg_estado||y|sic.Cliente.cdg_estado
cdg_famclie||y|sic.Cliente.cdg_famclie
cdg_grupoemp||y|sic.Cliente.cdg_grupoemp
cdg_pais||y|sic.Cliente.cdg_pais
nro_proveedor||y|sic.Cliente.nro_proveedor
cdg_provincia||y|sic.Cliente.cdg_provincia
num_sucursal||y|sic.Cliente.num_sucursal
cdg_tipoclie||y|sic.Cliente.cdg_tipoclie
nro_usuario||y|sic.Cliente.nro_usuario
nro_vendedor||y|sic.Cliente.nro_vendedor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_cliente,nro_cliente,nro_cobrador,cdg_condiva,cdg_condibr,cdg_postal,nro_entidad,cdg_estado,cdg_famclie,cdg_grupoemp,cdg_pais,nro_proveedor,cdg_provincia,num_sucursal,cdg_tipoclie,nro_usuario,nro_vendedor"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _XFTR "Advanced Query Options" B-table-Win _INLINE
/* Actions: ? adm/support/advqedit.w ? ? ? */
/* STRUCTURED-DATA
<KEY-OBJECT>
&BROWSE-NAME
</KEY-OBJECT>
<SORTBY-OPTIONS>
</SORTBY-OPTIONS>
<SORTBY-RUN-CODE>
************************
* Set attributes related to SORTBY-OPTIONS */
RUN set-attribute-list (
    'SortBy-Options = ""':U).
/************************
</SORTBY-RUN-CODE>
<FILTER-ATTRIBUTES>
</FILTER-ATTRIBUTES> */   

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON Bok 
     LABEL "OK" 
     SIZE 8 BY .95.

DEFINE VARIABLE Cestado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Est" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Aprobado","A",
                     "Rechazado","R",
                     "Pendiante","P",
                     "Todos","*"
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE que_nombre AS CHARACTER FORMAT "X(256)":U 
     LABEL "Nombre" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-periodo AS CHARACTER FORMAT "99/9999":U 
     LABEL "Periodo" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Mes/año de analisis" NO-UNDO.

DEFINE VARIABLE vacti AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Activos", 1,
"Todos", 2
     SIZE 24 BY .95 NO-UNDO.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 161 BY 1.43.

DEFINE VARIABLE v-fantasia AS LOGICAL INITIAL no 
     LABEL "Fantasía" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY 1.05 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cliente, 
      contrato_hd SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _FREEFORM
  QUERY br_table NO-LOCK DISPLAY
      Cliente.cdg_cliente FORMAT "X(8)":U WIDTH 14.2
      Cliente.nom_cliente FORMAT "X(40)":U WIDTH 47.4
      Cliente.direccion COLUMN-LABEL "Direccion!Cliente" FORMAT "X(45)":U
            WIDTH 53.6
      Cliente.localidad COLUMN-LABEL "Localidad!Cliente" FORMAT "X(30)":U
            WIDTH 25
      Cliente.cuit FORMAT "X(15)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 161 BY 20.71
         TITLE "Maestro de Clientes" FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     que_nombre AT ROW 1.24 COL 10 COLON-ALIGNED
     v-fantasia AT ROW 1.24 COL 63
     Bok AT ROW 1.24 COL 78
     vacti AT ROW 1.24 COL 89 NO-LABEL
     Cestado AT ROW 1.24 COL 119.6 COLON-ALIGNED WIDGET-ID 4
     v-periodo AT ROW 1.24 COL 145 COLON-ALIGNED WIDGET-ID 2
     br_table AT ROW 2.67 COL 1
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   Allow: Basic,Browse
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
  CREATE WINDOW B-table-Win ASSIGN
         HEIGHT             = 22.67
         WIDTH              = 161.6.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB B-table-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/browser.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW B-table-Win
  NOT-VISIBLE,,RUN-PERSISTENT                                           */
/* SETTINGS FOR FRAME F-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
/* BROWSE-TAB br_table v-periodo F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:ALLOW-COLUMN-SEARCHING IN FRAME F-Main = TRUE.

ASSIGN 
       que_nombre:PRIVATE-DATA IN FRAME F-Main     = 
                "nom_cliente".

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _START_FREEFORM

/*OPEN QUERY {&BROWSE-NAME}
    FOR EACH Cliente WHERE CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                               , FIRST contrato_hd OF cliente  NO-LOCK

  */
     _END_FREEFORM
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Query            is OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Bok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bok B-table-Win
ON CHOOSE OF Bok IN FRAME F-Main /* OK */
DO:
 RUN re-open.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Maestro de Clientes */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Maestro de Clientes */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON START-SEARCH OF br_table IN FRAME F-Main /* Maestro de Clientes */
DO:
  DEF VAR cc AS CHAR NO-UNDO.
  DO WITH WITH FRAME {&FRAME-NAME}:
    que_nombre:PRIVATE-DATA = SELF:CURRENT-COLUMN:NAME.
    CASE SELF:CURRENT-COLUMN:NAME :
      WHEN "nom_cliente" THEN cc = "Nombre".
      WHEN "localidad" THEN cc = "Localidad".
      WHEN "direccion" THEN cc = "Direccion".
      WHEN "cdg_cliente" THEN cc = "Codigo".
      WHEN "cuit" THEN cc = "C.U.I.T.".
     END CASE.
    que_nombre:LABEL = cc.
    v-fantasia:HIDDEN = ( cc <> "Nombre" ) .
    APPLY "select" TO que_nombre.
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Maestro de Clientes */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME que_nombre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre B-table-Win
ON LEAVE OF que_nombre IN FRAME F-Main /* Nombre */
DO:
  RUN re-open.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL que_nombre B-table-Win
ON RETURN OF que_nombre IN FRAME F-Main /* Nombre */
DO:
        RUN re-open.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fantasia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fantasia B-table-Win
ON VALUE-CHANGED OF v-fantasia IN FRAME F-Main /* Fantasía */
DO:
   RUN re-open.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-periodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-periodo B-table-Win
ON LEAVE OF v-periodo IN FRAME F-Main /* Periodo */
DO:
  RUN re-open.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vacti
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vacti B-table-Win
ON VALUE-CHANGED OF vacti IN FRAME F-Main
DO:
   RUN re-open.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK B-table-Win 


/* ***************************  Main Block  *************************** */

&IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
RUN dispatch IN THIS-PROCEDURE ('initialize':U).        
&ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available B-table-Win  _ADM-ROW-AVAILABLE
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

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI B-table-Win  _DEFAULT-DISABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i}
  /* Code placed here will execute PRIOR to standard behavior. */
  
 /* Dispatch standard ADM method.   */
RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
v-periodo:SCREEN-VALUE IN FRAME {&FRAME-NAME} =STRING(MONTH(TODAY),"99") + "/"  + STRING(YEAR(TODAY),"9999").

 /* Code placed here will execute AFTER standard behavior.    */


 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE re-open B-table-Win 
PROCEDURE re-open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN FRAME {&FRAME-NAME} v-periodo que_nombre v-fantasia.
ddd = DATE(int(SUBSTRING(v-periodo,1,2)),1,int(substring(v-periodo,3,4))).
hhh = DATE( MONTH(ddd + 32 ), 1 , YEAR( ddd + 32 ) ) - 1 .

CASE que_nombre:PRIVATE-DATA :
      WHEN 'nom_cliente' THEN 
        DO WITH FRAME {&FRAME-NAME}:
             IF NOT v-fantasia
             THEN DO:
                 IF vacti:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1" THEN
                  OPEN QUERY {&BROWSE-NAME} 
                      FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre 
                               AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                               , FIRST contrato_hd OF cliente WHERE   (cestado = contrato_hd.estado OR cestado = "*" ) AND contrato_hd.rige_hasta >= ddd AND
                                       contrato_hd.rige_desde <= hhh AND
                                       ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
                                       AND contrato_hd.primer_mes + contrato_hd.primer_ano * 100 <= int(SUBSTRING(v-periodo,1,2)) + int(SUBSTRING(v-periodo,3,4)) * 100 
                                       NO-LOCK.
                 ELSE
                  OPEN QUERY {&BROWSE-NAME} 
                      FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS que_nombre 
                                         AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                         , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) 
                                         NO-LOCK.
                 {&BROWSE-NAME}:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOMBRE=" + que_nombre.
             END.
             ELSE DO:
                 IF vacti:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1" THEN
                  OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.nom_fantasia CONTAINS que_nombre 
                                         AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                        , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) AND contrato_hd.rige_hasta >= ddd AND
                                        contrato_hd.rige_desde <= hhh AND
                                        ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
                                        AND contrato_hd.primer_mes + contrato_hd.primer_ano * 100 <= int(SUBSTRING(v-periodo,1,2)) + int(SUBSTRING(v-periodo,3,4)) * 100 
                                         NO-LOCK.
                 ELSE
                  OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.nom_fantasia CONTAINS que_nombre 
                                        AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                        , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) 
                                        NO-LOCK.
                 {&BROWSE-NAME}:TITLE = "Clientes que satisfacen la condición de búsqueda: POR NOM FANTASIA=" + que_nombre.
             END.
             
        END.  
        WHEN 'direccion' THEN 
             DO WITH FRAME {&FRAME-NAME}:
               IF vacti:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1" THEN
                  OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.direccion CONTAINS que_nombre 
                                        AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                        , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) AND contrato_hd.rige_hasta >= ddd AND
                                        contrato_hd.rige_desde <= hhh AND
                                        ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
                                        AND contrato_hd.primer_mes + contrato_hd.primer_ano * 100 <= int(SUBSTRING(v-periodo,1,2)) + int(SUBSTRING(v-periodo,3,4)) * 100 
                                        NO-LOCK.
               ELSE
                  OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.direccion CONTAINS que_nombre 
                                         AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                         , FIRST contrato_hd OF cliente  WHERE (cestado = contrato_hd.estado OR cestado = "*" ) 
                                        NO-LOCK.
              {&BROWSE-NAME}:TITLE = "Clientes que satisfacen la condición de búsqueda: POR DIRECCION=" + que_nombre.
         END.
         WHEN 'cdg_cliente' THEN 
              DO WITH FRAME {&FRAME-NAME}:
                 IF vacti:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1" THEN
                  OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_nombre 
                                      AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                      , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) AND contrato_hd.rige_hasta >= ddd AND
                                        contrato_hd.rige_desde <= hhh AND
                                        ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
                                        AND contrato_hd.primer_mes + contrato_hd.primer_ano * 100 <= int(SUBSTRING(v-periodo,1,2)) + int(SUBSTRING(v-periodo,3,4)) * 100 
                                        NO-LOCK.
                 ELSE
                   OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS que_nombre 
                                      AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                      , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" )  
                                      NO-LOCK.
               {&BROWSE-NAME}:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_nombre.
         END.
                 
         WHEN 'cuit' THEN 
              DO WITH FRAME {&FRAME-NAME}:
                 IF vacti:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "1" THEN
                   OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.cuit CONTAINS que_nombre 
                                    AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                    , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) AND contrato_hd.rige_hasta >= ddd AND
                                    contrato_hd.rige_desde <= hhh AND
                                    ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
                                    AND contrato_hd.primer_mes + contrato_hd.primer_ano * 100 <= int(SUBSTRING(v-periodo,1,2)) + int(SUBSTRING(v-periodo,3,4)) * 100 
                                    NO-LOCK.
                  ELSE
                   OPEN QUERY {&BROWSE-NAME} 
                     FOR EACH Cliente WHERE Cliente.cuit CONTAINS que_nombre 
                                    AND CAN-DO(Cliente.lista_empresas,empresa.cdg_empresa)
                                    , FIRST contrato_hd OF cliente WHERE  (cestado = contrato_hd.estado OR cestado = "*" ) 
                                    NO-LOCK.
                  {&BROWSE-NAME}:TITLE = "Clientes que satisfacen la condición de búsqueda: POR CODIGO=" + que_nombre.

               END.
     END CASE.
RUN dispatch IN THIS-PROCEDURE ('row-changed':U).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_cliente" "Cliente" "cdg_cliente"}
  {src/adm/template/sndkycas.i "nro_cliente" "Cliente" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_cobrador" "Cliente" "nro_cobrador"}
  {src/adm/template/sndkycas.i "cdg_condiva" "Cliente" "cdg_condiva"}
  {src/adm/template/sndkycas.i "cdg_condibr" "Cliente" "cdg_condibr"}
  {src/adm/template/sndkycas.i "cdg_postal" "Cliente" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_entidad" "Cliente" "nro_entidad"}
  {src/adm/template/sndkycas.i "cdg_estado" "Cliente" "cdg_estado"}
  {src/adm/template/sndkycas.i "cdg_famclie" "Cliente" "cdg_famclie"}
  {src/adm/template/sndkycas.i "cdg_grupoemp" "Cliente" "cdg_grupoemp"}
  {src/adm/template/sndkycas.i "cdg_pais" "Cliente" "cdg_pais"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Cliente" "nro_proveedor"}
  {src/adm/template/sndkycas.i "cdg_provincia" "Cliente" "cdg_provincia"}
  {src/adm/template/sndkycas.i "num_sucursal" "Cliente" "num_sucursal"}
  {src/adm/template/sndkycas.i "cdg_tipoclie" "Cliente" "cdg_tipoclie"}
  {src/adm/template/sndkycas.i "nro_usuario" "Cliente" "nro_usuario"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Cliente" "nro_vendedor"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records B-table-Win  _ADM-SEND-RECORDS
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
  {src/adm/template/snd-list.i "contrato_hd"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed B-table-Win 
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
      {src/adm/template/bstates.i}
  END CASE.
    CASE p-state:
    WHEN "update":U THEN DO:
        que_nombre:SENSITIVE = FALSE.
        v-fantasia:SENSITIVE = FALSE.
        bok:SENSITIVE = FALSE.
        vacti:SENSITIVE = FALSE.
        v-periodo:SENSITIVE = true.
    END.
    WHEN "update-complete":U THEN DO:
        que_nombre:SENSITIVE = true.
        v-fantasia::SENSITIVE = true.
        bok:SENSITIVE = true.
        vacti:SENSITIVE = true.
        v-periodo:SENSITIVE = true.
    END.
  END CASE.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

