/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_ctabco     AS ROWID.
DEFINE INPUT  PARAMETER has_fecha      AS DATE.
DEFINE OUTPUT PARAMETER saldo          AS DECIMAL.
DEFINE OUTPUT PARAMETER ultima_fecha   AS DATE.

{VRSHARED.I} 
{VPERSINM.I}

DEFINE VARIABLE debitos        AS   DECIMAL.
DEFINE VARIABLE creditos       AS   DECIMAL.
DEFINE VARIABLE primer_vivo    AS   LOGICAL.

/*=================================================================================*/
/*                           BLOQUE PRINCIPAL                                      */
/*=================================================================================*/

FIND Cuenta_bancaria WHERE ROWID(Cuenta_bancaria) = rid_ctabco.

RUN CIERRE.

/*=================================================================================*/
/*                           PROCEDIMIENTOS                                        */
/*=================================================================================*/

PROCEDURE CIERRE:

   OPEN QUERY qry_movimientos
       FOR EACH Cta_cte_bco OF Cuenta_bancaria EXCLUSIVE-LOCK
           WHERE Cta_cte_bco.fecha_movimto <= has_fecha
                 BY Cta_cte_bco.fecha_movimto.

   primer_vivo = NO.
   GET FIRST qry_movimientos.
   DO WHILE AVAILABLE Cta_cte_bco AND NOT primer_vivo:

      ultima_fecha = Cta_cte_bco.fecha_movimto.

      IF Cta_cte_bco.contable
      THEN DO:
           IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
              THEN debitos = debitos + Cta_cte_bco.debito.
              ELSE creditos = creditos + Cta_cte_bco.credito.

           DELETE Cta_cte_bco.
           GET NEXT qry_movimientos.
      END.
      ELSE DO:
           primer_vivo = YES.
      END.     

   END.         

   IF primer_vivo 
      THEN ultima_fecha = ultima_fecha - 1.
   
   saldo = debitos - creditos.
   
   CREATE Cta_cte_bco.
   ASSIGN Cta_cte_bco.cdg_cuenta_ban       = Cuenta_bancaria.cdg_cuenta_ban
          Cta_cte_bco.contable             = YES
          Cta_cte_bco.tip_comprob          = "SI"
          Cta_cte_bco.prf_comprob          = 0
          Cta_cte_bco.nro_comprob          = 0
          Cta_cte_bco.fecha_movimto        = ultima_fecha
          Cta_cte_bco.fecha_efectiva       = ultima_fecha
          Cta_cte_bco.leyenda              = "Saldo Inicial"
          Cta_cte_bco.credito              = saldo.
 
END PROCEDURE.   

