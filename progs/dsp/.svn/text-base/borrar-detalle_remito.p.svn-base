/*===================================================================================*/
/*             DETERMINA CUAL DE LOS DOS TIPOS DE DETALLE SE DEBEN INVOCAR           */
/*===================================================================================*/

DEFINE TEMP-TABLE T-Rem_header      NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_detalle     NO-UNDO LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Registrable-remito NO-UNDO LIKE Registrable-remito.
DEFINE TEMP-TABLE T-Rem_detalle-bon NO-UNDO LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Remito-pedido   NO-UNDO LIKE Remito-pedido.

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

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_header.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_detalle.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Registrable-remito.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Rem_detalle-bon.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Remito-pedido.

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
   FIND T-Rem_detalle WHERE T-Rem_detalle.nro_linea = p-inp_linea EXCLUSIVE-LOCK.
   FIND Articulo OF T-Rem_detalle NO-LOCK.
END.

IF Articulo.extendida
THEN DO:
   RUN d-detremito_servicios.w ( INPUT  p-nro_articulo,
                                 INPUT  p-inp_linea, 
                                 INPUT  p-modo-cabecera,
                                 INPUT  p-modo-detalle,
                                 OUTPUT p-nro_linea,
                                 INPUT-OUTPUT TABLE T-Rem_header,
                                 INPUT-OUTPUT TABLE T-Rem_detalle,
                                 INPUT-OUTPUT TABLE T-Registrable-remito,
                                 INPUT-OUTPUT TABLE T-Rem_detalle-bon,                                 
                                 INPUT-OUTPUT TABLE T-Remito-pedido
                                 ).

END.
ELSE DO:
   RUN d-detremito_articulos.w ( INPUT  p-nro_articulo,
                                 INPUT  p-inp_linea, 
                                 INPUT  p-modo-cabecera,
                                 INPUT  p-modo-detalle,
                                 OUTPUT p-nro_linea,
                                 INPUT-OUTPUT TABLE T-Rem_header,
                                 INPUT-OUTPUT TABLE T-Rem_detalle,
                                 INPUT-OUTPUT TABLE T-Registrable-remito,
                                 INPUT-OUTPUT TABLE T-Rem_detalle-bon,                                 
                                 INPUT-OUTPUT TABLE T-Remito-pedido
                                ).
END.
