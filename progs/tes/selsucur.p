
DEFINE INPUT  PARAMETER que_banco   AS ROWID.
DEFINE INPUT-OUTPUT PARAMETER que_sucursal as ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VAR que_item   AS CHARACTER FORMAT "X(20)".
DEFINE VAR que_tecla  AS CHARACTER FORMAT "X(1)".
DEFINE VAR des_domi   AS CHARACTER FORMAT "X(20)".
DEFINE VAR p_letra    AS INTEGER.
DEFINE VAR que_char   AS INTEGER.
DEFINE VAR ldes       AS INTEGER.

DEFINE BUTTON btn-elegir
     LABEL "Elegir":L
     SIZE 20 BY 1.

DEFINE BUTTON btn-salir
     LABEL "Cancelar":L
     SIZE 20 BY 1.

DEFINE VARIABLE sel_sucursal AS CHARACTER FORMAT "X(26)":U
     VIEW-AS FILL-IN
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE QUERY qry_sucursales FOR Banco_sucursal SCROLLING.

DEFINE BROWSE brw_sucursales QUERY qry_sucursales DISPLAY
       Banco_sucursal.cdg_sucurbanco
       Banco_sucursal.nombre
       Banco_sucursal.direccion
       WITH NO-LABELS NO-UNDERLINE SIZE 40 BY 6
            BGCOLOR h-bg_c FGCOLOR h-fg_c FONT 9
            TITLE BGCOLOR 4 FGCOLOR 14 "Sucursales asociadas":L.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frm-sel
     sel_sucursal AT ROW 1 COL 1 HELP
          "Ingrese el nombre de la Sucursal" NO-LABEL
     brw_sucursales   AT ROW 2 COL 1
     btn-elegir AT ROW 8 COL 1
     btn-salir  AT ROW 8 COL 21
     WITH 1 DOWN OVERLAY SIDE-LABELS
          AT COL 10 ROW 5
          BGCOLOR h-bg_c FGCOLOR h-fg_c FONT 9
          TITLE BGCOLOR 7 FGCOLOR 8 "Seleccion de Sucursales":L
          VIEW-AS DIALOG-BOX.

/* ************************  Control Triggers  ************************ */

ON ANY-KEY OF sel_sucursal IN FRAME FRM-SEL
DO:

  ldes = LENGTH(des_domi).
  que_char = LASTKEY.

  IF KEYFUNCTION(que_char) = "GO"
     THEN APPLY "RETURN" TO SELF.

  IF KEYFUNCTION(que_char) = "TAB"
     THEN APPLY "TAB" TO SELF.

  IF KEYFUNCTION(que_char) = "END-ERROR"
     THEN APPLY "END-ERROR" TO SELF.

  que_tecla = CAPS(CHR(que_char)).
  p_letra = INDEX("ABCDEFGHIJKLMN¥OPQRSTUVWXYZ ",que_tecla).

  IF p_letra <> 0
  THEN DO:
    des_domi = des_domi + que_tecla.
    ldes = ldes + 1.
  END.
  ELSE
    IF KEYFUNCTION(que_char) = "BACKSPACE"
    THEN DO:
       des_domi = substring(des_domi,1,ldes - 1).
       ldes = ldes - 1.
    END.

  OPEN QUERY qry_sucursales
       FOR EACH Banco_sucursal OF Banco NO-LOCK
           WHERE Banco_sucursal.nombre BEGINS des_domi BY Banco_sucursal.nombre.

  sel_sucursal:SCREEN-VALUE IN FRAME frm-sel = des_domi.
  IF ldes >= 0 THEN
     sel_sucursal:CURSOR-OFFSET IN FRAME frm-sel = ldes + 1.

  RETURN NO-APPLY.
END.

ON RETURN OF sel_sucursal IN FRAME FRM-SEL OR
   MOUSE-SELECT-DBLCLICK OF brw_sucursales IN FRAME FRM-SEL OR
   RETURN OF brw_sucursales IN FRAME FRM-SEL
DO:
  APPLY "CHOOSE" TO btn-elegir.
END.

ON CHOOSE OF btn-elegir IN FRAME FRM-SEL
DO:
  que_sucursal = ROWID(Banco_sucursal).
  APPLY "CHOOSE" TO btn-salir.
END.

/* ****************(**********  Main Block  *************************** */

ASSIGN
  sel_sucursal = ""
  des_domi = ""
  que_sucursal = ?.

VIEW FRAME frm-sel.
FIND Banco WHERE ROWID(Banco) = que_banco NO-LOCK.
OPEN QUERY qry_sucursales FOR EACH Banco_sucursal OF Banco NO-LOCK
   BY Banco_sucursal.nombre.
RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
ENABLE ALL WITH FRAME frm-sel.
WAIT-FOR CHOOSE OF btn-elegir, btn-salir.
DISABLE ALL WITH FRAME frm-sel.
HIDE FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").
