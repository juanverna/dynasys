&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Partida NO-UNDO LIKE Partida
       FIELD es_nueva AS LOGICAL.
DEFINE TEMP-TABLE T-Registrable NO-UNDO LIKE Registrable
       FIELD es_nuevo AS LOGICAL.
DEFINE TEMP-TABLE T-Registrable_vale NO-UNDO LIKE Registrable_vale.
DEFINE TEMP-TABLE T-Valeinv_dt NO-UNDO LIKE Valeinv_dt.
DEFINE TEMP-TABLE T-Valeinv_hd NO-UNDO LIKE Valeinv_hd.


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
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valeinv_hd.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Valeinv_dt.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Partida.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Registrable.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Registrable_vale.
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

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES T-Valeinv_dt

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define FIELDS-IN-QUERY-Dialog-Frame T-Valeinv_dt.cantidad ~
T-Valeinv_dt.granel T-Valeinv_dt.observacion 
&Scoped-define ENABLED-FIELDS-IN-QUERY-Dialog-Frame T-Valeinv_dt.cantidad ~
T-Valeinv_dt.granel T-Valeinv_dt.observacion 
&Scoped-define ENABLED-TABLES-IN-QUERY-Dialog-Frame T-Valeinv_dt
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-Dialog-Frame T-Valeinv_dt
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Valeinv_dt SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Valeinv_dt SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Valeinv_dt
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Valeinv_dt


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS T-Valeinv_dt.cantidad T-Valeinv_dt.granel ~
T-Valeinv_dt.observacion 
&Scoped-define ENABLED-TABLES T-Valeinv_dt
&Scoped-define FIRST-ENABLED-TABLE T-Valeinv_dt
&Scoped-Define ENABLED-OBJECTS v-crear_partida Btn_OK Btn_Cancel RECT-10 ~
RECT-11 RECT-12 RECT-13 RECT-9 
&Scoped-Define DISPLAYED-FIELDS T-Valeinv_dt.cantidad T-Valeinv_dt.granel ~
T-Valeinv_dt.observacion 
&Scoped-define DISPLAYED-TABLES T-Valeinv_dt
&Scoped-define FIRST-DISPLAYED-TABLE T-Valeinv_dt
&Scoped-Define DISPLAYED-OBJECTS v-cdg_articulo v-dsc_articulo v-cdg_umed ~
v-cdg_deposito v-dsc_deposito v-cdg_partida v-dsc_partida v-crear_partida ~
v-cdg_entidad v-dsc_entidad v-cdg_obra v-dsc_obra 

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

DEFINE BUTTON btn_crearpartida 
     LABEL "&Crear" 
     SIZE 13 BY 1.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 13 BY 1.

DEFINE VARIABLE v-cdg_articulo AS CHARACTER FORMAT "X(256)":U 
     LABEL "Artículo" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_deposito AS CHARACTER FORMAT "X(256)":U 
     LABEL "Depósito" 
     VIEW-AS FILL-IN NATIVE 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

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

DEFINE VARIABLE v-cdg_umed AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_articulo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_deposito AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 72 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_partida AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 104 BY 1.67.

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 104 BY 2.86.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 104 BY 1.67.

DEFINE RECTANGLE RECT-13
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 104 BY 1.67.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 104 BY 4.

DEFINE VARIABLE v-crear_partida AS LOGICAL INITIAL no 
     LABEL "Crear" 
     VIEW-AS TOGGLE-BOX
     SIZE 12 BY .95 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Valeinv_dt SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_articulo AT ROW 1.71 COL 12 COLON-ALIGNED
     v-dsc_articulo AT ROW 1.71 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_umed AT ROW 1.71 COL 90 COLON-ALIGNED NO-LABEL
     v-cdg_deposito AT ROW 2.91 COL 12 COLON-ALIGNED
     v-dsc_deposito AT ROW 2.91 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_partida AT ROW 4.1 COL 12 COLON-ALIGNED
     v-dsc_partida AT ROW 4.1 COL 31 COLON-ALIGNED NO-LABEL
     v-crear_partida AT ROW 4.1 COL 92
     v-cdg_entidad AT ROW 5.52 COL 12 COLON-ALIGNED
     v-dsc_entidad AT ROW 5.52 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 6.71 COL 12 COLON-ALIGNED
     v-dsc_obra AT ROW 6.71 COL 31 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 6.71 COL 92
     T-Valeinv_dt.cantidad AT ROW 8.38 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     btn_crearpartida AT ROW 8.38 COL 50
     T-Valeinv_dt.granel AT ROW 8.38 COL 85 COLON-ALIGNED
          VIEW-AS FILL-IN NATIVE 
          SIZE 18 BY 1
          BGCOLOR 15 FGCOLOR 9 
     T-Valeinv_dt.observacion AT ROW 11.48 COL 1 COLON-ALIGNED NO-LABEL FORMAT "X(40)"
          VIEW-AS FILL-IN NATIVE 
          SIZE 102 BY 1
          BGCOLOR 15 FGCOLOR 9 
     Btn_OK AT ROW 13.38 COL 3
     Btn_Cancel AT ROW 13.38 COL 87
     RECT-10 AT ROW 8.14 COL 2
     RECT-11 AT ROW 5.29 COL 2
     RECT-12 AT ROW 11.24 COL 2
     RECT-13 AT ROW 13.14 COL 2
     RECT-9 AT ROW 1.29 COL 2
     "  Observaciones asociadas al movimiento" VIEW-AS TEXT
          SIZE 104 BY 1 AT ROW 10.05 COL 2
          BGCOLOR 5 FGCOLOR 15 
     SPACE(1.39) SKIP(4.08)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Vales de Inventario"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Partida T "?" NO-UNDO sic Partida
      ADDITIONAL-FIELDS:
          FIELD es_nueva AS LOGICAL
      END-FIELDS.
      TABLE: T-Registrable T "?" NO-UNDO sic Registrable
      ADDITIONAL-FIELDS:
          FIELD es_nuevo AS LOGICAL
      END-FIELDS.
      TABLE: T-Registrable_vale T "?" NO-UNDO sic Registrable_vale
      TABLE: T-Valeinv_dt T "?" NO-UNDO sic Valeinv_dt
      TABLE: T-Valeinv_hd T "?" NO-UNDO sic Valeinv_hd
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON btn_crearpartida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
ASSIGN 
       btn_crearpartida:HIDDEN IN FRAME Dialog-Frame           = TRUE.

/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN T-Valeinv_dt.observacion IN FRAME Dialog-Frame
   EXP-FORMAT                                                           */
/* SETTINGS FOR FILL-IN v-cdg_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_deposito IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_partida IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_umed IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_articulo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_deposito IN FRAME Dialog-Frame
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

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Valeinv_dt"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Vales de Inventario */
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
      DELETE T-Valeinv_dt.  
  END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_crearpartida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_crearpartida Dialog-Frame
ON CHOOSE OF btn_crearpartida IN FRAME Dialog-Frame /* Crear */
DO:
    DEFINE VARIABLE x-cdg_partida LIKE Partida.cdg_partida.
    DEFINE VARIABLE x-dsc_partida LIKE Partida.descripcion.

    RUN d-crear_partida.w ( INPUT Articulo.nro_articulo,
                            OUTPUT x-cdg_partida,
                            OUTPUT x-dsc_partida).
    IF x-cdg_partida <> ?
    THEN DO:

        ASSIGN v-cdg_partida = x-cdg_partida
               v-dsc_partida = x-dsc_partida.
        DISPLAY v-cdg_partida
                v-dsc_partida
                WITH FRAME {&FRAME-NAME}.
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
        v-cdg_deposito
        v-crear_partida
        T-Valeinv_dt.cantidad 
        T-Valeinv_dt.granel
        T-Valeinv_dt.observacion.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
        IF p-modo-detalle = 0 /* Es un alta */ 
        THEN DO:
            ASSIGN
                T-Valeinv_hd.ultima_linea     = T-Valeinv_hd.ultima_linea + 1
                T-Valeinv_dt.nro_valeinv      = T-Valeinv_hd.nro_valeinv
                T-Valeinv_dt.nro_linea        = T-Valeinv_hd.ultima_linea.
        END.

        p-nro_linea-o = T-Valeinv_dt.nro_linea.
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
     T-Valeinv_dt.nro_obra = 0
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_deposito
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito Dialog-Frame
ON LEAVE OF v-cdg_deposito IN FRAME Dialog-Frame /* Depósito */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-cdg_deposito.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_deposito IN FRAME Dialog-Frame /* Depósito */
OR "*" OF v-cdg_deposito IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_deposito IN FRAME {&FRAME-NAME}
DO:

   {helptabla.i "Deposito" "cdg_deposito" "SELDEPOS.P"}
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_deposito Dialog-Frame
ON RETURN OF v-cdg_deposito IN FRAME Dialog-Frame /* Depósito */
DO:
    {traducetabla.i "Deposito" "cdg_deposito" "nombre"} 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-cdg_entidad
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-cdg_entidad Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF v-cdg_entidad IN FRAME Dialog-Frame /* Entidad */
OR "*" OF v-cdg_entidad IN FRAME {&FRAME-NAME}
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
OR "*" OF v-cdg_obra IN FRAME {&FRAME-NAME}
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
OR "*" OF v-cdg_partida IN FRAME {&FRAME-NAME}
OR MOUSE-MENU-DOWN OF v-cdg_partida IN FRAME {&FRAME-NAME}
DO:
  DEFINE VARIABLE x-cdg_partida LIKE Partida.cdg_partida.
  RUN d-seleccionar_partida-deposito.w ( INPUT  T-Valeinv_dt.nro_articulo,
                                         INPUT  v-cdg_deposito,
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
        WHERE Partida.cdg_empresa  = T-Valeinv_hd.cdg_empresa
          AND Partida.nro_articulo = T-Valeinv_dt.nro_articulo
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


&Scoped-define SELF-NAME v-crear_partida
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-crear_partida Dialog-Frame
ON VALUE-CHANGED OF v-crear_partida IN FRAME Dialog-Frame /* Crear */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-crear_partida.
  IF v-crear_partida
      THEN v-dsc_partida:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
      ELSE v-dsc_partida:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
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

  FIND FIRST T-Valeinv_hd.
  
  IF p-modo-detalle = 0
  THEN DO:
     FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
     ASSIGN v-cdg_articulo = Articulo.cdg_articulo
            v-dsc_articulo = Articulo.descripcion
            v-cdg_umed     = Articulo.cdg_umed.

     CREATE T-Valeinv_dt.
     ASSIGN T-Valeinv_dt.nro_valeinv  = T-Valeinv_hd.nro_valeinv
            T-Valeinv_dt.nro_entidad  = T-Valeinv_hd.nro_entidad
            T-Valeinv_dt.nro_articulo = Articulo.nro_articulo
            T-Valeinv_dt.costo        = Articulo.costo
            T-Valeinv_dt.a_granel     = Articulo.a_granel.

     RUN traer_entidad.
     RUN traer_obra.
     
     IF NOT Articulo.hay_partida
     THEN DO:
        FIND FIRST Partida OF Articulo NO-LOCK.
        T-Valeinv_dt.nro_partida = Partida.nro_partida.
     END.
     
  END.
  ELSE DO:
     FIND FIRST T-Valeinv_dt WHERE T-Valeinv_dt.nro_linea = p-nro_linea-i EXCLUSIVE-LOCK.
     RUN traer_tablas.
  END.

  DISPLAY 
        v-cdg_articulo
        v-dsc_articulo
        v-cdg_umed
        v-cdg_entidad
        v-dsc_entidad
        v-cdg_obra
        v-dsc_obra
        v-cdg_partida
        v-dsc_partida
        v-cdg_deposito
        v-dsc_deposito
        T-Valeinv_dt.cantidad 
        T-Valeinv_dt.granel 
        WITH FRAME {&FRAME-NAME}.      

  RUN habilitar_campos.

  APPLY "ENTRY" TO v-cdg_deposito IN FRAME {&FRAME-NAME}.      
 
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
  DISPLAY v-cdg_articulo v-dsc_articulo v-cdg_umed v-cdg_deposito v-dsc_deposito 
          v-cdg_partida v-dsc_partida v-crear_partida v-cdg_entidad 
          v-dsc_entidad v-cdg_obra v-dsc_obra 
      WITH FRAME Dialog-Frame.
  IF AVAILABLE T-Valeinv_dt THEN 
    DISPLAY T-Valeinv_dt.cantidad T-Valeinv_dt.granel T-Valeinv_dt.observacion 
      WITH FRAME Dialog-Frame.
  ENABLE v-crear_partida T-Valeinv_dt.cantidad T-Valeinv_dt.granel 
         T-Valeinv_dt.observacion Btn_OK Btn_Cancel RECT-10 RECT-11 RECT-12 
         RECT-13 RECT-9 
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
        v-cdg_deposito:SENSITIVE                  = NO
        T-Valeinv_dt.cantidad:SENSITIVE           = NO 
        T-Valeinv_dt.granel:SENSITIVE             = NO
        T-Valeinv_dt.observacion:SENSITIVE        = NO
        btn_crearpartida:SENSITIVE                = NO
        btn_sinobra:SENSITIVE                     = NO
        Btn_OK:SENSITIVE                          = NO.

    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            v-cdg_partida:SENSITIVE                   = Articulo.hay_partida.
            v-cdg_entidad:SENSITIVE                   = YES.
            v-cdg_deposito:SENSITIVE                  = YES.
            v-cdg_obra:SENSITIVE                      = hay_obras.
            T-Valeinv_dt.cantidad:SENSITIVE           = YES. 
            T-Valeinv_dt.granel:SENSITIVE             = Articulo.a_granel. 
            T-Valeinv_dt.observacion:SENSITIVE        = YES.
            btn_crearpartida:SENSITIVE                = YES.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_articulo Dialog-Frame 
PROCEDURE traer_articulo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Articulo OF T-Valeinv_dt NO-LOCK.
  ASSIGN
        v-cdg_articulo = Articulo.cdg_articulo
        v-dsc_articulo = Articulo.descripcion
        v-cdg_umed     = Articulo.cdg_umed.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_deposito Dialog-Frame 
PROCEDURE traer_deposito :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  FIND Deposito OF T-Valeinv_dt NO-LOCK NO-ERROR.
  IF AVAILABLE Deposito
  THEN DO:
       v-cdg_deposito = Deposito.cdg_deposito.
       v-dsc_deposito = Deposito.denominacion_dep.
  END.
  ELSE DO:
       v-cdg_deposito = "".
       v-dsc_deposito = "".
  END.

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

  FIND Entidad OF T-Valeinv_dt NO-LOCK NO-ERROR.
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

  FIND Obra OF T-Valeinv_dt NO-LOCK NO-ERROR.
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

  FIND Partida OF T-Valeinv_dt NO-LOCK.
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
  RUN traer_deposito.

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

   FIND Deposito WHERE Deposito.cdg_deposito = v-cdg_deposito NO-ERROR.
   IF NOT AVAILABLE Deposito
   THEN DO:
        RUN ponmensj.p ( INPUT "ASIE012" ).
        RETURN ERROR.
   END.
   ELSE DO:
        T-Valeinv_dt.nro_deposito = Deposito.nro_deposito.
   END.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN ponmensj.p ( INPUT "ASIE012" ).
        RETURN ERROR.
   END.
   ELSE DO:
        T-Valeinv_dt.nro_entidad = Entidad.nro_entidad.
   END.

   IF Articulo.hay_partida
   THEN DO:
       IF v-crear_partida
       THEN DO:
           ASSIGN FRAME {&FRAME-NAME}  v-cdg_partida v-dsc_partida.
           FIND FIRST Partida NO-LOCK 
               WHERE Partida.cdg_empresa  = T-Valeinv_hd.cdg_empresa
                 AND Partida.nro_articulo = T-Valeinv_dt.nro_articulo
                 AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.
     
           IF AVAILABLE Partida
           THEN DO:
               RUN ponmensj.p ( INPUT "ARTI018" ).
               RETURN ERROR .
           END.
           ELSE DO:
               DO TRANSACTION:
                   FIND CURRENT Articulo EXCLUSIVE-LOCK.
                   CREATE Partida.
                   ASSIGN Articulo.ult_partida     = Articulo.ult_partida + 1
                          Partida.nro_partida      = Articulo.ult_partida
                          Partida.cdg_partida      = v-cdg_partida
                          Partida.descripcion      = v-dsc_partida
                          Partida.nro_articulo     = Articulo.nro_articulo
                          Partida.cdg_empresa      = T-Valeinv_hd.cdg_empresa
                          T-Valeinv_dt.nro_partida = Partida.nro_partida.
                   RELEASE Partida.
                   FIND CURRENT Articulo NO-LOCK.
               END.
           END.
       END.
       ELSE DO:
           FIND FIRST Partida NO-LOCK 
               WHERE Partida.cdg_empresa  = T-Valeinv_hd.cdg_empresa
                 AND Partida.nro_articulo = T-Valeinv_dt.nro_articulo
                 AND Partida.cdg_partida  = INPUT FRAME {&FRAME-NAME} v-cdg_partida NO-ERROR.
     
           IF NOT AVAILABLE Partida
           THEN DO:
               RUN ponmensj.p ( INPUT "ARTI008" ).
               RETURN ERROR .
           END.
           ELSE DO:
               T-Valeinv_dt.nro_partida = Partida.nro_partida.
           END.
       END.
   END.
   
   IF INPUT FRAME {&FRAME-NAME} v-cdg_obra <> ""
   THEN DO:
        FIND Obra WHERE Obra.cdg_obra = v-cdg_obra NO-ERROR.
        IF NOT AVAILABLE Obra
        THEN DO:
             RUN ponmensj.p ( INPUT "ASIE013" ).
             RETURN ERROR.
        END.
        ELSE DO:

             IF NOT CAN-DO(Obra.entidades_validas,T-Valeinv_hd.cdg_empresa)
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE027" ).
                  RETURN ERROR.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN ponmensj.p ( INPUT "ASIE026" ).
                  RETURN ERROR.
             END.
             
             IF NOT Obra.permanente
             THEN DO:
                IF T-Valeinv_hd.fecha < Obra.fecha_apertura OR
                   T-Valeinv_hd.fecha > Obra.fecha_cierre 
                THEN DO:
                     RUN ponmensj.p ( INPUT "ASIE026" ).
                     RETURN ERROR.
                END.
             END.

             T-Valeinv_dt.nro_obra = Obra.nro_obra.

        END.
   END.

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

