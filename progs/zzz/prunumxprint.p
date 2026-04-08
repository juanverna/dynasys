/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE FACTURACION TIPO A                      */
/*=================================================================================*/

/*=================================================================================*/
/*                               FUNCIONES                                         */
/*=================================================================================*/

FUNCTION fnComprobante RETURN CHARACTER ( tip AS CHARACTER, prf AS INTEGER, nro AS INTEGER).
  RETURN tip + "-" + STRING(prf,"9999") + "-" + STRING(nro,"99999999").
END FUNCTION.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

{xprint.i}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE k              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.
DEFINE VARIABLE nt-lineas      AS INTEGER.
DEFINE VARIABLE nt-copias      AS INTEGER INITIAL 2.
DEFINE VARIABLE nt-hojas       AS INTEGER.
DEFINE VARIABLE n-hoja         AS INTEGER.
DEFINE VARIABLE v-cdg_seccion  AS CHARACTER.
DEFINE VARIABLE c-orden        AS INTEGER.
DEFINE VARIABLE c-linea_detalle AS INTEGER.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE v-cantidad     LIKE Fac_detalle.cantidad.
DEFINE VARIABLE v-subtotal     LIKE Fac_detalle.subtotal_neto.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

/*---------------------------------------------------------------------------------*/
/*                          GENERA EL FORMULARIO EN SI                             */
/*---------------------------------------------------------------------------------*/

SESSION:NUMERIC-FORMAT = "AMERICAN".  /* for the AT command. restore it if necessary */

OUTPUT STREAM Formulario TO "c:\sic-temp\prunumero.xpr".

RUN grabar_linea ( "<PREVIEW=70>" ) /*=ZoomToWidth>'*/.

RUN grabar_linea ( "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>").
RUN grabar_linea ( "<FORMAT=Letter>").
RUN grabar_linea ( "<AT=14,8><#1>").    
RUN grabar_linea ( "UNO DOS TRES").    

OUTPUT STREAM Formulario CLOSE .

FILE-INFO:File-NAME = "c:\sic-temp\prunumero.xpr".
  
RUN printFile( FILE-INFO:FULL-PATHNAME).

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE escribir:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER nomcolor AS CHARACTER.

    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=' + nomcolor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FCourierNew><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    RUN grabar_linea ( linea ).

END PROCEDURE.

PROCEDURE escribenumero:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER nomcolor AS CHARACTER.

    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.
    DEFINE VARIABLE r-texto         AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.
    DEFINE VARIABLE offset          AS DECIMAL.

    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    offset = DECIMAL(ENTRY(2,ENTRY(1,RightJustify(TRIM(texto), s-font, ancho),">"),",")) * 12.

        MESSAGE RightJustify(TRIM(texto), s-font, ancho)
            VIEW-AS ALERT-BOX INFO BUTTONS OK.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")) + offset.

    linea = '<FGCOLOR=' + nomcolor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
/*
    message linea view-as alert-box message title "plot".
*/    

    RUN grabar_linea ( linea ).

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

    RUN grabar_linea ( linea ).

END PROCEDURE.

PROCEDURE grabar_linea:

    DEFINE INPUT PARAMETER texto  AS CHARACTER.

    c-orden = c-orden + 1 . /* Incrementamos el contador de registros */

    PUT STREAM Formulario UNFORMATTED texto.

END PROCEDURE.
