/*=================================================================================*/
/*  CHEQUEA LA AUTORZACION PARA CAMBIAR EL ESTADO DE UNA REQUISICION Y LO CAMBIA.  */
/*  SE CREA UN PROGRAMA PARA CADA ESTADO PARA PODER CONTROLAR LOS CAMBIOS DE ESTA- */
/*  DO DENTRO DEL SISTEMA GENERAL DE SEGURIDAD.                                    */
/*=================================================================================*/

DEFINE INPUT  PARAMETER que_requisicion AS ROWID.
DEFINE INPUT  PARAMETER que_detalle     AS ROWID.
DEFINE INPUT  PARAMETER leyenda_cambio  AS CHARACTER.
DEFINE OUTPUT PARAMETER tiene_permiso   AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I}

/* Si llega hasta aqui, es porque el sistema de seguridad lo deja */

DO TRANSACTION:

   FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.
   FIND Rqs_detalle WHERE ROWID(Rqs_detalle) = que_detalle EXCLUSIVE-LOCK.
   Rqs_detalle.cdg_estado = "{&QUE_ESTADO}".
   CREATE Hst_requisicion.
   ASSIGN Hst_requisicion.cdg_estado         = "{&QUE_ESTADO}"
          Hst_requisicion.fch_cambio         = TODAY
          Hst_requisicion.hor_cambio         = TIME
          Hst_requisicion.hms_cambio         = STRING(Hst_requisicion.hor_cambio,"HH:MM:SS")
          Hst_requisicion.nro_linea          = Rqs_detalle.nro_linea
          Hst_requisicion.nro_requisicion    = Rqs_detalle.nro_requisicion
          Hst_requisicion.nro_usuario        = Usuario.nro_usuario
          Hst_requisicion.observacion        = leyenda_cambio.
   
   tiene_permiso = YES. 

END.
