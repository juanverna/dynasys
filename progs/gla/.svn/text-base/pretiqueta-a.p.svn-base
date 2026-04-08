/*=========================================================================================*/
/*                               IMPRESION DE ETIQUETAS                                    */
/*=========================================================================================*/

/*=========================================================================================*/
/*                                 P A R A M E T R O S                                     */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-num_etiqueta     AS INTEGER.
DEFINE INPUT PARAMETER p-cantidad         AS DECIMAL.


/*=========================================================================================*/
/*                                  V A R I A B L E S                                      */
/*=========================================================================================*/

DEFINE VARIABLE arch_salida AS CHARACTER.

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE lista_campos   AS CHARACTER INITIAL
       "empresa=1,1,7,NO/descripcion=5,1,7,NO/barra=13,10,9,NO/num_etiqueta=20,1,12,NO/cantidad=21,25,8,NO/nro_serie=9,1,9,NO".

DEFINE STREAM sstream.

{xprint.i}

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.        

{findempresa.i}

FIND Etiqueta WHERE Etiqueta.num_etiqueta = p-num_etiqueta NO-LOCK.
FIND Articulo OF Etiqueta NO-LOCK.
FIND Unidad OF Articulo NO-LOCK.
IF Etiqueta.nro_registrable <> 0
    THEN FIND Registrable WHERE Registrable.nro_registrable = Etiqueta.nro_registrable NO-LOCK.

arch_salida = "c:\sic-temp\et" + STRING(p-num_etiqueta,"99999999") + ".xpr".
OUTPUT STREAM sstream TO VALUE(arch_salida) CONVERT TARGET "iso8859-1".

RUN inicia_hoja.

/*PUT STREAM sstream "<=#1><BGCOLOR=WHITE><AT=+00,+0><FROM><AT=+25,+50><RECT>". */

RUN escribir ( INPUT "1,1", INPUT Empresa.nombre, INPUT 9, INPUT YES).
RUN escribir ( INPUT "5,1", INPUT Articulo.descripcion, INPUT 7, INPUT no).
RUN escribebarra ( INPUT "13,10", INPUT STRING(p-num_etiqueta,"99999999") + "/" + STRING(p-cantidad * 100,">>>>>>>9"), INPUT 9, INPUT no).
RUN escribir ( INPUT "20,1", INPUT "ID:" + STRING(p-num_etiqueta,"99999999"), INPUT 12, INPUT no).
RUN escribir ( INPUT "21,25", INPUT STRING(p-cantidad," X >>>>>9.99") + " " + Unidad.abrevia, INPUT 8, INPUT no).

 IF Etiqueta.nro_registrable <> 0 
 THEN DO:
      RUN escribir ( INPUT "9,1", INPUT "S/N:" + Registrable.nro_serie, INPUT 9, INPUT no).
 END.
 ELSE DO:
      RUN escribir ( INPUT "9,1", INPUT "S/N:", INPUT 9, INPUT no).
 END.

OUTPUT STREAM sstream CLOSE.

FILE-INFO:File-NAME = arch_salida.
RUN printFile( FILE-INFO:FULL-PATHNAME).


RUN UnLoadXprint.

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

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

    PUT STREAM sstream UNFORMATTED linea.

END PROCEDURE.

PROCEDURE escribenumero:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=' + textColor + '>>=#1><AT=' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><Flineprinter><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT UNFORMATTED linea.

END PROCEDURE.

PROCEDURE escribebarra:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    PUT STREAM sstream UNFORMATTED "<=#1><AT=+" TRIM(STRING(i-linea,">>9")) ",+" TRIM(STRING(i-columna,'>>9')) "><#2>".
    PUT STREAM sstream UNFORMATTED "<=#2><AT=+7,+55><#3>".
    PUT STREAM sstream UNFORMATTED "<=#2><FROM><BARCODE#3,TYPE=128A,CHECKSUM=TRUE,VALUE="   texto ">".

END PROCEDURE.

PROCEDURE inicia_hoja:

    PUT STREAM sstream CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
/*  PUT STREAM sstream CONTROL '<TOOLBAR=!PRINT>'.*/
    
    PUT STREAM sstream CONTROL "<OPORTRAIT><Title=Impresion de etiqueta Nro.:" + STRING(p-num_etiqueta,"99999999") + "><UNITS=mm><|2>".
    PUT STREAM sstream CONTROL "<FORMAT=Letter>".

END PROCEDURE.




