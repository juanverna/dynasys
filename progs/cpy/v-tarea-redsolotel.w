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

  DEFINE VARIABLE x-lista AS CHARACTER.
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

DEFINE VAR auxdireccion LIKE tarea.direccion.


DEFINE TEMP-TABLE tt NO-UNDO
    FIELD cdg_recurso LIKE recurso.cdg_recurso
    FIELD nom_recurso LIKE Recurso.nom_recurso
    FIELD grado AS INT
    INDEX grado grado.

DEFINE VAR hpersona AS HANDLE NO-UNDO.
DEFINE VAR hhistorico AS HANDLE NO-UNDO.

{tiempo.i}
{advtexto.i}
DEFINE BUFFER administrador FOR cliente.
    DEFINE VAR rid AS ROWID NO-UNDO.
       DEFINE VAR rid_tabla AS ROWID NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartViewer
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME sF-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Tarea
&Scoped-define FIRST-EXTERNAL-TABLE Tarea


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Tarea.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS Tarea.cdg_cargo Tarea.email 
&Scoped-define ENABLED-TABLES Tarea
&Scoped-define FIRST-ENABLED-TABLE Tarea
&Scoped-Define ENABLED-OBJECTS bVer BUTTON-6 BUTTON-11 BUTTON-12 BUTTON-13 
&Scoped-Define DISPLAYED-FIELDS Tarea.cdg_cargo Tarea.email 
&Scoped-define DISPLAYED-TABLES Tarea
&Scoped-define FIRST-DISPLAYED-TABLE Tarea
&Scoped-Define DISPLAYED-OBJECTS v-cdg_administrador v-cdg_cliente te-1 ~
vte-1 te-2 vte-2 te-3 vte-3 te-4 vte-4 snooze 

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
nro_usuario||y|sic.Tarea.nro_usuario
descripcion||y|sic.Tarea.descripcion
cdg_cargo||y|sic.Tarea.cdg_cargo
nom_cliente||y|sic.Tarea.nom_cliente
nro_cliente||y|sic.Tarea.nro_cliente
cdg_postal||y|sic.Tarea.cdg_postal
nro_evento||y|sic.Tarea.nro_evento
nro_persona||y|sic.Tarea.nro_persona
cdg_proyecto||y|sic.Tarea.cdg_proyecto
cdg_recurso||y|sic.Tarea.cdg_recurso
cdg_tipotarea||y|sic.Tarea.cdg_tipotarea
cdg_tarea||y|sic.Tarea.cdg_tarea
cdg_usuario||y|sic.Tarea.cdg_usuario
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "nro_usuario,descripcion,cdg_cargo,nom_cliente,nro_cliente,cdg_postal,nro_evento,nro_persona,cdg_proyecto,cdg_recurso,cdg_tipotarea,cdg_tarea,cdg_usuario"':U).
/**************************
</EXECUTING-CODE> */
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD chartel V-table-Win 
FUNCTION chartel RETURNS LOGICAL
  ( p AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD thandle V-table-Win 
FUNCTION thandle RETURNS HANDLE
  ( ppar AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE CtrlFrame AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chCtrlFrame AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-11 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 11" 
     SIZE 5 BY 1.14.

DEFINE BUTTON BUTTON-12 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 12" 
     SIZE 5 BY 1.14.

DEFINE BUTTON BUTTON-13 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 13" 
     SIZE 5 BY 1.14.

DEFINE BUTTON BUTTON-6 
     IMAGE-UP FILE "iconos16/telephone.jpg":U
     LABEL "Button 6" 
     SIZE 5 BY 1.14.

DEFINE BUTTON bVer 
     LABEL "Ver" 
     SIZE 7.8 BY 1.

DEFINE VARIABLE snooze AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Nada","0",
                     "15 min","15",
                     "30 min","30",
                     "Hora","60",
                     "2 Horas","120",
                     "Mañana","T",
                     "Pasado","P",
                     "Semana","W",
                     "Mes(dia 1)","M"
     DROP-DOWN-LIST
     SIZE 19 BY 1 TOOLTIP "Correr la visualizacion demorandola"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 10.8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 10.8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 10.8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE te-4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 10.8 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_administrador AS CHARACTER 
     LABEL "Admin" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "---" 
     SIMPLE
     SIZE 13 BY 1 TOOLTIP "Seleccione administrador o dbl-click para buscar"
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cliente AS CHARACTER FORMAT "X(8)" 
     LABEL "Cli" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE vte-1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29.2 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29.2 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE vte-4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 29.2 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME sF-Main
     v-cdg_administrador AT ROW 1 COL 24 COLON-ALIGNED WIDGET-ID 92
     v-cdg_cliente AT ROW 1.05 COL 3 COLON-ALIGNED WIDGET-ID 2
     bVer AT ROW 1.05 COL 40.2 WIDGET-ID 86
     te-1 AT ROW 3.33 COL 1.2 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     vte-1 AT ROW 3.33 COL 11.8 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     BUTTON-6 AT ROW 3.38 COL 43 WIDGET-ID 96
     BUTTON-11 AT ROW 4.33 COL 43 WIDGET-ID 106
     te-2 AT ROW 4.38 COL 1.2 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     vte-2 AT ROW 4.38 COL 11.8 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     BUTTON-12 AT ROW 5.38 COL 43 WIDGET-ID 108
     te-3 AT ROW 5.43 COL 1.2 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     vte-3 AT ROW 5.43 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     te-4 AT ROW 6.43 COL 1.2 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     vte-4 AT ROW 6.43 COL 11.8 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     BUTTON-13 AT ROW 6.43 COL 43 WIDGET-ID 110
     Tarea.cdg_cargo AT ROW 7.52 COL 5.6 COLON-ALIGNED WIDGET-ID 66
          LABEL "Rel."
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN
          SIZE 20 BY 1
          BGCOLOR 15 FGCOLOR 9 
     snooze AT ROW 7.52 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     Tarea.email AT ROW 8.57 COL 3 NO-LABEL WIDGET-ID 52 FORMAT "X(100)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 45 BY 1 TOOLTIP "Email particular"
          BGCOLOR 15 FGCOLOR 9 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.Tarea
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
         HEIGHT             = 8.67
         WIDTH              = 47.8.
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
/* SETTINGS FOR FRAME sF-Main
   NOT-VISIBLE FRAME-NAME Size-to-Fit                                   */
ASSIGN 
       FRAME sF-Main:SCROLLABLE       = FALSE
       FRAME sF-Main:HIDDEN           = TRUE.

/* SETTINGS FOR COMBO-BOX Tarea.cdg_cargo IN FRAME sF-Main
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN Tarea.email IN FRAME sF-Main
   ALIGN-L EXP-FORMAT                                                   */
/* SETTINGS FOR COMBO-BOX snooze IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX te-1 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX te-2 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX te-3 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX te-4 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX v-cdg_administrador IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cliente IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vte-1 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vte-2 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vte-3 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN vte-4 IN FRAME sF-Main
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME sF-Main
/* Query rebuild information for FRAME sF-Main
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* FRAME sF-Main */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME CtrlFrame ASSIGN
       FRAME           = FRAME sF-Main:HANDLE
       ROW             = 2.19
       COLUMN          = 3
       HEIGHT          = 1.1
       WIDTH           = 45
       WIDGET-ID       = 68
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      CtrlFrame:NAME = "CtrlFrame":U .
/* CtrlFrame OCXINFO:CREATE-CONTROL from: {93330F00-7CA6-101B-874B-0020AF109266} type: CSComboBox */
      CtrlFrame:MOVE-AFTER(bVer:HANDLE IN FRAME sF-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME BUTTON-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-11 V-table-Win
ON CHOOSE OF BUTTON-11 IN FRAME sF-Main /* Button 11 */
DO:
    OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-2:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-12 V-table-Win
ON CHOOSE OF BUTTON-12 IN FRAME sF-Main /* Button 12 */
DO:
  OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-3:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 V-table-Win
ON CHOOSE OF BUTTON-13 IN FRAME sF-Main /* Button 13 */
DO:
  OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-4:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-6 V-table-Win
ON CHOOSE OF BUTTON-6 IN FRAME sF-Main /* Button 6 */
DO:
  OUTPUT TO "CLIPBOARD".
  PUT UNFORMATTED "9" + vte-1:SCREEN-VALUE IN FRAME {&FRAME-NAME}.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bVer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bVer V-table-Win
ON CHOOSE OF bVer IN FRAME sF-Main /* Ver */
DO:
  DEFINE BUFFER badminis FOR cliente.

  IF cliente.nro_administrador <> 0 
      THEN DO:
  FIND badminis WHERE badminis.nro_cliente = cliente.nro_administrador NO-LOCK NO-ERROR.
  IF AVAILABLE badminis THEN
          RUN w-zoom_administraciones.w ( INPUT ROWID(badminis) ).
  END.
  ELSE 
     RUN ponmensj.p ( INPUT "USR_015").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME CtrlFrame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame V-table-Win
ON LEAVE OF CtrlFrame /* CSComboBox */
DO:
    RUN poner_contacto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL CtrlFrame V-table-Win OCX.CloseUp
PROCEDURE CtrlFrame.CSComboBox.CloseUp .
RUN poner_contacto.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Tarea.email
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Tarea.email V-table-Win
ON LEAVE OF Tarea.email IN FRAME sF-Main /* E-mail!Persona */
DO:
  IF {&SELF-NAME}:INPUT-VALUE <> "" THEN do:
      IF NOT emailcheck({&SELF-NAME}:SCREEN-VALUE) THEN DO:
          RUN ponmensj.p ( INPUT "EMAIL01" ).
          RETURN NO-APPLY.
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_administrador
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_administrador V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_administrador IN FRAME sF-Main /* Admin */
OR "." OF v-cdg_administrador IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_administrador IN FRAME {&FRAME-NAME}
DO:
    ASSIGN v-cdg_Administrador.
    FIND Administrador WHERE Administrador.cdg_cliente = v-cdg_Administrador NO-LOCK NO-ERROR.
       rid_tabla = IF AVAILABLE Administrador THEN ROWID( Administrador ) ELSE ?.
    
      RUN SELADMINIS.P ( INPUT-OUTPUT rid_tabla, INPUT YES ).
      IF rid_tabla <> ?
      THEN DO:
           FIND Administrador WHERE ROWID(Administrador) = rid_tabla NO-LOCK.
           v-cdg_Administrador:SCREEN-VALUE IN FRAME {&FRAME-NAME} = Administrador.cdg_cliente.
           APPLY "RETURN" TO SELF.
      END.       
      RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_cliente
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON LEAVE OF v-cdg_cliente IN FRAME sF-Main /* Cli */
DO:
    IF v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
    THEN DO:
        FIND cliente WHERE cliente.cdg_cliente = INPUT FRAME {&FRAME-NAME} v-cdg_cliente NO-LOCK NO-ERROR.
        IF NOT AVAILABLE cliente
        THEN DO:
            RUN PONMENSJ.P ( 'IREF002' ).
            RETURN NO-APPLY.
        END.
    END.
    RUN poner_cliente.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_cliente IN FRAME sF-Main /* Cli */
OR MOUSE-MENU-DOWN OF v-cdg_cliente IN FRAME {&FRAME-NAME}
DO:
    DEFINE VAR rid_tabla AS ROWID.
    ASSIGN v-cdg_cliente.
    FIND cliente WHERE cliente.cdg_cliente = v-cdg_cliente NO-LOCK NO-ERROR.
    rid_tabla = IF AVAILABLE cliente THEN ROWID( cliente ) ELSE ?.

    RUN selclien.p ( INPUT-OUTPUT rid_tabla, INPUT YES ).
    IF rid_tabla <> ?
    THEN DO:
        FIND cliente WHERE ROWID(cliente) = rid_tabla NO-LOCK.
        RUN poner_cliente.
        RUN poner_contacto.
    END.
    RETURN NO-APPLY.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_cliente V-table-Win
ON RETURN OF v-cdg_cliente IN FRAME sF-Main /* Cli */
DO:
    IF v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
    THEN DO:

        FIND cliente WHERE cliente.cdg_cliente = INPUT FRAME {&FRAME-NAME} v-cdg_cliente NO-LOCK NO-ERROR.
        IF NOT AVAILABLE cliente
        THEN DO:
            RUN PONMENSJ.P ( 'IREF002' ).
            RETURN NO-APPLY.
        END.
        RUN poner_cliente.
        RUN poner_contacto.
     END.                                                                                                   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vte-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vte-1 V-table-Win
ON ANY-PRINTABLE OF vte-1 IN FRAME sF-Main
DO:
  IF NOT chartel(LASTKEY) THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vte-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vte-2 V-table-Win
ON ANY-PRINTABLE OF vte-2 IN FRAME sF-Main
DO:
  IF NOT chartel(LASTKEY) THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vte-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vte-3 V-table-Win
ON ANY-PRINTABLE OF vte-3 IN FRAME sF-Main
DO:
  IF NOT chartel(LASTKEY) THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME vte-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL vte-4 V-table-Win
ON ANY-PRINTABLE OF vte-4 IN FRAME sF-Main
DO:
  IF NOT chartel(LASTKEY) THEN RETURN NO-APPLY.
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

  /* No Foreign keys are accepted by this SmartObject. */

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
  {src/adm/template/row-list.i "Tarea"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Tarea"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambia_cliente V-table-Win 
PROCEDURE cambia_cliente :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM p AS ROWID.
    FIND cliente WHERE ROWID(cliente) = p NO-LOCK NO-ERROR.
    IF AVAILABLE cliente THEN DO: 
        RUN poner_cliente.
        RUN poner_contacto.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load V-table-Win  _CONTROL-LOAD
PROCEDURE control_load :
/*------------------------------------------------------------------------------
  Purpose:     Load the OCXs    
  Parameters:  <none>
  Notes:       Here we load, initialize and make visible the 
               OCXs in the interface.                        
------------------------------------------------------------------------------*/

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN
DEFINE VARIABLE UIB_S    AS LOGICAL    NO-UNDO.
DEFINE VARIABLE OCXFile  AS CHARACTER  NO-UNDO.

OCXFile = SEARCH( "v-tarea-redsolotel.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chCtrlFrame = CtrlFrame:COM-HANDLE
    UIB_S = chCtrlFrame:LoadControls( OCXFile, "CtrlFrame":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "v-tarea-redsolotel.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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
  HIDE FRAME sF-Main.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos V-table-Win 
PROCEDURE habilitar_campos :
DEF INPUT PARAM YY AS LOGICAL NO-UNDO.
DO WITH FRAME {&FRAME-NAME}:
/*    te-1:SENSITIVE = yy.
    te-2:SENSITIVE = yy.
    te-3:SENSITIVE = yy.
    te-4:SENSITIVE = yy.
    vte-1:SENSITIVE = yy.
    vte-2:SENSITIVE = yy.
    vte-3:SENSITIVE = yy.
    vte-4:SENSITIVE = yy.*/
    v-cdg_administrador:SENSITIVE = yy.
    v-cdg_cliente:SENSITIVE IN FRAME {&FRAME-NAME} = yy.
    snooze:SENSITIVE = yy.
END.
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
      lista = "[Indique],".
      FOR EACH Cargo_persona:
          lista = lista + "," + Cargo_persona.dsc_cargo + "," + Cargo_persona.cdg_cargo.
      END.
     &SCOPED-DEFINE  CONDICION tipo_dato.Tipo="T"
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-1  }.
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-2  }.
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-3  }.
     {levantacombo.i &TABLA=tipo_dato &NOMBRE=descripcion &CODIGO=cdg_tipo_dato &OBJETO=te-4  }.
     
  END.          

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_recursos V-table-Win 
PROCEDURE inicia_recursos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER  auxcdg_tipotarea LIKE tarea.cdg_tipotarea.
DEF VAR i AS INT NO-UNDO.
DEFINE VARIABLE x-recurso AS CHARACTER NO-UNDO.
DEFINE VAR soloh AS CHARACTER NO-UNDO.
DEFINE VAR solog AS INTEGER NO-UNDO.
IF  AVAILABLE tarea  THEN x-recurso = Tarea.cdg_recurso.
ELSE x-recurso = "*".
x-lista = "[Indique Recurso],*".
/*selecciona los recursos que tienen todas esas habilidades simultaneamente*/
FIND tipo_tarea WHERE tipo_tarea.cdg_tipotarea = auxcdg_tipotarea NO-LOCK NO-ERROR.

IF AVAILABLE tipo_tarea THEN DO:
  EMPTY TEMP-TABLE tt.

  FOR EACH Recurso BY Recurso.interno DESCENDING :
        soloh = "".
        solog = 0.
        DO i = 1 TO NUM-ENTRIES(recurso.habilidades):
            soloh = entry(1,ENTRY(i,recurso.habilidades),"@").
            solog = int(entry(2,ENTRY(i,recurso.habilidades),"@")) NO-ERROR.
        
           IF NOT CAN-DO(soloh, auxcdg_tipotarea ) THEN next.
           FIND tt WHERE tt.cdg_recurso = recurso.cdg_recurso NO-ERROR.
           IF NOT AVAILABLE tt THEN DO:
               CREATE tt.
               ASSIGN tt.cdg_recurso = recurso.cdg_recurso
                      tt.nom_recurso = Recurso.nom_recurso.
                      tt.grado = solog.
           END.
        END.
  END. 

  FOR EACH tt BY tt.grado:
      x-lista = x-lista +  "," + tt.nom_recurso + "," + tt.cdg_recurso.
  END.

END.
IF LOOKUP(x-recurso,SUBSTRING(x-lista,2)) = 0 AND x-recurso <> "" AND x-recurso <> ? THEN DO:
    x-lista = x-lista + "," + "Desconocido" + "," + x-recurso.
END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-assign-statement V-table-Win 
PROCEDURE local-assign-statement :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR i AS INT NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
DEFINE BUFFER btarea FOR tarea.
DEFINE VARIABLE hora AS INTEGER.
DEFINE VAR pvisualizar AS DATETIME NO-UNDO.
pvisualizar = tarea.visualizar.
  /* Code placed here will execute PRIOR to standard behavior. */


  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'assign-statement':U ) .


ASSIGN FRAME {&FRAME-NAME} snooze.
CASE snooze:
    WHEN "15" THEN tarea.visualizar = ADD-INTERVAL( now , 15 , 'minutes' ).
    WHEN "30" THEN tarea.visualizar = ADD-INTERVAL( now , 30 , 'minutes' ).
    WHEN "60" THEN tarea.visualizar = ADD-INTERVAL( now , 1 , 'hour' ).
    WHEN "120" THEN tarea.visualizar = ADD-INTERVAL( now , 2 , 'hour' ).
    WHEN "T" THEN tarea.visualizar = ADD-INTERVAL( now , 1 , 'day' ).
    WHEN "P" THEN tarea.visualizar = ADD-INTERVAL( now ,2 , 'day' ).
    WHEN "W" THEN tarea.visualizar = ADD-INTERVAL( now , 1 , 'week' ).
    WHEN "M" THEN DO: 
        tarea.visualizar = ADD-INTERVAL( DATETIME( MONTH(now),1,YEAR(NOW),0,0,0 ) , 1 , 'month').
    REPEAT:
         IF NOT es_habil(date(tarea.visualizar),"23456") THEN
                   tarea.visualizar = ADD-INTERVAL(tarea.visualizar,-1,"days").
         ELSE LEAVE.
    END.
        /*tarea.visualizar = ADD-INTERVAL( now , 1 , 'month' ).*/
    END.
END CASE.
IF snooze <> "0" THEN DO:
    /*almacenar la fecha alterior y posterior de la visualizacion y interviniente*/
    agregaAdvTexto("Cambio Visualizar de " + STRING( pvisualizar )+ " a " + STRING( tarea.visualizar ),tarea.descripcion).
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

/*   Tarea.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 7. */
/*   Tarea.accion:FGCOLOR IN FRAME {&FRAME-NAME} = 7.      */
  RUN habilitar_campos(FALSE).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-display-fields V-table-Win 
PROCEDURE local-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR aux AS CHAR NO-UNDO.
DEFINE VAR auxtel LIKE tarea.telefonos NO-UNDO.
DEFINE VAR lista AS CHAR.
DO WITH FRAME {&FRAME-NAME}:
/*  lista = "".
  IF AVAILABLE tarea THEN DO:
        IF tarea.nro_persona <> 0 THEN DO:
            IF (tarea.nro_cliente <> 0 ) THEN lista =",Cliente,CLIEN".
            IF tarea.nro_administrador <> 0 THEN lista = lista + ",Admin,ADMIN".
            rpersona:LIST-ITEM-PAIRS = SUBSTRING(lista,2).
            FIND cliente-contacto WHERE cliente-contacto.nro_persona = tarea.nro_persona AND Cliente-contacto.nro_cliente = tarea.nro_cliente NO-LOCK NO-ERROR.
            IF NOT AVAILABLE cliente-contacto THEN DO:
                FIND cliente-contacto WHERE cliente-contacto.nro_persona = tarea.nro_persona AND Cliente-contacto.nro_cliente = tarea.nro_administrador NO-LOCK NO-ERROR.
                IF NOT AVAILABLE cliente-contacto THEN 
                    MESSAGE "Error al validar el contacto" VIEW-AS ALERT-BOX ERROR.
                ELSE
                   rpersona:SCREEN-VALUE = "ADMIN".
            END.
            ELSE
                rpersona:SCREEN-VALUE = "CLIEN".
        END.
        ELSE DO:
            rpersona:LIST-ITEM-PAIRS = "No ALTA,NOALTA".
        END.
  END.
  ELSE DO:
        rpersona:LIST-ITEM-PAIRS = "No ALTA,NOALTA".
  END.*/
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .

IF NOT AVAILABLE tarea THEN RETURN.
chCtrlFrame:CSComboBox:TEXT = tarea.reportado_por.

IF tarea.nro_cliente <> 0 THEN DO:
  FIND cliente OF tarea NO-LOCK NO-ERROR.
  IF AVAILABLE cliente THEN DO:
    RUN poner_cliente.
    RUN poner_contacto.
  END.
END.
RUN poner_administrador.
/*RUN poner_contacto.*/
  auxtel = tarea.telefonos.
  IF INDEX(tarea.telefonos,"!") = 0 THEN DO:
        RUN getparametro_c.p ("CDG-TE1",OUTPUT aux).
        auxtel = replace(aux + "!" + auxtel,"|","%").
  END.

  DO i = 1 TO 4:
     IF i <= NUM-ENTRIES(auxtel,"|") THEN DO:
          thandle("te-" + STRING(i,"9")):SCREEN-VALUE = entry(1,ENTRY(i,auxtel,"|"),"!").
          thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = entry(2,ENTRY(i,auxtel,"|"),"!").
     END.
     ELSE DO:
          RUN getparametro_c.p ("CDG-TE" + STRING(i,"9"),OUTPUT aux).
          thandle("te-" + STRING(i,"9")):SCREEN-VALUE = aux.
          thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = "".
          
     END.
  END.   

  
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

/*   Tarea.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 9. */
/*   Tarea.accion:FGCOLOR IN FRAME {&FRAME-NAME} = 9.      */
  RUN habilitar_campos(TRUE).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize V-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  RUN inicia_combos.

    /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

    chCtrlFrame:CSComboBox:ENABLED = TRUE.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_administrador V-table-Win 
PROCEDURE poner_administrador :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  FIND administrador WHERE administrador.nro_cliente = tarea.nro_admin NO-ERROR.
  v-cdg_administrador:SCREEN-VALUE IN FRAME {&FRAME-NAME}= IF AVAILABLE administrador THEN administrador.cdg_cliente ELSE "---".
  v-cdg_administrador:TOOLTIP IN FRAME {&FRAME-NAME}= IF AVAILABLE administrador THEN administrador.nom_cliente ELSE "No registrado".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_cliente V-table-Win 
PROCEDURE poner_cliente :
/*------------------------------------------------------------------------------
  Purpose:  Pone los valores extraidos del cliente seleccionado.   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER badm FOR cliente.


v-cdg_administrador:LIST-ITEMS IN FRAME {&FRAME-NAME}= "---".
IF AVAILABLE cliente THEN DO:
  FIND badm WHERE badm.nro_cliente = cliente.nro_administrador NO-LOCK NO-ERROR.
  IF AVAILABLE badm THEN
    v-cdg_administrador:ADD-FIRST(badm.cdg_cliente).
    v-cdg_administrador:SCREEN-VALUE = badm.cdg_cliente.
    v-cdg_administrador:TOOLTIP = badm.nom_cliente.
    v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME}= cliente.cdg_cliente.
    ASSIGN v-cdg_administrador v-cdg_cliente.
    DISPLAY v-cdg_administrador v-cdg_cliente WITH FRAME {&FRAME-NAME}.
    RUN refresco_contacto.
    RUN poner_contacto.

END.
ELSE v-cdg_cliente:SCREEN-VALUE IN FRAME {&FRAME-NAME}= "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_contacto V-table-Win 
PROCEDURE poner_contacto :
/*------------------------------------------------------------------------------
  Purpose: Actualiza los campos del acntacto con el seleccionado en CSCombobox    
           previo borrado de lo anterior
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR aux AS CHAR NO-UNDO.
DEFINE VAR auxtel AS CHAR NO-UNDO.
DEFINE VAR auxpersona AS INT NO-UNDO.
/*limpiar todo lo existinte*/
vte-1:SCREEN-VALUE IN FRAME {&FRAME-NAME}= "".
vte-2:SCREEN-VALUE = "".
vte-3:SCREEN-VALUE = "".
vte-4:SCREEN-VALUE = "".


    IF chCtrlFrame:CSComboBox:VALUE <> "" THEN DO:
        auxpersona = int(entry(4,chCtrlFrame:CSComboBox:value,"|")).
            FIND persona WHERE persona.nro_persona = auxpersona NO-LOCK.
            auxtel = Persona.numeros_telefono.
            DO i = 1 TO 4:
             IF i <= NUM-ENTRIES(auxtel,"|") THEN DO:
                  thandle("te-" + STRING(i,"9")):SCREEN-VALUE = entry(1,ENTRY(i,auxtel,"|"),"!").
                  thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = entry(2,ENTRY(i,auxtel,"|"),"!").
             END.
             ELSE DO:
                  RUN getparametro_c.p ("CDG-TE" + STRING(i,"9"),OUTPUT aux).
                  thandle("te-" + STRING(i,"9")):SCREEN-VALUE = aux.
                  thandle("vte-" + STRING(i,"9")):SCREEN-VALUE = "".

             END.
            END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refresco_contacto V-table-Win 
PROCEDURE refresco_contacto :
/*------------------------------------------------------------------------------
  Purpose:  si el campo viene con datos lo formatea ya que es un cliente   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR auxcargo AS CHAR NO-UNDO.
DEFINE VAR preferido AS CHAR NO-UNDO.
DEFINE VAR preferidoadmin AS CHAR NO-UNDO.
DEFINE VAR resl AS INT NO-UNDO.

hpersona =  chCtrlFrame:CSComboBox.
chCtrlFrame:CSComboBox:CLEAR().
chCtrlFrame:CSComboBox:ColDelim = "|".
chCtrlFrame:CSComboBox:ColWidths = "30;10;10;0".

DO WITH FRAME {&FRAME-NAME}:
    FIND administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK NO-ERROR.
    IF AVAILABLE administrador THEN do:
      FIND FIRST domicilio OF administrador NO-LOCK.
      FOR EACH Cliente-contacto OF Domicilio  NO-LOCK,
          each Persona OF Cliente-contacto NO-LOCK :
         FIND FIRST cargo_persona OF cliente-contacto NO-LOCK NO-ERROR.
         auxcargo = IF NOT AVAILABLE cargo_persona THEN "" ELSE Cargo_persona.cdg_cargo.
         chCtrlFrame:CSComboBox:ADDitem( persona.nombre + "|ADMIN|" + auxcargo + "|" + STRING(persona.nro_persona) ).
         IF  can-do(Cliente-contacto.canal-email,"*") THEN preferidoadmin = STRING(persona.nro_persona).  
      END.
    END.
    preferido = "".
    IF AVAILABLE cliente THEN DO:
     IF cliente.nro_cliente <> cliente.nro_administrador THEN DO:
        FIND FIRST domicilio OF cliente NO-LOCK.
        FOR EACH Cliente-contacto OF Domicilio  NO-LOCK,
          each Persona OF Cliente-contacto NO-LOCK :
            FIND FIRST cargo_persona OF cliente-contacto NO-LOCK NO-ERROR.
             auxcargo = IF NOT AVAILABLE cargo_persona THEN "" ELSE  Cargo_persona.cdg_cargo.
            chCtrlFrame:CSComboBox:ADDitem( persona.nombre + "|CLIEN|" + auxcargo + "|" + STRING(persona.nro_persona) ).
            IF  can-do(Cliente-contacto.canal-email,"*")  THEN preferido = STRING(persona.nro_persona).  
            END.
     END.
    END.


IF AVAILABLE tarea THEN DO:

        IF tarea.reportado_por <> "" THEN DO:
           resl = chCtrlFrame:CSComboBox:SelectString(trim(tarea.reportado_por),0).
           IF resl > 0 THEN           
               RUN poner_contacto.
        END.
/*valor por default*/
        ELSE DO: /*si no aparece nadie como reportado usar el preferido y sino el primero*/
         IF preferido <> "" THEN DO:   
               FIND persona WHERE persona.nro_persona = INT(preferido).
               resl = chCtrlFrame:CSComboBox:SelectString( persona.nombre ).
               IF resl > 0 THEN           
                        RUN poner_contacto.
         END.
         ELSE DO:
         IF preferidoadmin <> "" THEN DO:   
               FIND persona WHERE persona.nro_persona = INT(preferidoadmin).
               resl = chCtrlFrame:CSComboBox:SelectString( persona.nombre ).
               IF resl > 0 THEN           
                        RUN poner_contacto.
         END.      
         END.      
        END.      
    END.
END.
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
  {src/adm/template/sndkycas.i "nro_usuario" "Tarea" "nro_usuario"}
  {src/adm/template/sndkycas.i "descripcion" "Tarea" "descripcion"}
  {src/adm/template/sndkycas.i "cdg_cargo" "Tarea" "cdg_cargo"}
  {src/adm/template/sndkycas.i "nom_cliente" "Tarea" "nom_cliente"}
  {src/adm/template/sndkycas.i "nro_cliente" "Tarea" "nro_cliente"}
  {src/adm/template/sndkycas.i "cdg_postal" "Tarea" "cdg_postal"}
  {src/adm/template/sndkycas.i "nro_evento" "Tarea" "nro_evento"}
  {src/adm/template/sndkycas.i "nro_persona" "Tarea" "nro_persona"}
  {src/adm/template/sndkycas.i "cdg_proyecto" "Tarea" "cdg_proyecto"}
  {src/adm/template/sndkycas.i "cdg_recurso" "Tarea" "cdg_recurso"}
  {src/adm/template/sndkycas.i "cdg_tipotarea" "Tarea" "cdg_tipotarea"}
  {src/adm/template/sndkycas.i "cdg_tarea" "Tarea" "cdg_tarea"}
  {src/adm/template/sndkycas.i "cdg_usuario" "Tarea" "cdg_usuario"}

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
  {src/adm/template/snd-list.i "Tarea"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION chartel V-table-Win 
FUNCTION chartel RETURNS LOGICAL
  ( p AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
RETURN INDEX("01234567890-()",CHR(p)) <> 0.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION thandle V-table-Win 
FUNCTION thandle RETURNS HANDLE
  ( ppar AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

CASE ppar:
    WHEN "te-1" THEN RETURN te-1:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "te-2" THEN RETURN te-2:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "te-3" THEN RETURN te-3:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "te-4" THEN RETURN te-4:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-1" THEN RETURN vte-1:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-2" THEN RETURN vte-2:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-3" THEN RETURN vte-3:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "vte-4" THEN RETURN vte-4:HANDLE IN FRAME {&FRAME-NAME}.

    OTHERWISE do: RETURN ?. END.
END CASE.


  RETURN ?.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

