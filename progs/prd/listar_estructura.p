/*=================================================================================*/
/*      EMITE UN LISTADO CONTENIENDO LA ESTRUCTURA DE UN DETERMINADO ARTICULO      */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-nro_articulo   LIKE Articulo.nro_articulo.
DEFINE INPUT PARAMETER  nivel_maximo     AS INTEGER.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{tmplisestruc.i}
{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE titulo_plan              AS CHARACTER FORMAT "X(30)".

DEFINE VARIABLE c-linea                  AS INTEGER.
DEFINE VARIABLE nivel                    AS INTEGER.

/*=================================================================================*/
/*                                       FRAMES                                    */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Desarrollo de Estructura de Artículo" AT 52 
  "Pagina:" AT 150 PAGE-NUMBER FORMAT "ZZZ9" AT 157
  SKIP  
  fecha_lis   
  titulo_plan AT 52
  hora_lis AT 150
  SKIP(1)
  WITH WIDTH 165 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-listado
    T-Listado.que_codigo      
    T-Listado.que_descripcion 
    T-Listado.cantidad_total  
    T-Listado.unidad_can
    T-Listado.granel_total    
    T-Listado.unidad_gra     
    WITH WIDTH 265 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX FRAME frm-listado FONT 2.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.

EMPTY TEMP-TABLE T-Listado.

nivel = 1.

RUN listar_nivel_estructura.p ( INPUT Articulo.nro_articulo, 
                                INPUT 1,
                                INPUT 0,
                                INPUT nivel,
                                INPUT nivel_maximo,
                                INPUT-OUTPUT c-linea,
                                INPUT-OUTPUT TABLE T-Listado,
                                INPUT-OUTPUT TABLE T-Articulo).

CREATE T-Listado.
ASSIGN c-linea = c-linea + 1
       T-Listado.nro_linea = c-linea.

{dirprinfile.i}

FOR EACH T-Listado:
    VIEW FRAME frm-titulo.
    DISPLAY T-Listado.que_codigo      
            T-Listado.que_descripcion 
            T-Listado.cantidad_total WHEN que_codigo <> "" AND que_descripcion <> ""  
            T-Listado.unidad_can     WHEN que_codigo <> "" AND que_descripcion <> ""
            T-Listado.coeficiente    WHEN que_codigo <> "" AND que_descripcion <> ""
            T-Listado.granel_total   WHEN que_codigo <> "" AND que_descripcion <> "" 
            T-Listado.unidad_gra     WHEN que_codigo <> "" AND que_descripcion <> ""
            WITH FRAME frm-listado.
END.
OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22).

/*=================================================================================*/
/*                             P R O C E D I M I E N T O S                         */
/*=================================================================================*/

/*=================================================================================*/
/*           INVOCA AL REPORT BUILDER PARA VER EL REPORTE DE PRODUCCION            */
/*=================================================================================*/
/*
v-filtro =  "".

v-params = "p-listhora=" + STRING(listar_hora) + "~n" + 
           "p-fechas=" + STRING(des_fecha) + " al " + STRING(has_fecha) + "~n" + 
           "p-empresa=" + Empresa.nombre + "~n" +
           "p-sinmov="  + IF todas_cuent THEN "S" ELSE "N" + "~n".

RUN exreport.p (  INPUT  ".\prl\sic.prl",     /* Librería desde la que se ejecuta   */
                  INPUT  "Balance de Saldos", /* Nombre del reporte a ejecutar      */
                  INPUT  v-filtro,            /* Filtro de registros a imponer      */
                  INPUT  "D",                 /* Salida de datos    (ver cPrinter)  */
                  INPUT  "",                  /* Impresora de destino del listado   */
                  INPUT  v-params             /* Parametros especificos del reporte */
                ).   
*/
/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/



