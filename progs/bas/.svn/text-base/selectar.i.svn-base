/*===============================================================================================*/
/*   FUNCION GENERALIZADA DE ARMADO DE LISTAS DE CÓDIGOS EN BASE A DESCRIPCIONES                 */
/*===============================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER seleccion AS CHARACTER.

{VRSHARED.I}

DEFINE VARIABLE selec AS CHARACTER
       VIEW-AS SELECTION-LIST SIZE 26 BY 10 SORT SCROLLBAR-VERTICAL.
DEFINE VARIABLE dispo AS CHARACTER 
       VIEW-AS SELECTION-LIST SIZE 26 BY 10 SORT SCROLLBAR-VERTICAL.
       
DEFINE VARIABLE item AS CHARACTER.
DEFINE VARIABLE j    AS INTEGER.

DEFINE BUTTON btn_salir  SIZE 13 BY 1 LABEL "Cancelar".
DEFINE BUTTON btn_grabar SIZE 13 BY 1 LABEL "Asignar".
DEFINE BUTTON btn_desall SIZE 13 BY 1 LABEL "TODOS==>".
DEFINE BUTTON btn_selall SIZE 13 BY 1 LABEL "<==TODOS".

FORM 
   
   "      Seleccionados     " FGCOLOR 0 BGCOLOR 15 FONT 5 AT  ROW 1 COLUMN 2
   "       Disponibles      " FGCOLOR 0 BGCOLOR 15 FONT 5 AT  ROW 1 COLUMN 30
   selec AT ROW 2 COL 1  FGCOLOR 1 BGCOLOR 15 
   dispo AT ROW 2 COL 29 FGCOLOR 1 BGCOLOR 15
   SKIP
   btn_desall SPACE(0) btn_salir SPACE(2) btn_grabar SPACE(0) btn_selall
   WITH FRAME frm-elegir CENTERED NO-LABELS VIEW-AS DIALOG-BOX
        FGCOLOR 0 BGCOLOR 8 THREE-D FONT 4 TITLE "Seleccion de items".

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
   seleccion = selec:LIST-ITEMS.
   APPLY "CHOOSE" TO btn_salir.
END.   

/*------------------------------------------------------------------------------------
                                      M A I  N 
  ------------------------------------------------------------------------------------*/                                      
selec:LIST-ITEMS = seleccion.
FOR EACH {&TABLA} BY {&TABLA}.{&NOMBRE}:
    IF LOOKUP({&TABLA}.{&NOMBRE},selec:LIST-ITEMS) = 0 OR
       LOOKUP({&TABLA}.{&NOMBRE},selec:LIST-ITEMS) = ?
    THEN como_fue = dispo:ADD-LAST({&TABLA}.{&NOMBRE}).
END.

DISPLAY selec dispo 
        WITH FRAME frm-elegir.

ENABLE  selec dispo btn_desall btn_salir btn_grabar btn_selall
        WITH FRAME frm-elegir.

WAIT-FOR CHOOSE OF btn_salir IN FRAME frm-elegir.
