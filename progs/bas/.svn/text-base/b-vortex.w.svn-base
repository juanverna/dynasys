&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
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

DEFINE BUFFER BVortex FOR vortex.
DEFINE VAR  p-carpeta LIKE vortex.carpeta NO-UNDO.
DEFINE VAR  p-indice LIKE vortex.indice NO-UNDO.
{windows.i}
DEFINE VAR hcproc AS CHARACTER.
DEFINE VAR hproc AS HANDLE.
DEFINE TEMP-TABLE tt NO-UNDO LIKE vortex .

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
&Scoped-define INTERNAL-TABLES vortex

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table vortex.Carpeta vortex.Nombre ~
vortex.Tipo vortex.Version vortex.Protegido vortex.Tamanio vortex.FModif ~
vortex.FAccedido 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH vortex WHERE ~{&KEY-PHRASE} ~
      AND vortex.Carpeta = p-carpeta ~
 AND vortex.Indice = p-indice  ~
 and can-do( vortex.Plectura , userid("sic") ) NO-LOCK ~
    ~{&SORTBY-PHRASE}
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH vortex WHERE ~{&KEY-PHRASE} ~
      AND vortex.Carpeta = p-carpeta ~
 AND vortex.Indice = p-indice  ~
 and can-do( vortex.Plectura , userid("sic") ) NO-LOCK ~
    ~{&SORTBY-PHRASE}.
&Scoped-define TABLES-IN-QUERY-br_table vortex
&Scoped-define FIRST-TABLE-IN-QUERY-br_table vortex


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-br_table}

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
</FOREIGN-KEYS
><EXECUTING-CODE>
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


/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-br_table 
       MENU-ITEM m_Caracteristicas LABEL "Caracteristicas"
       MENU-ITEM m_Abrir        LABEL "Abrir"         
       MENU-ITEM m_Imprimir     LABEL "Imprimir"      
       MENU-ITEM m_Editar       LABEL "Editar"        
       MENU-ITEM m_Recarga      LABEL "Recarga"       .


/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      vortex SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      vortex.Carpeta FORMAT "x(30)":U
      vortex.Nombre FORMAT "x(200)":U WIDTH 33.2
      vortex.Tipo FORMAT "x(8)":U
      vortex.Version FORMAT ">>9":U
      vortex.Protegido FORMAT "S/N":U
      vortex.Tamanio FORMAT ">,>>>,>>9":U
      vortex.FModif FORMAT "99/99/99 HH:MM:SS":U
      vortex.FAccedido FORMAT "99/99/99 HH:MM:SS":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 136 BY 6.71 ROW-HEIGHT-CHARS .57 TOOLTIP "Seleccione un archivo o boton secundario para mas opciones".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     br_table AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE  WIDGET-ID 100.


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
         HEIGHT             = 6.91
         WIDTH              = 137.4.
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
/* BROWSE-TAB br_table 1 F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

ASSIGN 
       br_table:POPUP-MENU IN FRAME F-Main             = MENU POPUP-MENU-br_table:HANDLE
       br_table:COLUMN-RESIZABLE IN FRAME F-Main       = TRUE
       br_table:COLUMN-MOVABLE IN FRAME F-Main         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.vortex"
     _Options          = "NO-LOCK KEY-PHRASE SORTBY-PHRASE"
     _Where[1]         = "sic.vortex.Carpeta = p-carpeta
 AND sic.vortex.Indice = p-indice 
 and can-do( sic.vortex.Plectura , userid(""sic"") )"
     _FldNameList[1]   = sic.vortex.Carpeta
     _FldNameList[2]   > sic.vortex.Nombre
"vortex.Nombre" ? "x(200)" "character" ? ? ? ? ? ? no ? no no "33.2" yes no no "U" "" ""
     _FldNameList[3]   = sic.vortex.Tipo
     _FldNameList[4]   = sic.vortex.Version
     _FldNameList[5]   = sic.vortex.Protegido
     _FldNameList[6]   = sic.vortex.Tamanio
     _FldNameList[7]   > sic.vortex.FModif
"vortex.FModif" ? "99/99/99 HH:MM:SS" "datetime" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic.vortex.FAccedido
"vortex.FAccedido" ? "99/99/99 HH:MM:SS" "datetime" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
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

&Scoped-define BROWSE-NAME br_table
&Scoped-define SELF-NAME br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON DELETE-CHARACTER OF br_table IN FRAME F-Main
DO:
    DEF VAR pud AS LOGICAL NO-UNDO.
    MESSAGE "Quiere borrar el registro" SKIP SKIP
        "Falta ver los permisos"
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE pud.
    IF pud THEN do: 
        FIND CURRENT vortex EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE vortex THEN DO:
           DELETE vortex.
             {&OPEN-QUERY-{&BROWSE-NAME}}
        END.
           ELSE 
               MESSAGE "No se puede dar de baja el registro"
                   VIEW-AS ALERT-BOX INFO BUTTONS OK.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
DO:
    RUN abrir("OPEN").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-ENTRY OF br_table IN FRAME F-Main
DO:
  /* This code displays initial values for newly added or copied rows. */
  {src/adm/template/brsentry.i}  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-LEAVE OF br_table IN FRAME F-Main
DO:
    /* Do not disable this code or no updates will take place except
     by pressing the Save button on an Update SmartPanel. */
   {src/adm/template/brsleave.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON VALUE-CHANGED OF br_table IN FRAME F-Main
DO:
  /* This ADM trigger code must be preserved in order to notify other
     objects when the browser's current row changes. */
  {src/adm/template/brschnge.i}

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Abrir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Abrir B-table-Win
ON CHOOSE OF MENU-ITEM m_Abrir /* Abrir */
DO:
  RUN abrir("OPEN").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Caracteristicas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Caracteristicas B-table-Win
ON CHOOSE OF MENU-ITEM m_Caracteristicas /* Caracteristicas */
DO:
    DEF VAR paccion AS CHAR.
    EMPTY TEMP-TABLE  tt.
    CREATE tt.
    BUFFER-COPY vortex TO tt.
    RUN d-vortexq.w ( INPUT-OUTPUT TABLE tt,FALSE, OUTPUT paccion).
    IF paccion = "G" THEN
        BUFFER-COPY tt TO vortex.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Editar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Editar B-table-Win
ON CHOOSE OF MENU-ITEM m_Editar /* Editar */
DO:
    RUN abrir("EDIT").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Imprimir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Imprimir B-table-Win
ON CHOOSE OF MENU-ITEM m_Imprimir /* Imprimir */
DO:
    RUN abrir("Print").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Recarga
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Recarga B-table-Win
ON CHOOSE OF MENU-ITEM m_Recarga /* Recarga */
DO:
    DEF VAR i AS INT no-undo.

  DEF VAR rup AS LOGICAL NO-UNDO.
  DEF VAR archfile AS CHAR NO-UNDO.
  DEF VAR vaccion AS CHAR NO-UNDO.
  DEF VAR vnombre AS CHAR NO-UNDO.
  DEF VAR vtipo AS CHAR NO-UNDO.
  DEF VAR tempfile AS CHAR NO-UNDO.

      tempfile = SESSION:TEMP-DIRECTORY.
      archfile =   tempfile + vortex.Nombre + "." + vortex.tipo.
      FILE-INFO:FILE-NAME = archfile.
      
      FILE-INFO:FILE-NAME = archfile.
      IF FILE-INFO:FILE-NAME = ? THEN DO:
          MESSAGE "Archivo inexistente o no tiene los permisos suficientes"
          VIEW-AS ALERT-BOX ERROR.
          RETURN NO-APPLY.
      END.
      vnombre = FILE-INFO:FILE-NAME.
      vnombre = REPLACE(vnombre,"/","\").
      vnombre = entry(NUM-ENTRIES(vnombre,"\") , vnombre ,"\" ).
      vtipo = IF NUM-ENTRIES(vnombre,".") > 1 THEN ENTRY(NUM-ENTRIES(vnombre,"."),vnombre,".") ELSE "".
      vnombre = ENTRY(1,vnombre,".").
      FIND bvortex WHERE ROWID(bvortex) = ROWID(vortex) .
      CREATE vortex.
      BUFFER-COPY bvortex TO vortex 
          ASSIGN vortex.VERSION = bvortex.VERSION + 1 
                 vortex.fcreado = DATETIME(FILE-INFO:FILE-CREATE-DATE ,FILE-INFO:FILE-CREATE-TIME) 
                 vortex.fmodif = DATETIME(FILE-INFO:FILE-MOD-DATE, FILE-INFO:FILE-MOD-TIME) 
                 vortex.tamanio = FILE-INFO:FILE-SIZE.
                 COPY-LOB FROM FILE archfile TO OBJECT vortex.archivo.
                            {&OPEN-QUERY-{&BROWSE-NAME}}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir B-table-Win 
PROCEDURE abrir :
DEFINE INPUT PARAMETER modo AS CHAR NO-UNDO.
    DEF VAR archfile AS CHAR NO-UNDO.
    DEFINE VARIABLE hInstance AS INTEGER.
    DEFINE VAR tempfile AS CHAR NO-UNDO.
    DEF VAR pud AS LOGICAL NO-UNDO.
    DEFINE VARIABLE lpVerb AS MEMPTR.
    DEFINE VARIABLE lpFile AS MEMPTR.
    DEFINE VARIABLE lpExecInfo AS MEMPTR.
    DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.

    tempfile = SESSION:TEMP-DIRECTORY.
    archfile =   tempfile + vortex.Nombre + "." + vortex.tipo.
    FILE-INFO:FILE-NAME = archfile.
    IF FILE-INFO:FILE-NAME <> ? THEN DO:
        OS-DELETE archfile.
        /*MESSAGE "El archivo existe desea sobreescribirlo"
            VIEW-AS ALERT-BOX question BUTTONS YES-NO UPDATE pud.
        IF pud  THEN OS-DELETE VALUE(archfile).
        ELSE RETURN NO-APPLY.*/
    END.
        
    COPY-LOB FROM OBJECT vortex.archivo TO FILE archfile.
    FILE-INFO:FILE-NAME = archfile.
    FIND CURRENT vortex EXCLUSIVE-LOCK.
    ASSIGN sic.vortex.FAccedido = NOW.
    FIND CURRENT vortex NO-LOCK.
    RELEASE vortex.

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


/*    
    IF hinstance < 32  THEN DO:
        /*hay error*/
        RUN errores(hinstance).
        RETURN.
    END.
*/    
    /*OS-DELETE archfile. no es modal a si que no puedo detectar los cambios automaticamente*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir1 B-table-Win 
PROCEDURE abrir1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER modo AS CHAR NO-UNDO.
    DEF VAR archfile AS CHAR NO-UNDO.
    DEFINE VARIABLE hInstance AS INTEGER.
    DEFINE VAR tempfile AS CHAR NO-UNDO.
    DEF VAR pud AS LOGICAL NO-UNDO.
    tempfile = SESSION:TEMP-DIRECTORY.
    archfile =   tempfile + vortex.Nombre + "." + vortex.tipo.
    FILE-INFO:FILE-NAME = archfile.
    IF FILE-INFO:FILE-NAME <> ? THEN DO:
        MESSAGE "El archivo existe desea sobreescribirlo"
            VIEW-AS ALERT-BOX question BUTTONS YES-NO UPDATE pud.
        IF pud  THEN OS-DELETE VALUE(archfile).
        ELSE RETURN NO-APPLY.
    END.
        
    COPY-LOB FROM OBJECT vortex.archivo TO FILE archfile.
    FILE-INFO:FILE-NAME = archfile.
    FIND CURRENT vortex EXCLUSIVE-LOCK.
    ASSIGN sic.vortex.FAccedido = NOW.
    FIND CURRENT vortex NO-LOCK.
    RELEASE vortex.
    RUN ShellExecuteA(0, modo, archfile, "", "", 0, OUTPUT hInstance).
    IF hinstance < 32  THEN DO:
        /*hay error*/
        RUN errores(hinstance).
        RETURN.
    END.
    
    /*OS-DELETE archfile. no es modal a si que no puedo detectar los cambios automaticamente*/

END.
/*
PROCEDURE ShellExecuteA EXTERNAL "shell32.dll":
DEFINE INPUT PARAMETER hwnd AS LONG.
/* Handle to parent window */
DEFINE INPUT PARAMETER lpOperation AS CHAR.
/* Operation to perform: open, print */
DEFINE INPUT PARAMETER lpFile AS CHAR.
/* Document or executable name */
DEFINE INPUT PARAMETER lpParameters AS CHAR.
/* Command line parameters to executable in lpFile */
DEFINE INPUT PARAMETER lpDirectory AS CHAR.
/* Default directory */
DEFINE INPUT PARAMETER nShowCmd AS LONG.
/* whether shown when opened:
0 hidden, 1 normal, minimized 2, maximized 3,
0 if lpFile is a document */
DEFINE RETURN PARAMETER hInstance AS LONG.
/* Less than or equal to 32 */
END.

  */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrir2 B-table-Win 
PROCEDURE abrir2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*

 
PROCEDURE PrintAndWait :
  DEFINE INPUT PARAMETER FILENAME AS CHARACTER NO-UNDO.
 
  DEFINE VARIABLE lpVerb AS MEMPTR.
  DEFINE VARIABLE lpFile AS MEMPTR.
  DEFINE VARIABLE lpExecInfo AS MEMPTR.
  DEFINE VARIABLE ReturnValue AS INTEGER NO-UNDO.
 
  SET-SIZE(lpVerb)         = LENGTH("print") + 1.
  PUT-STRING(lpVerb,1)     = "print".
 
  SET-SIZE(lpFile)         = LENGTH (FILENAME) + 1.
  PUT-STRING(lpFile,1)     = FILENAME.
 
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
*/ 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE errores B-table-Win 
PROCEDURE errores :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER r AS INT NO-UNDO.
DEFINE VAR s AS CHAR NO-UNDO.
define var SW_SHOWNORMAL          AS INT INITIAL 1.
define var SE_ERR_FNF             as int initial 2.
define var SE_ERR_PNF             as int initial 3.
define var SE_ERR_ACCESSDENIED    as int initial 5.
define var SE_ERR_OOM             as int initial 8.
define var SE_ERR_DLLNOTFOUND     as int initial 32.
define var SE_ERR_SHARE           as int initial 26.
define var SE_ERR_ASSOCINCOMPLETE as int initial 27.
define var SE_ERR_DDETIMEOUT      as int initial 28.
define var SE_ERR_DDEFAIL         as int initial 29.
define var SE_ERR_DDEBUSY         as int initial 30.
define var SE_ERR_NOASSOC         as int initial 31.
define var ERROR_BAD_FORMAT       as int initial 11.
    
If r <= 32 Then DO:
CASE r:
    when SE_ERR_FNF THEN
                s = "Archivo No encontrado".
            when SE_ERR_PNF THEN
                s = "Path no encontrado".
            when SE_ERR_ACCESSDENIED THEN
                s = "Acceso denegado".
            when SE_ERR_OOM  THEN 
                s = "Sin memoria" .
            when SE_ERR_DLLNOTFOUND THEN
                s = "DLL no encontrada".
            when SE_ERR_SHARE THEN
                s = "Error Sharing Violation".
            when SE_ERR_ASSOCINCOMPLETE THEN
                s = "Asociacion de extencion incompleta".
            when SE_ERR_DDETIMEOUT THEN
                s = "DDE Time out".
            when SE_ERR_DDEFAIL THEN
                s = "DDE transaccion fallida".
            when SE_ERR_DDEBUSY THEN
                s = "DDE ocupada".
            when SE_ERR_NOASSOC THEN
                s = "No hay asociacion a la extencion".
            when ERROR_BAD_FORMAT THEN 
                s = "EXE invalido o error de formato".
            OTHERWISE
                s = "Error desconocido".

        End case.
        MESSAGE s
            VIEW-AS ALERT-BOX INFO BUTTONS OK.

    End.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
   RUN get-link-handle IN adm-broker-hdl
       ( INPUT THIS-PROCEDURE,
         INPUT "container-source",
         OUTPUT hcproc ).
   hproc = WIDGET-HANDLE(hcproc).
   IF VALID-HANDLE(hProc) THEN do:
       
       RUN GET-ATTRIBUTE IN hproc ( 'p-carpeta' ) .
        p-carpeta = RETURN-VALUE.
        RUN GET-ATTRIBUTE IN hproc ( 'p-indice' ).
        p-indice = RETURN-VALUE.

   END.

  /* Code placed here will execute PRIOR to standard behavior. */
  /* Dispatch standard ADM method.  */     
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .


  
  /* Code placed here will execute AFTER standard behavior.    */

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
  {src/adm/template/snd-list.i "vortex"}

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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

