/*=================================================================================*/
/*                  CALCULA EL SALDO DE UNA CUENTA A UNA FECHA DADA                */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_cuenta           LIKE Cuenta.cdg_cuenta.
DEFINE INPUT  PARAMETER p-cdg_empresa          LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-cdg_moneda           LIKE Moneda.cdg_moneda.
DEFINE INPUT  PARAMETER p-reexpresion          AS LOGICAL.
DEFINE INPUT  PARAMETER p-que_fecha            LIKE Asn_detalle.fecha.
DEFINE OUTPUT PARAMETER p-debitos_cuenta       LIKE Saldos_x_cuenta.tot_debitos.
DEFINE OUTPUT PARAMETER p-creditos_cuenta      LIKE Saldos_x_cuenta.tot_creditos.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

DEFINE VARIABLE v-debitos_ccosto               LIKE Saldos_x_cuenta.tot_debitos.
DEFINE VARIABLE v-creditos_ccosto              LIKE Saldos_x_cuenta.tot_creditos.
DEFINE VARIABLE v-saldos_ccosto                LIKE Saldos_x_cuenta.saldo_total.

DEFINE VARIABLE v-debitos_cuenta               LIKE Saldos_x_cuenta.tot_debitos.
DEFINE VARIABLE v-creditos_cuenta              LIKE Saldos_x_cuenta.tot_creditos.
DEFINE VARIABLE v-saldos_cuenta                LIKE Saldos_x_cuenta.saldo_total.

DEFINE VARIABLE x-comienzo_ejercicio           LIKE Asn_detalle.fecha.

/*=================================================================================*/
/*                             BLOQUE PRINCIPAL                                    */
/*=================================================================================*/

v-debitos_cuenta  = 0.
v-creditos_cuenta = 0.
v-saldos_cuenta   = 0.

FIND Cuenta  WHERE Cuenta.cdg_cuenta = p-cdg_cuenta NO-LOCK. 
FIND Moneda  WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK. 

/*
FOR EACH Entidad WHERE CAN-DO(Entidad.lista_empresas,p-cdg_empresa):

    v-debitos_ccosto  = 0.
    v-creditos_ccosto = 0.
    v-saldos_ccosto   = 0.

    FIND LAST Saldos_x_cuenta OF Cuenta 
        WHERE Saldos_x_cuenta.cdg_empresa = p-cdg_empresa 
          AND Saldos_x_cuenta.nro_entidad = Entidad.nro_entidad
          AND Saldos_x_cuenta.nro_obra    = 0
          AND Saldos_x_cuenta.fch_saldo  <= p-que_fecha
          AND Saldos_x_cuenta.nro_moneda  = Moneda.nro_moneda
          AND Saldos_x_cuenta.reexpresion = p-reexpresion
              NO-LOCK NO-ERROR.

    IF AVAILABLE Saldos_x_cuenta
    THEN DO:
 
        v-debitos_ccosto  = v-debitos_ccosto +  Saldos_x_cuenta.tot_debitos.
        v-creditos_ccosto = v-creditos_ccosto + Saldos_x_cuenta.tot_creditos.
        v-saldos_ccosto   = v-saldos_ccosto + Saldos_x_cuenta.saldo_total.
        
    END.

    FOR EACH Obra WHERE CAN-DO(Obra.lista_empresas,p-cdg_empresa):

        FIND LAST Saldos_x_cuenta OF Cuenta 
            WHERE Saldos_x_cuenta.cdg_empresa = p-cdg_empresa 
              AND Saldos_x_cuenta.nro_entidad = Entidad.nro_entidad
              AND Saldos_x_cuenta.nro_obra    = Obra.nro_obra
              AND Saldos_x_cuenta.fch_saldo  <= p-que_fecha
              AND Saldos_x_cuenta.nro_moneda  = Moneda.nro_moneda
              AND Saldos_x_cuenta.reexpresion = p-reexpresion
                  NO-LOCK NO-ERROR.

        IF AVAILABLE Saldos_x_cuenta
        THEN DO:
   
            v-debitos_ccosto  = v-debitos_ccosto +  Saldos_x_cuenta.tot_debitos.
            v-creditos_ccosto = v-creditos_ccosto + Saldos_x_cuenta.tot_creditos.
            v-saldos_ccosto   = v-saldos_ccosto + Saldos_x_cuenta.saldo_total.
            
        END.
        
    END.       
      
    v-debitos_cuenta = v-debitos_cuenta + v-debitos_ccosto.                
    v-creditos_cuenta = v-creditos_cuenta + v-creditos_ccosto.                

END.
*/

RUN comienzo_ejercicio.p ( INPUT p-que_fecha, OUTPUT x-comienzo_ejercicio ).

FOR EACH Asn_detalle OF Cuenta
  WHERE Asn_detalle.cdg_empresa = p-cdg_empresa
    AND Asn_detalle.fecha <= p-que_fecha
    AND Asn_detalle.fecha >= x-comienzo_ejercicio
    AND Asn_detalle.nro_moneda = Moneda.nro_moneda
    AND Asn_detalle.reexpresion = p-reexpresion:

    v-debitos_cuenta  = v-debitos_cuenta + Asn_detalle.debito.
    v-creditos_cuenta = v-creditos_cuenta + Asn_detalle.credito.

END.

ASSIGN
    p-debitos_cuenta  = v-debitos_cuenta.                
    p-creditos_cuenta = v-creditos_cuenta.                

