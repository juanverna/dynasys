/*=================================================================================*/
/*                  MUESTRA LOS TOTALIZADORES POR LIQUIDACION                      */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE QUERY qry_totales FOR Total-liquidacion, Totalizador.
DEFINE BROWSE brw_totales QUERY qry_totales
     DISPLAY 
       Totalizador.cdg_totalizador
       Totalizador.dsc_totalizador
       Total-liquidacion.valor
       WITH  12 DOWN THREE-D NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c
            SEPARATORS. /* TITLE "Totalizadores de la Liquidacion". */
            
DEFINE BUTTON btn_salir
     LABEL "&Salir":L 
     SIZE 48 BY 0.9 FONT 6.

FORM
   SKIP(0.2)
   brw_totales
   SKIP(0.2)
   btn_salir
   WITH FGCOLOR f-fg_c BGCOLOR f-bg_c THREE-D SIDE-LABELS FONT 8
       FRAME frm-totales VIEW-AS DIALOG-BOX TITLE "Totales de la Liquidacion".


FIND Liquidacion WHERE ROWID(Liquidacion) = act_liquidacion NO-LOCK.
OPEN QUERY qry_totales 
     FOR EACH Total-liquidacion OF Liquidacion, FIRST Totalizador OF Total-liquidacion.
ENABLE ALL WITH FRAME frm-totales.
WAIT-FOR CHOOSE OF btn_salir.     