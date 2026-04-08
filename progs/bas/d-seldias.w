&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
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


&IF DEFINED(UIB_is_Running) &THEN
DEFINE VARIABLE i-fecha AS DATE.
DEFINE VARIABLE o-lista_fechas AS CHARACTER.
&ELSE
DEFINE INPUT  PARAMETER i-fecha        AS DATE.
DEFINE OUTPUT PARAMETER o-lista_fechas AS CHARACTER.
&ENDIF

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE o-fecha AS DATE.

DEFINE VARIABLE ok        AS LOGICAL.
DEFINE VARIABLE idx-fecha AS INTEGER.

DEFINE VARIABLE nombre_meses AS CHARACTER 
       INITIAL "Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre".

DEFINE VARIABLE n-mes AS INTEGER.
DEFINE VARIABLE n-ano AS INTEGER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-5 RECT-4 RECT-3 RECT-6 btn_prevano ~
btn_nextano btn_prevmes btn_nextmes btn_prevdia btn_nextdia v-ano v-mes ~
v-fecha_actual Btn_OK v-fechas Btn_Borrar Btn_Cancel Btn_quitar 
&Scoped-Define DISPLAYED-OBJECTS v-ano v-mes v-fecha_actual v-fechas 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Borrar 
     LABEL "&Borrar" 
     SIZE 11 BY 1.15.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 11 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON btn_nextano 
     IMAGE-UP FILE "adeicon\next-au":U
     LABEL "btn_nextmes" 
     SIZE 4.72 BY .81.

DEFINE BUTTON btn_nextdia 
     IMAGE-UP FILE "adeicon\next-au":U
     LABEL "btn_nextdia" 
     SIZE 5 BY .81.

DEFINE BUTTON btn_nextmes 
     IMAGE-UP FILE "adeicon\next-au":U
     LABEL "btn_nextmes" 
     SIZE 6.57 BY .81.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 11 BY 1.15
     BGCOLOR 8 .

DEFINE BUTTON btn_prevano 
     IMAGE-UP FILE "adeicon\prev-au":U
     LABEL "btn_prevmes 3" 
     SIZE 4.72 BY .81.

DEFINE BUTTON btn_prevdia 
     IMAGE-UP FILE "adeicon\prev-au":U
     LABEL "btn_prevdia" 
     SIZE 5 BY .81.

DEFINE BUTTON btn_prevmes 
     IMAGE-UP FILE "adeicon\prev-au":U
     LABEL "Button 44" 
     SIZE 6.57 BY .81.

DEFINE BUTTON Btn_quitar 
     LABEL "&Quitar" 
     SIZE 11 BY 1.15.

DEFINE BUTTON BUTTON-1 
     LABEL "1" 
     SIZE 6 BY 1.35
     BGCOLOR 14 .

DEFINE BUTTON BUTTON-10 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-11 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-12 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-13 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-14 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-15 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-16 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-17 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-18 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-19 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-2 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-20 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-21 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-22 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-23 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-24 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-25 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-26 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-27 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-28 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-29 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-3 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-30 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-31 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-32 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-33 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-34 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-35 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-36 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-37 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-38 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-39 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-4 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-40 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-41 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-42 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-5 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-6 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-7 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-8 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE BUTTON BUTTON-9 
     LABEL "1" 
     SIZE 6 BY 1.35.

DEFINE VARIABLE v-ano AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "0" 
     SIZE 10 BY 1 NO-UNDO.

DEFINE VARIABLE v-mes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre" 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE VARIABLE v-fecha_actual AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .92
     BGCOLOR 15 FGCOLOR 9 FONT 4 NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 44 BY 2.96.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 44 BY 8.62.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 44 BY 2.42.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 44 BY 1.08.

DEFINE VARIABLE v-fechas AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SORT SCROLLBAR-VERTICAL 
     SIZE 17 BY 2.42
     BGCOLOR 15 FGCOLOR 9  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     btn_prevano AT ROW 1.27 COL 4
     btn_nextano AT ROW 1.27 COL 9
     btn_prevmes AT ROW 1.27 COL 16
     btn_nextmes AT ROW 1.27 COL 23
     btn_prevdia AT ROW 1.27 COL 35
     btn_nextdia AT ROW 1.27 COL 40
     v-ano AT ROW 2.35 COL 2 COLON-ALIGNED NO-LABEL
     v-mes AT ROW 2.35 COL 13 COLON-ALIGNED NO-LABEL
     v-fecha_actual AT ROW 2.35 COL 32 COLON-ALIGNED NO-LABEL
     BUTTON-1 AT ROW 4.77 COL 3
     BUTTON-2 AT ROW 4.77 COL 9
     BUTTON-3 AT ROW 4.77 COL 15
     BUTTON-4 AT ROW 4.77 COL 21
     BUTTON-5 AT ROW 4.77 COL 27
     BUTTON-6 AT ROW 4.77 COL 33
     BUTTON-7 AT ROW 4.77 COL 39
     BUTTON-8 AT ROW 6.12 COL 3
     BUTTON-9 AT ROW 6.12 COL 9
     BUTTON-10 AT ROW 6.12 COL 15
     BUTTON-11 AT ROW 6.12 COL 21
     BUTTON-12 AT ROW 6.12 COL 27
     BUTTON-13 AT ROW 6.12 COL 33
     BUTTON-14 AT ROW 6.12 COL 39
     BUTTON-15 AT ROW 7.46 COL 3
     BUTTON-16 AT ROW 7.46 COL 9
     BUTTON-17 AT ROW 7.46 COL 15
     BUTTON-18 AT ROW 7.46 COL 21
     BUTTON-19 AT ROW 7.46 COL 27
     BUTTON-20 AT ROW 7.46 COL 33
     BUTTON-21 AT ROW 7.46 COL 39
     BUTTON-22 AT ROW 8.81 COL 3
     BUTTON-23 AT ROW 8.81 COL 9
     BUTTON-24 AT ROW 8.81 COL 15
     BUTTON-25 AT ROW 8.81 COL 21
     BUTTON-26 AT ROW 8.81 COL 27
     BUTTON-27 AT ROW 8.81 COL 33
     BUTTON-28 AT ROW 8.81 COL 39
     BUTTON-29 AT ROW 10.15 COL 3
     BUTTON-30 AT ROW 10.15 COL 9
     BUTTON-31 AT ROW 10.15 COL 15
     BUTTON-32 AT ROW 10.15 COL 21
     BUTTON-33 AT ROW 10.15 COL 27
     BUTTON-34 AT ROW 10.15 COL 33
     BUTTON-35 AT ROW 10.15 COL 39
     BUTTON-36 AT ROW 11.5 COL 3
     BUTTON-37 AT ROW 11.5 COL 9
     BUTTON-38 AT ROW 11.5 COL 15
     BUTTON-39 AT ROW 11.5 COL 21
     BUTTON-40 AT ROW 11.5 COL 27
     BUTTON-41 AT ROW 11.5 COL 33
     BUTTON-42 AT ROW 11.5 COL 39
     Btn_OK AT ROW 13.38 COL 3
     v-fechas AT ROW 13.38 COL 15 NO-LABEL
     Btn_Borrar AT ROW 13.38 COL 33
     Btn_Cancel AT ROW 14.73 COL 3
     Btn_quitar AT ROW 14.73 COL 33
     "Dom" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 3.69 COL 4
          FGCOLOR 12 FONT 6
     RECT-5 AT ROW 1 COL 2
     "Mie" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 3.69 COL 22
          FGCOLOR 9 FONT 6
     "Lun" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 3.69 COL 10
          FGCOLOR 9 FONT 6
     RECT-4 AT ROW 4.5 COL 2
     RECT-3 AT ROW 13.12 COL 2
     "Jue" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 3.69 COL 28
          FGCOLOR 9 FONT 6
     "Sab" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 3.69 COL 40
          FGCOLOR 12 FONT 6
     "Mar" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 3.69 COL 16
          FGCOLOR 9 FONT 6
     "Vie" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 3.69 COL 34
          FGCOLOR 9 FONT 6
     RECT-6 AT ROW 3.42 COL 2
     SPACE(1.13) SKIP(13.30)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Ayuda de Calendario"
         DEFAULT-BUTTON Btn_OK CANCEL-BUTTON Btn_Cancel.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
                                                                        */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR BUTTON BUTTON-1 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-10 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-11 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-12 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-13 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-14 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-15 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-16 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-17 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-18 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-19 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-20 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-21 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-22 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-23 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-24 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-25 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-26 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-27 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-28 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-29 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-30 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-31 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-32 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-33 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-34 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-35 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-36 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-37 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-38 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-39 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-40 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-41 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-42 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-6 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-7 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-8 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR BUTTON BUTTON-9 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Ayuda de Calendario */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Borrar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Borrar Dialog-Frame
ON CHOOSE OF Btn_Borrar IN FRAME Dialog-Frame /* Borrar */
DO:
  v-fechas:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  v-fecha_actual = ?.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nextdia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nextdia Dialog-Frame
ON CHOOSE OF btn_nextdia IN FRAME Dialog-Frame /* btn_nextdia */
DO:
  v-fecha_actual = v-fecha_actual + 1.
  RUN incializar_campos ( INPUT v-fecha_actual ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_nextmes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_nextmes Dialog-Frame
ON CHOOSE OF btn_nextmes IN FRAME Dialog-Frame /* btn_nextmes */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-mes.
  n-mes = LOOKUP(v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME},nombre_meses,",").
  CASE n-mes:
       WHEN 12 
       THEN DO:
            n-mes = 1.
            v-ano = v-ano + 1.
       END.
       OTHERWISE n-mes = n-mes + 1.
       
  END.
  v-fecha_actual = DATE(n-mes,1,v-ano).
  RUN incializar_campos ( INPUT v-fecha_actual ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  o-lista_fechas = v-fechas:LIST-ITEMS IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_prevdia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_prevdia Dialog-Frame
ON CHOOSE OF btn_prevdia IN FRAME Dialog-Frame /* btn_prevdia */
DO:

  v-fecha_actual = v-fecha_actual - 1.
  RUN incializar_campos ( INPUT v-fecha_actual ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_prevmes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_prevmes Dialog-Frame
ON CHOOSE OF btn_prevmes IN FRAME Dialog-Frame /* Button 44 */
DO:
  ASSIGN FRAME {&FRAME-NAME} v-mes.
  n-mes = LOOKUP(v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME},nombre_meses,",").
  CASE n-mes:
       WHEN 1 
       THEN DO:
            n-mes = 12.
            v-ano = v-ano - 1.
       END.
       OTHERWISE n-mes = n-mes - 1.
       
  END.
  v-fecha_actual = DATE(n-mes,1,v-ano).
  RUN incializar_campos ( INPUT v-fecha_actual ).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_quitar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_quitar Dialog-Frame
ON CHOOSE OF Btn_quitar IN FRAME Dialog-Frame /* Quitar */
DO:
  IF v-fechas:SCREEN-VALUE <> "" AND v-fechas:SCREEN-VALUE <> ?
  THEN DO:
        idx-fecha = v-fechas:LOOKUP(v-fechas:SCREEN-VALUE).
        IF idx-fecha > 0
           THEN ok = v-fechas:DELETE(idx-fecha)IN FRAME {&FRAME-NAME}.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 Dialog-Frame
ON CHOOSE OF BUTTON-1 IN FRAME Dialog-Frame /* 1 */
OR CHOOSE OF BUTTON-2 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-3 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-4 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-5 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-6 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-7 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-8 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-9 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-10 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-11 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-12 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-13 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-14 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-15 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-16 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-17 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-18 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-19 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-20 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-21 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-22 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-23 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-24 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-25 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-26 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-27 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-28 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-29 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-30 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-31 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-32 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-33 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-34 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-35 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-36 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-37 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-38 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-39 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-40 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-41 IN FRAME {&FRAME-NAME}
OR CHOOSE OF BUTTON-42 IN FRAME {&FRAME-NAME}

DO:
  
  v-fecha_actual = DATE(SELF:PRIVATE-DATA).
  DISPLAY v-fecha_actual
          WITH FRAME {&FRAME-NAME}.

  IF SELF:PRIVATE-DATA <> "" AND SELF:PRIVATE-DATA <> ?
  THEN DO:
        idx-fecha = v-fechas:LOOKUP(SELF:PRIVATE-DATA).
        IF idx-fecha = 0 OR idx-fecha = ?
        THEN DO:
             ok = v-fechas:ADD-LAST(SELF:PRIVATE-DATA) IN FRAME {&FRAME-NAME}.
        END.
        ELSE DO:
             ok = v-fechas:DELETE(idx-fecha)IN FRAME {&FRAME-NAME}.
        END.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-ano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-ano Dialog-Frame
ON VALUE-CHANGED OF v-ano IN FRAME Dialog-Frame
DO:
  ASSIGN v-ano.
  v-fecha_actual = DATE(LOOKUP(v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME},nombre_meses,","),1,v-ano).
  RUN incializar_campos ( INPUT v-fecha_actual ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-mes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-mes Dialog-Frame
ON VALUE-CHANGED OF v-mes IN FRAME Dialog-Frame
DO:
  ASSIGN FRAME {&FRAME-NAME} v-mes.
  v-fecha_actual = DATE(LOOKUP(v-mes:SCREEN-VALUE IN FRAME {&FRAME-NAME},nombre_meses,","),1,v-ano).
  RUN incializar_campos ( INPUT v-fecha_actual ).

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
v-fechas:LIST-ITEMS IN FRAME {&FRAME-NAME} = "".
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN incializar_campos ( INPUT i-fecha ).
  RUN enable_UI.
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
  o-fecha = v-fecha_actual.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE asignar_fecha Dialog-Frame 
PROCEDURE asignar_fecha :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-widget AS WIDGET-HANDLE.
  DEFINE INPUT PARAMETER p-fecha  AS DATE.
  DEFINE INPUT PARAMETER n-fecha  AS DATE.

  p-widget:LABEL         = STRING(DAY(p-fecha)).
  p-widget:PRIVATE-DATA  = STRING(p-fecha,"99/99/9999").
  p-widget:SENSITIVE     = ( MONTH(p-fecha) = MONTH(n-fecha) ) .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame _DEFAULT-ENABLE
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
  DISPLAY v-ano v-mes v-fecha_actual v-fechas 
      WITH FRAME Dialog-Frame.
  ENABLE RECT-5 RECT-4 RECT-3 RECT-6 btn_prevano btn_nextano btn_prevmes 
         btn_nextmes btn_prevdia btn_nextdia v-ano v-mes v-fecha_actual Btn_OK 
         v-fechas Btn_Borrar Btn_Cancel Btn_quitar 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE incializar_campos Dialog-Frame 
PROCEDURE incializar_campos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER fecha_inicial  AS DATE.

    DEFINE VARIABLE w-actual       AS WIDGET-HANDLE.
    DEFINE VARIABLE w-foco         AS WIDGET-HANDLE.
    DEFINE VARIABLE v-deltafila    AS DECIMAL.
    DEFINE VARIABLE v-deltacolumna AS DECIMAL.
    DEFINE VARIABLE v-fila0        AS DECIMAL.
    DEFINE VARIABLE v-columna0     AS DECIMAL.
    DEFINE VARIABLE inicia_mes     AS DATE.
    DEFINE VARIABLE voy_fecha      AS DATE.
    DEFINE VARIABLE v-dia0         AS INTEGER.
    DEFINE VARIABLE j              AS INTEGER.
    DEFINE VARIABLE ok             AS LOGICAL.
    
    DO WITH FRAME {&FRAME-NAME}:

       DO j = 1901 TO 2050:
            ok = v-ano:ADD-LAST(STRING(j,"9999")).
       END.

       v-mes:SCREEN-VALUE = ENTRY(MONTH(fecha_inicial),nombre_meses,",").
       v-ano              = YEAR(fecha_inicial).
       v-ano:SCREEN-VALUE = STRING(v-ano,"9999").
       w-actual           = BUTTON-1:HANDLE.
       v-fila0            = BUTTON-1:ROW.
       v-columna0         = BUTTON-1:COLUMN.
       v-deltafila        = BUTTON-8:ROW - v-fila0.
       v-deltacolumna     = BUTTON-2:COLUMN - v-columna0.

    END.          

    inicia_mes = DATE(MONTH(fecha_inicial),1,YEAR(fecha_inicial)).
    v-dia0 = WEEKDAY(inicia_mes).
    
    CASE v-dia0:
         WHEN 1
         THEN DO:
              w-actual = BUTTON-1:HANDLE.
         END.
    
         WHEN 2 
         THEN DO:
              RUN asignar_fecha ( INPUT BUTTON-1:HANDLE, INPUT inicia_mes - 1, INPUT fecha_inicial ).
             
              BUTTON-2:LABEL = STRING(DAY(inicia_mes),">9").
              w-actual = BUTTON-2:HANDLE.
         END.
    
         WHEN 3 
         THEN DO:
              RUN asignar_fecha ( INPUT BUTTON-1:HANDLE, INPUT inicia_mes - 2, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-2:HANDLE, INPUT inicia_mes - 1, INPUT fecha_inicial ).
    
              BUTTON-3:LABEL = STRING(DAY(inicia_mes),">9").
              w-actual = BUTTON-3:HANDLE.
         END.
    
         WHEN 4 
         THEN DO:
              RUN asignar_fecha ( INPUT BUTTON-1:HANDLE, INPUT inicia_mes - 3, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-2:HANDLE, INPUT inicia_mes - 2, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-3:HANDLE, INPUT inicia_mes - 1, INPUT fecha_inicial ).
    
              BUTTON-4:LABEL = STRING(DAY(inicia_mes),">9").
              w-actual = BUTTON-4:HANDLE.
         END.
    
         WHEN 5 
         THEN DO:
              RUN asignar_fecha ( INPUT BUTTON-1:HANDLE, INPUT inicia_mes - 4, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-2:HANDLE, INPUT inicia_mes - 3, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-3:HANDLE, INPUT inicia_mes - 2, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-4:HANDLE, INPUT inicia_mes - 1, INPUT fecha_inicial ).
    
              BUTTON-5:LABEL = STRING(DAY(inicia_mes),">9").
              w-actual = BUTTON-5:HANDLE.
         END.
    
         WHEN 6 
         THEN DO:
              RUN asignar_fecha ( INPUT BUTTON-1:HANDLE, INPUT inicia_mes - 5, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-2:HANDLE, INPUT inicia_mes - 4, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-3:HANDLE, INPUT inicia_mes - 3, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-4:HANDLE, INPUT inicia_mes - 2, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-5:HANDLE, INPUT inicia_mes - 1, INPUT fecha_inicial ).
    
              BUTTON-6:LABEL = STRING(DAY(inicia_mes),">9").
              w-actual = BUTTON-6:HANDLE.
         END.
    
         WHEN 7 
         THEN DO:
              RUN asignar_fecha ( INPUT BUTTON-1:HANDLE, INPUT inicia_mes - 6, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-2:HANDLE, INPUT inicia_mes - 5, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-3:HANDLE, INPUT inicia_mes - 4, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-4:HANDLE, INPUT inicia_mes - 3, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-5:HANDLE, INPUT inicia_mes - 2, INPUT fecha_inicial ).
              RUN asignar_fecha ( INPUT BUTTON-6:HANDLE, INPUT inicia_mes - 1, INPUT fecha_inicial ).
    
              w-actual = BUTTON-7:HANDLE.
         END.
    
         
    END CASE.
    
    voy_fecha = inicia_mes.
    
    DO WHILE w-actual:NAME BEGINS "BUTTON-":
    
       RUN asignar_fecha ( INPUT w-actual, INPUT voy_fecha, INPUT fecha_inicial ).
       IF voy_fecha = fecha_inicial 
          THEN w-foco = w-actual.
    
       w-actual = w-actual:NEXT-SIBLING.   
       voy_fecha = voy_fecha + 1.
    
    END.
    
    v-fecha_actual = DATE(w-foco:PRIVATE-DATA).
    DISPLAY v-fecha_actual
            WITH FRAME {&FRAME-NAME}.

/*  APPLY "CHOOSE" TO w-foco.*/

    APPLY "ENTRY" TO w-foco.
   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


