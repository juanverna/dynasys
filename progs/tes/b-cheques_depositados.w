&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS B-table-Win 
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


  DEFINE VARIABLE que_empresa   LIKE Empresa.cdg_empresa.
  DEFINE VARIABLE fecha_inicial AS DATE.
  DEFINE VARIABLE fecha_elegida AS DATE.

  DEFINE VARIABLE sino          AS LOGICAL.
  DEFINE VARIABLE dire_tmp      AS CHARACTER.
  DEFINE VARIABLE que_estado    LIKE Cheque.estado.
  
  {parlocales.i}

  DEFINE BUFFER B-Caja FOR Caja.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartBrowser
&Scoped-define DB-AWARE no

&Scoped-define ADM-SUPPORTED-LINKS Record-Source,Record-Target,TableIO-Target

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main
&Scoped-define BROWSE-NAME br_table

/* External Tables                                                      */
&Scoped-define EXTERNAL-TABLES Cuenta_bancaria
&Scoped-define FIRST-EXTERNAL-TABLE Cuenta_bancaria


/* Need to scope the external tables to this procedure                  */
DEFINE QUERY external_tables FOR Cuenta_bancaria.
/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Cheque

/* Define KEY-PHRASE in case it is used by any query. */
&Scoped-define KEY-PHRASE TRUE

/* Definitions for BROWSE br_table                                      */
&Scoped-define FIELDS-IN-QUERY-br_table Cheque.fecha_deposito ~
Cheque.numero_cheque Cheque.fecha_acredita Cheque.fecha_emision ~
Cheque.importe Cheque.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_table 
&Scoped-define QUERY-STRING-br_table FOR EACH Cheque OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cheque.fecha_deposito <= v-has_fecha ~
 AND Cheque.fecha_deposito >= v-des_fecha ~
 AND Cheque.estado = que_estado NO-LOCK ~
    BY Cheque.fecha_deposito ~
       BY Cheque.numero_cheque INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_table OPEN QUERY br_table FOR EACH Cheque OF Cuenta_bancaria WHERE ~{&KEY-PHRASE} ~
      AND Cheque.fecha_deposito <= v-has_fecha ~
 AND Cheque.fecha_deposito >= v-des_fecha ~
 AND Cheque.estado = que_estado NO-LOCK ~
    BY Cheque.fecha_deposito ~
       BY Cheque.numero_cheque INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_table Cheque
&Scoped-define FIRST-TABLE-IN-QUERY-br_table Cheque


/* Definitions for FRAME F-Main                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-2 RECT-3 RECT-4 RECT-5 v-des_fecha ~
v-has_fecha v-fecha_acreditacion v-cantcheques v-totdeposito v-que_estado ~
btn_acreditar btn_rechazar btn_seltodos btn_desmarcar btn_verlog btn_listar ~
btn_comprobante br_table 
&Scoped-Define DISPLAYED-OBJECTS v-des_fecha v-has_fecha ~
v-fecha_acreditacion v-cantcheques v-totdeposito v-que_estado 

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
cdg_banco||y|sic.Valor.cdg_banco
cdg_caja||y|sic.Valor.cdg_caja
nro_transaccion||y|sic.Valor.nro_transaccion
nro_cliente||y|sic.Valor.nro_cliente
nro_cuenta||y|sic.Valor.nro_cuenta
cdg_cuenta_ban||y|sic.Valor.cdg_cuenta_ban
cdg_empresa||y|sic.Valor.cdg_empresa
nro_proveedor||y|sic.Valor.nro_proveedor
nro_recibo||y|sic.Valor.nro_recibo
num_sucursal||y|sic.Valor.num_sucursal
nro_titular-cob||y|sic.Valor.nro_titular-cob
nro_titular-pag||y|sic.Valor.nro_titular-pag
nro_valor||y|sic.Valor.nro_valor
</FOREIGN-KEYS> 
<EXECUTING-CODE>
**************************
* Set attributes related to FOREIGN KEYS
*/
RUN set-attribute-list (
    'Keys-Accepted = ,
     Keys-Supplied = "cdg_banco,cdg_caja,nro_transaccion,nro_cliente,nro_cuenta,cdg_cuenta_ban,cdg_empresa,nro_proveedor,nro_recibo,num_sucursal,nro_titular-cob,nro_titular-pag,nro_valor"':U).

/* Tell the ADM to use the OPEN-QUERY-CASES. */
&Scoped-define OPEN-QUERY-CASES RUN dispatch ('open-query-cases':U).
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


/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_acreditar 
     LABEL "&Acreditar" 
     SIZE 17 BY 1.14.

DEFINE BUTTON btn_comprobante 
     LABEL "Ver Valor" 
     SIZE 17 BY 1.14.

DEFINE BUTTON btn_desmarcar 
     LABEL "Desmarcar" 
     SIZE 17 BY 1.14.

DEFINE BUTTON btn_listar 
     LABEL "&Listar" 
     SIZE 17 BY 1.14.

DEFINE BUTTON btn_rechazar 
     LABEL "&Rechazar" 
     SIZE 17 BY 1.14.

DEFINE BUTTON btn_seltodos 
     LABEL "&Marcar" 
     SIZE 17 BY 1.14.

DEFINE BUTTON btn_verlog 
     LABEL "Ver Log" 
     SIZE 17 BY 1.14.

DEFINE VARIABLE v-que_estado AS CHARACTER FORMAT "X(256)":U 
     LABEL "Estado" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "En Circulacion","01",
                     "Acreditados","02",
                     "Rechazados","03"
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cantcheques AS INTEGER FORMAT ">>>9":U INITIAL 0 
     LABEL "Valores" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE VARIABLE v-des_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "Depósitos del" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-fecha_acreditacion AS DATE FORMAT "99/99/99":U 
     LABEL "Acreditación" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-has_fecha AS DATE FORMAT "99/99/99":U 
     LABEL "al" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 14 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE v-totdeposito AS DECIMAL FORMAT ">>,>>>,>>9.99":U INITIAL 0 
     LABEL "$" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 14 FGCOLOR 9 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 157 BY 1.62.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 36 BY 1.62.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 87 BY 1.62.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 157 BY 14.52.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_table FOR 
      Cheque SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_table
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_table B-table-Win _STRUCTURED
  QUERY br_table NO-LOCK DISPLAY
      Cheque.fecha_deposito FORMAT "99/99/9999":U
      Cheque.numero_cheque FORMAT ">>>>>>>9":U
      Cheque.fecha_acredita FORMAT "99/99/9999":U
      Cheque.fecha_emision FORMAT "99/99/9999":U
      Cheque.importe FORMAT "->>>,>>>,>>9.99":U
      Cheque.observacion FORMAT "X(50)":U WIDTH 53.6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ASSIGN SEPARATORS SIZE 154 BY 13.76
         BGCOLOR 15 FGCOLOR 9  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     v-des_fecha AT ROW 1.24 COL 14 COLON-ALIGNED
     v-has_fecha AT ROW 1.24 COL 32 COLON-ALIGNED
     v-fecha_acreditacion AT ROW 1.24 COL 61 COLON-ALIGNED
     v-cantcheques AT ROW 1.24 COL 84 COLON-ALIGNED
     v-totdeposito AT ROW 1.24 COL 96 COLON-ALIGNED
     v-que_estado AT ROW 1.24 COL 122 COLON-ALIGNED WIDGET-ID 6
     btn_acreditar AT ROW 3.14 COL 2
     btn_rechazar AT ROW 3.14 COL 19
     btn_seltodos AT ROW 3.14 COL 72
     btn_desmarcar AT ROW 3.14 COL 89
     btn_verlog AT ROW 3.14 COL 106
     btn_listar AT ROW 3.14 COL 123
     btn_comprobante AT ROW 3.14 COL 140
     br_table AT ROW 5.33 COL 2
     RECT-2 AT ROW 1 COL 1
     RECT-3 AT ROW 2.86 COL 1
     RECT-4 AT ROW 2.86 COL 71
     RECT-5 AT ROW 4.81 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1 SCROLLABLE 
         BGCOLOR 8 FGCOLOR 0 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartBrowser
   External Tables: sic.Cuenta_bancaria
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
         HEIGHT             = 18.52
         WIDTH              = 157.2.
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
   NOT-VISIBLE Size-to-Fit                                              */
/* BROWSE-TAB br_table btn_comprobante F-Main */
ASSIGN 
       FRAME F-Main:SCROLLABLE       = FALSE
       FRAME F-Main:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_table
/* Query rebuild information for BROWSE br_table
     _TblList          = "sic.Cheque OF sic.Cuenta_bancaria"
     _Options          = "NO-LOCK INDEXED-REPOSITION KEY-PHRASE"
     _OrdList          = "sic.Cheque.fecha_deposito|yes,sic.Cheque.numero_cheque|yes"
     _Where[1]         = "Cheque.fecha_deposito <= v-has_fecha
 AND Cheque.fecha_deposito >= v-des_fecha
 AND Cheque.estado = que_estado"
     _FldNameList[1]   = sic.Cheque.fecha_deposito
     _FldNameList[2]   = sic.Cheque.numero_cheque
     _FldNameList[3]   = sic.Cheque.fecha_acredita
     _FldNameList[4]   = sic.Cheque.fecha_emision
     _FldNameList[5]   = sic.Cheque.importe
     _FldNameList[6]   > sic.Cheque.observacion
"Cheque.observacion" ? "X(50)" "character" ? ? ? ? ? ? no ? no no "53.6" yes no no "U" "" ""
     _Query            is NOT OPENED
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
ON MOUSE-SELECT-DBLCLICK OF br_table IN FRAME F-Main
DO:
  APPLY "RETURN" TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON RETURN OF br_table IN FRAME F-Main
DO:
  DO TRANSACTION:
    FIND CURRENT Cheque EXCLUSIVE-LOCK.
    IF Cheque.user-id-sel = ""
    THEN DO:
         Cheque.user-id-sel = "ACR-" + USERID("sic").
         v-cantcheques = v-cantcheques + 1.
         v-totdeposito = v-totdeposito + Cheque.importe.
         RUN poner_color ( INPUT 0, INPUT 8).
    END.
    ELSE DO:
         Cheque.user-id-sel = "".
         v-cantcheques = v-cantcheques - 1.
         v-totdeposito = v-totdeposito - Cheque.importe.
         RUN poner_color ( INPUT 9, INPUT 15).

    END.
  END.
  DISPLAY  v-cantcheques
           v-totdeposito
           WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_table B-table-Win
ON ROW-DISPLAY OF br_table IN FRAME F-Main
DO:
  IF Cheque.user-id-sel = ""
     THEN RUN poner_color ( INPUT 9, INPUT 15).
     ELSE RUN poner_color ( INPUT 0, INPUT 8).
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


&Scoped-define SELF-NAME btn_acreditar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_acreditar B-table-Win
ON CHOOSE OF btn_acreditar IN FRAME F-Main /* Acreditar */
DO:

   sino = NO.
   IF que_estado = "01"
      THEN MESSAGE "Realmente desea registrar la acreditación de los cheques seleccionados?" 
                   VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
                   TITLE "Se pide confirmación" UPDATE sino.
      ELSE MESSAGE "Realmente desea revertir la acreditación de los cheques seleccionados?" 
                   VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
                   TITLE "Se pide confirmación" UPDATE sino.
   IF sino 
   THEN DO:

        ASSIGN FRAME {&FRAME-NAME} v-fecha_acreditacion.
        
        RUN acreditar_cheques.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        ASSIGN
              v-cantcheques = 0
              v-totdeposito = 0.
        DISPLAY  v-cantcheques
                 v-totdeposito
                 WITH FRAME {&FRAME-NAME}.

   END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_comprobante
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_comprobante B-table-Win
ON CHOOSE OF btn_comprobante IN FRAME F-Main /* Ver Valor */
DO:
  RUN d-muestra_cheque.w ( INPUT ROWID(Cheque)).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_desmarcar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_desmarcar B-table-Win
ON CHOOSE OF btn_desmarcar IN FRAME F-Main /* Desmarcar */
DO:
   sino = NO.
   MESSAGE "Realmente desea desseleccionar todos los cheques elegidos?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" UPDATE sino.
   IF sino 
   THEN DO:
        RUN desmarcar_todos.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_listar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_listar B-table-Win
ON CHOOSE OF btn_listar IN FRAME F-Main /* Listar */
DO:

   sino = NO.
   MESSAGE "Desea listar los cheques seleccionados?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" UPDATE sino.
   IF sino 
   THEN DO:
/*
        ASSIGN FRAME {&FRAME-NAME} v-fecha_acreditacion
               FRAME {&FRAME-NAME} v-referencia
               FRAME {&FRAME-NAME} v-cdg_cuenta_ban.
*/        
        RUN listar_cheques.
   END.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_rechazar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_rechazar B-table-Win
ON CHOOSE OF btn_rechazar IN FRAME F-Main /* Rechazar */
DO:

   sino = NO.
   IF que_estado = "01"
      THEN MESSAGE "Realmente desea registrar el RECHAZO de los cheques seleccionados?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmación" UPDATE sino.
      ELSE MESSAGE "Realmente desea ANULAR EL RECHAZO de los cheques seleccionados?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmación" UPDATE sino.
   IF sino 
   THEN DO:

        ASSIGN FRAME {&FRAME-NAME} v-fecha_acreditacion.
        
        RUN rechazar_cheques.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
        ASSIGN
              v-cantcheques = 0
              v-totdeposito = 0.
        DISPLAY  v-cantcheques
                 v-totdeposito
                 WITH FRAME {&FRAME-NAME}.

   END.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_seltodos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_seltodos B-table-Win
ON CHOOSE OF btn_seltodos IN FRAME F-Main /* Marcar */
DO:
   sino = NO.
   MESSAGE "Realmente desea seleccionar todos los cheques disponibles?" 
           VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
           TITLE "Se pide confirmacion" UPDATE sino.
   IF sino 
   THEN DO:
        RUN marcar_todos.
        RUN dispatch IN THIS-PROCEDURE ('open-query':U).
   END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_verlog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_verlog B-table-Win
ON CHOOSE OF btn_verlog IN FRAME F-Main /* Ver Log */
DO:
    RUN veresult.w ( INPUT dire_tmp + "acredcheque.txt",
                     INPUT 22).  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-des_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-des_fecha IN FRAME F-Main /* Depósitos del */
DO:

  fecha_inicial = DATE(v-des_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-des_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "RETURN" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-des_fecha B-table-Win
ON RETURN OF v-des_fecha IN FRAME F-Main /* Depósitos del */
DO:
  ASSIGN v-des_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-fecha_acreditacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-fecha_acreditacion B-table-Win
ON MOUSE-MENU-DOWN OF v-fecha_acreditacion IN FRAME F-Main /* Acreditación */
DO:

  fecha_inicial = DATE(v-fecha_acreditacion:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-fecha_acreditacion 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-has_fecha
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON MOUSE-MENU-DOWN OF v-has_fecha IN FRAME F-Main /* al */
DO:

  fecha_inicial = DATE(v-has_fecha:SCREEN-VALUE IN FRAME {&FRAME-NAME}) NO-ERROR.
  IF fecha_inicial = ? THEN fecha_inicial = TODAY.
  RUN d-calendario.w ( INPUT fecha_inicial, OUTPUT fecha_elegida).
  IF fecha_elegida <> ?
  THEN DO:
       DISPLAY fecha_elegida @ v-has_fecha 
               WITH FRAME {&FRAME-NAME}.
       APPLY "TAB" TO SELF.        
  END.               
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-has_fecha B-table-Win
ON RETURN OF v-has_fecha IN FRAME F-Main /* al */
DO:
  ASSIGN v-has_fecha.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-que_estado
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-que_estado B-table-Win
ON VALUE-CHANGED OF v-que_estado IN FRAME F-Main /* Estado */
DO:
  ASSIGN v-que_estado.
  RUN cambiar_estado ( INPUT v-que_estado ).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE acreditar_cheques B-table-Win 
PROCEDURE acreditar_cheques :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE tot_valors          AS INTEGER LABEL "cheques".
    DEFINE VARIABLE tot_importes        LIKE Cheque.importe LABEL "Importes".
    DEFINE VARIABLE fecha_lis           AS DATE.
    DEFINE VARIABLE hora_lis            AS CHARACTER.
    DEFINE VARIABLE dire_tmp            AS CHARACTER.
    DEFINE VARIABLE det_titulo          AS CHARACTER FORMAT "X(30)".
    DEFINE VARIABLE titulo_f            AS CHARACTER FORMAT "X(33)".
    DEFINE VARIABLE v-referencia        AS CHARACTER FORMAT "X(50)".
    DEFINE VARIABLE cod_efectivo        LIKE Rubro.cdg_rubro.
    DEFINE VARIABLE cod_cheque          LIKE Rubro.cdg_rubro.

    DEFINE FRAME frm-titulo HEADER
        que_empresa FORMAT "X(25)"
        titulo_f AT 30
        "Página:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 SKIP 
        fecha_lis               
        det_titulo AT 30
        hora_lis AT 70  
        WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

    DEFINE FRAME frm-listado
        Cheque.numero_cheque
        Cheque.estado
        Cheque.fecha_deposito
        Cheque.fecha_acredita
        Cheque.fecha_emision
        Cheque.importe
        Cheque.observacion
        WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
    
    {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}

    DO TRANSACTION WITH FRAME frm-listado:
       
         fecha_lis = TODAY.
         hora_lis = STRING(TIME,"HH:MM:SS").
         titulo_f = "Cheques acreditados el " + STRING(v-fecha_acreditacion,"99/99/99").
         det_titulo = Cuenta_bancaria.cdg_cuenta_ban + " - " + Cuenta_bancaria.denominacion_cta.
      
         OUTPUT TO VALUE(dire_tmp + "acredcheque.txt") PAGED.
      
         tot_importes = 0.
         FOR EACH Cheque WHERE Cheque.user-id-sel = "ACR-" + USERID("sic") EXCLUSIVE-LOCK:


             VIEW FRAME frm-titulo.

             Cheque.fecha_acredita = v-fecha_acreditacion.

             DISPLAY Cheque.numero_cheque
                     Cheque.estado
                     Cheque.fecha_deposito
                     Cheque.fecha_acredita
                     Cheque.fecha_emision
                     Cheque.importe
                     Cheque.observacion
                     WITH FRAME frm-listado.
      
             DOWN WITH FRAME frm-listado.
             tot_importes = tot_importes + Cheque.importe.
             tot_valors   = tot_valors + 1.

             IF que_estado = "01" /* Estoy tratando los cheques en circulacion, debo acreditarlos */
             THEN DO:
                
                 ASSIGN
                      Cheque.user-id-sel = ""
                      Cheque.estado      = "02".
    
                 /* ----------------------------------------------------------------- */
                 /* Si las dos cuentas son diferentes, hay "Cheques en circulacion" y */
                 /* debe generarse el correspondiente movimiento bancario. Dado que   */
                 /* en el movimiento de tesorería contabilizamos el estado transitorio*/
                 /* de los cheques en circulacion, aqui es donde se contabiliza contra*/
                 /* el saldo de banco. Como el movimiento de banco no es directamente */
                 /* de tesoreria, debe generarse el subdiario de banco para contabi-  */
                 /* lizar.                                                            */
                 /* ----------------------------------------------------------------- */
    
                 IF Cuenta_bancaria.nro_cuenta_acredita <> Cuenta_bancaria.nro_cuenta_emision
                 THEN DO:
    
                     CREATE Cta_cte_bco.
                     ASSIGN Cta_cte_bco.tip_comprob     = "CH"
                            Cta_cte_bco.prf_comprob     = 0
                            Cta_cte_bco.nro_comprob     = Cheque.numero_cheque
                            Cta_cte_bco.nro_transaccion = Cheque.nro_transaccion
                            Cta_cte_bco.fecha_efectiva  = Cheque.fecha_acredita
                            Cta_cte_bco.fecha_movimto   = Cheque.fecha_acredita
                            Cta_cte_bco.credito         = 0
                            Cta_cte_bco.debito          = Cheque.importe
                            Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
                            Cta_cte_bco.nro_cuenta      = Cuenta_bancaria.nro_cuenta_emision
                            Cta_cte_bco.nro_cheque      = Cheque.nro_cheque
                            Cta_cte_bco.leyenda         = Cheque.observacion.
    
                     CREATE Sub_header_bco.
                     BUFFER-COPY Cta_cte_bco TO Sub_header_bco
                         ASSIGN Sub_header_bco.anulado         = NO
                                Sub_header_bco.cdg_sigla-sic   = "TES"
                                Sub_header_bco.contable        = NO   
                                Sub_header_bco.fecha           = Cta_cte_bco.fecha_efectiva
                                Sub_header_bco.imp_total       = Cheque.importe
                                Sub_header_bco.nro_entidad     = 0 
                                Sub_header_bco.presentado      = "".
                     
                     CREATE Sub_detalle_bco.
                     BUFFER-COPY Sub_header_bco TO Sub_detalle_bco
                         ASSIGN Sub_detalle_bco.nro_cuenta = Cuenta_bancaria.nro_cuenta_emision
                                Sub_detalle_bco.tipo = 1
                                Sub_detalle_bco.valor = Sub_header_bco.imp_total.
    
                     RELEASE Cta_cte_bco.
                     RELEASE Sub_header_bco.
                     RELEASE Sub_detalle_bco.
                     
                 END.

             END.
             ELSE DO: /* Estoy tratado los cheques acreditados, debo retroceder acreditacion */
                
                 ASSIGN
                      Cheque.user-id-sel = ""
                      Cheque.estado      = "01".
    
                 /* ----------------------------------------------------------------- */
                 /* Si las dos cuentas son diferentes, hay "Cheques en circulacion" y */
                 /* debe generarse el correspondiente movimiento bancario. Dado que   */
                 /* en el movimiento de tesorería contabilizamos el estado transitorio*/
                 /* de los cheques en circulacion, aqui es donde se contabiliza contra*/
                 /* el saldo de banco. Como el movimiento de banco no es directamente */
                 /* de tesoreria, debe generarse el subdiario de banco para contabi-  */
                 /* lizar.                                                            */
                 /* ----------------------------------------------------------------- */
    
                 IF Cuenta_bancaria.nro_cuenta_acredita <> Cuenta_bancaria.nro_cuenta_emision
                 THEN DO:
    
                     FIND Cta_cte_bco 
                         WHERE Cta_cte_bco.tip_comprob     = "CH"
                           AND Cta_cte_bco.prf_comprob     = 0
                           AND Cta_cte_bco.nro_comprob     = Cheque.numero_cheque
                           AND Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
                               EXCLUSIVE-LOCK.

                     FOR EACH Sub_header_bco OF Cta_cte_bco EXCLUSIVE-LOCK:

                         FOR EACH Sub_detalle_bco 
                               WHERE Sub_detalle_bco.cdg_cuenta_ban = Sub_header_bco.cdg_cuenta_ban
                                 AND Sub_detalle_bco.nro_comprob    = Sub_header_bco.nro_comprob   
                                 AND Sub_detalle_bco.prf_comprob    = Sub_header_bco.prf_comprob   
                                 AND Sub_detalle_bco.tip_comprob    = Sub_header_bco.tip_comprob   
                                     EXCLUSIVE-LOCK:

                             DELETE Sub_detalle_bco.

                         END.

                         DELETE Sub_header_bco.
                     END.

                     DELETE Cta_cte_bco.
                     
                 END.

             END.


         END.  

         UNDERLINE Cheque.numero_cheque
                   Cheque.estado
                   Cheque.fecha_deposito
                   Cheque.fecha_acredita
                   Cheque.fecha_emision
                   Cheque.importe
                   Cheque.observacion
                   WITH FRAME frm-listado.
      
         DISPLAY   "Total"      @ Cheque.fecha_deposito
                   tot_valors   @ Cheque.numero_cheque
                   tot_importes @ Cheque.importe 
                   WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
      
         OUTPUT CLOSE.
      
         RELEASE Parametro.
         PAUSE 0.        

   END. /* De la transaccion de acreditación */
  
   RELEASE Parametro.
            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-open-query-cases B-table-Win  adm/support/_adm-opn.p
PROCEDURE adm-open-query-cases :
/*------------------------------------------------------------------------------
  Purpose:     Opens different cases of the query based on attributes
               such as the 'Key-Name', or 'SortBy-Case'
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* No Foreign keys are accepted by this SmartObject. */

  {&OPEN-QUERY-{&BROWSE-NAME}}

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

  /* Create a list of all the tables that we need to get.            */
  {src/adm/template/row-list.i "Cuenta_bancaria"}

  /* Get the record ROWID's from the RECORD-SOURCE.                  */
  {src/adm/template/row-get.i}

  /* FIND each record specified by the RECORD-SOURCE.                */
  {src/adm/template/row-find.i "Cuenta_bancaria"}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cambiar_estado B-table-Win 
PROCEDURE cambiar_estado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


  DEFINE INPUT PARAMETER p-nuevo_estado LIKE Cheque.estado.
  
  que_estado = p-nuevo_estado.
  RUN dispatch IN THIS-PROCEDURE ('open-query':U).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE desmarcar_todos B-table-Win 
PROCEDURE desmarcar_todos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO TRANSACTION:
     FOR EACH Cheque WHERE Cheque.user-id-sel = "ACR-" + USERID("sic") EXCLUSIVE-LOCK:
          Cheque.user-id-sel = "".
     END.
  END.
  
  ASSIGN
        v-cantcheques = 0
        v-totdeposito = 0.
  DISPLAY  v-cantcheques
           v-totdeposito
           WITH FRAME {&FRAME-NAME}.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE listar_cheques B-table-Win 
PROCEDURE listar_cheques :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    DEFINE VARIABLE tot_valors          AS INTEGER LABEL "cheques".
    DEFINE VARIABLE tot_importes        LIKE Cheque.importe LABEL "Importes".
    DEFINE VARIABLE fecha_lis           AS DATE.

    DEFINE VARIABLE hora_lis            AS CHARACTER.
    DEFINE VARIABLE dire_tmp            AS CHARACTER.
    DEFINE VARIABLE nom_empresa         AS CHARACTER FORMAT "X(30)".
    DEFINE VARIABLE det_titulo          AS CHARACTER FORMAT "X(30)".
    DEFINE VARIABLE titulo_f            AS CHARACTER FORMAT "X(33)".

    DEFINE FRAME frm-titulo HEADER
        nom_empresa FORMAT "X(25)"
        titulo_f AT 30
        "Página:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 SKIP
        fecha_lis               
        det_titulo AT 30
        hora_lis AT 70  
        WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.
                
    DEFINE FRAME frm-listado
        Cheque.cdg_banco      COLUMN-LABEL "Código!Banco"
        Banco.nombre         COLUMN-LABEL "Razón!Social"
        Cheque.numero_cheque  COLUMN-LABEL "Número!Cheque"
        Cheque.fecha_emision  COLUMN-LABEL "Fecha!Emisión" 
        Cheque.fecha_acredita COLUMN-LABEL "Fecha!Acredita" 
        Cheque.importe        COLUMN-LABEL "Importe!Cheque" 
        WITH WIDTH 96 DOWN CENTERED FRAME frm-listado STREAM-IO.
    
    {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}

    OUTPUT TO VALUE(dire_tmp + "acredcheque.txt").

    DO WITH FRAME frm-listado:
  
         fecha_lis = TODAY.
         hora_lis = STRING(TIME,"HH:MM:SS").
         titulo_f = "cheques a acreditar del " + STRING(v-des_fecha,"99/99/99") + " al " + STRING(v-has_fecha,"99/99/99").
         det_titulo = Cuenta_bancaria.cdg_cuenta_ban + " - " + Cuenta_bancaria.denominacion_cta.
         nom_empresa = Empresa.nombre.
       
         VIEW FRAME frm-titulo.
         
         tot_importes = 0.
         FOR EACH Valor WHERE Cheque.user-id-sel = "ACR-" + USERID("sic"),
             FIRST Banco OF Valor WITH FRAME frm-listado:
     
             DISPLAY Cheque.cdg_banco
                     Banco.nombre
                     Cheque.numero_cheque
                     Cheque.fecha_emision
                     Cheque.importe
                     Cheque.fecha_acredita
                     WITH FRAME frm-listado.
      
             DOWN WITH FRAME frm-listado.
             tot_importes = tot_importes + Cheque.importe.
             tot_valors   = tot_valors + 1.
            
         END.  

         UNDERLINE Cheque.cdg_banco
                   Banco.nombre
                   Cheque.numero_cheque
                   Cheque.fecha_emision
                   Cheque.importe
                   Cheque.fecha_acredita
                   WITH FRAME frm-listado.
      
         DISPLAY   "Total"      @ Banco.nombre
                   tot_valors   @ Cheque.numero_cheque
                   tot_importes @ Cheque.importe 
                   WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
      
         OUTPUT CLOSE.
      
         RUN veresult.w ( INPUT dire_tmp + "acredcheque.txt",
                          INPUT 22).
      
   END. /* De la impresion de los cheques */
*/  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize B-table-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

   v-fecha_acreditacion = TODAY.
   v-des_fecha = TODAY.
   v-has_fecha = TODAY.
   
   {findempresa.i}
   que_empresa = Empresa.cdg_empresa.

   {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}
   
   ASSIGN v-que_estado = "01"
          que_estado = v-que_estado.
   
  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

   DISPLAY v-des_fecha
           v-has_fecha
           v-fecha_acreditacion
           v-que_estado
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-open-query B-table-Win 
PROCEDURE local-open-query :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query':U ) .

  /* Code placed here will execute AFTER standard behavior.    */

    btn_comprobante:SENSITIVE IN FRAME {&FRAME-NAME} = AVAILABLE Cheque.
    btn_desmarcar:SENSITIVE IN FRAME {&FRAME-NAME}   = AVAILABLE Cheque.
    btn_listar:SENSITIVE IN FRAME {&FRAME-NAME}      = AVAILABLE Cheque.
    btn_seltodos:SENSITIVE IN FRAME {&FRAME-NAME}    = AVAILABLE Cheque.

    IF AVAILABLE Cheque
    THEN DO:
         CASE que_estado:
            WHEN "01"   /* Muestra cheques emitidos */
            THEN DO:
                  btn_acreditar:SENSITIVE IN FRAME {&FRAME-NAME}  = YES.
                  btn_acreditar:LABEL     IN FRAME {&FRAME-NAME}  = "&Acreditar".
                  btn_rechazar:SENSITIVE  IN FRAME {&FRAME-NAME}  = YES.
                  btn_rechazar:LABEL      IN FRAME {&FRAME-NAME } = "&Rechazar".
            END.      
            WHEN "02"   /* Muestra cheques acreditados */
            THEN DO:
                  btn_acreditar:SENSITIVE IN FRAME {&FRAME-NAME}  = YES.
                  btn_acreditar:LABEL     IN FRAME {&FRAME-NAME}  = "&Desacreditar".
                  btn_rechazar:SENSITIVE  IN FRAME {&FRAME-NAME}  = NO.
                  btn_rechazar:LABEL      IN FRAME {&FRAME-NAME } = "&Rechazar".
            END.      
            WHEN "03"   /* Muestra cheques rechazados */
            THEN DO:
                  btn_acreditar:SENSITIVE IN FRAME {&FRAME-NAME}  = NO.
                  btn_acreditar:LABEL     IN FRAME {&FRAME-NAME}  = "&Acreditar".
                  btn_rechazar:SENSITIVE  IN FRAME {&FRAME-NAME}  = YES.
                  btn_rechazar:LABEL      IN FRAME {&FRAME-NAME } = "Anular &Rechazo".
            END.      

         END CASE.
    END.
    ELSE DO:
         btn_acreditar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
         btn_rechazar:SENSITIVE IN FRAME {&FRAME-NAME}  = NO.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE marcar_todos B-table-Win 
PROCEDURE marcar_todos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE BUFFER B-Cheque FOR Cheque.

  DO TRANSACTION:
     ASSIGN
        v-cantcheques = 0
        v-totdeposito = 0.

     FOR EACH B-Cheque OF Cuenta_bancaria
         WHERE B-Cheque.fecha_deposito >= v-des_fecha
           AND B-Cheque.fecha_deposito <= v-has_fecha
           AND B-Cheque.estado = "01" EXCLUSIVE-LOCK:
           
         B-Cheque.user-id-sel = "ACR-" + USERID("sic").
         v-cantcheques = v-cantcheques + 1.
         v-totdeposito = v-totdeposito + B-Cheque.importe.

     END.
     RELEASE B-Cheque.
     
  END.
  
  DISPLAY  v-cantcheques
           v-totdeposito
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_color B-table-Win 
PROCEDURE poner_color :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER fg_color AS INTEGER.
  DEFINE INPUT PARAMETER bg_color AS INTEGER.

  Cheque.numero_cheque:FGCOLOR IN BROWSE {&BROWSE-NAME}   = fg_color.
  Cheque.fecha_deposito:FGCOLOR IN BROWSE {&BROWSE-NAME}  = fg_color.
  Cheque.fecha_acredita:FGCOLOR IN BROWSE {&BROWSE-NAME}  = fg_color.
  Cheque.fecha_emision:FGCOLOR IN BROWSE {&BROWSE-NAME}   = fg_color.
  Cheque.importe:FGCOLOR IN BROWSE {&BROWSE-NAME}         = fg_color.
  Cheque.observacion:FGCOLOR IN BROWSE {&BROWSE-NAME}     = fg_color.


  Cheque.numero_cheque:BGCOLOR IN BROWSE {&BROWSE-NAME}   = bg_color.
  Cheque.fecha_deposito:BGCOLOR IN BROWSE {&BROWSE-NAME}  = bg_color.
  Cheque.fecha_acredita:BGCOLOR IN BROWSE {&BROWSE-NAME}  = bg_color.
  Cheque.fecha_emision:BGCOLOR IN BROWSE {&BROWSE-NAME}   = bg_color.
  Cheque.importe:BGCOLOR IN BROWSE {&BROWSE-NAME}         = bg_color.
  Cheque.observacion:BGCOLOR IN BROWSE {&BROWSE-NAME}     = bg_color.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE rechazar_cheques B-table-Win 
PROCEDURE rechazar_cheques :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE VARIABLE tot_valors          AS INTEGER LABEL "cheques".
    DEFINE VARIABLE tot_importes        LIKE Cheque.importe LABEL "Importes".
    DEFINE VARIABLE fecha_lis           AS DATE.
    DEFINE VARIABLE hora_lis            AS CHARACTER.
    DEFINE VARIABLE dire_tmp            AS CHARACTER.
    DEFINE VARIABLE det_titulo          AS CHARACTER FORMAT "X(30)".
    DEFINE VARIABLE titulo_f            AS CHARACTER FORMAT "X(33)".
    DEFINE VARIABLE v-referencia        AS CHARACTER FORMAT "X(50)".
    DEFINE VARIABLE cod_efectivo        LIKE Rubro.cdg_rubro.
    DEFINE VARIABLE cod_cheque          LIKE Rubro.cdg_rubro.

    DEFINE FRAME frm-titulo HEADER
        que_empresa FORMAT "X(25)"
        titulo_f AT 30
        "Página:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 SKIP 
        fecha_lis               
        det_titulo AT 30
        hora_lis AT 70  
        WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

    DEFINE FRAME frm-listado
        Cheque.numero_cheque
        Cheque.estado
        Cheque.fecha_deposito
        Cheque.fecha_acredita
        Cheque.fecha_emision
        Cheque.importe
        Cheque.observacion
        WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
    
    {findparametro.i "DIRECTMP" "dire_tmp" "valor_c"}

    DO TRANSACTION WITH FRAME frm-listado:
       
         fecha_lis = TODAY.
         hora_lis = STRING(TIME,"HH:MM:SS").
         titulo_f = "Cheques acreditados el " + STRING(v-fecha_acreditacion,"99/99/99").
         det_titulo = Cuenta_bancaria.cdg_cuenta_ban + " - " + Cuenta_bancaria.denominacion_cta.
      
         OUTPUT TO VALUE(dire_tmp + "acredcheque.txt").
      
         tot_importes = 0.
         FOR EACH Cheque WHERE Cheque.user-id-sel = "ACR-" + USERID("sic") EXCLUSIVE-LOCK:

             VIEW FRAME frm-titulo.

             Cheque.fecha_acredita = v-fecha_acreditacion.

             DISPLAY Cheque.numero_cheque
                     Cheque.estado
                     Cheque.fecha_deposito
                     Cheque.fecha_acredita
                     Cheque.fecha_emision
                     Cheque.importe
                     Cheque.observacion
                     WITH FRAME frm-listado.
      
             DOWN WITH FRAME frm-listado.
             tot_importes = tot_importes + Cheque.importe.
             tot_valors   = tot_valors + 1.
            
             ASSIGN
                  Cheque.user-id-sel = ""
                  Cheque.estado      = "03".

             IF Cuenta_bancaria.nro_cuenta_acredita <> Cuenta_bancaria.nro_cuenta_emision
             THEN DO:

                 CREATE Cta_cte_bco.
                 ASSIGN Cta_cte_bco.tip_comprob     = "CH"
                        Cta_cte_bco.prf_comprob     = 0
                        Cta_cte_bco.nro_comprob     = Cheque.numero_cheque
                        Cta_cte_bco.nro_transaccion = Caj_header.nro_transaccion
                        Cta_cte_bco.fecha_efectiva  = Cheque.fecha_acredita
                        Cta_cte_bco.fecha_movimto   = Cheque.fecha_acredita
                        Cta_cte_bco.credito         = 0
                        Cta_cte_bco.debito          = Cheque.importe
                        Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
                        Cta_cte_bco.nro_cuenta      = Cuenta_bancaria.nro_cuenta_emision
                        Cta_cte_bco.nro_cheque      = Cheque.nro_cheque
                        Cta_cte_bco.leyenda         = Cheque.observacion.

                 CREATE Sub_header_bco.
                 BUFFER-COPY Cta_cte_bco TO Sub_header_bco
                     ASSIGN Sub_header_bco.anulado         = NO
                            Sub_header_bco.cdg_sigla-sic   = "TES"
                            Sub_header_bco.contable        = NO   
                            Sub_header_bco.fecha           = Cta_cte_bco.fecha_efectiva
                            Sub_header_bco.imp_total       = Cheque.importe
                            Sub_header_bco.nro_entidad     = 0 
                            Sub_header_bco.presentado      = "".
                 
                 CREATE Sub_detalle_bco.
                 BUFFER-COPY Sub_header_bco TO Sub_detalle_bco
                     ASSIGN Sub_detalle_bco.nro_cuenta = Cuenta_bancaria.nro_cuenta_emision
                            Sub_detalle_bco.tipo = 1
                            Sub_detalle_bco.valor = Sub_header_bco.imp_total.

                 RELEASE Cta_cte_bco.
                 RELEASE Sub_header_bco.
                 RELEASE Sub_detalle_bco.
                 
             END.

         END.  

         UNDERLINE Cheque.numero_cheque
                   Cheque.estado
                   Cheque.fecha_deposito
                   Cheque.fecha_acredita
                   Cheque.fecha_emision
                   Cheque.importe
                   Cheque.observacion
                   WITH FRAME frm-listado.
      
         DISPLAY   "Total"      @ Cheque.fecha_deposito
                   tot_valors   @ Cheque.numero_cheque
                   tot_importes @ Cheque.importe 
                   WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
      
         OUTPUT CLOSE.
      
         RELEASE Parametro.
         PAUSE 0.        

   END. /* De la transaccion de acreditación */
  
   RELEASE Parametro.
            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-key B-table-Win  adm/support/_key-snd.p
PROCEDURE send-key :
/*------------------------------------------------------------------------------
  Purpose:     Sends a requested KEY value back to the calling
               SmartObject.
  Parameters:  <see adm/template/sndkytop.i>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/sndkytop.i}

  /* Return the key value associated with each key case.             */
  {src/adm/template/sndkycas.i "cdg_banco" "Valor" "cdg_banco"}
  {src/adm/template/sndkycas.i "cdg_caja" "Valor" "cdg_caja"}
  {src/adm/template/sndkycas.i "nro_transaccion" "Valor" "nro_transaccion"}
  {src/adm/template/sndkycas.i "nro_cliente" "Valor" "nro_cliente"}
  {src/adm/template/sndkycas.i "nro_cuenta" "Valor" "nro_cuenta"}
  {src/adm/template/sndkycas.i "cdg_cuenta_ban" "Valor" "cdg_cuenta_ban"}
  {src/adm/template/sndkycas.i "cdg_empresa" "Valor" "cdg_empresa"}
  {src/adm/template/sndkycas.i "nro_proveedor" "Valor" "nro_proveedor"}
  {src/adm/template/sndkycas.i "nro_recibo" "Valor" "nro_recibo"}
  {src/adm/template/sndkycas.i "num_sucursal" "Valor" "num_sucursal"}
  {src/adm/template/sndkycas.i "nro_titular-cob" "Valor" "nro_titular-cob"}
  {src/adm/template/sndkycas.i "nro_titular-pag" "Valor" "nro_titular-pag"}
  {src/adm/template/sndkycas.i "nro_valor" "Valor" "nro_valor"}

  /* Close the CASE statement and end the procedure.                 */
  {src/adm/template/sndkyend.i}

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
  {src/adm/template/snd-list.i "Cuenta_bancaria"}
  {src/adm/template/snd-list.i "Cheque"}

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

