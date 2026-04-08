/*=================================================================================*/
/*                           IMPRESION DE CARTAS DOCUMENTO                         */
/*=================================================================================*/

/*=================================================================================*/
/*                           IMPRESION DE CARTAS DOCUMENTO                         */
/*=================================================================================*/                                                                                     
                                                                                     
DEFINE TEMP-TABLE T-Carta_encabezado NO-UNDO
    FIELD fecha           AS DATE
    FIELD rem_nombre      AS CHARACTER 
    FIELD rem_direccion   AS CHARACTER
    FIELD rem_cdg_postal  AS CHARACTER
    FIELD rem_localidad   AS CHARACTER
    FIELD rem_provincia   AS CHARACTER
    FIELD rem_dni         AS CHARACTER
    FIELD dst_nombre      AS CHARACTER
    FIELD dst_direccion   AS CHARACTER
    FIELD dst_cdg_postal  AS CHARACTER
    FIELD dst_localidad   AS CHARACTER
    FIELD dst_provincia   AS CHARACTER
    FIELD texto           AS CHARACTER.

/*=================================================================================*/
/*                           PARAMETROS DE ENTRADA                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Carta_encabezado.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{nommeses.i}
{xprint.i}
{valoresrecibo.I}

DEFINE VARIABLE TextColor                 AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color                  AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente                 AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                         AS INTEGER INITIAL 10.
DEFINE VARIABLE ncopia                    AS INTEGER.
DEFINE VARIABLE renglones                 AS CHARACTER.
DEFINE VARIABLE v-renglon                 AS CHARACTER.

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 27.
DEFINE VARIABLE n0-texto                  AS INTEGER.
DEFINE VARIABLE nl-texto                  AS INTEGER.
DEFINE VARIABLE j-renglon                 AS INTEGER.
DEFINE VARIABLE nt-lineas                 AS INTEGER.
DEFINE VARIABLE nt_hojas                  AS INTEGER INITIAL 1.
DEFINE VARIABLE n_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE t_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE v-ancho_renglon           AS INTEGER INITIAL 100.

DEFINE VARIABLE chr_linea                 AS CHARACTER.

DEFINE STREAM Formulario.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND FIRST T-Carta_encabezado NO-LOCK.

RUN renglons.p ( INPUT  T-Carta_encabezado.texto,
                 INPUT  v-ancho_renglon, 
                 OUTPUT renglones,
                 INPUT  "|").

RUN imprimir_orden.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_orden:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\cartadoc.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.
    ncopia = 1.
    RUN encabezado.
    RUN pie.
    RUN detalle.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\cartadoc.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de recibos de pago><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Legal>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    

END PROCEDURE.

PROCEDURE detalle:

    /*---------------------------------------------------------------------------------*/
    /*                                      DETALLE                                    */
    /*---------------------------------------------------------------------------------*/

    n0-texto = 154.
    nl-texto = 0.

    DO j-renglon = 1 TO NUM-ENTRIES(renglones,"|"):

          v-renglon = ENTRY(j-renglon,renglones,"|").
    
          IF j-renglon >= nmax_det 
          THEN DO:
    
              OUTPUT STREAM Formulario CLOSE.
              FILE-INFO:File-NAME = "c:\sic-temp\cartadoc.xpr".
              RUN printFile( FILE-INFO:FULL-PATHNAME).
        
              n_hoja = n_hoja + 1.
              nl-texto = 0.
              
              OUTPUT STREAM Formulario TO "c:\sic-temp\cartadoc.xpr" CONVERT TARGET "iso8859-1".
              RUN inicia_formulario.
              RUN encabezado.    
              RUN pie.
                
          END.
    
          nl-texto = nl-texto + 1.
          chr_linea = TRIM(STRING(n0-texto + nl-texto * 4,">>9")).
    
          RUN escribir ( INPUT chr_linea + ",14",  INPUT v-renglon, 12, NO).
      
    END.

    nl-texto = nl-texto + 6.
    chr_linea = TRIM(STRING(n0-texto + nl-texto * 4,">>9")).
    RUN escribir ( INPUT chr_linea + ",142",  INPUT T-Carta_encabezado.rem_nombre, 10, NO).

    nl-texto = nl-texto + 1.
    chr_linea = TRIM(STRING(n0-texto + nl-texto * 4,">>9")).
    RUN escribir ( INPUT chr_linea + ",142",  INPUT T-Carta_encabezado.rem_dni, 10, NO).


END PROCEDURE.

PROCEDURE encabezado:

    /*---------------------------------------------------------------------------------*/
    /*                                    ENCABEZADO                                   */
    /*---------------------------------------------------------------------------------*/

    RUN escribir ( INPUT "38,31",  INPUT T-Carta_encabezado.rem_nombre, 10, YES).
    RUN escribir ( INPUT "49,31",  INPUT T-Carta_encabezado.rem_direccion, 10, NO).
    RUN escribir ( INPUT "57,31",  INPUT T-Carta_encabezado.rem_cdg_postal + " " + T-Carta_encabezado.rem_localidad, 10, NO).
    RUN escribir ( INPUT "57,91",  INPUT T-Carta_encabezado.rem_provincia, 10, NO).
    
    RUN escribir ( INPUT "38,114",  INPUT T-Carta_encabezado.dst_nombre, 10, YES).
    RUN escribir ( INPUT "49,114",  INPUT T-Carta_encabezado.dst_direccion, 10, NO).
    RUN escribir ( INPUT "57,114",  INPUT T-Carta_encabezado.dst_cdg_postal + " " + T-Carta_encabezado.dst_localidad, 10, NO).
    RUN escribir ( INPUT "57,172",  INPUT T-Carta_encabezado.dst_provincia, 10, NO).

    RUN escribir ( INPUT "132,31",  INPUT T-Carta_encabezado.rem_nombre, 10, YES).
    RUN escribir ( INPUT "143,31",  INPUT T-Carta_encabezado.rem_direccion, 10, NO).
    RUN escribir ( INPUT "150,31",  INPUT T-Carta_encabezado.rem_cdg_postal + " " + T-Carta_encabezado.rem_localidad, 10, NO).
    RUN escribir ( INPUT "150,91",  INPUT T-Carta_encabezado.rem_provincia, 10, NO).
    
    RUN escribir ( INPUT "132,114",  INPUT T-Carta_encabezado.dst_nombre, 10, YES).
    RUN escribir ( INPUT "143,114",  INPUT T-Carta_encabezado.dst_direccion, 10, NO).
    RUN escribir ( INPUT "150,114",  INPUT T-Carta_encabezado.dst_cdg_postal + " " + T-Carta_encabezado.dst_localidad, 10, NO).
    RUN escribir ( INPUT "150,172",  INPUT T-Carta_encabezado.dst_provincia, 10, NO).


END PROCEDURE.

PROCEDURE pie:

    /*---------------------------------------------------------------------------------*/
    /*                                       PIE                                       */
    /*---------------------------------------------------------------------------------*/
/*
    IF n_hoja = nt_hojas
    THEN DO:
        RUN escribir( INPUT "120,15", INPUT T-Carta_encabezado.leyenda, 8, NO).
        
        RUN escribenumero( INPUT "142,195", INPUT STRING(T-Carta_encabezado.imp_pesos + T-Carta_encabezado.imp_difcambio,"->,>>>,>>9.99"), 8, YES).
    
        RUN escribir     ( INPUT "237,15", INPUT "<B>Son " + Moneda.descripcion + ":</B>" + letras, 8, NO).
        RUN escribenumero( INPUT "237,195", INPUT STRING(T-Carta_encabezado.imp_pesos + T-Carta_encabezado.imp_difcambio,"->,>>>,>>9.99"), 8, YES).
    END.


    /*
    RUN escribircentrado( INPUT "143,70", INPUT Usuario.nombre, 7, NO, 10.0).
    RUN escribircentrado( INPUT "143,158", INPUT "Por " + T-Carta_encabezado.nom_destinatario, 7, NO, 10.0).
    */
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

    linea = f-ref(ncopia) + '<FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
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

    linea = f-ref(ncopia) + '<FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
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
  /*RUN grabar_linea ( linea ).*/

END PROCEDURE.

