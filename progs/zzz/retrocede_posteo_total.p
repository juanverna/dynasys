/*=========================================================================================================*/        
/*                        RETROCEDE UN POSTEO DE UN DETERMINADO PERIODO                                    */
/*=========================================================================================================*/        

DEFINE VARIABLE v-des_fecha   AS DATE.
DEFINE VARIABLE v-has_fecha   AS DATE.
DEFINE VARIABLE v-cdg_empresa LIKE Empresa.cdg_empresa.

UPDATE v-cdg_empresa v-des_fecha v-has_fecha.

/* VENTAS */        

FOR EACH Sub_header_vta 
    WHERE Sub_header_vta.cdg_empresa = v-cdg_empresa
      AND Sub_header_vta.fecha <= v-has_fecha
      AND Sub_header_vta.fecha >= v-des_fecha:

    Sub_header_vta.contable = NO.

END.

/* COMPRAS */        

FOR EACH Sub_header_prv 
    WHERE Sub_header_prv.cdg_empresa = v-cdg_empresa
      AND Sub_header_prv.fecha <= v-has_fecha
      AND Sub_header_prv.fecha >= v-des_fecha:

    Sub_header_prv.contable = NO.

END.
        
/* TESORERIA */        

FOR EACH Caj_header 
    WHERE Caj_header.cdg_empresa = v-cdg_empresa
      AND Caj_header.fecha <= v-has_fecha
      AND Caj_header.fecha >= v-des_fecha:

    Caj_header.contable = NO.

END.

FOR EACH Asn_header 
    WHERE Asn_header.cdg_empresa = v-cdg_empresa
      AND Asn_header.fecha <= v-has_fecha
      AND Asn_header.fecha >= v-des_fecha
      AND Asn_header.origen = "A":

    FOR EACH asn_detalle OF asn_header:
        DELETE asn_detalle.
    END.
    
    FOR EACH asn_totales OF asn_header:
        DELETE asn_totales.
    END.
    
    DELETE asn_header.

END.

