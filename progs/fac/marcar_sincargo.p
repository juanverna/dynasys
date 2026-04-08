/*==================================================================================================*/
/*                  PRODUCE LA FACTURACION DE UNA SERIE DE REMITOS EN UNA SOLA FACTURA              */
/*==================================================================================================*/
/*
  NOTA: En la asignacion del nùmero interno de factura, se hace mencion a CURRENT-VALUE() + 1 en
  lugar de NEXT-VALUE. Es para no adelantar la secuencia ya que lo hace el procedimiento que sigue
  que es emitir_comprobante_cliente y entonces quedan los remitos con una referencia invalida a las 
  facturas
*/

DEFINE TEMP-TABLE T-Rem_header               NO-UNDO LIKE Rem_header.

/*==================================================================================================*/
/*                                          PARAMETROS                                              */
/*==================================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Rem_header.
DEFINE OUTPUT PARAMETER lista_errores AS CHARACTER.

/*==================================================================================================*/
/*                                          VARIABLES                                               */
/*==================================================================================================*/


/*==================================================================================================*/
/*                                        BLOQUE  PRINCIPAL                                         */
/*==================================================================================================*/

RUN proceso.

/*==================================================================================================*/
/*                                      PROCEDIMIENTOS INTERNOS                                     */
/*==================================================================================================*/

PROCEDURE proceso:

    {findempresa.i}


    /* --------------------------------------------------- */
    /* Procesamos todos los remitos y asignamos los arti-  */
    /* culos a la factura. Se asigna precio del remito.    */
    /* Luego, si los remitos tienen un origen que no debe  */
    /* respetar los precios que vienen en el mismo, pisamos*/
    /* esa asignacion levantando de la lista de precios    */
    /* --------------------------------------------------- */

   FOR EACH T-Rem_header:
       RUN poner_sincargo. /* Agrega las lineas de remito a las de factura. */
   END.
   

END PROCEDURE.

PROCEDURE poner_sincargo:

    FIND Rem_header WHERE Rem_header.nro_remito = T-Rem_header.nro_remito EXCLUSIVE-LOCK.
    ASSIGN Rem_header.sin_cargo = YES.
    RELEASE Rem_header.

END PROCEDURE.

