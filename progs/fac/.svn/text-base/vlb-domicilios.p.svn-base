
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Domicilio                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Domicilio AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Domicilio WHERE ROWID(Domicilio) = rid_Domicilio NO-LOCK.
FIND Cliente OF Domicilio NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Contrato_hd OF Cliente WHERE Contrato_hd.nro_domicilio = Domicilio.nro_domicilio) OR
     CAN-FIND(FIRST Fac_header OF Cliente WHERE Fac_header.nro_domicilio = Domicilio.nro_domicilio) OR
     CAN-FIND(FIRST Ped_header OF Cliente WHERE Ped_header.nro_domicilio = Domicilio.nro_domicilio) OR
     CAN-FIND(FIRST Rec_header OF Cliente WHERE Rec_header.nro_domicilio = Domicilio.nro_domicilio) OR
     CAN-FIND(FIRST Rem_header OF Cliente WHERE Rem_header.nro_domicilio = Domicilio.nro_domicilio)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
