/*====================================================================================*/
/*                     LISTADO DE EMPLEADOS POR CATEGORIA                             */
/*====================================================================================*/

&GLOBAL-DEFINE TITULO              Empleados por Categoria
&GLOBAL-DEFINE ANCHO-LST           80
&GLOBAL-DEFINE LIN-PAGINA          72
&GLOBAL-DEFINE POS_TIT             30
&GLOBAL-DEFINE POS_PAG             70
&GLOBAL-DEFINE POS_NPAG            77
&GLOBAL-DEFINE ARCHIVO-SALIDA      lsremcat
&GLOBAL-DEFINE TABLA-EXTERNA       Categoria
&GLOBAL-DEFINE CDG_EXTERNA         cdg_categoria
&GLOBAL-DEFINE POR-TABLA           cdg_categoria
&GLOBAL-DEFINE NOM_EXTERNA         descripcion
&GLOBAL-DEFINE CAMPOS-DSP ~
               Categoria.cdg_categoria WHEN Empleado.cdg_categoria <> ant_tabla ~
               Categoria.descripcion   WHEN Empleado.cdg_categoria <> ant_tabla ~
               Empleado.nro_legajo ~
               Empleado.nombre
               
&GLOBAL-DEFINE CAMPOS  ~
               Categoria.cdg_categoria ~
               Categoria.descripcion   ~
               Empleado.nro_legajo ~
               Empleado.nombre


{LSRNKEMP.I}