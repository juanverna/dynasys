/*=================================================================================*/
/*                    IMPRESION DE NOTAS DE DEBITO A CLIENTES                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_recibo   AS ROWID.

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

{findempresa.i}
FIND Rec_header WHERE ROWID(Rec_header) = rid_recibo NO-LOCK.
FIND FIRST tipocomprobante 
     WHERE Tipocomprobante.cdg_comprobante = rec_header.cdg_comprobante
     AND   Tipocomprobante.cdg_empresa     = Empresa.cdg_empresa 
     NO-LOCK NO-ERROR.

que_rutina = "".

RUN getparametro.p (  INPUT  Tipocomprobante.prefijo_formulario,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

que_rutina = Tipocomprobante.prefijo_programa + STRING(v-valor_n, "999") + ".P".

RUN getparametro.p (  INPUT  Tipocomprobante.prefijo_ncopias,
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

ncopias = v-valor_n.

RUN getparametro.p (  INPUT  "FACTHOJA",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).
DO j = 1 TO ncopias:
   IF v-valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para"
              + " imprimir copia de Recibo Nro.:" + STRING(j,"9")
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
   END.

   
   RUN VALUE(que_rutina) (INPUT ROWID(Rec_header)). 
  /* RUN prrcx103.p (INPUT ROWID(Rec_header)). */

END.
