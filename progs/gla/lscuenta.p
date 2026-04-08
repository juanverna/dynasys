/*=================================================================================*/
/*                        LISTADO DE CUENTAS CONTABLES                             */
/*=================================================================================*/

&SCOPED-DEFINE TABLA              Cuenta
&SCOPED-DEFINE CODIGO             cdg_cuenta
&SCOPED-DEFINE NOMBRE             nombre_cta
&SCOPED-DEFINE TITULO-LST         Detalle de Cuentas Contables
&SCOPED-DEFINE POS-TITULO         45
&SCOPED-DEFINE POS-PAGINA         102
&SCOPED-DEFINE POS-NROPAG         110
&SCOPED-DEFINE ANCHO-FRAME        160
&SCOPED-DEFINE FRAME-LISTADO       ~
    Cuenta.cdg_cuenta              ~
    Cuenta.nombre_cta              ~
    Cuenta.cta_cte                 ~
    Cuenta.entidades_validas FORMAT "X(10)"      ~
    Cuenta.fecha_alta              ~
    Cuenta.fecha_baja              ~
    Cuenta.grupo_pat VIEW-AS TEXT   ~
    Cuenta.ajuste                  ~
    Cuenta.unidades                ~

&SCOPED-DEFINE ARCHIVO-ID         cuenta
&SCOPED-DEFINE CAMPOS-LISTADO       ~
    Cuenta.cdg_cuenta              ~
    Cuenta.nombre_cta              ~
    Cuenta.cta_cte                 ~
    Cuenta.entidades_validas       ~
    Cuenta.fecha_alta              ~
    Cuenta.fecha_baja              ~
    Cuenta.grupo_pat               ~
    Cuenta.ajuste                  ~
    Cuenta.unidades
           
{LSTABLAS.I}           
