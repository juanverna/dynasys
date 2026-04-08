/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE ArticuloS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_articulo AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.



PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Acumulado_stock WHERE Acumulado_stock.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Acum_ventas WHERE Acum_ventas.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Ajusteinv_dt WHERE Ajusteinv_dt.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Aliart-cliente WHERE Aliart-cliente.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Aliart-interno WHERE Aliart-interno.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Aliart-proveed WHERE Aliart-proveed.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo-bonificacion WHERE Articulo-bonificacion.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo-deposito WHERE Articulo-deposito.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo-oferta WHERE Articulo-oferta.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo-proveedor WHERE Articulo-proveedor.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo_atributo WHERE Articulo_atributo.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo_contenedor WHERE Articulo_contenedor.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo_precio WHERE Articulo_precio.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Articulo_propiedad WHERE Articulo_propiedad.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Cct_envases WHERE Cct_envases.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Cct_stock WHERE Cct_stock.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Clase_de_Articulo WHERE Clase_de_Articulo.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Cliente-bonxarticulo WHERE Cliente-bonxarticulo.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Concurso-requisicion WHERE Concurso-requisicion.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Concurso_cotiza WHERE Concurso_cotiza.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Concurso_item WHERE Concurso_item.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Contrato_dt WHERE Contrato_dt.nro_articulo = Articulo.nro_articulo) OR
     /*CAN-FIND(FIRST Dev_detalle WHERE Dev_detalle.nro_articulo = Articulo.nro_articulo) OR*/
     CAN-FIND(FIRST Emb_detalle_prv WHERE Emb_detalle_prv.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Fac_detalle WHERE Fac_detalle.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Fac_detalle_prv WHERE Fac_detalle_prv.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST FComercial WHERE FComercial.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Lista_comisiones WHERE Lista_comisiones.nro_articulo = Articulo.nro_articulo) OR
     /*CAN-FIND(FIRST Oci_detalle WHERE Oci_detalle.nro_articulo = Articulo.nro_articulo) OR*/
     CAN-FIND(FIRST Ocm_detalle WHERE Ocm_detalle.nro_articulo = Articulo.nro_articulo) OR
     /*CAN-FIND(FIRST Partida WHERE Partida.nro_articulo = Articulo.nro_articulo) OR*/
     CAN-FIND(FIRST Partida-deposito WHERE Partida-deposito.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Ped_detalle WHERE Ped_detalle.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Registrable WHERE Registrable.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Rem_detalle WHERE Rem_detalle.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Rem_detalle_prv WHERE Rem_detalle_prv.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Rqs_detalle WHERE Rqs_detalle.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Transdep_dt WHERE Transdep_dt.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Valeinv_dt WHERE Valeinv_dt.nro_articulo = Articulo.nro_articulo) OR
     CAN-FIND(FIRST Vigencia_cyorden WHERE Vigencia_cyorden.nro_articulo = Articulo.nro_articulo)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

