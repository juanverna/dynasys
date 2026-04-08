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

FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = rid_factura EXCLUSIVE-LOCK.

FIND Tipocomprobante OF Valeinv_hd NO-LOCK.
     
RUN getparametro_n.p (  INPUT  Tipocomprobante.prefijo_formulario, OUTPUT v-valor_n).
que_rutina = Tipocomprobante.prefijo_programa + STRING(v-valor_n, "999") + ".p".

RUN getparametro_n.p (  INPUT  Tipocomprobante.prefijo_ncopias, OUTPUT ncopias ).
RUN getparametro_l.p (  INPUT  Tipocomprobante.prefijo_hojas, OUTPUT v-valor_l ).

DO j = 1 TO ncopias:
   IF v-valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para imprimir copia" nombre_copia [ j ] 
          "del comprobante:" fnComprobante(Valeinv_hd.tip_comprob,Valeinv_hd.prf_comprob,Valeinv_hd.nro_comprob) 
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
   END.

   RUN VALUE(que_rutina) (INPUT ROWID(Valeinv_hd)).

END.

