/*=============================================================================*/
/*                  HELP DE SELECCION DE CUENTAS CONTABLES                     */
/*=============================================================================*/

&GLOBAL-DEFINE TABLA           Proveedor
&GLOBAL-DEFINE CODIGO          cdg_proveedor
&GLOBAL-DEFINE NOMBRE          nombre
&GLOBAL-DEFINE CONDICION       CAN-DO(Proveedor.lista_empresas,que_empresa) AND Proveedor.titular_oxp_sino
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la Cuenta o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Imputaciones Contables
&GLOBAL-DEFINE PROCESO         ACBRWCTA
&GLOBAL-DEFINE ULT_REGISTRO    ult_cuenta

{SELBROWS.I}
