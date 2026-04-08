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
DEFINE INPUT PARAMETER ridVigencia  AS ROWID.
DEFINE OUTPUT PARAMETER lValido     AS LOGICAL.             /* Período Válido? */

/* Tabla temporal que contiene los dìas ocupados de ese artìculo */
DEFINE BUFFER B-Vigencia_cyorden FOR Vigencia_cyorden.
DEFINE BUFFER B-Articulo         FOR Articulo.

FIND FIRST B-Articulo 
     WHERE B-Articulo.cdg_articulo = cArticulo 
     NO-LOCK NO-ERROR.

IF AVAILABLE B-Articulo THEN DO:
    
    /* Cargo todos los comprobantes del detalle de factura que referenciaban a ese artìculo */
    lValido = TRUE.

    FOR EACH  Fac_detalle OF B-Articulo,
        FIRST Fac_header OF Fac_detalle 
        WHERE Fac_header.cdg_empresa = cCodEmpresa    NO-LOCK:
        IF Fac_header.fecha  >= dFechaDesde AND
            Fac_header.fecha <= dFechaHasta THEN DO:
            lValido = FALSE.
            LEAVE.
        END.
    END.

END.


