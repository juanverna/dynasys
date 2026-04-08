DEFINE TEMP-TABLE T-Produccion NO-UNDO
    FIELD nro_articulo LIKE Articulo.nro_articulo
    FIELD cantidad_total AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Cantidad!A Consumir"
    FIELD cantidad_neto  AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Cantidad!A Producir"
    FIELD granel_total   AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Granel!A Consumir"
    FIELD granel_neto    AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Granel!A Producir"
    INDEX por_articulo IS UNIQUE PRIMARY nro_articulo.

DEFINE TEMP-TABLE T-Listado NO-UNDO
    FIELD nro_linea       AS INTEGER
    FIELD que_codigo      LIKE Articulo.cdg_articulo FORMAT "X(30)"
    FIELD que_descripcion LIKE Articulo.descripcion  FORMAT "X(60)"
    FIELD cantidad_total  AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Cantidad!A Consumir"
    FIELD cantidad_neto   AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Cantidad!A Producir"
    FIELD unidad_can      AS CHARACTER FORMAT "X(8)" COLUMN-LABEL "Unidad!Cantidad"
    FIELD coeficiente     AS DECIMAL FORMAT ">>>,>>9.9999" COLUMN-LABEL "Razón!de Consumo"
    FIELD granel_total    AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Granel!A Consumir"
    FIELD granel_neto     AS DECIMAL FORMAT "->>>,>>>,>>9.9999" COLUMN-LABEL "Granel!A Producir"
    FIELD unidad_gra      AS CHARACTER FORMAT "X(8)" COLUMN-LABEL "Unidad!Granel"
    INDEX por_linea       IS UNIQUE PRIMARY nro_linea.
