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

DEFINE VARIABLE que_empresas LIKE Empresa.cdg_empresa.

DEFINE TEMP-TABLE T-Cumplimiento NO-UNDO
     FIELD cdg_subclaseart      LIKE  Clase_de_Articulo.cdg_subclaseart   
     FIELD nombre_subclaseart   LIKE  Clase_de_Articulo.nombre_subclaseart
     FIELD cantidad             LIKE  Vendedor_objetivo.cantidad          
     FIELD granel               LIKE  Vendedor_objetivo.granel            
     FIELD subtotal             LIKE  Vendedor_objetivo.subtotal
     FIELD cantidad_cum         LIKE  Vendedor_objetivo.cantidad          
     FIELD granel_cum           LIKE  Vendedor_objetivo.granel            
     FIELD subtotal_cum         LIKE  Vendedor_objetivo.subtotal
     FIELD cantidad_prc         AS DECIMAL FORMAT ">>>9.99"         
     FIELD granel_prc           AS DECIMAL FORMAT ">>>9.99"         
     FIELD subtotal_prc         AS DECIMAL FORMAT ">>>9.99"
     INDEX por_clase IS UNIQUE cdg_subclaseart.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Vendedor Ciclo_ventas
&Scoped-define FIRST-EXTERNAL-TABLE Vendedor


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Vendedor, Ciclo_ventas.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Vendedor_objetivo Clase_de_Articulo

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Clase_de_Articulo.cdg_subclaseart ~
Clase_de_Articulo.nombre_subclaseart 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Vendedor_objetivo OF Vendedor WHERE ~{&KEY-PHRASE} ~
      AND Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas ~
 AND LOOKUP(Vendedor_objetivo.cdg_empresa,que_empresas) <> 0 NO-LOCK, ~
      EACH Clase_de_Articulo WHERE TRUE /* Join to Vendedor_objetivo incomplete */ ~
      AND Clase_de_Articulo.cdg_subclaseart = Vendedor_objetivo.cdg_subclaseart NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Vendedor_objetivo OF Vendedor WHERE ~{&KEY-PHRASE} ~
      AND Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas ~
 AND LOOKUP(Vendedor_objetivo.cdg_empresa,que_empresas) <> 0 NO-LOCK, ~
      EACH Clase_de_Articulo WHERE TRUE /* Join to Vendedor_objetivo incomplete */ ~
      AND Clase_de_Articulo.cdg_subclaseart = Vendedor_objetivo.cdg_subclaseart NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table Vendedor_objetivo Clase_de_Articulo
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Vendedor_objetivo
&Scoped-define SECOND-TABLE-IN-QUERY-br_table Clase_de_Articulo


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_table 

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
nro_cicloventas||y|sic.Vendedor_objetivo.nro_cicloventas
cdg_empresa||y|sic.Vendedor_objetivo.cdg_empresa
nro_moneda||y|sic.Vendedor_objetivo.nro_moneda
nro_vendedor||y|sic.Vendedor_objetivo.nro_vendedor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_cicloventas,cdg_empresa,nro_moneda,nro_vendedor"':U).

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
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Vendedor_objetivo, 
      Clase_de_Articulo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Clase_de_Articulo.cdg_subclaseart COLUMN-LABEL "Subclase!Artículo" FORMAT "X(25)":U
      Clase_de_Articulo.nombre_subclaseart COLUMN-LABEL "Denominación!Clase Artículo" FORMAT "X(40)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 71 BY 6.71
         TITLE "Objetivos para la empresa actual".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Vendedor,sic.Ciclo_ventas
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
         HEIGHT             = 6.86
         WIDTH              = 72.2.
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
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Vendedor_objetivo OF sic.Vendedor,sic.Clase_de_Articulo WHERE sic.Vendedor_objetivo ..."
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas
 AND LOOKUP(Vendedor_objetivo.cdg_empresa,que_empresas) <> 0"
     _Where[2]         = "Clase_de_Articulo.cdg_subclaseart = Vendedor_objetivo.cdg_subclaseart"
     _FldNameList[1]   > sic.Clase_de_Articulo.cdg_subclaseart
"Clase_de_Articulo.cdg_subclaseart" "Subclase!Artículo" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Clase_de_Articulo.nombre_subclaseart
"Clase_de_Articulo.nombre_subclaseart" "Denominación!Clase Artículo" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE br_table */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME F-Main
/* Query rebuild information for FRAME F-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME F-Main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main /* Objetivos para la empresa actual */
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main /* Objetivos para la empresa actual */
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main /* Objetivos para la empresa actual */
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Vendedor"}
  {src/adm/template/row-list.i "Ciclo_ventas"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Vendedor"}
  {src/adm/template/row-find.i "Ciclo_ventas"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ejecutar B-table-Win 
PROCEDURE ejecutar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-proceso AS CHARACTER.

  CASE p-proceso:
      WHEN "listado"      THEN RUN listar_objetivos.
      WHEN "cumplimiento" THEN RUN listar_cumplimiento.
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE listar_cumplimiento B-table-Win 
PROCEDURE listar_cumplimiento :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE tot_valors          AS INTEGER LABEL "cheques".
    DEFINE VARIABLE tot_importes        LIKE Cheque.importe LABEL "Importes".
    DEFINE VARIABLE fecha_lis           AS DATE.
    DEFINE VARIABLE hora_lis            AS CHARACTER.
    DEFINE VARIABLE que_empresa         LIKE Empresa.nombre.
    DEFINE VARIABLE dire_tmp            AS CHARACTER.
    DEFINE VARIABLE arch_salida         AS CHARACTER.
    DEFINE VARIABLE det_titulo          AS CHARACTER FORMAT "X(80)".
    DEFINE VARIABLE titulo_f            AS CHARACTER FORMAT "X(80)".
    DEFINE VARIABLE v-referencia        AS CHARACTER FORMAT "X(80)".
    DEFINE VARIABLE cod_efectivo        LIKE Rubro.cdg_rubro.
    DEFINE VARIABLE cod_cheque          LIKE Rubro.cdg_rubro.

    DEFINE FRAME frm-titulo HEADER
        que_empresa
        titulo_f AT 50
        "Página:" AT 165 PAGE-NUMBER FORMAT ">9" AT 172 SKIP 
        fecha_lis               
        det_titulo AT 50
        hora_lis AT 165  
        WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

    DEFINE FRAME frm-listado
        T-Cumplimiento.cdg_subclaseart      COLUMN-LABEL "Código!Línea"     
        T-Cumplimiento.nombre_subclaseart   COLUMN-LABEL "Descripción!Línea"
        T-Cumplimiento.cantidad             COLUMN-LABEL "Objetivo!Cantidad"     
        T-Cumplimiento.subtotal             COLUMN-LABEL "Objetivo!Monetario"     
        T-Cumplimiento.cantidad_cum         COLUMN-LABEL "Cumplido!Cantidad" 
        T-Cumplimiento.subtotal_cum         COLUMN-LABEL "Cumplido!Monetario"
        T-Cumplimiento.cantidad_prc         COLUMN-LABEL "  %  !Cant" 
        T-Cumplimiento.subtotal_prc         COLUMN-LABEL "  %  !Monet"
        WITH WIDTH 196 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
    
    {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}

    EMPTY TEMP-TABLE T-Cumplimiento.

    FOR EACH Vendedor_objetivo OF Vendedor 
            WHERE Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas
              AND LOOKUP(Vendedor_objetivo.cdg_empresa,que_empresas) <> 0 NO-LOCK,
                  FIRST Clase_de_Articulo WHERE Clase_de_Articulo.cdg_subclaseart = Vendedor_objetivo.cdg_subclaseart NO-LOCK:

        FIND FIRST T-Cumplimiento OF  Vendedor_objetivo NO-ERROR.
        IF NOT AVAILABLE T-Cumplimiento
        THEN DO:
            CREATE T-Cumplimiento.
            BUFFER-COPY Vendedor_objetivo TO T-Cumplimiento
                ASSIGN T-Cumplimiento.nombre_subclaseart = Clase_de_Articulo.nombre_subclaseart.
        END.

    END.

    FOR EACH Fac_header OF Vendedor
        WHERE Fac_header.fecha <= Ciclo_ventas.rige_hasta 
          AND Fac_header.fecha >= Ciclo_ventas.rige_desde
          AND Fac_header.anulado = NO
          AND LOOKUP(Fac_header.cdg_empresa,que_empresas) <> 0,
        FIRST Imputacion OF Fac_header WHERE Imputacion.afecta_estadisticas,
              FIRST Tipocomprobante OF Fac_header,
        EACH Fac_detalle OF Fac_header, FIRST Articulo OF Fac_detalle, 
             FIRST Vendedor_objetivo OF Ciclo_ventas
                   WHERE Vendedor_objetivo.cdg_subclaseart = Articulo.cdg_subclase: 

        FIND FIRST T-Cumplimiento OF  Vendedor_objetivo NO-ERROR.
        IF NOT AVAILABLE T-Cumplimiento
        THEN DO:
            CREATE T-Cumplimiento.
            BUFFER-COPY Vendedor_objetivo TO T-Cumplimiento.
        END.

        IF Tipocomprobante.debita
            THEN ASSIGN T-Cumplimiento.cantidad_cum = T-Cumplimiento.cantidad_cum  + Fac_detalle.cantidad
                        T-Cumplimiento.granel_cum   = T-Cumplimiento.granel_cum    + Fac_detalle.granel                 
                        T-Cumplimiento.subtotal_cum = T-Cumplimiento.subtotal_cum  + Fac_detalle.subtotal_neto.
            ELSE ASSIGN T-Cumplimiento.cantidad_cum = T-Cumplimiento.cantidad_cum  - Fac_detalle.cantidad
                        T-Cumplimiento.granel_cum   = T-Cumplimiento.granel_cum    - Fac_detalle.granel                 
                        T-Cumplimiento.subtotal_cum = T-Cumplimiento.subtotal_cum  - Fac_detalle.subtotal_neto.

    END.

    fecha_lis = TODAY.
    hora_lis = STRING(TIME,"HH:MM:SS").
    titulo_f = "Cumplimmiento del Vendedor: " + Vendedor.cdg_vendedor + " - " + Vendedor.nombre + " " + "Empresas:" + que_empresas.
    det_titulo = "Ciclo de Ventas: " + STRING(Ciclo_ventas.rige_desde,"99/99/99") + " - " +  
                  STRING(Ciclo_ventas.rige_hasta,"99/99/99") + " " + Ciclo_ventas.dsc_cicloventas.
    {findempresa.i}
    que_empresa = Empresa.nombre.

    arch_salida = dire_tmp + "cumplimiento.txt".

    OUTPUT TO VALUE(arch_salida) PAGED.

    DO WITH FRAME frm-listado:

        FOR EACH T-Cumplimiento:

            IF T-Cumplimiento.cantidad <> 0
                THEN T-Cumplimiento.cantidad_prc = T-Cumplimiento.cantidad_cum / T-Cumplimiento.cantidad * 100.
            IF T-Cumplimiento.granel <> 0
                THEN T-Cumplimiento.granel_prc = T-Cumplimiento.granel_cum / T-Cumplimiento.granel * 100.
            IF T-Cumplimiento.subtotal <> 0
                THEN T-Cumplimiento.subtotal_prc = T-Cumplimiento.subtotal_cum / T-Cumplimiento.subtotal * 100.

            VIEW FRAME frm-titulo.
    
            DISPLAY 
                T-Cumplimiento.cdg_subclaseart     
                T-Cumplimiento.nombre_subclaseart  
                T-Cumplimiento.cantidad            
                T-Cumplimiento.subtotal            
                T-Cumplimiento.cantidad_cum        
                T-Cumplimiento.subtotal_cum        
                T-Cumplimiento.cantidad_prc        
                T-Cumplimiento.subtotal_prc        
                WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.
    
        END.  
    
        UNDERLINE 
            T-Cumplimiento.cdg_subclaseart     
            T-Cumplimiento.nombre_subclaseart  
            T-Cumplimiento.cantidad            
            T-Cumplimiento.subtotal            
            T-Cumplimiento.cantidad_cum        
            T-Cumplimiento.subtotal_cum        
            T-Cumplimiento.cantidad_prc        
            T-Cumplimiento.subtotal_prc        
            WITH FRAME frm-listado.
    /*      
        DISPLAY   "Total"      @ Cheque.fecha_deposito
                  tot_valors   @ Cheque.numero_cheque
                  tot_importes @ Cheque.importe 
                  WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.
    */  
        OUTPUT CLOSE.

    END.

    
    RUN veresult.w ( INPUT arch_salida, INPUT 22 ).
      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE listar_objetivos B-table-Win 
PROCEDURE listar_objetivos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE tot_valors          AS INTEGER LABEL "cheques".
    DEFINE VARIABLE tot_importes        LIKE Cheque.importe LABEL "Importes".
    DEFINE VARIABLE fecha_lis           AS DATE.
    DEFINE VARIABLE hora_lis            AS CHARACTER.
    DEFINE VARIABLE que_empresa         LIKE Empresa.nombre.
    DEFINE VARIABLE dire_tmp            AS CHARACTER.
    DEFINE VARIABLE arch_salida         AS CHARACTER.
    DEFINE VARIABLE det_titulo          AS CHARACTER FORMAT "X(60)".
    DEFINE VARIABLE titulo_f            AS CHARACTER FORMAT "X(60)".
    DEFINE VARIABLE v-referencia        AS CHARACTER FORMAT "X(50)".
    DEFINE VARIABLE cod_efectivo        LIKE Rubro.cdg_rubro.
    DEFINE VARIABLE cod_cheque          LIKE Rubro.cdg_rubro.

    DEFINE FRAME frm-titulo HEADER
        que_empresa FORMAT "X(25)"
        titulo_f AT 30
        "Página:" AT 99 PAGE-NUMBER FORMAT ">9" AT 106 SKIP 
        fecha_lis               
        det_titulo AT 30
        hora_lis AT 99  
        WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

    DEFINE FRAME frm-listado
        Clase_de_Articulo.cdg_subclaseart       COLUMN-LABEL "Código!Línea"
        Clase_de_Articulo.nombre_subclaseart    COLUMN-LABEL "Descripción!Línea"
        Vendedor_objetivo.cantidad
        Vendedor_objetivo.granel
        Vendedor_objetivo.subtotal
        WITH WIDTH 196 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
    
    {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}

    fecha_lis = TODAY.
    hora_lis = STRING(TIME,"HH:MM:SS").
    titulo_f = "Objetivos del Vendedor: " + Vendedor.cdg_vendedor + " - " + Vendedor.nombre + " " + "Empresas:" + que_empresas.
    det_titulo = "Ciclo de Ventas: " + STRING(Ciclo_ventas.rige_desde,"99/99/99") + " - " +  
                  STRING(Ciclo_ventas.rige_hasta,"99/99/99") + " " + Ciclo_ventas.dsc_cicloventas.
    {findempresa.i}
    que_empresa = Empresa.nombre.

    arch_salida = dire_tmp + "objetivos.txt".

    OUTPUT TO VALUE(arch_salida) PAGED.

    DO WITH FRAME frm-listado:
    
        FOR EACH Vendedor_objetivo OF Vendedor 
            WHERE Vendedor_objetivo.nro_cicloventas = Ciclo_ventas.nro_cicloventas
              AND LOOKUP(Vendedor_objetivo.cdg_empresa,que_empresas) <> 0 NO-LOCK,
                  FIRST Clase_de_Articulo WHERE Clase_de_Articulo.cdg_subclaseart = Vendedor_objetivo.cdg_subclaseart NO-LOCK
            BY Clase_de_Articulo.cdg_subclaseart:
    
            VIEW FRAME frm-titulo.
    
            DISPLAY 
                Clase_de_Articulo.cdg_subclaseart 
                Clase_de_Articulo.nombre_subclaseart
                Vendedor_objetivo.cantidad
                Vendedor_objetivo.granel
                Vendedor_objetivo.subtotal
                WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.
    
        END.  
    
        UNDERLINE 
            Clase_de_Articulo.cdg_subclaseart 
            Clase_de_Articulo.nombre_subclaseart
            Vendedor_objetivo.cantidad
            Vendedor_objetivo.granel
            Vendedor_objetivo.subtotal
            WITH FRAME frm-listado.
    /*      
        DISPLAY   "Total"      @ Cheque.fecha_deposito
                  tot_valors   @ Cheque.numero_cheque
                  tot_importes @ Cheque.importe 
                  WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.
    */  
        OUTPUT CLOSE.

    END.

    
    RUN veresult.w ( INPUT arch_salida, INPUT 22 ).
      

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
  {src/adm/template/sndkycas.i "nro_cicloventas" "Vendedor_objetivo" "nro_cicloventas"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Vendedor_objetivo" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_moneda" "Vendedor_objetivo" "nro_moneda"}
  {src/adm/template/sndkycas.i "nro_vendedor" "Vendedor_objetivo" "nro_vendedor"}

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
  {src/adm/template/snd-list.i "Vendedor"}
  {src/adm/template/snd-list.i "Ciclo_ventas"}
  {src/adm/template/snd-list.i "Vendedor_objetivo"}
  {src/adm/template/snd-list.i "Clase_de_Articulo"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setear_empresa B-table-Win 
PROCEDURE setear_empresa :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 DEFINE INPUT PARAMETER p-lista AS CHARACTER.

 que_empresas = p-lista.

 RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query' ).


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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

