/*==============================================================================*/
/*                 SELECCIONA UNA LISTA DE PRECIOS DE VENTAS                    */
/*==============================================================================*/

&GLOBAL-DEFINE TABLA           Lista_precio
&GLOBAL-DEFINE CODIGO          cdg_lista
&GLOBAL-DEFINE NOMBRE          descripcion
&GLOBAL-DEFINE CONDICION       CAN-DO(Lista_precios.lista_empresas,que_empresa) AND
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la Lista de precios o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Listas de precios
&GLOBAL-DEFINE PROCESO         ACBRWLIS
&GLOBAL-DEFINE ULT_REGISTRO    ult_lista

{SELBROWS.I}
