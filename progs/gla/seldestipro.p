/*======================================================================================*/
/*                          Seleccion de destinatario del retiro                        */
/*======================================================================================*/

&GLOBAL-DEFINE TABLA           Destinatario
&GLOBAL-DEFINE CODIGO          cdg_destinatario
&GLOBAL-DEFINE NOMBRE          dsc_destinatario
&GLOBAL-DEFINE CONDICION       Destinatario.hab_proveedor = YES and
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el Destinatario o ingrese nombre
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Destinatario
&GLOBAL-DEFINE PROCESO         ACTSECTR
&GLOBAL-DEFINE ULT_REGISTRO    ult_area

{SELBROWS.I}

