/*=================================================================================*/
/*                         ANULA UNA BOLETA DE DEPOSITO                            */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_boleta   AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular AS LOGICAL.

DEFINE VARIABLE anulacion_caja AS INTEGER.

{VRSHARED.I}

/*=================================================================================*/
/*                            TRANSACCION DE ANULACION                             */
/*=================================================================================*/

puede_anular = NO.

DO TRANSACTION:

    FIND Boleta_deposito_hd WHERE ROWID(Boleta_deposito_hd) = rid_boleta EXCLUSIVE-LOCK.

    FOR EACH Boleta_deposito_dt OF Boleta_deposito_hd NO-LOCK,
        FIRST Valor OF Boleta_deposito_dt EXCLUSIVE-LOCK:

        /* ------------------------------------------------------- */
        /* Ajustamos el estado del valor al unico estado en que    */
        /* ANULCAJA permite anular un movimiento de Caja que       */
        /* que involucre valores de terceros. Reponemos la fecha   */
        /* de deposito original                                    */
        /* ------------------------------------------------------- */

        
        RUN fecvalor.p ( INPUT-OUTPUT Valor.fecha_deposito, 
                         INPUT Valor.dias_clearing, 
                         OUTPUT Valor.fecha_acredita). 
        OVERLAY(Valor.estado,2,1) = "0".
        
   END.     

        /* ------------------------------------------------------- */
        /*         Anulamos los movimientos bancarios              */
        /* ------------------------------------------------------- */
         
   FOR EACH Cta_cte_bco 
               WHERE  Cta_cte_bco.tip_comprob     = "DP"
                 AND  Cta_cte_bco.prf_comprob     = 0
                 AND  Cta_cte_bco.nro_comprob     = Boleta_deposito_hd.nro_boletadep
                 AND  Cta_cte_bco.cdg_cuenta_ban  = Boleta_deposito_hd.cdg_cuenta_ban
                      EXCLUSIVE-LOCK:
               
        Cta_cte_bco.anulado = YES.
               
   END.

        /* ------------------------------------------------------- */
        /*         Anulamos el movimiento de caja en si            */
        /* ------------------------------------------------------- */

   FIND Caj_header 
         WHERE Caj_header.tip_comprob = "DP" 
           AND Caj_header.prf_comprob = 0
           AND Caj_header.nro_comprob = Boleta_deposito_hd.nro_boletadep
               NO-LOCK.

   act_caj_head = ROWID(caj_header).
   RUN ACUMCAJA.P ( INPUT "B",input rowid(caj_header) ).

   ASSIGN Caj_header.estado = "A"
          Boleta_deposito_hd.anulado = YES
          puede_anular = YES.
    
END. 


