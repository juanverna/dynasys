/*=================================================================================*/
/*             GENERA LA INTERFACE DE SUCURSALES PARA VALES DE INVENTARIO          */
/*=================================================================================*/

&SCOPED-DEFINE TABLA-DOCUMENTO      Ajusteinv_hd
&SCOPED-DEFINE NRO_INTERNO          nro_ajustinv
&SCOPED-DEFINE SIGLA-MODULO         INV

&SCOPED-DEFINE EXPORTAR-TABLAS ~
~{exportabla.i "Ajusteinv_hd"      "AJH"~} ~
~{exportabla.i "Ajusteinv_dt"      "AJD"~} ~

{gnintersuc_xxx.i}


