&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
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

{nrorelea.i}

DEFINE VARIABLE txn_activa AS LOGICAL.
DEFINE TEMP-TABLE tt
FIELD orden AS INT
FIELD tipo AS CHAR INITIAL "L"
FIELD bloque AS CHAR 
FIELD c6 AS CHAR LABEL "IDENT."
FIELDS c1 AS CHAR FORMAT "X(6)" LABEL "HORA"
FIELD c2 AS CHAR FORMAT "X(50)" LABEL "DIRECCION"
FIELD c3  AS CHAR FORMAT "X(10)" LABEL "OPER"
FIELD c4  AS CHAR FORMAT "X(4)" LABEL "TIP"
FIELD c5  AS CHAR FORMAT "X(200)" LABEL "OBSERVACION" 
INDEX dfl orden.
{extrae.i}
{tt2xls.i}
{advtexto.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-9

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt

/* Definitions for BROWSE BROWSE-9                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 c6 c1 c2 c3 c4 c5 c6   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9   
&Scoped-define SELF-NAME BROWSE-9
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH tt
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY {&SELF-NAME} FOR EACH tt.
&Scoped-define TABLES-IN-QUERY-BROWSE-9 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 tt


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-9}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn-excel fdate BROWSE-9 
&Scoped-Define DISPLAYED-OBJECTS fdate 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn-excel 
     IMAGE-UP FILE "excel.gif":U NO-FOCUS
     LABEL "&Modifica" 
     SIZE 9 BY 1.05 TOOLTIP "Modifica el registro actual"
     FONT 4.

DEFINE VARIABLE fdate AS DATE FORMAT "99/99/9999":U 
     LABEL "Fecha" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-9 FOR 
      tt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 W-Win _FREEFORM
  QUERY BROWSE-9 DISPLAY
      c6
      c1
c2
c3
c4
c5
c6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 186 BY 19.76 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Btn-excel AT ROW 1.24 COL 32.8 WIDGET-ID 4
     fdate AT ROW 1.24 COL 9 COLON-ALIGNED WIDGET-ID 2
     BROWSE-9 AT ROW 2.67 COL 3 WIDGET-ID 100
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 189.6 BY 21.76.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Modelo"
         HEIGHT             = 21.76
         WIDTH              = 189.6
         MAX-HEIGHT         = 26.62
         MAX-WIDTH          = 189.6
         VIRTUAL-HEIGHT     = 26.62
         VIRTUAL-WIDTH      = 189.6
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{excel-export.i}
{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* BROWSE-TAB BROWSE-9 fdate F-Main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-9
/* Query rebuild information for BROWSE BROWSE-9
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-9 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Modelo */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Modelo */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
  DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.


  RUN verificar_txn ( OUTPUT txn_activa ).
  IF NOT txn_activa
  THEN DO: 
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
  END.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-MINIMIZED OF W-Win /* Modelo */
DO:
  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No debe minimizar esta ventana con una actualización pendiente"
               VIEW-AS ALERT-BOX WARNING TITLE "CUIDADO!!!".
{&WINDOW-NAME}:WINDOW-STATE = 1.
RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-9
&Scoped-define SELF-NAME BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-9 W-Win
ON ROW-DISPLAY OF BROWSE-9 IN FRAME F-Main
DO:
  IF tt.tipo = "T" THEN
   c2:BGCOLOR IN BROWSE {&browse-NAME}= 14.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn-excel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn-excel W-Win
ON CHOOSE OF Btn-excel IN FRAME F-Main /* Modifica */
DO:
   run excel-export2 ( {&BROWSE-NAME}:HANDLE IN FRAME {&FRAME-NAME} , INPUT 'FitToPagesTall=1|PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1'  ).
  /* RUN pTT2XLS                                                               
  ( INPUT TEMP-TABLE tt:DEFAULT-BUFFER-HANDLE,                       
    INPUT 'c:\temp\a.xls',                                                
    INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ).  */
 END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdate W-Win
ON LEAVE OF fdate IN FRAME F-Main /* Fecha */
DO:
  RUN carga.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fdate W-Win
ON MOUSE-MENU-CLICK OF fdate IN FRAME F-Main /* Fecha */
DO:
    {selfecha.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE carga W-Win 
PROCEDURE carga :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EMPTY TEMP-TABLE tt.
DEFINE VAR i AS INT NO-UNDO.
DEFINE VAR cc AS INT NO-UNDO.
ASSIGN FRAME {&FRAME-NAME} fdate.
EMPTY TEMP-TABLE tt.
DEFINE VAR ultrecurso AS CHAR NO-UNDO.
DEFINE VAR dd AS CHAR NO-UNDO.
cc = 0.
/*tareas*/
CREATE tt.
                ASSIGN tt.tipo = "T"
                       tt.bloque = ""
                       tt.c2 = "Fecha: " +  string(fdate,"99/99/9999")
                       tt.c4 = ""
                       cc = cc + 1
                       tt.c5 = "Procesada:" + string( now ,"99/99/99 HH:MM:SS") + " " + USERID("SIC")
                       tt.orden = cc.
FOR EACH tarea WHERE tarea.fecha_prevista = fdate OR tarea.fecha_prevista = ? AND estado = "A" AND date(sic.Tarea.Visualizar) <= fdate NO-LOCK BY tarea.cdg_tipotarea BY tarea.hora_prevista:
       IF NOT tarea.INFORMA THEN DO:
           FIND tipo_tarea OF tarea WHERE tipo_tarea.INFORMA NO-LOCK NO-ERROR.
           IF NOT AVAILABLE tipo_tarea THEN NEXT.
       END.
       IF tarea.cdg_tipotarea = "P" AND tarea.accion <> "1" THEN NEXT.
       IF tarea.cdg_tipotarea = "Q" AND tarea.accion <> "1" THEN NEXT.

       FIND tt WHERE tt.tipo = "T" AND tt.bloque = tarea.cdg_tipotarea AND tt.c4 = tarea.cdg_tipotarea NO-LOCK NO-ERROR.
       IF NOT AVAILABLE tt THEN DO:
                CREATE tt.
                ASSIGN tt.tipo = "S"
                       tt.bloque = tarea.cdg_tipotarea
                       tt.c2 = ""
                   cc = cc + 1
                   tt.orden = cc.
                CREATE tt.
                ASSIGN tt.tipo = "T"
                       tt.bloque = tarea.cdg_tipotarea
                       tt.c2 = "Tarea " + Tipo_tarea.dsc_tipotarea
                       tt.c4 = tarea.cdg_tipotarea
                       cc = cc + 1
                       tt.orden = cc.
       END.

 
    FIND recurso WHERE recurso.cdg_recurso = extrae("Frecursos",tarea.datos-template) NO-LOCK NO-ERROR.
    IF AVAILABLE recurso THEN 
        IF NOT recurso.INFORMA AND NOT tarea.INFORMA THEN NEXT.
    dd = "".
    RUN loadAdvTTtexto(tarea.descripcion,OUTPUT TABLE tttexto).
    FOR EACH tttexto:
      IF tttexto.ttexto = "Visitar" THEN NEXT.
      dd = dd + "|" + tttexto.ttexto.
    END.
    
    CREATE tt.
    ASSIGN tipo = ""
           tt.bloque = "D"
           tt.c2 = tarea.direccion
           tt.c1 = tarea.hora_prevista
           tt.c5 = substring(dd,2)
           cc = cc + 1
           tt.orden = cc
           tt.c6 = string(tarea.nro_tarea).
           tt.c3 = extrae("Frecursos",tarea.datos-template).
           ultrecurso = tt.c3.

END.
/*eventos*/
/*un solo titulo ya que va por operario*/
CREATE tt.
            ASSIGN tt.tipo = "S"
                   tt.bloque = "T"
                   tt.c2 = ""
               cc = cc + 1
               tt.orden = cc.
CREATE tt.
                ASSIGN tt.tipo = "T"
                       tt.bloque = ""
                       tt.c2 = "Eventos "
                       tt.c4 = ""
                       cc = cc + 1
                       tt.orden = cc.

ultrecurso = "".
FOR EACH evento  WHERE evento.fasignado = fdate AND NOT evento.anulado ,  
                           cliente OF evento NO-LOCK BREAK BY evento.recurso BY evento.nro_tipo_evento:
       IF NOT evento.INFORMA THEN DO:
           FIND tipo_evento OF evento WHERE tipo_evento.INFORMA NO-LOCK NO-ERROR.
           IF NOT AVAILABLE tipo_evento THEN NEXT.
       END.
       FIND tipo_evento OF evento NO-LOCK NO-ERROR.
       DO i = 1 TO NUM-ENTRIES(evento.recursos):
          FIND recurso WHERE recurso.cdg_recurso = ENTRY(i,evento.recursos) NO-LOCK NO-ERROR.
          IF NOT AVAILABLE recurso THEN NEXT.
          IF recurso.INFORMA THEN LEAVE.
       END.
       IF AVAILABLE recurso THEN
            IF NOT recurso.INFORMA AND NOT evento.INFORMA THEN NEXT.
       IF FIRST-OF(evento.recurso) AND ultrecurso <> entry(1,evento.recurso ) AND ultrecurso <> "" THEN DO:
            CREATE tt.
            ASSIGN tt.tipo = "S"
                   tt.bloque = "T"
                   tt.c2 = ""
               cc = cc + 1
               tt.orden = cc.
               
           END.
       ultrecurso = entry(1,evento.recurso ).
/*       FIND tt WHERE tt.tipo = "T" AND tt.bloque = tipo_evento.cdg_tipo_evento AND tt.c4 = tipo_evento.cdg_tipo_evento NO-LOCK NO-ERROR.
       IF NOT AVAILABLE tt THEN DO:
                CREATE tt.
                ASSIGN tt.tipo = "S"
                       tt.bloque = tipo_evento.cdg_tipo_evento
                       tt.c2 = ""
                   cc = cc + 1
                   tt.orden = cc.
                CREATE tt.
                ASSIGN tt.tipo = "T"
                       tt.bloque = tipo_evento.cdg_tipo_evento
                       tt.c2 = "Eventos " + tipo_evento.descripcion
                       tt.c4 = tipo_evento.cdg_tipo_evento
                       cc = cc + 1
                       tt.orden = cc.
       END.                          */
           
       CREATE tt.
       ASSIGN  tt.tipo = ""
               tt.bloque = tipo_evento.cdg_tipo_evento
               tt.c2 = cliente.direccion
               tt.c4 = tipo_evento.cdg_tipo_evento
               tt.c3 = evento.recurso
               tt.c5 = evento.leyenda
               tt.c6 = string(evento.nro_evento)
               cc = cc + 1
               tt.orden = cc.
END.

{&OPEN-QUERY-{&BROWSE-NAME}}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fdate 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Btn-excel fdate BROWSE-9 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/

  RUN verificar_txn ( OUTPUT txn_activa ).
  IF txn_activa
  THEN DO:
       RETURN NO-APPLY.
  END.     
  ELSE DO:
       APPLY "CLOSE":U TO THIS-PROCEDURE.
       RETURN.
  END.     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
fdate = TODAY + 1.
DISPLAY fdate WITH  FRAME {&FRAME-NAME}.
RUN carga.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-view W-Win 
PROCEDURE local-view :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'view':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

  {setwintit.i "SIC/OPR" "Resumen Agenda Diaria por Operario"}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "tt"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.
/*
    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.

    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).

    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

/*
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN WIDGET-HANDLE(page-hdl) (j-pagina).
          ELSE RUN disable-folder-page IN WIDGET-HANDLE(page-hdl) (j-pagina).
*/
       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE verificar_txn W-Win 
PROCEDURE verificar_txn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER p-estado AS LOGICAL.

  RUN get-attribute ('ADM-TRANSACTION').
  IF RETURN-VALUE = "YES"
  THEN DO:
       MESSAGE "No puede salir de esta pantalla con una actualización pendiente"
               VIEW-AS ALERT-BOX ERROR.
       p-estado = YES.
  END.
  ELSE DO:
       p-estado = NO.   /* Function return value. */
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

