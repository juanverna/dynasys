/*=================================================================================*/
/*                    IMPRESION DE FACTURAS A CLIENTES                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_planprod  AS ROWID.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{parlocales.i}

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

FIND Planprod_hd WHERE ROWID(Planprod_hd) = rid_planprod EXCLUSIVE-LOCK.

RUN getparametro_n.p (  INPUT  "NFPLANPR", OUTPUT v-valor_n ).
que_rutina = "PRPLP" + STRING(v-valor_n, "999") + ".p".

RUN getparametro_n.p (  INPUT  "NCOPPLAP", OUTPUT v-valor_n ).
ncopias = v-valor_n.

RUN getparametro_l.p (  INPUT  "FACTHOJA", OUTPUT v-valor_l ).

DO j = 1 TO ncopias:
   IF v-valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para"
              + " imprimir copia de Factura Nro.:" + STRING(j,"9")
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
   END.

   RUN VALUE(que_rutina) (INPUT ROWID(Planprod_hd)).

END.

Planprod_hd.impreso = "S".
