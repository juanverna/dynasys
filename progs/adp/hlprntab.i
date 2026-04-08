/*================================= HELPS DEL RANGO =================================*/

&SCOPED-DEFINE VACIO           0

&SCOPED-DEFINE FRAME-INGRESO   frm-rango
&SCOPED-DEFINE EVENTO          U8
&SCOPED-DEFINE TABLA           Empleado
&SCOPED-DEFINE CODIGO          nro_legajo
&SCOPED-DEFINE NOMBRE          nombre
&SCOPED-DEFINE VAR-CODIGO      des_legajo
&SCOPED-DEFINE VAR-NOMBRE      des_nombre
&SCOPED-DEFINE RUTINA          SELEMPLE
&SCOPED-DEFINE ROWID-TABLA     act_empleado
&SCOPED-DEFINE INDICE          por_legajo
&SCOPED-DEFINE ALFABETICO      alfabetico

{TRIGRANG.I}

&SCOPED-DEFINE FRAME-INGRESO   frm-rango
&SCOPED-DEFINE EVENTO          U9
&SCOPED-DEFINE TABLA           Empleado
&SCOPED-DEFINE CODIGO          nro_legajo
&SCOPED-DEFINE NOMBRE          nombre
&SCOPED-DEFINE VAR-CODIGO      has_legajo
&SCOPED-DEFINE VAR-NOMBRE      has_nombre
&SCOPED-DEFINE RUTINA          SELEMPLE
&SCOPED-DEFINE ROWID-TABLA     act_empleado
&SCOPED-DEFINE INDICE          por_legajo
&SCOPED-DEFINE ALFABETICO      alfabetico

{TRIGRANG.I}

