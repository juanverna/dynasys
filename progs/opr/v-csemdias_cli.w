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

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES cliente_restriccion
&Scoped-define FIRST-EXTERNAL-TABLE cliente_restriccion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR cliente_restriccion.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS cliente_restriccion.Valor 
&Scoped-define ENABLED-TABLES cliente_restriccion
&Scoped-define FIRST-ENABLED-TABLE cliente_restriccion
&Scoped-Define ENABLED-OBJECTS RECT-10 BUTTON-13 
&Scoped-Define DISPLAYED-OBJECTS m-1 m-2 s-1 t-1 m-3 t-2 m-4 Fd Fh m-5 s-2 ~
t-3 m-6 t-4 m-7 m-8 s-3 t-5 m-9 t-6 m-10 m-11 s-4 t-7 m-12 

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

/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD muestra-error V-table-Win 
FUNCTION muestra-error RETURNS CHARACTER
  ( INPUT msg AS char )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD que_valor V-table-Win 
FUNCTION que_valor RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD thandle V-table-Win 
FUNCTION thandle RETURNS HANDLE
  ( p AS CHAR , i AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-m-1 
       MENU-ITEM m_Todos        LABEL "Todos"         
       MENU-ITEM m_Impares      LABEL "Impares"       
       MENU-ITEM m_Pares        LABEL "Pares"         
       MENU-ITEM m_Borra_todo   LABEL "Ninguno"       .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-13 
     LABEL "Ayuda" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE Fd AS INTEGER FORMAT ">9":U INITIAL 1 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1 NO-UNDO.

DEFINE VARIABLE Fh AS INTEGER FORMAT ">9":U INITIAL 31 
     LABEL "-" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 TOOLTIP "si se pone un 31 asumira el ultimo dia del mes segun corresponda" NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 30 BY 7.62.

DEFINE VARIABLE m-1 AS LOGICAL INITIAL no 
     LABEL "Enero" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-10 AS LOGICAL INITIAL no 
     LABEL "Octubre" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-11 AS LOGICAL INITIAL no 
     LABEL "Noviembre" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-12 AS LOGICAL INITIAL no 
     LABEL "Diciembre" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-2 AS LOGICAL INITIAL no 
     LABEL "Febrero" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-3 AS LOGICAL INITIAL no 
     LABEL "Marzo" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-4 AS LOGICAL INITIAL no 
     LABEL "Abril" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-5 AS LOGICAL INITIAL no 
     LABEL "Mayo" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-6 AS LOGICAL INITIAL no 
     LABEL "Junio" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-7 AS LOGICAL INITIAL no 
     LABEL "Julio" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-8 AS LOGICAL INITIAL no 
     LABEL "Agosto" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE m-9 AS LOGICAL INITIAL no 
     LABEL "Setiembre" 
     VIEW-AS TOGGLE-BOX
     SIZE 17.8 BY .81 NO-UNDO.

DEFINE VARIABLE s-1 AS LOGICAL INITIAL no 
     LABEL "Primero" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 NO-UNDO.

DEFINE VARIABLE s-2 AS LOGICAL INITIAL no 
     LABEL "Segundo" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 NO-UNDO.

DEFINE VARIABLE s-3 AS LOGICAL INITIAL no 
     LABEL "Tercer" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 NO-UNDO.

DEFINE VARIABLE s-4 AS LOGICAL INITIAL no 
     LABEL "Ultimo" 
     VIEW-AS TOGGLE-BOX
     SIZE 16 BY .81 NO-UNDO.

DEFINE VARIABLE t-1 AS LOGICAL INITIAL no 
     LABEL "Domingo" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE t-2 AS LOGICAL INITIAL no 
     LABEL "Lunes" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE t-3 AS LOGICAL INITIAL no 
     LABEL "Martes" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE t-4 AS LOGICAL INITIAL no 
     LABEL "Miercoles" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE t-5 AS LOGICAL INITIAL no 
     LABEL "Jueves" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE t-6 AS LOGICAL INITIAL no 
     LABEL "Viernes" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.

DEFINE VARIABLE t-7 AS LOGICAL INITIAL no 
     LABEL "Sabado" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     m-1 AT ROW 1.1 COL 1.2 WIDGET-ID 14
     m-2 AT ROW 1.71 COL 1 WIDGET-ID 16
     s-1 AT ROW 1.81 COL 20.6
     t-1 AT ROW 1.86 COL 35
     m-3 AT ROW 2.33 COL 1 WIDGET-ID 18
     cliente_restriccion.Valor AT ROW 2.57 COL 37.2 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 4 BY .29 NO-TAB-STOP 
     t-2 AT ROW 2.76 COL 35
     m-4 AT ROW 2.95 COL 1 WIDGET-ID 20
     Fd AT ROW 3.14 COL 55.2 COLON-ALIGNED WIDGET-ID 44
     Fh AT ROW 3.14 COL 63.2 COLON-ALIGNED WIDGET-ID 46
     m-5 AT ROW 3.57 COL 1 WIDGET-ID 22
     s-2 AT ROW 3.62 COL 20.6
     t-3 AT ROW 3.67 COL 35
     m-6 AT ROW 4.19 COL 1 WIDGET-ID 24
     t-4 AT ROW 4.57 COL 35
     m-7 AT ROW 4.81 COL 1 WIDGET-ID 26
     m-8 AT ROW 5.43 COL 1 WIDGET-ID 28
     s-3 AT ROW 5.43 COL 20.6
     t-5 AT ROW 5.48 COL 35
     m-9 AT ROW 6.05 COL 1 WIDGET-ID 30
     t-6 AT ROW 6.38 COL 35
     m-10 AT ROW 6.67 COL 1 WIDGET-ID 32
     m-11 AT ROW 7.29 COL 1 WIDGET-ID 34
     s-4 AT ROW 7.29 COL 20.6
     t-7 AT ROW 7.33 COL 35
     BUTTON-13 AT ROW 7.43 COL 55 WIDGET-ID 40
     m-12 AT ROW 8 COL 1 WIDGET-ID 36
     "Rango Dias" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 1.48 COL 58.2 WIDGET-ID 42
     RECT-10 AT ROW 1.24 COL 19 WIDGET-ID 38
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.cliente_restriccion
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
         HEIGHT             = 7.86
         WIDTH              = 72.6.
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

/* SETTINGS FOR FILL-IN Fd IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Fh IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-1 IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       m-1:POPUP-MENU IN FRAME F-Main       = MENU POPUP-MENU-m-1:HANDLE.

/* SETTINGS FOR TOGGLE-BOX m-10 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-11 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-12 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-3 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-4 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-5 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-6 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-7 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-8 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX m-9 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX s-1 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX s-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX s-3 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX s-4 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-1 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-2 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-3 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-4 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-5 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-6 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR TOGGLE-BOX t-7 IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN cliente_restriccion.Valor IN FRAME F-Main
   NO-DISPLAY                                                           */
ASSIGN 
       cliente_restriccion.Valor:HIDDEN IN FRAME F-Main           = TRUE.

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

&Scoped-define SELF-NAME BUTTON-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-13 V-table-Win
ON CHOOSE OF BUTTON-13 IN FRAME F-Main /* Ayuda */
DO:
  MESSAGE "1-Si no se elige ninguna opcion es TODOS" SKIP
      "2-Si es dia de la restriccion cae un feriado pasara al dia siguiente , sino al dia anterior habil" SKIP
      "3-En caso de no poder cumplir con una restriccion para ese operario se cambiara de semana, si ninguna semana se puede se cambiara de operario." SKIP
      "4-Para la semana ULTIMO significa intentar poner la 4 semama y si no puede la 5." SKIP
      "Presionando boton secundario sobre mes enero se abre un menu de seleccion rapida".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Fd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fd V-table-Win
ON LEAVE OF Fd IN FRAME F-Main /* Desde */
DO:
  ASSIGN fd.
  IF fd < 0 OR fd > 31 THEN DO:
      muestra-error("Desde invalido [0-31]").
      RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Fh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Fh V-table-Win
ON LEAVE OF Fh IN FRAME F-Main /* - */
DO:
  ASSIGN fh fd.
  IF fh < 1 OR fh > 31 THEN DO:
      muestra-error("Hasta invalido [0-31]").
      RETURN NO-APPLY.
  END.
  IF fd > fh THEN DO:
      muestra-error("El Hasta debe ser mayor que el Desde").
      RETURN NO-APPLY.
  END.
    IF fd = fh THEN DO:
      muestra-error("Utilize una restriccion de dia fijo").
      RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Borra_todo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Borra_todo V-table-Win
ON CHOOSE OF MENU-ITEM m_Borra_todo /* Ninguno */
DO:
  DEFINE VAR i AS INT NO-UNDO.

  DEFINE VAR hh AS HANDLE.

  DO i = 1 TO 12 :
      hh = thandle("m" , i ).
      hh:checked = FALSE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Impares
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Impares V-table-Win
ON CHOOSE OF MENU-ITEM m_Impares /* Impares */
DO:
  DEFINE VAR i AS INT NO-UNDO.

  DEFINE VAR hh AS HANDLE.

  DO i = 1 TO 12 BY 2 :
      hh = thandle("m" , i ).
      hh:checked = TRUE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Pares
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Pares V-table-Win
ON CHOOSE OF MENU-ITEM m_Pares /* Pares */
DO:
  DEFINE VAR i AS INT NO-UNDO.

  DEFINE VAR hh AS HANDLE.

  DO i = 2 TO 12 BY 2 :
      hh = thandle("m" , i ).
      hh:checked = TRUE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Todos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Todos V-table-Win
ON CHOOSE OF MENU-ITEM m_Todos /* Todos */
DO:
  DEFINE VAR i AS INT NO-UNDO.

  DEFINE VAR hh AS HANDLE.

  DO i = 1 TO 12 :
      hh = thandle("m" , i ).
      hh:checked = TRUE.
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
  {src/adm/template/row-list.i "cliente_restriccion"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "cliente_restriccion"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-disable-fields V-table-Win 
PROCEDURE local-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR i AS INT NO-UNDO.
DEF VAR hh AS HANDLE NO-UNDO.  
/* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .
  DO i = 1 TO 12:
      hh = thandle("m" , i ).
      hh:SENSITIVE = FALSE.
  END.
  DO i = 1 TO 4:
      hh = thandle("S" , i ).
      hh:SENSITIVE = FALSE.
  END.
  DO i = 1 TO 7:
      hh = thandle("T",i).
      hh:SENSITIVE = FALSE.
  END.


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
DEFINE VAR i AS int NO-UNDO.
DEFINE VAR hh AS handle NO-UNDO.
DEF VAR p0 AS CHAR NO-UNDO.
DEF VAR p1 AS CHAR NO-UNDO.
DEF VAR p2 AS CHAR NO-UNDO.

DEF VAR err AS LOGICAL NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
  
  /* Code placed here will execute AFTER standard behavior.    */
/*Reconstruir los radio-sets*/
IF AVAILABLE cliente_restriccion THEN DO:
    p0 = ENTRY(1,cliente_restriccion.valor,"|") NO-ERROR.
    err =  ERROR-STATUS:ERROR.
    p1 = ENTRY(2,cliente_restriccion.valor,"|") NO-ERROR.
    err = err OR ERROR-STATUS:ERROR.
    p2 = ENTRY(3,cliente_restriccion.valor,"|") NO-ERROR.
    err = err OR ERROR-STATUS:ERROR.


    IF err THEN 
       DO: 
           muestra-error("El valores de:" + cliente_restriccion.valor + " no es valido se ignoraran").  
           p0 = "".
           p1 = "".
           p2 = "".
       END.
       ELSE DO:
           IF p0 = "*" THEN P0 = "1.2.3.4.5.6.7.8.9.10.11.12" .
            ELSE IF p0 = "P" THEN P0 = ".2.4.6.8.10.12".
            ELSE IF p0 = "I" THEN p0 = ".1.3.5.7.9.11".
           DO i = 1 TO 12:
              hh = thandle("m",i).
              hh:CHECKED = LOOKUP(string(i),p0,".") <> 0. 
           END.
           DO i = 1 TO 4:
              hh = thandle("S",i).
              hh:CHECKED = index(p1,string(i,"9")) <> 0. 
           END.
           DO i = 1 TO 7:
              hh = thandle("T",i).
              hh:CHECKED = index(p2,string(i,"9")) <> 0. 
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
DEF VAR i AS INT NO-UNDO.
DEF VAR hh AS handle NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'enable-fields':U ) .
  DO i = 1 TO 12:
      hh = thandle("m" , i ).
      hh:SENSITIVE = TRUE.
  END.
  DO i = 1 TO 4:
      hh = thandle("S" , i ).
      hh:SENSITIVE = TRUE.
  END.
  DO i = 1 TO 7:
      hh = thandle("T",i).
      hh:SENSITIVE = TRUE.
  END.


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
  {src/adm/template/snd-list.i "cliente_restriccion"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION muestra-error V-table-Win 
FUNCTION muestra-error RETURNS CHARACTER
  ( INPUT msg AS char ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR h_cont AS HANDLE NO-UNDO.
RUN get-link-handle IN adm-broker-hdl
    ( INPUT THIS-PROCEDURE /* HANDLE */,
      INPUT 'container-source' /* CHARACTER */,
      OUTPUT h_cont /* CHARACTER */ ).
DYNAMIC-FUNCTION( 'muestra-error' IN h_cont , INPUT msg ).

  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION que_valor V-table-Win 
FUNCTION que_valor RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR sal AS CHAR NO-UNDO.
DEF VAR i AS INT NO-UNDO.
DEF VAR hh AS HANDLE NO-UNDO.

sal = "".
DO i = 1 TO 12:
          hh = thandle("m" , i ).
          IF hh:CHECKED THEN sal = sal + "." + STRING(i).
END.

IF sal = ".1.2.3.4.5.6.7.8.9.10.11.12" THEN sal = "*".
ELSE IF sal = ".2.4.6.8.10.12" THEN sal = "P".
ELSE IF sal = ".1.3.5.7.9.11" THEN sal = "I".
ELSE sal = SUBSTRING(sal,2).

sal = sal + "|".

DO i = 1 TO 4:
          hh = thandle("S" , i ).
          IF hh:CHECKED THEN sal = sal + STRING(i,"9").
END.
      sal = sal + "|".
DO i = 1 TO 7:
          hh = thandle("T",i).
          IF hh:CHECKED THEN sal = sal + STRING(i,"9").
END.


RETURN sal.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION thandle V-table-Win 
FUNCTION thandle RETURNS HANDLE
  ( p AS CHAR , i AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  retorna el handle de los toogle-box
    Notes:  
------------------------------------------------------------------------------*/

 CASE trim(p) + "-" + string(i):
    WHEN "s-1" THEN RETURN s-1:HANDLE IN FRAME {&FRAME-NAME}.
    WHEN "s-2" THEN RETURN s-2:HANDLE.
    WHEN "s-3" THEN RETURN s-3:HANDLE.
    WHEN "s-4" THEN RETURN s-4:HANDLE.
    WHEN "t-1" THEN RETURN t-1:HANDLE.
    WHEN "t-2" THEN RETURN t-2:HANDLE.
    WHEN "t-3" THEN RETURN t-3:HANDLE.
    WHEN "t-4" THEN RETURN t-4:HANDLE.
    WHEN "t-5" THEN RETURN t-5:HANDLE.
    WHEN "t-6" THEN RETURN t-6:HANDLE.
    WHEN "t-7" THEN RETURN t-7:HANDLE.
    WHEN "m-1" THEN RETURN m-1:HANDLE.
    WHEN "m-2" THEN RETURN m-2:HANDLE.
    WHEN "m-3" THEN RETURN m-3:HANDLE.
    WHEN "m-4" THEN RETURN m-4:HANDLE.
    WHEN "m-5" THEN RETURN m-5:HANDLE.
    WHEN "m-6" THEN RETURN m-6:HANDLE.    
    WHEN "m-7" THEN RETURN m-7:HANDLE.
    WHEN "m-8" THEN RETURN m-8:HANDLE.
    WHEN "m-9" THEN RETURN m-9:HANDLE.
    WHEN "m-10" THEN RETURN m-10:HANDLE.
    WHEN "m-11" THEN RETURN m-11:HANDLE.
    WHEN "m-12" THEN RETURN m-12:HANDLE.

    OTHERWISE RETURN ?.
END CASE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

