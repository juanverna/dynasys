
/*=================================================================================*/
/*                           SELECCION DE PROVINCIAS                               */
/*=================================================================================*/

&GLOBAL-DEFINE TABLA           Provincia
&GLOBAL-DEFINE CODIGO          cdg_provincia
&GLOBAL-DEFINE FORMATO-CODIGO  "X(2)"
&GLOBAL-DEFINE NOMBRE          nombre
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la provincia o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Selección de provincias
&GLOBAL-DEFINE PROCESO         ACTMONED
&GLOBAL-DEFINE ULT_REGISTRO    ult_moneda

{SELBROWS.I}

