/*=====================================================================================*/
/*            CARGA MASIVA DE ARTICULOS DE CATALOGO DE ABASTECIMIENTO                  */
/*=====================================================================================*/

DEFINE INPUT  PARAMETER arch_cab  AS CHARACTER.
DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

DEFINE VARIABLE v-sectores AS CHARACTER.

DEFINE VARIABLE linea          AS CHARACTER FORMAT "X(132)".

DEFINE VARIABLE V-GRUPO         AS CHARACTER FORMAT "X(02)".
DEFINE VARIABLE V-ARTICULO      AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-TIPO          AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-CLASIF        AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-DESCRIPCION1  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE V-DESCRIPCION2  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE V-US-CONTENED   AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-US-CANTIDAD   AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-US-UN-MEDIDA  AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UA-CONTENED   AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UA-CANTIDAD   AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-UA-UN-MEDIDA  AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UC-CONTENED   AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-UC-CANTIDAD   AS CHARACTER FORMAT "X(06)".
DEFINE VARIABLE V-UC-UN-MEDIDA  AS CHARACTER FORMAT "X(03)".
DEFINE VARIABLE V-VIGENCIA      AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-INDIC-SUSPEN  AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE V-FEC-HAB-SUSP  AS CHARACTER FORMAT "X(08)".
DEFINE VARIABLE V-FEC-INGR      AS CHARACTER FORMAT "X(08)".

DEFINE VARIABLE V-INDICALMACEN  AS CHARACTER FORMAT "X(01)".

DEFINE VARIABLE X-COD-S         AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE X-COD-A         AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE X-COD-C         AS CHARACTER FORMAT "X(01)".


DEFINE VARIABLE x-alta   AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE x-baja   AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE x-cod    AS CHARACTER.

DEFINE VARIABLE c                         AS INTEGER.
DEFINE VARIABLE n                         AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE na                        AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE ia                        AS INTEGER FORMAT ">>>>>9".
DEFINE VARIABLE v-validacion_codigo       LIKE Tipo_articulo.validacion_codigo.

DEFINE STREAM Errores.

DEFINE TEMP-TABLE T-Articulo LIKE Articulo.
DEFINE TEMP-TABLE T-Partida  LIKE Partida.
DEFINE TEMP-TABLE T-Articulo_atributo LIKE Articulo_atributo
    FIELD nuevo AS LOGICAL.

DEFINE TEMP-TABLE T-Atributo LIKE Atributo
    FIELD nuevo AS LOGICAL.

DEFINE TEMP-TABLE T-Tipo_articulo LIKE Tipo_articulo
    FIELD nuevo AS LOGICAL.

DEFINE TEMP-TABLE T-Unidad LIKE Unidad
    FIELD nuevo AS LOGICAL.

FUNCTION alta_unidades RETURN CHARACTER ( INPUT P-CONTENEDOR AS CHARACTER, 
                                          INPUT P-CANTIDAD   AS CHARACTER,
                                          INPUT P-UN-MEDIDA  AS CHARACTER,
                                          INPUT MODO-UNIDAD  AS CHARACTER ).
    
    P-CANTIDAD = TRIM(STRING(INTEGER(P-CANTIDAD),">>>>>9")).

    FIND T-Unidad WHERE T-Unidad.cdg_umed = TRIM(P-CONTENEDOR + P-CANTIDAD + P-UN-MEDIDA) NO-ERROR.
    IF NOT AVAILABLE T-Unidad 
    THEN DO:
        MESSAGE "No encontrada unidad " P-CONTENEDOR P-CANTIDAD P-UN-MEDIDA "en articulo" V-GRUPO + "-" + V-ARTICULO
            VIEW-AS ALERT-BOX MESSAGE.

        CREATE T-Unidad.
        ASSIGN T-Unidad.cdg_umed         = TRIM(P-CONTENEDOR + P-CANTIDAD + P-UN-MEDIDA)
               T-Unidad.descripcion_unid = "Unidad" + " " + TRIM(P-CONTENEDOR + P-CANTIDAD + P-UN-MEDIDA)
               T-Unidad.tipounidad       = ""
               T-Unidad.nuevo            = YES.
     END.

     RETURN T-Unidad.cdg_umed.


END FUNCTION.

/*=====================================================================================*/
/*                                         PROCESO                                     */
/*=====================================================================================*/ 

RUN levantar_tablas.

INPUT FROM VALUE(arch_cab).

{findempresa.i}

FIND Parametro WHERE Parametro.cdg_empresa = Empresa.cdg_empresa
                 AND Parametro.cdg_parametro = "DFSECTOR"
                     NO-LOCK.

REPEAT:
    PAUSE 0 BEFORE-HIDE.
    n = n + 1.
    IMPORT UNFORMATTED linea. 

    RUN desarmar_registro.

    DISPLAY n

        V-GRUPO
        V-ARTICULO
        V-TIPO
        V-CLASIF
        V-DESCRIPCION1
        V-DESCRIPCION2
        V-US-CONTENED
        V-US-CANTIDAD
        V-US-UN-MEDIDA
        V-UA-CONTENED
        V-UA-CANTIDAD
        V-UA-UN-MEDIDA
        V-UC-CONTENED
        V-UC-CANTIDAD
        V-UC-UN-MEDIDA
        V-VIGENCIA
        V-INDIC-SUSPEN
        V-FEC-HAB-SUSP
        V-FEC-INGR
        V-INDICALMACEN
        Parametro.valor_c LABEL "Sectores" FORMAT "X(160)"

        WITH WIDTH 256 FRAME AA SIDE-LABELS STREAM-IO 1 COLUMN.

    x-alta = DATE(SUBSTRING(V-FEC-HAB-SUSP,7,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,5,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,1,4) ) NO-ERROR.
    IF ERROR-STATUS:ERROR 
        THEN x-alta = ?.

    x-baja = DATE(SUBSTRING(V-FEC-HAB-SUSP,7,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,5,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,1,4) ) NO-ERROR.
    IF ERROR-STATUS:ERROR 
        THEN x-baja = ?.

    x-cod = IF ASC(V-TIPO) < ASC("a") THEN "101" + V-TIPO ELSE "100" + V-TIPO.

    X-COD-S = alta_unidades ( INPUT V-US-CONTENED, INPUT V-US-CANTIDAD, INPUT V-US-UN-MEDIDA, INPUT "S").
    X-COD-A = alta_unidades ( INPUT V-UA-CONTENED, INPUT V-UA-CANTIDAD, INPUT V-UA-UN-MEDIDA, INPUT "A").
    X-COD-C = alta_unidades ( INPUT V-UC-CONTENED, INPUT V-UC-CANTIDAD, INPUT V-UC-UN-MEDIDA, INPUT "C").

    CREATE T-Articulo.

    FIND Articulo WHERE Articulo.cdg_articulo = V-GRUPO + "-" + V-ARTICULO NO-LOCK NO-ERROR.
    IF AVAILABLE Articulo 
        THEN BUFFER-COPY Articulo TO T-Articulo .
    ELSE DO: 
        ASSIGN
            T-Articulo.nro_articulo = NEXT-VALUE(proximo_articulo)
            T-Articulo.fecha_grab   = TODAY
            T-Articulo.hora_grab    = TIME.

        CREATE T-Partida.
        ASSIGN
            T-Partida.nro_partida  = 1
            T-Partida.cdg_partida  = "00000001"
            T-Partida.nro_articulo = T-Articulo.nro_articulo
            T-Partida.cdg_empresa  = "M".

        CREATE T-Articulo_atributo.
        ASSIGN
            T-Articulo_atributo.cdg_atributo        = V-GRUPO
            T-Articulo_atributo.cdg_tipoatributo    = "GRBS"
            T-Articulo_atributo.es_manual           = NO
            T-Articulo_atributo.nro_articulo        = T-Articulo.nro_articulo
            T-Articulo_atributo.nuevo               = YES.

    END.

    ASSIGN T-Articulo.cdg_articulo     = V-GRUPO + "-" + V-ARTICULO 
           T-Articulo.descripcion      = V-DESCRIPCION1 + V-DESCRIPCION2 
           T-Articulo.cdg_estado       = IF V-INDIC-SUSPEN <> "N" THEN "B" ELSE ""
           T-Articulo.fecha_baja       = IF T-Articulo.cdg_estado = "B" THEN x-baja ELSE ?
           T-Articulo.fecha_alta       = x-alta
           T-Articulo.lista_sectores   = Parametro.valor_c                                       
           T-Articulo.lista_empresas   = "M"                                       
           T-Articulo.a_granel         = NO                                         
           T-Articulo.granel_pesado    = V-INDICALMACEN = "S"
           T-Articulo.cdg_umed         = IF T-Articulo.granel_pesado THEN X-COD-A ELSE X-COD-S
           T-Articulo.cdg_ugranel      = IF T-Articulo.granel_pesado THEN X-COD-S ELSE X-COD-A
           T-Articulo.cdg_ucompra      = X-COD-C
           T-Articulo.cdg_tipoart      = x-cod
           T-Articulo.cdg_envases      = "009"
           T-Articulo.cdg_subclase     = ""
           T-Articulo.cdg_marcacom     = "15"
           T-Articulo.compras_sino     = NO
           T-Articulo.costo            = 0
           T-Articulo.dec_precio       = 2
           T-Articulo.hay_marca        = YES
           T-Articulo.hay_partida      = NO
           T-Articulo.inventario_sino  = YES
           T-Articulo.metodo_costeo    = "PP"
           T-Articulo.modo_volumen     = ""
           T-Articulo.nro_familia      = 1001
           T-Articulo.nro_familimpos   = 1
           T-Articulo.produccion_sino  = NO
           T-Articulo.retornable       = ""
           T-Articulo.ult_partida      = 0
           T-Articulo.unidades_sino    = YES
           T-Articulo.ventas_sino      = NO
           T-Articulo.cyorden_sino     = NO.
    
    IF V-US-CONTENED  = V-UA-CONTENED AND
       V-US-CANTIDAD  = V-UA-CANTIDAD AND
       V-US-UN-MEDIDA = V-UA-UN-MEDIDA
        THEN T-Articulo.relacion_granel = 1.
        ELSE T-Articulo.relacion_granel = 
            IF T-Articulo.granel_pesado 
                 THEN DECIMAL(V-UA-CANTIDAD) / DECIMAL(V-US-CANTIDAD)
                 ELSE DECIMAL(V-US-CANTIDAD) / DECIMAL(V-UA-CANTIDAD).
    
    FIND T-Atributo WHERE T-Atributo.cdg_tipoatributo = "GRBS" 
                      AND T-Atributo.cdg_atributo = V-GRUPO NO-ERROR.
    IF NOT AVAILABLE T-Atributo 
    THEN DO:
        CREATE T-Atributo.
        ASSIGN T-Atributo.cdg_tipoatributo = "GRBS" 
               T-Atributo.cdg_atributo     = V-GRUPO           
               T-Atributo.nuevo            = YES.
    END.

    FIND T-Tipo_articulo WHERE T-Tipo_articulo.cdg_tipoart =  x-cod NO-ERROR.
    IF NOT AVAILABLE T-Tipo_articulo 
    THEN DO:
        CREATE T-Tipo_articulo.
        ASSIGN T-Tipo_articulo.cdg_tipoart = x-cod
               T-Tipo_articulo.dsc_tipoart = "Bienes " + x-cod
               T-Tipo_articulo.validacion_codigo = v-validacion_codigo
               T-Tipo_articulo.nuevo       = YES.
    END.
    
    DISPLAY
           n
           T-Articulo.cdg_articulo
           T-Articulo.cdg_tipoart
           T-Articulo.descripcion
           T-Articulo.granel_pesado
           T-Articulo.cdg_tipoart
        WITH FRAME AA SIDE-LABELS STREAM-IO 1 COLUMN.
    
END.

RUN bajar_articulos.
RUN bajar_atributos.
RUN bajar_tipo_articulos.
RUN bajar_unidades.

/*=====================================================================================*/
/*                             PROCEDIMIENTOS                                          */
/*=====================================================================================*/ 

PROCEDURE desarmar_registro:

    c = 1.
    V-GRUPO         = SUBSTRING(linea,c,02). c = c +  2.
    V-ARTICULO      = SUBSTRING(linea,c,06). c = c +  6.
    V-TIPO          = SUBSTRING(linea,c,01). c = c +  1.
    V-CLASIF        = SUBSTRING(linea,c,01). c = c +  1.
    V-DESCRIPCION1  = SUBSTRING(linea,c,40). c = c + 40.
    V-DESCRIPCION2  = SUBSTRING(linea,c,40). c = c + 40.
    V-US-CONTENED   = SUBSTRING(linea,c,03). c = c +  3.
    V-US-CANTIDAD   = SUBSTRING(linea,c,06). c = c +  6.
    V-US-UN-MEDIDA  = SUBSTRING(linea,c,03). c = c +  3.
    V-UA-CONTENED   = SUBSTRING(linea,c,03). c = c +  3.
    V-UA-CANTIDAD   = SUBSTRING(linea,c,06). c = c +  6.
    V-UA-UN-MEDIDA  = SUBSTRING(linea,c,03). c = c +  3.
    V-UC-CONTENED   = SUBSTRING(linea,c,03). c = c +  3.
    V-UC-CANTIDAD   = SUBSTRING(linea,c,06). c = c +  6.
    V-UC-UN-MEDIDA  = SUBSTRING(linea,c,03). c = c +  3.
    V-VIGENCIA      = SUBSTRING(linea,c,01). c = c +  1.
    V-INDIC-SUSPEN  = SUBSTRING(linea,c,01). c = c +  9.
    V-FEC-HAB-SUSP  = SUBSTRING(linea,c,08). c = c +  8.
    V-FEC-INGR      = SUBSTRING(linea,c,08). c = c +  8.
    V-INDICALMACEN  = SUBSTRING(linea,c,01). c = c +  1.

END PROCEDURE.

PROCEDURE bajar_articulos:

    FOR EACH T-Articulo:

        FIND Articulo WHERE Articulo.cdg_articulo = T-Articulo.cdg_articulo EXCLUSIVE-LOCK NO-ERROR.
        IF NOT AVAILABLE Articulo 
            THEN CREATE Articulo.
         
        BUFFER-COPY T-Articulo TO Articulo.

        FIND CURRENT Articulo NO-LOCK.
    END.

    FOR EACH T-Partida:
        CREATE Partida.
        BUFFER-COPY T-Partida TO Partida.
    END.

    FOR EACH T-Articulo_atributo WHERE T-Articulo_atributo.nuevo:
        CREATE Articulo_atributo.
        BUFFER-COPY T-Articulo_atributo TO Articulo_atributo.
    END.

END PROCEDURE.

PROCEDURE bajar_atributos:

    FOR EACH T-Atributo WHERE T-Atributo.nuevo:
        CREATE Atributo.
        BUFFER-COPY T-Atributo TO Atributo.
    END.

END PROCEDURE.

PROCEDURE bajar_tipo_articulos:

    FOR EACH T-Tipo_articulo WHERE T-Tipo_articulo.nuevo:
        CREATE Tipo_articulo.
        BUFFER-COPY T-Tipo_articulo TO Tipo_articulo.
    END.

END PROCEDURE.

PROCEDURE bajar_unidades:

    FOR EACH T-Unidad WHERE T-Unidad.nuevo:
        CREATE Unidad.
        BUFFER-COPY T-Unidad TO Unidad.

    DISPLAY
        SKIP
        "***** UNIDAD NUEVA *****"
        T-Unidad.cdg_umed
        T-Unidad.descripcion_unid
        WITH FRAME BB SIDE-LABELS STREAM-IO 1 COLUMN.
    END.

END PROCEDURE.

PROCEDURE levantar_tablas:

    DEFINE VARIABLE v-cod  AS CHARACTER.
    DEFINE VARIABLE v-desc AS CHARACTER.
    DEFINE VARIABLE v-tiun AS CHARACTER.

    FOR EACH Atributo:
        CREATE T-Atributo.
        BUFFER-COPY Atributo TO T-Atributo ASSIGN T-Atributo.nuevo = NO.
    END.
    
    FOR EACH Tipo_articulo:
        CREATE T-Tipo_articulo.
        BUFFER-COPY Tipo_articulo TO T-Tipo_articulo ASSIGN T-Tipo_articulo.nuevo = NO.
        IF Tipo_articulo.cdg_tipoart = "1000"
            THEN v-validacion_codigo = T-Tipo_articulo.validacion_codigo.
    END.
    
    FOR EACH Unidad:
        CREATE T-Unidad.
        BUFFER-COPY Unidad TO T-Unidad ASSIGN T-Unidad.nuevo = NO.
    END.

END PROCEDURE.
