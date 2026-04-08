/*===================================================================================*/
/*            DETERMINA CUAL DE LOS DOS TIPOS DE DETALLE SE DEBEN INVOCAR            */
/*===================================================================================*/

/*===================================================================================*/
/*                      DEFINICION DE LAS TABLAS TEMPORALES                          */
/*===================================================================================*/

DEFINE TEMP-TABLE T-Ocm_header               NO-UNDO LIKE Ocm_header.
DEFINE TEMP-TABLE T-Ocm_detalle              NO-UNDO LIKE Ocm_detalle.
                                                                                                   
/*===================================================================================*/
/*                           DEFINICION DE PARAMETROS                                */
/*===================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ocm_detalle.

DEFINE INPUT  PARAMETER p-nro_articulo   AS INTEGER.
DEFINE INPUT  PARAMETER p-inp_linea      AS INTEGER.
DEFINE INPUT  PARAMETER p-modo-cabecera  AS INTEGER.
DEFINE INPUT  PARAMETER p-modo-detalle   AS INTEGER.
DEFINE OUTPUT PARAMETER p-nro_linea      AS INTEGER.

{valoresmodo.i}

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
   RUN d-detocmcomex_servicios.w ( INPUT-OUTPUT TABLE T-Ocm_header,
                                   INPUT-OUTPUT TABLE T-Ocm_detalle,
                                   INPUT  p-nro_articulo,
                                   INPUT  p-inp_linea, 
                                   INPUT  p-modo-cabecera,
                                   INPUT  p-modo-detalle,
                                   OUTPUT p-nro_linea).

END.
ELSE DO:
   RUN d-detocmcomex_articulos.w ( INPUT-OUTPUT TABLE T-Ocm_header,
                                   INPUT-OUTPUT TABLE T-Ocm_detalle,
                                   INPUT  p-nro_articulo,
                                   INPUT  p-inp_linea, 
                                   INPUT  p-modo-cabecera,
                                   INPUT  p-modo-detalle,
                                   OUTPUT p-nro_linea).
END.
