/*===========================================================================================*/
/*             S E L E C C I O N   D E   C U E N T A S   B A N C A R I A S                   */
/*===========================================================================================*/

&GLOBAL-DEFINE TABLA           Cuenta_bancaria
&GLOBAL-DEFINE CODIGO          cdg_cuenta_ban
&GLOBAL-DEFINE NOMBRE          denominacion
&GLOBAL-DEFINE CONDICION       Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa AND Cuenta_bancaria.cdg_banco = p-que_banco
&GLOBAL-DEFINE OTROS-CAMPOS    numero_cuenta cdg_banco
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la cuenta o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Cuentas Bancarias
&GLOBAL-DEFINE PROCESO         ACTCTBCO
&GLOBAL-DEFINE ULT_REGISTRO    ult_cuenta_ban

DEFINE INPUT PARAMETER p-que_banco LIKE Rubro.cdg_banco.

{SELBROWS-old.I}
