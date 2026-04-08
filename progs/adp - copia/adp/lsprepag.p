/*=================================================================================*/
/*                        LISTADO DE TIPOS DE LIQUIDACION                          */
/*=================================================================================*/

&SCOPED-DEFINE ARCHIVO-ID         prepag
&SCOPED-DEFINE TABLA              Prepaga   
&SCOPED-DEFINE CODIGO             cdg_prepaga
&SCOPED-DEFINE NOMBRE             nombre
&SCOPED-DEFINE TITULO-LST         Detalle de Prepagas
&SCOPED-DEFINE POS-TITULO         40
&SCOPED-DEFINE POS-PAGINA         85
&SCOPED-DEFINE POS-NROPAG         93
&SCOPED-DEFINE ANCHO-FRAME        96
&SCOPED-DEFINE FRAME-LISTADO       ~
      Prepaga.cdg_prepaga ~
      Prepaga.nombre  ~
      Prepaga.cdg_concepto_empl ~
      Prepaga.cdg_concepto_adic ~
      Prepaga.nro_afiliacion    ~
      Prepaga.porc_contribucion 

&SCOPED-DEFINE CAMPOS-LISTADO       ~
      Prepaga.cdg_prepaga ~
      Prepaga.nombre  ~
      Prepaga.cdg_concepto_empl ~
      Prepaga.cdg_concepto_adic ~
      Prepaga.nro_afiliacion    ~
      Prepaga.porc_contribucion 

{LSTABLAS.I}           
