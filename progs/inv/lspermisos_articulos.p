/*====================================================================================*/
/*             CAMBIA MASIVAMENTE LOS PERMISOS DE UN GRUPO DE ARTÍCULOS               */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER p-sector   LIKE Area.cdg_area.
DEFINE INPUT PARAMETER p-accion   AS CHARACTER. /* "Agregar", "Eliminar","Negar","Conceder","Listar"*/ 

/*====================================================================================*/
/*                                 VARIABLES Y FRAMES                                 */
/*====================================================================================*/

/*
{VRSHARED.I}
{VPERSINM.I}
*/
{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".

DEFINE BUFFER B-Partida FOR Partida.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "Detalle de Permisos por Artículo" AT 50
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
    Articulo.lista_sectores          COLUMN-LABEL "Permisos!Articulo" FORMAT "X(60)"
    WITH WIDTH 220 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  FOR EACH Articulo WHERE Articulo.cdg_articulo >= des_codart
                      AND Articulo.cdg_articulo <= has_codart
                       BY Articulo.cdg_articulo:

     VIEW FRAME frm-titulo.
     
     IF NOT p-accion = "Listar" THEN RUN actualizar_permisos.

     DISPLAY
            Articulo.cdg_articulo     
            Articulo.descripcion     
            Articulo.lista_sectores
            WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.
     

  END.

  UNDERLINE
        Articulo.cdg_articulo     
        Articulo.descripcion      
        Articulo.lista_sectores
        WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.

  OUTPUT CLOSE.
  RUN VERESULT.W ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

PROCEDURE actualizar_permisos:

    DEFINE VARIABLE v-lista_sectores AS CHARACTER.

    RUN tratar_lista_permisos.p ( INPUT Articulo.lista_sectores, OUTPUT v-lista_sectores, INPUT "SEPARAR" ).

    CASE p-accion:
        WHEN "Agregar"
        THEN DO:
            v-lista_sectores = p-sector + "," + v-lista_sectores.
        END.
        WHEN "Eliminar"
        THEN DO:
        END.
        WHEN "Negar"
        THEN DO:
        END.
        WHEN "Conceder"
        THEN DO:
        END.
    END CASE.

    IF SUBSTRING(v-lista_sectores,1,1) = ","
        THEN v-lista_sectores = SUBSTRING(v-lista_sectores,2).

    RUN tratar_lista_permisos.p ( INPUT v-lista_sectores, OUTPUT Articulo.lista_sectores, INPUT "UNIR" ).

END PROCEDURE.
