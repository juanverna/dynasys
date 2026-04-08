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



DEFINE TEMP-TABLE oblea
    FIELD url2 LIKE evento.url2
    FIELD frealizado LIKE evento.frealizado
    FIELD fvencimiento LIKE evento.frealizado
    FIELD nro_certif LIKE evento.nro_certif
    FIELD imagen AS char.


{findempresa.i}
{tt2xls.i}
{stavisado.i}
{windows.i}
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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bProceso 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bProceso 
     LABEL "Procesar" 
     SIZE 15 BY 1.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     bProceso AT ROW 7.91 COL 48 WIDGET-ID 2
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
         TITLE              = "Generacion de Avisos"
         HEIGHT             = 9.24
         WIDTH              = 108.2
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 108.8
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 108.8
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Generacion de Avisos */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Generacion de Avisos */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bProceso
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bProceso W-Win
ON CHOOSE OF bProceso IN FRAME F-Main /* Procesar */
DO:
          CREATE aimp.
          ASSIGN aimp.c_nro_tipo_evento = bevento.nro_tipo_evento
                 aimp.aviso_fasignado = evento.fasignado 
                 aimp.aviso_evento = evento.nro_evento 
                 aimp.aviso_recurso = evento.recurso
                 aimp.turno = evento.turno
                 aimp.nro_evento = evento.refevento.
    END.

    /*imprimir avisos cuya fmax expira.*/
    IF ccondicion = "1" THEN DO:
        FOR EACH evento NO-LOCK WHERE 
               NOT evento.anulado AND
               evento.nro_tipo_evento = tipo_evento.nro_tipo_evento AND
               evento.fasignado = ? AND
               evento.fmax = p-has_fecha AND NOT impreso:
    
              FIND bevento WHERE bevento.nro_evento = evento.refevento NO-LOCK NO-ERROR.
              IF NOT AVAILABLE bevento THEN DO:
                      MESSAGE "Verificar error en evento " evento.nro_evento SKIP
                              "que referencia al inexistente " evento.refevento VIEW-AS ALERT-BOX ERROR.
                      NEXT.
              END.
        
              MESSAGE "Tiene avisos vencidos sin asignar" SKIP
                      "RESUELVA ESTE PROBLEMA INMEDIATAMENTE" SKIP
                      "se continua la impresion de lo solicitado"
              VIEW-AS ALERT-BOX ERROR.
        END.
    END.

    EMPTY TEMP-TABLE aimp3.

    FOR EACH aimp:
        CREATE aimp3.
        FIND evento OF aimp NO-LOCK.
        FIND cliente OF evento NO-ERROR.
        IF NOT AVAILABLE cliente THEN DO:
            MESSAGE "No se encuentra el cliente para el evento " evento.nro_evento SKIP
                    "no se imprimira el aviso"
            VIEW-AS ALERT-BOX ERROR.
            DELETE aimp.
            NEXT.
        END.
        BUFFER-COPY aimp TO aimp3.
        ASSIGN aimp3.direccion = cliente.direccion.
    END.
          /*deneracion de excel de control de avisos*/
    RUN pTT2XLS                                                                  
              ( INPUT TEMP-TABLE aimp3:DEFAULT-BUFFER-HANDLE,                           
                INPUT 'c:\temp\'+ userid("SIC") + 'control-avisos'  + '.xls',                                    
                INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ). 
    RUN abrir( "OPEN" , 'c:\temp\'+ userid("SIC") + 'control-avisos' + '.xls' ).

    EMPTY TEMP-TABLE aimp2.
        
    FOR EACH aimp BREAK BY aimp.c_nro_tipo_evento BY aimp.aviso_fasignado BY aimp.aviso_recurso:
          CREATE aimp2.
          BUFFER-COPY aimp TO aimp2.
          IF LAST-OF( aimp.c_nro_tipo_evento ) THEN DO:
              RUN printavisos2.p ( INPUT TABLE aimp2, ? ). 
              EMPTY TEMP-TABLE aimp2.
          END.
    END.
    FOR EACH aimp:
       FIND evento WHERE evento.nro_evento = aimp.aviso_evento EXCLUSIVE-LOCK.
                evento.impreso = TRUE.
                evento.observacion = agregaAdvTexto("Imprimio Aviso",evento.observacion).
    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir W-Win 
PROCEDURE abrir :
DEFINE INPUT PARAMETER modo AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER archfile AS CHAR NO-UNDO.
    DEFINE VARIABLE hInstance AS INTEGER.
    DEFINE VAR tempfile AS CHAR NO-UNDO.
    DEF VAR pud AS LOGICAL NO-UNDO.
    DEFINE VARIABLE lpVerb AS MEMPTR.
    DEFINE VARIABLE lpFile AS MEMPTR.
    DEFINE VARIABLE lpExecInfo AS MEMPTR.
    DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.

SET-SIZE(lpVerb)         = LENGTH(modo) + 1.
PUT-STRING(lpVerb,1)     = modo.

SET-SIZE(lpFile)         = LENGTH (archfile) + 1.
PUT-STRING(lpFile,1)     = archfile.

SET-SIZE (lpExecInfo)    = 60.
PUT-LONG (lpExecInfo, 1) = GET-SIZE(lpExecInfo).
PUT-LONG (lpExecInfo, 5) = 256. /* = SEE_MASK_FLAG_DDEWAIT */
PUT-LONG (lpExecInfo, 9) = 0.   /* hwnd                    */
PUT-LONG (lpExecInfo,13) = GET-POINTER-VALUE(lpVerb).
PUT-LONG (lpExecInfo,17) = GET-POINTER-VALUE(lpFile).
PUT-LONG (lpExecInfo,21) = 0.   /* commandline             */
PUT-LONG (lpExecInfo,25) = 0.   /* current directory       */
PUT-LONG (lpExecInfo,29) = 2.   /* wCmdShow                */

RUN ShellExecuteExA IN hpApi(GET-POINTER-VALUE(lpExecInfo),
                             OUTPUT ReturnValue).

SET-SIZE (lpExecInfo)    = 0.
SET-SIZE (lpFile)        = 0.
SET-SIZE (lpverb)        = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  ENABLE bProceso 
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

