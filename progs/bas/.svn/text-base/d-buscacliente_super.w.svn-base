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
/*almacena los rowid encontrados en clientes*/
{geolibrary.i}
DEFINE TEMP-TABLE tt
    FIELD rrow AS ROWID
    FIELD mot AS CHAR LABEL "PATRON" FORMAT "X(14)"
    FIELD orden AS INT
    INDEX rrow rrow.
    
DEFINE INPUT PARAM patron AS CHAR NO-UNDO.
DEFINE INPUT-OUTPUT PARAM SALIDA AS CHAR NO-UNDO.
DEFINE VARIABLE que_empresa LIKE Empresa.cdg_empresa.
DEFINE VARIABLE que_sector  LIKE Area.cdg_area.

DEFINE VAR v-calle AS CHAR NO-UNDO.
DEFINE VAR v-altura AS CHAR NO-UNDO.
DEFINE VAR v-refer AS CHAR NO-UNDO.
DEFINE VAR v-extra AS CHAR NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt cliente

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 tt.mot Cliente.cdg_cliente Cliente.nom_cliente Cliente.direccion Cliente.localidad Cliente.cuit   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH tt , ~
       FIRST cliente WHERE ROWID(cliente) = tt.rrow BY tt.orden
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH tt , ~
       FIRST cliente WHERE ROWID(cliente) = tt.rrow BY tt.orden.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 tt cliente
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 tt
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-2 cliente


/* Definitions for DIALOG-BOX D-Dialog                                  */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD crea_row D-Dialog 
FUNCTION crea_row RETURNS LOGICAL
  ( prow AS ROWID,pmot AS CHAR, porden AS INT )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      tt, 
      cliente SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 D-Dialog _FREEFORM
  QUERY BROWSE-2 DISPLAY
      tt.mot
      Cliente.cdg_cliente FORMAT "X(8)":U 
      Cliente.nom_cliente FORMAT "X(40)":U 
      Cliente.direccion COLUMN-LABEL "Direccion!Cliente" FORMAT "X(45)":U
            
      Cliente.localidad COLUMN-LABEL "Localidad!Cliente" FORMAT "X(20)":U
           
      Cliente.cuit FORMAT "X(15)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 148 BY 11.19 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     BROWSE-2 AT ROW 1 COL 1 WIDGET-ID 200
     SPACE(0.00) SKIP(0.09)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE BGCOLOR 11 "Buscador de clientes por patron" WIDGET-ID 100.


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
/* BROWSE-TAB BROWSE-2 1 D-Dialog */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

ASSIGN 
       BROWSE-2:COLUMN-RESIZABLE IN FRAME D-Dialog       = TRUE
       BROWSE-2:COLUMN-MOVABLE IN FRAME D-Dialog         = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt , FIRST cliente WHERE ROWID(cliente) = tt.rrow BY tt.orden.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Buscador de clientes por patron */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-2
&Scoped-define SELF-NAME BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 D-Dialog
ON MOUSE-SELECT-DBLCLICK OF BROWSE-2 IN FRAME D-Dialog
DO:
    IF AVAILABLE cliente THEN
        salida = cliente.cdg_cliente.
    ELSE salida = ?.

    APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-2 D-Dialog
ON ROW-DISPLAY OF BROWSE-2 IN FRAME D-Dialog
DO:
  IF cliente.cdg_estado = "I" THEN DO:
          cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 12.
  END.
  IF cliente.cdg_estado = "P" THEN DO:
          cliente.cdg_cliente:BGCOLOR IN BROWSE {&BROWSE-NAME} = 11.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */
RUN abrirpatron( patron ).
FIND FIRST tt NO-ERROR.
IF AVAILABLE tt THEN DO:
    {src/adm/template/dialogmn.i}
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE abrirpatron D-Dialog 
PROCEDURE abrirpatron :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAM ppatron AS CHAR NO-UNDO.
{findempresa.i}
que_empresa = Empresa.cdg_empresa.
{findsector.i}
que_sector = Area.cdg_area.
salida = ?.
DEFINE VAR bpatron AS CHAR no-undo.

RUN decodir(ppatron,OUTPUT v-calle, OUTPUT v-altura,OUTPUT v-refer,OUTPUT v-extra).
bpatron = v-calle + " " + v-altura.
bpatron = TRIM(bpatron).

FOR EACH Cliente WHERE Cliente.nom_cliente CONTAINS bpatron 
                                        AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                        NO-LOCK:
    crea_row(ROWID(cliente),"NOMBRE",2).
    
END.
FOR EACH Cliente WHERE Cliente.nom_fantasia CONTAINS bpatron 
                                        AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                        NO-LOCK:
    crea_row(ROWID(cliente),"FANTASIA",3).
    
END.
FOR EACH Cliente WHERE Cliente.direccion CONTAINS bpatron 
                                        AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                        NO-LOCK:
    crea_row(ROWID(cliente),"DIRECCION",1).
    
END.
FOR EACH Cliente WHERE Cliente.cuit CONTAINS bpatron 
                                        AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                        NO-LOCK:
    crea_row(ROWID(cliente),"CUIT",5).
    
END.
FOR EACH Cliente WHERE Cliente.cdg_cliente BEGINS bpatron 
                                        AND CAN-DO(Cliente.lista_empresas,que_empresa)
                                        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0
                                        NO-LOCK.
        crea_row(ROWID(cliente),"CODIGO",0).
    
END.
FIND contrato_hd WHERE nro_contrato = int(bpatron) NO-LOCK NO-ERROR.
IF AVAILABLE contrato_hd THEN DO:
    FIND cliente OF contrato_hd NO-LOCK.
         crea_row(ROWID(cliente),"CONTRATO",4).
END.


FIND FIRST tt NO-ERROR.
IF AVAILABLE tt THEN
DO:
    {&OPEN-QUERY-{&BROWSE-NAME}}
    FIND cliente WHERE cliente.cdg_cliente = salida NO-LOCK NO-ERROR.
    REPOSITION {&BROWSE-NAME} TO ROWID ROWID(cliente) NO-ERROR.
END.


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
  ENABLE BROWSE-2 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
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
  {src/adm/template/snd-list.i "tt"}
  {src/adm/template/snd-list.i "cliente"}

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

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION crea_row D-Dialog 
FUNCTION crea_row RETURNS LOGICAL
  ( prow AS ROWID,pmot AS CHAR, porden AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    FIND tt WHERE prow = tt.rrow NO-ERROR.
    IF NOT AVAILABLE tt THEN DO:
        CREATE tt.
        ASSIGN tt.rrow = prow.
    END.
    ASSIGN tt.mot = pmot
           tt.orden = porden.

/* ASSIGN  tt.mot = IF porden < tt.orden THEN pmot ELSE tt.mot
            tt.orden = IF porden < tt.orden THEN porden ELSE tt.orden. */
    RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

