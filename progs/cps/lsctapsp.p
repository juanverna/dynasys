/*=================================================================================*/
/*                        LISTADO DE TIPOS DE LIQUIDACION                          */
/*=================================================================================*/

&SCOPED-DEFINE TABLA              Ctapsp
&SCOPED-DEFINE CODIGO             cdg_ctapsp
&SCOPED-DEFINE NOMBRE             nombre_cps
&SCOPED-DEFINE TITULO-LST         Detalle de Cuentas de Presupuesto
&SCOPED-DEFINE POS-TITULO         45
&SCOPED-DEFINE POS-PAGINA         102
&SCOPED-DEFINE POS-NROPAG         110
&SCOPED-DEFINE ANCHO-FRAME        160
&SCOPED-DEFINE FRAME-LISTADO       ~
    Ctapsp.cdg_ctapsp              ~
    Ctapsp.nombre_cps              ~
    Ctapsp.cdg_subclase      FORMAT "X(10)"      ~
    Ctapsp.entidades_validas FORMAT "X(10)"      ~
    Ctapsp.fecha_alta              ~
    Ctapsp.fecha_baja              ~
    Ctapsp.grupo_pat VIEW-AS TEXT   ~
    Ctapsp.unidades                ~

&SCOPED-DEFINE ARCHIVO-ID         Ctapsp
&SCOPED-DEFINE CAMPOS-LISTADO       ~
    Ctapsp.cdg_ctapsp              ~
    Ctapsp.nombre_cps              ~
    Ctapsp.cdg_subclase            ~
    Ctapsp.entidades_validas       ~
    Ctapsp.fecha_alta              ~
    Ctapsp.fecha_baja              ~
    Ctapsp.grupo_pat               ~
    Ctapsp.unidades
           
{LSTABLAS.I}           
