/*==================================================================================*/
/*          SUMA LOS PORCENTAJES DE DISTRIBUCION PARA UNA ENTIDAD DADA              */
/*==================================================================================*/

 DEFINE INPUT  PARAMETER p-nro_entidad       LIKE Entidad.nro_entidad.
 DEFINE OUTPUT PARAMETER p-total-porcentajes LIKE Entidad_distribucion.porcentaje.

 p-total-porcentajes  = 0.
 FOR EACH Entidad_distribucion WHERE Entidad_distribucion.nro_entidad = p-nro_entidad NO-LOCK:
     p-total-porcentajes = p-total-porcentajes + Entidad_distribucion.porcentaje.
 END.
