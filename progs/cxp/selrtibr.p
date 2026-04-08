/*========================================================================================*/
/*              SELECCIONA EL TIPO DE REGIMEN DE IMPUESTO A LAS GANANCIAS                 */
/*========================================================================================*/

&GLOBAL-DEFINE TABLA           Tipo_retibr
&GLOBAL-DEFINE CODIGO          cdg_tiporetibr
&GLOBAL-DEFINE NOMBRE          nom_retibr
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione el Tipo de Regimen Ing.Brutos
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de Ingresos Brutos
&GLOBAL-DEFINE PROCESO         ACBRWTAV
&GLOBAL-DEFINE ULT_REGISTRO    ult_tipactiv

{SELBROWS.I}
