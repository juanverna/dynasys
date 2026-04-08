/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Procedimiento                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Procedimiento AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Procedimiento WHERE ROWID(Procedimiento) = rid_Procedimiento NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Articulo WHERE Articulo.nro_procedimiento = Procedimiento.nro_procedimiento) OR
     CAN-FIND(FIRST Especif_procedimiento WHERE Especif_procedimiento.nro_procedimiento = Procedimiento.nro_procedimiento) 
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

