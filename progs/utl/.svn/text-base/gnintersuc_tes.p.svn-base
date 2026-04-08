/*=================================================================================*/
/*               GENERA LA INTERFACE DE SUCURSALES PARA TESORERIA                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 

DEFINE WORK-TABLE W-Docids
  FIELD nro_transaccion AS INTEGER.
  
DEFINE STREAM Exportacion.

DEFINE VARIABLE archivo            AS CHARACTER.
DEFINE VARIABLE direc_tmp          AS CHARACTER INITIAL ".\".

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS MOVIMIENTOS A EXPORTAR           */
/*=================================================================================*/

FOR EACH Caj_header WHERE Caj_header.fecha <= p-has_fecha 
                      AND Caj_header.fecha >= p-des_fecha
                      AND LOOKUP(STRING(Caj_header.prf_comprob,"9999"),p-pto_venta,",") <> 0:
                      
    CREATE W-Docids.
    ASSIGN W-Docids.nro_transaccion = Caj_header.nro_transaccion.
    
END.                          

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN direc_tmp = Parametro.valor_c.

archivo = direc_tmp + "\" + p-archivo + 
          STRING(YEAR(p-has_fecha),"9999") + 
          STRING(MONTH(p-has_fecha),"99") + 
          STRING(DAY(p-has_fecha),"99") + "TESXXX.TXT".
          
OUTPUT TO VALUE(REPLACE(archivo,"XXX","TEH")). 
FOR EACH W-Docids:
    FOR EACH Caj_header WHERE Caj_header.nro_transaccion = W-Docids.nro_transaccion:
        EXPORT DELIMITER "|" Caj_header.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","TED")). 
FOR EACH W-Docids:
    FOR EACH Caj_detalle WHERE Caj_detalle.nro_transaccion = W-Docids.nro_transaccion:
        EXPORT DELIMITER "|" Caj_detalle.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","CHQ")). 
FOR EACH W-Docids:
    FOR EACH Cheque WHERE Cheque.nro_transaccion = W-Docids.nro_transaccion:
        EXPORT DELIMITER "|" Cheque.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","VAL")). 
FOR EACH W-Docids:
    FOR EACH Valor WHERE Valor.nro_transaccion = W-Docids.nro_transaccion:
        EXPORT DELIMITER "|" Valor.
    END.    
END.
OUTPUT CLOSE.











