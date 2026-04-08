/*=================================================================================*/
/*     CALCULA TODAS LAS RETENCIONES DE IMPUESTOS QUE DEBEN HACERSE EN UN PAGO     */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_orden AS ROWID. /* Apunta a la orden de pago */

{VRSHARED.I}
{VPERSINM.I}

FIND Opg_header WHERE ROWID(Opg_header) = que_orden  NO-LOCK.
FIND Proveedor OF Opg_header NO-LOCK.

IF es_agretgan 
THEN DO:
    IF Proveedor.ret_ganancias OR 
       ( NOT Proveedor.ret_ganancias AND Opg_header.fecha > Proveedor.fmax_ganancias )
       THEN RUN CALRTGAN.P ( INPUT que_orden ).
END.

IF es_agretibr 
THEN DO:
    IF Proveedor.ret_ibrutos OR 
       ( NOT Proveedor.ret_ibrutos AND Opg_header.fecha > Proveedor.fmax_ibrutos )
       THEN RUN CALRTIBR.P ( INPUT que_orden ).
END.

IF es_agretiva 
THEN DO:
    IF Proveedor.ret_iva OR 
       ( NOT Proveedor.ret_iva AND Opg_header.fecha > Proveedor.fmax_iva )
       THEN RUN CALRTIVA.P ( INPUT que_orden ).
END.
