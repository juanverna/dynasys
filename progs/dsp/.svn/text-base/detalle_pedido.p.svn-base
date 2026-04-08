/*===================================================================================*/
/*             DETERMINA CUAL DE LOS DOS TIPOS DE DETALLE SE DEBEN INVOCAR           */
/*===================================================================================*/

DEFINE TEMP-TABLE T-Ped_header      NO-UNDO LIKE Ped_header .
DEFINE TEMP-TABLE T-Ped_detalle     NO-UNDO LIKE Ped_detalle.
DEFINE TEMP-TABLE T-Ped_detalle-bon NO-UNDO LIKE Ped_detalle-bon.

/*===================================================================================*/
/*                                 PARAMETROS                                        */
/*===================================================================================*/

DEFINE INPUT  PARAMETER p-nro_articulo   AS INTEGER.
DEFINE INPUT  PARAMETER p-inp_linea      AS INTEGER.
DEFINE INPUT  PARAMETER p-modo-cabecera  AS INTEGER.
DEFINE INPUT  PARAMETER p-modo-detalle   AS INTEGER.
DEFINE OUTPUT PARAMETER p-nro_linea      AS INTEGER.

/*===================================================================================*/
/*                             TABLAS TEMPORALES                                     */
/*===================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle-bon.

/*===================================================================================*/
/*                                 VARIABLES                                         */
/*===================================================================================*/

{valoresmodo.i}

/*===================================================================================*/
/*                               BLOQUE PRINCIPAL                                    */
/*===================================================================================*/

IF p-modo-cabecera = MD_ALTA
THEN DO:
   FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
END.
ELSE DO:
   FIND T-Ped_detalle WHERE T-Ped_detalle.nro_linea = p-inp_linea EXCLUSIVE-LOCK.
   FIND Articulo OF T-Ped_detalle NO-LOCK.
END.

IF Articulo.extendida
THEN DO:
   RUN d-detpedido_servicios.w ( INPUT  p-nro_articulo,
                                 INPUT  p-inp_linea, 
                                 INPUT  p-modo-cabecera,
                                 INPUT  p-modo-detalle,
                                 OUTPUT p-nro_linea,
                                 INPUT-OUTPUT TABLE T-Ped_header,
                                 INPUT-OUTPUT TABLE T-Ped_detalle
                                 ).

END.
ELSE DO:
   RUN d-detpedido_articulos.w ( INPUT  p-nro_articulo,
                                 INPUT  p-inp_linea, 
                                 INPUT  p-modo-cabecera,
                                 INPUT  p-modo-detalle,
                                 OUTPUT p-nro_linea,
                                 INPUT-OUTPUT TABLE T-Ped_header,
                                 INPUT-OUTPUT TABLE T-Ped_detalle,
                                 INPUT-OUTPUT TABLE T-Ped_detalle-bon).
END.
