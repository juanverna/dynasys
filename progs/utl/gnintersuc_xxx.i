/*=================================================================================*/
/*          GENERA LA INTERFACE DE SUCURSALES PARA UN MODULO DETERMINADO           */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha AS DATE. 
DEFINE INPUT PARAMETER p-archivo   AS CHARACTER. 

DEFINE WORK-TABLE W-Docids
  FIELD {&NRO_INTERNO} AS INTEGER.
  
DEFINE STREAM Exportacion.

DEFINE VARIABLE archivo            AS CHARACTER.
DEFINE VARIABLE direc_tmp          AS CHARACTER INITIAL ".\".

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS REMITOS A EXPORTAR               */
/*=================================================================================*/

FOR EACH {&TABLA-DOCUMENTO} WHERE {&TABLA-DOCUMENTO}.fecha <= p-has_fecha 
                      AND {&TABLA-DOCUMENTO}.fecha >= p-des_fecha
                      AND LOOKUP(STRING({&TABLA-DOCUMENTO}.prf_comprob,"9999"),p-pto_venta,",") <> 0:
                      
    CREATE W-Docids.
    ASSIGN W-Docids.{&NRO_INTERNO} = {&TABLA-DOCUMENTO}.{&NRO_INTERNO}.
    
END.                          

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN direc_tmp = Parametro.valor_c.

archivo = direc_tmp + "\" + p-archivo + 
          STRING(YEAR(p-has_fecha),"9999") + 
          STRING(MONTH(p-has_fecha),"99") + 
          STRING(DAY(p-has_fecha),"99") + "{&SIGLA-MODULO}XXX.TXT".
          
{&EXPORTAR_TABLAS}












