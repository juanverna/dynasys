/*===================================================================================*/
/*            DETERMINA CUAL DE LOS DOS TIPOS DE DETALLE SE DEBEN INVOCAR            */
/*===================================================================================*/

/*===================================================================================*/
/*                      DEFINICION DE LAS TABLAS TEMPORALES                          */
/*===================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
                                                                                                   
/*===================================================================================*/
/*                           DEFINICION DE PARAMETROS                                */
/*===================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Fac_detalle-bon.

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
   FIND T-Fac_detalle WHERE T-Fac_detalle.nro_linea = p-inp_linea EXCLUSIVE-LOCK.
   FIND Articulo OF T-Fac_detalle NO-LOCK.
END.

IF Articulo.extendida
THEN DO:

   RUN d-detfactura_servicios.w ( INPUT-OUTPUT TABLE T-Fac_header,
                                  INPUT-OUTPUT TABLE T-Fac_detalle,
                                  INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                                  INPUT  p-nro_articulo,
                                  INPUT  p-inp_linea, 
                                  INPUT  p-modo-cabecera,
                                  INPUT  p-modo-detalle,
                                  OUTPUT p-nro_linea).

END.
ELSE DO:
   RUN d-detfactura_articulos.w ( INPUT-OUTPUT TABLE T-Fac_header,
                                  INPUT-OUTPUT TABLE T-Fac_detalle,
                                  INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                                  INPUT  p-nro_articulo,
                                  INPUT  p-inp_linea, 
                                  INPUT  p-modo-cabecera,
                                  INPUT  p-modo-detalle,
                                  OUTPUT p-nro_linea).
END.
