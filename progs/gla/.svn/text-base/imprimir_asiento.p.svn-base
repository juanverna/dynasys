/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_asiento    AS ROWID.
DEFINE INPUT PARAMETER p-reexpresion  AS LOGICAL.
DEFINE INPUT PARAMETER p-que_moneda   LIKE Moneda.nro_moneda.


/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{parlocales.i}

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
     THEN RUN VALUE("PRASI" + STRING(v-valor_n, "999") + ".P") (INPUT act_asiento,  
                                                                INPUT p-reexpresion,
                                                                INPUT p-que_moneda).
     ELSE RUN VALUE("PRASI000.P") (INPUT act_asiento,       
                                   INPUT p-reexpresion,
                                   INPUT p-que_moneda).

