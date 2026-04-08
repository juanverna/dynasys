/*=================================================================================*/
/*       GENERA LAS ORDENES DE FABRICA DE UN DETERMINADO PLAN DE PRODUCCION        */
/*=================================================================================*/

/*=================================================================================*/
/*                             TABLAS TEMPORALES                                   */
/*=================================================================================*/

{tmptabprod.i}

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-nro_articulo       LIKE Articulo.nro_articulo.
DEFINE INPUT PARAMETER  p-cantidad_compuesto AS DECIMAL.
DEFINE INPUT PARAMETER  p-granel_compuesto   AS DECIMAL.
DEFINE INPUT PARAMETER  nivel                AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER  c-linea       AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER  TABLE FOR T-Produccion.
DEFINE INPUT-OUTPUT PARAMETER  TABLE FOR T-Listado.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

DEFINE VARIABLE x-cantidad_componente AS DECIMAL.
DEFINE VARIABLE x-granel_componente   AS DECIMAL.

/*=================================================================================*/
/*                                     PROCESO                                     */
/*=================================================================================*/

FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.

/* -------------------------------------------------------------- */
/* Acumulamos los requerimientos de produccion para este articulo */
/* -------------------------------------------------------------- */

FIND T-Produccion OF Articulo EXCLUSIVE-LOCK NO-ERROR.
IF NOT AVAILABLE T-Produccion
THEN DO:
    CREATE T-Produccion.
    ASSIGN T-Produccion.nro_articulo = Articulo.nro_articulo.
END.

ASSIGN
    T-Produccion.cantidad_total = T-Produccion.cantidad_total + p-cantidad_compuesto 
    T-Produccion.granel_total = T-Produccion.granel_total + p-granel_compuesto.

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

FOR EACH Formula_articulo WHERE Formula_articulo.nro_art_compuesto = T-Produccion.nro_articulo:

    x-cantidad_componente  = p-cantidad_compuesto / Formula_articulo.cantidad_compuesto * Formula_articulo.cantidad_componente.
    x-granel_componente    = p-granel_compuesto / Formula_articulo.granel_compuesto * Formula_articulo.granel_componente.

    RUN acumular_produccion.p ( INPUT Formula_articulo.nro_art_componente,
                                INPUT x-cantidad_componente,
                                INPUT x-granel_componente,
                                INPUT nivel + 1,
                                INPUT-OUTPUT c-linea,
                                INPUT-OUTPUT TABLE T-Produccion,
                                INPUT-OUTPUT TABLE T-Listado).
END.
