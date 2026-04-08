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
{crystal_dyna.p}

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
&Scoped-define EXTERNAL-TABLES Cliente
&Scoped-define FIRST-EXTERNAL-TABLE Cliente


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cliente.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Cliente.cdg_cliente Cliente.cdg_estado ~
Cliente.mostrar_admin Cliente.HAT Cliente.dfl_cdg_puntovta ~
Cliente.nom_cliente Cliente.direccion Cliente.cuit Cliente.cdg_postal ~
Cliente.localidad Cliente.cdg_provincia Cliente.horario_de_atencion ~
Cliente.telefonos Cliente.dias_de_pago Cliente.horario_de_pago ~
Cliente.contacto_pago 
&Scoped-define ENABLED-TABLES Cliente
&Scoped-define FIRST-ENABLED-TABLE Cliente
&Scoped-Define ENABLED-OBJECTS RECT-9 b-resumen 
&Scoped-Define DISPLAYED-FIELDS Cliente.cdg_cliente Cliente.cdg_estado ~
Cliente.mostrar_admin Cliente.HAT Cliente.dfl_cdg_puntovta ~
Cliente.nom_cliente Cliente.direccion Cliente.cuit Cliente.cdg_postal ~
Cliente.localidad Cliente.cdg_provincia Cliente.horario_de_atencion ~
Cliente.telefonos Cliente.dias_de_pago Cliente.horario_de_pago ~
Cliente.contacto_pago 
&Scoped-define DISPLAYED-TABLES Cliente
&Scoped-define FIRST-DISPLAYED-TABLE Cliente


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
cdg_cliente|y|y|sic.Cliente.cdg_cliente
nro_cliente|y|y|sic.Cliente.nro_cliente
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
    'Keys-Accepted = "cdg_cliente,nro_cliente",
     Keys-Supplied = "cdg_cliente,nro_cliente,nro_cobrador,cdg_condiva,cdg_condibr,cdg_postal,nro_entidad,cdg_estado,cdg_famclie,cdg_grupoemp,cdg_pais,nro_proveedor,cdg_provincia,num_sucursal,cdg_tipoclie,nro_usuario,nro_vendedor"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b-resumen 
     LABEL "&Resumen" 
     SIZE 15 BY 1.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 139 BY 9.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Cliente.cdg_cliente AT ROW 1.48 COL 15 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN NATIVE 
          SIZE 11 BY 1 TOOLTIP "En el alta lo asigna directamente Dynasys si lo deja en blanco"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_estado AT ROW 1.48 COL 37 COLON-ALIGNED
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Activo","A",
                     "Inactivo","I",
                     "Potencial","P"
          DROP-DOWN-LIST
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.mostrar_admin AT ROW 1.48 COL 65 WIDGET-ID 4
          VIEW-AS TOGGLE-BOX
          SIZE 23 BY .81 TOOLTIP "Si se muestra el Administrador o no en los comprobantes de venta"
     Cliente.HAT AT ROW 1.48 COL 92 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY 1
          BGCOLOR 15 FGCOLOR 9 
     b-resumen AT ROW 1.48 COL 106.4 WIDGET-ID 8
     Cliente.dfl_cdg_puntovta AT ROW 1.48 COL 127 COLON-ALIGNED WIDGET-ID 6
          LABEL "PVta"
          VIEW-AS FILL-IN NATIVE 
          SIZE 7.6 BY 1 TOOLTIP "Punto de venta que lo atientde por default"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 2.67 COL 15 COLON-ALIGNED FORMAT "X(80)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 120 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.direccion AT ROW 3.86 COL 15 COLON-ALIGNED
          LABEL "Dirección" FORMAT "X(60)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 84 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cuit AT ROW 3.86 COL 109 COLON-ALIGNED FORMAT "X(11)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 26 BY 1 TOOLTIP "No introduzca los guiones"
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_postal AT ROW 5.05 COL 15 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 13.6 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.localidad AT ROW 5.05 COL 42 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 40 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.cdg_provincia AT ROW 5.05 COL 96 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 31 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.horario_de_atencion AT ROW 6.24 COL 21 COLON-ALIGNED FORMAT "X(80)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.telefonos AT ROW 6.24 COL 83.8 COLON-ALIGNED
          LABEL "Teléfonos"
          VIEW-AS FILL-IN NATIVE 
          SIZE 53 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.dias_de_pago AT ROW 7.43 COL 21 COLON-ALIGNED FORMAT "X(256)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 116 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.horario_de_pago AT ROW 8.57 COL 87.2 COLON-ALIGNED FORMAT "X(256)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cliente.contacto_pago AT ROW 8.62 COL 21 COLON-ALIGNED WIDGET-ID 14
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEMS "Item 1" 
          DROP-DOWN-LIST
          SIZE 49 BY 1
          BGCOLOR 15 FGCOLOR 9 
     RECT-9 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Cliente
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
         HEIGHT             = 12.33
         WIDTH              = 139.6.
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

/* SETTINGS FOR FILL-IN Cliente.cdg_cliente IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.cuit IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.dfl_cdg_puntovta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Cliente.dias_de_pago IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.direccion IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Cliente.horario_de_atencion IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.horario_de_pago IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.nom_cliente IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Cliente.telefonos IN FRAME F-Main
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

&Scoped-define SELF-NAME b-resumen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b-resumen V-table-Win
ON CHOOSE OF b-resumen IN FRAME F-Main /* Resumen */
DO:
  RUN resumen_cob.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cliente.cuit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cliente.cuit V-table-Win
ON LEAVE OF Cliente.cuit IN FRAME F-Main /* C.U.I.T. */
DO:
    run validar_cuit_param.p ( INPUT FRAME {&FRAME-NAME} Cliente.cuit ,? ).
    if return-value <> "OK"
    THEN DO:
       RETURN NO-APPLY.
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
    WHEN 'cdg_cliente':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Cliente
           &WHERE = "WHERE Cliente.cdg_cliente eq key-value"
       }
    WHEN 'nro_cliente':U THEN
       {src/adm/template/find-tbl.i
           &TABLE = Cliente
           &WHERE = "WHERE Cliente.nro_cliente eq INTEGER(key-value)"
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
  {src/adm/template/row-list.i "Cliente"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cliente"}

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
  DEF VAR hay_error_interface AS LOGICAL NO-UNDO.
  DEF BUFFER  b-cliente FOR cliente.
  /* Code placed here will execute PRIOR to standard behavior. */
      
    IF INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = "" OR 
        INPUT FRAME {&FRAME-NAME} Cliente.nom_cliente = ?  
    THEN DO:
         RUN PONMENSJ.P (INPUT "USR_009").
         RETURN ERROR.
    END.            
    IF NEW cliente 
    THEN DO:
        
        IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente <> "" AND CAN-FIND(FIRST B-Cliente 
                           WHERE B-Cliente.cdg_cliente = 
                               INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente )
        THEN DO:
             RUN PONMENSJ.P (INPUT "USR_010").
             RETURN ERROR.
        END.

    END.
    ELSE DO:

        IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente <> "" AND CAN-FIND(FIRST B-Cliente 
                           WHERE B-Cliente.cdg_cliente = 
                               INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente  
                            AND ROWID(B-Cliente) <> ROWID(Cliente) )
        THEN DO:
             RUN PONMENSJ.P (INPUT "USR_010").
             RETURN ERROR.
        END.
        
    END.
    
    run validar_cuit_param.p ( INPUT FRAME {&FRAME-NAME} Cliente.cuit,? ).
    if return-value <> "OK"
    THEN DO:
       RETURN ERROR.
    END.  
    
    IF CAN-FIND(FIRST B-Cliente
                       WHERE INPUT FRAME {&FRAME-NAME} Cliente.cuit <> ""
                         AND B-Cliente.cuit = INPUT FRAME {&FRAME-NAME} Cliente.cuit
                         AND ROWID(B-Cliente) <> ROWID(Cliente) )
    THEN DO:
         RUN PONMENSJ.P (INPUT "CLIE036").
         RETURN ERROR.
    END.

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
  IF NEW Cliente
     THEN DO:
         ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente)
                 Cliente.fecha_alta  = TODAY
                 Cliente.hora_alta   = TIME.
         IF INPUT FRAME {&FRAME-NAME} Cliente.cdg_cliente = "" THEN
             ASSIGN cliente.cdg_cliente = "A" + STRING(Cliente.nro_cliente,"99999").
     /*perdon pero no quieren cargar estos datos estan forzados KILOMBO EN PUERTA 20/9/2006 */         
        ASSIGN  cliente.cdg_pais = 1
                cliente.cdg_grupo = "1"
                cliente.lista_empresas = "P"
                cliente.lista_sectores = "P"
                cliente.ult_domicilio = 1    
                cliente.tiene_ctacte = TRUE
                cliente.nro_entidad = 0
                cliente.nro_vendedor = 1
                cliente.cdg_tipoclie = "1"
                cliente.dfl_cndventa = "00"
                cliente.cdg_condiva = 2  /*le fuerzo consumidores finales a todos*/
                cliente.dfl_lista = 1
                cliente.max_chrechazados  = 3
                cliente.lista_mail = "ADM"
                cliente.num_sucursal = "C"
                Cliente.cdg_famclie = "1"
                cliente.nro_cobrador = 1
                cliente.nro_administrador = cliente.nro_cliente.
                
  END.
             
  IF NEW Cliente
     THEN DO:
    CREATE Hst_Cliente.
    BUFFER-COPY Cliente TO Hst_cliente.
    RUN completar_auditoria.p ( OUTPUT Hst_Cliente.user_cambio,
                                OUTPUT Hst_cliente.fecha_cambio,
                                OUTPUT Hst_cliente.hor_cambio,
                                OUTPUT Hst_cliente.pc_cambio).
    ASSIGN Hst_cliente.hms_cambio = STRING(Hst_cliente.hor_cambio,"HH:MM:SS").
  END.
  
   IF SEARCH("sincronizar_cliente.p") <> ? OR
   SEARCH("sincronizar_cliente.r") <> ?
   THEN DO:
       RUN sincronizar_cliente.p ( INPUT Cliente.cdg_cliente,
                                   OUTPUT hay_error_interface).
   END.
   cliente.ult_domicilio = 1.    
   FIND FIRST domicilio OF cliente NO-ERROR.
   IF NOT AVAILABLE domicilio THEN DO:
       CREATE domicilio.
        ASSIGN  Domicilio.telefono = cliente.telefonos
            Domicilio.nro_domicilio = 1
            Domicilio.nro_cliente = cliente.nro_cliente
            Domicilio.nombre = "Domicilio" 
            Domicilio.localidad = cliente.localidad
            Domicilio.factura = TRUE
            Domicilio.retira = FALSE
            Domicilio.es_fiscal = TRUE
            Domicilio.direccion = cliente.direccion 
            Domicilio.cdg_provincia = cliente.cdg_provincia
            Domicilio.cdg_postal = REPLACE(cliente.cdg_postal,"-","")
            Domicilio.cdg_pais = 1.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR LISTA AS CHAR NO-UNDO.
DEF VAR v-preferido AS CHAR NO-UNDO.  
/* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */

lista = "".
v-preferido = "".
FOR EACH domicilio OF cliente no-lock, 
        EACH cliente-contacto OF domicilio  WHERE 
        ( des_fecha = ? OR des_fecha <= TODAY )
         AND ( has_fecha = ? OR has_fecha >= TODAY ),
        EACH Persona OF Cliente-contacto NO-LOCK :
        lista = lista + "," + persona.nombre.
        IF  can-do(Cliente-contacto.canal-email,"*") THEN v-preferido = persona.nombre.
END.

IF LOOKUP(cliente.contacto_pago:SCREEN-VALUE IN FRAME {&FRAME-NAME},contacto_pago:LIST-ITEMS) = 0 THEN cliente.contacto_pago:SCREEN-VALUE.

IF lista <> "" THEN lista = SUBSTRING(lista,2).
IF LOOKUP(cliente.contacto_pago,lista) = 0 THEN DO:
        FIND CURRENT cliente EXCLUSIVE-LOCK.
    ASSIGN cliente.contacto_pago = v-preferido.
    FIND CURRENT cliente NO-LOCK.
END.
contacto_pago:LIST-ITEMS IN FRAME {&FRAME-NAME} = lista.

    
DISPLAY cliente.contacto_pago WITH FRAME {&FRAME-NAME}.

RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resumen_cob V-table-Win 
PROCEDURE resumen_cob :
/*------------------------------------------------------------------------------
  Purpose:     imprime el resumen de cobranza para el cliente
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{findempresa.i} 
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR ReportePath AS CHAR NO-UNDO.
DEF VAR cFullPath AS CHAR NO-UNDO.
DEF VAR XFullPath AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.

  DEFINE VARIABLE chApplication AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE chReport      AS COM-HANDLE NO-UNDO.

  

  RUN prinresumenes.p ( INPUT Empresa.cdg_empresa,
                             INPUT cliente.cdg_cliente,
                             INPUT cliente.cdg_cliente,
                             INPUT TODAY,
                             INPUT 01/01/3000,
                             INPUT "*", /*todos los puntos de venta*/
                             INPUT 1,
                             OUTPUT xfile). 

ReportePath = "resumen_cobranzas".
       RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
IF cFullPath = ? 
THEN DO:
    RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
    RETURN NO-apply.
END.

CREATE "CrystalRuntime.Application" chApplication.
chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').

RUN crearReporte(chReport,"rpt",/*ViewReport*/ TRUE,/*PrinterName*/ "",
                 /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
RELEASE OBJECT chReport. 
chReport = ?.
RELEASE OBJECT chApplication.
chApplication = ?.

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
  {src/adm/template/snd-list.i "Cliente"}

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

