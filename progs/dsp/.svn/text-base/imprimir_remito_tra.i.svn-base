/*=================================================================================*/
/*                    IMPRESION DE FACTURAS A CLIENTES                             */
/*=================================================================================*/


/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

 {parlocales.i}  

DEFINE VARIABLE que_rutina1          AS CHARACTER.
DEFINE VARIABLE x-formulario        AS CHARACTER.
DEFINE VARIABLE x-copias            AS CHARACTER.
DEFINE VARIABLE x-hojasuelta        AS CHARACTER.
DEFINE VARIABLE ncopias1             AS INTEGER.
DEFINE VARIABLE j1                   AS INTEGER.
DEFINE VARIABLE a                   AS CHARACTER.  
/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/
 

FIND {1} WHERE ROWID({1}) = rid_remito EXCLUSIVE-LOCK.
 


FIND Tipocomprobante OF {1} NO-LOCK NO-ERROR.


x-formulario = Tipocomprobante.prefijo_formulario.


RUN getparametro.p (  INPUT  x-formulario,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

que_rutina = Tipocomprobante.prefijo_programa + STRING(v-valor_n, "999") + ".p".



x-copias = Tipocomprobante.prefijo_ncopias.


RUN getparametro.p (  INPUT  x-copias,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
ncopias1 = v-valor_n.

x-hojasuelta = Tipocomprobante.prefijo_hojas.


RUN getparametro.p (  INPUT  x-hojasuelta,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

DO j1 = 1 TO ncopias1:
   IF v-valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para"
              + " imprimir copia de Remito Nro.:" + STRING(j1,"9")
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
   END.


   RUN value(que_rutina) ( input rowid({1})).

   {1}.impreso = "S".
END.
