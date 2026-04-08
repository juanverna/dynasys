/*===================================================================================*/
/*           V A R I A B L E S     F R A M E S     Y     T R I G G E R S             */
/*===================================================================================*/

/* ----------------------------------------------------------------- */
/* CONSULTA DE RECEPCIONES POR RANGO DE FECHAS Y POR UN PROVEEDOR    */
/* SIN PARAMETRO DE SALIDA, SE BUSCAN LOS REGISTROS SELECTADOS       */
/* ----------------------------------------------------------------- */

DEFINE OUTPUT PARAMETER hay_factura AS LOGICAL INITIAL NO.

{VRSHARED.I}
{VPERSINM.I}

IF CAN-FIND( FIRST Parametro WHERE Parametro.cdg_parametro = "ACTIVMXP" 
                              AND Parametro.valor_l )
   THEN RUN SELRCPEN.P ( OUTPUT hay_factura ).
   ELSE RUN SELRMPEN.P ( OUTPUT hay_factura ).
