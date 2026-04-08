/*=================================================================================*/
/*                     IMPRESION DE FORMULARIO DE PEDIDOS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_pedido AS ROWID.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}

DEFINE VARIABLE TextColor          AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color           AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente          AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                  AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f            AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c            AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia             AS INTEGER.
DEFINE VARIABLE det0               AS INTEGER INITIAL 42.
                                   
DEFINE VARIABLE ancho              AS DECIMAL INITIAL 1.0.
                                   
DEFINE VARIABLE max_det            AS INTEGER INITIAL 52. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle     AS INTEGER INITIAL 72. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_observacion AS INTEGER INITIAL 5.  /* Cantidad de lineas de observacion */
DEFINE VARIABLE v-leng_observacion AS INTEGER INITIAL 70. /* Ancho en chars de la observacion  */

DEFINE VARIABLE v-reng_monto       AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto       AS INTEGER INITIAL 60. /* Ancho en chars del monto      */
                                   
DEFINE VARIABLE j                  AS INTEGER.
DEFINE VARIABLE nreng              AS INTEGER.
DEFINE VARIABLE linea0             AS INTEGER.
DEFINE VARIABLE n_hoja             AS INTEGER.
                                   
DEFINE VARIABLE total_articulo     AS INTEGER.
                                   
DEFINE VARIABLE que_dia            AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes            AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano            AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha          AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo           AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada        AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-monto_letras     AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-observacion      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto             AS CHARACTER FORMAT "X(75)".

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                                      FUNCIONES                                          */
/*=========================================================================================*/

FUNCTION fnComprobante RETURN CHARACTER ( tip AS CHARACTER, prf AS INTEGER, nro AS INTEGER).
  RETURN tip + "-" + STRING(prf,"9999") + "-" + STRING(nro,"99999999").
END FUNCTION.

FUNCTION ch_linea RETURN CHARACTER ( INPUT n0 AS INTEGER, INPUT n AS INTEGER).
    RETURN STRING(n0 + n * 4,"9999").
END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
DO TRANSACTION:

    FIND Valeinv_hd WHERE ROWID(Valeinv_hd) = rid_pedido EXCLUSIVE-LOCK.

    FIND Area            OF Valeinv_hd NO-LOCK NO-ERROR.
    FIND Imputacion      OF Valeinv_hd NO-LOCK.
    FIND Usuario         OF Valeinv_hd NO-LOCK.
    FIND Tipocomprobante OF Valeinv_hd NO-LOCK.

    que_mes = STRING(MONTH(Valeinv_hd.fecha),"99").
    que_ano = STRING(YEAR(Valeinv_hd.fecha),"9999").
    que_dia = STRING(DAY(Valeinv_hd.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Valeinv_hd.fecha) ] + " de " + que_ano.
        
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DEL PEDIDO                                  */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\prval002.xpr" CONVERT TARGET "iso8859-1".

    ncopia = 1.
    n_hoja = 0.
    RUN forma.
   
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\prval002.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */

END.
RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE inicia_hoja:

    n_hoja = n_hoja + 1.

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.  
/*  PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.            */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de Vale de Inventario Nro.:" + STRING(Valeinv_hd.nro_comprob,'999999')
                                  + " Hoja:" + STRING(n_hoja,'>9') + "><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    PUT STREAM Formulario CONTROL "<#1>".    
    PUT STREAM Formulario CONTROL "<R172><C1><#2>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+10,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+15,+5><FROM><AT=+22,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+37,+5><FROM><AT=+220,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+257,+5><FROM><AT=+25,+190><FILLRECT)>". 

/*  ---------- Boxes
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+237,+138><FROM><AT=+25,+30><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+237,+168><FROM><AT=+25,+27><FILLRECT)>". 
*/

    RUN escribir ( INPUT "07,70", INPUT Tipocomprobante.denominacion_impresa, INPUT 14, INPUT YES). 
    RUN escribir ( INPUT "07,145", INPUT "<B>NRO:</B>" + fncomprobante(INPUT Valeinv_hd.tip_comprob, INPUT Valeinv_hd.prf_comprob, INPUT Valeinv_hd.nro_comprob), INPUT 12, INPUT NO). 
    
    RUN escribir ( INPUT "20,20", INPUT "<B>IMPUTACION:</B>" + STRING(Imputacion.cdg_imputacion,"999") + "-" + Imputacion.dsc_imputacion , INPUT 12, INPUT NO). 
    RUN escribir ( INPUT "20,145", INPUT "<B>HOJA:</B>" + STRING(n_hoja,'>9'), INPUT 12, INPUT NO). 

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+18,+183><FROM><AT=+9,+9><FILLRECT)>". 
    RUN escribir ( INPUT "20,186", INPUT Valeinv_hd.cdg_empresa, INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "25,20", INPUT "<B>FECHA:</B>" + que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT NO). 

    RUN escribir ( INPUT "30,20", INPUT "<B>INGRESO:</B>" + Usuario.cdg_usuario + "-" + Usuario.nombre, INPUT 10, INPUT NO).  

    RUN escribir ( ch_linea(det0 + 1,-1)  + ",9", INPUT "Código", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",28", INPUT "Descripción", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",114", INPUT "Color", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",133", INPUT "Cantidad", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",160", INPUT "Deposito", INPUT 8, INPUT NO).
    /*RUN escribir ( ch_linea(det0 + 1,-1)  + ",175", INPUT "Descripción", INPUT 8, INPUT NO).*/

    RUN linea    ( ch_linea(det0 - 2,1)  + ",5", INPUT "190", "H" ).

    RUN linea    ( "37,26", INPUT "220", "V" ).
    RUN linea    ( "37,110", INPUT "220", "V" ).
    RUN linea    ( "37,129", INPUT "220", "V" ).
    RUN linea    ( "37,147", INPUT "245", "V" ).
  /*RUN linea    ( "57,168", INPUT "225", "V" ).*/

    RUN linea    ( "264,147", INPUT "48", "H" ).
    RUN escribir ( INPUT "258,163", INPUT "Intervino", INPUT 8, INPUT YES).

    linea0 = 1.

END PROCEDURE.

PROCEDURE forma:

    RUN inicia_hoja.

    FOR EACH Valeinv_dt NO-LOCK OF Valeinv_hd, Articulo NO-LOCK OF Valeinv_dt,
        Partida NO-LOCK OF Valeinv_dt, Deposito NO-LOCK OF Valeinv_dt
        BREAK BY Articulo.cdg_articulo BY Partida.cdg_partida:

        IF linea0 > max_det
        THEN DO:
             RUN escribir ( "258,30", INPUT "CONTINUA EN HOJA " + STRING(n_hoja + 1,">9"), INPUT 12, INPUT YES).
             OUTPUT STREAM Formulario CLOSE.
             FILE-INFO:File-NAME = "c:\sic-temp\prval002.xpr".
             RUN printFile( FILE-INFO:FULL-PATHNAME).
             
             OUTPUT STREAM Formulario TO "c:\sic-temp\prval002.xpr" CONVERT TARGET "iso8859-1".
             RUN inicia_hoja.             
        END.

        RUN escribir      ( ch_linea(det0,linea0)  + ",9", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
        RUN escribir      ( ch_linea(det0,linea0)  + ",28", INPUT Articulo.descripcion, INPUT 8, INPUT NO).
        RUN escribir      ( ch_linea(det0,linea0)  + ",112", INPUT Partida.cdg_partida, INPUT 8, INPUT NO).
        RUN escribenumero ( ch_linea(det0,linea0)  + ",124", INPUT STRING(Valeinv_dt.cantidad,"ZZZZZZ9"), INPUT 8, INPUT NO).
        RUN escribenumero ( ch_linea(det0,linea0)  + ",140", INPUT Deposito.cdg_deposito, INPUT 8, INPUT NO).
        RUN escribir      ( ch_linea(det0,linea0)  + ",154", INPUT Deposito.nombre, INPUT 8, INPUT NO).
        
        linea0 = linea0 + 1.

        total_articulo = total_articulo + Valeinv_dt.cantidad.    
        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:
            IF NOT CAN-FIND(FIRST Partida OF Articulo 
                            WHERE Partida.cdg_partida = "" )
            THEN DO:
                RUN linea         ( ch_linea(det0 + 1,linea0)  + ",131", INPUT "13", "H" ).
                linea0 = linea0 + 1.       
                RUN escribenumero ( ch_linea(det0,linea0)  + ",124", INPUT STRING(total_articulo,"ZZZZZZ9"), INPUT 8, INPUT NO).
            END.
            linea0 = linea0 + 2.       
            total_articulo = 0.
        END. 
    
    END.

    RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "FIN DE LOS ITEMS DEL VALE DE INVENTARIO", INPUT 12, INPUT YES).

    /*
    IF Valeinv_hd.observacion <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Valeinv_hd.observacion, 
                        INPUT  v-leng_observacion,
                        OUTPUT v-observacion,
                        INPUT  "|").
    
    
        linea0 = 258.
        DO j = 1 TO v-reng_observacion:
            IF j <= NUM-ENTRIES(v-observacion, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT ENTRY(j,v-observacion, "|"), INPUT 10, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    
    END.
    */

END PROCEDURE.

PROCEDURE escribir:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM FORMULARIO UNFORMATTED linea.

END PROCEDURE.

PROCEDURE escribenumero:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.
    DEFINE VARIABLE r-texto         AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.
    DEFINE VARIABLE offset          AS DECIMAL.

    s-font = 'Arial,' + puntos + IF negrita THEN ',B' ELSE ''.
    offset = DECIMAL(ENTRY(2,ENTRY(1,RightJustify(TRIM(texto), s-font, ancho),">"),",")) * 12.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")) + offset.

    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
/*
    message linea view-as alert-box message title "plot".
*/    
    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

PROCEDURE linea:

    DEFINE INPUT PARAMETER posicion    AS CHARACTER.
    DEFINE INPUT PARAMETER longitud    AS CHARACTER.
    DEFINE INPUT PARAMETER orientacion AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    DEFINE VARIABLE linea           AS CHARACTER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    linea = '<=#1><FGCOLOR=' + 
           textColor + 
           '><AT=+' + 
           TRIM(STRING(i-linea,">>9")) + 
            ',+' + 
            TRIM(STRING(i-columna,">>9")) + 
            '><FROM><AT=' + 
            (IF orientacion = "H" THEN ',' ELSE '') + 
            '+' + 
            longitud + 
            '><LINE>'.

    PUT STREAM Formulario UNFORMATTED linea.
    

END PROCEDURE.
