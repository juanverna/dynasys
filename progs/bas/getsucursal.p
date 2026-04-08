/*=================================================================================*/
/*               LEE LAS DEFINICIONES DE LOS PUNTOS DE VENTA                       */
/*=================================================================================*/

DEFINE OUTPUT PARAMETER codigo_sucursal  LIKE Sucursal.num_sucursal.

DEFINE VARIABLE valor_sucursal  AS CHARACTER.

{levantarini.i}

GET-KEY-VALUE SECTION "PuntodeVenta" KEY "SUCURSAL" VALUE codigo_sucursal.

IF codigo_sucursal = ? 
THEN DO:
     MESSAGE "No se ha definido el valor de SUCURSAL. Edite el archivo SIC.INI y modifique la seccion "
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

