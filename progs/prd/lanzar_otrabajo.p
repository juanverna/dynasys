/*=================================================================================*/
/*       GENERA LAS ORDENES DE FABRICA DE UN DETERMINADO PLAN DE PRODUCCION        */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-tip_comprob    LIKE Planprod_hd.tip_comprob.
DEFINE INPUT PARAMETER  p-prf_comprob    LIKE Planprod_hd.prf_comprob.
DEFINE INPUT PARAMETER  p-nro_comprob    LIKE Planprod_hd.nro_comprob.
DEFINE INPUT PARAMETER  p-generar        AS LOGICAL.   

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{tmptabprod.i}
{dfvarimp.i}
{parlocales.i}
{dfmodoexist.i}

DEFINE VARIABLE des_fecha                AS DATE.
DEFINE VARIABLE has_fecha                AS DATE.
DEFINE VARIABLE titulo_plan              AS CHARACTER FORMAT "X(30)".

DEFINE VARIABLE c-linea                  AS INTEGER.
DEFINE VARIABLE nivel                    AS INTEGER.

DEFINE VARIABLE arch_log                 AS CHARACTER.

/*=================================================================================*/
/*                                       FRAMES                                    */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Desarrollo del Plan de Producción" AT 52 
  titulo_plan
  "Pagina:" AT 150 PAGE-NUMBER FORMAT "ZZZ9" AT 157
  SKIP  
  fecha_lis   
  "Inicia:" AT 52
  des_fecha
  "Finaliza:" 
  has_fecha 
  hora_lis AT 150
  SKIP(1)
  /*
  "             Totales  del  periodo                       Totales  del  ejercicio" AT 44 SKIP
  "Codigo Descripcion" 
  "       Debitos       Creditos          Saldo        Debitos       Creditos          Saldo" AT 44 SKIP
  "------ -----------------------------------" 
  "-------------- -------------- -------------- -------------- -------------- --------------" AT 44 SKIP
  */
  WITH WIDTH 165 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-listado
    T-Listado.que_codigo      
    T-Listado.que_descripcion 
    T-Listado.cantidad_total  
    T-Listado.cantidad_neto   
    T-Listado.unidad_can
    T-Listado.granel_total    
    T-Listado.granel_neto     
    T-Listado.unidad_gra     
    WITH WIDTH 265 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX FRAME frm-listado FONT 2.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Planprod_hd WHERE Planprod_hd.cdg_empresa = Empresa.cdg_empresa 
                   AND Planprod_hd.tip_comprob = p-tip_comprob
                   AND Planprod_hd.prf_comprob = p-prf_comprob
                   AND Planprod_hd.nro_comprob = p-nro_comprob
                       NO-LOCK.

RUN getparametro_c.p (  INPUT  "DIRECTMP", OUTPUT arch_log).
IF arch_log = ? THEN arch_log = SESSION:TEMP-DIRECTORY.
arch_log = arch_log + "\" + Planprod_hd.tip_comprob + 
                            STRING(Planprod_hd.prf_comprob,"9999") + 
                            STRING(Planprod_hd.nro_comprob,"99999999")  + " .log".

OUTPUT TO VALUE(arch_log) PAGE-SIZE 0.
PUT "==============================================================" SKIP
    "Plan: " Planprod_hd.tip_comprob " " Planprod_hd.prf_comprob " " Planprod_hd.nro_comprob SKIP
    "Inicia:" Planprod_hd.fecha_inicio " Finaliza:" Planprod_hd.fecha_final SKIP
    "==============================================================" SKIP.
OUTPUT CLOSE.

ASSIGN
  des_fecha   = Planprod_hd.fecha_inicio
  has_fecha   = Planprod_hd.fecha_final
  titulo_plan = Planprod_hd.tip_comprob + "-" + 
                STRING(Planprod_hd.prf_comprob,"9999") + "-" + 
                STRING(Planprod_hd.nro_comprob,"99999999") + " - " + 
                       IF p-generar THEN "Generado" ELSE "No Generado".

EMPTY TEMP-TABLE T-Listado.
EMPTY TEMP-TABLE T-Produccion.

nivel = 1.

FOR EACH Planprod_dt OF Planprod_hd:

    RUN acumular_produccion.p ( INPUT Planprod_dt.nro_articulo, 
                                INPUT Planprod_dt.cantidad, 
                                INPUT Planprod_dt.granel, 
                                INPUT nivel,
                                INPUT-OUTPUT c-linea,
                                INPUT-OUTPUT TABLE T-Produccion,
                                INPUT-OUTPUT TABLE T-Listado).
    CREATE T-Listado.
    ASSIGN c-linea = c-linea + 1
           T-Listado.nro_linea = c-linea.

END.

{dirprinfile.i}

FOR EACH T-Listado:
    VIEW FRAME frm-titulo.
    DISPLAY T-Listado.que_codigo      
            T-Listado.que_descripcion 
            T-Listado.cantidad_total WHEN que_codigo <> "" AND que_descripcion <> ""  
            T-Listado.cantidad_neto  WHEN que_codigo <> "" AND que_descripcion <> "" 
            T-Listado.unidad_can     WHEN que_codigo <> "" AND que_descripcion <> ""
            T-Listado.coeficiente    WHEN que_codigo <> "" AND que_descripcion <> ""
            T-Listado.granel_total   WHEN que_codigo <> "" AND que_descripcion <> "" 
            T-Listado.granel_neto    WHEN que_codigo <> "" AND que_descripcion <> "" 
            T-Listado.unidad_gra     WHEN que_codigo <> "" AND que_descripcion <> ""
            WITH FRAME frm-listado.
END.
OUTPUT CLOSE.

IF p-generar
THEN 
DO TRANSACTION: 
    RUN ordenes.
    FIND CURRENT Planprod_hd EXCLUSIVE-LOCK.
    Planprod_hd.cdg_estado = "EP".
    RELEASE Planprod_hd.
END.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22).

/*=================================================================================*/
/*                             P R O C E D I M I E N T O S                         */
/*=================================================================================*/

PROCEDURE ordenes:

    FIND Parametro WHERE Parametro.cdg_empresa = Planprod_hd.cdg_empresa
                     AND Parametro.cdg_parametro = "PROXNOFB"
                         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE Parametro
    THEN DO:
         CREATE Parametro.
         ASSIGN Parametro.cdg_empresa   = Planprod_hd.cdg_empresa
                Parametro.cdg_parametro = "PROXNOFB"
                Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                Parametro.observacion   = ""
                Parametro.tipo          = "N"
                Parametro.valor_n       = 1.
    END.         

    FOR EACH Planprod_dt OF Planprod_hd, Articulo OF Planprod_dt:

    
        RUN generar_rutaproceso.p ( INPUT Planprod_dt.nro_articulo, 
                                    INPUT Planprod_dt.cantidad, 
                                    INPUT Planprod_dt.granel, 
                                    INPUT Planprod_hd.nro_planprod,
                                    OUTPUT Planprod_dt.nro_ofabrica,
                                    INPUT-OUTPUT Parametro.valor_n).
    
    END.

    RELEASE Parametro.

END PROCEDURE.

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



