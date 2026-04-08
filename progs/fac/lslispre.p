/*====================================================================================*/
/*                Genera el listado de listas de precios                              */
/*====================================================================================*/

DEFINE INPUT PARAMETER p-lista        AS   ROWID.
DEFINE INPUT PARAMETER ir_a           AS   CHARACTER.
DEFINE INPUT PARAMETER ver_por        AS   INTEGER.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE p_codigo              AS   INTEGER INITIAL 0.
DEFINE VARIABLE p_nombre              AS   INTEGER INITIAL 1.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

DEFINE BUFFER B-Partida FOR Partida.
DEFINE QUERY qry_movimiento   FOR Cct_stock, B-Partida.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Lista de Precios por Artículo" AT 30
  "Página:" AT 73 PAGE-NUMBER FORMAT ">9" AT 80
  SKIP
  fecha_lis
  titulo_det AT 30
  hora_lis AT 73
  SKIP(1)
  "---------------------------------------------------------------------------------" SKIP
  "Código     Descripción                          Unidad        Precio       Precio" SKIP
  "Artículo   Artículo                              Venta      Unitario   Cons.Final" SKIP
  "---------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       Articulo.cdg_articulo
       Articulo.descripcion
       Unidad.abrevia
       Articulo_precio.precio
       Articulo_precio.precio_cf
       WITH WIDTH 96 DOWN FRAME frm-listado USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.

/*=================================================================================*/
/*                                   PROCEDIMIENTOS                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

  FIND Lista_precios WHERE ROWID(Lista_precios) = p-lista NO-LOCK.

  titulo_det = "Lista:" + STRING(Lista_precio.cdg_lista,">>>9") + "-" + Lista_precios.descripcion.

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

  OUTPUT TO VALUE(dire_tmp + "lslispre.txt") PAGED.

  RUN PONE_CODIGO ( INPUT "CARTA").

  CASE ver_por:
    WHEN p_codigo
    THEN DO:                  
        OPEN QUERY qry_precios
             FOR EACH Articulo_precio OF Lista_precio
                WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa,
                FIRST Articulo OF Articulo_precio WHERE Articulo.cdg_articulo >= ir_a
                   BY Articulo.cdg_articulo.
    END.
    WHEN p_nombre
    THEN DO:
        OPEN QUERY qry_precios
             FOR EACH Articulo_precio OF Lista_precio
                WHERE Articulo_precio.cdg_empresa = Empresa.cdg_empresa,
                FIRST Articulo OF Articulo_precio WHERE Articulo.descripcion >= ir_a
                   BY Articulo.descripcion.
    END.
  END CASE.

  GET FIRST qry_precios.
  DO WHILE AVAILABLE Articulo:
     VIEW FRAME frm-titulo.
     FIND Unidad OF Articulo NO-LOCK.
     DISPLAY
          Articulo.cdg_articulo
          Articulo.descripcion
          Unidad.abrevia
          Articulo_precio.precio
          Articulo_precio.precio_cf
          WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.
     GET NEXT qry_precios.
  END.

  UNDERLINE
       Articulo.cdg_articulo
       Articulo.descripcion
       Unidad.abrevia
       Articulo_precio.precio
       Articulo_precio.precio_cf
       WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT dire_tmp + "lslispre.txt",
                   INPUT 8 ).

END PROCEDURE.

{CODIMPRE.I}
