/*=====================================================================================================*/
/*                           ARREGLA UN REGISTRO DE CUENTA CORRIENTE                                   */
/*=====================================================================================================*/

DEFINE VARIABLE v-cdg_proveedor LIKE Proveedor.cdg_proveedor.
DEFINE VARIABLE v-tip_comprob   LIKE Cta_cte_prv.tip_comprob.
DEFINE VARIABLE v-prf_comprob   LIKE Cta_cte_prv.prf_comprob.
DEFINE VARIABLE v-nro_comprob   LIKE Cta_cte_prv.nro_comprob.

REPEAT:
   SET v-cdg_proveedor LABEL "Proveedor"
       v-tip_comprob   LABEL "Comprobante"
       v-prf_comprob   LABEL "Prefijo"
       v-nro_comprob   LABEL "Número"
       WITH SIDE-LABELS.
       
   FIND Proveedor WHERE Proveedor.cdg_proveedor = v-cdg_proveedor NO-LOCK.
   FOR EACH Cta_cte_prv OF Proveedor
       WHERE Cta_cte_prv.tip_comprob = v-tip_comprob
         AND Cta_cte_prv.prf_comprob = v-prf_comprob
         AND Cta_cte_prv.nro_comprob = v-nro_comprob:
         
         UPDATE Cta_cte_prv.debito Cta_cte_prv.credito.

   END.
   
END.            
