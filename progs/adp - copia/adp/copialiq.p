/*=================================================================================*/
/*                                                                                 */
/*          GENERA UNA NUEVA LIQUIDACION MEDIANTE LA COPIA UNA EXISTENTE           */
/*                                                                                 */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE BUFFER B-Liquidacion FOR Liquidacion.
DEFINE BUFFER B-Rango_liquidacion FOR Rango_liquidacion.

DEFINE VARIABLE mensaje AS CHARACTER FORMAT "X(40)".

FORM 
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE "Aguarde un momento por favor" FONT 8
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 1.

PAUSE 0.
mensaje = "Procediendo a copiar Liquidaci¢n...".
DISPLAY mensaje WITH FRAME frm-espere.

RUN DUPLICAR_LIQUIDACION.

/*=================================================================================*/
/*                            P R O C E D I M I E N T O S                          */
/*=================================================================================*/

PROCEDURE DUPLICAR_LIQUIDACION:

     FIND B-Liquidacion WHERE ROWID(B-Liquidacion) = ult_liquidacion NO-LOCK.
     FIND   Liquidacion WHERE ROWID(Liquidacion)   = act_liquidacion EXCLUSIVE-LOCK.

     ASSIGN 
            Liquidacion.ano             = B-Liquidacion.ano
            Liquidacion.descripcion     = B-Liquidacion.descripcion
            Liquidacion.desde_legajo    = B-Liquidacion.desde_legajo
            Liquidacion.fecha           = B-Liquidacion.fecha
            Liquidacion.fecha_liq       = B-Liquidacion.fecha_liq
            Liquidacion.hasta_legajo    = B-Liquidacion.hasta_legajo
            Liquidacion.n_periodo       = B-Liquidacion.n_periodo
            Liquidacion.observacion     = B-Liquidacion.observacion
            Liquidacion.reset_datos     = B-Liquidacion.reset_datos.


     FOR EACH B-Rango_liquidacion OF B-Liquidacion NO-LOCK:
     
         CREATE Rango_liquidacion.
         ASSIGN Rango_liquidacion.cdg_liquid      = B-Rango_liquidacion.cdg_liquid
                Rango_liquidacion.desde_legajo    = B-Rango_liquidacion.desde_legajo
                Rango_liquidacion.hasta_legajo    = B-Rango_liquidacion.hasta_legajo
                Rango_liquidacion.sec_liquidacion = B-Rango_liquidacion.sec_liquidacion.

     END.

     HIDE FRAME frm-espere NO-PAUSE.

END PROCEDURE.