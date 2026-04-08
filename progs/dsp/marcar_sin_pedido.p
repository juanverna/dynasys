/*=================================================================================*/
/*                 VERIFICA QUE EL CALCE DE PEDIDO Y REMITO SEA FACTIBLE           */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-nro_remito LIKE Rem_header.nro_remito.

/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

{findempresa.i}

DO TRANSACTION:

    FIND Rem_header WHERE Rem_header.nro_remito = p-nro_remito 
                      AND Rem_header.cdg_empresa = Empresa.cdg_empresa
                          EXCLUSIVE-LOCK.

    Rem_header.proc_estad = YES.

END.
