/*===============================================================================*/
/*       SELECCIONA EL NUMERO DE CAJA HABILITADA POR EMPRESA                     */
/*===============================================================================*/

&GLOBAL-DEFINE TABLA           Caja
&GLOBAL-DEFINE CODIGO          cdg_caja
&GLOBAL-DEFINE NOMBRE          nombre
&GLOBAL-DEFINE CONDICION       CAN-DO(Caja.lista_empresas,Empresa.cdg_empresa) AND CAN-DO(Caja.lista_usuarios,Usuario.cdg_usuario)
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la caja o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Cajas
&GLOBAL-DEFINE PROCESO         ACBRWCAJ
&GLOBAL-DEFINE ULT_REGISTRO    ult_caja

{SELBROWS.I}
