/*===========================================================================================*/
/*                                 HELP DE ARTICULO PARA COMPRAS                            */
/*===========================================================================================*/

&GLOBAL-DEFINE TABLA           Articulo  
&GLOBAL-DEFINE CONDICION       CAN-DO(Articulo.lista_empresas,Empresa.cdg_empresa) ~
                               AND Articulo.cdg_articulo <> "" AND Articulo.compras_sino
&GLOBAL-DEFINE CODIGO          cdg_articulo
&GLOBAL-DEFINE FORMATO-CODIGO  "X(20)"
&GLOBAL-DEFINE NOMBRE          descripcion
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el articulo o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de articulos
&GLOBAL-DEFINE PROCESO         ACTARTIC
&GLOBAL-DEFINE ULT_REGISTRO    ult_articulo

{SELBROWS.I}


