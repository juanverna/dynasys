/*========================================================================================================*/
/* VERIFICA QUE NO HAYA MOVIMIENTOS DE FACTURACION DE UN DETERMINADO ARTICULO EN CIERTO PERIODO           */
/*========================================================================================================*/

/* Parámetros entrada: Cod Articulo - Fecha desde - Fecha hasta */
/*                  Julio Díaz - 13 Abril 2005                  */


/*
RUN validar_vigencia ( INPUT cCodEmpresa,           /* Codigo de Empresa */
                       INPUT cCodigoArticulo,
                       INPUT dFechaDesde,
                       INPUT dFechaHasta,
                       INPUT rowidVigencia,          
                       OUTPUT lValido  )
*/

DEFINE INPUT PARAMETER cCodEmpresa  LIKE  Vigencia_cyorden.cdg_empresa.
DEFINE INPUT PARAMETER cArticulo    LIKE  Articulo.cdg_articulo.
DEFINE INPUT PARAMETER dFechaDesde  LIKE  Vigencia_cyorden.rige_desde.
DEFINE INPUT PARAMETER dFechaHasta  LIKE  Vigencia_cyorden.rige_hasta.
DEFINE OUTPUT PARAMETER lValido     AS LOGICAL.             /* Período Válido? */

/*========================================================================================================*/
/*                                           PROCESO                                                      */
/*========================================================================================================*/

FIND Articulo WHERE Articulo.cdg_articulo = cArticulo NO-LOCK.

OPEN QUERY q-facturas
    FOR EACH Fac_detalle OF Articulo NO-LOCK, 
    FIRST Fac_header  OF Fac_detalle NO-LOCK 
          WHERE Fac_header.cdg_empresa = cCodEmpresa 
            AND Fac_header.fecha <= dFechaHasta      
            AND Fac_header.fecha >= dFechaDesde.

GET FIRST q-facturas.
IF AVAILABLE Fac_detalle 
THEN DO:
    RUN ponmensj.p ( INPUT "CYOR007" ).
    lValido = NO.
END.
ELSE DO:
    lValido = YES.
END.
