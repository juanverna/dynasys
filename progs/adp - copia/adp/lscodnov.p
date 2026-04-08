/*=================================================================================*/
/*                        LISTADO DE TIPOS DE LIQUIDACION                          */
/*=================================================================================*/

&SCOPED-DEFINE ARCHIVO-ID         codnov
&SCOPED-DEFINE TABLA              Novedad   
&SCOPED-DEFINE CODIGO             cdg_novedad
&SCOPED-DEFINE NOMBRE             descripcion
&SCOPED-DEFINE TITULO-LST         Detalle de C¢digos de Novedad
&SCOPED-DEFINE POS-TITULO         30
&SCOPED-DEFINE POS-PAGINA         69
&SCOPED-DEFINE POS-NROPAG         77
&SCOPED-DEFINE ANCHO-FRAME        80
&SCOPED-DEFINE FRAME-LISTADO       ~
  Novedad.cdg_novedad ~
  Novedad.descripcion ~
  Novedad.abreviatura ~
  Novedad.afecta_salario ~
  Novedad.cdg_estado_nov ~
  Novedad.unidad         ~
  Novedad.valor_defecto  ~        

&SCOPED-DEFINE CAMPOS-LISTADO       ~
  Novedad.cdg_novedad ~
  Novedad.descripcion ~
  Novedad.abreviatura ~
  Novedad.afecta_salario ~
  Novedad.cdg_estado_nov ~
  Novedad.unidad         ~
  Novedad.valor_defecto  ~        

{LSTABLAS.I}           
