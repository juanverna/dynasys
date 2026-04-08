/*=============================================================================*/
/*                  HELP DE SELECCION DE CUENTAS CONTABLES                     */
/*=============================================================================*/

&GLOBAL-DEFINE TABLA           Cuenta
&GLOBAL-DEFINE CODIGO          cdg_cuenta
&GLOBAL-DEFINE NOMBRE          nombre
&GLOBAL-DEFINE CONDICION       Cuenta.lista_empresas CONTAINS que_empresa
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la Cuenta o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Imputaciones Contables
&GLOBAL-DEFINE PROCESO         ACBRWCTA
&GLOBAL-DEFINE ULT_REGISTRO    ult_cuenta

{SELBROWS.I}
