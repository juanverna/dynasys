/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_imputacion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Imputacioncontable WHERE ROWID(Imputacion) = rid_imputacion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

    hay_error = YES.
                                                                                      
    OPEN QUERY q-Sub_detalle_vta    
        FOR EACH Sub_detalle_vta    NO-LOCK
            WHERE Sub_detalle_vta.lista_imputaciones CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Sub_detalle_vta.
    
    OPEN QUERY q-Fac_detalle        
        FOR EACH Fac_detalle        NO-LOCK
            WHERE Fac_detalle.lista_imputaciones     CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Fac_detalle.
    
    OPEN QUERY q-Fac_detalle_prv    
        FOR EACH Fac_detalle_prv    NO-LOCK
            WHERE Fac_detalle_prv.lista_imputaciones CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Fac_detalle_prv.
    
    OPEN QUERY q-Sub_detalle_prv    
        FOR EACH Sub_detalle_prv    NO-LOCK
            WHERE Sub_detalle_prv.lista_imputaciones CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Sub_detalle_prv.
    
    OPEN QUERY q-Asn_detalle        
        FOR EACH Asn_detalle        NO-LOCK
            WHERE Asn_detalle.lista_imputaciones     CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Asn_detalle.
    
    OPEN QUERY q-Aps_detalle        
        FOR EACH Aps_detalle        NO-LOCK
            WHERE Aps_detalle.lista_imputaciones     CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Aps_detalle.
    
    OPEN QUERY q-Ped_detalle        
        FOR EACH Ped_detalle        NO-LOCK
            WHERE Ped_detalle.lista_imputaciones     CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Ped_detalle.
    
    OPEN QUERY q-Rem_detalle        
        FOR EACH Rem_detalle        NO-LOCK
            WHERE Rem_detalle.lista_imputaciones     CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Rem_detalle.
    
    OPEN QUERY q-Rem_detalle_prv    
        FOR EACH Rem_detalle_prv    NO-LOCK
            WHERE Rem_detalle_prv.lista_imputaciones CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Rem_detalle_prv.
    
    OPEN QUERY q-Ocm_detalle        
        FOR EACH Ocm_detalle        NO-LOCK
            WHERE Ocm_detalle.lista_imputaciones     CONTAINS Imputacioncontable.cdg_imputacontable.
    GET FIRST q-Ocm_detalle.

    IF AVAILABLE Sub_detalle_vta   OR 
       AVAILABLE Fac_detalle       OR
       AVAILABLE Fac_detalle_prv   OR
       AVAILABLE Sub_detalle_prv   OR
       AVAILABLE Asn_detalle       OR
       AVAILABLE Aps_detalle       OR
       AVAILABLE Ped_detalle       OR
       AVAILABLE Rem_detalle       OR
       AVAILABLE Rem_detalle_prv   OR
       AVAILABLE Ocm_detalle      
       THEN RETURN.

    hay_error = NO.

END PROCEDURE.
