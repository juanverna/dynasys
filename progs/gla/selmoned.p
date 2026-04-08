/*=================================================================================*/
/*                           SELECCION DE MONEDADS                                 */
/*=================================================================================*/

&GLOBAL-DEFINE TABLA           Moneda
&GLOBAL-DEFINE CODIGO          cdg_moneda
&GLOBAL-DEFINE FORMATO-CODIGO  FORMAT "X(8)"
&GLOBAL-DEFINE NOMBRE          descripcion
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la moneda o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de monedas
&GLOBAL-DEFINE PROCESO         ACTMONED
&GLOBAL-DEFINE ULT_REGISTRO    ult_moneda

{SELBROWS.I}
