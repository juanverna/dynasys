/*=================================================================================*/
/*                    IMPRIME EL FORMULARIO EN BLANCO DEL LIBRO DEL VIAJANTE       */
/*=================================================================================*/

{xprint.i}

DEFINE VARIABLE TextColor              AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color               AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente              AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                      AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f                AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c                AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia                 AS INTEGER.
DEFINE VARIABLE ancho                  AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE n-pagina               AS INTEGER.
DEFINE VARIABLE n-linea                AS INTEGER.
DEFINE VARIABLE h-linea                AS INTEGER INITIAL 4.
DEFINE VARIABLE linea0                 AS INTEGER INITIAL 60.
DEFINE VARIABLE n-maxlinea             AS INTEGER INITIAL 30.
DEFINE VARIABLE ch_linea               AS CHARACTER.
DEFINE VARIABLE j                      AS INTEGER.

DEFINE VARIABLE des_hoja               AS INTEGER LABEL "Desde Hoja" INITIAL 1.
DEFINE VARIABLE has_hoja               AS INTEGER LABEL "Hasta Hoja" INITIAL 50.

DEFINE STREAM Formulario.

{vrshared.i "new"}
{WGLISTAR.I}
{dfvarimp.i}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

UPDATE des_hoja has_hoja 
       WITH  FRAME f VIEW-AS DIALOG-BOX THREE-D SIDE-LABELS TITLE "Rango a imprimir".

{findempresa.i}
SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
RUN LISTAR_TODO.
IF n-linea <> 0 THEN RUN cerrar_hoja.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

    n-pagina = des_hoja - 1.
    DO j = des_hoja to has_hoja:
  
       RUN iniciar_hoja.
       RUN cerrar_hoja.
  
    END.   

END PROCEDURE.

PROCEDURE iniciar_hoja:

    OUTPUT STREAM Formulario TO "c:\sic-temp\libro.xpr" CONVERT TARGET "iso8859-1".

    n-pagina = n-pagina + 1.
    n-linea = 0.
    
 /* PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. */
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OLANDSCAPE><Title=Formulario del Libro del Viajante - Hoja:" STRING(n-pagina,">>>>9") "><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    PUT STREAM Formulario CONTROL "<#1>".    

                      /* datos fijos del encabezado */

    RUN escribir ( INPUT "10,0",   INPUT Empresa.nombre , INPUT 8, INPUT NO).
    RUN escribir ( INPUT "10,115", INPUT "Libro del Viajante", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "10,254", INPUT "Página:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "14,0",   INPUT Empresa.cuit, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "14,115", INPUT "Ley 14546 Art. 10", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "14,254", INPUT "Fecha:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "18,0",   INPUT Empresa.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "18,115", INPUT "Operaciones del " , INPUT 8, INPUT NO).
    RUN escribir ( INPUT "18,254", INPUT "Hora: ", INPUT 8, INPUT NO).
 
    RUN escribir ( INPUT "22,0",   INPUT "(" + Empresa.codigo_postal + ") " + Empresa.localidad, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "26,0",   INPUT Empresa.provincia, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "26,115", INPUT "Viajante:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "34,25",  INPUT "Zona:", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "34,145", INPUT "Productos:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "38,25",  INPUT "Nro. de CUIL:", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "38,145", INPUT "Nro. de Legajo:", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "38,235", INPUT "Fecha de Ingreso:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "42,25",  INPUT "Sueldo Garantido:", INPUT 8, INPUT NO).   
    RUN escribir ( INPUT "42,145", INPUT "Comisión x ventas:", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "42,235", INPUT "Comisión x cobranzas:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "46,25",  INPUT "Viáticos: 0.00", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "46,145", INPUT "Otros:0.00", INPUT 8, INPUT NO).   

    RUN escribir ( INPUT "54,16",  INPUT "Fecha", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,16",  INPUT "Pedido", INPUT 8, INPUT NO).  

    RUN escribir ( INPUT "54,36",  INPUT "Identificación", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,36",  INPUT "del Pedido", INPUT 8, INPUT NO).             

    RUN escribir ( INPUT "54,66",  INPUT "Estado del", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,66",  INPUT "Pedido", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "54,96",  INPUT "Importe", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,96",  INPUT "Pedido", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "54,116",  INPUT "Identificación", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,116",  INPUT "de la Factura", INPUT 8, INPUT NO).             

    RUN escribir ( INPUT "54,166", INPUT "Importe", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,166", INPUT "Vendido", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "54,186", INPUT "Comisión", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,186", INPUT "S/Vendido", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "54,206", INPUT "Importe", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,206", INPUT "Cobrado", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "54,226", INPUT "Comisión", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,226", INPUT "S/Cobrado", INPUT 8, INPUT NO).


                   /* datos variables del encabezado */


    RUN escribir ( INPUT "10,265", INPUT STRING(n-pagina,"999999"), INPUT 8, INPUT NO).


END PROCEDURE.

PROCEDURE cerrar_hoja:

  OUTPUT STREAM Formulario CLOSE.
  FILE-INFO:File-NAME = "c:\sic-temp\libro.xpr".
  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
  
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
