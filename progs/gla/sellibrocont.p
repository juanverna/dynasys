/*=============================================================================*/
/*                  HELP DE SELECCION DE CUENTAS CONTABLES                     */
/*=============================================================================*/

&GLOBAL-DEFINE TABLA           Librocontable
&GLOBAL-DEFINE CODIGO          cdg_librocontable
&GLOBAL-DEFINE NOMBRE          dsc_librocontable
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el Libro Contable o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Libros Contables
&GLOBAL-DEFINE PROCESO         ACBRWCTA
&GLOBAL-DEFINE ULT_REGISTRO    ult_cuenta

{SELBROWS.I}
