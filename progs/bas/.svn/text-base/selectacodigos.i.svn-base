/*========================================================================================*/
/*               ARMA UNA LISTA CON LOS CODIGOS SELECCIONADOS EN UN MAESTRO DADO          */
/*========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER seleccion AS CHARACTER.

/*{VRSHARED.I}*/

DEFINE VARIABLE como_fue AS LOGICAL.

DEFINE VARIABLE selec AS CHARACTER
       VIEW-AS SELECTION-LIST SIZE 26 BY 10 SCROLLBAR-VERTICAL.
DEFINE VARIABLE dispo AS CHARACTER 
       VIEW-AS SELECTION-LIST SIZE 26 BY 10 SCROLLBAR-VERTICAL.
       
DEFINE VARIABLE item AS CHARACTER.
DEFINE VARIABLE j    AS INTEGER.

DEFINE BUTTON btn_salir  SIZE 13 BY 1 LABEL "Cancelar".
DEFINE BUTTON btn_grabar SIZE 13 BY 1 LABEL "Asignar".
DEFINE BUTTON btn_desall SIZE 13 BY 1 LABEL "<==TODOS".
DEFINE BUTTON btn_selall SIZE 13 BY 1 LABEL "TODOS==>".

FORM 
   
   "       Disponibles    " FGCOLOR 0 BGCOLOR 8 AT ROW 1 COL 1
   "      Seleccionados   " FGCOLOR 0 BGCOLOR 8 AT ROW 1 COL 30
   dispo AT ROW 2 COL 1   FGCOLOR 9 BGCOLOR 15
   selec AT ROW 2 COL 29  FGCOLOR 9 BGCOLOR 15
   SKIP
   btn_selall SPACE(0) btn_salir SPACE(2) btn_grabar SPACE(0) btn_desall
   WITH FRAME frm-elegir CENTERED NO-LABELS VIEW-AS DIALOG-BOX FONT 4
        FGCOLOR 0 BGCOLOR 8 THREE-D TITLE "Seleccion de items".

ON MOUSE-SELECT-DBLCLICK OF selec  
DO:
  IF selec:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:
     item = selec:SCREEN-VALUE.
     IF item <> ?
     THEN DO:
        como_fue = dispo:ADD-LAST(item).
        como_fue = selec:DELETE(item).
     END.   
  END.   
END.

ON MOUSE-SELECT-DBLCLICK OF dispo
DO:
  IF dispo:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:
     item = dispo:SCREEN-VALUE.
     IF item <> ?
     THEN DO:
        como_fue = selec:ADD-LAST(item).
        como_fue = dispo:DELETE(item).
     END.   
  END.   
END.   

ON CHOOSE OF btn_desall
DO:
  IF selec:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:                     
     DO WHILE selec:NUM-ITEMS <> 0:
        item = selec:ENTRY(1).
        como_fue = dispo:ADD-LAST(item).
        como_fue = selec:DELETE(item).
     END.   
  END.   
END.

ON CHOOSE OF btn_selall
DO:
  IF dispo:NUM-ITEMS = 0
  THEN DO:
     BELL.
  END.
  ELSE DO:                     
     DO WHILE dispo:NUM-ITEMS <> 0:
        item = dispo:ENTRY(1).
        como_fue = selec:ADD-LAST(item).
        como_fue = dispo:DELETE(item).
     END.   
  END.   
END.

ON CHOOSE OF btn_grabar
DO:
    seleccion = "".
    DO WHILE selec:NUM-ITEMS <> 0:
       FIND {&TABLA} WHERE {&TABLA}.{&NOMBRE} = selec:ENTRY(1) NO-LOCK.
       seleccion = seleccion + {&TABLA}.{&CODIGO}.
       IF selec:NUM-ITEMS > 1 THEN seleccion = seleccion + ",".
       como_fue = selec:DELETE(1).
    END.   
    
    APPLY "CHOOSE" TO btn_salir.
END.   

/*=====================================================================================*/
/*                        B L O Q U E    P R I N C I P A L                             */
/*=====================================================================================*/

FOR EACH {&TABLA} BY {&TABLA}.{&NOMBRE}:
    IF LOOKUP({&TABLA}.{&CODIGO},seleccion) = 0 OR
       LOOKUP({&TABLA}.{&CODIGO},seleccion) = ?
    THEN como_fue = dispo:ADD-LAST({&TABLA}.{&NOMBRE}).
    ELSE como_fue = selec:ADD-LAST({&TABLA}.{&NOMBRE}).

END.

DISPLAY selec dispo 
        WITH FRAME frm-elegir.

ENABLE  selec dispo btn_desall btn_salir btn_grabar btn_selall
        WITH FRAME frm-elegir.

WAIT-FOR CHOOSE OF btn_salir IN FRAME frm-elegir.
