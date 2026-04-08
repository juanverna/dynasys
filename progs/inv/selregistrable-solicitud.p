/*===========================================================================================*/
/*             S E L E C C I O N   D E   C U E N T A S   B A N C A R I A S                   */
/*===========================================================================================*/

DEFINE INPUT PARAMETER p-articulo AS INTEGER.

&GLOBAL-DEFINE TABLA           Registrable
&GLOBAL-DEFINE CODIGO          cdg_registrable
&GLOBAL-DEFINE NOMBRE          dsc_registrable
&GLOBAL-DEFINE CONDICION       /*Registrable.cdg_empresa = Empresa.cdg_empresa  AND */ Registrable.nro_articulo = p-articulo
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el registrable o ingrese descripcion
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Bienes Registrables
&GLOBAL-DEFINE PROCESO         ACTCTBCO
&GLOBAL-DEFINE ULT_REGISTRO    ult_cta_ban

{SELBROWS.I}
