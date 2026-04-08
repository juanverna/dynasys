
DEFINE INPUT-OUTPUT PARAMETER disponibles AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER seleccion   AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

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

   "      Seleccionados     " FGCOLOR fe_c BGCOLOR be_c FONT 0 AT  2
   "       Disponibles      " FGCOLOR fe_c BGCOLOR be_c FONT 0 AT 30
   selec AT ROW 2 COL 1  FGCOLOR fg_c BGCOLOR bg_c
   dispo AT ROW 2 COL 29 FGCOLOR fg_c BGCOLOR bg_c
   SKIP
   btn_desall SPACE(0) btn_salir SPACE(2) btn_grabar SPACE(0) btn_selall
   WITH FRAME frm-elegir CENTERED NO-LABELS VIEW-AS DIALOG-BOX
        FGCOLOR f-fg_c BGCOLOR f-bg_c THREE-D FONT 8 TITLE "Seleccion de items".

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
   disponibles = dispo:LIST-ITEMS.
   APPLY "CHOOSE" TO btn_salir.
END.

/*------------------------------------------------------------------------------------*/
/*                                      M A I N                                       */
/*------------------------------------------------------------------------------------*/

selec:LIST-ITEMS = seleccion.
dispo:LIST-ITEMS = disponibles.

DISPLAY selec dispo
        WITH FRAME frm-elegir.

ENABLE  selec dispo btn_desall btn_salir btn_grabar btn_selall
        WITH FRAME frm-elegir.

WAIT-FOR CHOOSE OF btn_salir IN FRAME frm-elegir.
