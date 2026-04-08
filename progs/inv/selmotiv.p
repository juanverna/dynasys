/*===========================================================================================*/
/*                         HELP DE TIPO DE MOTIVO DE RETIRO                                  */
/*===========================================================================================*/

&GLOBAL-DEFINE TABLA           Motivo_retiro  
/*
&GLOBAL-DEFINE CONDICION       cdg_articulo <> ""
*/
&GLOBAL-DEFINE CODIGO          cdg_motivo_retiro
&GLOBAL-DEFINE NOMBRE          dsc_motivo_retiro 
&GLOBAL-DEFINE OTROS-CAMPOS    con_regreso
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el Motivo o ingrese el Motivo
&GLOBAL-DEFINE TITULO-FRAME    Selección de Motivo
&GLOBAL-DEFINE PROCESO         ACTTPART
&GLOBAL-DEFINE ULT_REGISTRO    ult_tipoart

&GLOBAL-DEFINE NUMERO          cdg_motivo_retiro
{SELBROWS.I}
