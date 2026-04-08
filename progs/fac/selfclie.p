/*==========================================================================================*/
/*                           SELECCION DEL TIPO DE PROVEEDOR                                */
/*==========================================================================================*/

&GLOBAL-DEFINE TABLA           Familia_cliente
&GLOBAL-DEFINE CODIGO          cdg_famclie
&GLOBAL-DEFINE NOMBRE          dsc_famclie
&GLOBAL-DEFINE CONDICION       LOOKUP(que_empresa,Familia_cliente.lista_empresas) <> 0
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la Familia del Cliente
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Familias de Clientes
&GLOBAL-DEFINE PROCESO         ACTFCLIE
&GLOBAL-DEFINE ULT_REGISTRO    ult_famclie

{SELBROWS.I}
