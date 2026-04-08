
/*--------------------- Tratamiendo del browse de Domicilios-------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     NO
&SCOPED-DEFINE BROWSE           brw_precio
&SCOPED-DEFINE ACT_REGBROWSE    act_precio
&SCOPED-DEFINE ULT_REGBROWSE    ult_precio
&SCOPED-DEFINE TABLA-BRW        Articulo_precio
&SCOPED-DEFINE TABLA-MASTER     Articulo
&SCOPED-DEFINE ACTREGIS         ACTPRECI
&SCOPED-DEFINE BOTON            btn_precio 
&SCOPED-DEFINE QRY_BROWSE       qry_precio 
&SCOPED-DEFINE QRY_CONDICION    Articulo_precio OF Articulo, EACH Lista_precio OF Articulo_precio
&SCOPED-DEFINE MENSAJE-VACIO    NO hay precios asignados al articulo
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este precio?

{TRGBROWS.I}


/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Articulo


        /* -------------------- Imputacion contable ------------*/

&SCOPED-DEFINE TABLA            Cuenta
&SCOPED-DEFINE CODIGO-TAB       cdg_cuenta
&SCOPED-DEFINE CODIGO-ENT       cdg_cuenta
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELCUENT
&SCOPED-DEFINE FRAME-INGRESO    frm-articulo
&SCOPED-DEFINE ROWID-TABLA      act_cuenta
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTCUENT
&SCOPED-DEFINE ULT_REGISTRO     ult_cuenta
&SCOPED-DEFINE ALT-MOD          YES

{TRIGHELP.I} 


