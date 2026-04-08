/*=================================================================================*/
/*          EDITA O MUESTRA LAS OBSERVACIONES DE CUALQUIER DOCUMENTO               */
/*=================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER texto       AS CHARACTER.
DEFINE INPUT        PARAMETER titulo_obs  AS CHARACTER.
DEFINE INPUT        PARAMETER modo        AS INTEGER.
DEFINE INPUT        PARAMETER estado      AS CHARACTER.
DEFINE INPUT        PARAMETER fil_observ  AS CHARACTER.
DEFINE INPUT        PARAMETER col_observ  AS CHARACTER.

DEFINE VARIABLE MD_ALTA          AS INTEGER INITIAL 0.
DEFINE VARIABLE MD_MULTIPLE      AS INTEGER INITIAL 1.
DEFINE VARIABLE MD_DEFINIDA      AS INTEGER INITIAL 2.
DEFINE VARIABLE MD_RELACION      AS INTEGER INITIAL 3.
DEFINE VARIABLE MD_READONLY      AS INTEGER INITIAL 4.
DEFINE VARIABLE MD_CAMBIO        AS INTEGER INITIAL 5.
DEFINE VARIABLE MD_GENERADO      AS INTEGER INITIAL 6.

{VRSHARED.I}
{VPERCONM.I}

DEFINE BUTTON btn_grabar
     LABEL "&Grabar":L
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_cancel
     LABEL "Ca&ncelar":L
     SIZE 10 BY 0.9 FONT 4.

FORM
   texto NO-LABEL FGCOLOR h-fg_c BGCOLOR h-bg_c
                 VIEW-AS EDITOR SIZE 70 BY 4
   btn_grabar AT 1
   btn_cancel
   WITH FRAME frm-texto TITLE titulo_obs
   VIEW-AS DIALOG-BOX FGCOLOR f-fg_c BGCOLOR f-bg_c CENTERED FONT 9.

ON ESC OF FRAME frm-texto
DO:
   APPLY "CHOOSE" TO btn_cancel IN FRAME frm-texto.
   RETURN NO-APPLY.
END.

ON CHOOSE OF btn_grabar IN FRAME frm-texto
DO:
   ASSIGN FRAME frm-texto texto.
   APPLY "U1" TO FRAME frm-texto.
END.

ON CHOOSE OF btn_cancel IN FRAME frm-texto
DO:
   APPLY "U1" TO FRAME frm-texto.
END.

/*=================================================================================*/
/*                                  BLOQUE PRINCIPAL                               */
/*=================================================================================*/

RUN ARREGLAR_FRAME.

DISPLAY texto WITH FRAME frm-texto.
ENABLE texto /*WHEN modo = MD_CAMBIO OR estado = ""*/
          btn_grabar WHEN modo = MD_CAMBIO OR estado = ""
          btn_cancel
          WITH FRAME frm-texto.
WAIT-FOR U1 OF FRAME frm-texto.
HIDE FRAME frm-texto.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/

PROCEDURE ARREGLAR_FRAME:

   RUN getparametro.p (  INPUT  fil_observ,
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   IF v-valor_n = ? THEN v-valor_n = 7.
   FRAME frm-texto:HEIGHT = v-valor_n + 2.2.
   texto:HEIGHT = v-valor_n.

   RUN getparametro.p (  INPUT  col_observ,
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   IF v-valor_n = ? THEN v-valor_n = 60.
   FRAME frm-texto:WIDTH = v-valor_n + 1.5.
   texto:WIDTH  = v-valor_n.
   
   btn_cancel:COLUMN IN FRAME frm-texto =
                        FRAME frm-texto:WIDTH  - btn_cancel:WIDTH - 0.5.
   btn_cancel:ROW    IN FRAME frm-texto =
                        FRAME frm-texto:HEIGHT - btn_cancel:HEIGHT - 0.2.
   btn_grabar:ROW    IN FRAME frm-texto =
                        FRAME frm-texto:HEIGHT - btn_cancel:HEIGHT - 0.2.
                        
END PROCEDURE.                        
