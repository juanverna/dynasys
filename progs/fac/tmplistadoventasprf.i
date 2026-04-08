DEFINE TEMP-TABLE T-Listado NO-UNDO
    FIELD cdg_puntovta      AS INTEGER FORMAT "9999" COLUMN-LABEL "Punto!Venta"
    FIELD que_padre         AS CHARACTER FORMAT "X(30)" COLUMN-LABEL "Código!Clasificación"
    FIELD que_codigo        AS CHARACTER FORMAT "X(30)" COLUMN-LABEL "Código!Clasificación"
    FIELD que_nombre        AS CHARACTER FORMAT "X(50)" COLUMN-LABEL "Denominación!Clasificación"
    FIELD l-nivel           AS INTEGER  
    FIELD l-tot_cantidad    LIKE Cct_stock.cantidad COLUMN-LABEL "Total!Cantidad"
    FIELD l-cdg_umed        LIKE Articulo.cdg_umed COLUMN-LABEL "Unidad!Cantidad"
    FIELD l-tot_granel      LIKE Cct_stock.granel   COLUMN-LABEL "Total!Granel"
    FIELD l-cdg_ugranel     LIKE Articulo.cdg_ugranel COLUMN-LABEL "Unidad!Granel"
    FIELD l-tot_importe     AS DECIMAL FORMAT "->>>,>>>,>>9.99" COLUMN-LABEL "Total!Importe"
    FIELD linea             AS INTEGER 
    FIELD l-visible         AS LOGICAL 
    INDEX por_linea IS UNIQUE PRIMARY linea.
