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
&Scoped-define EXTERNAL-TABLES cliente_Restriccion
&Scoped-define FIRST-EXTERNAL-TABLE cliente_Restriccion


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR cliente_Restriccion.
/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS cliente_restriccion.Valor 
&Scoped-define ENABLED-TABLES cliente_restriccion
&Scoped-define FIRST-ENABLED-TABLE cliente_restriccion
&Scoped-Define ENABLED-OBJECTS f01 f07 f02 f08 b_ayuda f03 f09 f04 f10 f05 ~
f11 f06 f12 
&Scoped-Define DISPLAYED-OBJECTS f01 f07 f02 f08 f03 f09 f04 f10 f05 f11 ~
f06 f12 

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


/* ***********************  Control Definitions  ********************** */


/* Definitions of the field level widgets                               */
DEFINE BUTTON b_ayuda 
     LABEL "Ayuda" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE f01 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Enero" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE f02 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Febrero" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE f03 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Marzo" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE f04 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Abril" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE f05 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Mayo" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE f06 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Junio" 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE f07 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Julio" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.

DEFINE VARIABLE f08 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Agosto" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.

DEFINE VARIABLE f09 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Setiembre" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.

DEFINE VARIABLE f10 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Octubre" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.

DEFINE VARIABLE f11 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Noviembre" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.

DEFINE VARIABLE f12 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     LABEL "Diciembre" 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     f01 AT ROW 1 COL 10 COLON-ALIGNED WIDGET-ID 6
     f07 AT ROW 1 COL 33 COLON-ALIGNED WIDGET-ID 18
     cliente_restriccion.Valor AT ROW 1.24 COL 68 NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 4 BY .29 NO-TAB-STOP 
     f02 AT ROW 2.24 COL 10 COLON-ALIGNED WIDGET-ID 8
     f08 AT ROW 2.24 COL 33 COLON-ALIGNED WIDGET-ID 20
     b_ayuda AT ROW 2.91 COL 51 WIDGET-ID 2
     f03 AT ROW 3.48 COL 10 COLON-ALIGNED WIDGET-ID 10
     f09 AT ROW 3.48 COL 33 COLON-ALIGNED WIDGET-ID 22
     f04 AT ROW 4.71 COL 10 COLON-ALIGNED WIDGET-ID 12
     f10 AT ROW 4.71 COL 33 COLON-ALIGNED WIDGET-ID 24
     f05 AT ROW 5.95 COL 10 COLON-ALIGNED WIDGET-ID 14
     f11 AT ROW 5.95 COL 33 COLON-ALIGNED WIDGET-ID 26
     f06 AT ROW 7.19 COL 10 COLON-ALIGNED WIDGET-ID 16
     f12 AT ROW 7.19 COL 33 COLON-ALIGNED WIDGET-ID 28
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartViewer
   External Tables: sic.cliente_Restriccion
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

/* SETTINGS FOR FILL-IN cliente_restriccion.Valor IN FRAME F-Main
   NO-DISPLAY ALIGN-L                                                   */
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

&Scoped-define SELF-NAME b_ayuda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL b_ayuda V-table-Win
ON CHOOSE OF b_ayuda IN FRAME F-Main /* Ayuda */
DO:
  MESSAGE "Establece un cronograma" skip
          "Se puede poner un rango desde,hasta en cada posicion"
           VIEW-AS ALERT-BOX INFORMATION.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f01 V-table-Win
ON LEAVE OF f01 IN FRAME F-Main /* Enero */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f02 V-table-Win
ON LEAVE OF f02 IN FRAME F-Main /* Febrero */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f03
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f03 V-table-Win
ON LEAVE OF f03 IN FRAME F-Main /* Marzo */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f04
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f04 V-table-Win
ON LEAVE OF f04 IN FRAME F-Main /* Abril */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f05
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f05 V-table-Win
ON LEAVE OF f05 IN FRAME F-Main /* Mayo */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f06
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f06 V-table-Win
ON LEAVE OF f06 IN FRAME F-Main /* Junio */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f07
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f07 V-table-Win
ON LEAVE OF f07 IN FRAME F-Main /* Julio */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f08
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f08 V-table-Win
ON LEAVE OF f08 IN FRAME F-Main /* Agosto */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f09
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f09 V-table-Win
ON LEAVE OF f09 IN FRAME F-Main /* Setiembre */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f10 V-table-Win
ON LEAVE OF f10 IN FRAME F-Main /* Octubre */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f11 V-table-Win
ON LEAVE OF f11 IN FRAME F-Main /* Noviembre */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME f12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL f12 V-table-Win
ON LEAVE OF f12 IN FRAME F-Main /* Diciembre */
DO:
DEFINE VAR r AS INT.
DEFINE VAR t AS CHAR.
DEFINE VAR ult AS INT EXTENT 12 INITIAL [31,29,31,30,31,30,31,31,30,31,30,31].
IF {&SELF-NAME}:INPUT-VALUE = "" THEN RETURN.
t = {&SELF-NAME}:INPUT-VALUE.
DO r = 1 TO LENGTH(t):
    IF INDEX('0123456789,',SUBSTRING( t , r , 1 ) ) = 0 THEN DO:
        MESSAGE "Caracter ingresado invalido solo se acepta '01234567,'" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
END.
IF NUM-ENTRIES(t,",") > 2 THEN DO:
    MESSAGE "Solo se acepta un rango de numeros, desde,hasta" VIEW-AS ALERT-BOX ERROR.
    RETURN NO-APPLY.
END.
DO r = 1 TO NUM-ENTRIES(t,","):
    IF int( ENTRY(r,t,",") ) > ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) )] THEN DO:
        MESSAGE "Este mes tiene un maximo de " ult[int( SUBSTRING( {&SELF-NAME}:NAME , 2 ) ) ] VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
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
  {src/adm/template/row-list.i "cliente_Restriccion"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "cliente_Restriccion"}

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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'disable-fields':U ) .
f01:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f02:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f03:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f04:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f05:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f06:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f07:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f08:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f09:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f10:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f11:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.
f12:SENSITIVE IN FRAME {&FRAME-NAME} = FALSE.

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
DEF VAR legajo AS INT NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields':U ) .
  
  /* Code placed here will execute AFTER standard behavior.    */
/*Reconstruir los radio-sets*/

IF AVAILABLE cliente_restriccion  THEN DO:
    f01:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 1 THEN entry(1,cliente_restriccion.valor,"|") ELSE "".
    f02:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 2 THEN entry(2,cliente_restriccion.valor,"|") ELSE "".
    f03:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 3 THEN entry(3,cliente_restriccion.valor,"|") ELSE "".
    f04:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 4 THEN entry(4,cliente_restriccion.valor,"|") ELSE "".
    f05:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 5 THEN entry(5,cliente_restriccion.valor,"|") ELSE "".
    f06:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 6 THEN entry(6,cliente_restriccion.valor,"|") ELSE "".
    f07:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 7 THEN entry(7,cliente_restriccion.valor,"|") ELSE "".
    f08:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 8 THEN entry(8,cliente_restriccion.valor,"|") ELSE "".
    f09:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 9 THEN entry(9,cliente_restriccion.valor,"|") ELSE "".
    f10:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 10 THEN entry(10,cliente_restriccion.valor,"|") ELSE "".
    f11:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 11 THEN entry(11,cliente_restriccion.valor,"|") ELSE "".
    f12:SCREEN-VALUE IN FRAME {&FRAME-NAME} = IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 12 THEN entry(12,cliente_restriccion.valor,"|") ELSE "".
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
f01:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f02:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f03:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f04:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f05:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f06:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f07:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f08:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f09:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f10:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f11:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
f12:SENSITIVE IN FRAME {&FRAME-NAME} = TRUE.
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
  {src/adm/template/snd-list.i "cliente_Restriccion"}

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
DO WITH FRAME {&FRAME-NAME}:
  RETURN    f01:SCREEN-VALUE + "|" + 
            f02:SCREEN-VALUE + "|" +
            f03:SCREEN-VALUE + "|" +
            f04:SCREEN-VALUE + "|" +
            f05:SCREEN-VALUE + "|" +
            f06:SCREEN-VALUE + "|" +
            f07:SCREEN-VALUE + "|" +
            f08:SCREEN-VALUE + "|" +
            f09:SCREEN-VALUE + "|" +
            f10:SCREEN-VALUE + "|" +
            f11:SCREEN-VALUE + "|" +
            f12:SCREEN-VALUE.
END.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

