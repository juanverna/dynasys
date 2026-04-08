/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.

DEFINE VARIABLE chLinea        AS CHARACTER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE n-hoja         AS INTEGER.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 10.
DEFINE VARIABLE linea0         AS INTEGER.
DEFINE VARIABLE dtl_rubro      AS CHARACTER.

DEFINE STREAM Formulario.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

    {findempresa.i}

    FIND Caj_header WHERE ROWID(Caj_header) = act_recibo EXCLUSIVE-LOCK.

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    
    OUTPUT STREAM Formulario TO "./prl/prcaj001.xpr" CONVERT TARGET "iso8859-1".
      
    RUN inicia_formulario.
    
    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    RUN forma.

    PUT STREAM Formulario CONTROL "<AT=145,0><#1>".    
    RUN forma.
    
    OUTPUT STREAM Formulario CLOSE.
    
    FILE-INFO:File-NAME = "./prl/prcaj001.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME).
    
/*=================================================================================*/
/*                                    PROCEDIMIENTOS                               */
/*=================================================================================*/

PROCEDURE forma:

    n-hoja = 1.
    RUN encabezado.

    /*---------------------------------------------------------------------------------*/
    /*                                      DETALLE                                    */
    /*---------------------------------------------------------------------------------*/

    linea0 = 45.
    i = 0.
    FOR EACH Caj_detalle OF Caj_header:
    
         FIND Rubro OF Caj_detalle NO-ERROR.
         CASE Rubro.tipo:
            WHEN "D"
              THEN DO:
                   dtl_rubro = "".
              END.
            WHEN "C"
              THEN DO:
                   dtl_rubro = STRING(Caj_detalle.divisas) + " * " +
                               STRING(Caj_detalle.cambio,"ZZZ9.9999").
              END.
            WHEN "V"
              THEN DO:
                   FIND Valor OF Caj_detalle NO-LOCK.
                   FIND Banco OF Valor NO-LOCK.
                   dtl_rubro = SUBSTRING(Banco.abrevia,1,5) + " " +
                               STRING(Valor.numero_cheque,"99999999") + " " +
                               STRING(Valor.fecha_emision).
              END.
            WHEN "P"
              THEN DO:
                   FIND Cheque OF Caj_detalle NO-LOCK.
                   FIND Cuenta_bancaria OF Cheque NO-LOCK.
                   FIND Banco OF Cuenta_bancaria NO-LOCK.
                   dtl_rubro = Banco.abrevia + " " +
                               STRING(Cheque.numero_cheque,"99999999") + " " +
                               STRING(Cheque.fecha_emision).
              END.
         END CASE.
    
         chLinea = TRIM(STRING(linea0 + i * 4)).
         RUN escribenumero ( INPUT chLinea + ",7", INPUT STRING(Rubro.cdg_rubro,"999"), 8, NO).
         RUN escribenumero ( INPUT chLinea + ",20", INPUT Rubro.nombre, 8, NO).
         RUN escribenumero ( INPUT chLinea + ",177", INPUT STRING(Caj_detalle.importe,"->>,>>>,>>9.99"), 8, NO).
         RUN escribenumero ( INPUT chLinea + ",70", INPUT dtl_rubro, 8, NO).
    
         i = i + 1.
    
    END.
    
    /*---------------------------------------------------------------------------------*/
    /*                                       PIE                                       */
    /*---------------------------------------------------------------------------------*/
    
    RUN pie.
        
    /*---------------------------------------------------------------------------------*/
    /*                                       FIN                                       */
    /*---------------------------------------------------------------------------------*/

END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresion de comprobantes de caja><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

END PROCEDURE.

PROCEDURE encabezado:

    /*---------------------------------------------------------------------------------*/
    /*                                    ENCABEZADO                                   */
    /*---------------------------------------------------------------------------------*/
    
    PUT STREAM Formulario UNFORMATTED "<=#1><AT=+5,+5><FROM><AT=+140,+200><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><AT=+35,+5><FROM><AT=+8,+200><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><AT=+5,+72><FROM><AT=+8,+57><RECT>". 

    RUN escribir ( INPUT "7,75", INPUT "COMPROBANTE DE EGRESO", 10, YES).

    RUN escribir ( INPUT "37,40", INPUT "DETALLE DE VALORES DEL COMPROBANTE", 10, YES).
    RUN escribir ( INPUT "37,180", INPUT "IMPORTES", 10, YES).
    PUT STREAM Formulario UNFORMATTED "<=#1><AT=+35,+170><FROM><AT=+110,+0><LINE>". 
    
    RUN escribir ( INPUT "7,10", INPUT Empresa.nombre, 10, YES).
    RUN escribir ( INPUT "11,10", INPUT Empresa.direccion, 8, NO).
    RUN escribir ( INPUT "15,10", INPUT Empresa.localidad , 8, NO).
    RUN escribir ( INPUT "19,10", INPUT Empresa.telefono , 8, NO).

    RUN escribir ( INPUT "7,175", INPUT "NRO.:" + STRING(Caj_header.nro_comprob,"999999"), 10, YES).

    RUN escribir ( INPUT "11,175", INPUT "Fecha:" + STRING(Caj_header.fecha,"99/99/99"), 8, NO).
    RUN escribir ( INPUT "15,175", INPUT "Hoja:" + STRING(n-hoja,"99"), 8, NO).

    RUN escribir ( INPUT "28,167", INPUT "Importe:" + STRING(Caj_header.importe,"->>,>>>,>>9.99"), 10, YES). 
    RUN escribir ( INPUT "26,10", INPUT "Obs.:" + Caj_header.observacion, 8, YES).


END PROCEDURE.

PROCEDURE pie:

    RUN escribir ( INPUT "140,150",  INPUT "TOTAL", 10, YES). 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=GRAY><AT=+138,+170><FROM><AT=+7,+35><FILLRECT>". 
    
    RUN escribenumero ( INPUT "140,177",  INPUT STRING(Caj_header.importe,"->>,>>>,>>9.99"), 8, YES). 

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

    linea = '<=#1><FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

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

     linea = '<=#1><FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><Fcourier><P' + puntos + '>'.
 /* linea = '<=#1><FGCOLOR=' + textColor + '><R+' + TRIM(STRING(i-linea,">>9")) + '><C+' + TRIM(STRING(i-columna,">>9")) + '><Fcourier ><P' + puntos + '>'.*/

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

PROCEDURE printFile EXTERNAL "xPrint.dll" :

    DEFINE INPUT PARAMETER a AS CHARACTER.

END PROCEDURE.
