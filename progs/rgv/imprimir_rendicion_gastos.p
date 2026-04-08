/*=================================================================================*/
/*                    IMPRESION DE FACTURAS A CLIENTES                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura  AS ROWID.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

FUNCTION fnComprobante RETURN CHARACTER ( tip AS CHARACTER, prf AS INTEGER, nro AS INTEGER).
  RETURN tip + "-" + STRING(prf,"9999") + "-" + STRING(nro,"99999999").
END FUNCTION.

DEFINE VARIABLE nombre_copia   AS CHARACTER EXTENT 10 
    INITIAL ["Original","Duplicado","Triplicado","Cuadruplicado","Quinutplicado",
             "Sextuplicado","Septuplicado","Octuplicado","Nonuplicado","Decuplicado"].

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

FIND Rendgastos_hd WHERE ROWID(Rendgastos_hd) = rid_factura NO-LOCK.
FIND Tipocomprobante OF Rendgastos_hd NO-LOCK.

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
ncopias = v-valor_n.

x-hojasuelta = Tipocomprobante.prefijo_hojas.

RUN getparametro.p (  INPUT  x-hojasuelta,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

DO j = 1 TO ncopias:
   IF v-valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para imprimir copia" nombre_copia [ j ] 
          "del comprobante:" fnComprobante(Rendgastos_hd.tip_comprob,Rendgastos_hd.prf_comprob,Rendgastos_hd.nro_comprob) 
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
   END.

   RUN VALUE(que_rutina) (INPUT ROWID(Rendgastos_hd)).

END.

/*Rendgastos_hd.impreso = "S".*/
