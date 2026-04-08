&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Fac_detalle NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_detalle-bon NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.


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
DEFINE VARIABLE           p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE VARIABLE           p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE VARIABLE           p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE           p-modo-detalle   AS INTEGER.
DEFINE VARIABLE           p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ELSE
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle-bon.
DEFINE INPUT   PARAMETER  p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE INPUT   PARAMETER  p-nro_linea-i    LIKE Asn_detalle.nro_linea.
DEFINE INPUT   PARAMETER  p-modo-cabecera  AS INTEGER.
DEFINE INPUT   PARAMETER  p-modo-detalle   AS INTEGER.
DEFINE OUTPUT  PARAMETER  p-nro_linea-o    LIKE Asn_detalle.nro_linea.
&ENDIF

/* Local Variable Definitions ---                                       */

{valoresmodo.i}
{valoressalida.i}

DEFINE VARIABLE           rid_tabla       AS ROWID.
DEFINE VARIABLE           hubo_error      AS LOGICAL.
DEFINE VARIABLE           hay_obras       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME BROWSE-7

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Fac_detalle-bon Bonificacion T-Fac_detalle

/* Definitions for BROWSE BROWSE-7                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-7 T-Fac_detalle-bon.cdg_bonificacion ~
Bonificacion.descripcion T-Fac_detalle-bon.porcentaje ~
T-Fac_detalle-bon.importe 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-7 
&Scoped-define QUERY-STRING-BROWSE-7 FOR EACH T-Fac_detalle-bon OF T-Fac_detalle NO-LOCK, ~
      EACH Bonificacion OF T-Fac_detalle-bon NO-LOCK
&Scoped-define OPEN-QUERY-BROWSE-7 OPEN QUERY BROWSE-7 FOR EACH T-Fac_detalle-bon OF T-Fac_detalle NO-LOCK, ~
      EACH Bonificacion OF T-Fac_detalle-bon NO-LOCK.
&Scoped-define TABLES-IN-QUERY-BROWSE-7 T-Fac_detalle-bon Bonificacion
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-7 T-Fac_detalle-bon
&Scoped-define SECOND-TABLE-IN-QUERY-BROWSE-7 Bonificacion


/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Fac_detalle.cantidad ~
T-Fac_detalle.granel T-Fac_detalle.precio T-Fac_detalle.precio_cf ~
T-Fac_detalle.subtotal_neto T-Fac_detalle.subtotal_neto_cf 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Fac_detalle.cantidad ~
T-Fac_detalle.granel T-Fac_detalle.precio T-Fac_detalle.precio_cf 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle
&Scoped-define OPEN-BROWSERS-IN-QUERY-Dialog-Frame ~
    ~{&OPEN-QUERY-BROWSE-7}
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Fac_detalle SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Fac_detalle SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Fac_detalle
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Fac_detalle


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Fac_detalle.cantidad T-Fac_detalle.granel ~
T-Fac_detalle.precio T-Fac_detalle.precio_cf 
&Scoped-define ENABLED-TABLES T-Fac_detalle
&Scoped-define FIRST-ENABLED-TABLE T-Fac_detalle
&Scoped-Define ENABLED-OBJECTS v-cdg_bonificacion v-porcentaje BROWSE-7 ~
Btn_OK Btn_Cancel btn_crear btn_eliminar RECT-10 RECT-11 RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Fac_detalle.cantidad T-Fac_detalle.granel ~
T-Fac_detalle.precio T-Fac_detalle.precio_cf T-Fac_detalle.subtotal_neto ~
T-Fac_detalle.subtotal_neto_cf 
&Scoped-define DISPLAYED-TABLES T-Fac_detalle
&Scoped-define FIRST-DISPLAYED-TABLE T-Fac_detalle
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo ~
v-cdg_partida v-dsc_partida v-cdg_entidad v-dsc_entidad v-cdg_obra ~
v-dsc_obra v-cdg_umed v-cdg_ugranel v-cdg_bonificacion v-dsc_bonificacion ~
v-porcentaje 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_crear 
     LABEL "Crear &Bonificacion" 
     SIZE 31 BY 1.14.

DEFINE BUTTON btn_eliminar 
     LABEL "Eliminar &Bonificacion" 
     SIZE 30 BY 1.14.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 12 BY 1.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_bonificacion AS INTEGER FORMAT ">>>>9" INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_partida AS CHARACTER FORMAT "X(256)":U 
     LABEL "Partida" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_ugranel AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_umed AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 64 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_bonificacion AS CHARACTER FORMAT "X(50)" 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 7 FGCOLOR 15 .

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 64 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_partida AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 64 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-porcentaje AS DECIMAL FORMAT ">>9.99":U INITIAL 0 
     LABEL "%" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 9.95.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 2.52.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 2.57.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-7 FOR 
      T-Fac_detalle-bon, 
      Bonificacion SCROLLING.

DEFINE QUERY Dialog-Frame FOR 
      T-Fac_detalle SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 Dialog-Frame _STRUCTURED
  QUERY BROWSE-7 NO-LOCK DISPLAY
      T-Fac_detalle-bon.cdg_bonificacion COLUMN-LABEL "Có-!digo" FORMAT "ZZ9":U
      Bonificacion.descripcion COLUMN-LABEL "Descripción!Bonificación" FORMAT "X(28)":U
            WIDTH 31
      T-Fac_detalle-bon.porcentaje COLUMN-LABEL "%.!Bon." FORMAT "->>9.99":U
      T-Fac_detalle-bon.importe COLUMN-LABEL "Importe!Bonificado" FORMAT "->,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SIZE 63 BY 5.38
         TITLE "Bonificaciones del Item de Factura".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.48 COL 12 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.48 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_partida AT ROW 2.67 COL 12 COLON-ALIGNED
     v-dsc_partida AT ROW 2.67 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 4.1 COL 12 COLON-ALIGNED
     v-dsc_entidad AT ROW 4.1 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 5.29 COL 12 COLON-ALIGNED
     v-dsc_obra AT ROW 5.29 COL 31 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 5.29 COL 85
     T-Fac_detalle.cantidad AT ROW 6.95 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_umed AT ROW 6.95 COL 31 COLON-ALIGNED NO-LABEL
     T-Fac_detalle.granel AT ROW 6.95 COL 61 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_ugranel AT ROW 6.95 COL 84 COLON-ALIGNED NO-LABEL
     T-Fac_detalle.precio AT ROW 8.14 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     v-cdg_bonificacion AT ROW 8.14 COL 31 COLON-ALIGNED NO-LABEL
     v-dsc_bonificacion AT ROW 8.14 COL 40 COLON-ALIGNED NO-LABEL
     v-porcentaje AT ROW 8.14 COL 84 COLON-ALIGNED
     T-Fac_detalle.precio_cf AT ROW 9.33 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     BROWSE-7 AT ROW 9.38 COL 33
     T-Fac_detalle.subtotal_neto AT ROW 10.52 COL 12 COLON-ALIGNED
          LABEL "Neto"
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Fac_detalle.subtotal_neto_cf AT ROW 11.71 COL 12 COLON-ALIGNED
          LABEL "Neto CF."
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 12.91 COL 14
     Btn_Cancel AT ROW 14.24 COL 14
     btn_crear AT ROW 15.05 COL 33
     btn_eliminar AT ROW 15.05 COL 66
     RECT-10 AT ROW 6.67 COL 2
     RECT-11 AT ROW 3.95 COL 2
     RECT-9 AT ROW 1.29 COL 2
     SPACE(0.99) SKIP(13.04)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle del Comprobante"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Fac_detalle T "?" NO-UNDO sic Fac_detalle
      TABLE: T-Fac_detalle-bon T "?" NO-UNDO sic Fac_detalle-bon
      TABLE: T-Fac_header T "?" NO-UNDO sic Fac_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
/* BROWSE-TAB BROWSE-7 precio_cf Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_neto IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN T-Fac_detalle.subtotal_neto_cf IN FRAME Dialog-Frame
   NO-ENABLE EXP-LABEL                                                  */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_ugranel IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_umed IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_bonificacion IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _TblList          = "Temp-Tables.T-Fac_detalle-bon OF Temp-Tables.T-Fac_detalle,sic.Bonificacion OF Temp-Tables.T-Fac_detalle-bon"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > Temp-Tables.T-Fac_detalle-bon.cdg_bonificacion
"T-Fac_detalle-bon.cdg_bonificacion" "Có-!digo" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic.Bonificacion.descripcion
"Bonificacion.descripcion" "Descripción!Bonificación" "X(28)" "character" ? ? ? ? ? ? no ? no no "31" yes no no "U" "" ""
     _FldNameList[3]   > Temp-Tables.T-Fac_detalle-bon.porcentaje
"T-Fac_detalle-bon.porcentaje" "%.!Bon." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > Temp-Tables.T-Fac_detalle-bon.importe
"T-Fac_detalle-bon.importe" "Importe!Bonificado" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Fac_detalle"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle del Comprobante */
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
      FOR EACH T-Fac_detalle-bon OF T-Fac_detalle:
          DELETE T-Fac_detalle-bon.
      END.
      DELETE T-Fac_detalle.  
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_crear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_crear Dialog-Frame
ON CHOOSE OF btn_crear IN FRAME Dialog-Frame /* Crear Bonificacion */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-cdg_bonificacion v-porcentaje.
  FIND Bonificacion WHERE Bonificacion.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
  IF AVAILABLE Bonificacion 
  THEN DO:
       FIND T-Fac_detalle-bon 
            WHERE T-Fac_detalle-bon.cdg_bonificacion = v-cdg_bonificacion NO-LOCK NO-ERROR.
       IF AVAILABLE T-Fac_detalle-bon 
       THEN DO:
            RUN ponmensj.p ( INPUT "BONI002").
            RETURN NO-APPLY.
       END.
       ELSE DO:
            DO TRANSACTION:
               CREATE T-Fac_detalle-bon.
               ASSIGN T-Fac_detalle-bon.cdg_bonificacion = v-cdg_bonificacion
                      T-Fac_detalle-bon.porcentaje       = v-porcentaje
                      T-Fac_detalle-bon.nro_factura      = T-Fac_detalle.nro_factura
                      T-Fac_detalle-bon.nro_linea        = T-Fac_detalle.nro_linea. 
            END.
            {&OPEN-QUERY-{&BROWSE-NAME}}
            ASSIGN  v-cdg_bonificacion = 0
                    v-dsc_bonificacion = ""
                    v-porcentaje       = 0.
            DISPLAY v-cdg_bonificacion
                    v-dsc_bonificacion
                    v-porcentaje
                    WITH FRAME {&FRAME-NAME}.
       END.
  END.
  ELSE DO:
       RUN ponmensj.p ( INPUT "BONI002").
       RETURN NO-APPLY.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_eliminar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_eliminar Dialog-Frame
ON CHOOSE OF btn_eliminar IN FRAME Dialog-Frame /* Eliminar Bonificacion */
DO:
    DEFINE VARIABLE sino-msg AS LOGICAL.
    IF NOT AVAILABLE T-Fac_detalle-bon
    THEN DO:
         RUN ponmensj.p ( INPUT "BONI003").
         RETURN NO-APPLY.
    END.
    ELSE DO:
         sino-msg = NO.
         MESSAGE "Realmente desea eliminar esta Bonificación?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmación" UPDATE sino-msg.
         IF sino-msg
         THEN DO:
              DO TRANSACTION:              
                 DELETE T-Fac_detalle-bon.
                 {&OPEN-QUERY-{&BROWSE-NAME}}                 
              END. 
         END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME}
        v-cdg_partida
        v-cdg_entidad
        v-cdg_obra
        T-Fac_detalle.cantidad 
        T-Fac_detalle.granel 
        T-Fac_detalle.precio
        T-Fac_detalle.precio_cf.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Fac_header.ultima_linea     = T-Fac_header.ultima_linea + 1
                T-Fac_detalle.nro_factura     = T-Fac_header.nro_factura
                T-Fac_detalle.nro_linea       = T-Fac_header.ultima_linea.
        END.

        FOR EACH T-Fac_detalle-bon WHERE T-Fac_detalle-bon.nro_linea = 0:
            ASSIGN
                /*T-Fac_detalle-bon.nro_factura = T-Fac_detalle.nro_factura*/
                T-Fac_detalle-bon.nro_linea   = T-Fac_detalle.nro_linea.
        END.        

        p-nro_linea-o = T-Fac_detalle.nro_linea.
        codigo_salir = CD_GRABAR.
        APPLY "U1" TO THIS-PROCEDURE.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_sinobra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_sinobra Dialog-Frame
ON CHOOSE OF btn_sinobra IN FRAME Dialog-Frame /* Sin Obra */
DO:

  ASSIGN
     T-Fac_detalle.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_bonificacion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_bonificacion Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_bonificacion IN FRAME Dialog-Frame
OR "." OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Bonificacion" "cdg_bonificacion" "SELBONIF.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_bonificacion Dialog-Frame
ON RETURN OF v-cdg_bonificacion IN FRAME Dialog-Frame
OR TAB OF v-cdg_bonificacion IN FRAME {&FRAME-NAME}
DO:
   &SCOPED-DEFINE PONER-TABLA RUN poner_porcentaje.
   {traducetabla.i "Bonificacion" "cdg_bonificacion" "descripcion"} 
   &UNDEFINE PONER-TABLA
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON RETURN OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_obra
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_obra IN FRAME Dialog-Frame /* Obra */
OR "." OF v-cdg_obra IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_obra IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Obra" "cdg_obra" "SELOBRGL.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_obra Dialog-Frame
ON RETURN OF v-cdg_obra IN FRAME Dialog-Frame /* Obra */
DO:
    {traducetabla.i "Obra" "cdg_obra" "dsc_obra"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_partida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON F7 OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
DO:
/*
  HIDE FRAME {&FRAME-NAME}.
  ult_partida = ?.
  RUN ACTPARTI.P (INPUT 1).
  RUN PONER_SESION.
  IF ult_partida <> ?
  THEN DO:
     ant_ROWID = ?.
     FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
     DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
  END.
  ELSE DO:
     VIEW FRAME {&FRAME-NAME}.
     APPLY "ENTRY" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
  END.
  RETURN NO-APPLY.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON F8 OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
DO:
/*
  IF NOT AVAILABLE Partida
  THEN DO:
     RUN ponmensj.p (INPUT "HELP001").
  END.
  ELSE DO:
     HIDE FRAME {&FRAME-NAME}.
     ult_partida = ROWID(Partida).
     RUN ACTPARTI.P (INPUT 2).
     RUN PONER_SESION.
     IF ult_partida <> ?
     THEN DO:
        ant_ROWID = ?.
        FIND Partida WHERE ROWID(Partida) = ult_partida NO-LOCK.
        DISPLAY Partida.cdg_partida WITH FRAME {&FRAME-NAME}.
        APPLY "RETURN" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     END.
     ELSE DO:
        VIEW FRAME {&FRAME-NAME}.
        APPLY "ENTRY" TO Partida.cdg_partida IN FRAME {&FRAME-NAME}.
     END.
  END.
  RETURN NO-APPLY.
*/  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR "." OF v-cdg_partida IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_partida IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE x-cdg_partida LIKE Partida.cdg_partida.
  RUN d-seleccionar_partida-deposito.w ( INPUT  T-Fac_detalle.nro_articulo,
                                         INPUT  T-Fac_header.nro_deposito,
                                         OUTPUT x-cdg_partida ).
  IF x-cdg_partida <> ?
  THEN DO:
     DISPLAY x-cdg_partida @ v-cdg_partida 
             WITH FRAME {&FRAME-NAME}.
     APPLY "RETURN" TO v-cdg_partida IN FRAME {&FRAME-NAME}.        
     RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_partida Dialog-Frame
ON RETURN OF v-cdg_partida IN FRAME Dialog-Frame /* Partida */
OR TAB OF v-cdg_partida  IN FRAME {&FRAME-NAME}
DO:

   FIND FIRST Partida NO-LOCK 
        WHERE Partida.cdg_empresa  = T-Fac_header.cdg_empresa
          AND Partida.nro_articulo = T-Fac_detalle.nro_articulo
          AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.

   IF NOT AVAILABLE Partida
   THEN DO:
        RUN ponmensj.p ( INPUT "ARTI008" ).
        RETURN NO-APPLY.
   END.
   ELSE DO:
         v-dsc_partida = Partida.descripcion.
         DISPLAY v-dsc_partida
                 WITH FRAME {&FRAME-NAME}.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_ugranel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ugranel Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_ugranel IN FRAME Dialog-Frame
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_ugranel Dialog-Frame
ON RETURN OF v-cdg_ugranel IN FRAME Dialog-Frame
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_umed
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_umed Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_umed IN FRAME Dialog-Frame
OR "." OF v-cdg_entidad IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_entidad IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Entidad" "cdg_entidad" "SELENTID.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_umed Dialog-Frame
ON RETURN OF v-cdg_umed IN FRAME Dialog-Frame
DO:
    {traducetabla.i "Entidad" "cdg_entidad" "dsc_entidad"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-7
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

  FIND FIRST T-Fac_header.
  
  IF p-modo-detalle = 0
  THEN DO:
     FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
     ASSIGN v-cdg_articulo = Articulo.cdg_articulo
            v-dsc_articulo = Articulo.descripcion.
     FIND Unidad OF Articulo NO-LOCK.
     v-cdg_umed     = Unidad.abrevia.
     FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
     v-cdg_ugranel   = Unidad.abrevia.

     FIND Entidad WHERE Entidad.cdg_entidad = T-Fac_header.cdg_empresa NO-LOCK.
     CREATE T-Fac_detalle.
     ASSIGN T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
            T-Fac_detalle.nro_entidad  = T-Fac_header.nro_entidad
            T-Fac_detalle.nro_obra     = T-Fac_header.nro_obra
            T-Fac_detalle.nro_articulo = Articulo.nro_articulo
            T-Fac_detalle.costo        = Articulo.costo
            T-Fac_detalle.a_granel     = Articulo.a_granel.

     RUN traer_entidad.
     RUN traer_obra.
     
     FIND Lista_precios OF T-Fac_header NO-LOCK.
     FIND LAST Articulo_precio OF Articulo 
               WHERE Articulo_precio.cdg_lista   = Lista_precios.cdg_lista 
                 AND Articulo_precio.cdg_empresa = T-Fac_header.cdg_empresa
                 AND Articulo_precio.fch_desde <= T-Fac_header.fecha
                     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Articulo_precio 
     THEN DO:
          RUN ponmensj.p ( INPUT "PEDI012").
          T-Fac_detalle.precio     = ?.
          T-Fac_detalle.precio_cf  = ?.
     END.     
     ELSE DO:
          T-Fac_detalle.precio     = Articulo_precio.precio.
          T-Fac_detalle.precio_cf  = Articulo_precio.precio_cf.
     END.

     FOR EACH Cliente-bonxarticulo OF Articulo 
         WHERE Cliente-bonxarticulo.nro_cliente = T-Fac_header.nro_cliente 
           AND Cliente-bonxarticulo.desde_fecha <= T-Fac_header.fecha 
           AND Cliente-bonxarticulo.hasta_fecha >= T-Fac_header.fecha 
           AND Cliente-bonxarticulo.cdg_empresa  = T-Fac_header.cdg_empresa 
               NO-LOCK:
         
         CREATE T-Fac_detalle-bon.
         ASSIGN T-Fac_detalle-bon.cdg_bonificacion = Cliente-bonxarticulo.cdg_bonificacion
                T-Fac_detalle-bon.importe          = 0
                T-Fac_detalle-bon.nro_linea        = T-Fac_detalle.nro_linea
                T-Fac_detalle-bon.nro_factura      = T-Fac_detalle.nro_factura
                T-Fac_detalle-bon.porcentaje       = Cliente-bonxarticulo.porcentaje.
         
     END.

     IF NOT Articulo.hay_partida
     THEN DO:
        FIND FIRST Partida OF Articulo NO-LOCK.
        T-Fac_detalle.nro_partida = Partida.nro_partida.
     END.
     
  END.
  ELSE DO:
     FIND FIRST T-Fac_detalle WHERE T-Fac_detalle.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
     RUN traer_tablas.
  END.

  IF Articulo.a_granel
     THEN ASSIGN T-Fac_detalle.cantidad:BGCOLOR IN FRAME {&FRAME-NAME} = 14
                 T-Fac_detalle.granel:BGCOLOR IN FRAME {&FRAME-NAME} = 14.
     ELSE ASSIGN T-Fac_detalle.cantidad:BGCOLOR IN FRAME {&FRAME-NAME} = 15
                 T-Fac_detalle.granel:BGCOLOR IN FRAME {&FRAME-NAME} = 15.

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_umed
        v-cdg_ugranel WHEN Articulo.a_granel
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        v-cdg_partida
        v-dsc_partida
        T-Fac_detalle.cantidad 
        T-Fac_detalle.granel 
        T-Fac_detalle.precio 
        T-Fac_detalle.precio_cf 
        T-Fac_detalle.subtotal_neto 
        T-Fac_detalle.subtotal_neto_cf
        WITH FRAME {&FRAME-NAME}.      

  RUN habilitar_campos.
 {&OPEN-QUERY-{&BROWSE-NAME}}

  APPLY "ENTRY" TO T-Fac_detalle.cantidad IN FRAME {&FRAME-NAME}.      
 
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

  {&OPEN-QUERY-Dialog-Frame}
  GET FIRST Dialog-Frame.
  DISPLAY v-cdg_articulo v-dsc_articulo v-cdg_partida v-dsc_partida 
          v-cdg_entidad v-dsc_entidad v-cdg_obra v-dsc_obra v-cdg_umed 
          v-cdg_ugranel v-cdg_bonificacion v-dsc_bonificacion v-porcentaje 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Fac_detalle THEN 
    DISPLAY T-Fac_detalle.cantidad T-Fac_detalle.granel T-Fac_detalle.precio 
          T-Fac_detalle.precio_cf T-Fac_detalle.subtotal_neto 
          T-Fac_detalle.subtotal_neto_cf 
      WITH FRAME Dialog-Frame.
  ENABLE T-Fac_detalle.cantidad T-Fac_detalle.granel T-Fac_detalle.precio 
         v-cdg_bonificacion v-porcentaje T-Fac_detalle.precio_cf BROWSE-7 
         Btn_OK Btn_Cancel btn_crear btn_eliminar RECT-10 RECT-11 RECT-9 
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

    RUN hayobras.p ( OUTPUT hay_obras ).

    ASSIGN
        v-cdg_partida:SENSITIVE                   = NO
        v-cdg_entidad:SENSITIVE                   = NO
        v-cdg_obra:SENSITIVE                      = NO
        T-Fac_detalle.cantidad:SENSITIVE          = NO 
        T-Fac_detalle.granel:SENSITIVE            = NO 
        T-Fac_detalle.precio:SENSITIVE            = NO 
        T-Fac_detalle.precio_cf:SENSITIVE         = NO 
        btn_sinobra:SENSITIVE                     = NO
        Btn_OK:SENSITIVE                          = NO.

    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_partida:SENSITIVE                   = Articulo.hay_partida.
            v-cdg_entidad:SENSITIVE                   = YES.
            v-cdg_obra:SENSITIVE                      = hay_obras.
            T-Fac_detalle.cantidad:SENSITIVE          = YES. 
            T-Fac_detalle.granel:SENSITIVE            = Articulo.a_granel. 
            T-Fac_detalle.precio:SENSITIVE            = YES. 
            T-Fac_detalle.precio_cf:SENSITIVE         = NO. 
            btn_sinobra:SENSITIVE                     = hay_obras.
            Btn_OK:SENSITIVE                          = YES.
        END.
        
        WHEN MD_MULTIPLE               
        THEN DO:
           /* nada habilitado */
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE poner_porcentaje Dialog-Frame 
PROCEDURE poner_porcentaje :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  v-porcentaje = Bonificacion.porcentaje.
  DISPLAY v-porcentaje
          WITH FRAME {&FRAME-NAME}.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_articulo Dialog-Frame 
PROCEDURE traer_articulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Articulo OF T-Fac_detalle NO-LOCK.
  ASSIGN
        v-cdg_articulo = Articulo.cdg_articulo
        v-dsc_articulo = Articulo.descripcion.
  FIND Unidad OF Articulo NO-LOCK.
  v-cdg_umed     = Unidad.abrevia.
  FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
  v-cdg_ugranel   = Unidad.abrevia.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_entidad Dialog-Frame 
PROCEDURE traer_entidad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Entidad OF T-Fac_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE Entidad
  THEN DO:
       v-cdg_entidad = Entidad.cdg_entidad.
       v-dsc_entidad = Entidad.dsc_entidad.
  END.
  ELSE DO:
       v-cdg_entidad = "".
       v-dsc_entidad = "".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_obra Dialog-Frame 
PROCEDURE traer_obra :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Obra OF T-Fac_detalle NO-LOCK NO-ERROR.
  IF AVAILABLE obra
  THEN DO:
       v-cdg_obra = Obra.cdg_obra.
       v-dsc_obra = Obra.dsc_obra.
  END.
  ELSE DO:
       v-cdg_obra = "".
       v-dsc_obra = "".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_partida Dialog-Frame 
PROCEDURE traer_partida :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Partida OF T-Fac_detalle NO-LOCK.
  IF AVAILABLE Partida
  THEN DO:
       v-cdg_partida = Partida.cdg_partida.
       v-dsc_partida = Partida.descripcion.
  END.
  ELSE DO:
       v-cdg_Partida = "".
       v-dsc_Partida = "".
  END.

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

  RUN traer_articulo.
  RUN traer_entidad.
  RUN traer_obra.
  RUN traer_partida.

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

   IF ( Articulo.a_granel AND T-Fac_detalle.granel:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 ) OR
      ( NOT Articulo.a_granel AND T-Fac_detalle.cantidad:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 )
   THEN DO:
       RUN ponmensj.p ( INPUT "FACT012" ).
       RETURN.
   END.

   IF ( T-Fac_detalle.precio:INPUT-VALUE IN FRAME {&FRAME-NAME} = 0 OR
        T-Fac_detalle.precio:INPUT-VALUE IN FRAME {&FRAME-NAME} = ? )  AND FALSE /*agregar para facturar en 0*/
   THEN DO:
       RUN ponmensj.p ( INPUT "FACT036" ).
       RETURN.
   END.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN ponmensj.p ( INPUT "ASIE012" ).
        RETURN.
   END.
   ELSE DO:
        T-Fac_detalle.nro_entidad = Entidad.nro_entidad.
   END.

   IF Articulo.hay_partida
   THEN DO:
        FIND FIRST Partida NO-LOCK 
             WHERE Partida.cdg_empresa  = T-Fac_header.cdg_empresa
               AND Partida.nro_articulo = T-Fac_detalle.nro_articulo
               AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.
     
        IF NOT AVAILABLE Partida
        THEN DO:
             RUN ponmensj.p ( INPUT "ARTI008" ).
             RETURN NO-APPLY.
        END.
        ELSE DO:
             T-Fac_detalle.nro_partida = Partida.nro_partida.
        END.
   END.
   
   IF INPUT FRAME {&FRAME-NAME} v-cdg_obra <> ""
   THEN DO:
        FIND Obra WHERE Obra.cdg_obra = v-cdg_obra NO-ERROR.
        IF NOT AVAILABLE Obra
        THEN DO:
             RUN ponmensj.p ( INPUT "ASIE013" ).
             RETURN.
        END.
        ELSE DO:

             IF NOT CAN-DO(Obra.entidades_validas,T-Fac_header.cdg_empresa)
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF NOT Obra.permanente
             THEN DO:
                IF T-Fac_header.fecha < Obra.fecha_apertura OR
                   T-Fac_header.fecha > Obra.fecha_cierre 
                THEN DO:
                     RUN ponmensj.p ( INPUT "ASIE026" ).
                     RETURN.
                END.
             END.

             T-Fac_detalle.nro_obra = Obra.nro_obra.

        END.
   END.


   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

