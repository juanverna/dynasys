/*=====================================================================================*/
/*            CARGA MASIVA DE ARTICULOS DE CATALOGO DE ABASTECIMIENTO                  */
/*=====================================================================================*/

DEFINE INPUT  PARAMETER arch_cab  AS CHARACTER.
DEFINE OUTPUT PARAMETER hay_error AS LOGICAL.

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
DEFINE VARIABLE V-FECHA-TRANSA  AS CHARACTER FORMAT "X(08)". 
DEFINE VARIABLE V-HORA-TRANSA   AS CHARACTER FORMAT "X(08)". 

DEFINE VARIABLE V-INDICALMACEN  AS CHARACTER FORMAT "X(01)".

DEFINE VARIABLE X-COD-S         AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE X-COD-A         AS CHARACTER FORMAT "X(01)".
DEFINE VARIABLE X-COD-C         AS CHARACTER FORMAT "X(01)".


DEFINE VARIABLE x-alta   AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE x-baja   AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE x-cod    AS CHARACTER.
DEFINE VARIABLE arch_entrada AS CHARACTER FORMAT "X(76)" INITIAL "G:\Abastecimiento\GRUPO-FINANZAS\vt\pv9\r3.5\progs\imple\abmre364.02al09.txt".

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

DEFINE TEMP-TABLE T-Contenedor 
    FIELD cdg_contenedor AS CHARACTER
    FIELD dsc_contenedor AS CHARACTER
    INDEX por_codigo IS UNIQUE PRIMARY cdg_contenedor.

DEFINE TEMP-TABLE T-Unimedida 
    FIELD cdg_unimedida AS CHARACTER
    FIELD dsc_unimedida AS CHARACTER
    FIELD tipounidad    AS CHARACTER
    INDEX por_codigo IS UNIQUE PRIMARY cdg_unimedida.

FUNCTION alta_unidades RETURN CHARACTER ( INPUT P-CONTENEDOR AS CHARACTER, 
                                          INPUT P-CANTIDAD   AS CHARACTER,
                                          INPUT P-UN-MEDIDA  AS CHARACTER ).
    
    P-CANTIDAD = TRIM(STRING(INTEGER(P-CANTIDAD),">>>>>9")).

    FIND T-Contenedor WHERE T-Contenedor.cdg_contenedor = P-CONTENEDOR NO-LOCK NO-ERROR.
    IF NOT AVAILABLE T-Contenedor
    THEN DO:
        MESSAGE "No encontrado contenedor " P-CONTENEDOR  "en articulo" V-GRUPO + "-" + V-ARTICULO
            VIEW-AS ALERT-BOX MESSAGE.
        CREATE T-Contenedor.
        ASSIGN T-Contenedor.cdg_contenedor = P-CONTENEDOR
               T-Contenedor.dsc_contenedor = "CONTENEDOR " + P-CONTENEDOR.
    END.

    FIND T-Unimedida WHERE T-Unimedida.cdg_unimedida = P-UN-MEDIDA NO-LOCK NO-ERROR.
    IF NOT AVAILABLE T-Unimedida
    THEN DO:
        MESSAGE "No encontrada unidad de medida " P-UN-MEDIDA "en articulo" V-GRUPO + "-" + V-ARTICULO
            VIEW-AS ALERT-BOX MESSAGE.
        CREATE T-Unimedida.
        ASSIGN T-Unimedida.cdg_unimedida = P-UN-MEDIDA
               T-Unimedida.dsc_unimedida = "UNIDAD " + P-UN-MEDIDA
               T-Unimedida.tipounidad = "".
    END.

    FIND T-Unidad WHERE T-Unidad.cdg_umed = TRIM(P-CONTENEDOR + P-CANTIDAD + P-UN-MEDIDA) NO-ERROR.
    IF NOT AVAILABLE T-Unidad 
    THEN DO:

        CREATE T-Unidad.
        ASSIGN T-Unidad.cdg_umed         = TRIM(P-CONTENEDOR + P-CANTIDAD + P-UN-MEDIDA)
               T-Unidad.descripcion_unid = TRIM(T-Contenedor.dsc_contenedor + " " + P-CANTIDAD + " " + T-Unimedida.dsc_unimedida) 
               T-Unidad.tipounidad       = T-Unimedida.tipounidad
               T-Unidad.nuevo            = YES.
     END.

     RETURN T-Unidad.cdg_umed.


END FUNCTION.

FORM n
     /*
     V-GRUPO         COLON 20 
     V-ARTICULO      COLON 20 
     V-TIPO          COLON 20 
     V-CLASIF        COLON 20 
     V-DESCRIPCION1  COLON 20 
     V-DESCRIPCION2  COLON 20 
     V-US-CONTENED   COLON 20 
     V-US-CANTIDAD   COLON 20 
     V-US-UN-MEDIDA  COLON 20 
     V-UA-CONTENED   COLON 20 
     V-UA-CANTIDAD   COLON 20 
     V-UA-UN-MEDIDA  COLON 20 
     V-UC-CONTENED   COLON 20 
     V-UC-CANTIDAD   COLON 20 
     V-UC-UN-MEDIDA  COLON 20 
     V-VIGENCIA      COLON 20 
     V-INDIC-SUSPEN  COLON 20 
     V-FEC-HAB-SUSP  COLON 20 
     V-FEC-INGR      COLON 20 
     V-FECHA-TRANSA  COLON 20 
     V-HORA-TRANSA   COLON 20 
     */
     WITH FRAME AA 1 DOWN FONT 2 SIDE-LABELS VIEW-AS DIALOG-BOX.

/*=====================================================================================*/
/*                                         PROCESO                                     */
/*=====================================================================================*/ 

RUN levantar_tablas.
UPDATE arch_entrada.
INPUT FROM VALUE(arch_entrada).

REPEAT:
    PAUSE 0 BEFORE-HIDE.
    n = n + 1.
    IMPORT UNFORMATTED linea. 
    DISPLAY n WITH FRAME AA.
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
        
        WITH FRAME AA SIDE-LABELS STREAM-IO 1 COLUMN.

    x-alta = DATE(SUBSTRING(V-FEC-HAB-SUSP,7,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,5,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,1,4) ) NO-ERROR.
    IF ERROR-STATUS:ERROR 
        THEN x-alta = ?.

    x-baja = DATE(SUBSTRING(V-FEC-HAB-SUSP,7,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,5,2) + "/" + SUBSTRING(V-FEC-HAB-SUSP,1,4) ) NO-ERROR.
    IF ERROR-STATUS:ERROR 
        THEN x-baja = ?.

    x-cod = IF ASC(V-TIPO) < ASC("a") THEN "101" + V-TIPO ELSE "100" + V-TIPO.

    X-COD-S = alta_unidades ( INPUT V-US-CONTENED, INPUT V-US-CANTIDAD, INPUT V-US-UN-MEDIDA).
    X-COD-A = alta_unidades ( INPUT V-UA-CONTENED, INPUT V-UA-CANTIDAD, INPUT V-UA-UN-MEDIDA).
    X-COD-C = alta_unidades ( INPUT V-UC-CONTENED, INPUT V-UC-CANTIDAD, INPUT V-UC-UN-MEDIDA).

    CREATE T-Articulo.
    ASSIGN T-Articulo.cdg_articulo     = V-GRUPO + "-" + V-ARTICULO 
           T-Articulo.descripcion      = V-DESCRIPCION1 + V-DESCRIPCION2 
           T-Articulo.cdg_estado       = IF V-INDIC-SUSPEN <> "N" THEN "B" ELSE ""
           T-Articulo.fecha_baja       = IF T-Articulo.cdg_estado = "B" THEN x-baja ELSE ?
           T-Articulo.fecha_alta       = x-alta
           T-Articulo.lista_sectores   = "!A.GA.CR,!M.GA,*,|"                                       
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
           T-Articulo.cyorden_sino     = NO
           T-Articulo.nro_articulo     = NEXT-VALUE(proximo_articulo).


    CREATE T-Partida.
    ASSIGN T-Partida.nro_articulo = T-Articulo.nro_articulo
           T-Partida.cdg_empresa  = "M".
    
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

    CREATE T-Articulo_atributo.
    ASSIGN T-Articulo_atributo.cdg_atributo        = V-GRUPO
           T-Articulo_atributo.cdg_tipoatributo    = "GRBS"
           T-Articulo_atributo.es_manual           = NO
           T-Articulo_atributo.nro_articulo        = T-Articulo.nro_articulo
           T-Articulo_atributo.nuevo               = YES.

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
/*
RUN bajar_articulos.
RUN bajar_atributos.
RUN bajar_tipo_articulos.
RUN bajar_unidades.
*/
MESSAGE "Terminó" VIEW-AS ALERT-BOX MESSAGE.

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
    /*
    V-FECHA-TRANSA  = SUBSTRING(linea,c,08). c = c +  8.

    V-HORA-TRANSA   = SUBSTRING(linea,c,08). c = c +  8.
    */
    V-INDICALMACEN  = SUBSTRING(linea,c,01). c = c +  1.

END PROCEDURE.

PROCEDURE asignar_sectores:
/*
    DEFINE VARIABLE lista AS CHARACTER.
    DEFINE VARIABLE nsectores AS INTEGER.

    lista = "".

    nsectores = RANDOM(1,na).

    DO ia = 1 TO nsectores:
        lista = lista + "," + v-sector [ RANDOM(1,na) ].
    END.
    Articulo.lista_sectores = SUBSTRING(lista,2).
*/
END PROCEDURE.

PROCEDURE bajar_articulos:

    FOR EACH T-Articulo:
        CREATE Articulo.
        BUFFER-COPY T-Articulo TO Articulo.
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

    INPUT FROM "G:\Abastecimiento\GRUPO-FINANZAS\vt\pv9\r3.5\progs\imple\contenedores.txt".
    REPEAT:
        IMPORT v-cod v-desc.
        CREATE T-Contenedor.
        ASSIGN T-Contenedor.cdg_contenedor = v-cod
               T-Contenedor.dsc_contenedor = v-desc.
    END.
    INPUT CLOSE.
    CREATE T-Contenedor.
    ASSIGN T-Contenedor.cdg_contenedor = ""
           T-Contenedor.dsc_contenedor = "".

    INPUT FROM "G:\Abastecimiento\GRUPO-FINANZAS\vt\pv9\r3.5\progs\imple\unidades.txt".
    REPEAT:
        IMPORT v-cod v-desc v-tiun.
        CREATE T-Unimedida.
        ASSIGN T-Unimedida.cdg_unimedida = v-cod
               T-Unimedida.dsc_unimedida = v-desc
               T-Unimedida.tipounidad = v-tiun.
    END.
    INPUT CLOSE.

END PROCEDURE.
