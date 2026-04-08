/*=================================================================================*/
/*                CARGA LOS COMPROBANTES DE VENTAS QUE DEBITAN                     */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-ciclo     AS CHARACTER.
DEFINE OUTPUT PARAMETER str_debitan AS CHARACTER.

{findempresa.i}
str_debitan = "".
FOR EACH  Tipocomprobante 
    WHERE Tipocomprobante.debita 
    AND   Tipocomprobante.cdg_empresa = Empresa.cdg_empresa 
    AND   Tipocomprobante.cdg_ciclocomercial = p-ciclo
    NO-LOCK :
    str_debitan = str_debitan +  "," +  Tipocomprobante.tip_comprob.
END.
str_debitan = SUBSTRING(str_debitan,2).
