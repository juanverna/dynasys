/*================================================================================*/
/*                        SELECCION DE BIENES DE USO                              */
/*================================================================================*/

&GLOBAL-DEFINE TABLA           Bduso
&GLOBAL-DEFINE CODIGO          num_inventario
&GLOBAL-DEFINE NOMBRE          dsc_bduso
&GLOBAL-DEFINE CONDICION       Bduso.cdg_empresa = Empresa.cdg_empresa
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el Bien de Uso
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Bienes de Uso
&GLOBAL-DEFINE PROCESO         ACTBDUSO
&GLOBAL-DEFINE ULT_REGISTRO    ult_bduso

{SELBROWS.I}
