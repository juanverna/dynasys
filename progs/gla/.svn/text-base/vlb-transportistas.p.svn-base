
/*=========================================================================================*/
/*                      VALIDACION DE BAJAS DE LA TABLA:Transportista                             */
/*=========================================================================================*/

DEFINE INPUT  PARAMETER rid_Transportista AS ROWID.
DEFINE OUTPUT PARAMETER hay_error  AS LOGICAL.

FIND Transportista WHERE ROWID(Transportista) = rid_Transportista NO-LOCK.
RUN VALIDAR_BAJA.

RETURN.

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  MESSAGE "Tipo de datos incompatibles entre la tabla Transportista y las otras tablas.".

/*   IF CAN-FIND(FIRST Contrato_hd WHERE Contrato_hd.cdg_transportista = Transportista.cdg_transportista) OR */
/*      CAN-FIND(FIRST Ped_header WHERE Ped_header.cdg_transportista = Transportista.cdg_transportista) OR   */
/*      CAN-FIND(FIRST Rem_header WHERE Rem_header.cdg_transportista = Transportista.cdg_transportista) OR   */
/*      CAN-FIND(FIRST Transdep_hd WHERE Transdep_hd.cdg_transportista = Transportista.cdg_transportista)    */
/*      THEN RETURN.                                                                                         */

  hay_error = NO.

END PROCEDURE.
