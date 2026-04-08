/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Empresa                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Empresa AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Empresa WHERE ROWID(Empresa) = rid_Empresa NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_caja WHERE Acumulado_caja.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Acumulado_ctapsp WHERE Acumulado_ctapsp.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Acumulado_cuenta WHERE Acumulado_cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Acumulado_diariocaja WHERE Acumulado_diariocaja.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Acumulado_pagos WHERE Acumulado_pagos.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Acumulado_stock WHERE Acumulado_stock.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Acum_ventas WHERE Acum_ventas.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Afiliado WHERE Afiliado.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Ajusteinv_hd WHERE Ajusteinv_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Aplicacion_pagos WHERE Aplicacion_pagos.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Aplicacion_pagos_prv WHERE Aplicacion_pagos_prv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Aps_header WHERE Aps_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Area WHERE Area.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Articulo-deposito WHERE Articulo-deposito.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Articulo-impuesto WHERE Articulo-impuesto.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Articulo_precio WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Articulo_tiporendicion WHERE Articulo_tiporendicion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Asn_detalle WHERE Asn_detalle.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Asn_header WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Atributos_deposito WHERE Atributos_deposito.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Auditoria_parametros WHERE Auditoria_parametros.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Autoriza_transaccion WHERE Autoriza_transaccion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Base WHERE Base.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Bduso WHERE Bduso.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Boleta_deposito_hd WHERE Boleta_deposito_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Caja_tipocomprobante WHERE Caja_tipocomprobante.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Caj_header WHERE Caj_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cct_stock WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Certificado_gan WHERE Certificado_gan.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Certificado_ibr WHERE Certificado_ibr.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Certificado_iva WHERE Certificado_iva.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Certificado_sus WHERE Certificado_sus.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cierre_diario WHERE Cierre_diario.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cierre_diariocaja WHERE Cierre_diariocaja.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Clase_de_Ctapsp WHERE Clase_de_Ctapsp.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Clase_de_Cuenta WHERE Clase_de_Cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Clase_de_Entidad WHERE Clase_de_Entidad.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Clase_de_Obra WHERE Clase_de_Obra.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Clase_de_Sector WHERE Clase_de_Sector.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Clearing_sucursal WHERE Clearing_sucursal.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente-bonificacion WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente-bonxarticulo WHERE Cliente-bonxarticulo.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente-observacion WHERE Cliente-observacion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente_cndventa WHERE Cliente_cndventa.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente_excencion WHERE Cliente_excencion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente_oficialcredito WHERE Cliente_oficialcredito.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cliente_rubro WHERE Cliente_rubro.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cobrador-tipocli WHERE Cobrador-tipocli.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cobrador-zona WHERE Cobrador-zona.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cobrador_ptovta WHERE Cobrador_ptovta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Columna_cuenta WHERE Columna_cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Columna_reporte WHERE Columna_reporte.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Comprobante_concepto WHERE Comprobante_concepto.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cotizacion WHERE Cotizacion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cotizacion_bono WHERE Cotizacion_bono.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Creditomaximo WHERE Creditomaximo.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Ctapsp-cuenta WHERE Ctapsp-cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cta_cte_com WHERE Cta_cte_com.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cta_cte_prv WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa) THEN RETURN.
  IF
     CAN-FIND(FIRST Cuenta-usuarios WHERE Cuenta-usuarios.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Cuenta_bancaria WHERE Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Ejercicio_fiscal WHERE Ejercicio_fiscal.cdg_empresa = Empresa.cdg_empresa) OR
  /* CAN-FIND(FIRST Emb_header_prv WHERE Emb_header_prv.cdg_empresa = Empresa.cdg_empresa) OR*/
     CAN-FIND(FIRST Empleado WHERE Empleado.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Entidad WHERE Entidad.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Entidad_distribucion WHERE Entidad_distribucion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Especificacion_detalle WHERE Especificacion_detalle.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Factura_de_credito WHERE Factura_de_credito.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Fac_header WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Fac_header_prv WHERE Fac_header_prv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Familia_cuenta WHERE Familia_cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Ficha WHERE Ficha.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Grupo-domicilio WHERE Grupo-domicilio.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Grupofam WHERE Grupofam.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_caj_header WHERE Hst_caj_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_cierre_diario WHERE Hst_cierre_diario.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_cierre_diariocaja WHERE Hst_cierre_diariocaja.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_domicilio WHERE Hst_domicilio.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_estadoregis WHERE Hst_estadoregis.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_ficha WHERE Hst_ficha.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_grupofam WHERE Hst_grupofam.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_opg_header WHERE Hst_opg_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_Proveedor WHERE Hst_Proveedor.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_rec_header WHERE Hst_rec_header.cdg_empresa = Empresa.cdg_empresa)
     THEN RETURN.

  IF CAN-FIND(FIRST Hst_rendgastos WHERE Hst_rendgastos.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Hst_valores WHERE Hst_valores.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Impuesto_condicion WHERE Impuesto_condicion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Imputacion_difcambios WHERE Imputacion_difcambios.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Libro-cuenta WHERE Libro-cuenta.cdg_empresa = Empresa.cdg_empresa) OR
 /*  CAN-FIND(FIRST Linea WHERE Linea.cdg_empresa = Empresa.cdg_empresa) OR*/
     CAN-FIND(FIRST Localidad WHERE Localidad.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Logmenu WHERE Logmenu.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Logusuario WHERE Logusuario.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Lote-factura WHERE Lote-factura.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Lote_pago WHERE Lote_pago.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Lote_pago_det WHERE Lote_pago_det.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Lst_sumysal WHERE Lst_sumysal.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Treemenu WHERE Treemenu.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Motivo_rechazo WHERE Motivo_rechazo.cdg_empresa = Empresa.cdg_empresa) OR
  /* CAN-FIND(FIRST Oci_header WHERE Oci_header.cdg_empresa = Empresa.cdg_empresa) OR*/
     CAN-FIND(FIRST Ocm_header WHERE Ocm_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Ofabrica_hd WHERE Ofabrica_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Opg_header WHERE Opg_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST OTraslado_hd WHERE OTraslado_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Parametro WHERE Parametro.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Parametro-excep WHERE Parametro-excep.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Parteprod_hd WHERE Parteprod_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Partida WHERE Partida.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Partida-deposito WHERE Partida-deposito.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Pedido_credencial WHERE Pedido_credencial.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Ped_header WHERE Ped_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Periodo_fiscal WHERE Periodo_fiscal.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Permiso-transaccion WHERE Permiso-transaccion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Plan WHERE Plan.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Plan-capita WHERE Plan-capita.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Planprod_hd WHERE Planprod_hd.cdg_empresa = Empresa.cdg_empresa) OR
  /* CAN-FIND(FIRST Producto WHERE Producto.cdg_empresa = Empresa.cdg_empresa) OR */
     CAN-FIND(FIRST Proveedor WHERE Proveedor.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_articulo WHERE Proveedor_articulo.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_cndventa WHERE Proveedor_cndventa.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_empleado WHERE Proveedor_empleado.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_excencion WHERE Proveedor_excencion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_excen_gan WHERE Proveedor_excen_gan.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_excen_ibr WHERE Proveedor_excen_ibr.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_excen_iva WHERE Proveedor_excen_iva.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_excen_sus WHERE Proveedor_excen_sus.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_Rendicion WHERE Proveedor_Rendicion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_Rubro WHERE Proveedor_Rubro.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Proveedor_viapago WHERE Proveedor_viapago.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Punto-venta WHERE Punto-venta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Registrable WHERE Registrable.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Relacion_comprobante WHERE Relacion_comprobante.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rem_header_prv WHERE Rem_header_prv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rendgastos_hd WHERE Rendgastos_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rendicion_hd WHERE Rendicion_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rescuenta_hd WHERE Rescuenta_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rqs_header WHERE Rqs_header.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Rubro_oficialcredito WHERE Rubro_oficialcredito.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Saldos_x_cuenta WHERE Saldos_x_cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Solic_derivacion WHERE Solic_derivacion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Sre_header WHERE Sre_header.cdg_empresa = Empresa.cdg_empresa) THEN RETURN.
  IF
     CAN-FIND(FIRST Sub_detalle_inv WHERE Sub_detalle_inv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Sub_detalle_prv WHERE Sub_detalle_prv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Sub_detalle_vta WHERE Sub_detalle_vta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Sub_header_inv WHERE Sub_header_inv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Sub_header_prv WHERE Sub_header_prv.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Sub_header_vta WHERE Sub_header_vta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Tipocomprobante WHERE Tipocomprobante.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Tipocomp_cuenta WHERE Tipocomp_cuenta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Tipocomp_rubro WHERE Tipocomp_rubro.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Tipo_puntovta WHERE Tipo_puntovta.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Transdep_hd WHERE Transdep_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Traslado-hd WHERE Traslado-hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Usuario WHERE Usuario.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST User_empresa WHERE User_empresa.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Usovehiculo WHERE Usovehiculo.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Usuario_funcion WHERE Usuario_funcion.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Usuario_modulo WHERE Usuario_modulo.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Usuario_programa WHERE Usuario_programa.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Valeinv_hd WHERE Valeinv_hd.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Valor WHERE Valor.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vendedor_articliente WHERE Vendedor_articliente.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vendedor_cliente WHERE Vendedor_cliente.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vendedor_escala WHERE Vendedor_escala.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vendedor_objetivo WHERE Vendedor_objetivo.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vendedor_obj_general WHERE Vendedor_obj_general.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vendedor_obj_zona WHERE Vendedor_obj_zona.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vigencia_cai WHERE Vigencia_cai.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vigencia_cyorden WHERE Vigencia_cyorden.cdg_empresa = Empresa.cdg_empresa) OR
     CAN-FIND(FIRST Vigencia_precios WHERE Vigencia_precios.cdg_empresa = Empresa.cdg_empresa)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
