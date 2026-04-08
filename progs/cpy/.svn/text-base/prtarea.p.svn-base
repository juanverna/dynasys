/*=================================================================================*/
/*                           IMPRESION DE ORDENES DE PAGO                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_tarea      LIKE Tarea.nro_tarea.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

/*{nommeses.i}*/
{xprint.i}

DEFINE VARIABLE TextColor                 AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color                  AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente                 AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                         AS INTEGER INITIAL 10.
DEFINE VARIABLE ncopia                    AS INTEGER.
DEFINE VARIABLE v-vigencia                AS CHARACTER.
DEFINE VARIABLE letras                    AS CHARACTER.
DEFINE VARIABLE renglones                 AS CHARACTER.
DEFINE VARIABLE monto_letras1             AS CHARACTER.

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 12.
DEFINE VARIABLE linea0                    AS INTEGER.
DEFINE VARIABLE n-linea                   AS INTEGER.
DEFINE VARIABLE j                         AS INTEGER.

DEFINE VARIABLE ch_linea                  AS CHARACTER.
DEFINE VARIABLE dtl_accion                AS CHARACTER.

DEFINE VARIABLE n_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE t_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE ancho                     AS DECIMAL INITIAL 1.0.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Tarea WHERE Tarea.nro_tarea = act_tarea NO-LOCK.
FIND Recurso OF Tarea NO-LOCK.
FIND Proyecto OF Tarea NO-LOCK.
RUN imprimir_tarea.

RUN UnLoadXprint.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_tarea:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\tarea.xpr" CONVERT TARGET "iso8859-1".

    ncopia = 1.
    RUN inicia_formulario.
    RUN encabezado_forma.
    RUN encabezado_datos.

    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\tarea.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    /*
    RUN poner ( '<PREVIEW=70>' )/*=ZoomToWidth>'*/. 
    
    RUN poner '<TOOLBAR=!PRINT>'.  
    */
    RUN poner ( "<PREVIEW=PDF><PDF-TITLE=Solicitud de Tarea><PDF-FONTS=BASE14><PDF-OUTPUT=C:\XPrint65\tar" + STRING(Tarea.nro_tarea,"99999") + ".pdf>").

    RUN poner ( "<OPORTRAIT><Title=Impresión de tareas><UNITS=mm><|2>" ).
    RUN poner ( "<FORMAT=A4>" ).

    RUN poner ( "<AT=0,0><#1>" ).    
    RUN poner ( "<AT=140,0><#2>" ).    

END PROCEDURE.

PROCEDURE encabezado_forma:
    
    RUN poner ( "<=#1><BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>" ). 
    RUN poner ( "<=#1><AT=+17,+13><#3><AT=+8,+60><IMAGE#3=..\imagenes\logo.bmp>" ).
    RUN poner ( "<=#1><BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+240,+190><FILLRECT)>" ). 
    RUN poner ( "<=#1><AT=+53,+10><FROM><AT=+8,+190><RECT>" ). 
    RUN poner ( "<=#1><AT=+100,+10><FROM><AT=+8,+190><RECT>" ). 
    RUN poner ( "<=#1><AT=+157,+10><FROM><AT=+8,+190><RECT>" ). 

    RUN escribir ( INPUT "18,75",  INPUT "SEGUIMIENTO DE TAREAS", 14, YES, "BLACK").

    RUN escribir ( INPUT "55,83", INPUT "DESCRIPCION DE LA TAREA", 10, YES, "BLACK").
    RUN escribir ( INPUT "102,66", INPUT "DESCRIPCION DE LAS ACCIONES EFECTUADAS", 10, YES, "BLACK").
    RUN escribir ( INPUT "159,70", INPUT "OBSERVACIONES ASOCIADAS A LA TAREA", 10, YES, "BLACK").

    RUN poner ( "<AT=+165,+53><FROM><AT=+103><LINE>" ). 

    RUN escribir ( INPUT "32,20", INPUT "Tarea:", INPUT 10, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "32,170", INPUT "Nro:", INPUT 12, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "38,20", INPUT "Solicitada:", INPUT 10, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "38,90", INPUT "Prevista:", INPUT 10, INPUT NO, "BLACK").     
    RUN escribir ( INPUT "38,150", INPUT "Resuelta:", INPUT 10, INPUT NO, "BLACK").     
    RUN escribir ( INPUT "42,20", INPUT "Proyecto:", INPUT 10, INPUT NO, "BLACK").     
    RUN escribir ( INPUT "42,150", INPUT "Hs. Estimadas:", INPUT 10, INPUT NO, "BLACK").     
    RUN escribir ( INPUT "46,20", INPUT "Recurso:", INPUT 10, INPUT NO, "BLACK").     
    RUN escribir ( INPUT "46,150", INPUT "Hs. Reales:", INPUT 10, INPUT NO, "BLACK").     

END PROCEDURE.

PROCEDURE encabezado_datos:

    RUN escribir ( INPUT "32,180", INPUT STRING(Tarea.nro_tarea,"99999"), INPUT 12, INPUT YES, "BLUE"). 
    RUN escribir ( INPUT "32,32", INPUT Tarea.titulo, INPUT 10, INPUT NO, "BLUE"). 
    RUN escribir ( INPUT "38,37", INPUT STRING(Tarea.fecha_reportado,"99/99/9999"), INPUT 10, INPUT NO, "BLUE"). 
    RUN escribir ( INPUT "38,57", INPUT Tarea.reportado_por, INPUT 10, INPUT NO, "BLUE").     
    RUN escribir ( INPUT "38,105", INPUT STRING(Tarea.fecha_prevista,"99/99/9999"), INPUT 10, INPUT NO, "BLUE").     
    IF Tarea.estado = "R"
        THEN RUN escribir ( INPUT "38,180", INPUT STRING(Tarea.fecha_resuelto,"99/99/9999"), INPUT 10, INPUT NO, "BLUE").     
    RUN escribir ( INPUT "42,35", INPUT Tarea.cdg_proyecto + " - " + Proyecto.dsc_proyecto, INPUT 10, INPUT NO, "BLUE").     
    RUN escribenumero ( INPUT "42,170",INPUT STRING(Tarea.horas_estimadas,">>9.99"),INPUT 10,INPUT NO, "BLUE").     
    RUN escribir ( INPUT "46,35", INPUT Tarea.cdg_recurso + " - " + Recurso.nom_recurso, INPUT 10, INPUT NO, "BLUE").     
    RUN escribenumero ( INPUT "46,170", INPUT STRING(Tarea.horas_reales,">>9.99"), INPUT 10, INPUT NO, "BLUE").

    IF Tarea.descripcion <> ""
    THEN DO:
        RUN RENGLONS.P (INPUT  Tarea.descripcion, 
                        INPUT  100,
                        OUTPUT dtl_accion,
                        INPUT  "|").
        linea0 = 1.
        DO j = 1 TO NUM-ENTRIES(dtl_accion,"|"):
            ch_linea = STRING(60 + linea0 * 4,">>9").                     
            RUN escribir ( INPUT ch_linea  + ",20", INPUT ENTRY(j,dtl_accion, "|"), INPUT 10, INPUT NO, "BLUE").
            linea0 = linea0 + 1.
        END.
    END.
   
    IF Tarea.accion <> ""
    THEN DO:
        RUN RENGLONS.P (INPUT  Tarea.accion, 
                    INPUT  100,
                    OUTPUT dtl_accion,
                    INPUT  "|").
        linea0 = 1.
        DO j = 1 TO NUM-ENTRIES(dtl_accion,"|"):
            ch_linea = STRING(107 + linea0 * 4,">>9").                     
            RUN escribir ( INPUT ch_linea  + ",20", INPUT ENTRY(j,dtl_accion, "|"), INPUT 10, INPUT NO, "BLUE").
            linea0 = linea0 + 1.
        END.
    END.

    linea0 = 1.
    FOR EACH Observacion OF Tarea:
        RUN RENGLONS.P (INPUT  Observacion.texto, 
                    INPUT  85,
                    OUTPUT dtl_accion,
                    INPUT  "|").

        DO j = 1 TO NUM-ENTRIES(dtl_accion,"|"):
            ch_linea = STRING(163 + linea0 * 4,">>9").                     
            IF j = 1 
            THEN DO:
                RUN escribir ( INPUT ch_linea  + ",13", INPUT STRING(Observacion.fch_alta,"99/99/9999"), INPUT 10, INPUT NO, "BLUE").
                RUN escribir ( INPUT ch_linea  + ",32", INPUT Observacion.cho_alta, INPUT 10, INPUT NO, "BLUE").
            END.
            RUN escribir ( INPUT ch_linea  + ",55", INPUT ENTRY(j,dtl_accion, "|"), INPUT 10, INPUT NO, "BLUE").
            linea0 = linea0 + 1.
        END.
    END.


END PROCEDURE.

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
                                       
    linea =  '<FGCOLOR=' + nomcolor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    RUN poner ( linea ).

END PROCEDURE.

PROCEDURE poner:

    DEFINE INPUT PARAMETER texto    AS CHARACTER.

    PUT STREAM Formulario UNFORMATTED texto.

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

    linea =  '<FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + CenterText(TRIM(texto), s-font, f-width).
    IF negrita THEN linea = linea + '</B>'.

    RUN poner ( linea ).

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

    RUN poner ( linea ).

END PROCEDURE.

