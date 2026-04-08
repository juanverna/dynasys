/*=================================================================================*/
/*                                                                                 */
/*                SELECCIONA UN DOMICILIO ASOCIADO A UN PROVEEDOR                  */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT  PARAMETER que_proveedor   AS ROWID.
DEFINE INPUT-OUTPUT PARAMETER que_domicilio AS ROWID.

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

DEFINE VARIABLE sel_domi AS CHARACTER FORMAT "X(26)":U
     VIEW-AS FILL-IN
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE QUERY brw-domi FOR Domicilio_prv SCROLLING.

DEFINE BROWSE brw-domi QUERY brw-domi DISPLAY
       Domicilio_prv.nro_domicilio
       Domicilio_prv.nombre
       Domicilio_prv.direccion
       WITH NO-LABELS NO-UNDERLINE SIZE 40 BY 6
            BGCOLOR h-bg_c FGCOLOR h-fg_c FONT 9
            TITLE BGCOLOR 4 FGCOLOR 14 "Domicilios asociados":L.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frm-sel
     sel_domi AT ROW 1 COL 1 HELP
          "Ingrese el nombre del domicilio" NO-LABEL
     brw-domi   AT ROW 2 COL 1
     btn-elegir AT ROW 8 COL 1
     btn-salir  AT ROW 8 COL 21
     WITH 1 DOWN OVERLAY SIDE-LABELS
          AT COL 10 ROW 5
          BGCOLOR h-bg_c FGCOLOR h-fg_c FONT 9
          TITLE BGCOLOR 7 FGCOLOR 8 "Seleccion de Domicilios":L
          VIEW-AS DIALOG-BOX.

/* ************************  Control Triggers  ************************ */

ON ANY-KEY OF sel_domi IN FRAME FRM-SEL
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

  OPEN QUERY brw-domi
       FOR EACH Domicilio_prv OF Proveedor
           WHERE Domicilio_prv.nombre BEGINS des_domi BY Domicilio_prv.nombre.

  sel_domi:SCREEN-VALUE IN FRAME frm-sel = des_domi.
  IF ldes >= 0 THEN
     sel_domi:CURSOR-OFFSET IN FRAME frm-sel = ldes + 1.

  RETURN NO-APPLY.
END.

ON RETURN OF sel_domi IN FRAME FRM-SEL OR
   MOUSE-SELECT-DBLCLICK OF brw-domi IN FRAME FRM-SEL OR
   RETURN OF brw-domi IN FRAME FRM-SEL
DO:
  APPLY "CHOOSE" TO btn-elegir.
END.

ON CHOOSE OF btn-elegir IN FRAME FRM-SEL
DO:
  que_domicilio = ROWID(Domicilio_prv).
  APPLY "CHOOSE" TO btn-salir.
END.

/* ****************(**********  Main Block  *************************** */

ASSIGN
  sel_domi = ""
  des_domi = ""
  que_domicilio = ?.

VIEW FRAME frm-sel.
FIND Proveedor WHERE ROWID(Proveedor) = que_proveedor NO-LOCK.
OPEN QUERY brw-domi FOR EACH Domicilio_prv OF Proveedor BY Domicilio_prv.nombre.
RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
ENABLE ALL WITH FRAME frm-sel.
WAIT-FOR CHOOSE OF btn-elegir, btn-salir.
DISABLE ALL WITH FRAME frm-sel.
HIDE FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").
