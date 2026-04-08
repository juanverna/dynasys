/*==========================================================================================*/
/*                                RENUMERA NOTAS DE CREDITO                                 */
/*==========================================================================================*/

DEFINE VARIABLE v-cdg_empresa LIKE Fac_header.cdg_empresa LABEL "Empresa".
DEFINE VARIABLE v-tip_comprob LIKE Fac_header.tip_comprob LABEL "Tipo".
DEFINE VARIABLE v-prf_comprob LIKE Fac_header.prf_comprob LABEL "Punto".
DEFINE VARIABLE v-nro_comprob LIKE Fac_header.nro_comprob LABEL "Numero".
DEFINE VARIABLE v-nue_comprob LIKE Fac_header.nro_comprob LABEL "Nuevo".

REPEAT TRANSACTION:

   SET  v-cdg_empresa 
        v-tip_comprob 
        v-prf_comprob 
        v-nro_comprob 
        v-nue_comprob 
        WITH SIDE-LABELS 1 COLUMNS VIEW-AS DIALOG-BOX THREE-D 1 DOWN.
   
   FIND   Fac_header 
          WHERE Fac_header.cdg_empresa = v-cdg_empresa
            AND Fac_header.tip_comprob = v-tip_comprob
            AND Fac_header.prf_comprob = v-prf_comprob
            AND Fac_header.nro_comprob = v-nro_comprob
                EXCLUSIVE-LOCK.

   FIND   Sub_header_vta 
          WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
            AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
            AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
            AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob
                EXCLUSIVE-LOCK.


    FOR EACH Sub_detalle_vta 
             WHERE Sub_detalle_vta.cdg_empresa    = Sub_header_vta.cdg_empresa
               AND Sub_detalle_vta.tip_comprob    = Sub_header_vta.tip_comprob
               AND Sub_detalle_vta.prf_comprob    = Sub_header_vta.prf_comprob
               AND Sub_detalle_vta.nro_comprob    = Sub_header_vta.nro_comprob
                   EXCLUSIVE-LOCK.
          
        Sub_detalle_vta.nro_comprob    = v-nue_comprob.
            

    END.

    Sub_header_vta.nro_comprob    = v-nue_comprob.

    FOR EACH Cta_cte 
             WHERE Cta_cte.cdg_empresa    = Fac_header.cdg_empresa
               AND Cta_cte.tip_comprob    = Fac_header.tip_comprob
               AND Cta_cte.prf_comprob    = Fac_header.prf_comprob
               AND Cta_cte.nro_comprob    = Fac_header.nro_comprob
                   EXCLUSIVE-LOCK.
          
        Cta_cte.nro_comprob    = v-nue_comprob.
            

    END.

    Fac_header.nro_comprob    = v-nue_comprob.

END.
