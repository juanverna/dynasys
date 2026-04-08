/* --------------------------------------------------------------------------- */
/* CONSULTA DE FACTURAS POR RANGO DE FECHAS Y POR UN CLIENTE ESPECIFICO O NO   */
/* PARAMETRO DE SALIDA, APUNTA A LA FACTURA SELECCIONADA                       */
/* --------------------------------------------------------------------------- */

DEFINE INPUT-OUTPUT PARAMETER par_Amd_head as ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE BUTTON btn_elegir
     LABEL "&Elegir":L
     SIZE 3 BY 1 FONT 4.

DEFINE BUTTON btn_salir
     LABEL "&Cancelar":L
     SIZE 3 BY 1 FONT 4.

DEFINE QUERY qry-fact FOR Amd_Header SCROLLING.

DEFINE BROWSE brw-fact QUERY qry-fact DISPLAY
      Amd_header.tip_comprob
      Amd_header.nro_comprob
      Amd_header.modo_importes COLUMN-LABEL "Imp"
      Amd_header.leyenda
      WITH NO-UNDERLINE 7 DOWN
         BGCOLOR b-bg_c FGCOLOR b-fg_c FONT 4 SEPARATORS
         TITLE BGCOLOR 4 FGCOLOR 14 "Asientos modelo por codigo":L.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frm-sel
     SKIP(0.2)
     brw-fact
     SKIP
     btn_elegir AT 1
     btn_salir  AT 39
     WITH 1 DOWN OVERLAY SIDE-LABELS
         AT COL 10 ROW 5
         BGCOLOR f-bg_c FGCOLOR f-fg_c FONT 9 THREE-D
         TITLE BGCOLOR 7 FGCOLOR 8 "Seleccion de Asientos Modelo":L
         VIEW-AS DIALOG-BOX.

/* ************************  Control Triggers  ************************ */

ON MOUSE-SELECT-DBLCLICK OF brw-fact IN FRAME FRM-SEL OR
   RETURN OF brw-fact IN FRAME FRM-SEL
DO:
  APPLY "CHOOSE" TO btn_elegir.
END.

ON CHOOSE OF btn_elegir IN FRAME FRM-SEL
DO:
  par_Amd_head = ROWID(Amd_Header).
  APPLY "CHOOSE" TO btn_salir.
END.

/* **************************  Main Block  *************************** */

btn_elegir:WIDTH = FRAME frm-sel:WIDTH / 2 - 1.0.
btn_salir:WIDTH = btn_elegir:WIDTH.
btn_salir:COLUMN = btn_elegir:COLUMN + btn_elegir:WIDTH.

ASSIGN
  par_Amd_head = ?.

VIEW FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
ENABLE ALL WITH FRAME frm-sel.
RUN Act_Browse.
WAIT-FOR CHOOSE OF btn_elegir, btn_salir.
HIDE FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").

PROCEDURE Act_Browse:

   OPEN QUERY qry-fact FOR EACH Amd_Header BY Amd_header.tip_comprob BY Amd_header.nro_comprob.

END PROCEDURE.
