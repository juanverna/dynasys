&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Grupofam Empresa
&Scoped-define FIRST-EXTERNAL-TABLE Grupofam


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Grupofam, Empresa.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Grupofam.cdg_grupofam Grupofam.importe_cuota ~
Grupofam.centro_medico Grupofam.fecha_alta Grupofam.nom_grupofam ~
Grupofam.nombre_fijo Grupofam.nom_fantasia Grupofam.techo Grupofam.cdg_plan ~
Grupofam.cdg_estado Grupofam.cdg_motbaja Grupofam.fecha_baja ~
Grupofam.cant_capitas Grupofam.cdg_cobrador Grupofam.cdg_promotor ~
Grupofam.cdg_tarjeta Grupofam.num_tarjeta Grupofam.fch_vtotarjeta ~
Grupofam.cdg_obrasocial Grupofam.num_sucursal Grupofam.tipo_ap ~
Grupofam.tipo_grupo Grupofam.cdg_condiva Grupofam.cuit ~
Grupofam.tipo_compbte Grupofam.observacion 
&Scoped-define FIELD-PAIRS~
 ~{&FP1}cdg_grupofam ~{&FP2}cdg_grupofam ~{&FP3}~
 ~{&FP1}importe_cuota ~{&FP2}importe_cuota ~{&FP3}~
 ~{&FP1}centro_medico ~{&FP2}centro_medico ~{&FP3}~
 ~{&FP1}fecha_alta ~{&FP2}fecha_alta ~{&FP3}~
 ~{&FP1}nom_grupofam ~{&FP2}nom_grupofam ~{&FP3}~
 ~{&FP1}nom_fantasia ~{&FP2}nom_fantasia ~{&FP3}~
 ~{&FP1}cdg_plan ~{&FP2}cdg_plan ~{&FP3}~
 ~{&FP1}cdg_motbaja ~{&FP2}cdg_motbaja ~{&FP3}~
 ~{&FP1}fecha_baja ~{&FP2}fecha_baja ~{&FP3}~
 ~{&FP1}cant_capitas ~{&FP2}cant_capitas ~{&FP3}~
 ~{&FP1}cdg_cobrador ~{&FP2}cdg_cobrador ~{&FP3}~
 ~{&FP1}cdg_promotor ~{&FP2}cdg_promotor ~{&FP3}~
 ~{&FP1}cdg_tarjeta ~{&FP2}cdg_tarjeta ~{&FP3}~
 ~{&FP1}num_tarjeta ~{&FP2}num_tarjeta ~{&FP3}~
 ~{&FP1}fch_vtotarjeta ~{&FP2}fch_vtotarjeta ~{&FP3}~
 ~{&FP1}cdg_obrasocial ~{&FP2}cdg_obrasocial ~{&FP3}~
 ~{&FP1}num_sucursal ~{&FP2}num_sucursal ~{&FP3}~
 ~{&FP1}tipo_ap ~{&FP2}tipo_ap ~{&FP3}~
 ~{&FP1}cuit ~{&FP2}cuit ~{&FP3}
&Scoped-define ENABLED-TABLES Grupofam
&Scoped-define FIRST-ENABLED-TABLE Grupofam
&Scoped-Define ENABLED-OBJECTS RECT-3 RECT-7 RECT-4 RECT-8 RECT-6 RECT-1 ~
v-cdg_cliente 
&Scoped-Define DISPLAYED-FIELDS Grupofam.cdg_grupofam ~
Grupofam.importe_cuota Grupofam.centro_medico Grupofam.fecha_alta ~
Grupofam.nom_grupofam Grupofam.nombre_fijo Grupofam.nom_fantasia ~
Grupofam.techo Grupofam.cdg_plan Grupofam.cdg_estado Grupofam.cdg_motbaja ~
Grupofam.fecha_baja Grupofam.cant_capitas Grupofam.cdg_cobrador ~
Grupofam.cdg_promotor Grupofam.cdg_tarjeta Grupofam.num_tarjeta ~
Grupofam.fch_vtotarjeta Grupofam.cdg_obrasocial Grupofam.num_sucursal ~
Grupofam.tipo_ap Grupofam.tipo_grupo Grupofam.cdg_condiva Grupofam.cuit ~
Grupofam.tipo_compbte Grupofam.observacion 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cliente 

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
DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cliente" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY .81
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 83 BY 7.81.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 83 BY 3.46.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 18 BY 1.35.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 33 BY 1.35.

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 11 BY 1.35.

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 21 BY 1.35.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Grupofam.cdg_grupofam AT ROW 1.27 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.importe_cuota AT ROW 1.27 COL 33 COLON-ALIGNED
          LABEL "Cuota"
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.centro_medico AT ROW 1.27 COL 55 COLON-ALIGNED
          LABEL "C.Médico" FORMAT "X(3)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.fecha_alta AT ROW 1.27 COL 67 COLON-ALIGNED FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.nom_grupofam AT ROW 2.35 COL 12 COLON-ALIGNED
          LABEL "R.Social"
          VIEW-AS FILL-IN NATIVE 
          SIZE 48 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.nombre_fijo AT ROW 2.35 COL 69
          LABEL "Nombre Fijo"
          VIEW-AS TOGGLE-BOX
          SIZE 13.72 BY .77
     Grupofam.nom_fantasia AT ROW 3.42 COL 12 COLON-ALIGNED
          LABEL "Nombre"
          VIEW-AS FILL-IN NATIVE 
          SIZE 48 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.techo AT ROW 3.42 COL 69
          LABEL "Techo"
          VIEW-AS TOGGLE-BOX
          SIZE 9 BY .77
     Grupofam.cdg_plan AT ROW 4.5 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.cdg_estado AT ROW 4.5 COL 26 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Act.", "A":U,
"Baja", "B":U,
"B.Rec", "R":U
          SIZE 23 BY .85
     Grupofam.cdg_motbaja AT ROW 4.5 COL 55 COLON-ALIGNED
          LABEL "M.Baja" FORMAT "X(2)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.fecha_baja AT ROW 4.5 COL 67 COLON-ALIGNED
          LABEL "Baja" FORMAT "99/99/9999"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.cant_capitas AT ROW 5.58 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.cdg_cobrador AT ROW 5.58 COL 33 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.cdg_promotor AT ROW 5.58 COL 67 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.cdg_tarjeta AT ROW 6.65 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.num_tarjeta AT ROW 6.65 COL 33 COLON-ALIGNED
          LABEL "Número" FORMAT "X(16)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 20 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.fch_vtotarjeta AT ROW 6.65 COL 67 COLON-ALIGNED
          LABEL "Vence"
          VIEW-AS FILL-IN NATIVE 
          SIZE 13 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.cdg_obrasocial AT ROW 7.73 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 10 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.num_sucursal AT ROW 7.73 COL 33 COLON-ALIGNED
          LABEL "Sucursal"
          VIEW-AS FILL-IN NATIVE 
          SIZE 6 BY .81
          BGCOLOR 15 FGCOLOR 9 
.
/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME F-Main
     Grupofam.tipo_ap AT ROW 7.73 COL 50 COLON-ALIGNED
          LABEL "Tipo A/P"
          VIEW-AS FILL-IN NATIVE 
          SIZE 2.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_cliente AT ROW 7.73 COL 67 COLON-ALIGNED
     Grupofam.tipo_grupo AT ROW 9.62 COL 2 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "A", "A":U,
"G", "G":U
          SIZE 9 BY .81
     Grupofam.cdg_condiva AT ROW 9.62 COL 13 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "C.F.", "C":U,
"R.I.", "R":U,
"Mon.", "M":U,
"NoI.", "N":U,
"Exh.", "E":U
          SIZE 31 BY .85
     Grupofam.cuit AT ROW 9.62 COL 49 COLON-ALIGNED
          LABEL "CUIT"
          VIEW-AS FILL-IN NATIVE 
          SIZE 14 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Grupofam.tipo_compbte AT ROW 9.62 COL 67 NO-LABEL
          VIEW-AS RADIO-SET HORIZONTAL
          RADIO-BUTTONS 
                    "Rc", "R":U,
"Fa", "F":U,
"NO", "N":U
          SIZE 16 BY .85
     Grupofam.observacion AT ROW 10.96 COL 3 NO-LABEL
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 79 BY 2.96
          BGCOLOR 15 FGCOLOR 7 FONT 4
     RECT-3 AT ROW 10.69 COL 1
     RECT-7 AT ROW 9.35 COL 1
     RECT-4 AT ROW 9.35 COL 66
     RECT-8 AT ROW 9.35 COL 45
     RECT-6 AT ROW 9.35 COL 12
     RECT-1 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         FONT 4.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: padron.Grupofam,sic.Empresa
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
         HEIGHT             = 13.15
         WIDTH              = 87.43.
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

/* SETTINGS FOR FILL-IN Grupofam.cdg_motbaja IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Grupofam.centro_medico IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Grupofam.cuit IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.fch_vtotarjeta IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.fecha_alta IN FRAME F-Main
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Grupofam.fecha_baja IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR FILL-IN Grupofam.importe_cuota IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR TOGGLE-BOX Grupofam.nombre_fijo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.nom_fantasia IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.nom_grupofam IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.num_sucursal IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.num_tarjeta IN FRAME F-Main
   EXP-LABEL EXP-FORMAT                                                 */
/* SETTINGS FOR TOGGLE-BOX Grupofam.techo IN FRAME F-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Grupofam.tipo_ap IN FRAME F-Main
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

&Scoped-define SELF-NAME Grupofam.cdg_cobrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Grupofam.cdg_cobrador V-table-Win
ON LEAVE OF Grupofam.cdg_cobrador IN FRAME F-Main /* Cobrador */
DO:
  DO WITH FRAME {&FRAME-NAME}:
     Grupofam.cdg_cobrador:SCREEN-VALUE = STRING(INTEGER(Grupofam.cdg_cobrador:SCREEN-VALUE), "999").
  END.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Grupofam.cdg_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Grupofam.cdg_estado V-table-Win
ON VALUE-CHANGED OF Grupofam.cdg_estado IN FRAME F-Main /* Estado */
DO:
  IF Grupofam.cdg_estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "B"
     THEN DISPLAY STRING(TODAY) @ Grupofam.fecha_baja
                  WITH FRAME {&FRAME-NAME}.            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Grupofam.cdg_grupofam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Grupofam.cdg_grupofam V-table-Win
ON LEAVE OF Grupofam.cdg_grupofam IN FRAME F-Main /* Nro. Grupo */
DO:
  
  DEFINE VARIABLE lcod AS INTEGER.

  lcod = LENGTH(Grupofam.cdg_grupofam:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
  IF lcod <> 6 AND lcod <> 7
  THEN DO:
       RUN PONMENSJ.P ( INPUT "GRUF005").
       RETURN NO-APPLY.
  END.
  ELSE DO:     
       IF lcod = 6 
          THEN Grupofam.cdg_grupofam:SCREEN-VALUE IN FRAME {&FRAME-NAME} =
               Grupofam.cdg_grupofam:SCREEN-VALUE IN FRAME {&FRAME-NAME} + 
               Grupofam.tipo_grupo:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  END.       
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Grupofam.cdg_promotor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Grupofam.cdg_promotor V-table-Win
ON LEAVE OF Grupofam.cdg_promotor IN FRAME F-Main /* Promotor */
DO:
  DO WITH FRAME {&FRAME-NAME}:
     Grupofam.cdg_promotor:SCREEN-VALUE = STRING(INTEGER(Grupofam.cdg_promotor:SCREEN-VALUE), "9999").
  END.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Grupofam.tipo_grupo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Grupofam.tipo_grupo V-table-Win
ON VALUE-CHANGED OF Grupofam.tipo_grupo IN FRAME F-Main /* Tipo!Grupo */
DO:
       
    Grupofam.cdg_grupofam:SCREEN-VALUE IN FRAME {&FRAME-NAME} =
           SUBSTRING(Grupofam.cdg_grupofam:SCREEN-VALUE IN FRAME {&FRAME-NAME},1,6) +
               Grupofam.tipo_grupo:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

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

  FIND Cliente OF Grupofam EXCLUSIVE-LOCK.
  FIND Vendedor WHERE Vendedor.cdg_vendedor = Grupofam.cdg_promotor NO-LOCK.
  FIND Cobrador OF Grupofam NO-LOCK.

  RUN asignar_cliente.

  RELEASE Cliente.


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
  {src/adm/template/row-list.i "Grupofam"}
  {src/adm/template/row-list.i "Empresa"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Grupofam"}
  {src/adm/template/row-find.i "Empresa"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_cliente V-table-Win 
PROCEDURE asignar_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  FIND FIRST Grupo-empresario NO-LOCK.
  ASSIGN Cliente.cdg_cliente   = Grupofam.cdg_empresa + Grupofam.cdg_grupofam 
         Cliente.dfl_cndventa  = "00"
         Cliente.dfl_lista     = 1
         Cliente.cdg_grupoem   = Grupo-empresario.cdg_grupoem
         Cliente.cdg_famclie   = "1"
         Cliente.cdg_estado    = Grupofam.cdg_estado 
         Cliente.cdg_tipocli   = Grupofam.cdg_plan 
         Cliente.nro_vendedor  = Vendedor.nro_vendedor
         Cliente.cuit          = Grupofam.cuit
         Cliente.fecha_alta    = Grupofam.fecha_alta
         Cliente.nom_cliente   = Grupofam.nom_grupofam
         Cliente.nro_cobrador  = Cobrador.nro_cobrador
         Cliente.fecha_alta    = Grupofam.fecha_alta
         Cliente.num_sucursal  = Grupofam.num_sucursal
         Cliente.lista_empresa = Grupofam.cdg_empresa.

  CASE Grupofam.cdg_condiva:
        WHEN "C" THEN Cliente.cdg_condiva = 5.
        WHEN "R" THEN Cliente.cdg_condiva = 1.
        WHEN "M" THEN Cliente.cdg_condiva = 6.
        WHEN "N" THEN Cliente.cdg_condiva = 2.
        WHEN "E" THEN Cliente.cdg_condiva = 4.
  END CASE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crear_cliente V-table-Win 
PROCEDURE crear_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Cobrador OF Grupofam NO-LOCK.
  FIND Vendedor WHERE Vendedor.cdg_vendedor = Grupofam.cdg_promotor NO-LOCK.

  CREATE Cliente.
  
  ASSIGN Cliente.nro_cliente = NEXT-VALUE(proximo_cliente).
  
  RUN asignar_cliente.
    
  Grupofam.nro_cliente = Cliente.nro_cliente.

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

  Grupofam.cdg_estado:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "A".

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

    DEFINE BUFFER B-Grupofam FOR Grupofam.
  
    IF CAN-FIND(FIRST B-Grupofam 
                      WHERE ROWID(B-Grupofam) <> ROWID(Grupofam)
                        AND B-Grupofam.cdg_grupofam = Grupofam.cdg_grupofam:SCREEN-VALUE IN FRAME {&FRAME-NAME}
                        AND B-Grupofam.cdg_empresa  = Empresa.cdg_empresa)
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF001").
         RETURN ERROR.
    END.                      

    IF NOT CAN-FIND(FIRST Plan 
                      WHERE Plan.cdg_plan = Grupofam.cdg_plan:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF002").
         RETURN ERROR.
    END.                      
    
    IF NOT CAN-FIND(FIRST Cobrador 
                      WHERE Cobrador.cdg_cobrador = Grupofam.cdg_cobrador:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF003").
         RETURN ERROR.
    END.                      

    IF NOT CAN-FIND(FIRST Vendedor 
                      WHERE Vendedor.cdg_vendedor = Grupofam.cdg_promotor:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF004").
         RETURN ERROR.
    END.                      
/*
    IF NOT CAN-FIND(FIRST Tarjeta 
                      WHERE Plan.cdg_plan = Grupofam.cdg_plan:SCREEN-VALUE IN FRAME {&FRAME-NAME})
    THEN DO:
         RUN ponmensj.p ( INPUT "GRUF005").
         RETURN ERROR.
    END.                      
*/

    {creahistoria.i &MAESTRO=Grupofam &HISTORICA=Hst_grupofam}

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    IF NEW Grupofam
    THEN DO:
         Grupofam.cdg_empresa = Empresa.cdg_empresa.
         RUN crear_cliente.
    END.
    ELSE DO:

         CASE Grupofam.cdg_estado:SCREEN-VALUE IN FRAME {&FRAME-NAME}:

            WHEN "R" /* Recupero de Baja */
            THEN DO:
                 Grupofam.fecha_baja = ?.
                 Grupofam.cdg_motbaja = "".
                 Grupofam.cdg_estado = "A".
                 FOR EACH Afiliado OF Grupofam EXCLUSIVE-LOCK:
                     Afiliado.cdg_estado = "A".
                     Afiliado.fecha_baja = ?.
                 END.
                 
                 FOR EACH Grupo-domicilio OF Grupofam EXCLUSIVE-LOCK:
                     Grupo-domicilio.cdg_estado = "A".
                 END.
                 
                 FIND Cliente WHERE Cliente.cdg_cliente = 
                                    Grupofam.cdg_empresa + Grupofam.cdg_grupofam 
                                    NO-LOCK NO-ERROR.
   
                 IF NOT AVAILABLE Cliente
                 THEN DO:
                      RUN crear_cliente.
                 END.     
                 ELSE DO:
                      Grupofam.nro_cliente = Cliente.nro_cliente. /* Asigna Cliente existente */
                      RUN actualizar_cliente.
                 END.     
            END.

            WHEN "B" /* Baja */
            THEN DO:
                 Grupofam.cdg_estado = "B".
                 FOR EACH Afiliado OF Grupofam WHERE Afiliado.cdg_estado = "A" EXCLUSIVE-LOCK:
                     ASSIGN
                        Afiliado.cdg_estado = "B"
                        Afiliado.fecha_baja = Grupofam.fecha_baja.
                     FOR EACH Pedido_credencial OF Afiliado 
                         WHERE Pedido_credencial.cumplido <> "C" EXCLUSIVE-LOCK:
                         DELETE Pedido_credencial.
                     END.
                 END.
                 FIND Cliente WHERE Cliente.cdg_cliente = 
                                    Grupofam.cdg_empresa + Grupofam.cdg_grupofam NO-LOCK NO-ERROR.
   
                 RUN actualizar_cliente.

                 FOR EACH Grupo-domicilio OF Grupofam EXCLUSIVE-LOCK:
                     Grupo-domicilio.cdg_estado = "B".
                 END.

            END.
   
            OTHERWISE RUN actualizar_cliente.

         END CASE.

         RELEASE Afiliado.
         RELEASE Grupo-domicilio.
         RELEASE Cliente.
    
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

  /* Code placed here will execute PRIOR to standard behavior. */

   FOR EACH Grupo-domicilio OF Grupofam:
       DELETE Grupo-domicilio.
   END.

   FOR EACH Afiliado OF Grupofam:
       DELETE Afiliado.
   END.
   
   FOR EACH Hst_domicilio OF Grupofam:
       DELETE Hst_domicilio. 
   END.
   
   FOR EACH Hst_grupofam OF Grupofam:
       DELETE Hst_grupofam.
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

  Grupofam.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.

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

  Grupofam.observacion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.

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
  {src/adm/template/snd-list.i "Grupofam"}
  {src/adm/template/snd-list.i "Empresa"}

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


