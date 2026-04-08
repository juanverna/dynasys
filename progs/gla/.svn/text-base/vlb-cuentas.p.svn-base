/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE clienteS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_cuenta AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Cuenta WHERE ROWID(Cuenta) = rid_cuenta NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_cuenta WHERE Acumulado_cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Ajusteinv_dt WHERE Ajusteinv_dt.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Amd_detalle WHERE Amd_detalle.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Asn_detalle WHERE Asn_detalle.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Banco-comex WHERE Banco-comex.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Bduso WHERE Bduso.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Bonificacion WHERE Bonificacion.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Caja-imputacion WHERE Caja-imputacion.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cheque WHERE Cheque.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Clase_de_Cuenta WHERE Clase_de_Cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Columna_cuenta WHERE Columna_cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Concepto-cuenta WHERE Concepto-cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Ctapsp-cuenta WHERE Ctapsp-cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cta_cte_bco WHERE Cta_cte_bco.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Emb_detalle_prv WHERE Emb_detalle_prv.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_cliente WHERE Familia_cliente.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_cuenta WHERE Familia_cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Gasto WHERE Gasto.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Impuesto WHERE Impuesto.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Item-cuenta WHERE Item-cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Rem_detalle WHERE Rem_detalle.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Rem_detalle_prv WHERE Rem_detalle_prv.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Rubro WHERE Rubro.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Saldos_x_cuenta WHERE Saldos_x_cuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Subcuenta WHERE Subcuenta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_detalle_bco WHERE Sub_detalle_bco.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_detalle_inv WHERE Sub_detalle_inv.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_detalle_prv WHERE Sub_detalle_prv.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_detalle_syj WHERE Sub_detalle_syj.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_detalle_vta WHERE Sub_detalle_vta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_header_bco WHERE Sub_header_bco.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_header_inv WHERE Sub_header_inv.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_header_prv WHERE Sub_header_prv.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_header_syj WHERE Sub_header_syj.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sub_header_vta WHERE Sub_header_vta.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Sumariza_psp WHERE Sumariza_psp.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Tipo_actividad WHERE Tipo_actividad.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Tipo_retibr WHERE Tipo_retibr.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Tipo_retiva WHERE Tipo_retiva.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Tipo_retsus WHERE Tipo_retsus.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Transdep_dt WHERE Transdep_dt.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Valeinv_dt WHERE Valeinv_dt.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Valor WHERE Valor.nro_cuenta = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cuenta_bancaria WHERE Cuenta_bancaria.nro_cuenta_acredita = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.nro_cuenta_ajuste = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cheque WHERE Cheque.nro_cuenta_ban = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.nro_cuenta_consumo = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.nro_cuenta_costo = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cuenta_bancaria WHERE Cuenta_bancaria.nro_cuenta_deposito = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cuenta_bancaria WHERE Cuenta_bancaria.nro_cuenta_emision = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.nro_cuenta_existencia = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.nro_cuenta_pendte = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cuenta_bancaria WHERE Cuenta_bancaria.nro_cuenta_rechazo = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Cuenta_bancaria WHERE Cuenta_bancaria.nro_cuenta_rechpropio = Cuenta.nro_cuenta) OR
     CAN-FIND(FIRST Familia_articulo WHERE Familia_articulo.nro_cuenta_variacion = Cuenta.nro_cuenta)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
