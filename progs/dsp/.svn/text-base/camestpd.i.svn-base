/*=================================================================================*/
/*  CHEQUEA LA AUTORZACION PARA CAMBIAR EL ESTADO DE UN PEDIDO Y LO CAMBIA.        */
/*  SE CREA UN PROGRAMA PARA CADA ESTADO PARA PODER CONTROLAR LOS CAMBIOS DE ESTA- */
/*  DO DENTRO DEL SISTEMA GENERAL DE SEGURIDAD.                                    */
/*=================================================================================*/

DEFINE INPUT  PARAMETER que_pedido AS ROWID.
DEFINE INPUT  PARAMETER que_detalle     AS ROWID.
DEFINE INPUT  PARAMETER leyenda_cambio  AS CHARACTER.
DEFINE OUTPUT PARAMETER tiene_permiso   AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I}

/* Si llega hasta aqui, es porque el sistema de seguridad lo deja */

DO TRANSACTION:

   FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.
   FIND Ped_detalle WHERE ROWID(Ped_detalle) = que_detalle EXCLUSIVE-LOCK.
   Ped_detalle.cdg_estado = "{&QUE_ESTADO}".
   CREATE Hst_pedido.
   ASSIGN Hst_pedido.cdg_estado         = "{&QUE_ESTADO}"
          Hst_pedido.fch_cambio         = TODAY
          Hst_pedido.hor_cambio         = TIME
          Hst_pedido.hms_cambio         = STRING(Hst_pedido.hor_cambio,"HH:MM:SS")
          Hst_pedido.nro_linea          = Ped_detalle.nro_linea
          Hst_pedido.nro_pedido         = Ped_detalle.nro_pedido
          Hst_pedido.nro_usuario        = Usuario.nro_usuario
          Hst_pedido.observacion        = leyenda_cambio.
   
   tiene_permiso = YES. 

END.
