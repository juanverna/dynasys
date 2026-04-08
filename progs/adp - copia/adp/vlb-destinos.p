/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Destino                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Destino AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Destino WHERE ROWID(Destino) = rid_Destino NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Horario WHERE Horario.cdg_destino = Destino.cdg_destino) OR
     CAN-FIND(FIRST Parte_novedades WHERE Parte_novedades.cdg_destino = Destino.cdg_destino)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
