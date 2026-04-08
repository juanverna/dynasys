/*=================================================================================*/
/*                    IMPRESION DE FACTURAS A CLIENTES                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura  AS ROWID.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{parlocales.i}

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE VARIABLE x-formulario        AS CHARACTER.
DEFINE VARIABLE x-copias            AS CHARACTER.
DEFINE VARIABLE x-hojasuelta        AS CHARACTER.
DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

/*=================================================================================*/
/*                         INICIALIZACION DE LA EMISION                            */
/*=================================================================================*/

FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = rid_factura EXCLUSIVE-LOCK.
FIND Tipocomprobante OF Fac_header_prv NO-LOCK.
IF Tipocomprobante.usa_letra
   THEN FIND Condicion_impos OF Fac_header_prv NO-LOCK.

x-formulario = Tipocomprobante.prefijo_formulario.
IF Tipocomprobante.usa_letra
   THEN x-formulario = REPLACE(x-formulario,"*",Condicion_impos.tipo_factura). 

RUN getparametro.p (  INPUT  x-formulario,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

que_rutina = Tipocomprobante.prefijo_programa + STRING(v-valor_n, "999") + ".p".
IF Tipocomprobante.usa_letra
   THEN que_rutina = REPLACE(que_rutina,"*",Condicion_impos.tipo_factura).

x-copias = Tipocomprobante.prefijo_ncopias.
IF Tipocomprobante.usa_letra
   THEN x-copias = REPLACE(x-copias,"*",Condicion_impos.tipo_factura). 

RUN getparametro.p (  INPUT  x-copias,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
ncopias = v-valor_n.

x-hojasuelta = Tipocomprobante.prefijo_hojas.
IF Tipocomprobante.usa_letra
   THEN x-hojasuelta = REPLACE(x-hojasuelta,"*",Condicion_impos.tipo_factura). 

RUN getparametro.p (  INPUT  x-hojasuelta,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

DO j = 1 TO ncopias:
   IF v-valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para"
              + " imprimir copia Nro.:" + STRING(j,"9")
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
   END.

   RUN VALUE(que_rutina) (INPUT ROWID(Fac_header_prv)).

END.

Fac_header_prv.impreso = "S".
