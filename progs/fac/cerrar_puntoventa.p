/*================================================================================================================*/
/*                                   PROCESO DE CIERRE DE PUNTOS DE VENTA                                         */
/*================================================================================================================*/

DEFINE INPUT PARAMETER rid_ptovta     AS ROWID.
DEFINE INPUT PARAMETER v-fecha_cierre AS DATE.

DO TRANSACTION:

    FIND Punto-venta WHERE ROWID(Punto-venta) = rid_ptovta EXCLUSIVE-LOCK.
    
      /* Desmarca todos los puntos para todos los comprobantes y marca aquellos del punto indicado */
    
    FOR EACH Tipo_puntovta EXCLUSIVE-LOCK:
        Tipo_puntovta.preferido = Tipo_puntovta.cdg_puntovta = Punto-venta.cdg_puntovta.
    END.
    
      /* Vuelve a poner como preferidos aquellos que tienen un solo centro emisor asignado */
    
    FOR EACH Tipocomprobante:
        FIND Tipo_puntovta OF Tipocomprobante EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Tipo_puntovta THEN Tipo_puntovta.preferido = YES.
    END.
    
      /* Para todos los puntos de venta que toman la fecha de la tabla, actualizamos el ultimo cierre */
    
    FOR EACH Punto-venta WHERE Punto-venta.modo_fecha = "T" EXCLUSIVE-LOCK:
        Punto-venta.fch_cierre = v-fecha_cierre.
    END.

END.
