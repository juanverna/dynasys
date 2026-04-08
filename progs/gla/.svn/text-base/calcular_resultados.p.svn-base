/*=================================================================================*/
/*      RECORRE LAS CUENTAS DE RESULTADO CALCULANDO EL RESULTADO DEL EJERCICIO     */
/*=================================================================================*/

DEFINE INPUT PARAMETER        p-cdg_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER        p-cdg_nombalance   AS CHARACTER.
DEFINE INPUT PARAMETER        p-nro_moneda       AS INTEGER.
DEFINE INPUT PARAMETER        p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER        p-has_fecha        AS DATE.
DEFINE INPUT-OUTPUT PARAMETER p-acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos".

/*=================================================================================*/
/*                                V A R I A B L E S                                */
/*=================================================================================*/

DEFINE VARIABLE l-saldo_per        LIKE Asn_detalle.debito LABEL "Saldo" INITIAL 0.
DEFINE VARIABLE l-acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" INITIAL 0.
DEFINE VARIABLE l-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" INITIAL 0.
DEFINE VARIABLE l-saldo_tot        LIKE Asn_detalle.debito LABEL "Saldo" INITIAL 0.
DEFINE VARIABLE l-acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" INITIAL 0.
DEFINE VARIABLE l-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" INITIAL 0.

DEFINE VARIABLE v-esp              AS CHARACTER.
DEFINE SHARED VARIABLE c-linea     AS INTEGER.
DEFINE VARIABLE linea_total        AS INTEGER.


{VPERSINM.I}

/*{SHTSUMYS.I}*/

DEFINE QUERY qry_cuentas        FOR Cuenta.

{SHVSUMYS.I}

DEFINE VARIABLE que_subclase AS CHARACTER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN ABRE_QUERY_CUENTAS.
GET FIRST qry_cuentas.
DO WHILE AVAILABLE Cuenta:

    RUN CALCULAR_SALDO. 
    
    ASSIGN
       p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
       p-acm_creditos_per = p-acm_creditos_per  + l-acm_creditos_per
       p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
       p-acm_creditos_tot = p-acm_creditos_tot  + l-acm_creditos_tot.
    
    GET NEXT qry_cuentas.
END.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE ABRE_QUERY_CUENTAS:

        OPEN QUERY qry_cuentas 
             FOR EACH Cuenta 
                 WHERE Cuenta.grupo_pat = "+"
                    OR Cuenta.grupo_pat = "-". 
                              
END PROCEDURE.

PROCEDURE CALCULAR_SALDO:

    l-acm_debitos_per  = 0. 
    l-acm_creditos_per = 0.
    l-acm_debitos_tot  = 0.
    l-acm_creditos_tot = 0.
    
    FOR EACH Asn_detalle OF Cuenta 
        WHERE Asn_detalle.fecha_mayor <= p-has_fecha 
          AND Asn_detalle.cdg_empresa = p-cdg_empresa
          AND Asn_detalle.nro_moneda  = p-nro_moneda
          AND Asn_detalle.reexpresion
           BY Asn_detalle.fecha_mayor:

        IF Asn_detalle.fecha_mayor >= p-des_fecha 
        THEN DO:
            ASSIGN l-acm_debitos_per  = l-acm_debitos_per  + Asn_detalle.debito
                   l-acm_creditos_per = l-acm_creditos_per + Asn_detalle.credito.
        END.
 
        l-acm_debitos_tot  = l-acm_debitos_tot  + Asn_detalle.debito.
        l-acm_creditos_tot = l-acm_creditos_tot + Asn_detalle.credito.
    
    END.
    
    l-saldo_per = l-acm_debitos_per  - l-acm_creditos_per.
    l-saldo_tot = l-acm_debitos_tot  - l-acm_creditos_tot.

END PROCEDURE.

