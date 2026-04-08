/*========================================================================================================*/
/* VERIFICA QUE NO HAYA MOVIMIENTOS DE FACTURACION DE UN DETERMINADO Proveedor EN CIERTO PERIODO           */
/*========================================================================================================*/

/* Parámetros entrada: Cod Proveedor - Fecha desde - Fecha hasta */
/*                  Julio Díaz - 13 Abril 2005                  */


/*
RUN validar_vigencia ( INPUT cCodEmpresa,           /* Codigo de Empresa */
                       INPUT cCodigoProveedor,
                       INPUT dFechaDesde,
                       INPUT dFechaHasta,
                       INPUT rowidVigencia,          
                       OUTPUT lValido  )
*/

DEFINE INPUT PARAMETER cCodEmpresa  LIKE  Vigencia_cyorden.cdg_empresa.
DEFINE INPUT PARAMETER cProveedor   LIKE  Proveedor.cdg_Proveedor.
DEFINE INPUT PARAMETER dFechaDesde  LIKE  Vigencia_cyorden.rige_desde.
DEFINE INPUT PARAMETER dFechaHasta  LIKE  Vigencia_cyorden.rige_hasta.
DEFINE OUTPUT PARAMETER lValido     AS LOGICAL.             /* Período Válido? */

/*========================================================================================================*/
/*                                           PROCESO                                                      */
/*========================================================================================================*/

FIND Proveedor WHERE Proveedor.cdg_Proveedor = cProveedor NO-LOCK.
IF CAN-FIND(FIRST Opg_header OF Proveedor 
            WHERE Opg_header.cdg_empresa = cCodEmpresa 
              AND Opg_header.fecha <= dFechaHasta      
              AND Opg_header.fecha >= dFechaDesde
              AND NOT Opg_header.anulado)
THEN DO:
    RUN ponmensj.p ( INPUT "EXIM008" ).
    lValido = NO.
END.
ELSE DO:
    lValido = YES.
END.



