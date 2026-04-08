&GLOBAL-DEFINE TITULO            Datos de Domicilio
&GLOBAL-DEFINE TITULO-FRAME      Domicilios
&GLOBAL-DEFINE TITULO-WINDOW     Reportes de empleados
&GLOBAL-DEFINE ARCHIVO-SALIDA    lsemdomi
&GLOBAL-DEFINE SETEAR-IMPRESORA  RUN PONE_CODIGO ( INPUT "CARTA,SET17CPI" ).
&GLOBAL-DEFINE CAMPOS ~
    Empleado.nro_legajo  ~
    Empleado.nombre      ~
    Empleado.calle ~
    Empleado.numero  ~
    Empleado.piso ~
    Empleado.depto ~
    Empleado.cdg_postal ~
    Empleado.localidad ~
    Empleado.cdg_provincia ~
    Empleado.telefono
    
{LSDATEMP.I}
