/*=================================================================================*/
/*               LEE LAS DEFINICIONES DE LOS PUNTOS DE VENTA                       */
/*=================================================================================*/

DEFINE INPUT PARAMETER  que_comprobante AS CHARACTER.
DEFINE OUTPUT PARAMETER punto_venta     AS INTEGER.

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE valor_ptovta   AS CHARACTER.
/*
{findempresa.i}

FILE-INFO:FILE-NAME = "sic-" + Empresa.cdg_empresa + ".ini".
LOAD FILE-INFO:FULL-PATHNAME NO-ERROR.
IF NOT ERROR-STATUS:ERROR
THEN DO:

    USE "sic-" + Empresa.cdg_empresa + ".ini".
    
    GET-KEY-VALUE SECTION "PuntodeVenta" KEY que_comprobante VALUE valor_ptovta.
    punto_venta = INTEGER(valor_ptovta).
    
    IF punto_venta = ? 
    THEN DO:
         MESSAGE "No se ha definido el valor del punto de venta para los comprobantes "
                 que_comprobante " de la empresa " Empresa.nombre  
                 ".Edite el archivo SIC.INI y modifique la seccion "
                 "[PuntodeVenta]"
                 VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE INSTALACION".
    END.
    ELSE DO:
    /*
         UPDATE SPACE(4) punto_venta BGCOLOR 15 LABEL "Valor Actual" FORMAT "9999"
                WITH FRAME frm-punto SIDE-LABELS THREE-D FGCOLOR 0 BGCOLOR 8 FONT 4
                     VIEW-AS DIALOG-BOX TITLE "Indique Punto de Venta".
    */
    END.                 
END.
ELSE DO:
    MESSAGE "No se ha encontrado el archivo SIC-" Empresa.cdg_empresa 
            ", Correspondiente a la empresa " Empresa.nombre  
            ".No es conveniente proseguir con el uso de la aplicación. "
            VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE INSTALACION - getptovta.p".

END.
*/
