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

DEFINE BUFFER B-Area FOR Area.
DEFINE TEMP-TABLE T-Area LIKE Area.

{nrorelea.i}

DEFINE VARIABLE txn_activa  AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE p-que_padre AS CHARACTER.
DEFINE VARIABLE a-que_padre AS CHARACTER.
DEFINE VARIABLE aux_archivo AS CHARACTER.
DEFINE VARIABLE puso_ok     AS LOGICAL.
DEFINE VARIABLE v-nueitem   AS CHARACTER NO-UNDO.
DEFINE VARIABLE v-nuedesc   LIKE Area.denominacion.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_Done btn_cambiar btn_vertodo ~
v-cdg_articulo btn_addnodo btn_addsubnivel btn_deletenode btn_refrescar ~
btn_exportar btn_importar btn_exportar-2 RECT-1 RECT-2 RECT-4 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo v-unidad 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD GetCodigo W-Win 
FUNCTION GetCodigo RETURNS CHARACTER
  (   INPUT p-NodeInfo AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of handles for OCX Containers                            */
DEFINE VARIABLE ChTreeview AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE chChTreeview AS COMPONENT-HANDLE NO-UNDO.

/* Definitions of handles for SmartObjects                              */
DEFINE VARIABLE h_p-soloedita AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-articulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_q-formula_articulo AS HANDLE NO-UNDO.
DEFINE VARIABLE h_v-formula_articulo AS HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_addnodo 
     LABEL "Nueva Fórmula" 
     SIZE 23 BY 1.67.

DEFINE BUTTON btn_addsubnivel 
     LABEL "Nueva Sub Fórmula" 
     SIZE 23 BY 1.67 TOOLTIP "Add a child node for the selected one.".

DEFINE BUTTON btn_cambiar 
     LABEL "&Cambiar Empresa" 
     SIZE 20 BY 1.14 TOOLTIP "Delete the selected Node.".

DEFINE BUTTON btn_deletenode 
     LABEL "&Eliminar Fórmula" 
     SIZE 23 BY 1.67 TOOLTIP "Add a child node for the selected one.".

DEFINE BUTTON Btn_Done DEFAULT 
     LABEL "&Salir" 
     SIZE 23 BY 1.67
     BGCOLOR 8 .

DEFINE BUTTON btn_exportar 
     LABEL "&Export" 
     SIZE 11 BY 1.67.

DEFINE BUTTON btn_exportar-2 
     LABEL "&Exportar Sector" 
     SIZE 23 BY 1.67.

DEFINE BUTTON btn_importar 
     LABEL "&Import" 
     SIZE 11 BY 1.67.

DEFINE BUTTON btn_refrescar 
     LABEL "&Refrescar" 
     SIZE 23 BY 1.67.

DEFINE BUTTON btn_vertodo 
     LABEL "Ver &Todo" 
     SIZE 18 BY 1.14 TOOLTIP "Delete the selected Node.".

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN NATIVE 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-unidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 131 BY 1.62.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 9.76.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 2.14.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     Btn_Done AT ROW 1.24 COL 135
     btn_cambiar AT ROW 1.48 COL 3
     btn_vertodo AT ROW 1.48 COL 24
     v-cdg_articulo AT ROW 1.48 COL 42 COLON-ALIGNED NO-LABEL
     v-dsc_articulo AT ROW 1.48 COL 66 COLON-ALIGNED NO-LABEL
     v-unidad AT ROW 1.48 COL 120 COLON-ALIGNED NO-LABEL
     btn_addnodo AT ROW 3.38 COL 135
     btn_addsubnivel AT ROW 5.29 COL 135
     btn_deletenode AT ROW 7.19 COL 135
     btn_refrescar AT ROW 9.1 COL 135
     btn_exportar AT ROW 11 COL 135
     btn_importar AT ROW 11 COL 147
     btn_exportar-2 AT ROW 13.14 COL 135
     RECT-1 AT ROW 1.24 COL 2
     RECT-2 AT ROW 3.14 COL 134
     RECT-4 AT ROW 12.91 COL 134
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 158 BY 26.86.


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
         TITLE              = "Mantenimiento de Estructuras Recursivas"
         HEIGHT             = 26.86
         WIDTH              = 158
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 160
         VIRTUAL-HEIGHT     = 27.67
         VIRTUAL-WIDTH      = 160
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
                                                                        */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-unidad IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


/* **********************  Create OCX Containers  ********************** */

&ANALYZE-SUSPEND _CREATE-DYNAMIC

&IF "{&OPSYS}" = "WIN32":U AND "{&WINDOW-SYSTEM}" NE "TTY":U &THEN

CREATE CONTROL-FRAME ChTreeview ASSIGN
       FRAME           = FRAME F-Main:HANDLE
       ROW             = 3.14
       COLUMN          = 2
       HEIGHT          = 16.67
       WIDTH           = 131
       HIDDEN          = no
       SENSITIVE       = yes.

PROCEDURE adm-create-controls:
      ChTreeview:NAME = "ChTreeview":U .
/* ChTreeview OCXINFO:CREATE-CONTROL from: {6C00BE45-F188-11D2-8CE6-00A0D21A0A6B} type: TreeView4GL */
      ChTreeview:MOVE-AFTER(v-unidad:HANDLE IN FRAME F-Main).

END PROCEDURE.

&ENDIF

&ANALYZE-RESUME /* End of _CREATE-DYNAMIC */


/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Mantenimiento de Estructuras Recursivas */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Mantenimiento de Estructuras Recursivas */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */


  RUN verificar_txn ( OUTPUT txn_activa ).
  IF NOT txn_activa
  THEN DO: 
        APPLY "CLOSE":U TO THIS-PROCEDURE.
  END.

  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_addnodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_addnodo W-Win
ON CHOOSE OF btn_addnodo IN FRAME F-Main /* Nueva Fórmula */
DO:
  
  DEFINE VARIABLE a               AS CHARACTER.
  DEFINE VARIABLE NodeDesc        AS CHARACTER NO-UNDO.
  DEFINE VARIABLE thelevel        AS CHARACTER NO-UNDO.
  DEFINE VARIABLE SelectedNode    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE n               AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j               AS INTEGER   NO-UNDO.
  DEFINE VARIABLE l               AS INTEGER   NO-UNDO.
  DEFINE VARIABLE v-item          AS CHARACTER NO-UNDO.

  /*
  IF NOT AVAILABLE Area THEN APPLY "OCX.OnChanged" TO ChTreeview.
  IF Area.cdg_reporta <> ""
      THEN Area.cdg_reporta + "." + v-nueitem
      ELSE v-nueitem
  */
  IF AVAILABLE Area
  THEN DO:
      
      RUN d-datos_nuevarea.w ( INPUT Area.cdg_reporta, 
                               INPUT Area.cdg_empresa,
                               OUTPUT v-nueitem, 
                               OUTPUT v-nuedesc, 
                               OUTPUT puso_ok ).  
      IF puso_ok      
      THEN DO:
          DO TRANSACTION:
               CREATE B-Area.
               BUFFER-COPY Area TO B-Area
                           ASSIGN B-Area.cdg_area = v-nueitem
                                  B-Area.denominacion = v-nuedesc
                                  B-Area.nro_area = NEXT-VALUE(proxima_area).
          END.                   
          
          a = chChTreeview:TreeView4GL:GetSelectedNode().
          SelectedNode = int( entry(1, A, chr(1)) ).
          NodeDesc = entry(3, a, chr(1) ).         /* Full description of Node */
          Thelevel =   entry(1, NodeDesc, "~t" ).
          chChTreeview:TreeView4GL:addafterNode(
                                            SelectedNode, 
                                            TheLevel
                                            + "~t"
                                            + B-Area.denominacion
                                            + "~t0~t1~t~t" + "Accion=sindefinir.r|" + B-Area.cdg_area).
    
      END.
  END.
  ELSE DO:
        MESSAGE "Seleccione un nodo del árbol" VIEW-AS ALERT-BOX MESSAGE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_addsubnivel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_addsubnivel W-Win
ON CHOOSE OF btn_addsubnivel IN FRAME F-Main /* Nueva Sub Fórmula */
DO:
  
  DEFINE VARIABLE a               AS CHARACTER.
  DEFINE VARIABLE NodeDesc        AS CHARACTER NO-UNDO.
  DEFINE VARIABLE thelevel        AS CHARACTER NO-UNDO.
  DEFINE VARIABLE SelectedNode    AS INTEGER   NO-UNDO.
  DEFINE VARIABLE n               AS INTEGER   NO-UNDO.
  DEFINE VARIABLE j               AS INTEGER   NO-UNDO.
  DEFINE VARIABLE l               AS INTEGER   NO-UNDO.
  DEFINE VARIABLE v-item          AS CHARACTER NO-UNDO.

  /*
  IF NOT AVAILABLE Area THEN APPLY "OCX.OnChanged" TO ChTreeview.
  */
  IF AVAILABLE Area
  THEN DO:

      RUN d-datos_nuevarea.w ( INPUT Area.cdg_reporta, 
                               INPUT Area.cdg_empresa,
                               OUTPUT v-nueitem, 
                               OUTPUT v-nuedesc, 
                               OUTPUT puso_ok ).  
      IF puso_ok      
      THEN DO:
          DO TRANSACTION:
           CREATE B-Area.
           ASSIGN B-Area.cdg_empresa  = Area.cdg_empresa
                  B-Area.cdg_area     = v-nueitem
                  B-Area.cdg_reporta  = Area.cdg_area
                  B-Area.denominacion = v-nuedesc
                  B-Area.nro_area     = NEXT-VALUE(proxima_area).
             /*   B-Area.visible      = YES. */
                            
          END.                   
          
          a = chChTreeview:TreeView4GL:GetSelectedNode().
          SelectedNode = int( entry(1, A, chr(1)) ).
          NodeDesc = entry(2, a, chr(1) ).         /* Full description of Node */
          Thelevel =   STRING(INT(entry(1, NodeDesc, "~t" )) + 1).  
          chChTreeview:TreeView4GL:addafterNode(
                                              SelectedNode, 
                                              TheLevel
                                              + "~t"
                                              + v-nuedesc
                                              + "~t0~t1~t~t" + "Accion=sindefinir.r|" + B-Area.cdg_area).
      END.
  END.
  ELSE DO:
        MESSAGE "Seleccione un nodo del árbol" VIEW-AS ALERT-BOX MESSAGE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_cambiar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_cambiar W-Win
ON CHOOSE OF btn_cambiar IN FRAME F-Main /* Cambiar Empresa */
DO:
  /*----------------------------------------------------------
  DEFINE VARIABLE i     AS CHARACTER NO-UNDO.
  DEFINE VARIABLE hNode AS INTEGER   NO-UNDO.

  i = chChTreeview:TreeView4GL:GetSelectedNode().
  hNode = INTEGER(ENTRY(2, i, CHR(1))).
  
  chChTreeview:TreeView4GL:Expanded( hNode ) = 
                NOT chChTreeview:TreeView4GL:Expanded( hNode ).
  -------------------------------------------------------------*/
  
  RUN c-cambioempresa.w.
  RUN dispatch IN THIS-PROCEDURE ('initialize':U).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_deletenode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_deletenode W-Win
ON CHOOSE OF btn_deletenode IN FRAME F-Main /* Eliminar Fórmula */
DO:

  DEFINE VARIABLE a AS CHARACTER.
  DEFINE VARIABLE sino AS LOGICAL.

  sino = NO.
  MESSAGE "Desea eliminar este nodo" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino .
  IF sino
  THEN DO:
      a = chChTreeview:TreeView4GL:GetSelectedNode().
      chChTreeview:TreeView4GL:DeleteNode(INTEGER(ENTRY(1, a, CHR(1)))).
      DO TRANSACTION:
         FIND Area WHERE Area.cdg_area = GetCodigo(a) 
                     AND Area.cdg_empresa = que_empresa
                         EXCLUSIVE-LOCK.
         DELETE Area.
      END.
      RUN cargar_area.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Done
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Done W-Win
ON CHOOSE OF Btn_Done IN FRAME F-Main /* Salir */
DO:
  &IF DEFINED (adm-panel) <> 0 &THEN
      RUN dispatch IN THIS-PROCEDURE ('exit').
  &ELSE
      APPLY "CLOSE":U TO THIS-PROCEDURE.
  &ENDIF
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_exportar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_exportar W-Win
ON CHOOSE OF btn_exportar IN FRAME F-Main /* Export */
DO:
    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Exportar al archivo..."
        SAVE-AS
        ASK-OVERWRITE
        CREATE-TEST-FILE
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
         RUN exportar_rama ( INPUT aux_archivo ).
         MESSAGE "Exportación terminada" VIEW-AS ALERT-BOX MESSAGE.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_exportar-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_exportar-2 W-Win
ON CHOOSE OF btn_exportar-2 IN FRAME F-Main /* Exportar Sector */
DO:
    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Exportar al archivo..."
        SAVE-AS
        ASK-OVERWRITE
        CREATE-TEST-FILE
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
         RUN exportar_Area ( INPUT aux_archivo ).
         MESSAGE "Exportación terminada" VIEW-AS ALERT-BOX MESSAGE.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_importar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_importar W-Win
ON CHOOSE OF btn_importar IN FRAME F-Main /* Import */
DO:

    DEFINE VARIABLE nue_empresa LIKE Empresa.cdg_empresa.
    DEFINE VARIABLE modo_importa AS CHARACTER.
    SYSTEM-DIALOG GET-FILE aux_archivo
        TITLE      "Importar Area desde el archivo..."
        MUST-EXIST
        USE-FILENAME
        UPDATE puso_ok.

    IF puso_ok
    THEN DO:
         RUN d-que_empresa.w ( OUTPUT nue_empresa, OUTPUT modo_importa ).
         IF nue_empresa <> ?
         THEN DO:
              RUN importar_Area ( INPUT aux_archivo, INPUT nue_empresa, INPUT modo_importa ).
              MESSAGE "Importación terminada" VIEW-AS ALERT-BOX MESSAGE.
         END.     
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_refrescar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_refrescar W-Win
ON CHOOSE OF btn_refrescar IN FRAME F-Main /* Refrescar */
DO:
  RUN cargar_formula.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_vertodo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_vertodo W-Win
ON CHOOSE OF btn_vertodo IN FRAME F-Main /* Ver Todo */
DO:
def var i     as int  no-undo.
def var a     as char no-undo.

def var hNode as int no-undo.
 
  /* Set the REFRESH MODE TO FALSE
     ===========================*/
      
  chChTreeview:TreeView4GL:TreeRefresh = false.
  
    do i = 1 to chChTreeview:TreeView4GL:ChildrenNumber(0) :
        a =  chChTreeview:TreeView4GL:GetNode( I - 1).  /* Rel to 0 */
        
        hNode = int(entry(2, a, chr(1))).       /* Get the node handle */
        
        If Not chChTreeview:TreeView4GL:Expanded( hNode ) then
                chChTreeview:TreeView4GL:Expanded( hNode ) = true.      
        end.

  /* Set the REFRESH MODE TO TRUE
     ==========================*/
             
   chChTreeview:TreeView4GL:TreeRefresh = true.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ChTreeview
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ChTreeview W-Win OCX.OnChange
PROCEDURE ChTreeview.TreeView4GL.OnChange .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Required for OCX.
    NodeInfo
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-NodeInfo AS CHARACTER NO-UNDO.
 
  DEFINE VARIABLE v-item AS CHARACTER.
  DEFINE VARIABLE p      AS INTEGER.
 
  v-item = GetCodigo(p-NodeInfo).
  IF v-item <> "" /* Si existe el string Accion en la información del nodo ....*/
  THEN DO:
       FIND Formula_articulo 
           WHERE Formula_articulo.nro_art_compuesto  = INTEGER(ENTRY(1,v-item))
             AND Formula_articulo.nro_art_componente = INTEGER(ENTRY(2,v-item))
                       NO-LOCK.
       RUN posicionar_query IN h_q-formula_articulo ( INPUT ROWID(Formula_articulo)).
       RETURN NO-APPLY.  
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ChTreeview W-Win OCX.OnCollapsed
PROCEDURE ChTreeview.TreeView4GL.OnCollapsed .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Required for OCX.
    NodeInfo
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER p-NodeInfo AS CHARACTER NO-UNDO.

/* Here you can add your instructions in case of an node Collapse
   event
   */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ChTreeview W-Win OCX.OnDblClick
PROCEDURE ChTreeview.TreeView4GL.OnDblClick .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  None required for OCX.
  Notes:       
------------------------------------------------------------------------------*/
/*
    RUN ejecutar (chChTreeview:TreeView4GL:GetSelectedNode()).
    RETURN NO-APPLY.  
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ChTreeview W-Win OCX.OnExpanded
PROCEDURE ChTreeview.TreeView4GL.OnExpanded .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Required for OCX.
    NodeInfo
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER p-NodeInfo AS CHARACTER NO-UNDO.

/*
 *          Sample code to illustrate an icon change
 *          after 'Expanded event'
 *
 *          You should do the same in OnCollapsed event.
 *
 * Def var NodeNumber  as int  NO-UNDO.
 * 
 * NodeNumber =  int( entry(1, P-NodeInfo, chr(1)) ).
 * p-NodeInfo = entry(3, p-Nodeinfo, chr(1)).
 * 
 * /* Icon replace
 *    ==========*/
 *    
 * entry(3, p-NodeInfo, "~t") = "20".
 *    
 * chChTreeview:TreeView4GL:ChangeNode( NodeNumber, p-NodeInfo).*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ChTreeview W-Win OCX.OnKeyPress
PROCEDURE ChTreeview.TreeView4GL.OnKeyPress .
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  Required for OCX.
    Key
  Notes:       
------------------------------------------------------------------------------*/

DEFINE INPUT-OUTPUT PARAMETER p-Key AS INTEGER NO-UNDO.

IF p-key = 13
THEN DO:
    RUN ejecutar (chChTreeview:TreeView4GL:GetSelectedNode()).
END.
ELSE DO:
    BELL.
    RETURN NO-APPLY.
END.    

/*
dChar:screen-value in frame {&FRAME-NAME} = 
           "CTRL-" + chr(p-Key + asc("a") - 1).

 message p-key view-as alert-box. 
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_articulo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo W-Win
ON MOUSE-SELECT-DBLCLICK OF v-cdg_articulo IN FRAME F-Main /* Componente */
OR "." OF v-cdg_articulo IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_articulo IN FRAME {&FRAME-NAME}
DO:
  
  DEFINE VARIABLE rid_tabla AS ROWID.
  
  RUN selartic.p ( INPUT-OUTPUT rid_tabla, "P",
                   INPUT YES).
  IF rid_tabla <> ?
  THEN DO:
       FIND Articulo WHERE ROWID(Articulo) = rid_tabla NO-LOCK.
       DISPLAY Articulo.cdg_articulo @ v-cdg_articulo
               WITH  FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.
  END.       
  RETURN NO-APPLY.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_articulo W-Win
ON RETURN OF v-cdg_articulo IN FRAME F-Main /* Componente */
DO:
   {traducetabla.i "Articulo" "cdg_articulo" "descripcion"}   
   RUN cargar_formula.
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
             INPUT  'v-formula_articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Layout = ':U ,
             OUTPUT h_v-formula_articulo ).
       RUN set-position IN h_v-formula_articulo ( 20.05 , 2.00 ) NO-ERROR.
       /* Size in UIB:  ( 5.71 , 104.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'p-soloedita.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  'Edge-Pixels = 2,
                     SmartPanelType = Update-Trans,
                     AddFunction = One-Record':U ,
             OUTPUT h_p-soloedita ).
       RUN set-position IN h_p-soloedita ( 20.05 , 107.00 ) NO-ERROR.
       RUN set-size IN h_p-soloedita ( 5.71 , 26.00 ) NO-ERROR.

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-articulo ).
       RUN set-position IN h_q-articulo ( 1.48 , 44.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.19 , 7.00 ) */

       RUN init-object IN THIS-PROCEDURE (
             INPUT  'q-formula_articulo.w':U ,
             INPUT  FRAME F-Main:HANDLE ,
             INPUT  '':U ,
             OUTPUT h_q-formula_articulo ).
       RUN set-position IN h_q-formula_articulo ( 1.48 , 46.00 ) NO-ERROR.
       /* Size in UIB:  ( 1.38 , 8.00 ) */

       /* Links to SmartViewer h_v-formula_articulo. */
       RUN add-link IN adm-broker-hdl ( h_p-soloedita , 'TableIO':U , h_v-formula_articulo ).
       RUN add-link IN adm-broker-hdl ( h_q-formula_articulo , 'Record':U , h_v-formula_articulo ).

       /* Links to SmartQuery h_q-formula_articulo. */
       RUN add-link IN adm-broker-hdl ( h_q-articulo , 'Record':U , h_q-formula_articulo ).

       /* Adjust the tab order of the smart objects. */
       RUN adjust-tab-order IN adm-broker-hdl ( h_v-formula_articulo ,
             btn_exportar-2:HANDLE IN FRAME F-Main , 'AFTER':U ).
       RUN adjust-tab-order IN adm-broker-hdl ( h_p-soloedita ,
             h_v-formula_articulo , 'AFTER':U ).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_formula W-Win 
PROCEDURE cargar_formula :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEFINE VARIABLE a               AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i               AS INTEGER.

  DEFINE BUFFER B-Componente FOR Articulo.

  chChTreeview:TreeView4GL:TreeRefresh = FALSE.  /* Desactivamos el refresh de pantalla */
 
  {findempresa.i}
   
  a = "". /* Borramos el STRING que contiene el arbol y lo armamos en base al contenido de la tabla */

  FOR EACH Formula_articulo WHERE Formula_articulo.nro_art_compuesto = Articulo.nro_articulo:

      FIND B-Componente WHERE B-Componente.nro_articulo = Formula_articulo.nro_art_componente NO-LOCK. 
      a = a  + "~n0~t" + B-Componente.descripcion + "~t0~t1~t~tAccion=|" + 
          STRING(Formula_articulo.nro_art_compuesto,">>>>>>>>>9") + "," + 
          STRING(Formula_articulo.nro_art_componente,">>>>>>>>>9").
      RUN cargar_hijos ( INPUT-OUTPUT a, INPUT Formula_articulo.nro_art_componente, INPUT 1).

  END.

  a = SUBSTRING(a, 2). /* Eliminamos el primer caracter especial "~n" */
  chChTreeview:TreeView4GL:clear(). /* Borramos el contenido del arbol */
  chChTreeview:TreeView4GL:addnodes(A). /* Asignamos el nuevo contenido */
  chChTreeview:TreeView4GL:TreeRefresh = TRUE.  /* Activamos el refresh de pantalla para visualizar el arbol */
   
  APPLY "ENTRY" to ChTreeview.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_hijos W-Win 
PROCEDURE cargar_hijos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT-OUTPUT PARAMETER a           AS CHARACTER.
  DEFINE INPUT PARAMETER p-nro_articulo     LIKE Formula_articulo.nro_art_componente.
  DEFINE INPUT PARAMETER p-nivel            AS INTEGER.
  
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE j-funcion          AS INTEGER.
  DEFINE VARIABLE tiene_permiso      AS LOGICAL.

  DEFINE BUFFER B-Formula_articulo FOR Formula_articulo.
  DEFINE BUFFER B-Componente FOR Articulo.
  
  
  {findempresa.i}

  FOR EACH Formula_articulo 
      WHERE Formula_articulo.nro_art_compuesto = p-nro_articulo:

      IF CAN-FIND(FIRST B-Formula_articulo 
                  WHERE B-Formula_articulo.nro_art_compuesto = B-Formula_articulo.nro_art_compuesto) 
      THEN DO:
          FIND B-Componente WHERE B-Componente.nro_articulo = Formula_articulo.nro_art_componente NO-LOCK. 
          a = a  + "~n" + STRING(p-nivel,">9") + "~t" + B-Componente.descripcion + "~t0~t1~t~t" + 
                     "Accion=" + STRING(Formula_articulo.nro_art_compuesto,">>>>>>>>>9") + "|" + 
                                 STRING(Formula_articulo.nro_art_componente,">>>>>>>>>9").
          RUN cargar_hijos ( INPUT-OUTPUT a, INPUT Formula_articulo.nro_art_componente, INPUT p-nivel + 1).
      END.
      ELSE DO:
          a = a  + "~n" + STRING(p-nivel,">9") + "~t" + B-Componente.descripcion + "~t0~t1~t~t" + 
                     "Accion=" + STRING(Formula_articulo.nro_art_compuesto,">>>>>>>>>9") + "|" + 
                                 STRING(Formula_articulo.nro_art_componente,">>>>>>>>>9").
      END.
             
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE control_load W-Win  _CONTROL-LOAD
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

OCXFile = SEARCH( "w-tree_formulas.wrx":U ).
IF OCXFile = ? THEN
  OCXFile = SEARCH(SUBSTRING(THIS-PROCEDURE:FILE-NAME, 1,
                     R-INDEX(THIS-PROCEDURE:FILE-NAME, ".":U), "CHARACTER":U) + "wrx":U).

IF OCXFile <> ? THEN
DO:
  ASSIGN
    chChTreeview = ChTreeview:COM-HANDLE
    UIB_S = chChTreeview:LoadControls( OCXFile, "ChTreeview":U)
  .
  RUN DISPATCH IN THIS-PROCEDURE("initialize-controls":U) NO-ERROR.
END.
ELSE MESSAGE "w-tree_formulas.wrx":U SKIP(1)
             "The binary control file could not be found. The controls cannot be loaded."
             VIEW-AS ALERT-BOX TITLE "Controls Not Loaded".

&ENDIF

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
  DISPLAY v-cdg_articulo v-dsc_articulo v-unidad 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE Btn_Done btn_cambiar btn_vertodo v-cdg_articulo btn_addnodo 
         btn_addsubnivel btn_deletenode btn_refrescar btn_exportar btn_importar 
         btn_exportar-2 RECT-1 RECT-2 RECT-4 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exportar_menu W-Win 
PROCEDURE exportar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER a-salida AS CHARACTER.

  OUTPUT TO VALUE(a-salida) PAGE-SIZE 0.
  FOR EACH Area WHERE Area.cdg_empresa = que_empresa:
      EXPORT Delimiter "@" Area.
  END.
  OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exportar_rama W-Win 
PROCEDURE exportar_rama :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER a-salida AS CHARACTER.

  OUTPUT TO VALUE(a-salida) PAGE-SIZE 0.
  EXPORT Delimiter "@" Area.
  FOR EACH B-Area NO-LOCK 
      WHERE B-Area.cdg_reporta BEGINS Area.cdg_area 
        AND B-Area.cdg_empresa = Area.cdg_empresa
            BY B-Area.cdg_area:

      EXPORT Delimiter "@" B-Area.
  
  END.
  OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE importar_menu W-Win 
PROCEDURE importar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER a-entrada    AS CHARACTER.
  DEFINE INPUT PARAMETER nue_empresa  AS CHARACTER.
  DEFINE INPUT PARAMETER modo_bajada  AS CHARACTER.

  INPUT FROM VALUE(a-entrada) PAGE-SIZE 0.
  REPEAT:
      CREATE T-Area.
      IMPORT Delimiter "@" T-Area.
  END.
  INPUT CLOSE.

  IF modo_bajada = "reemplazar"
  THEN DO:
       FOR EACH Area WHERE Area.cdg_empresa = nue_empresa:
           DELETE Area.
       END.    
  END.
      
  FOR EACH T-Area:

      CASE modo_bajada:

           WHEN "reemplazar"
           THEN DO:
                CREATE Area.
                BUFFER-COPY T-Area TO Area 
                            ASSIGN Area.cdg_empresa = nue_empresa.
           END.

           WHEN "actualizar"
           THEN DO:
                FIND Area WHERE Area.cdg_empresa = nue_empresa
                            AND Area.cdg_area    = T-Area.cdg_area EXCLUSIVE-LOCK NO-ERROR.
                IF NOT AVAILABLE Area THEN CREATE Area.            
                BUFFER-COPY T-Area TO Area 
                            ASSIGN Area.cdg_empresa = nue_empresa.
           END.
           WHEN "agregar"
           THEN DO:
                FIND Area WHERE Area.cdg_empresa = nue_empresa
                            AND Area.cdg_area    = T-Area.cdg_area EXCLUSIVE-LOCK NO-ERROR.
                IF NOT AVAILABLE Area 
                THEN DO:
                     CREATE Area.            
                     BUFFER-COPY T-Area TO Area 
                                 ASSIGN Area.cdg_empresa = nue_empresa.
                END.
           END.
   
      END CASE.     

      DELETE T-Area.

  END.

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

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.

   chChTreeview:TreeView4GL:Lines = YES.
   chChTreeview:TreeView4GL:Buttons = YES.

   /*
   FIND articulo WHERE cdg_articulo = "PP-BICICL-26" NO-LOCK.
   RUN cargar_formula.
   */

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

  {setwintit.i "SIC/UTL" "Mantenimiento de Menúes"}

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE set-estado-folders W-Win 
PROCEDURE set-estado-folders :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-operacion AS CHARACTER.

    DEFINE VARIABLE folder-labels AS CHARACTER.
    DEFINE VARIABLE page-hdl      AS CHARACTER.
    DEFINE VARIABLE j-pagina      AS INTEGER.
/*
    RUN get-attribute IN h_folder ('FOLDER-LABELS':U).
    ASSIGN folder-labels   = IF RETURN-VALUE = ? THEN "":U
                             ELSE RETURN-VALUE.

    RUN get-link-handle IN adm-broker-hdl
                      (THIS-PROCEDURE, 'PAGE-TARGET',OUTPUT page-hdl).


    DO j-pagina = 1 TO NUM-ENTRIES(folder-labels,'|':U):                             

       IF p-operacion = "HABILITAR"
          THEN RUN enable-folder-page  IN h_folder (j-pagina).
          ELSE RUN disable-folder-page IN h_folder (j-pagina).

    END.
*/
    DO WITH FRAME {&FRAME-NAME}:
        btn_addnodo:SENSITIVE = p-operacion = "HABILITAR". 
        btn_addsubnivel:SENSITIVE = p-operacion = "HABILITAR". 
        btn_cambiar:SENSITIVE = p-operacion = "HABILITAR". 
        btn_deletenode:SENSITIVE = p-operacion = "HABILITAR". 
        Btn_Done:SENSITIVE = p-operacion = "HABILITAR". 
        btn_exportar:SENSITIVE = p-operacion = "HABILITAR". 
        btn_exportar-2:SENSITIVE = p-operacion = "HABILITAR". 
        btn_importar:SENSITIVE = p-operacion = "HABILITAR". 
        btn_refrescar:SENSITIVE = p-operacion = "HABILITAR". 
        btn_vertodo:SENSITIVE = p-operacion = "HABILITAR". 
        ChTreeview:SENSITIVE = p-operacion = "HABILITAR".
    END.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION GetCodigo W-Win 
FUNCTION GetCodigo RETURNS CHARACTER
  (   INPUT p-NodeInfo AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
 
  DEFINE VARIABLE v-item AS CHARACTER.
  DEFINE VARIABLE p      AS INTEGER.

  p = INDEX(p-NodeInfo,"Accion").
  IF p <> 0 /* Si existe el string Accion en la información del nodo ....*/
  THEN DO:
       v-item = ENTRY(2,SUBSTRING(p-NodeInfo,p),"|"). /* Tomamos lo que está a la derecha de "|", que es el codigo de item */
  END.
  ELSE DO:
       v-item = "".
  END.

  RETURN v-item.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

