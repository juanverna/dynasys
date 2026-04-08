&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
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


DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL"
    INDEX aimp1 recurso turno.
    
DEFINE TEMP-TABLE aimp2 LIKE aimp.
    {crystal_dyna.p}

 {findempresa.i}
{impresoras.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS c_nro_tipo_evento dsc_tipo_evento tot ~
Treimprime bProceso 
&Scoped-Define DISPLAYED-OBJECTS c_nro_tipo_evento dsc_tipo_evento ~
dnro_certificado hnro_certificado tot Treimprime 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fac_bloqueo W-Win 
FUNCTION fac_bloqueo RETURNS LOGICAL ( nro AS INT , cant AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD pagado W-Win 
FUNCTION pagado RETURNS CHARACTER
  ( nro AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_v-rng-fechas AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bProceso 
     LABEL "Procesar" 
     SIZE 12 BY 1.14.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 1 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 10.2 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento".

DEFINE VARIABLE tot AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "OT" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "No Imprimir",0
     DROP-DOWN-LIST
     SIZE 23.8 BY 1 NO-UNDO.

DEFINE VARIABLE dnro_certificado AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Desde inclusive" NO-UNDO.

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 71 BY 1 NO-UNDO.

DEFINE VARIABLE hnro_certificado AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 TOOLTIP "Hasta inclusive, deje en 0 para el ultimo" NO-UNDO.

DEFINE VARIABLE Treimprime AS LOGICAL INITIAL no 
     LABEL "Reimprime" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.4 BY .81 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     c_nro_tipo_evento AT ROW 1.95 COL 7 COLON-ALIGNED WIDGET-ID 48
     dsc_tipo_evento AT ROW 1.95 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     dnro_certificado AT ROW 6.24 COL 29 COLON-ALIGNED WIDGET-ID 52
     hnro_certificado AT ROW 6.24 COL 43.8 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     tot AT ROW 6.24 COL 64 COLON-ALIGNED WIDGET-ID 70
     Treimprime AT ROW 6.33 COL 5.2 WIDGET-ID 56
     bProceso AT ROW 6.48 COL 93 WIDGET-ID 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 107.2 BY 9.14 WIDGET-ID 100.


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
         TITLE              = "Generacion de Orden de trabajo de los eventos"
         HEIGHT             = 7.14
         WIDTH              = 107.6
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 107.6
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 107.6
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

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN dnro_certificado IN FRAME F-Main
   NO-ENABLE                                                            */
ASSIGN 
       dnro_certificado:HIDDEN IN FRAME F-Main           = TRUE.

ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME F-Main        = TRUE.

/* SETTINGS FOR FILL-IN hnro_certificado IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Generacion de Orden de trabajo de los eventos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Generacion de Orden de trabajo de los eventos */
DO:
    /* Modificado para que el control retorne a la window padre al cerrar una windows hija */
    DEFINE VARIABLE h_parent AS HANDLE      NO-UNDO.
    h_parent = THIS-PROCEDURE:CURRENT-WINDOW:PARENT.
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    IF VALID-HANDLE(h_parent) THEN DO:
        CURRENT-WINDOW = h_parent.
        APPLY 'ENTRY' TO h_parent.
    END.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bProceso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bProceso W-Win
ON CHOOSE OF bProceso IN FRAME F-Main /* Procesar */
DO:
    DEFI VAR xfile AS CHAR NO-UNDO.
    DEF VAR ReportePath AS CHAR NO-UNDO.
    DEF VAR cFullPath AS CHAR NO-UNDO.
    DEF VAR XFullPath AS CHAR NO-UNDO.
    DEF VAR exportFileName AS CHAR NO-UNDO.
    DEFINE VAR p-des_fecha AS DATE.
    DEFINE VAR p-has_fecha AS DATE.
    DEFINE VAR ERROR_rango AS LOGICAL.
    DEFINE VAR filebloqueo AS CHAR NO-UNDO.
    filebloqueo = "e:\wproceso\BloqueoFactura" + 
                entry(1,replace(ISO-DATE(now),":","-"),".") + ".LOG".
    OUTPUT TO value(filebloqueo) APPEND.
    PUT "CDG;Direccion;Evento" skip.
    OUTPUT CLOSE.

    ASSIGN  c_nro_tipo_evento treimprime tot dnro_certificado hnro_certificado.
    IF tot =  0 THEN DO:
        IF ERROR_rango THEN DO:
            MESSAGE "Seleccionar impresora".
            RETURN NO-APPLY.
        END.
    END.
    RUN dar_rango IN h_v-rng-fechas ( OUTPUT p-des_fecha , OUTPUT p-has_fecha , OUTPUT  error_rango) .
    IF ERROR_rango THEN DO:
        MESSAGE "Error de fechas".
        RETURN NO-APPLY.
    END.
    ReportePath = "orden_" + string(c_nro_tipo_evento) .
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
      THEN DO:
        MESSAGE "No se encuentra el archivo de impresion " ReportePath SKIP
                "para el tipo de evento seleccionado" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-apply.
      END.

      EMPTY TEMP-TABLE aimp.
      IF NOT treimprime THEN DO:
          FOR EACH evento WHERE nro_tipo_evento = c_nro_tipo_evento AND evento.nro_certificado = 0 AND
               evento.fasignado >= p-des_fecha AND evento.fasignado <= p-has_fecha AND
               evento.fasignado<>? AND
              NOT evento.anulado AND
              NOT evento.frealizado<>?:
              FIND cliente OF evento NO-LOCK.
              FIND Cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
              IF NOT AVAILABLE cliente_otros_datos then
                 evento.leyenda = "INFORMAR UNIDADES. " + evento.leyenda .
              ELSE
                 IF cliente_otros_datos.unidades = 0 THEN
                     evento.leyenda = "INFORMAR UNIDADES. " + evento.leyenda .
              IF fac_bloqueo(evento.nro_cliente,3) THEN DO:
                  OUTPUT TO value(filebloqueo) APPEND.
                  export cliente.cdg_cliente cliente.direccion evento.nro_evento SKIP.
                  OUTPUT CLOSE.
                  NEXT.
              END.
              CREATE aimp.
              ASSIGN
                  aimp.c_nro_tipo_evento = evento.nro_tipo_evento 
                  aimp.nro_evento = evento.nro_evento.
                  aimp.recurso = evento.recurso.
                  aimp.turno = evento.turno.
          END.
      END.
      ELSE DO:
          FOR EACH evento WHERE 
               evento.letraprefijo = letraprefijo AND 
                evento.nro_certificado >= dnro_certificado AND 
               ( evento.nro_certificado <= hnro_certificado OR hnro_certificado = 0 ):
              FIND cliente OF evento NO-LOCK.
              FIND Cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
              IF NOT AVAILABLE cliente_otros_datos then
                 evento.leyenda = "INFORMAR UNIDADES. " + evento.leyenda .
              ELSE
                 IF cliente_otros_datos.unidades = 0 THEN
                     evento.leyenda = "INFORMAR UNIDADES. " + evento.leyenda .
              IF fac_bloqueo(evento.nro_cliente,3) THEN DO:
                  OUTPUT TO value(filebloqueo) APPEND.
                  export cliente.cdg_cliente cliente.direccion evento.nro_evento SKIP.
                  OUTPUT CLOSE.
              END.
              CREATE aimp.
              ASSIGN
                  aimp.c_nro_tipo_evento = evento.nro_tipo_evento 
                  aimp.nro_evento = evento.nro_evento.
                  aimp.recurso = evento.recurso.
                  aimp.turno = evento.turno.
          END.
      END.

      FOR EACH aimp:
          EMPTY TEMP-TABLE aimp2.
          CREATE aimp2.
          BUFFER-COPY aimp TO aimp2.
          RUN printorden.p ( INPUT TABLE aimp2, OUTPUT xfile, ? ). 
          CREATE "CrystalRuntime.Application" chApplication.
          chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
          chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
          RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
          chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
          RUN crearReporte(chReport,"rpt",/*ViewReport*/ FALSE, impreport(tot),
                             /*exportToDisk*/ FALSE, INPUT-OUTPUT exportFileName ).        
          RELEASE OBJECT chReport. 
          chReport = ?.
          RELEASE OBJECT chApplication.
      END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME c_nro_tipo_evento
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c_nro_tipo_evento W-Win
ON VALUE-CHANGED OF c_nro_tipo_evento IN FRAME F-Main /* Tipo */
DO:
  FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento:INPUT-VALUE NO-ERROR.
  IF AVAILABLE tipo_evento THEN 
       dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
  ELSE
      dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}="ERROR".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Treimprime
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Treimprime W-Win
ON VALUE-CHANGED OF Treimprime IN FRAME F-Main /* Reimprime */
DO:
  ASSIGN treimprime.
         dnro_certificado:SENSITIVE = treimprime:CHECKED.
         hnro_certificado:SENSITIVE = treimprime:CHECKED.
         dnro_certificado:VISIBLE = treimprime:CHECKED.
         hnro_certificado:VISIBLE = treimprime:CHECKED.
         c_nro_tipo_evento:SENSITIVE = NOT treimprime:CHECKED.
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
  DEFINE VARIABLE adm-current-page  AS INTEGER NO-UNDO.

  RUN get-attribute IN THIS-PROCEDURE ('Current-Page':U).
  ASSIGN adm-current-page = INTEGER(RETURN-VALUE).

  CASE adm-current-page: 

    WHEN 0 THEN DO:
       RUN init-object IN THIS-PROCEDURE (
             INPUT  'v-rng-fechas.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-rng-fechas ).
       RUN set-position IN h_v-rng-fechas ( 3.38 , 5.00 ) NO-ERROR.
       /* Size in UIB:  ( 2.43 , 100.00 ) */

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-rng-fechas ,
             dsc_tipo_evento:HANDLE IN FRAME F-Main , 'AFTER':U ).
    END. /* Page 0 */

  END CASE.

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
  DISPLAY c_nro_tipo_evento dsc_tipo_evento dnro_certificado hnro_certificado 
          tot Treimprime 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE c_nro_tipo_evento dsc_tipo_evento tot Treimprime bProceso 
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
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEF VAR lista AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */
DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento &CONDICION=tipo_evento.ot }
     c_nro_tipo_evento = int(entry(2,c_nro_tipo_evento:LIST-ITEM-PAIRS,"|")).
  END.
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


  
  tot:LIST-ITEM-PAIRS =  tot:LIST-ITEM-PAIRS + "," + imprelista().
  FIND FIRST tipo_evento WHERE tipo_evento.nro_tipo_evento = c_nro_tipo_evento NO-ERRor.
  IF AVAILABLE tipo_evento THEN DO:
       dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME} = tipo_evento.descripcion.
  END.
  ELSE
      dsc_tipo_evento:SCREEN-VALUE IN FRAME {&FRAME-NAME}="ERROR".
  dnro_certificado:VISIBLE = FALSE.
  hnro_certificado:VISIBLE = FALSE.
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

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fac_bloqueo W-Win 
FUNCTION fac_bloqueo RETURNS LOGICAL ( nro AS INT , cant AS INT ) :
    DEFINE BUFFER fac FOR fac_header.
    DEFINE VAR ii AS INT64 NO-UNDO.
    DEFINE VAR dfecha AS DATE.
    DEFINE VAR hfecha AS DATE.
    hfecha = TODAY - 45.
    dfecha = 01/01/2016.

    FOR EACH fac WHERE fac.nro_cliente = nro AND fac.fecha > dfecha AND fac.fecha < hfecha AND NOT fac.anulado BY fac.fecha DESC:
        IF pagado(fac.nro_factura) <> "S" THEN
            ii = ii  + 1.
        IF ii >= cant THEN RETURN TRUE.
    END.
    RETURN FALSE.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION pagado W-Win 
FUNCTION pagado RETURNS CHARACTER
  ( nro AS INT ) :
    DEF VAR PAGA AS CHAR NO-UNDO.
    DEFINE BUFFER fac FOR fac_header.
      FIND fac WHERE fac.nro_factura = nro NO-LOCK NO-ERROR.
      IF NOT AVAILABLE fac THEN RETURN ?.
      FIND cta_cte WHERE
      cta_cte.cdg_empresa = fac.cdg_empresa AND
      cta_cte.tip_comprob = fac.tip_comprob AND
      cta_cte.prf_comprob = fac.prf_comprob AND
      cta_cte.nro_comprob = fac.nro_comprob NO-LOCK NO-ERROR.
   
IF AVAILABLE cta_cte THEN DO:
      IF cta_cte.credito = 0 AND cta_cte.debito = 0 THEN paga = "S".
      ELSE DO:
          IF cta_cte.credito = 0 OR cta_cte.debito = 0 
              THEN paga = "N".
              ELSE IF cta_cte.credito = cta_cte.debito 
                  THEN paga = "S".
                  ELSE paga = "P".
      END.
  END.
  ELSE paga = "?".
     
RETURN paga.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

