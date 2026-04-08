/*=================================================================================*/
/*  CHEQUEA LA AUTORZACION PARA CAMBIAR EL ESTADO DE UNA O.DE COMPRA Y LO CAMBIA.  */
/*  SE CREA UN PROGRAMA PARA CADA ESTADO PARA PODER CONTROLAR LOS CAMBIOS DE ESTA- */
/*  DO DENTRO DEL SISTEMA GENERAL DE SEGURIDAD.                                    */
/*=================================================================================*/

DEFINE INPUT  PARAMETER que_ocompra     AS ROWID.
DEFINE INPUT  PARAMETER leyenda_cambio  AS CHARACTER.
DEFINE OUTPUT PARAMETER tiene_permiso   AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I}

/* Si llega hasta aqui, es porque el sistema de seguridad lo deja */

DO TRANSACTION:

   FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.
   FIND Ocm_header WHERE ROWID(Ocm_header) = que_ocompra EXCLUSIVE-LOCK.
   Ocm_header.cdg_estado = "{&QUE_ESTADO}".
   FOR EACH Ocm_detalle OF Ocm_header EXCLUSIVE-LOCK.
       Ocm_detalle.cdg_estado = Ocm_header.cdg_estado.
   END.
   CREATE Hst_ocompra.
   ASSIGN Hst_ocompra.cdg_estado         = "{&QUE_ESTADO}"
          Hst_ocompra.fch_cambio         = TODAY
          Hst_ocompra.hor_cambio         = TIME
          Hst_ocompra.hms_cambio         = STRING(Hst_ocompra.hor_cambio,"HH:MM:SS")
          Hst_ocompra.nro_ocompra        = Ocm_header.nro_ocompra
          Hst_ocompra.nro_usuario        = Usuario.nro_usuario
          Hst_ocompra.observacion        = leyenda_cambio.
   
   tiene_permiso = YES. 

END.
