/*===================================================================================*/
/*             DETERMINA CUAL DE LOS DOS TIPOS DE DETALLE SE DEBEN INVOCAR           */
/*===================================================================================*/

DEFINE INPUT  PARAMETER p-nro_articulo   AS INTEGER.
DEFINE INPUT  PARAMETER p-inp_linea      AS INTEGER.
DEFINE INPUT  PARAMETER p-modo-cabecera  AS INTEGER.
DEFINE INPUT  PARAMETER p-modo-detalle   AS INTEGER.
DEFINE OUTPUT PARAMETER p-nro_linea      AS INTEGER.

{valoresmodo.i}

DEFINE SHARED TEMP-TABLE T-Ocm_detalle NO-UNDO LIKE Ocm_detalle.

/*===================================================================================*/
/*                               BLOQUE PRINCIPAL                                    */
/*===================================================================================*/

IF p-modo-cabecera = MD_ALTA
THEN DO:
   FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
END.
ELSE DO:
   FIND T-Ocm_detalle WHERE T-Ocm_detalle.nro_linea = p-inp_linea EXCLUSIVE-LOCK.
   FIND Articulo OF T-Ocm_detalle NO-LOCK.
END.

IF Articulo.extendida
THEN DO:
   RUN d-detocompra_servicios.w ( INPUT  p-nro_articulo,
                                  INPUT  p-inp_linea, 
                                  INPUT  p-modo-cabecera,
                                  INPUT  p-modo-detalle,
                                  OUTPUT p-nro_linea).

END.
ELSE DO:
   RUN d-detocompra_articulos.w ( INPUT  p-nro_articulo,
                                  INPUT  p-inp_linea, 
                                  INPUT  p-modo-cabecera,
                                  INPUT  p-modo-detalle,
                                  OUTPUT p-nro_linea).
END.
