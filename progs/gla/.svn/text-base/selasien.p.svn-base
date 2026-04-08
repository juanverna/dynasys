/*=============================================================================*/
/*                 CONSULTA DE ASIENTOS POR RANGO DE FECHAS                    */
/*=============================================================================*/

DEFINE INPUT-OUTPUT PARAMETER par_Asn_head as ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE BUTTON btn-elegir
     LABEL "Elegir":L
     SIZE 39 BY 1.

DEFINE BUTTON btn-salir
     LABEL "Cancelar":L
     SIZE 39 BY 1.

DEFINE VARIABLE dde_fecha AS DATE LABEL "Desde Fecha" FGCOLOR fg_c.
DEFINE VARIABLE hta_fecha AS DATE LABEL "Hasta Fecha" INITIAL TODAY FGCOLOR fg_c.
DEFINE VARIABLE cli_ant AS ROWID.

DEFINE QUERY qry-fact FOR Asn_Header SCROLLING.

DEFINE BROWSE brw-fact QUERY qry-fact DISPLAY
      Asn_header.fecha
      Asn_header.tip_comprob
      Asn_header.nro_comprob
      Asn_header.leyenda
      WITH NO-UNDERLINE 7 DOWN
         BGCOLOR b-bg_c FGCOLOR b-fg_c FONT 4 SEPARATORS
         TITLE BGCOLOR 4 FGCOLOR 14 "Asientos por fecha":L.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frm-sel
     SKIP(0.2)
     SPACE(1)
     dde_fecha FGCOLOR fe_c BGCOLOR be_c
     hta_fecha AT 40 FGCOLOR fe_c BGCOLOR be_c
     SKIP(0.2)
     brw-fact
     SKIP
     btn-elegir AT 1
     btn-salir  AT 40
     WITH 1 DOWN OVERLAY SIDE-LABELS
         AT COL 10 ROW 5
         BGCOLOR f-bg_c FGCOLOR f-fg_c FONT 4 THREE-D
         TITLE BGCOLOR 7 FGCOLOR 8 "Seleccion de Asientos":L
         VIEW-AS DIALOG-BOX WIDTH 96.

/* ************************  Control Triggers  ************************ */

ON MOUSE-SELECT-DBLCLICK OF brw-fact IN FRAME FRM-SEL OR
   RETURN OF brw-fact IN FRAME FRM-SEL
DO:
  APPLY "CHOOSE" TO btn-elegir.
END.

ON CHOOSE OF btn-elegir IN FRAME FRM-SEL
DO:
  par_Asn_head = ROWID(Asn_Header).
  APPLY "CHOOSE" TO btn-salir.
END.

ON LEAVE OF dde_fecha
DO:
   IF DATE(dde_fecha:SCREEN-VALUE) = dde_fecha THEN RETURN.
   ASSIGN dde_fecha.
   RUN Act_Browse.
END.

ON LEAVE OF hta_fecha
DO:
   IF DATE(hta_fecha:SCREEN-VALUE) = hta_fecha THEN RETURN.
   ASSIGN hta_fecha.
   RUN Act_Browse.
END.

/* **************************  Main Block  *************************** */

ASSIGN
  par_Asn_head = ?.
  dde_fecha = today - ( day(today) - 1).

VIEW FRAME frm-sel.
DISPLAY dde_fecha hta_fecha WITH FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
ENABLE ALL WITH FRAME frm-sel.
RUN Act_Browse.
WAIT-FOR CHOOSE OF btn-elegir, btn-salir.
HIDE FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").

PROCEDURE Act_Browse:
   ASSIGN FRAME frm-sel
          dde_fecha
          hta_fecha.

   OPEN QUERY qry-fact FOR EACH Asn_Header
                           WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
                             AND Asn_Header.fecha >= dde_fecha 
                             AND Asn_Header.fecha <= hta_fecha.

END PROCEDURE.
