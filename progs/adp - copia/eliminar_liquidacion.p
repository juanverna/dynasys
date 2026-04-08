/*=========================================================================================*/
/*                ELIMINA LA LIQUIDACION DE UN EMPLEADO EN PARTICULAR                      */
/*=========================================================================================*/

DEFINE VARIABLE que_empleado    LIKE Empleado.nro_legajo         INITIAL 58.
DEFINE VARIABLE que_liquidacion LIKE Liquidacion.sec_liquidacion INITIAL 2.

FIND Empleado WHERE Empleado.nro_legajo = que_empleado EXCLUSIVE-LOCK.

FOR EACH Rcb_header OF Empleado WHERE Rcb_header.sec_liquidacion = 2 EXCLUSIVE-LOCK:
    FOR EACH Rcb_detalle OF Rcb_header EXCLUSIVE-LOCK:
        DELETE Rcb_detalle.
    END.
    DELETE Rcb_header.
END.
        
FOR EACH Datos_liq OF Empleado WHERE Datos_liq.sec_liquidacion = 2 EXCLUSIVE-LOCK:
    DELETE Datos_liq.
END.            
