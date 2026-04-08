/*=================================================================================*/
/*                           IMPRESION DE RECIBOS A                                */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-cdg_moneda LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-ano        AS INTEGER.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{nommeses.i}
{xprint.i}

DEFINE VARIABLE TextColor                 AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color                  AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente                 AS LOGICAL INITIAL NO.
DEFINE VARIABLE j                         AS INTEGER INITIAL 10.
DEFINE VARIABLE k                         AS INTEGER INITIAL 10.

DEFINE VARIABLE y0                        AS INTEGER INITIAL 47.
DEFINE VARIABLE x0                        AS INTEGER INITIAL 60.
DEFINE VARIABLE x-fila                    AS INTEGER.
DEFINE VARIABLE x-columna                 AS INTEGER.
DEFINE VARIABLE x-offset                  AS INTEGER.

DEFINE VARIABLE chr_linea                 AS CHARACTER.

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

    {findempresa.i}
    FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\listarcotizaciones.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.
    RUN encabezado.
    RUN detalle.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\listarcotizaciones.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de cotizaciones por moneda><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Letter>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    
END PROCEDURE.

PROCEDURE detalle:

    /*---------------------------------------------------------------------------------*/
    /*                                      DETALLE                                    */
    /*---------------------------------------------------------------------------------*/

    FOR EACH Cotizacion OF Moneda NO-LOCK
        WHERE Cotizacion.cdg_empresa = Empresa.cdg_empresa
          AND YEAR(Cotizacion.fch_cotizacion) = p-ano:

        ASSIGN x-offset = TRUNC((DAY(Cotizacion.fch_cotizacion) - 1 ) / 10,0)
               x-fila = ( MONTH(Cotizacion.fch_cotizacion) - 1 ) * 4 + x-offset
               x-columna = ( DAY(Cotizacion.fch_cotizacion) - 1 ) MOD 10 - 1.

        chr_linea = TRIM(STRING(y0 + x-fila * 4,">>>9")) + "," + 
                    TRIM(STRING( x0 - 3 +  x-columna * 17,">>>9")).
          
        RUN escribenumero( INPUT chr_linea, INPUT STRING(Cotizacion.cambio,">>,>>9.9999"), 8, NO). 
        
    END.

END PROCEDURE.

PROCEDURE encabezado:

    /*---------------------------------------------------------------------------------*/
    /*                                    ENCABEZADO                                   */
    /*---------------------------------------------------------------------------------*/

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+191><RECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+17,+191><RECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+46,+10><FROM><AT=+192,+191><RECT)>". 
    
    PUT STREAM Formulario UNFORMATTED "<=#1><AT=+17,+13><#3><AT=+8,+60><IMAGE#3=..\imagenes\logo.bmp>".
    RUN escribir ( INPUT "18,61", INPUT "COTIZACIONES:" + Moneda.descripcion + " - " + STRING(p-ano,"9999"), 14, YES).
    RUN escribir ( INPUT "30,15", INPUT "Mes", 8, YES).

    DO j = 1 TO 31:
        ASSIGN x-offset = TRUNC((j - 1 ) / 10,0)
               x-fila = x-offset
               x-columna = ( j - 1 ) MOD 10 - 1.

        chr_linea = TRIM(STRING(y0 - 2 + x-fila * 4 - 16,">>>9")) + 
                    "," + 
                    TRIM(STRING( x0 + 3 +  x-columna * 17,">>>9")).
          
        RUN escribenumero( INPUT chr_linea, INPUT STRING(j,"99"), 8, NO). 


    END.

    DO j = 1 TO 12:
        chr_linea = TRIM(STRING(y0 + ( j - 1 ) * 16,">>>9")) + ",12".
        RUN escribir ( INPUT chr_linea, INPUT nom_mes [ j ], 10, NO). 
        IF j >= 2
            THEN PUT STREAM Formulario UNFORMATTED "<=#1><AT=+" + TRIM(STRING(y0 + ( j - 1 ) * 16,">>>9")) +
                             ",+10><FROM><AT=,+191><LINE>". 

    END.

    DO k = 1 TO 10:

        chr_linea = TRIM(STRING(y0 - 1,">>>9")).
        
        PUT STREAM Formulario UNFORMATTED "<=#1><AT=+28,+" + TRIM(STRING( 14 +  k * 17,">>>9")) +
                                          "><FROM><AT=+17><LINE>". 

        PUT STREAM Formulario UNFORMATTED "<=#1><AT=+46,+" + TRIM(STRING( 14 +  k * 17,">>>9")) + 
                                          "><FROM><AT=+192><LINE>". 

    END.

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

    linea = '<=#1><FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

PROCEDURE escribircentrado:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER f-width  AS DECIMAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    linea = '<=#1><FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + CenterText(TRIM(texto), s-font, f-width).
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

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
    
    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    
    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=BLACK><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             "<DECIMAL=+0>" + texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 

    PUT STREAM Formulario UNFORMATTED linea.
  

END PROCEDURE.

