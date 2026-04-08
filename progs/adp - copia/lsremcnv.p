/*====================================================================================*/
/*                     LISTADO DE EMPLEADOS POR CONVENIO                              */
/*====================================================================================*/

&GLOBAL-DEFINE TITULO              Empleados por Convenio
&GLOBAL-DEFINE ANCHO-LST           96
&GLOBAL-DEFINE LIN-PAGINA          72
&GLOBAL-DEFINE POS_TIT             30
&GLOBAL-DEFINE POS_PAG             70
&GLOBAL-DEFINE POS_NPAG            77
&GLOBAL-DEFINE ARCHIVO-SALIDA      lsremcnv
&GLOBAL-DEFINE TABLA-EXTERNA       Convenio
&GLOBAL-DEFINE CDG_EXTERNA         cdg_convenio
&GLOBAL-DEFINE POR-TABLA           cdg_convenio
&GLOBAL-DEFINE NOM_EXTERNA         descripcion
&GLOBAL-DEFINE CAMPOS-DSP ~
               Convenio.cdg_convenio WHEN Empleado.cdg_convenio <> ant_tabla ~
               Convenio.descripcion   WHEN Empleado.cdg_convenio <> ant_tabla ~
               Empleado.nro_legajo ~
               Empleado.nombre
               
&GLOBAL-DEFINE CAMPOS  ~
               Convenio.cdg_convenio ~
               Convenio.descripcion   ~
               Empleado.nro_legajo ~
               Empleado.nombre


{LSRNKEMP.I}
