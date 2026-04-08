/*===================================================================================*/
/*                   MUESTRA LAS NOVEDADES DE UNA REQUISICION                        */
/*===================================================================================*/

&GLOBAL-DEFINE TITULO_WIN       Novedades de Item de Requisiciones
&GLOBAL-DEFINE FRAME-MAIN       frm-novedades
&GLOBAL-DEFINE ACT_MASTER       act_rqs_detl
&GLOBAL-DEFINE TABLA-BRW        Hst_requisicion
&GLOBAL-DEFINE TABLA-MASTER     Rqs_detalle
&GLOBAL-DEFINE BROWSE           brw_novedades
&GLOBAL-DEFINE TITULO_BRW       Novedades registradas
&GLOBAL-DEFINE TABLAS_QUERY     Hst_requisicion, Estado_pedido, Usuario
&GLOBAL-DEFINE CAMPOS_BRW       Hst_requisicion.fch_cambio ~
                                Hst_requisicion.hms_cambio ~
                                Hst_requisicion.cdg_estado ~
                                Usuario.nombre COLUMN-LABEL "Nombre!Usuario" FORMAT "X(20)" ~
                                Hst_requisicion.observacion FORMAT "X(35)"
&GLOBAL-DEFINE QRY_BROWSE       qry_novedades
&GLOBAL-DEFINE QRY_CONDICION    ~
             Hst_requisicion OF Rqs_detalle, ~
              FIRST Estado_pedido OF Hst_requisicion, FIRST Usuario OF Hst_requisicion  

{SHOWNODT.I}
