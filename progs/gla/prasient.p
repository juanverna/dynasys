/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_asiento  AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I }

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

  RUN getparametro.p (  INPUT  "NFASIENT",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).

  IF v-valor_n <> ?
     THEN RUN VALUE("PRASI" + STRING(v-valor_n, "999") + ".P") (INPUT act_asiento).
     ELSE RUN VALUE("PRASI000.P") (INPUT act_asiento).


