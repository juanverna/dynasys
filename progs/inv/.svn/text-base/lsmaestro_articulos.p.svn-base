/*====================================================================================*/
/*                   GENERA EL LISTADO DEL MAESTRO DE ARTICULOS                       */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por    AS   INTEGER.

/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "Maestro de Artículos" AT 48
    "Página:" AT 147 PAGE-NUMBER FORMAT "9999" AT 155
    SKIP
    fecha_lis
    titulo_det AT 48
    hora_lis AT 147
    SKIP(1)
    WITH WIDTH 160 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
    Articulo.cdg_articulo              COLUMN-LABEL "Código!Artículo"
    Articulo.descripcion               COLUMN-LABEL "Descripción!Artículo"
    Articulo.cdg_subclase              COLUMN-LABEL "Calsificación!Artículo" 
    Articulo.cdg_tipoart               COLUMN-LABEL "Código!Tipo"
    Familia_articulo.cdg_familia       COLUMN-LABEL "Familia!Contable" 
    Articulo.cdg_ucompra               COLUMN-LABEL "Unidad!Compra"      FORMAT "X(5)"
    Articulo.cdg_ugranel               COLUMN-LABEL "Unidad!Granel"      FORMAT "X(5)"
    Articulo.cdg_umed                  COLUMN-LABEL "Unidad!Uso"         FORMAT "X(5)"
    Articulo.es_registrable            COLUMN-LABEL "Regis-!trable"      FORMAT "Si/No"
    Articulo.extendida                 COLUMN-LABEL "Exten-!dida"        FORMAT "Si/No"
    Articulo.hay_partida               COLUMN-LABEL "Par-!tida"          FORMAT "Si/No"
    Articulo.stock_sino                COLUMN-LABEL "Stock!SiNo"         FORMAT "Si/No"
    WITH WIDTH 160 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  titulo_det = "Ordenado por: " + IF ver_por = 1 THEN "código" ELSE "descripción".

  {dirprinfile.i}
  
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo NO-LOCK 
                       WHERE Articulo.cdg_articulo >= des_codart
                         AND Articulo.cdg_articulo <= has_codart
                         AND Articulo.stock_sino
                          BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo NO-LOCK
                       WHERE Articulo.descripcion >= des_nomart
                         AND Articulo.descripcion <= has_nomart
                         AND Articulo.stock_sino
                          BY Articulo.descripcion.
  END.

  GET FIRST qry_Articulos.
  DO WHILE AVAILABLE Articulo:

      VIEW FRAME frm-titulo.

      FIND Familia_articulo OF Articulo NO-LOCK.

      DISPLAY
           Articulo.cdg_articulo              
           Articulo.descripcion               
           Articulo.cdg_subclase              
           Articulo.cdg_tipoart               
           Articulo.cdg_ucompra               
           Articulo.cdg_ugranel               
           Articulo.cdg_umed                  
           Articulo.es_registrable            
           Articulo.extendida                 
           Articulo.hay_partida               
           Familia_articulo.cdg_familia       
           Articulo.stock_sino                
           WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.

     GET NEXT qry_Articulos.

  END.

  
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).

END PROCEDURE.

