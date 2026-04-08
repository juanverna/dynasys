&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
*/
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
DEFINE TEMP-TABLE tt
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD nro_cliente LIKE cliente.nro_cliente
    FIELD direccion LIKE cliente.direccion
    FIELD nro_administrador  LIKE Cliente.nro_administrador
    FIELD cdg_admin LIKE cliente.cdg_cliente
    FIELD nombre_administrador LIKE cliente.nom_cliente
    FIELD Nombre LIKE persona.nombre
    FIELD Telefono-1 AS CHAR FORMAT "X(25)"
    FIELD Telefono-2 AS CHAR FORMAT "X(25)"
    FIELD pisos LIKE Cliente_otros_datos.pisos
    FIELD unidades LIKE cliente_otros.unidades
    FIELD mes AS CHAR.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME BROWSE-2

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tt

/* Definitions for BROWSE BROWSE-2                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-2 tt.cdg_admin tt.nombre_administrador tt.cdg_cliente tt.direccion tt.mes tt.Nombre tt.telefono-1 tt.telefono-2 tt.pisos tt.unidades   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-2   
&Scoped-define SELF-NAME BROWSE-2
&Scoped-define QUERY-STRING-BROWSE-2 FOR EACH tt BY cdg_admin BY nro_cliente
&Scoped-define OPEN-QUERY-BROWSE-2 OPEN QUERY {&SELF-NAME} FOR EACH tt BY cdg_admin BY nro_cliente.
&Scoped-define TABLES-IN-QUERY-BROWSE-2 tt
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-2 tt


/* Definitions for FRAME F-Main                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-F-Main ~
    ~{&OPEN-QUERY-BROWSE-2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BUTTON-8 BUTTON-9 c_nro_tipo_evento ~
dsc_tipo_evento v-mes v-ano Terrores cdg_cargo BROWSE-2 
&Scoped-Define DISPLAYED-OBJECTS c_nro_tipo_evento dsc_tipo_evento v-mes ~
v-ano Terrores cdg_cargo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-8 
     IMAGE-UP FILE "img/excel.gif":U
     LABEL "Button 8" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-9 
     LABEL "Buscar" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE cdg_cargo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Rel" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Item 1","Item 1"
     DROP-DOWN-LIST
     SIZE 23 BY 1 NO-UNDO.

DEFINE VARIABLE c_nro_tipo_evento AS INTEGER FORMAT ">>>>>>>>9" INITIAL 1 
     LABEL "Tipo" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "0",1
     DROP-DOWN-LIST
     SIZE 10.2 BY 1 TOOLTIP "Tipo de Restriccion o Tipo de Evento".

DEFINE VARIABLE dsc_tipo_evento AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 22.2 BY 1 NO-UNDO.

DEFINE VARIABLE v-ano AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1 NO-UNDO.

DEFINE VARIABLE v-mes AS INTEGER FORMAT ">9":U INITIAL 0 
     LABEL "Periodo" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1 NO-UNDO.

DEFINE VARIABLE Terrores AS LOGICAL INITIAL no 
     LABEL "Solo Errores" 
     VIEW-AS TOGGLE-BOX
     SIZE 19 BY .81 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-2 FOR 
      tt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-2 W-Win _FREEFORM
  QUERY BROWSE-2 DISPLAY
      tt.cdg_admin
  tt.nombre_administrador
  tt.cdg_cliente         
  tt.direccion           
  tt.mes COLUMN-LABEL "M"    
  tt.Nombre     
  tt.telefono-1
  tt.telefono-2
  tt.pisos
  tt.unidades
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 148 BY 14.76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     BUTTON-8 AT ROW 1.33 COL 68.4 WIDGET-ID 6
     BUTTON-9 AT ROW 1.33 COL 84.8 WIDGET-ID 80
     c_nro_tipo_evento AT ROW 1.48 COL 6 COLON-ALIGNED WIDGET-ID 78
     dsc_tipo_evento AT ROW 1.48 COL 15.6 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     v-mes AT ROW 1.48 COL 48.8 COLON-ALIGNED WIDGET-ID 4
     v-ano AT ROW 1.48 COL 56.8 COLON-ALIGNED WIDGET-ID 2
     Terrores AT ROW 1.48 COL 105 WIDGET-ID 82
     cdg_cargo AT ROW 1.48 COL 126 COLON-ALIGNED WIDGET-ID 84
     BROWSE-2 AT ROW 2.91 COL 3 WIDGET-ID 200
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 155.2 BY 17 WIDGET-ID 100.


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
         TITLE              = "Busqueda de datos en Agenda"
         HEIGHT             = 17
         WIDTH              = 152.4
         MAX-HEIGHT         = 33.38
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 33.38
         VIRTUAL-WIDTH      = 256
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
/* BROWSE-TAB BROWSE-2 cdg_cargo F-Main */
ASSIGN 
       BROWSE-2:MAX-DATA-GUESS IN FRAME F-Main         = 1000.

ASSIGN 
       dsc_tipo_evento:READ-ONLY IN FRAME F-Main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-2
/* Query rebuild information for BROWSE BROWSE-2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tt BY cdg_admin BY nro_cliente.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* Busqueda de datos en Agenda */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* Busqueda de datos en Agenda */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-8 W-Win
ON CHOOSE OF BUTTON-8 IN FRAME F-Main /* Button 8 */
DO:
 
  run excel-export (browse-2:handle).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-9 W-Win
ON CHOOSE OF BUTTON-9 IN FRAME F-Main /* Buscar */
DO:
  RUN creatt.
  {&OPEN-QUERY-{&BROWSE-NAME}}
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


&Scoped-define BROWSE-NAME BROWSE-2
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE creatt W-Win 
PROCEDURE creatt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DEFINE BUFFER extevento FOR evento.
  DEFINE BUFFER bevento FOR evento.
  DEF VAR i AS INT NO-UNDO.
  DEF VAR k AS INT NO-UNDO.
  DEF VAR ddd AS DATE NO-UNDO.
  DEF VAR hhh AS DATE NO-UNDO.
  DEF VAR j AS DATE NO-UNDO.
  DEFINE VAR pridia AS DATE NO-UNDO.
  DEFINE VAR ultdia AS DATE NO-UNDO.
  DEFINE VAR ecreados AS INT NO-UNDO.
  DEFINE VAR OPRDDTA AS INT NO-UNDO.
  DEFINE VARIABLE v-transcurridos           AS INTEGER    NO-UNDO.
  DEFINE VARIABLE v-ciclo_facturacion       AS INTEGER    NO-UNDO.
  DEFINE VAR nplan AS INTEGER NO-UNDO.
  DEFINE VAR pperiodo AS INTEGER NO-UNDO.
  DEFINE BUFFER administrador FOR cliente.
  ASSIGN FRAME {&FRAME-NAME} v-mes v-ano c_nro_tipo_evento.
  DEFINE VAR almenos AS LOGICAL NO-UNDO.
  DEFINE VAR ptel1 AS CHAR NO-UNDO.
  DEFINE VAR ptel2 AS CHAR NO-UNDO.

   ASSIGN v-mes v-ano c_nro_tipo_evento terrores cdg_cargo.
 pperiodo = v-ano * 100 + v-mes.
 pridia = DATE(v-mes,1,v-ano).
 ultdia = pridia + 32.
 ultdia = DATE(MONTH(ultdia),1,YEAR(ultdia)) - 1.

  j  = DATE(v-mes,1,v-ano).
  ddd = DATE(v-mes,1,v-ano).
  hhh = DATE( MONTH(ddd + 32 ), 1 , YEAR( ddd + 32 ) ) - 1 .
  EMPTY TEMP-TABLE tt.
  ecreados = 0.  
  RUN getparametro_n.p ( "OPRDDTA" , OUTPUT OPRDDTA ).
  FOR EACH contrato_hd NO-LOCK WHERE contrato_hd.estado = "A" AND 
      contrato_hd.rige_hasta >= ddd AND
      contrato_hd.rige_desde <= hhh AND
      ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 )
      AND contrato_hd.primer_ano * 100 + contrato_hd.primer_mes  <= pperiodo and 
      not Contrato_hd.anulado and  ( contrato_hd.fecha_baja = ? OR year(contrato_hd.fecha_baja) * 100 + MONTH(contrato_hd.fecha_baja) > pperiodo ):
      IF contrato_hd.nro_tipo_evento <> c_nro_tipo_evento THEN NEXT.
      v-ciclo_facturacion = INTEGER(Contrato_hd.modo_facturacion).
      v-transcurridos = ( year(j) - Contrato_hd.primer_ano ) * 12 + 
                        ( month(j) - Contrato_hd.primer_mes ).
      FIND FIRST cliente NO-LOCK OF contrato_hd.
      FIND contrato_dt NO-LOCK OF contrato_hd NO-ERROR.
      FIND FIRST cliente_otros OF cliente NO-LOCK NO-ERROR.
      FIND FIRST administrador NO-LOCK WHERE administrador.nro_cliente = cliente.nro_administrador.
      FIND FIRST domicilio NO-LOCK OF cliente.
      almenos = FALSE.
      FOR EACH cliente-contacto OF domicilio WHERE Cliente-contacto.cdg_cargo = cdg_cargo,
        FIRST Persona OF cliente-contacto NO-LOCK.
        ptel1 = "".
        ptel2 = "".
        DO i = 1 TO NUM-ENTRIES(persona.numeros_telefono,"|"):
           IF entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!") <> "" THEN DO:
               IF k = 0 THEN DO:
                  ptel1 = entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!").
                  k = 1.
               END.
               ELSE
                  ptel2 = entry(2,ENTRY(i,persona.numeros_telefono,"|"),"!").
           END.
        END.

        IF terrores AND index("0123456789-. " , substring( persona.nombre , 1 , 1 )) = 0 and ( LENGTH( ptel1 ) <> 0 OR LENGTH( ptel2 ) <> 0 ) THEN NEXT.
        
        CREATE tt.
        ASSIGN 
             almenos                = TRUE
             tt.cdg_cliente         = cliente.cdg_cliente
             tt.nro_cliente         = cliente.nro_cliente
             tt.direccion           = cliente.direccion
             tt.nro_administrador   = Cliente.nro_administrador
             tt.Nombre              = persona.nombre
             tt.telefono-1           = ptel1
             tt.telefono-2           = ptel2
             tt.unidades            = IF AVAILABLE cliente_otros THEN cliente_otros.unidades ELSE 0
             tt.pisos               = IF AVAILABLE cliente_otros THEN cliente_otros.pisos ELSE 0
             tt.cdg_admin           = administrador.cdg_cliente
             tt.nombre_administrador = administrador.nom_cliente
             tt.mes    = IF INTEGER(Contrato_hd.modo_facturacion) <= 1 THEN "M" ELSE IF contrato_hd.primer_mes MOD 2 = 0 THEN "P" ELSE "I".             
        k = 0.
        
      END.
      IF NOT almenos THEN DO:
            CREATE tt.
        ASSIGN 
             almenos                = TRUE
             tt.cdg_cliente         = cliente.cdg_cliente
             tt.nro_cliente         = cliente.nro_cliente
             tt.direccion           = cliente.direccion
             tt.nro_administrador   = Cliente.nro_administrador
             tt.Nombre              = ""
             tt.unidades            = IF AVAILABLE cliente_otros THEN cliente_otros.unidades ELSE 0
             tt.pisos               = IF AVAILABLE cliente_otros THEN cliente_otros.pisos ELSE 0
             tt.cdg_admin           = administrador.cdg_cliente
             tt.nombre_administrador = administrador.nom_cliente
             tt.mes    = IF INTEGER(Contrato_hd.modo_facturacion) <= 1 THEN "M" ELSE IF contrato_hd.primer_mes MOD 2 = 0 THEN "P" ELSE "I".             
      END.
  END.
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
  DISPLAY c_nro_tipo_evento dsc_tipo_evento v-mes v-ano Terrores cdg_cargo 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE BUTTON-8 BUTTON-9 c_nro_tipo_evento dsc_tipo_evento v-mes v-ano 
         Terrores cdg_cargo BROWSE-2 
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
DEFINE VAR lista AS CHAR NO-UNDO.
  
/* Code placed here will execute PRIOR to standard behavior. */
DO WITH FRAME {&FRAME-NAME}:
     {levantacombo.i &TABLA=Tipo_evento &NOMBRE=cdg_tipo_evento &CODIGO=nro_tipo_evento &OBJETO=c_nro_tipo_evento}
     {levantacombo.i &TABLA=Cargo_persona &NOMBRE=dsc_cargo &CODIGO=cdg_cargo &OBJETO=cdg_cargo}.
END.
dsc_tipo_evento = "Fumigacion".

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */
v-mes:SCREEN-VALUE = string(MONTH(TODAY),"99").
v-ano:SCREEN-VALUE = STRING(YEAR(TODAY)).
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

