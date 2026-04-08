/*===========================================================================================*/
/*                         HELP DE TIPO DE AREA                                  */
/*===========================================================================================*/

&GLOBAL-DEFINE TABLA           Area  
/*
&GLOBAL-DEFINE CONDICION       cdg_articulo <> ""
*/
&GLOBAL-DEFINE CODIGO          cdg_area
&GLOBAL-DEFINE FORMATO-CODIGO  FORMAT "X(20)"
&GLOBAL-DEFINE NOMBRE          denominacion
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el Area o ingrese el nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Area
&GLOBAL-DEFINE PROCESO         ACTTPART
&GLOBAL-DEFINE ULT_REGISTRO    ult_tipoart

&GLOBAL-DEFINE NUMERO          nro_area
{SELBROWS.I}
