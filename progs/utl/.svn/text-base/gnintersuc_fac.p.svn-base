/*=================================================================================*/
/*               GENERA LA INTERFACE DE SUCURSALES PARA FACTURACION                */
/*=================================================================================*/

/*

    NOTA:  ACTUALMENTE, LA INTERFACE DE FACTURACION NO CONTEMPLA 
           FACTURACION DE MOSTRADOR, YA QUE NO RELACIONARA LOS MOVIMIENTOS DE CAJA
           RESPECTIVOS. ESTOS SON TRATADOS POR LA INTERFACE DEL MODULO RESPECTI-
           VO, PERO EN FORMA INDEPENDIENTE TOTALMENTE.
           
           REVISAR    C U I D A D O S A M E N T E    ESTE TEMA
           
*/                      

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 

DEFINE WORK-TABLE W-Docids
  FIELD nro_factura AS INTEGER.
  
DEFINE STREAM Exportacion.

DEFINE VARIABLE archivo            AS CHARACTER.
DEFINE VARIABLE direc_tmp          AS CHARACTER INITIAL ".\".

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS MOVIMIENTOS A EXPORTAR           */
/*=================================================================================*/

FOR EACH Fac_header WHERE Fac_header.fecha <= p-has_fecha 
                      AND Fac_header.fecha >= p-des_fecha
                      AND LOOKUP(STRING(Fac_header.prf_comprob,"9999"),p-pto_venta,",") <> 0:
                      
    CREATE W-Docids.
    ASSIGN W-Docids.nro_factura = Fac_header.nro_factura.
    
END.                          

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN direc_tmp = Parametro.valor_c.

archivo = direc_tmp + "\" + p-archivo + 
          STRING(YEAR(p-has_fecha),"9999") + 
          STRING(MONTH(p-has_fecha),"99") + 
          STRING(DAY(p-has_fecha),"99") + "FACXXX.TXT".
          
OUTPUT TO VALUE(REPLACE(archivo,"XXX","FAH")). 
FOR EACH W-Docids:
    FOR EACH Fac_header WHERE Fac_header.nro_factura = W-Docids.nro_factura:
        EXPORT DELIMITER "|" Fac_header.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","FAD")). 
FOR EACH W-Docids:
    FOR EACH Fac_detalle WHERE Fac_detalle.nro_factura = W-Docids.nro_factura:
        EXPORT DELIMITER "|" Fac_detalle.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","BOH")). 
FOR EACH W-Docids:
    FOR EACH Fac_header-bon WHERE Fac_header-bon.nro_factura = W-Docids.nro_factura:
        EXPORT DELIMITER "|" Fac_header-bon.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","BOD")). 
FOR EACH W-Docids:
    FOR EACH Fac_detalle-bon WHERE Fac_detalle-bon.nro_factura = W-Docids.nro_factura:
        EXPORT DELIMITER "|" Fac_detalle-bon.
    END.    
END.
OUTPUT CLOSE.

OUTPUT TO VALUE(REPLACE(archivo,"XXX","RYF")). 
FOR EACH W-Docids:
    FOR EACH Remito-factura WHERE Remito-factura.nro_factura = W-Docids.nro_factura:
        EXPORT DELIMITER "|" Remito-factura.
    END.    
END.
OUTPUT CLOSE.











