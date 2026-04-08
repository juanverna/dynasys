
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Grupo_francos                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Grupo_francos AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Grupo_francos WHERE ROWID(Grupo_francos) = rid_Grupo_francos NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Dia_franco WHERE Dia_franco.cdg_franco = grupo_francos.cdg_franco) OR
     CAN-FIND(FIRST Empleado WHERE Empleado.cdg_franco = grupo_francos.cdg_franco)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
