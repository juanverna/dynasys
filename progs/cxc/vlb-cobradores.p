
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Cobrador                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Cobrador AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Cobrador WHERE ROWID(Cobrador) = rid_Cobrador NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Cliente WHERE Cliente.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Cobrador-tipocli WHERE Cobrador-tipocli.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Cobrador-zona WHERE Cobrador-zona.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Cobrador_ptovta WHERE Cobrador_ptovta.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Cta_cte WHERE Cta_cte.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Rec_header WHERE Rec_header.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Rendicion_hd WHERE Rendicion_hd.nro_cobrador = Cobrador.nro_cobrador) OR
     CAN-FIND(FIRST Rescuenta_hd WHERE Rescuenta_hd.nro_cobrador = Cobrador.nro_cobrador)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.
