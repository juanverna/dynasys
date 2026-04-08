/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE CONDICIONES DE IVA                          */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_condicion AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Vigencia_cai WHERE ROWID(Vigencia_cai) = rid_condicion NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  IF CAN-FIND(FIRST Fac_header      WHERE Fac_header.cai        = vigencia_cai.cai) OR
     CAN-FIND(FIRST Fac_header_prv  WHERE Fac_header_prv.cai    = vigencia_cai.cai) OR
     CAN-FIND(FIRST Rem_header      WHERE Rem_header.cai        = vigencia_cai.cai) OR
     CAN-FIND(FIRST Rem_header_prv  WHERE Rem_header_prv.cai    = vigencia_cai.cai) OR
     CAN-FIND(FIRST Transdep_hd     WHERE transdep_hd.cai       = vigencia_cai.cai) 
     THEN RETURN.

  hay_error = NO.

END PROCEDURE.

