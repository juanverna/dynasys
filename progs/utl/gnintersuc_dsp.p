/*=================================================================================*/
/*               GENERA LA INTERFACE DE SUCURSALES PARA DESPACHO                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 

DEFINE WORK-TABLE W-Docids
  FIELD nro_remito AS INTEGER.
  
DEFINE STREAM Exportacion.

DEFINE VARIABLE archivo            AS CHARACTER.
DEFINE VARIABLE direc_tmp          AS CHARACTER INITIAL ".\".

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS REMITOS A EXPORTAR               */
/*=================================================================================*/

FOR EACH Rem_header WHERE Rem_header.fecha <= p-has_fecha 
                      AND Rem_header.fecha >= p-des_fecha
                      AND LOOKUP(STRING(Rem_header.prf_comprob,"9999"),p-pto_venta,",") <> 0:
                      
    CREATE W-Docids.
    ASSIGN W-Docids.nro_remito = Rem_header.nro_remito.
    
END.                          

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN direc_tmp = Parametro.valor_c.

archivo = direc_tmp + "\" + p-archivo + 
          STRING(YEAR(p-has_fecha),"9999") + 
          STRING(MONTH(p-has_fecha),"99") + 
          STRING(DAY(p-has_fecha),"99") + "DSPXXX.TXT".
          
OUTPUT TO VALUE(REPLACE(archivo,"XXX","RMH")). 
FOR EACH W-Docids:
    FOR EACH Rem_header WHERE Rem_header.nro_remito = W-Docids.nro_remito:
        EXPORT DELIMITER "|" Rem_header.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","RMD")). 
FOR EACH W-Docids:
    FOR EACH Rem_detalle WHERE Rem_detalle.nro_remito = W-Docids.nro_remito:
        EXPORT DELIMITER "|" Rem_detalle.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","BOH")). 
FOR EACH W-Docids:
    FOR EACH Rem_header-bon WHERE Rem_header-bon.nro_remito = W-Docids.nro_remito:
        EXPORT DELIMITER "|" Rem_header-bon.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","BOD")). 
FOR EACH W-Docids:
    FOR EACH Rem_detalle-bon WHERE Rem_detalle-bon.nro_remito = W-Docids.nro_remito:
        EXPORT DELIMITER "|" Rem_detalle-bon.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","RYF")). 
FOR EACH W-Docids:
    FOR EACH Remito-factura WHERE Remito-factura.nro_remito = W-Docids.nro_remito:
        EXPORT DELIMITER "|" Remito-factura.
    END.    
END.
OUTPUT CLOSE.











