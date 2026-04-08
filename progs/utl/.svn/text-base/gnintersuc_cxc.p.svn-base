/*=================================================================================*/
/*         GENERA LA INTERFACE DE SUCURSALES PARA CUENTAS POR COBRAR               */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 

DEFINE WORK-TABLE W-Docids
  FIELD nro_recibo AS INTEGER.
  
DEFINE STREAM Exportacion.

DEFINE VARIABLE archivo            AS CHARACTER.
DEFINE VARIABLE direc_tmp          AS CHARACTER INITIAL ".\".

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS MOVIMIENTOS A EXPORTAR           */
/*=================================================================================*/

FOR EACH Rec_header WHERE Rec_header.fecha <= p-has_fecha 
                      AND Rec_header.fecha >= p-des_fecha
                      AND LOOKUP(STRING(Rec_header.prf_comprob,"9999"),p-pto_venta,",") <> 0:
                      
    CREATE W-Docids.
    ASSIGN W-Docids.nro_recibo = Rec_header.nro_recibo.
    
END.                          

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN direc_tmp = Parametro.valor_c.

archivo = direc_tmp + "\" + p-archivo + 
          STRING(YEAR(p-has_fecha),"9999") + 
          STRING(MONTH(p-has_fecha),"99") + 
          STRING(DAY(p-has_fecha),"99") + "CXCXXX.TXT".
          
OUTPUT TO VALUE(REPLACE(archivo,"XXX","REH")). 
FOR EACH W-Docids:
    FOR EACH Rec_header WHERE Rec_header.nro_recibo = W-Docids.nro_recibo:
        EXPORT DELIMITER "|" Rec_header.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","RED")). 
FOR EACH W-Docids:
    FOR EACH Rec_detalle WHERE Rec_detalle.nro_recibo = W-Docids.nro_recibo:
        EXPORT DELIMITER "|" Rec_detalle.
    END.    
END.
OUTPUT CLOSE.












