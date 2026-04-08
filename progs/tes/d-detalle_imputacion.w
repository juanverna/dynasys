&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.


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
DEFINE VARIABLE                  p-nro_cuenta     LIKE Cuenta.nro_cuenta.
DEFINE VARIABLE                  p-nro_entidad    LIKE Entidad.nro_entidad.
DEFINE VARIABLE                  p-nro_obra       LIKE Obra.nro_obra.
DEFINE VARIABLE                  p-modo-cabecera  AS INTEGER.
DEFINE VARIABLE                  p-modo-detalle   AS INTEGER.
DEFINE VARIABLE                  p-valor          LIKE Caja-imputacion.valor.
DEFINE VARIABLE                  p-observacion    LIKE Caja-imputacion.observacion.
DEFINE VARIABLE                  p-ok             AS LOGICAL.
&ELSE
DEFINE INPUT         PARAMETER   p-nro_cuenta     LIKE Cuenta.nro_cuenta.
DEFINE INPUT         PARAMETER   p-modo-cabecera  AS INTEGER.
DEFINE INPUT         PARAMETER   p-modo-detalle   AS INTEGER.

DEFINE INPUT-OUTPUT  PARAMETER   p-nro_entidad    LIKE Entidad.nro_entidad.
DEFINE INPUT-OUTPUT  PARAMETER   p-nro_obra       LIKE Obra.nro_obra.
DEFINE INPUT-OUTPUT  PARAMETER   p-valor          LIKE Caja-imputacion.valor.
DEFINE INPUT-OUTPUT  PARAMETER   p-observacion    LIKE Caja-imputacion.observacion.
DEFINE OUTPUT        PARAMETER   p-ok             AS LOGICAL.
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
&Scoped-define INTERNAL-TABLES T-Caja-imputacion

/* Definitions for DIALOG-BOX Dialog-Frame                              */
&Scoped-define QUERY-STRING-Dialog-Frame FOR EACH T-Caja-imputacion SHARE-LOCK
&Scoped-define OPEN-QUERY-Dialog-Frame OPEN QUERY Dialog-Frame FOR EACH T-Caja-imputacion SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-Dialog-Frame T-Caja-imputacion
&Scoped-define FIRST-TABLE-IN-QUERY-Dialog-Frame T-Caja-imputacion


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-valor v-observacion Btn_Cancel RECT-11 ~
RECT-12 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS v-cdg_cuenta v-dsc_cuenta v-cdg_entidad ~
v-dsc_entidad v-cdg_obra v-dsc_obra v-valor v-observacion 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 18 BY 1.1
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 18 BY 1.1
     BGCOLOR 8 .

DEFINE BUTTON btn_sinobra 
     LABEL "&Sin Obra" 
     SIZE 12 BY 1.

DEFINE VARIABLE v-observacion AS CHARACTER 
     VIEW-AS EDITOR SCROLLBAR-VERTICAL
     SIZE 63 BY 3.57
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_cuenta AS CHARACTER FORMAT "X(256)":U 
     LABEL "Cuenta" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-cdg_entidad AS CHARACTER FORMAT "X(256)":U 
     LABEL "Entidad" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-cdg_obra AS CHARACTER FORMAT "X(256)":U 
     LABEL "Obra" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.

DEFINE VARIABLE v-dsc_cuenta AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_entidad AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-dsc_obra AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY 1
     BGCOLOR 7 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE v-valor AS DECIMAL FORMAT "->>>>>>9.99" INITIAL 0 
     LABEL "Valor" 
     VIEW-AS FILL-IN 
     SIZE 17.4 BY 1
     BGCOLOR 15 FGCOLOR 9 .

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 2.67.

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 5.38.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 96 BY 1.33.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Dialog-Frame FOR 
      T-Caja-imputacion SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     v-cdg_cuenta AT ROW 1.48 COL 12 COLON-ALIGNED
     v-dsc_cuenta AT ROW 1.48 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_entidad AT ROW 2.91 COL 12 COLON-ALIGNED
     v-dsc_entidad AT ROW 2.91 COL 31 COLON-ALIGNED NO-LABEL
     v-cdg_obra AT ROW 4.1 COL 12 COLON-ALIGNED
     v-dsc_obra AT ROW 4.1 COL 31 COLON-ALIGNED NO-LABEL
     btn_sinobra AT ROW 4.1 COL 84
     v-valor AT ROW 6.71 COL 12 COLON-ALIGNED HELP
          "Valor del importe"
     v-observacion AT ROW 6.95 COL 33 HELP
          "Ingrese una observacion (opcional)" NO-LABEL
     Btn_OK AT ROW 7.95 COL 14
     Btn_Cancel AT ROW 9.29 COL 14
     RECT-11 AT ROW 2.62 COL 2
     RECT-12 AT ROW 5.52 COL 2
     RECT-9 AT ROW 1.29 COL 2
     "         Valor de la imputación contable y observaciones opcionales" VIEW-AS TEXT
          SIZE 93 BY .81 AT ROW 5.81 COL 3
          BGCOLOR 7 FGCOLOR 15 
     SPACE(5.99) SKIP(5.70)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Detalle de Imputación Contable"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
   Temp-Tables and Buffers:
      TABLE: T-Caja-imputacion T "?" NO-UNDO sic Caja-imputacion
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

/* SETTINGS FOR BUTTON Btn_OK IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON btn_sinobra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_cuenta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-cdg_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_cuenta IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_entidad IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-dsc_obra IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX Dialog-Frame
/* Query rebuild information for DIALOG-BOX Dialog-Frame
     _TblList          = "Temp-Tables.T-Caja-imputacion"
     _Options          = "SHARE-LOCK"
     _Query            is OPENED
*/  /* DIALOG-BOX Dialog-Frame */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Detalle de Imputación Contable */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  p-ok = NO.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:

  ASSIGN FRAME {&FRAME-NAME}
        v-cdg_entidad
        v-cdg_obra
        v-valor
        v-observacion.
  
  RUN  validar_datos ( OUTPUT hubo_error ).
  IF NOT hubo_error
  THEN DO:
      ASSIGN p-ok = YES
             p-valor = v-valor
             p-observacion = v-observacion
             p-nro_entidad = Entidad.nro_entidad
             codigo_salir  = CD_GRABAR.
             IF AVAILABLE Obra THEN
             ASSIGN p-nro_obra = Obra.nro_obra.
             

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
/*      T-Caja-imputacion.nro_obra = 0 */
     v-cdg_obra = ""
     v-dsc_obra = "".

  DISPLAY 
        v-cdg_obra
        v-dsc_obra
        WITH FRAME {&FRAME-NAME}.

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


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.

ASSIGN v-valor = p-valor
       v-observacion = p-observacion.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.

     FIND Cuenta WHERE Cuenta.nro_cuenta = p-nro_cuenta NO-LOCK.
     ASSIGN v-cdg_cuenta = Cuenta.cdg_cuenta
            v-dsc_cuenta = Cuenta.nombre_cta.
    
     FIND Entidad WHERE Entidad.nro_entidad = p-nro_entidad NO-LOCK NO-ERROR.
     IF AVAILABLE Entidad
     THEN DO:
          v-cdg_entidad = Entidad.cdg_entidad.
          v-dsc_entidad = Entidad.dsc_entidad.
     END.
     ELSE DO:
          v-cdg_entidad = "".
          v-dsc_entidad = "".
     END.
    
     FIND Obra WHERE Obra.nro_obra = p-nro_obra NO-LOCK NO-ERROR.
     IF AVAILABLE Obra
     THEN DO:
          v-cdg_obra = Obra.cdg_obra.
          v-dsc_obra = Obra.dsc_obra.
     END.
     ELSE DO:
          v-cdg_obra = "".
          v-dsc_obra = "".
     END.

     DISPLAY 
            v-cdg_cuenta
            v-dsc_cuenta
            v-cdg_entidad
            v-dsc_entidad
            v-cdg_obra
            v-dsc_obra
            v-valor 
            v-observacion
            WITH FRAME {&FRAME-NAME}.      

     RUN habilitar_campos.
    
     APPLY "ENTRY" TO v-valor IN FRAME {&FRAME-NAME}.      
     
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
  DISPLAY v-cdg_cuenta v-dsc_cuenta v-cdg_entidad v-dsc_entidad v-cdg_obra 
          v-dsc_obra v-valor v-observacion 
      WITH FRAME Dialog-Frame.
  ENABLE v-valor v-observacion Btn_Cancel RECT-11 RECT-12 RECT-9 
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
        v-cdg_entidad:SENSITIVE                   = NO
        v-cdg_obra:SENSITIVE                      = NO
        v-valor:SENSITIVE           = NO 
        v-observacion:SENSITIVE     = NO
        v-observacion:FGCOLOR       = 7
        v-observacion:BGCOLOR       = 15
        btn_sinobra:SENSITIVE                     = NO
        Btn_OK:SENSITIVE                          = NO.

    CASE p-modo-cabecera:
        WHEN MD_ALTA                   
        THEN DO:
            ASSIGN
                v-cdg_entidad:SENSITIVE                   = YES
                v-cdg_obra:SENSITIVE                      = hay_obras
                v-valor:SENSITIVE           = YES 
                btn_sinobra:SENSITIVE                     = hay_obras
                Btn_OK:SENSITIVE                          = YES
                v-observacion:SENSITIVE     = YES
                v-observacion:FGCOLOR       = 9
                v-observacion:BGCOLOR       = 15.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traer_tablas Dialog-Frame 
PROCEDURE traer_tablas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

     FIND Cuenta OF T-Caja-imputacion NO-LOCK NO-ERROR.
     IF AVAILABLE Cuenta
     THEN DO:
          v-cdg_cuenta = Cuenta.cdg_cuenta.
          v-dsc_cuenta = Cuenta.nombre_cta.
     END.
     ELSE DO:
          v-cdg_cuenta = "".
          v-dsc_cuenta = "".
     END.

     FIND Entidad OF T-Caja-imputacion NO-LOCK NO-ERROR.
     IF AVAILABLE Entidad
     THEN DO:
          v-cdg_entidad = Entidad.cdg_entidad.
          v-dsc_entidad = Entidad.dsc_entidad.
     END.
     ELSE DO:
          v-cdg_entidad = "".
          v-dsc_entidad = "".
     END.

     FIND Obra OF T-Caja-imputacion NO-LOCK NO-ERROR.
     IF AVAILABLE Obra
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE validar_datos Dialog-Frame 
PROCEDURE validar_datos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

   {findempresa.i}

   hay_error = YES.

   FIND Entidad WHERE Entidad.cdg_entidad = v-cdg_entidad NO-ERROR.
   IF NOT AVAILABLE Entidad
   THEN DO:
        RUN PONMENSJ.P ( INPUT "ASIE012" ).
        RETURN.
   END.

   IF v-cdg_obra <> ""
   THEN DO:
        FIND Obra WHERE Obra.cdg_obra = v-cdg_obra NO-ERROR.
        IF NOT AVAILABLE Obra
        THEN DO:
             RUN PONMENSJ.P ( INPUT "ASIE013" ).
             RETURN.
        END.
        ELSE DO:
             IF NOT CAN-DO (Obra.lista_empresas, Empresa.cdg_empresa) THEN DO:
             
/*              IF LOOKUP(Obra.lista_empresas,Empresa.cdg_empresa,",") = 0 */
/*              THEN DO:                                                   */
                  RUN PONMENSJ.P ( INPUT "ASIE027" ).
                  RETURN.
             END.

             IF Obra.finalizada
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             
             IF TODAY /*Caj_header.fecha*/ < Obra.fecha_apertura OR
                TODAY /*Caj_header.fecha*/ > Obra.fecha_cierre 
             THEN DO:
                  RUN PONMENSJ.P ( INPUT "ASIE026" ).
                  RETURN.
             END.
             

        END.
   END.

   hay_error = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

