/*====================================================================================*/
/*                LISTADO DE ARTÍCULOS CON SU IMPUTACION CONTABLE                     */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por    AS   INTEGER.

/*====================================================================================*/
/*                                 VARIABLES Y FRAMES                                 */
/*====================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".

DEFINE BUFFER B-Partida FOR Partida.

DEFINE BUFFER Imp-ajuste      FOR Cuenta.
DEFINE BUFFER Imp-variac      FOR Cuenta.
DEFINE BUFFER Imp-costo       FOR Cuenta.
DEFINE BUFFER Imp-consumo     FOR Cuenta.
DEFINE BUFFER Imp-pendte      FOR Cuenta.
DEFINE BUFFER Imp-existencia  FOR Cuenta.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "Detalle de Artículos con su Imputación Contable" AT 50
    "Página:" AT 156 PAGE-NUMBER FORMAT ">>>9" AT 164
    SKIP
    fecha_lis
    titulo_det AT 50
    hora_lis AT 156
    SKIP(1)
    WITH WIDTH 220 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo            COLUMN-LABEL "Código!Artículo"
    Articulo.descripcion             COLUMN-LABEL "Descripción!Artículo"
    Familia_articulo.cdg_familia     COLUMN-LABEL "Familia!Contable"
    Familia_articulo.dsc_familia     COLUMN-LABEL "Descripción!Familia"
    Imp-ajuste.cdg_cuenta            COLUMN-LABEL "Ajuste!Inventario"
    Imp-variac.cdg_cuenta            COLUMN-LABEL "Variación!Costos"
    Imp-costo.cdg_cuenta             COLUMN-LABEL "Costo!Ventas"
    Imp-consumo.cdg_cuenta           COLUMN-LABEL "Consumo!Producción"
    Imp-pendte.cdg_cuenta            COLUMN-LABEL "Facturas!A Recibir"
    Imp-existencia.cdg_cuenta        COLUMN-LABEL "Existencia!Productos"
    WITH WIDTH 220 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.cdg_articulo >= des_codart
                         AND Articulo.cdg_articulo <= has_codart,
                         FIRST Familia_articulo OF Articulo
                          BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.descripcion >= des_nomart
                         AND Articulo.descripcion <= has_nomart,
                         FIRST Familia_articulo OF Articulo
                          BY Articulo.descripcion.
  END.

  GET FIRST qry_Articulos.
  DO WHILE AVAILABLE Articulo:

     VIEW FRAME frm-titulo.

     FIND Imp-ajuste     WHERE Imp-ajuste.nro_cuenta     = Familia_articulo.nro_cuenta_ajuste      NO-LOCK.
     FIND Imp-consumo    WHERE Imp-consumo.nro_cuenta    = Familia_articulo.nro_cuenta_consumo     NO-LOCK.
     FIND Imp-costo      WHERE Imp-costo.nro_cuenta      = Familia_articulo.nro_cuenta_costo       NO-LOCK.
     FIND Imp-pendte     WHERE Imp-pendte.nro_cuenta     = Familia_articulo.nro_cuenta_pendte      NO-LOCK.
     FIND Imp-existencia WHERE Imp-existencia.nro_cuenta = Familia_articulo.nro_cuenta_existencia  NO-LOCK.
     FIND Imp-variac     WHERE Imp-variac.nro_cuenta     = Familia_articulo.nro_cuenta_variacion   NO-LOCK. 
     
     DISPLAY
            Articulo.cdg_articulo     
            Articulo.descripcion      
            Familia_articulo.cdg_familia        
            Familia_articulo.dsc_familia        
            Imp-ajuste.cdg_cuenta     
            Imp-variac.cdg_cuenta     
            Imp-costo.cdg_cuenta      
            Imp-consumo.cdg_cuenta    
            Imp-pendte.cdg_cuenta     
            Imp-existencia.cdg_cuenta 
            WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.
     GET NEXT qry_Articulos.

  END.

  UNDERLINE
        Articulo.cdg_articulo     
        Articulo.descripcion      
        Familia_articulo.cdg_familia        
        Familia_articulo.dsc_familia        
        Imp-ajuste.cdg_cuenta     
        Imp-variac.cdg_cuenta     
        Imp-costo.cdg_cuenta      
        Imp-consumo.cdg_cuenta    
        Imp-pendte.cdg_cuenta     
        Imp-existencia.cdg_cuenta 
        WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.

  OUTPUT CLOSE.
  RUN VERESULT.W ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

