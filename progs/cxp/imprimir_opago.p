/*==================================================================*/
/*                    IMPRIME UNA ORDEN DE PAGO                     */
/*==================================================================*/

   DEFINE INPUT PARAMETER rid_opago AS ROWID.
   
   {parlocales.i}

/*==================================================================*/
/*                             VARIABLES                            */
/*==================================================================*/
   
   DEFINE VARIABLE j          AS INTEGER.
   DEFINE VARIABLE ncopias    AS INTEGER.
   DEFINE VARIABLE que_rutina AS CHARACTER.

/*==================================================================*/
/*                         BLOQUE PRINCIPAL                         */
/*==================================================================*/

   RUN getparametro.p (  INPUT  "NFORDPAG",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   que_rutina = "PROPG" + STRING(v-valor_n, "999") + ".P".

   RUN getparametro.p (  INPUT  "NCOPIAOP",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   ncopias = v-valor_n.

   RUN getparametro.p (  INPUT  "OPAGHOJA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   DO j = 1 TO ncopias:
      IF v-valor_l
      THEN DO:
         MESSAGE "Por Favor, coloque formulario en la impresora para" 
                 + " imprimir copia de O/Pago Nro.:" + STRING(j,"9")
                 VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
      END.           

      RUN VALUE(que_rutina) (INPUT rid_opago).

   END.
     
