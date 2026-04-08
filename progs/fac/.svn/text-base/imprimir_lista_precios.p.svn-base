/*==========================================================================*/
/*                    IMPRESION DE LISTAS DE PRECIOS                        */
/*==========================================================================*/
  
DEFINE INPUT PARAMETER que_lista    LIKE Lista_precios.cdg_lista.
DEFINE INPUT PARAMETER que_vigencia LIKE Vigencia_precios.fch_desde.

/*=================================================================================*/
/*                            VARIABLES Y FRAMES                                   */
/*=================================================================================*/

{parlocales.i}
{dfvarimp.i}

{WGLISTAR.I}

DEFINE VARIABLE tit_lista LIKE Lista_precios.descripcion FORMAT "X(60)".

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Lista de precios a una fecha dada" AT 38
  "Página:" AT 106 PAGE-NUMBER FORMAT ">>9" AT 113
  SKIP  
  fecha_lis
  tit_lista AT 38
  hora_lis AT 106
  SKIP(1)
  WITH WIDTH 190 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  SPACE(20)
  Articulo.cdg_articulo
  SPACE(2)
  Articulo.descripcion
  SPACE(2)
  Unidad.abrevia COLUMN-LABEL "Unidad de!Medida"
  SPACE(2)
  Articulo_precio.precio
  WITH WIDTH 190 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Lista_precios WHERE Lista_precios.cdg_lista = que_lista NO-LOCK.
  tit_lista = STRING(Lista_precios.cdg_lista,"9999") + " - " + Lista_precios.descripcion + " - rige:" + STRING(que_vigencia,"99/99/9999").

  {findempresa.i}
  que_empresa = Empresa.nombre.
  {dirprinfile.i} 

  FOR EACH Articulo WHERE Articulo.cdg_estado <> "B", FIRST Unidad OF Articulo, 
      EACH Articulo_precio OF Articulo  WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa
                                         AND Articulo_precio.cdg_lista   = Lista_precio.cdg_lista
                                         AND Articulo_precio.fch_desde   = que_vigencia :

      VIEW FRAME frm-titulo.

      DISPLAY 
          Articulo.cdg_articulo
          Articulo.descripcion
          Unidad.abrevia
          Articulo_precio.precio
          WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE
