/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE PARTIDAS                                    */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Partida AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Partida WHERE ROWID(Partida) = rid_Partida NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.


PROCEDURE VALIDAR_BAJA:

  hay_error = NO.

  IF CAN-FIND(FIRST Acumulado_stock WHERE Acumulado_stock.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Ajusteinv_dt WHERE Ajusteinv_dt.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Cct_envases WHERE Cct_envases.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Cct_stock WHERE Cct_stock.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Emb_detalle_prv WHERE Emb_detalle_prv.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Fac_detalle WHERE Fac_detalle.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Fac_detalle_prv WHERE Fac_detalle_prv.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Partida-deposito WHERE Partida-deposito.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Ped_detalle WHERE Ped_detalle.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Rem_detalle WHERE Rem_detalle.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Rem_detalle_prv WHERE Rem_detalle_prv.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Transdep_dt WHERE Transdep_dt.nro_partida = Partida.nro_partida) OR
     CAN-FIND(FIRST Valeinv_dt WHERE Valeinv_dt.nro_partida = Partida.nro_partida)
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

