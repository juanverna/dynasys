&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 Character
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS a 
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

/* Local Variable Definitions ---                                       */

/*{nrorelea.i}*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME a

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS v-empresa v-tipo_rendicion btn_ingresar ~
Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS v-empresa v-nom-empresa v-tipo_rendicion ~
v-nom-tiporend 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Salir del Sistema" 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 26 BY 1
     &ELSE SIZE 26 BY 1.01 &ENDIF.

DEFINE BUTTON btn_ingresar 
     LABEL "Ingresar Cupones" 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 24 BY 1
     &ELSE SIZE 24 BY 1.01 &ENDIF.

DEFINE VARIABLE v-empresa AS CHARACTER FORMAT "X(256)":U 
     LABEL "Empresa" 
     VIEW-AS FILL-IN 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 7 BY 1
     &ELSE SIZE 7 BY 1 &ENDIF NO-UNDO.

DEFINE VARIABLE v-nom-empresa AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 37 BY 1
     &ELSE SIZE 37 BY 1 &ENDIF NO-UNDO.

DEFINE VARIABLE v-nom-tiporend AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 37 BY 1
     &ELSE SIZE 37 BY 1 &ENDIF NO-UNDO.

DEFINE VARIABLE v-tipo_rendicion AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tipo" 
     VIEW-AS FILL-IN 
     &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 7 BY 1
     &ELSE SIZE 7 BY 1 &ENDIF NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME a
     v-empresa
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 7 COL 38 COLON-ALIGNED
          &ELSE AT ROW 7 COL 38 COLON-ALIGNED &ENDIF
     v-nom-empresa
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 7 COL 47 COLON-ALIGNED
          &ELSE AT ROW 7 COL 47 COLON-ALIGNED &ENDIF NO-LABEL
     v-tipo_rendicion
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 11 COL 38 COLON-ALIGNED
          &ELSE AT ROW 11 COL 38 COLON-ALIGNED &ENDIF
     v-nom-tiporend
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 11 COL 47 COLON-ALIGNED
          &ELSE AT ROW 11 COL 47 COLON-ALIGNED &ENDIF NO-LABEL
     btn_ingresar
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 18 COL 16
          &ELSE AT ROW 18 COL 16 &ENDIF
     Btn_Cancel
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 18 COL 44
          &ELSE AT ROW 18 COL 44 &ENDIF
     "para" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 6 BY 1
          &ELSE SIZE 6 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 4 COL 43
          &ELSE AT ROW 4 COL 43 &ENDIF
     "para" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 6 BY 1
          &ELSE SIZE 6 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 3 COL 43
          &ELSE AT ROW 3 COL 43 &ENDIF
     "AZUL" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 5 BY 1
          &ELSE SIZE 5 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 3 COL 50
          &ELSE AT ROW 3 COL 50 &ENDIF
     "R" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 2 BY 1
          &ELSE SIZE 2 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 4 COL 40
          &ELSE AT ROW 4 COL 40 &ENDIF
     "Ingrese" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 10 BY 1
          &ELSE SIZE 10 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 3 COL 26
          &ELSE AT ROW 3 COL 26 &ENDIF
     "3 - Bajas" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 22 BY 1
          &ELSE SIZE 22 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 14 COL 40
          &ELSE AT ROW 14 COL 40 &ENDIF
     "CUERPO MEDICO" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 22 BY 1
          &ELSE SIZE 22 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 6 COL 50
          &ELSE AT ROW 6 COL 50 &ENDIF
     "C" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 2 BY 1
          &ELSE SIZE 2 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 6 COL 40
          &ELSE AT ROW 6 COL 40 &ENDIF
     "para" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 6 BY 1
          &ELSE SIZE 6 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 6 COL 43
          &ELSE AT ROW 6 COL 43 &ENDIF
     "TIME" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 6 BY 1
          &ELSE SIZE 6 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 5 COL 50
          &ELSE AT ROW 5 COL 50 &ENDIF
     "T" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 2 BY 1
          &ELSE SIZE 2 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 5 COL 40
          &ELSE AT ROW 5 COL 40 &ENDIF
.
/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME a
     "para" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 6 BY 1
          &ELSE SIZE 6 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 5 COL 43
          &ELSE AT ROW 5 COL 43 &ENDIF
     "1 - Cobranzas" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 22 BY 1
          &ELSE SIZE 22 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 12 COL 40
          &ELSE AT ROW 12 COL 40 &ENDIF
     "A" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 2 BY 1
          &ELSE SIZE 2 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 3 COL 40
          &ELSE AT ROW 3 COL 40 &ENDIF
     "ROJO" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 6 BY 1
          &ELSE SIZE 6 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 4 COL 50
          &ELSE AT ROW 4 COL 50 &ENDIF
     "4 - Devoluciones" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 24 BY 1
          &ELSE SIZE 24 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 15 COL 40
          &ELSE AT ROW 15.01 COL 40 &ENDIF
     "Indique el tipo de rendición a ingresar" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 57 BY 1
          &ELSE SIZE 57 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 9 COL 27
          &ELSE AT ROW 9 COL 27 &ENDIF
     "2 - Moras" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 22 BY 1
          &ELSE SIZE 22 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 13 COL 40
          &ELSE AT ROW 12.99 COL 40 &ENDIF
     "Por Favor, identifique la empresa:" VIEW-AS TEXT
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN SIZE 49 BY 1
          &ELSE SIZE 49 BY 1 &ENDIF
          &IF '{&WINDOW-SYSTEM}' = 'TTY':U &THEN AT ROW 2 COL 26
          &ELSE AT ROW 2 COL 26 &ENDIF
     SPACE(40.28) SKIP(20.14)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
        TITLE "Identificacion de Empresa"
         CANCEL-BUTTON Btn_Cancel.


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
/* SETTINGS FOR DIALOG-BOX a
                                                                        */
ASSIGN 
       FRAME a:SCROLLABLE       = FALSE
       FRAME a:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN v-nom-empresa IN FRAME a
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN v-nom-tiporend IN FRAME a
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME a
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL a a
ON WINDOW-CLOSE OF FRAME a /* Identificacion de Empresa */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_ingresar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_ingresar a
ON CHOOSE OF btn_ingresar IN FRAME a /* Ingresar Cupones */
DO:

  ASSIGN FRAME {&FRAME-NAME} v-empresa.
  IF LOOKUP(v-empresa,"A,R,C,T") = 0
  THEN DO:
       MESSAGE "Para la EMPRESA debe indicar solo A,R,C o T" VIEW-AS ALERT-BOX ERROR.
       RETURN NO-APPLY.
  END.
  ELSE DO:
       v-nom-empresa = "Seleccionó ".
       CASE v-empresa:
            WHEN "A" THEN v-nom-empresa = v-nom-empresa + "AZUL".
            WHEN "R" THEN v-nom-empresa = v-nom-empresa + "ROJO".
            WHEN "C" THEN v-nom-empresa = v-nom-empresa + "CUERPO MEDICO".
            WHEN "T" THEN v-nom-empresa = v-nom-empresa + "TIME".
       END CASE.
       DISPLAY v-nom-empresa
               WITH FRAME {&FRAME-NAME}.

       ASSIGN FRAME {&FRAME-NAME} v-tipo_rendicion.
       IF LOOKUP(v-tipo_rendicion,"1,2,3,4") = 0
       THEN DO:
            MESSAGE "Para el TIPO DE RENDICION debe indicar solo 1, 2, 3 o 4"  VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
       END.
       ELSE DO:
        
            DO TRANSACTION:
            
                CREATE Rendicion_hd.
                ASSIGN
                       Rendicion_hd.nro_rendicion  = NEXT-VALUE(proxima_rendicion)
                       Rendicion_hd.cdg_empresa    = v-empresa
                       Rendicion_hd.fch_rendicion  = TODAY
                       Rendicion_hd.tipo           = v-tipo_rendicion
                       Rendicion_hd.abierta        = YES.
                       
                /*
                MESSAGE "Número:" STRING(Rendicion_hd.nro_rendicion,">>>>9")
                               VIEW-AS ALERT-BOX MESSAGE TITLE "Creando Rendición".
                */
                       
                RUN d-alta_cupones.w ( INPUT ROWID(Rendicion_hd) ).       
            
                RELEASE Rendicion_hd.
                
            END.
                       
            ASSIGN
                  v-empresa = ""
                  v-tipo_rendicion = ""
                  v-nom-empresa = ""
                  v-nom-tiporend = "".
          
            DISPLAY
                  v-empresa
                  v-tipo_rendicion
                  v-nom-empresa
                  v-nom-tiporend
                  WITH FRAME {&FRAME-NAME}.
          
            APPLY "ENTRY" TO v-empresa.
            RETURN NO-APPLY.
       END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-empresa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-empresa a
ON ANY-PRINTABLE OF v-empresa IN FRAME a /* Empresa */
DO:
 v-empresa = CAPS(KEYFUNCTION(LASTKEY)).
 IF LOOKUP(v-empresa,"A,R,C,T") = 0
 THEN DO:
      MESSAGE "Para la EMPRESA debe indicar solo A,R,C o T" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
 END.
 ELSE DO:
      v-nom-empresa = "Seleccionó ".
      CASE v-empresa:
           WHEN "A" THEN v-nom-empresa = v-nom-empresa + "AZUL".
           WHEN "R" THEN v-nom-empresa = v-nom-empresa + "ROJO".
           WHEN "C" THEN v-nom-empresa = v-nom-empresa + "CUERPO MEDICO".
           WHEN "T" THEN v-nom-empresa = v-nom-empresa + "TIME".
      END CASE.
      DISPLAY v-nom-empresa
              v-empresa
              WITH FRAME {&FRAME-NAME}.
      APPLY "TAB" TO SELF.
      RETURN NO-APPLY.
 END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-empresa a
ON LEAVE OF v-empresa IN FRAME a /* Empresa */
DO:
/*
 ASSIGN FRAME {&FRAME-NAME} v-empresa.
 IF LOOKUP(v-empresa,"A,R,C,T") = 0
 THEN DO:
      MESSAGE "Para la EMPRESA debe indicar solo A,R,C o T" VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
 END.
 ELSE DO:
      v-nom-empresa = "Seleccionó ".
      CASE v-empresa:
           WHEN "A" THEN v-nom-empresa = v-nom-empresa + "AZUL".
           WHEN "R" THEN v-nom-empresa = v-nom-empresa + "ROJO".
           WHEN "C" THEN v-nom-empresa = v-nom-empresa + "CUERPO MEDICO".
           WHEN "T" THEN v-nom-empresa = v-nom-empresa + "TIME".

      END CASE.
      DISPLAY v-nom-empresa
              WITH FRAME {&FRAME-NAME}.
 END.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-empresa a
ON RETURN OF v-empresa IN FRAME a /* Empresa */
DO:
  APPLY "TAB" TO v-empresa IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME v-tipo_rendicion
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tipo_rendicion a
ON ANY-PRINTABLE OF v-tipo_rendicion IN FRAME a /* Tipo */
DO:

 v-tipo_rendicion = KEYFUNCTION(LASTKEY).
 IF LOOKUP(v-tipo_rendicion,"1,2,3,4") = 0
 THEN DO:
      MESSAGE "Para el TIPO DE RENDICION debe indicar solo 1, 2, 3 o 4" 
              VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
 END.
 ELSE DO:
      v-nom-tiporend = "Seleccionó ".
      CASE v-tipo_rendicion:
           WHEN "1" THEN v-nom-tiporend = v-nom-tiporend + "COBRANZAS".
           WHEN "2" THEN v-nom-tiporend = v-nom-tiporend + "MORAS".
           WHEN "3" THEN v-nom-tiporend = v-nom-tiporend + "BAJAS".
           WHEN "4" THEN v-nom-tiporend = v-nom-tiporend + "DEVOLUCIONES".
      END CASE.
      DISPLAY v-nom-tiporend
              v-tipo_rendicion
              WITH FRAME {&FRAME-NAME}.
      APPLY "TAB" TO SELF.
      RETURN NO-APPLY.
 END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tipo_rendicion a
ON LEAVE OF v-tipo_rendicion IN FRAME a /* Tipo */
DO:
/* 
 ASSIGN FRAME {&FRAME-NAME} v-tipo_rendicion.
 IF LOOKUP(v-tipo_rendicion,"1,2,3,4") = 0
 THEN DO:
      MESSAGE "Para el TIPO DE RENDICION debe indicar solo 1, 2, 3 o 4" 
              VIEW-AS ALERT-BOX ERROR.
      RETURN NO-APPLY.
 END.
 ELSE DO:
      v-nom-tiporend = "Seleccionó ".
      CASE v-tipo_rendicion:
           WHEN "1" THEN v-nom-tiporend = v-nom-tiporend + "COBRANZAS".
           WHEN "2" THEN v-nom-tiporend = v-nom-tiporend + "MORAS".
           WHEN "3" THEN v-nom-tiporend = v-nom-tiporend + "BAJAS".
           WHEN "4" THEN v-nom-tiporend = v-nom-tiporend + "DEVOLUCIONES".
      END CASE.
      DISPLAY v-nom-tiporend
              WITH FRAME {&FRAME-NAME}.
 END.
*/ 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL v-tipo_rendicion a
ON RETURN OF v-tipo_rendicion IN FRAME a /* Tipo */
DO:
  APPLY "TAB" TO v-tipo_rendicion IN FRAME {&FRAME-NAME}.
  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK a 


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
  /*{setwintit.i "SIC/AFI" "Ingreso de Cupones"}*/
  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI a _DEFAULT-DISABLE
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
  HIDE FRAME a.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI a _DEFAULT-ENABLE
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
  DISPLAY v-empresa v-nom-empresa v-tipo_rendicion v-nom-tiporend 
      WITH FRAME a.
  ENABLE v-empresa v-tipo_rendicion btn_ingresar Btn_Cancel 
      WITH FRAME a.
  VIEW FRAME a.
  {&OPEN-BROWSERS-IN-QUERY-a}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


