/*=================================================================================*/
/*                 VERIFICA QUE EL CALCE DE PEDIDO Y REMITO SEA FACTIBLE           */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-nro_pedido LIKE Ped_header.nro_pedido.
DEFINE INPUT  PARAMETER p-nro_remito LIKE Rem_header.nro_remito.
DEFINE OUTPUT PARAMETER p-rc         AS INTEGER.


/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

{findempresa.i}

FIND Ped_header WHERE Ped_header.nro_pedido = p-nro_pedido NO-LOCK NO-ERROR.
IF NOT AVAILABLE Ped_header
THEN DO:
     p-rc = 1.
     RETURN.
END.

FIND Rem_header WHERE Rem_header.nro_remito = p-nro_remito NO-LOCK NO-ERROR.
IF NOT AVAILABLE Rem_header
THEN DO:
     p-rc = 2.
     RETURN.
END.

p-rc = 0.
FOR EACH Rem_detalle OF Rem_header WHILE p-rc = 0:
    
    FIND FIRST Ped_detalle OF Ped_header
         WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo 
               NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Ped_detalle 
    THEN DO:
         p-rc = 3.
         RUN ponmensj.p ( "CNRE003" ).
    END.

END.


