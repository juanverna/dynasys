
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Grupo_abasto                       */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Grupo_abasto AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Grupo_abasto WHERE ROWID(Grupo_abasto) = rid_Grupo_abasto NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.cdg_grupoabasto = Grupo_abasto.cdg_grupoabasto) OR
     CAN-FIND(FIRST Tasa_abasto WHERE Tasa_abasto.cdg_grupoabasto = Grupo_abasto.cdg_grupoabasto)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
