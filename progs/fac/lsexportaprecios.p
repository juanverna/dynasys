/*=================================================================================*/
/*    EXPORTA LOS VALORES DE LAS LISTAS DE PRECIO DE UN CONJUNTO DE ARTICULOS      */
/*=================================================================================*/

DEFINE VARIABLE v-cdg_empresa          LIKE Empresa.cdg_empresa FORMAT "X(40)".
DEFINE VARIABLE v-des_codigo           LIKE Articulo.cdg_articulo FORMAT "X(40)".
DEFINE VARIABLE v-has_codigo           LIKE Articulo.cdg_articulo FORMAT "X(40)".
DEFINE VARIABLE v-codigos_listas       AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE v-archivo_salida       AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE j                      AS INTEGER.
DEFINE VARIABLE n-items                AS INTEGER.

DEFINE TEMP-TABLE Precios
       FIELD cdg_articulo              LIKE Articulo.cdg_articulo
       FIELD dsc_articulo              LIKE Articulo.descripcion
       FIELD n-columna                 AS INTEGER
       FIELD precio                    LIKE Articulo_precio.precio FORMAT ">>>>>9.99"
       INDEX por_articulo 
             IS PRIMARY UNIQUE cdg_articulo n-columna.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

SESSION:NUMERIC-FORMAT = "AMERICAN".

UPDATE SKIP(1)
       v-cdg_empresa    COLON 20 LABEL "Empresa"
       v-des_codigo     COLON 20 LABEL "Desde Artículo"
       v-has_codigo     COLON 20 LABEL "Hasta Artículo"
       v-codigos_listas COLON 20 LABEL "Listas"
       v-archivo_salida COLON 20 LABEL "Archivo Salida" SPACE(5)
       SKIP(1)
       WITH FRAME f-rango SIDE-LABELS THREE-D VIEW-AS DIALOG-BOX 
            TITLE "Ingrese los datos de la exportación".

n-items = NUM-ENTRIES(v-codigos_listas,",").
FOR EACH Articulo WHERE Articulo.cdg_articulo <= v-has_codigo
                    AND Articulo.cdg_articulo >= v-des_codigo:
    
    DO j = 1 TO n-items:
       CREATE Precios.
       ASSIGN Precios.cdg_articulo = Articulo.cdg_articulo
              Precios.dsc_articulo = Articulo.descripcion
              Precios.n-columna    = j.
       FIND FIRST Articulo_precio OF Articulo
            WHERE Articulo_precio.cdg_empresa = v-cdg_empresa 
              AND Articulo_precio.cdg_lista   = INTEGER(ENTRY(j,v-codigos_listas,","))
                  NO-ERROR.
       IF AVAILABLE Articulo_precio
          THEN Precios.precio = Articulo_precio.precio.              
    END.                
END.    

OUTPUT TO VALUE(v-archivo_salida) PAGE-SIZE 0.
FOR EACH Precios BREAK BY Precios.cdg_articulo BY Precios.n-columna:

    IF FIRST-OF(Precios.cdg_articulo)
    THEN DO:
         PUT Precios.cdg_articulo "," Precios.dsc_articulo ",".
    END.

    PUT Precios.precio.

    IF LAST-OF(Precios.cdg_articulo)
    THEN DO:
         PUT SKIP.
    END.     
    ELSE DO:
         PUT ",".
    END.

END.
OUTPUT CLOSE.    
    
