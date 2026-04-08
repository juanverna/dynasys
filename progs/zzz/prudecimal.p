/*=================================================================================*/
/*                           PRUEBA DE RJUSTIFY                                    */
/*=================================================================================*/

{xprint.i}

DEFINE VARIABLE TextColor                 AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE tam                       AS INTEGER.
DEFINE VARIABLE ancho                     AS DECIMAL INITIAL 1.0.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
RUN imprimir_orden.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_orden:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "./prl/prujust.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    RUN forma.

    OUTPUT STREAM Formulario CLOSE.

    FILE-INFO:File-NAME = "./prl/prujust.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de órdenes de pago><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

END PROCEDURE.

PROCEDURE forma:

    tam = 14.
/* 
    RUN escribenumero( INPUT "100,70",  INPUT STRING(23564.78,"->,>>>,>>9.99"), tam, NO).
    RUN escribenumero( INPUT "104,70",  INPUT STRING(    1.45,"->,>>>,>>9.99"), tam, NO).
    RUN escribenumero( INPUT "108,70",  INPUT STRING(  564.11,"->,>>>,>>9.99"), tam, NO).
    RUN escribenumero( INPUT "112,70",  INPUT STRING(  789.65,"->,>>>,>>9.99"), tam, NO).
    RUN escribenumero( INPUT "116,70",  INPUT STRING(  209.00,"->,>>>,>>9.99"), tam, NO).
*/
    RUN escribenumero( INPUT "100,230",  INPUT STRING(23564.78,"->,>>>,>>9.99"), tam, YES).
    RUN escribenumero( INPUT "104,230",  INPUT STRING(    1.45,"->,>>>,>>9.99"), tam, YES).
    RUN escribenumero( INPUT "108,230",  INPUT STRING(  564.11,"->,>>>,>>9.99"), tam, YES).
    RUN escribenumero( INPUT "112,230",  INPUT STRING(  789.65,"->,>>>,>>9.99"), tam, YES).
    RUN escribenumero( INPUT "116,230",  INPUT STRING(  209.00,"->,>>>,>>9.99"), tam, YES).

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
    offset = DECIMAL(ENTRY(2,ENTRY(1,RightJustify(TRIM(texto), s-font, ancho),">"),",")) * 14.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).
/*
    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',DECIMAL=+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             TRIM(texto). 
*/

    linea =  '<FGCOLOR=' + textColor + '>' + /*<FArial><P' + puntos + '>' +*/
             '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',DECIMAL=+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             texto. 

    message linea view-as alert-box message title "plot".
    
    PUT STREAM Formulario UNFORMATTED linea.

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

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.


