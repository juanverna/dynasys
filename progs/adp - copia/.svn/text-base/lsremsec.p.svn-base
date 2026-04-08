/*====================================================================================*/
/*                     LISTADO DE EMPLEADOS POR Secci¢n                             */
/*====================================================================================*/

&GLOBAL-DEFINE TITULO              Empleados por Secci¢n
&GLOBAL-DEFINE ANCHO-LST           96
&GLOBAL-DEFINE LIN-PAGINA          72
&GLOBAL-DEFINE POS_TIT             30
&GLOBAL-DEFINE POS_PAG             70
&GLOBAL-DEFINE POS_NPAG            77
&GLOBAL-DEFINE ARCHIVO-SALIDA      lsremsec
&GLOBAL-DEFINE TABLA-EXTERNA       Seccion
&GLOBAL-DEFINE CDG_EXTERNA         cdg_seccion
&GLOBAL-DEFINE POR-TABLA           cdg_seccion
&GLOBAL-DEFINE NOM_EXTERNA         denominacion
&GLOBAL-DEFINE CAMPOS-DSP ~
               Seccion.cdg_seccion WHEN Empleado.cdg_seccion <> ant_tabla ~
               Seccion.denominacion   WHEN Empleado.cdg_seccion <> ant_tabla ~
               Empleado.nro_legajo ~
               Empleado.nombre
               
&GLOBAL-DEFINE CAMPOS  ~
               Seccion.cdg_seccion ~
               Seccion.denominacion   ~
               Empleado.nro_legajo ~
               Empleado.nombre


{LSRNKEMP.I}