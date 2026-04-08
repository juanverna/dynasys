/*=================================================================================*/
/*   CHEQUEA LA AUTORZACION PARA ACEPTAR UN ITEM DE REQUISICION DE COMPRA          */
/*=================================================================================*/

DEFINE INPUT  PARAMETER que_requisicion AS ROWID.
DEFINE INPUT  PARAMETER que_detalle     AS ROWID.
DEFINE OUTPUT PARAMETER tiene_permiso   AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I}

tiene_permiso = YES. /* Si llega hasta aqui, es porque el sistema de seguridad lo deja */
