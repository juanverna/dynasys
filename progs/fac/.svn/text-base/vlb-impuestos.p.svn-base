
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Impuesto                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Impuesto AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Impuesto WHERE ROWID(Impuesto) = rid_Impuesto NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo-impuesto WHERE Articulo-impuesto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Cliente_excencion WHERE Cliente_excencion.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Fac_detalle_impuesto WHERE Fac_detalle_impuesto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Fac_detalle_prv_impuesto WHERE Fac_detalle_prv_impuesto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Fac_header_impuesto WHERE Fac_header_impuesto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Fac_header_prv_impuesto WHERE Fac_header_prv_impuesto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Impuesto_concepto WHERE Impuesto_concepto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Impuesto_condicion WHERE Impuesto_condicion.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Ped_detalle_impuesto WHERE Ped_detalle_impuesto.cdg_impuesto = Impuesto.cdg_impuesto) OR
     CAN-FIND(FIRST Ped_header_impuesto WHERE Ped_header_impuesto.cdg_impuesto = Impuesto.cdg_impuesto)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
