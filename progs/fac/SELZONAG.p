/*=============================================================================*/
/*                    SELECCION DE ZONAS GEOGRAFICAS                           */
/*=============================================================================*/

&GLOBAL-DEFINE TABLA           Zona_geografica
&GLOBAL-DEFINE CODIGO          cdg_zonag 
&GLOBAL-DEFINE NOMBRE          nombre
&GLOBAL-DEFINE FORMATO-CODIGO  FORMAT "X(15)" 
&GLOBAL-DEFINE TITULO-BROWSE   Seleccione la zona geografica
&GLOBAL-DEFINE TITULO-FRAME    Seleccion de zonas geograficas
&GLOBAL-DEFINE PROCESO         ACBRWZGF
&GLOBAL-DEFINE ULT_REGISTRO    ult_zona

{SELBROWS.I}



