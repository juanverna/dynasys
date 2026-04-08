DEFINE TEMP-TABLE T-Listado NO-UNDO
    FIELD nro_linea       AS INTEGER
    FIELD que_codigo      LIKE Articulo.cdg_articulo FORMAT "X(30)"
    FIELD que_descripcion LIKE Articulo.descripcion  FORMAT "X(60)"
    FIELD cantidad_total  AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Cantidad!Compuesto"
    FIELD unidad_can      AS CHARACTER FORMAT "X(8)" COLUMN-LABEL "Unidad!Cantidad"
    FIELD coeficiente     AS DECIMAL FORMAT ">>>,>>9.9999" COLUMN-LABEL "Razón!de Consumo"
    FIELD granel_total    AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Granel!A Consumir"
    FIELD unidad_gra      AS CHARACTER FORMAT "X(8)" COLUMN-LABEL "Unidad!Granel"
    INDEX por_linea       IS UNIQUE PRIMARY nro_linea.

DEFINE TEMP-TABLE T-Articulo NO-UNDO
    FIELD cdg_articulo LIKE Articulo.cdg_articulo
    INDEX por_codigo IS UNIQUE PRIMARY cdg_articulo.
