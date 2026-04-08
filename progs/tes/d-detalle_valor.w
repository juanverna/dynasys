&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame


/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

&IF DEFINED(UIB_is_Running) NE 0
&THEN
DEFINE VARIABLE               p-cdg_rubro      LIKE Rubro.cdg_rubro.
DEFINE VARIABLE               p-nro_linea-i    AS INTEGER.
DEFINE VARIABLE               p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE               p-modo-detalle   AS INTEGER.
DEFINE VARIABLE               p-nro_linea-o    AS INTEGER.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Cheque.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valor.
DEFINE INPUT PARAMETER        p-cdg_rubro      LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER        p-nro_linea-i    AS INTEGER.
DEFINE INPUT PARAMETER        p-modo-cabecera  AS INTEGER.
DEFINE INPUT PARAMETER        p-modo-detalle   AS INTEGER.
DEFINE INPUT PARAMETER        v-cdg_caja       AS INTEGER.
DEFINE OUTPUT PARAMETER       p-nro_linea-o    AS INTEGER.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}
{stcheques.i}

DEFINE VARIABLE rid_tabla        AS ROWID.
DEFINE VARIABLE hubo_error       AS LOGICAL.
DEFINE VARIABLE hay_obras        AS LOGICAL.
DEFINE VARIABLE v-importe        AS DECIMAL.
DEFINE VARIABLE suma_habil       AS INTEGER.
DEFINE VARIABLE diasem           AS INTEGER.
DEFINE VARIABLE v-fecha0         AS DATE.
DEFINE VARIABLE v-fecha1         AS DATE.
DEFINE VARIABLE v-ndias          AS INTEGER.
DEFINE VARIABLE x-fecha_cambio   AS DATE.

DEFINE VARIABLE v-fecha_deposito AS DATE.
DEFINE VARIABLE v-fecha_acredita AS DATE.

DEFINE BUFFER B-T-Valor FOR T-Valor.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Caj_detalle T-Valor T-Cheque T-Caj_header

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Caj_detalle.tipo_mov ~
T-Caj_detalle.observacion T-Caj_detalle.importe T-Caj_detalle.cambio ~
T-Caj_detalle.divisas T-Valor.cdg_banco T-Valor.cdg_sucurbanco ~
T-Cheque.cdg_cuenta_ban T-Valor.numero_cheque T-Valor.numero_cuenta_val ~
T-Cheque.numero_cheque T-Valor.fecha_emision T-Valor.dias_clearing ~
T-Valor.estado T-Cheque.fecha_emision T-Cheque.dias_clearing ~
T-Valor.fecha_deposito T-Valor.fecha_acredita T-Cheque.fecha_deposito ~
T-Cheque.fecha_acredita T-Caj_detalle.numero_certificado 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame ~
T-Caj_detalle.observacion T-Caj_detalle.importe T-Caj_detalle.cambio ~
T-Caj_detalle.divisas T-Valor.cdg_banco T-Cheque.cdg_cuenta_ban ~
T-Valor.numero_cheque T-Valor.numero_cuenta_val T-Cheque.numero_cheque ~
T-Valor.fecha_emision T-Valor.dias_clearing T-Valor.estado ~
T-Cheque.fecha_emision T-Cheque.dias_clearing T-Valor.fecha_deposito ~
T-Valor.fecha_acredita T-Cheque.fecha_deposito T-Cheque.fecha_acredita ~
T-Caj_detalle.numero_certificado 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Caj_detalle T-Valor ~
T-Cheque
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Caj_detalle
&Scoped-define SECOND-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Valor
&Scoped-define THIRD-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Cheque
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Caj_detalle SHARE-LOCK, ~
      EACH T-Valor WHERE TRUE /* Join to T-Caj_detalle incomplete */ SHARE-LOCK, ~
      EACH T-Cheque WHERE TRUE /* Join to T-Caj_detalle incomplete */ SHARE-LOCK, ~
      EACH T-Caj_header WHERE TRUE /* Join to T-Caj_detalle incomplete */ SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Caj_detalle SHARE-LOCK, ~
      EACH T-Valor WHERE TRUE /* Join to T-Caj_detalle incomplete */ SHARE-LOCK, ~
      EACH T-Cheque WHERE TRUE /* Join to T-Caj_detalle incomplete */ SHARE-LOCK, ~
      EACH T-Caj_header WHERE TRUE /* Join to T-Caj_detalle incomplete */ SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Caj_detalle T-Valor T-Cheque ~
T-Caj_header
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Caj_detalle
&Scoped-define SECOND-TABLE-IN-QUERY-Dialog-Frame T-Valor
&Scoped-define THIRD-TABLE-IN-QUERY-Dialog-Frame T-Cheque
&Scoped-define FOURTH-TABLE-IN-QUERY-Dialog-Frame T-Caj_header


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Caj_detalle.observacion ~
T-Caj_detalle.importe T-Caj_detalle.cambio T-Caj_detalle.divisas ~
T-Valor.cdg_banco T-Cheque.cdg_cuenta_ban T-Valor.numero_cheque ~
T-Valor.numero_cuenta_val T-Cheque.numero_cheque T-Valor.fecha_emision ~
T-Valor.dias_clearing T-Valor.estado T-Cheque.fecha_emision ~
T-Cheque.dias_clearing T-Valor.fecha_deposito T-Valor.fecha_acredita ~
T-Cheque.fecha_deposito T-Cheque.fecha_acredita ~
T-Caj_detalle.numero_certificado 
&Scoped-define ENABLED-TABLES T-Caj_detalle T-Valor T-Cheque
&Scoped-define FIRST-ENABLED-TABLE T-Caj_detalle
&Scoped-define SECOND-ENABLED-TABLE T-Valor
&Scoped-define THIRD-ENABLED-TABLE T-Cheque
&Scoped-Define ENABLED-OBJECTS RECT-13 RECT-14 RECT-15 RECT-16 RECT-17 ~
RECT-18 RECT-19 RECT-20 Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-FIELDS T-Caj_detalle.tipo_mov ~
T-Caj_detalle.observacion T-Caj_detalle.importe T-Caj_detalle.cambio ~
T-Caj_detalle.divisas T-Valor.cdg_banco T-Valor.cdg_sucurbanco Banco.nombre ~
T-Cheque.cdg_cuenta_ban Cuenta_bancaria.denominacion_cta ~
T-Valor.numero_cheque T-Valor.numero_cuenta_val T-Cheque.numero_cheque ~
T-Valor.fecha_emision T-Valor.dias_clearing T-Valor.estado ~
T-Cheque.fecha_emision T-Cheque.dias_clearing T-Valor.fecha_deposito ~
T-Valor.fecha_acredita T-Cheque.fecha_deposito T-Cheque.fecha_acredita ~
T-Caj_detalle.numero_certificado 
&Scoped-define DISPLAYED-TABLES T-Caj_detalle T-Valor Banco T-Cheque ~
Cuenta_bancaria
&Scoped-define FIRST-DISPLAYED-TABLE T-Caj_detalle
&Scoped-define SECOND-DISPLAYED-TABLE T-Valor
&Scoped-define THIRD-DISPLAYED-TABLE Banco
&Scoped-define FOURTH-DISPLAYED-TABLE T-Cheque
&Scoped-define FIFTH-DISPLAYED-TABLE Cuenta_bancaria
&Scoped-Define DISPLAYED-OBJECTS v-cdg_rubro v-dsc_rubro 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE v-cdg_rubro AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Rubro" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_rubro AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 13 BY 2.14.

DEFINE RECTANGLE RECT-14
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 115 BY 2.57.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 2.86.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 2.86.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 6.43.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 6.43.

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57 BY 2.62.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 2.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Caj_detalle, 
      T-Valor, 
      T-Cheque, 
      T-Caj_header SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_rubro AT ROW 1.48 COL 14 COLON-ALIGNED
     v-dsc_rubro AT ROW 1.48 COL 29 COLON-ALIGNED NO-LABEL
     T-Caj_detalle.tipo_mov AT ROW 1.76 COL 104 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Ingreso", "I":U,
"Egreso", "E":U
          SIZE 11 BY 1.62
     T-Caj_detalle.observacion AT ROW 2.67 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 85 BY 1
          BGCOLOR 15 FGCOLOR 9  NO-TAB-STOP 
     T-Caj_detalle.importe AT ROW 5.29 COL 14 COLON-ALIGNED FORMAT "->>>,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 23 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_detalle.cambio AT ROW 5.29 COL 70 COLON-ALIGNED FORMAT ">>,>>9.9999"
          VIEW-AS FILL-IN 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Caj_detalle.divisas AT ROW 5.29 COL 97 COLON-ALIGNED FORMAT "->,>>>,>>9.99"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.cdg_banco AT ROW 8.14 COL 14 COLON-ALIGNED
          LABEL "Banco"
          VIEW-AS FILL-IN 
          SIZE 7 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.cdg_sucurbanco AT ROW 8.14 COL 22 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 8 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Banco.nombre AT ROW 8.14 COL 31 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 26 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Cheque.cdg_cuenta_ban AT ROW 8.14 COL 70 COLON-ALIGNED
          LABEL "Cuenta"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Cuenta_bancaria.denominacion_cta AT ROW 8.14 COL 87 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 27 BY 1
          BGCOLOR 7 FGCOLOR 15 
     T-Valor.numero_cheque AT ROW 9.33 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.numero_cuenta_val AT ROW 9.33 COL 40 COLON-ALIGNED WIDGET-ID 2
          LABEL "Cuenta"
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Cheque.numero_cheque AT ROW 9.33 COL 70 COLON-ALIGNED
          LABEL "Número"
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.fecha_emision AT ROW 10.52 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.dias_clearing AT ROW 10.52 COL 40 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 4 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.estado AT ROW 10.52 COL 52 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Cheque.fecha_emision AT ROW 10.52 COL 70 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Cheque.dias_clearing AT ROW 10.52 COL 98 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.fecha_deposito AT ROW 11.71 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valor.fecha_acredita AT ROW 11.71 COL 40 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 17 BY 1
          BGCOLOR 15 FGCOLOR 9 
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     T-Cheque.fecha_deposito AT ROW 11.71 COL 70 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Cheque.fecha_acredita AT ROW 11.71 COL 98 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 13.86 COL 69
     Btn_Cancel AT ROW 13.86 COL 98
     T-Caj_detalle.numero_certificado AT ROW 14.57 COL 14 COLON-ALIGNED WIDGET-ID 6
          LABEL "Número"
          VIEW-AS FILL-IN 
          SIZE 43 BY 1
          BGCOLOR 15 FGCOLOR 9 
     "   Valores de Terceros" VIEW-AS TEXT
          SIZE 56 BY 1 AT ROW 6.95 COL 3
          BGCOLOR 7 FGCOLOR 15 
     "   Cheques Propios" VIEW-AS TEXT
          SIZE 55 BY 1 AT ROW 6.95 COL 61
          BGCOLOR 7 FGCOLOR 15 
     "  Certificado de Retención" VIEW-AS TEXT
          SIZE 56 BY 1 AT ROW 13.38 COL 3 WIDGET-ID 4
          BGCOLOR 7 FGCOLOR 15 
     "   Valores de Cambio" VIEW-AS TEXT
          SIZE 55 BY 1 AT ROW 4.14 COL 61
          BGCOLOR 7 FGCOLOR 15 
     "   Importe" VIEW-AS TEXT
          SIZE 56 BY 1 AT ROW 4.14 COL 3
          BGCOLOR 7 FGCOLOR 15 
     RECT-13 AT ROW 1.48 COL 103
     RECT-14 AT ROW 1.29 COL 2
     RECT-15 AT ROW 3.86 COL 2
     RECT-16 AT ROW 3.86 COL 60
     RECT-17 AT ROW 6.71 COL 2
     RECT-18 AT ROW 6.71 COL 60
     RECT-19 AT ROW 13.14 COL 60
     RECT-20 AT ROW 13.14 COL 2 WIDGET-ID 8
     SPACE(57.59) SKIP(0.66)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Valores"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Caj_detalle T "?" NO-UNDO sic Caj_detalle
      TABLE: T-Caj_header T "?" NO-UNDO sic Caj_header
      TABLE: T-Cheque T "?" NO-UNDO sic Cheque
      TABLE: T-Valor T "?" NO-UNDO sic Valor
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN T-Caj_detalle.cambio IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Valor.cdg_banco IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Cheque.cdg_cuenta_ban IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Valor.cdg_sucurbanco IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN Cuenta_bancaria.denominacion_cta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_detalle.divisas IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN T-Caj_detalle.importe IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN Banco.nombre IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Caj_detalle.numero_certificado IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Cheque.numero_cheque IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR FILL-IN T-Valor.numero_cuenta_val IN FRAME Dialog-Frame
   EXP-LABEL                                                            */
/* SETTINGS FOR RADIO-SET T-Caj_detalle.tipo_mov IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_rubro IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_rubro IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Caj_detalle,Temp-Tables.T-Valor WHERE Temp-Tables.T-Caj_detalle ...,Temp-Tables.T-Cheque WHERE Temp-Tables.T-Caj_detalle ...,Temp-Tables.T-Caj_header WHERE Temp-Tables.T-Caj_detalle ..."
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Valores */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
    IF p-modo-detalle = 0 
    THEN DO:  
        DELETE T-Caj_detalle.  
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  RUN validar_fechas.

  ASSIGN FRAME {&FRAME-NAME}
         T-Caj_detalle.cambio 
         T-Caj_detalle.divisas 
         T-Caj_detalle.importe
         T-Caj_detalle.observacion
         T-Caj_detalle.numero_certificado.

  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:

        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:

            ASSIGN
                T-Caj_header.ultima_linea     = T-Caj_header.ultima_linea + 1
                T-Caj_detalle.nro_transaccion = T-Caj_header.nro_transaccion
                T-Caj_detalle.nro_linea       = T-Caj_header.ultima_linea.

        END.
      
        IF Rubro.tipo = "V"
        THEN DO:
            IF T-Caj_detalle.tipo_mov = "I"
            THEN DO:
               IF p-modo-detalle = MD_ALTA 
               THEN DO:
                    CREATE T-Valor.
                    ASSIGN T-Valor.cdg_empresa     = T-Caj_header.cdg_empresa
                           T-Valor.nro_valor       = T-Caj_detalle.nro_linea
                           T-Valor.estado          = "**"
                           T-Caj_detalle.nro_valor = T-Valor.nro_valor.
                    RUN getparametro_d.p ( "DLFCLEAR" , OUTPUT t-valor.dias_clearing).
               END.

               ASSIGN FRAME {&FRAME-NAME}
                      T-Valor.cdg_banco 
                      T-Valor.cdg_sucurbanco 
                      T-Valor.dias_clearing 
                      T-Valor.fecha_acredita                       
                      T-Valor.fecha_deposito 
                      T-Valor.fecha_emision 
                      T-Valor.numero_cuenta_val
                      T-Valor.numero_cheque.

               ASSIGN T-Valor.importe = T-Caj_detalle.importe.

            END.   
            ELSE DO:
                 FIND Valor WHERE Valor.cdg_banco          = INPUT FRAME {&FRAME-NAME} T-Valor.cdg_banco 
                              AND Valor.cdg_sucurbanco     = INPUT FRAME {&FRAME-NAME} T-Valor.cdg_sucurbanco
                              AND Valor.numero_cheque      = INPUT FRAME {&FRAME-NAME} T-Valor.numero_cheque 
                              AND Valor.numero_cuenta_val  = INPUT FRAME {&FRAME-NAME} T-Valor.numero_cuenta_val 
                                  NO-LOCK.
                 CREATE T-Valor.
                 BUFFER-COPY Valor TO T-Valor.
                 ASSIGN T-Caj_detalle.nro_valor = T-Valor.nro_valor
                        T-Caj_detalle.importe   = T-Valor.importe.
                 RELEASE Valor.
            END.
        END.

        IF Rubro.tipo = "P"
        THEN DO:
             IF p-modo-detalle = MD_ALTA 
             THEN DO:
                  CREATE T-Cheque.
                  ASSIGN T-Cheque.nro_cheque      = T-Caj_detalle.nro_linea
                         T-Caj_detalle.nro_cheque = T-Cheque.nro_cheque
                         T-Cheque.nro_transaccion = T-Caj_header.nro_transaccion
                         T-Cheque.importe         = T-Caj_detalle.importe.
                  RUN getparametro_d.p ( "DLFCLEAR" , OUTPUT T-Cheque.dias_clearing).
             END.

             ASSIGN FRAME {&FRAME-NAME}
                    T-Cheque.cdg_cuenta_ban 
                    T-Cheque.dias_clearing 
                    T-Cheque.fecha_acredita 
                    T-Cheque.fecha_deposito 
                    T-Cheque.fecha_emision 
                    T-Cheque.numero_cheque.

             RUN calcular_fecha_valor.p ( INPUT  T-Cheque.fecha_emision,
                                          INPUT  T-Cheque.dias_clearing - 1,
                                          OUTPUT T-Cheque.fecha_deposito,
                                          OUTPUT T-Cheque.fecha_acredita).
        END.
        IF INPUT t-cheque.cdg_cuenta_ban <> "" THEN DO:
            FIND cuenta_bancaria WHERE cuenta_bancaria.cdg_cuenta = INPUT t-cheque.cdg_cuenta_ban NO-LOCK NO-ERROR.
            IF NOT AVAILABLE cuenta_bancaria THEN DO:
                MESSAGE "Cuenta bancaria inexistente" VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
            END.
            RUN poner_cuenta_bancaria.
        END.
        p-nro_linea-o = T-Caj_detalle.nro_linea.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_detalle.cambio
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_detalle.cambio Dialog-Frame
ON LEAVE OF T-Caj_detalle.cambio IN FRAME Dialog-Frame /* Cambio */
DO:
  v-importe = ( INPUT T-Caj_detalle.divisas * INPUT T-Caj_detalle.cambio ).
  DISPLAY v-importe @ T-Caj_detalle.importe
      WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Valor.cdg_banco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.cdg_banco Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF T-Valor.cdg_banco IN FRAME Dialog-Frame /* Banco */
OR "MOUSE-MENU-DOWN" OF T-Valor.cdg_banco IN FRAME {&FRAME-NAME}
DO:
    RUN selbanco.p ( INPUT-OUTPUT rid_tabla, INPUT YES ).
    IF rid_tabla <> ?
    THEN DO:
         FIND Banco WHERE ROWID(Banco) = rid_tabla NO-LOCK.
         DISPLAY Banco.cdg_banco @ T-Valor.cdg_banco
                 WITH  FRAME {&FRAME-NAME}.
         APPLY "RETURN" TO SELF.
    END.       
    RETURN NO-APPLY.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.cdg_banco Dialog-Frame
ON RETURN OF T-Valor.cdg_banco IN FRAME Dialog-Frame /* Banco */
DO:
    FIND Banco WHERE Banco.cdg_banco = INPUT FRAME {&FRAME-NAME} T-Valor.cdg_banco NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Banco 
    THEN DO:
         RUN PONMENSJ.P ( 'IREF002' ).
         RETURN NO-APPLY.
    END.

    DISPLAY Banco.nombre 
            WITH FRAME {&FRAME-NAME}. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Cheque.cdg_cuenta_ban
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Cheque.cdg_cuenta_ban Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF T-Cheque.cdg_cuenta_ban IN FRAME Dialog-Frame /* Cuenta */
OR "MOUSE-MENU-DOWN" OF T-Cheque.cdg_cuenta_ban IN FRAME {&FRAME-NAME}
DO:
    RUN selcuenta_banco.p ( INPUT Rubro.cdg_banco, INPUT-OUTPUT rid_tabla, INPUT YES ).
    IF rid_tabla <> ?
    THEN DO:
         FIND Cuenta_bancaria WHERE ROWID(Cuenta_bancaria) = rid_tabla NO-LOCK.
         DISPLAY Cuenta_bancaria.cdg_cuenta_ban @ T-Cheque.cdg_cuenta_ban
                 WITH  FRAME {&FRAME-NAME}.
         APPLY "RETURN" TO SELF.
    END.       
    RETURN NO-APPLY.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Cheque.cdg_cuenta_ban Dialog-Frame
ON RETURN OF T-Cheque.cdg_cuenta_ban IN FRAME Dialog-Frame /* Cuenta */
DO:
    FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = INPUT FRAME {&FRAME-NAME} T-Cheque.cdg_cuenta_ban NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Cuenta_bancaria 
    THEN DO:
         RUN PONMENSJ.P ( 'IREF002' ).
         RETURN NO-APPLY.
    END.
    ELSE DO:
        IF Cuenta_bancaria.cdg_banco <> Rubro.cdg_banco
        THEN DO:
             RUN PONMENSJ.P ( 'CAJA027' ).
             RETURN NO-APPLY.
        END.

    END.

    DISPLAY Cuenta_bancaria.denominacion_cta 
            WITH FRAME {&FRAME-NAME}. 
    RUN poner_cuenta_bancaria.    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Valor.dias_clearing
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.dias_clearing Dialog-Frame
ON LEAVE OF T-Valor.dias_clearing IN FRAME Dialog-Frame /* Clearing */
DO:
/*    IF T-Caj_header.fecha - INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision > 30                      */
/*     THEN DO:                                                                                         */
/*        RUN PONMENSJ.P ( INPUT "VALR004" ).                                                           */
/*        RETURN NO-APPLY.                                                                              */
/*     END.                                                                                             */
/*                                                                                                      */
/*     IF WEEKDAY(INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) = 1 OR                               */
/*        WEEKDAY(INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) = 7                                  */
/*     THEN DO:                                                                                         */
/*        RUN PONMENSJ.P ( INPUT "VALR002" ).                                                           */
/*     END.                                                                                             */
/*                                                                                                      */
/*     IF CAN-FIND(FIRST Feriado WHERE Feriado.fecha = INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) */
/*     THEN DO:                                                                                         */
/*        RUN PONMENSJ.P ( INPUT "VALR003" ).                                                           */
/*     END.                                                                                             */
/*     RUN calcular_fecha_valor.p ( INPUT  INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision,             */
/*                                  INPUT  INPUT FRAME {&FRAME-NAME} T-Valor.dias_clearing,             */
/*                                  OUTPUT v-fecha_deposito,                                            */
/*                                  OUTPUT v-fecha_acredita).                                           */
/*     DISPLAY v-fecha_deposito @ T-Valor.fecha_deposito                                                */
/*             v-fecha_acredita @ T-Valor.fecha_acredita                                                */
/*             WITH FRAME {&FRAME-NAME}.                                                                */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.dias_clearing Dialog-Frame
ON RETURN OF T-Valor.dias_clearing IN FRAME Dialog-Frame /* Clearing */
DO:
  RUN validar_fechas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Caj_detalle.divisas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Caj_detalle.divisas Dialog-Frame
ON LEAVE OF T-Caj_detalle.divisas IN FRAME Dialog-Frame /* Divisas */
DO:
  v-importe = ( INPUT T-Caj_detalle.divisas * INPUT T-Caj_detalle.cambio ).
  DISPLAY v-importe @ T-Caj_detalle.importe
      WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Valor.fecha_emision
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.fecha_emision Dialog-Frame
ON LEAVE OF T-Valor.fecha_emision IN FRAME Dialog-Frame /* Pago */
DO:
                    
/*     IF T-Caj_header.fecha - INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision > 30                     */
/*     THEN DO:                                                                                         */
/*        RUN PONMENSJ.P ( INPUT "VALR004" ).                                                           */
/*        RETURN NO-APPLY.                                                                              */
/*     END.                                                                                             */
/*                                                                                                      */
/*     IF WEEKDAY(INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) = 1 OR                               */
/*        WEEKDAY(INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) = 7                                  */
/*     THEN DO:                                                                                         */
/*        RUN PONMENSJ.P ( INPUT "VALR002" ).                                                           */
/*     END.                                                                                             */
/*                                                                                                      */
/*     IF CAN-FIND(FIRST Feriado WHERE Feriado.fecha = INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) */
/*     THEN DO:                                                                                         */
/*        RUN PONMENSJ.P ( INPUT "VALR003" ).                                                           */
/*     END.                                                                                             */
/*     RUN calcular_fecha_valor.p ( INPUT  INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision,             */
/*                                  INPUT  INPUT FRAME {&FRAME-NAME} T-Valor.dias_clearing,             */
/*                                  OUTPUT v-fecha_deposito,                                            */
/*                                  OUTPUT v-fecha_acredita).                                           */
/*     DISPLAY v-fecha_deposito @ T-Valor.fecha_deposito                                                */
/*             v-fecha_acredita @ T-Valor.fecha_acredita                                                */
/*             WITH FRAME {&FRAME-NAME}.                                                                */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.fecha_emision Dialog-Frame
ON RETURN OF T-Valor.fecha_emision IN FRAME Dialog-Frame /* Pago */
DO:
  RUN validar_fechas.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Cheque.fecha_emision
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Cheque.fecha_emision Dialog-Frame
ON LEAVE OF T-Cheque.fecha_emision IN FRAME Dialog-Frame /* Emitido */
DO:

    IF WEEKDAY( INPUT FRAME {&FRAME-NAME} T-Cheque.fecha_emision) = 1 OR
       WEEKDAY( INPUT FRAME {&FRAME-NAME} T-Cheque.fecha_emision) = 7
    THEN DO:
       RUN PONMENSJ.P ( INPUT "CHEQ002" ).
    END.

    IF CAN-FIND(FIRST Feriado WHERE Feriado.fecha = INPUT FRAME {&FRAME-NAME} T-Cheque.fecha_emision)
    THEN DO:
       RUN PONMENSJ.P ( INPUT "CHEQ003" ).
    END.

    RUN calcular_fecha_valor.p ( INPUT  INPUT FRAME {&FRAME-NAME} T-Cheque.fecha_emision,
                                 INPUT  INPUT FRAME {&FRAME-NAME} T-Cheque.dias_clearing - 1,
                                 OUTPUT v-fecha_deposito,
                                 OUTPUT v-fecha_acredita).
    DISPLAY v-fecha_deposito @ T-Cheque.fecha_deposito 
            v-fecha_acredita @ T-Cheque.fecha_acredita
            WITH FRAME {&FRAME-NAME}.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME T-Valor.numero_cheque
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL T-Valor.numero_cheque Dialog-Frame
ON RETURN OF T-Valor.numero_cheque IN FRAME Dialog-Frame /* Cheque Nro. */
OR TAB OF T-Valor.numero_cheque IN FRAME  {&FRAME-NAME}
DO:
  

   IF T-Caj_detalle.tipo_mov = "I"
   THEN DO:
     
      IF CAN-FIND(Valor WHERE Valor.cdg_banco      = INPUT T-Valor.cdg_banco 
                          AND Valor.cdg_sucurbanco = INPUT T-Valor.cdg_sucurbanco 
                          AND Valor.numero_cheque  = INPUT T-Valor.numero_cheque
                          AND Valor.cdg_caja       = v-cdg_caja )
      THEN DO:
         RUN PONMENSJ.P (INPUT "CAJA006").
         RETURN NO-APPLY.
      END.   
   END.
   ELSE DO:
     
      FIND Valor WHERE Valor.cdg_banco      = INPUT T-Valor.cdg_banco 
                   AND Valor.cdg_sucurbanco = INPUT T-Valor.cdg_sucurbanco 
                   AND Valor.numero_cheque  = INPUT T-Valor.numero_cheque 
                   AND Valor.cdg_caja       = v-cdg_caja NO-LOCK NO-ERROR.
      
      IF NOT AVAILABLE Valor
      THEN DO:
         RUN PONMENSJ.P (INPUT "CAJA010").
         RETURN NO-APPLY.
      END.   
      ELSE DO:
         IF Valor.estado <> "00"
         THEN DO:
            RUN PONMENSJ.P (INPUT "CAJA011").
            RETURN NO-APPLY.
         END.   
         ELSE DO:
             DISPLAY Valor.importe @ T-Caj_detalle.importe 
                     Valor.fecha_emision @ T-Valor.fecha_emision
                     Valor.fecha_deposito @ T-Valor.fecha_deposito
                     Valor.fecha_acredita @ T-Valor.fecha_acredita
                     WITH FRAME {&FRAME-NAME}.
         END.

      END.

   END.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

  FIND FIRST T-Caj_header.

  IF p-modo-detalle = 0
  THEN DO:
     FIND Rubro WHERE Rubro.cdg_rubro = p-cdg_rubro NO-LOCK.
     ASSIGN v-cdg_rubro = Rubro.cdg_rubro
            v-dsc_rubro = Rubro.nombre.

     CREATE T-Caj_detalle.
     ASSIGN T-Caj_detalle.tipo_mov         = T-Caj_header.tipo_mov
            T-Caj_detalle.cdg_rubro        = Rubro.cdg_rubro
            T-Caj_detalle.importe          = T-Caj_header.importe - T-Caj_header.ingreso.
     IF Rubro.tipo = "C" /* Es un valor de cambio, o sea una divisa */
     THEN DO:
         FIND Moneda OF Rubro NO-LOCK.
         RUN cotizar_moneda.p ( INPUT Moneda.cdg_moneda,
                                INPUT T-Caj_header.cdg_empresa,
                                INPUT T-Caj_header.fecha,
                                OUTPUT T-Caj_detalle.cambio,
                                OUTPUT x-fecha_cambio ).
         T-Caj_detalle.divisas = T-Caj_detalle.importe / T-Caj_detalle.cambio.
         /* Una vez hallada la cantidad de divisas, volvemos a hacer la cuenta para planchar los redondeos */
         T-Caj_detalle.importe = T-Caj_detalle.divisas * T-Caj_detalle.cambio. 
     END.

  END.
  ELSE DO:
     FIND T-Caj_detalle WHERE T-Caj_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
     FIND Rubro OF T-Caj_detalle NO-LOCK.
     ASSIGN v-cdg_rubro = Rubro.cdg_rubro
            v-dsc_rubro = Rubro.nombre.
   /*RUN traer_tablas.*/
     IF Rubro.tipo = "V"
     THEN DO:
        FIND T-Valor OF T-Caj_detalle EXCLUSIVE-LOCK.
        FIND Banco  OF T-Valor      NO-LOCK NO-ERROR.
     END.

     IF Rubro.tipo = "P"
     THEN DO:
        FIND T-Cheque OF T-Caj_detalle EXCLUSIVE-LOCK NO-ERROR.
        FIND Cuenta_bancaria  OF T-Cheque  NO-LOCK NO-ERROR.
     END.

  END.

  DISPLAY v-cdg_rubro
          v-dsc_rubro
          T-Caj_detalle.observacion
          T-Caj_detalle.tipo_mov     
          T-Caj_detalle.importe      
          T-Caj_detalle.cambio       
          T-Caj_detalle.divisas    
          T-Caj_detalle.numero_certificado    
          T-Valor.cdg_banco                 WHEN AVAILABLE T-Valor
          Banco.nombre                      WHEN AVAILABLE Banco
          T-Valor.cdg_sucurbanco            WHEN AVAILABLE T-Valor
          T-Valor.numero_cheque             WHEN AVAILABLE T-Valor
          T-Valor.numero_cuenta_val         WHEN AVAILABLE T-Valor
          T-Valor.fecha_emision             WHEN AVAILABLE T-Valor
          T-Valor.dias_clearing             WHEN AVAILABLE T-Valor
          T-Valor.fecha_deposito            WHEN AVAILABLE T-Valor
          T-Valor.fecha_acredita            WHEN AVAILABLE T-Valor
          T-Valor.estado                    WHEN AVAILABLE T-Valor
          T-Cheque.cdg_cuenta_ban           WHEN AVAILABLE Cuenta_bancaria
          Cuenta_bancaria.denominacion_cta  WHEN AVAILABLE Cuenta_bancaria
          T-Cheque.numero_cheque            WHEN AVAILABLE T-Cheque
          T-Cheque.fecha_emision            WHEN AVAILABLE T-Cheque
          T-Cheque.dias_clearing            WHEN AVAILABLE T-Cheque
          T-Cheque.fecha_deposito           WHEN AVAILABLE T-Cheque
          T-Cheque.fecha_acredita           WHEN AVAILABLE T-Cheque
          WITH FRAME {&FRAME-NAME}.

  RUN habilitar_campos.

/*WAIT-FOR GO OF FRAME {&FRAME-NAME}.*/

  WAIT-FOR U1 OF THIS-PROCEDURE.
  CASE codigo_salir:
       WHEN CD_SALIR    THEN UNDO,LEAVE.
       WHEN CD_CANCELAR THEN UNDO,RETRY.
       WHEN CD_GRABAR   THEN LEAVE.
  END CASE.

END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
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
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY v-cdg_rubro v-dsc_rubro 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Banco THEN 
    DISPLAY Banco.nombre 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE Cuenta_bancaria THEN 
    DISPLAY Cuenta_bancaria.denominacion_cta 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Caj_detalle THEN 
    DISPLAY T-Caj_detalle.tipo_mov T-Caj_detalle.observacion T-Caj_detalle.importe 
          T-Caj_detalle.cambio T-Caj_detalle.divisas 
          T-Caj_detalle.numero_certificado 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Cheque THEN 
    DISPLAY T-Cheque.cdg_cuenta_ban T-Cheque.numero_cheque T-Cheque.fecha_emision 
          T-Cheque.dias_clearing T-Cheque.fecha_deposito T-Cheque.fecha_acredita 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Valor THEN 
    DISPLAY T-Valor.cdg_banco T-Valor.cdg_sucurbanco T-Valor.numero_cheque 
          T-Valor.numero_cuenta_val T-Valor.fecha_emision T-Valor.dias_clearing 
          T-Valor.estado T-Valor.fecha_deposito T-Valor.fecha_acredita 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-13 RECT-14 RECT-15 RECT-16 RECT-17 RECT-18 RECT-19 RECT-20 
         T-Caj_detalle.observacion T-Caj_detalle.importe T-Caj_detalle.cambio 
         T-Caj_detalle.divisas T-Valor.cdg_banco T-Cheque.cdg_cuenta_ban 
         T-Valor.numero_cheque T-Valor.numero_cuenta_val T-Cheque.numero_cheque 
         T-Valor.fecha_emision T-Valor.dias_clearing T-Valor.estado 
         T-Cheque.fecha_emision T-Cheque.dias_clearing T-Valor.fecha_deposito 
         T-Valor.fecha_acredita T-Cheque.fecha_deposito T-Cheque.fecha_acredita 
         Btn_OK Btn_Cancel T-Caj_detalle.numero_certificado 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE habilitar_campos Dialog-Frame 
PROCEDURE habilitar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DO WITH FRAME {&FRAME-NAME}:

     ASSIGN
          v-cdg_rubro:SENSITIVE                       = NO
          T-Caj_detalle.observacion:SENSITIVE         = NO
          T-Caj_detalle.tipo_mov:SENSITIVE            = NO     
          T-Caj_detalle.importe:SENSITIVE             = NO      
          T-Caj_detalle.cambio:SENSITIVE              = NO       
          T-Caj_detalle.divisas:SENSITIVE             = NO    
          T-Caj_detalle.numero_certificado:SENSITIVE  = NO
          T-Valor.cdg_banco:SENSITIVE                 = NO
          T-Valor.cdg_sucurbanco:SENSITIVE            = NO
          T-Valor.numero_cheque:SENSITIVE             = NO
          T-Valor.numero_cuenta_val:SENSITIVE         = NO
          T-Valor.fecha_emision:SENSITIVE             = NO
          T-Valor.dias_clearing:SENSITIVE             = NO
          T-Valor.fecha_deposito:SENSITIVE            = NO
          T-Valor.fecha_acredita:SENSITIVE            = NO
          T-Valor.estado:SENSITIVE                    = NO
          T-Cheque.cdg_cuenta_ban:SENSITIVE           = NO
          T-Cheque.numero_cheque:SENSITIVE            = NO
          T-Cheque.fecha_emision:SENSITIVE            = NO
          T-Cheque.dias_clearing:SENSITIVE            = NO
          T-Cheque.fecha_deposito:SENSITIVE           = NO
          T-Cheque.fecha_acredita:SENSITIVE           = NO
          Btn_OK:SENSITIVE                            = NO.

     IF p-modo-cabecera = MD_ALTA
     THEN DO:
         CASE p-modo-detalle:
            WHEN MD_ALTA                   
            THEN DO:
                ASSIGN
                     T-Caj_detalle.observacion:SENSITIVE         = YES
                     T-Caj_detalle.importe:SENSITIVE             = ( Rubro.tipo = "V" AND T-Caj_detalle.tipo_mov = "I" ) 
                                                                   OR LOOKUP(Rubro.tipo,"D,P,A,B,R" ) <> 0
                     T-Caj_detalle.cambio:SENSITIVE              = Rubro.tipo = "C"       
                     T-Caj_detalle.divisas:SENSITIVE             = Rubro.tipo = "C"
                     T-Caj_detalle.numero_certificado:SENSITIVE  = Rubro.tipo = "R" AND T-Caj_detalle.tipo_mov = "I"
                     T-Valor.cdg_banco:SENSITIVE                 = Rubro.tipo = "V"
                     T-Valor.cdg_sucurbanco:SENSITIVE            = Rubro.tipo = "V"
                     T-Valor.numero_cheque:SENSITIVE             = Rubro.tipo = "V"
                     T-Valor.numero_cuenta_val:SENSITIVE         = Rubro.tipo = "V"
                     T-Valor.fecha_emision:SENSITIVE             = Rubro.tipo = "V" AND T-Caj_detalle.tipo_mov = "I"
                     T-Valor.dias_clearing:SENSITIVE             = Rubro.tipo = "V" AND T-Caj_detalle.tipo_mov = "I"
                     T-Valor.fecha_deposito:SENSITIVE            = NO
                     T-Valor.fecha_acredita:SENSITIVE            = NO
                     T-Valor.estado:SENSITIVE                    = NO
                     T-Cheque.cdg_cuenta_ban:SENSITIVE           = LOOKUP(Rubro.tipo,"P,A,B" ) <> 0
                     T-Cheque.numero_cheque:SENSITIVE            = NO
                     T-Cheque.fecha_emision:SENSITIVE            = Rubro.tipo = "P"
                     T-Cheque.dias_clearing:SENSITIVE            = Rubro.tipo = "P"
                     T-Cheque.fecha_deposito:SENSITIVE           = NO
                     T-Cheque.fecha_acredita:SENSITIVE           = NO
                     Btn_OK:SENSITIVE                            = YES.
            END.

            WHEN MD_MULTIPLE               
            THEN DO:
                ASSIGN
                     T-Caj_detalle.observacion:SENSITIVE         = YES
                     T-Caj_detalle.importe:SENSITIVE             = ( Rubro.tipo = "V" AND T-Caj_detalle.tipo_mov = "I" ) 
                                                                   OR LOOKUP(Rubro.tipo,"D,P,A,B,R" ) <> 0
                     T-Caj_detalle.cambio:SENSITIVE              = Rubro.tipo = "C"       
                     T-Caj_detalle.divisas:SENSITIVE             = Rubro.tipo = "C"
                     T-Valor.cdg_banco:SENSITIVE                 = NO
                     T-Valor.cdg_sucurbanco:SENSITIVE            = NO
                     T-Valor.numero_cheque:SENSITIVE             = NO
                     T-Valor.numero_cuenta_val:SENSITIVE         = NO
                     T-Valor.fecha_emision:SENSITIVE             = NO
                     T-Valor.dias_clearing:SENSITIVE             = NO
                     T-Valor.fecha_deposito:SENSITIVE            = NO
                     T-Valor.fecha_acredita:SENSITIVE            = NO
                     T-Valor.estado:SENSITIVE                    = NO
                     T-Cheque.cdg_cuenta_ban:SENSITIVE           = NO
                     T-Cheque.numero_cheque:SENSITIVE            = NO
                     T-Cheque.fecha_emision:SENSITIVE            = Rubro.tipo = "P"
                     T-Cheque.dias_clearing:SENSITIVE            = Rubro.tipo = "P"
                     T-Cheque.fecha_deposito:SENSITIVE           = NO
                     T-Cheque.fecha_acredita:SENSITIVE           = NO
                     Btn_OK:SENSITIVE                            = YES.

            END.

            WHEN MD_DEFINIDA               
            THEN DO:
               /* nada habilitado */
            END.

            WHEN MD_RELACION               
            THEN DO:
               /* nada habilitado */
            END.

            WHEN MD_READONLY               
            THEN DO:
               /* nada habilitado */
            END.

            WHEN MD_CAMBIO                 
            THEN DO:
               /* nada habilitado */
            END.

            WHEN MD_GENERADO               
            THEN DO:
               /* nada habilitado */
            END.

            WHEN MD_ANULACION              
            THEN DO:
               /* nada habilitado */
            END.

            WHEN MD_EMISION                
            THEN DO:
               /* nada habilitado */
            END.

        END CASE.

     END.

  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_cuenta_bancaria Dialog-Frame 
PROCEDURE poner_cuenta_bancaria :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   CASE Rubro.tipo:

        WHEN "P" /* Se trata de un cheque propio */
        THEN DO:
             IF Cuenta_bancaria.autonumera
             THEN DO:
                  RUN proximo_cheque.
                  IF RETURN-VALUE = ""
                     THEN ENABLE T-Cheque.fecha_emision
                                 T-Cheque.dias_clearing
                                 WITH FRAME {&FRAME-NAME}.
                     ELSE RETURN ERROR.            
             END.            
             ELSE ENABLE T-Cheque.numero_cheque
                         T-Cheque.fecha_emision
                         T-Cheque.dias_clearing
                         WITH FRAME {&FRAME-NAME}.
        END.                    
        WHEN "A"  /* Acreditacion bancaria */
        THEN DO:
             T-Caj_detalle.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban.
        END.                    
        WHEN "B"  /* Débito Bancario */
        THEN DO:
             T-Caj_detalle.cdg_cuenta_ban = Cuenta_bancaria.cdg_cuenta_ban.
        END.                    

   END CASE. 
   IF AVAILABLE  T-Cheque THEN DO:
       RUN getparametro_d.p ( "DLFCLEAR" , OUTPUT T-Cheque.dias_clearing ).
       DISPLAY T-Cheque.dias_clearing
           WITH FRAME {&FRAME-NAME}.
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proximo_cheque Dialog-Frame 
PROCEDURE proximo_cheque :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   FIND FIRST Chequera OF Cuenta_bancaria 
        WHERE Chequera.ultimo_cheque < Chequera.hasta_cheque EXCLUSIVE-LOCK NO-WAIT NO-ERROR.
        
   IF NOT AVAILABLE Chequera
   THEN IF LOCKED Chequera
        THEN DO:
           RUN PONMENSJ.P (INPUT "CAJA015").
           RETURN ERROR.
        END.
        ELSE DO:
           RUN PONMENSJ.P (INPUT "CAJA016").
           RETURN ERROR.
        END.
   
   IF Chequera.ultimo_cheque = 0
   THEN DO:
       DISPLAY Chequera.desde_cheque @ T-Cheque.numero_cheque
           WITH FRAME {&FRAME-NAME}.
       Chequera.ultimo_cheque = Chequera.desde_cheque.
   END.
   ELSE DO:
       Chequera.ultimo_cheque = Chequera.ultimo_cheque + 1.
       DISPLAY Chequera.ultimo_cheque @ T-Cheque.numero_cheque
            WITH FRAME {&FRAME-NAME}.
       
   END.

   DISABLE T-Cheque.numero_cheque
           WITH FRAME {&FRAME-NAME}.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas Dialog-Frame 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  IF Rubro.tipo = "V"
  THEN DO:
     FIND T-Valor OF T-Caj_detalle EXCLUSIVE-LOCK.
     FIND Banco  OF T-Valor      NO-LOCK NO-ERROR.
  END.

  IF Rubro.tipo = "P"
  THEN DO:
     FIND T-Cheque OF T-Caj_detalle EXCLUSIVE-LOCK NO-ERROR.
     FIND Cuenta_bancaria  OF T-Cheque  NO-LOCK NO-ERROR.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   hay_error = YES.
/*{debug.i}*/
   DO WITH FRAME {&FRAME-NAME}:
      IF rubro.requiere_observacion AND INPUT t-caj_detalle.observacion = "" THEN DO:
          MESSAGE "El rubro requiere que indique una observacion" VIEW-AS ALERT-BOX ERROR.
          RETURN.
      END.
      IF INPUT  T-Caj_detalle.importe < 0 AND NOT rubro.admite_negativo THEN DO:
          MESSAGE "Este rubro de caja NO admite valores negativos"
              VIEW-AS ALERT-BOX ERROR.
          RETURN.
      END.

       IF INPUT  T-Caj_detalle.importe = 0
       THEN DO:
          RUN PONMENSJ.P (INPUT "CAJA003").
          RETURN.
       END.   
    
       IF Rubro.imp_maximo < INPUT T-Caj_detalle.importe AND Rubro.imp_maximo <> 0 THEN DO:
           MESSAGE "Se ha superado el maximo de " Rubro.imp_maximo SKIP
               "permitido para este rubro de caja" VIEW-AS ALERT-BOX ERROR.
           RETURN.
       END.

       IF Rubro.imp_minimo < INPUT T-Caj_detalle.importe AND Rubro.imp_minimo <> 0 THEN DO:
       MESSAGE "Se ha superado el minimo de " Rubro.imp_minimo SKIP
           "permitido para este rubro de caja" VIEW-AS ALERT-BOX ERROR.
       RETURN.
   END.



       IF T-Cheque.cdg_cuenta_ban:SENSITIVE 
       THEN DO:
            IF NOT CAN-FIND(Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = T-Cheque.cdg_cuenta_ban:INPUT-VALUE)
    
            THEN DO:
               RUN PONMENSJ.P (INPUT "CAJA023").
               RETURN.
            END.      
    
       END.
       
       CASE Rubro.tipo:

           WHEN "V" THEN DO:
               
               IF NOT CAN-FIND(Banco WHERE Banco.cdg_banco = T-Valor.cdg_banco:INPUT-VALUE)
               THEN DO:
                   RUN PONMENSJ.P (INPUT "CAJA004").
                   RETURN.
               END.      
    
               /* El valor no debe haber sido ingresado ya en este transacion */
    
               IF p-modo-detalle = MD_ALTA 
               THEN DO:
                   
                   IF CAN-FIND(T-Valor WHERE T-Valor.cdg_banco          = T-Valor.cdg_banco:INPUT-VALUE 
                                         AND T-Valor.cdg_sucurbanco     = T-Valor.cdg_sucurbanco:INPUT-VALUE
                                         AND T-Valor.numero_cheque      = T-Valor.numero_cheque:INPUT-VALUE
                                         AND T-Valor.numero_cuenta_val  = T-Valor.numero_cuenta_val:INPUT-VALUE)
                   THEN DO:
                       RUN PONMENSJ.P (INPUT "CAJA006").
                       RETURN.
                   END.           
        
        
                   IF T-Caj_detalle.tipo_mov = "I"
                   THEN DO:
                          /* en un INGRESO, el valor NO debe existir en la base de datos */
                       IF CAN-FIND(Valor WHERE Valor.cdg_banco          = T-Valor.cdg_banco:INPUT-VALUE         
                                           AND Valor.cdg_sucurbanco     = T-Valor.cdg_sucurbanco:INPUT-VALUE    
                                           AND Valor.numero_cheque      = T-Valor.numero_cheque:INPUT-VALUE     
                                           AND Valor.numero_cuenta_val  = T-Valor.numero_cuenta_val:INPUT-VALUE)
                       THEN DO:
                           RUN PONMENSJ.P (INPUT "CAJA030").
                           RETURN.
                       END.           
        
                       IF T-Valor.fecha_emision:INPUT-VALUE = ? 
                       THEN DO:
                           RUN PONMENSJ.P (INPUT "CAJA032").
                           RETURN.
                       END.
        
                       IF T-Valor.dias_clearing:INPUT-VALUE = "" 
                       THEN DO:
                           RUN PONMENSJ.P ( INPUT "VALR010" ).
                           RETURN.
                       END.
                       
        
                   END.
                   ELSE DO:

                       /* en un EGRESO, el valor SI debe existir en la base de datos y no debe haber sido egresado previamente */
                       IF NOT CAN-FIND(Valor WHERE Valor.cdg_banco          = T-Valor.cdg_banco:INPUT-VALUE         
                                               AND Valor.cdg_sucurbanco     = T-Valor.cdg_sucurbanco:INPUT-VALUE    
                                               AND Valor.numero_cheque      = T-Valor.numero_cheque:INPUT-VALUE     
                                               AND Valor.numero_cuenta_val  = T-Valor.numero_cuenta_val:INPUT-VALUE
                                               AND Valor.estado             = stchq_encarte)
                       THEN DO:
                           RUN PONMENSJ.P (INPUT "CAJA031").
                           RETURN.
                       END.           

                   END.
               END.
           END.

           WHEN "R" THEN DO:

               IF T-Caj_detalle.tipo_mov = "I" AND T-Caj_detalle.numero_certificado:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0
               THEN DO:
                   RUN PONMENSJ.P (INPUT "CAJA049").
                   RETURN.
               END.

           END.
         
       END CASE.  
   END.
   
   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_fechas Dialog-Frame 
PROCEDURE validar_fechas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR opt AS LOGICAL NO-UNDO.
  IF T-Caj_header.fecha - INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision > 30 
    THEN DO:
       MESSAGE "El valor ingresado es esta vencido" SKIP "Confirma" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
         IF NOT opt THEN
            RETURN error.
    END.
    IF INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision - T-Caj_header.fecha  > 120 
      THEN DO:
         MESSAGE "El valor ingresado es de mas de 120 dias" SKIP "Confirma" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE opt.
         IF NOT opt THEN
            RETURN error.
      END.



    IF WEEKDAY(INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) = 1 OR
       WEEKDAY(INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision) = 7
    THEN DO:
       RUN PONMENSJ.P ( INPUT "VALR002" ).
    END.

    IF CAN-FIND(FIRST Feriado WHERE Feriado.fecha = INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision)
    THEN DO:
       RUN PONMENSJ.P ( INPUT "VALR003" ).
    END.
    RUN calcular_fecha_valor.p ( INPUT  INPUT FRAME {&FRAME-NAME} T-Valor.fecha_emision,
                                 INPUT  INPUT FRAME {&FRAME-NAME} T-Valor.dias_clearing,
                                 OUTPUT v-fecha_deposito,
                                 OUTPUT v-fecha_acredita).
    DISPLAY v-fecha_deposito @ T-Valor.fecha_deposito 
            v-fecha_acredita @ T-Valor.fecha_acredita
            WITH FRAME {&FRAME-NAME}.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

