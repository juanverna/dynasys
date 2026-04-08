/*=================================================================================*/
/*                        LISTADO DE TIPOS DE LIQUIDACION                          */
/*=================================================================================*/

&SCOPED-DEFINE ARCHIVO-ID         grufra
&SCOPED-DEFINE TABLA              Grupo_francos
&SCOPED-DEFINE CODIGO             cdg_franco
&SCOPED-DEFINE NOMBRE             dsc_franco
&SCOPED-DEFINE TITULO-LST         Detalle de Grupos de Franco
&SCOPED-DEFINE POS-TITULO         30
&SCOPED-DEFINE POS-PAGINA         69
&SCOPED-DEFINE POS-NROPAG         77
&SCOPED-DEFINE ANCHO-FRAME        80
&SCOPED-DEFINE FRAME-LISTADO       ~
      Grupo_francos.cdg_franco ~
      Grupo_francos.dsc_franco

&SCOPED-DEFINE CAMPOS-LISTADO       ~
      Grupo_francos.cdg_franco ~
      Grupo_francos.dsc_franco
           
{LSTABLAS.I}           
