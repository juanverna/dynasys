/*=================================================================================*/
/*       GENERA LAS ORDENES DE FABRICA DE UN DETERMINADO PLAN DE PRODUCCION        */
/*=================================================================================*/

/*=================================================================================*/
/*                             TABLAS TEMPORALES                                   */
/*=================================================================================*/

{tmplisestruc.i}

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-nro_articulo        LIKE Articulo.nro_articulo.
DEFINE INPUT PARAMETER  p-cantidad_compuesto  AS DECIMAL.
DEFINE INPUT PARAMETER  p-granel_compuesto    AS DECIMAL.
DEFINE INPUT PARAMETER  nivel                 AS INTEGER.
DEFINE INPUT PARAMETER  p-maximo              AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER  c-linea        AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER  TABLE FOR T-Listado.
DEFINE INPUT-OUTPUT PARAMETER  TABLE FOR T-Articulo.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

DEFINE VARIABLE x-cantidad_componente AS DECIMAL.
DEFINE VARIABLE x-granel_componente   AS DECIMAL.

/*=================================================================================*/
/*                                     PROCESO                                     */
/*=================================================================================*/

FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.
FIND T-Articulo OF Articulo NO-ERROR.
IF NOT AVAILABLE T-Articulo
THEN DO:

    CREATE T-Articulo.
    ASSIGN T-Articulo.cdg_articulo = Articulo.cdg_articulo.
    
    /* -------------------------------------------------------------- */
    /* Creamos el listado estructurado con las necesidades totales    */
    /* -------------------------------------------------------------- */
    
    CREATE T-Listado.
    ASSIGN c-linea = c-linea + 1
           T-Listado.nro_linea = c-linea
           T-Listado.que_codigo = FILL(" ",( nivel - 1 ) * 2 + 1) + Articulo.cdg_articulo
           T-Listado.que_descripcion = FILL(" ",( nivel - 1 ) * 2 + 1) + Articulo.descripcion
           T-Listado.cantidad_total = p-cantidad_compuesto
           T-Listado.granel_total = p-granel_compuesto.
    
    FIND Unidad OF Articulo NO-LOCK.
    T-Listado.unidad_can = Unidad.abrevia.
    
    FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
    T-Listado.unidad_gra = Unidad.abrevia.
    
    IF nivel < p-maximo
    THEN DO:
    
        FOR EACH Formula_articulo WHERE Formula_articulo.nro_art_compuesto = Articulo.nro_articulo:
        
            x-cantidad_componente  = p-cantidad_compuesto / Formula_articulo.cantidad_compuesto * Formula_articulo.cantidad_componente.
            IF Formula_articulo.granel_compuesto <> 0 
                THEN x-granel_componente    = p-granel_compuesto / Formula_articulo.granel_compuesto * Formula_articulo.granel_componente.
                ELSE x-granel_componente    = 0.
        
            RUN listar_nivel_estructura.p ( INPUT Formula_articulo.nro_art_componente,
                                            INPUT x-cantidad_componente,
                                            INPUT x-granel_componente,
                                            INPUT nivel + 1,
                                            INPUT p-maximo,
                                            INPUT-OUTPUT c-linea,
                                            INPUT-OUTPUT TABLE T-Listado,
                                            INPUT-OUTPUT TABLE T-Articulo).
        END.
    
    END.

    FIND T-Articulo WHERE T-Articulo.cdg_articulo = Articulo.cdg_articulo.
    DELETE T-Articulo.

END.
ELSE DO:

    /* -------------------------------------------------------------- */
    /* Creamos el listado estructurado con las necesidades totales    */
    /* -------------------------------------------------------------- */
    
    CREATE T-Listado.
    ASSIGN c-linea = c-linea + 1
           T-Listado.nro_linea = c-linea
           T-Listado.que_codigo = FILL(" ",( nivel - 1 ) * 2 + 1) + Articulo.cdg_articulo
           T-Listado.que_descripcion = FILL(" ",( nivel - 1 ) * 2 + 1) + "*** " + Articulo.descripcion
           T-Listado.cantidad_total = p-cantidad_compuesto
           T-Listado.granel_total = p-granel_compuesto.

END.
