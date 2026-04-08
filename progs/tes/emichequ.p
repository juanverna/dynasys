/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_cheque  AS ROWID.
DEFINE INPUT PARAMETER que_cuenta  LIKE Cuenta.nro_cuenta.

FIND Cheque WHERE ROWID(Cheque) = rid_cheque EXCLUSIVE-LOCK.
FIND Cuenta_bancaria OF Cheque NO-LOCK.
CREATE Cta_cte_bco.
ASSIGN Cta_cte_bco.tip_comprob     = "CH"
       Cta_cte_bco.prf_comprob     = 0
       Cta_cte_bco.nro_comprob     = Cheque.numero_cheque
       Cta_cte_bco.fecha_efectiva  = Cheque.fecha_acredita
       Cta_cte_bco.fecha_movimto   = Cheque.fecha_emision
       Cta_cte_bco.credito         = 0
       Cta_cte_bco.debito          = Cheque.importe
       Cta_cte_bco.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
       Cta_cte_bco.nro_cuenta      = que_cuenta
       Cta_cte_bco.nro_cheque      = Cheque.nro_cheque.

