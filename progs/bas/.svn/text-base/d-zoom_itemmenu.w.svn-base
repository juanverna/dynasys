&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
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

  Description: from cntnrdlg.w - ADM SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
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

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE                rid_item        AS ROWID.
DEFINE VARIABLE                modo            AS INTEGER.
DEFINE VARIABLE                cdg_salida      AS INTEGER.
FIND FIRST Treemenu WHERE Treemenu.cdg_item BEGINS "FAC".
rid_item = ROWID(Treemenu).
&ELSE
DEFINE INPUT        PARAMETER  rid_item        AS ROWID.
DEFINE INPUT        PARAMETER  modo            AS INTEGER.
DEFINE OUTPUT       PARAMETER  cdg_salida      AS INTEGER.
&ENDIF

DEFINE BUFFER B-Empresa FOR Empresa.
DEFINE BUFFER B-Submenu FOR Treemenu.
DEFINE BUFFER B-Treemenu FOR Treemenu.
DEFINE BUFFER C-Treemenu FOR Treemenu.
DEFINE BUFFER Submenu FOR Treemenu.
DEFINE TEMP-TABLE T-Treemenu NO-UNDO LIKE Treemenu.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Treemenu

/* Definitions for DIALOG-BOX D-Dialog                                  */
&Scoped-define FIELDS-IN-QUERY-D-Dialog Treemenu.cdg_item ~
Treemenu.cdg_padre Treemenu.titulo Treemenu.accion Treemenu.cdg_comprobante ~
Treemenu.modo Treemenu.archivo_help Treemenu.archivo_icono ~
Treemenu.permitidos Treemenu.descripcion 
&Scoped-define QUERY-STRING-D-Dialog FOR EACH Treemenu SHARE-LOCK
&Scoped-define OPEN-QUERY-D-Dialog OPEN QUERY D-Dialog FOR EACH Treemenu SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-D-Dialog Treemenu
&Scoped-define FIRST-TABLE-IN-QUERY-D-Dialog Treemenu


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-8 btn_grabar Bmuestra btn_cancelar ~
btn_deshacer Btn_Salir btn_updatenode 
&Scoped-Define DISPLAYED-FIELDS Treemenu.cdg_item Treemenu.cdg_padre ~
Treemenu.titulo Treemenu.accion Treemenu.cdg_comprobante Treemenu.modo ~
Treemenu.archivo_help Treemenu.archivo_icono Treemenu.permitidos ~
Treemenu.descripcion 
&Scoped-define DISPLAYED-TABLES Treemenu
&Scoped-define FIRST-DISPLAYED-TABLE Treemenu


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */
&Scoped-define List-1 Treemenu.cdg_item Treemenu.titulo Treemenu.accion ~
btn_programas Treemenu.cdg_comprobante Treemenu.modo Treemenu.archivo_help ~
btn_ayudas Treemenu.archivo_icono btn_iconos Treemenu.permitidos ~
Treemenu.descripcion 
&Scoped-define List-2 Treemenu.cdg_padre 

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bmuestra 
     LABEL "" 
     SIZE 5.4 BY 1.29.

DEFINE BUTTON btn_ayudas 
     LABEL "&Ayudas" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_cancelar  NO-FOCUS FLAT-BUTTON
     LABEL "&Cancelar" 
     SIZE 21 BY 1.14.

DEFINE BUTTON btn_deshacer  NO-FOCUS FLAT-BUTTON
     LABEL "&Deshacer" 
     SIZE 21 BY 1.14.

DEFINE BUTTON btn_grabar  NO-FOCUS FLAT-BUTTON
     LABEL "&Grabar" 
     SIZE 21 BY 1.14.

DEFINE BUTTON btn_iconos 
     LABEL "&Imágenes" 
     SIZE 15 BY 1.

DEFINE BUTTON btn_programas 
     LABEL "&Programas" 
     SIZE 15 BY 1.

DEFINE BUTTON Btn_Salir AUTO-GO  NO-FOCUS FLAT-BUTTON
     LABEL "Salir" 
     SIZE 21 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_updatenode  NO-FOCUS FLAT-BUTTON
     LABEL "&Modificar" 
     SIZE 21 BY 1.14 TOOLTIP "Add a child node for the selected one.".

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 129 BY 12.86.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY D-Dialog FOR 
      Treemenu SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     btn_grabar AT ROW 12.67 COL 39 WIDGET-ID 82
     Treemenu.cdg_item AT ROW 1.71 COL 15 COLON-ALIGNED WIDGET-ID 16 FORMAT "X(40)"
          VIEW-AS FILL-IN 
          SIZE 55 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.cdg_padre AT ROW 1.71 COL 79 COLON-ALIGNED WIDGET-ID 18 FORMAT "X(20)"
          VIEW-AS FILL-IN 
          SIZE 48 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.titulo AT ROW 2.91 COL 15 COLON-ALIGNED WIDGET-ID 24
          VIEW-AS FILL-IN 
          SIZE 112 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.accion AT ROW 4.1 COL 15 COLON-ALIGNED WIDGET-ID 26
          VIEW-AS FILL-IN 
          SIZE 95.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_programas AT ROW 4.1 COL 114 WIDGET-ID 34
     Treemenu.cdg_comprobante AT ROW 5.29 COL 15 COLON-ALIGNED WIDGET-ID 28
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Item 1","Item 1"
          DROP-DOWN-LIST
          SIZE 82 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.modo AT ROW 5.29 COL 106 COLON-ALIGNED WIDGET-ID 30
          VIEW-AS COMBO-BOX INNER-LINES 5
          LIST-ITEM-PAIRS "Sin Modo","X",
                     "Altas","0",
                     "Consultas","1",
                     "Modificaciones","5",
                     "Anulaciones","7",
                     "Emision","8"
          DROP-DOWN-LIST
          SIZE 21 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Treemenu.archivo_help AT ROW 6.43 COL 15 COLON-ALIGNED WIDGET-ID 14 FORMAT "X(90)"
          VIEW-AS FILL-IN 
          SIZE 95.8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_ayudas AT ROW 6.43 COL 114 WIDGET-ID 36
     Bmuestra AT ROW 7.57 COL 104.2 WIDGET-ID 84
     Treemenu.archivo_icono AT ROW 7.67 COL 15 COLON-ALIGNED WIDGET-ID 76
          VIEW-AS FILL-IN 
          SIZE 82 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_iconos AT ROW 7.67 COL 114 WIDGET-ID 78
     Treemenu.permitidos AT ROW 9 COL 17 NO-LABEL WIDGET-ID 22
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 111.8 BY 1.62
          BGCOLOR 15 FGCOLOR 7 
     Treemenu.descripcion AT ROW 10.76 COL 17 NO-LABEL WIDGET-ID 20
          VIEW-AS EDITOR SCROLLBAR-VERTICAL
          SIZE 111.8 BY 1.62
          BGCOLOR 15 FGCOLOR 7 
     btn_cancelar AT ROW 12.67 COL 83 WIDGET-ID 68
     btn_deshacer AT ROW 12.67 COL 61 WIDGET-ID 70
     Btn_Salir AT ROW 12.67 COL 106
     btn_updatenode AT ROW 12.67 COL 17 WIDGET-ID 46
     "Descripción:" VIEW-AS TEXT
          SIZE 12 BY .86 AT ROW 10.76 COL 5 WIDGET-ID 74
     "Funciones:" VIEW-AS TEXT
          SIZE 11 BY .86 AT ROW 8.62 COL 6 WIDGET-ID 72
     RECT-8 AT ROW 1.24 COL 2 WIDGET-ID 80
     SPACE(1.79) SKIP(0.41)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Datos del item de menú"
         CANCEL-BUTTON btn_cancelar WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   FRAME-NAME                                                           */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN Treemenu.accion IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR FILL-IN Treemenu.archivo_help IN FRAME D-Dialog
   NO-ENABLE 1 EXP-FORMAT                                               */
/* SETTINGS FOR FILL-IN Treemenu.archivo_icono IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_ayudas IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_iconos IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR BUTTON btn_programas IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR COMBO-BOX Treemenu.cdg_comprobante IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR FILL-IN Treemenu.cdg_item IN FRAME D-Dialog
   NO-ENABLE 1 EXP-FORMAT                                               */
/* SETTINGS FOR FILL-IN Treemenu.cdg_padre IN FRAME D-Dialog
   NO-ENABLE 2 EXP-FORMAT                                               */
/* SETTINGS FOR EDITOR Treemenu.descripcion IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR COMBO-BOX Treemenu.modo IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR EDITOR Treemenu.permitidos IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* SETTINGS FOR FILL-IN Treemenu.titulo IN FRAME D-Dialog
   NO-ENABLE 1                                                          */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _TblList          = "sic.Treemenu"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Datos del item de menú */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Treemenu.accion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Treemenu.accion D-Dialog
ON LEAVE OF Treemenu.accion IN FRAME D-Dialog /* Acción */
DO:
      IF Treemenu.accion <> "" THEN DO:
    IF SEARCH(Treemenu.accion) = ? AND search(entry(1,Treemenu.accion,".") + ".r" ) = ? THEN DO:
       Treemenu.accion:BGCOLOR = 12.
       Treemenu.accion:FGCOLOR = 15.
      END.
      ELSE DO:
       Treemenu.accion:BGCOLOR = 15.
       Treemenu.accion:FGCOLOR = 9.
    END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Treemenu.archivo_icono
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Treemenu.archivo_icono D-Dialog
ON LEAVE OF Treemenu.archivo_icono IN FRAME D-Dialog /* Icono */
DO:
  DEF VAR bmicon AS CHAR NO-UNDO.
  bmicon = REPLACE(Treemenu.archivo_icono:SCREEN-VALUE,"iconos16","iconos24").
  bmicon = REPLACE(Treemenu.archivo_icono:SCREEN-VALUE,"tvpics","iconos24").
  IF SEARCH(bmicon) <> ? THEN
    Bmuestra:LOAD-IMAGE(bmicon).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ayudas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ayudas D-Dialog
ON CHOOSE OF btn_ayudas IN FRAME D-Dialog /* Ayudas */
DO:
    DEFINE VARIABLE ok AS LOGICAL.
    DEFINE VARIABLE x-archivo AS CHARACTER.
    DEFINE VARIABLE x-carpeta_inicial AS CHARACTER.
    DEFINE VARIABLE x-carpeta_default AS CHARACTER INITIAL ".\ayudas".
    DEFINE VARIABLE x-separador AS CHARACTER INITIAL "\".
    DEFINE VARIABLE j-carpeta AS INTEGER.
    DEFINE VARIABLE puso_ok AS LOGICAL.

    ASSIGN x-archivo = Treemenu.archivo_help:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    x-archivo = REPLACE(x-archivo,"/","\").
    x-carpeta_inicial = "".
    DO j-carpeta = 1 TO NUM-ENTRIES(x-archivo,x-separador) - 1:
        x-carpeta_inicial = x-carpeta_inicial + x-separador + ENTRY(j-carpeta,x-archivo,x-separador).
    END.
    x-carpeta_inicial = SUBSTRING(x-carpeta_inicial,2).
    
    IF x-carpeta_inicial = ""
        THEN x-carpeta_inicial = x-carpeta_default.
    
    SYSTEM-DIALOG GET-FILE x-archivo
          FILTERS "Archivos (*.*)" "*.*",
                  "Programas (*.*)" "*.*"
          INITIAL-FILTER 1
          MUST-EXIST
          DEFAULT-EXTENSION ".*"
          INITIAL-DIR x-carpeta_inicial
          RETURN-TO-START-DIR 
          TITLE "Seleccione el archivo de ayuda" 
          USE-FILENAME
          UPDATE puso_ok.

  IF puso_ok 
  THEN DO:
      FILE-INFO:FILE-NAME = ".".
      ASSIGN x-archivo = REPLACE(x-archivo,FILE-INFO:FULL-PATHNAME + "\","").

      DISPLAY x-archivo @ Treemenu.archivo_help
                  WITH FRAME {&FRAME-NAME}.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cancelar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cancelar D-Dialog
ON CHOOSE OF btn_cancelar IN FRAME D-Dialog /* Cancelar */
DO:
  RUN adm-disable-fields.
  RUN adm-display-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_deshacer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_deshacer D-Dialog
ON CHOOSE OF btn_deshacer IN FRAME D-Dialog /* Deshacer */
DO:
    RUN adm-display-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_grabar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_grabar D-Dialog
ON CHOOSE OF btn_grabar IN FRAME D-Dialog /* Grabar */
DO:
    RUN adm-assign-statment.
    IF RETURN-VALUE <> "ERROR"
       THEN RUN adm-disable-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_iconos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_iconos D-Dialog
ON CHOOSE OF btn_iconos IN FRAME D-Dialog /* Imágenes */
DO:
   DEFINE VARIABLE ok AS LOGICAL.
    DEFINE VARIABLE x-icono AS CHARACTER.
    DEFINE VARIABLE x-carpeta_inicial AS CHARACTER.
    DEFINE VARIABLE x-carpeta_default AS CHARACTER INITIAL ".\img".
    DEFINE VARIABLE x-separador AS CHARACTER INITIAL "\".
    DEFINE VARIABLE j-carpeta AS INTEGER.
    DEFINE VAR puso_ok AS LOGICAL.
    DEF VAR bmicon AS CHAR NO-UNDO.
    ASSIGN x-icono = Treemenu.archivo_icono:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    x-icono = REPLACE(x-icono,"/","\").
    x-carpeta_inicial = "".
    DO j-carpeta = 1 TO NUM-ENTRIES(x-icono,x-separador) - 1:
        x-carpeta_inicial = x-carpeta_inicial + x-separador + ENTRY(j-carpeta,x-icono,x-separador).
    END.
    x-carpeta_inicial = SUBSTRING(x-carpeta_inicial,2).
    
    IF x-carpeta_inicial = ""
        THEN x-carpeta_inicial = x-carpeta_default.
    
    RUN giconos.w (INPUT-OUTPUT x-carpeta_inicial, OUTPUT x-icono).
  puso_ok = search(x-carpeta_inicial + "/" +  x-icono ) <> ?.
  IF puso_ok 
  THEN DO:
      ASSIGN x-icono = REPLACE(x-icono,"Minus","")
             x-icono = REPLACE(x-icono,"Plus","")
             x-icono = REPLACE(x-icono,"noSIgn","")
             x-icono = REPLACE(x-icono,"Open","").
      FILE-INFO:FILE-NAME = ".\img".
      x-icono = REPLACE(x-icono,FILE-INFO:FULL-PATHNAME + "\","").
      bmicon = REPLACE(x-icono,"iconos16","iconos24").
      bmicon = REPLACE(x-icono,"tvpics","iconos24").
      IF SEARCH(bmicon) <> ? THEN
          Bmuestra:LOAD-IMAGE(bmicon).
      DISPLAY x-icono @ Treemenu.archivo_icono
                  WITH FRAME {&FRAME-NAME}.
  END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_programas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_programas D-Dialog
ON CHOOSE OF btn_programas IN FRAME D-Dialog /* Programas */
DO:
   DEFINE VARIABLE ok AS LOGICAL.
    DEFINE VARIABLE x-programa AS CHARACTER.
        DEFINE VARIABLE x-carpeta_inicial AS CHARACTER.
    DEFINE VARIABLE x-carpeta_default AS CHARACTER INITIAL ".\".
    DEFINE VARIABLE x-separador AS CHARACTER INITIAL "\".
    DEFINE VARIABLE j-carpeta AS INTEGER.
    DEFINE VARIABLE puso_ok AS LOGICAL.

    ASSIGN x-programa = Treemenu.accion:SCREEN-VALUE IN FRAME {&FRAME-NAME}.

    x-programa = REPLACE(x-programa,"/","\").
    x-carpeta_inicial = "".
    DO j-carpeta = 1 TO NUM-ENTRIES(x-programa,x-separador) - 1:
        x-carpeta_inicial = x-carpeta_inicial + x-separador + ENTRY(j-carpeta,x-programa,x-separador).
    END.
    x-carpeta_inicial = SUBSTRING(x-carpeta_inicial,2).
    
    IF x-carpeta_inicial = ""
        THEN x-carpeta_inicial = x-carpeta_default.
    
    SYSTEM-DIALOG GET-FILE x-programa
          FILTERS "Programas (*.w)" "*.w",
                  "Programas (*.p)" "*.p"
          INITIAL-FILTER 1
          MUST-EXIST
          DEFAULT-EXTENSION ".w"
          INITIAL-DIR x-carpeta_inicial
          RETURN-TO-START-DIR 
          TITLE "Seleccione el programa a ejecutar" 
          USE-FILENAME
          UPDATE puso_ok.

  IF puso_ok 
  THEN DO:
      FILE-INFO:FILE-NAME = ".".
      ASSIGN x-programa = REPLACE(x-programa,FILE-INFO:FULL-PATHNAME + "\","").

      DISPLAY x-programa @ Treemenu.accion
                  WITH FRAME {&FRAME-NAME}.
      IF SEARCH(x-programa) = ? AND search(entry(1,x-programa,".") + ".r" ) = ? THEN 
          MESSAGE "Tenga en cuenta que este programa no existe"
              VIEW-AS ALERT-BOX INFO BUTTONS OK.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_updatenode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_updatenode D-Dialog
ON CHOOSE OF btn_updatenode IN FRAME D-Dialog /* Modificar */
DO:
    RUN adm-enable-fields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-assign-record D-Dialog 
PROCEDURE adm-assign-record :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE n                    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j                    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE l                    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE v-item               AS CHARACTER NO-UNDO.
  DEFINE VARIABLE v-codigo_padre       AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lmovernodo           AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE v-old_nodo           LIKE Treemenu.cdg_item.
  DEFINE VARIABLE x-padre              LIKE Submenu.cdg_padre.

  DO TRANSACTION WITH FRAME {&FRAME-NAME}:

      ASSIGN lmovernodo = Treemenu.cdg_item <> Treemenu.cdg_item:INPUT-VALUE
             v-old_nodo = Treemenu.cdg_item.
      FIND CURRENT Treemenu EXCLUSIVE-LOCK.
    
      ASSIGN FRAME {&FRAME-NAME}
          Treemenu.archivo_help 
          Treemenu.cdg_item 
          Treemenu.descripcion 
          Treemenu.permitidos 
          Treemenu.titulo
          Treemenu.archivo_icono 
          Treemenu.cdg_comprobante 
          Treemenu.accion 
          Treemenu.modo.

      IF Treemenu.cdg_comprobante = "Z" THEN Treemenu.cdg_comprobante = "".

      Treemenu.permitidos = REPLACE(Treemenu.permitidos ,CHR(10) ,"").
      Treemenu.permitidos = REPLACE(Treemenu.permitidos ,CHR(13) ,"").

      FIND CURRENT Treemenu NO-LOCK.

  END. /* De la transaccion */
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-assign-statment D-Dialog 
PROCEDURE adm-assign-statment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE sino         AS LOGICAL.
  DEFINE VARIABLE v-old_padre  LIKE Treemenu.cdg_item.

  DEFINE VARIABLE v-new_item   LIKE Treemenu.cdg_item.
  DEFINE VARIABLE v-new_padre  LIKE Treemenu.cdg_padre.

  DO WITH FRAME {&FRAME-NAME}:

      IF Treemenu.titulo:INPUT-VALUE = ""
      THEN DO:
          RUN ponmensj.p ( INPUT "TREE003").
          RETURN ERROR.
      END.

      IF Treemenu.permitidos:INPUT-VALUE = ""
      THEN DO:
          RUN ponmensj.p ( INPUT "TREE004").
          RETURN ERROR.
      END.

  END.

  RUN adm-assign-record.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-disable-fields D-Dialog 
PROCEDURE adm-disable-fields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  ENABLE ALL EXCEPT {&LIST-2}
      WITH FRAME {&FRAME-NAME}.

  DISABLE {&LIST-1}
      WITH FRAME {&FRAME-NAME}.

  ASSIGN Treemenu.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 7
         Treemenu.permitidos:FGCOLOR IN FRAME {&FRAME-NAME} = 7.


  btn_salir:SENSITIVE IN FRAME {&FRAME-NAME} = YES.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-display-fields D-Dialog 
PROCEDURE adm-display-fields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DISPLAY
        Treemenu.archivo_help 
        Treemenu.cdg_item 
        Treemenu.cdg_padre 
        Treemenu.descripcion 
        Treemenu.permitidos 
        Treemenu.titulo
        Treemenu.archivo_icono 
        Treemenu.cdg_comprobante  
        Treemenu.accion 
        Treemenu.modo
        WITH FRAME {&FRAME-NAME}.
    IF Treemenu.accion <> "" 
    THEN DO:
        IF SEARCH(Treemenu.accion) = ? AND SEARCH(ENTRY(1,Treemenu.accion,".") + ".r" ) = ? 
        THEN DO:
           Treemenu.accion:BGCOLOR = 12.
           Treemenu.accion:FGCOLOR = 15.
        END.
        ELSE DO:
           Treemenu.accion:BGCOLOR = 15.
           Treemenu.accion:FGCOLOR = 9.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-enable-fields D-Dialog 
PROCEDURE adm-enable-fields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  /*DISABLE ALL WITH FRAME {&FRAME-NAME}.*/

  ENABLE {&LIST-1}
      WITH FRAME {&FRAME-NAME}.

  ASSIGN Treemenu.descripcion:FGCOLOR IN FRAME {&FRAME-NAME} = 9
         Treemenu.permitidos:FGCOLOR IN FRAME {&FRAME-NAME} = 9.

  btn_salir:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
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
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
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

  {&OPEN-QUERY-D-Dialog}
  GET FIRST D-Dialog.
  IF AVAILABLE Treemenu THEN 
    DISPLAY Treemenu.cdg_item Treemenu.cdg_padre Treemenu.titulo Treemenu.accion 
          Treemenu.cdg_comprobante Treemenu.modo Treemenu.archivo_help 
          Treemenu.archivo_icono Treemenu.permitidos Treemenu.descripcion 
      WITH FRAME D-Dialog.
  ENABLE RECT-8 btn_grabar Bmuestra btn_cancelar btn_deshacer Btn_Salir 
         btn_updatenode 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inicia_combos D-Dialog 
PROCEDURE inicia_combos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE ok AS LOGICAL.
  DEFINE VARIABLE lista AS CHARACTER.

  {findempresa.i}

  DO WITH FRAME {&FRAME-NAME}:
      lista = "[Sin Comprobante]|Z".
      Treemenu.cdg_comprobante:DELIMITER = "|".
      FOR EACH Tipocomprobante NO-LOCK WHERE Tipocomprobante.cdg_empresa = Empresa.cdg_empresa BY Tipocomprobante.dsc_comprobante:
          lista = lista + "|" + TRIM(Tipocomprobante.dsc_comprobante) + " - " + STRING(Tipocomprobante.cdg_comprobante) + "|" + STRING(Tipocomprobante.cdg_comprobante).
      END.
      Treemenu.cdg_comprobante:LIST-ITEM-PAIRS = lista.
  END.          
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/
  DEF VAR bmicon AS CHAR NO-UNDO.
  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
 RUN inicia_combos.
  /* Code placed here will execute AFTER standard behavior.    */

  FIND FIRST Treemenu WHERE ROWID(Treemenu) = rid_item NO-LOCK.
  DISPLAY Treemenu.accion 
          Treemenu.archivo_help 
          Treemenu.archivo_icono 
          Treemenu.cdg_comprobante 
          Treemenu.cdg_item 
          Treemenu.cdg_padre 
          Treemenu.descripcion 
          Treemenu.modo 
          Treemenu.permitidos 
          Treemenu.titulo
          WITH FRAME {&FRAME-NAME}.
  bmicon = REPLACE(Treemenu.archivo_icono,"iconos16","iconos24").
  bmicon = REPLACE(Treemenu.archivo_icono,"tvpics","iconos24").
  IF SEARCH(bmicon) <> ? THEN
    Bmuestra:LOAD-IMAGE(bmicon).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.               */
  {src/adm/template/snd-head.i}

  /* For each requested table, put it's ROWID in the output list.      */
  {src/adm/template/snd-list.i "Treemenu"}

  /* Deal with any unexpected table requests before closing.           */
  {src/adm/template/snd-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
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

