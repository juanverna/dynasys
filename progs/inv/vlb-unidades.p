/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Unidad                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Unidad AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Unidad WHERE ROWID(Unidad) = rid_Unidad NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.cdg_umed = Unidad.cdg_umed) OR
     CAN-FIND(FIRST Articulo WHERE Articulo.cdg_ugranel = Unidad.cdg_umed) OR
     CAN-FIND(FIRST Articulo WHERE Articulo.cdg_ucompra = Unidad.cdg_umed) OR
     CAN-FIND(FIRST Equiv_unidades WHERE Equiv_unidades.cdg_umed = Unidad.cdg_umed) OR
     CAN-FIND(FIRST Propiedad WHERE Propiedad.cdg_umed = Unidad.cdg_umed) OR
     CAN-FIND(FIRST Equiv_unidades WHERE Equiv_unidades.cdg_umed_equiv = Unidad.cdg_umed)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
