DEFINE INPUT PARAMETER tipo_a       LIKE Rem_header.tip_comprob.
DEFINE INPUT PARAMETER prefijo_a    LIKE Rem_header.prf_comprob.
DEFINE INPUT PARAMETER numero_a     LIKE Rem_header.nro_comprob.
DEFINE INPUT PARAMETER tipo         LIKE Rem_header.tip_comprob.
DEFINE INPUT PARAMETER prefijo      LIKE Rem_header.prf_comprob.
DEFINE INPUT PARAMETER numero       LIKE Rem_header.nro_comprob.

DO TRANSACTION:

    FIND Rem_header WHERE Rem_header.tip_comprob = tipo_a
                      AND Rem_header.prf_comprob = prefijo_a
                      AND Rem_header.nro_comprob = numero_a  EXCLUSIVE-LOCK.
    ASSIGN Rem_header.tip_comprob = tipo
           Rem_header.prf_comprob = prefijo
           Rem_header.nro_comprob = numero.
    
    FIND Sub_header_inv WHERE Sub_header_inv.tip_comprob = tipo_a
                          AND Sub_header_inv.prf_comprob = prefijo_a
                          AND Sub_header_inv.nro_comprob = numero_a  
                          AND Sub_header_inv.nro_proveedor = 0 EXCLUSIVE-LOCK.
    
    FOR EACH Sub_detalle_inv WHERE Sub_detalle_inv.tip_comprob   = tipo_a
                               AND Sub_detalle_inv.prf_comprob   = prefijo_a
                               AND Sub_detalle_inv.nro_comprob   = numero_a  
                               AND Sub_detalle_inv.nro_proveedor = 0 EXCLUSIVE-LOCK:
        ASSIGN Sub_detalle_inv.tip_comprob = tipo
               Sub_detalle_inv.prf_comprob = prefijo
               Sub_detalle_inv.nro_comprob = numero.
    END.
    
    ASSIGN Sub_header_inv.tip_comprob = tipo
           Sub_header_inv.prf_comprob = prefijo
           Sub_header_inv.nro_comprob = numero.
            
    FOR EACH Cct_stock WHERE Cct_stock.tip_comprob = tipo_a
                      AND Cct_stock.prf_comprob = prefijo_a
                      AND Cct_stock.nro_comprob = numero_a  
                      AND Cct_stock.nro_proveedor = 0 EXCLUSIVE-LOCK:
        ASSIGN Cct_stock.tip_comprob = tipo
               Cct_stock.prf_comprob = prefijo
               Cct_stock.nro_comprob = numero.
    END.
    
    MESSAGE "La modificación ha sido exitosa" VIEW-AS ALERT-BOX.
    
END.
