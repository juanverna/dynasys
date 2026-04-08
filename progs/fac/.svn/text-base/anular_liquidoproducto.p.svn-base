/*======================================================================================*/
/*                     ELIMINA UN COMPROBANTE DE LIQUIDO PRODUCTO                       */
/*======================================================================================*/

DEFINE VARIABLE v-tip_comprob LIKE Fac_header_prv.tip_comprob.
DEFINE VARIABLE v-prf_comprob LIKE Fac_header_prv.prf_comprob.
DEFINE VARIABLE v-nro_comprob LIKE Fac_header_prv.nro_comprob.

UPDATE v-tip_comprob v-prf_comprob v-nro_comprob.

FOR EACH Fac_header_prv 
    WHERE Fac_header_prv.tip_comprob = v-tip_comprob
      AND Fac_header_prv.prf_comprob = v-prf_comprob
      AND Fac_header_prv.nro_comprob = v-nro_comprob:

    DISPLAY tip_comprob prf_comprob nro_comprob.
    FOR EACH Fac_detalle_prv OF Fac_header_prv:
        FOR EACH Detalle_liquido OF Fac_detalle_prv:

            FIND Fac_detalle WHERE Fac_detalle.nro_factura = Detalle_liquido.nro_factura
                               AND Fac_detalle.nro_linea   = Detalle_liquido.nro_lineafac
                EXCLUSIVE-LOCK.
            
            Fac_detalle.liquido_sino = NO.
            
            DELETE Detalle_liquido.

        END.

        DELETE Fac_detalle_prv.
        
    END.

    DELETE Fac_header_prv.

END.
