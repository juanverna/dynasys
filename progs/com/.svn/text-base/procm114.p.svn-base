/*=================================================================================*/
/*                     IMPRESION DE FORMULARIO DE PEDIDOS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_pedido AS ROWID.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.
DEFINE VARIABLE det0           AS INTEGER INITIAL 62.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE max_det        AS INTEGER INITIAL 47. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 72. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_observacion AS INTEGER INITIAL 7.  /* Cantidad de lineas de observacion */
DEFINE VARIABLE v-leng_observacion AS INTEGER INITIAL 75. /* Ancho en chars de la observacion  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.
DEFINE VARIABLE n_hoja         AS INTEGER.

DEFINE VARIABLE total_articulo AS INTEGER.

DEFINE VARIABLE que_dia        AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes        AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano        AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo       AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada    AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-monto_letras AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-observacion  AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto         AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Ocm_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE STREAM Formulario.

FUNCTION ch_linea RETURN CHARACTER ( INPUT n0 AS INTEGER, INPUT n AS INTEGER).
    RETURN STRING(n0 + n * 4,"9999").
END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
DO TRANSACTION:

    FIND Ocm_header WHERE ROWID(Ocm_header) = rid_pedido EXCLUSIVE-LOCK.

    FIND Condicion_impos OF Ocm_header NO-LOCK.
    FIND Condicion_venta OF Ocm_header NO-LOCK.
    FIND Proveedor       OF Ocm_header NO-LOCK NO-ERROR.
    FIND Domicilio_prv   OF Ocm_header NO-LOCK.
    FIND Provincia       OF Domicilio_prv NO-LOCK.
    /*FIND Estado   OF Ocm_header NO-LOCK.*/

    que_mes = STRING(MONTH(Ocm_header.fecha),"99").
    que_ano = STRING(YEAR(Ocm_header.fecha),"9999").
    que_dia = STRING(DAY(Ocm_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Ocm_header.fecha) ] + " de " + que_ano.
        
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DEL PEDIDO                                  */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\ocompra114.xpr" CONVERT TARGET "iso8859-1".

    ncopia = 1.
    n_hoja = 0.
    RUN forma.
   
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\ocompra114.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
    /*
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */
    */

END.
RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE inicia_hoja:

    n_hoja = n_hoja + 1.

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.    
  /*PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.                   */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de Pedido Nro.:" + STRING(Ocm_header.nro_comprob,'999999')
                                  + " Hoja:" + STRING(n_hoja,'>9') + "><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    PUT STREAM Formulario CONTROL "<#1>".    
    PUT STREAM Formulario CONTROL "<R172><C1><#2>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+10,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+15,+5><FROM><AT=+42,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+57,+5><FROM><AT=+200,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+257,+5><FROM><AT=+25,+190><FILLRECT)>". 

/*  ---------- Boxes
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+237,+138><FROM><AT=+25,+30><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+237,+168><FROM><AT=+25,+27><FILLRECT)>". 
*/

    RUN escribir ( INPUT "07,70", INPUT "ORDEN DE COMPRA", INPUT 14, INPUT YES). 
    RUN escribir ( INPUT "07,165", INPUT "<B>NRO:</B>" + STRING(Ocm_header.nro_comprob), INPUT 12, INPUT NO). 

    RUN escribir ( INPUT "25,20", INPUT "<B>FECHA:</B>" + que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT NO). 

    RUN escribir ( INPUT "20,115", INPUT "<B>HOJA:</B>" + STRING(n_hoja,'>9'), INPUT 12, INPUT NO). 

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+18,+183><FROM><AT=+9,+9><FILLRECT)>". 
    RUN escribir ( INPUT "20,186", INPUT Ocm_header.cdg_empresa, INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "33,20", INPUT "[" + Proveedor.cdg_Proveedor + "] " + Proveedor.nombre, INPUT 10, INPUT YES).
    RUN escribir ( INPUT "33,115", INPUT "<B>Alta:</B>" + STRING(Ocm_header.fecha,"99/99/99") , INPUT 10, INPUT NO). 

    RUN escribir ( INPUT "37,20", INPUT Domicilio_prv.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "37,115", INPUT "<B>Estado:</B>" + Ocm_header.cdg_estado, INPUT 10, INPUT NO).

    RUN escribir ( INPUT "41,20", INPUT "(" + Domicilio_prv.cdg_postal + ") " +  
                 Domicilio_prv.localidad, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "45,20", INPUT Provincia.nombre, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "51,20", INPUT "Transporte:" + Ocm_header.transportista, INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",9", INPUT "Código", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",28", INPUT "Descripción", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",114", INPUT "Color", INPUT 8, INPUT NO).
    
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",128", INPUT "Pedido", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",146", INPUT "Precio sin IVA", INPUT 8, INPUT NO).
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",175", INPUT "Entrega", INPUT 8, INPUT NO).

    RUN linea    ( ch_linea(det0 - 2,1)  + ",5", INPUT "190", "H" ).

    RUN linea    ( "57,26", INPUT "200", "V" ).
    RUN linea    ( "57,110", INPUT "200", "V" ).
    RUN linea    ( "57,124", INPUT "200", "V" ).
    RUN linea    ( "57,138", INPUT "225", "V" ).
    RUN linea    ( "57,168", INPUT "225", "V" ).

    RUN linea    ( "262,138", INPUT "57", "H" ).

    RUN escribir ( INPUT "258,143", INPUT "Importe Neto", INPUT 8, INPUT YES).
    RUN escribir ( INPUT "258,171", INPUT "Importe Total", INPUT 8, INPUT YES).

    
    RUN escribenumero ( INPUT "267,141", INPUT Ocm_header.imp_neto, INPUT 12, INPUT YES).
    RUN escribenumero ( INPUT "267,169", INPUT Ocm_header.imp_total, INPUT 12, INPUT YES).
    
    linea0 = 1.

END PROCEDURE.

PROCEDURE forma:

    RUN inicia_hoja.

    FOR EACH Ocm_detalle OF Ocm_header NO-LOCK, Articulo OF Ocm_detalle NO-LOCK,
        Partida OF Ocm_detalle NO-LOCK
        BREAK BY Articulo.cdg_articulo BY Partida.cdg_partida:

        IF linea0 > max_det
        THEN DO:
           /*RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "CONTINUA EN HOJA " + STRING(n_hoja + 1,">9"), INPUT 12, INPUT YES).*/
             RUN escribir ( "258,30", INPUT "CONTINUA EN HOJA " + STRING(n_hoja + 1,">9"), INPUT 12, INPUT YES).
             OUTPUT STREAM Formulario CLOSE.
             FILE-INFO:File-NAME = "c:\sic-temp\ocompra114.xpr".
             RUN printFile( FILE-INFO:FULL-PATHNAME).
             
             OUTPUT STREAM Formulario TO "c:\sic-temp\ocompra114.xpr" CONVERT TARGET "iso8859-1".
             RUN inicia_hoja.             
        END.

        RUN escribir      ( ch_linea(det0,linea0)  + ",9", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
        RUN escribir      ( ch_linea(det0,linea0)  + ",28", INPUT Articulo.descripcion, INPUT 8, INPUT NO).
        RUN escribir      ( ch_linea(det0,linea0)  + ",112", INPUT Partida.cdg_partida, INPUT 8, INPUT NO).
        RUN escribenumero ( ch_linea(det0,linea0)  + ",117", INPUT STRING(Ocm_detalle.cantidad,"ZZZZZZ9"), INPUT 8, INPUT NO).
        RUN escribenumero ( ch_linea(det0,linea0)  + ",145", INPUT STRING(Ocm_detalle.precio,"->>>>9.9999"), INPUT 8, INPUT NO). 
        RUN escribenumero ( ch_linea(det0,linea0)  + ",170", INPUT STRING(Ocm_detalle.fecha_temprana,"99/99/99"), INPUT 8, INPUT NO). 
        /*RUN linea         ( ch_linea(det0 + 3,linea0)  + ",170", INPUT "23", "H" ).*/
        linea0 = linea0 + 1.

        total_articulo = total_articulo + Ocm_detalle.cantidad.    
        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:
            IF NOT CAN-FIND(FIRST Partida OF Articulo 
                            WHERE Partida.cdg_partida = "" )
            THEN DO:
                RUN linea         ( ch_linea(det0 + 1,linea0)  + ",126", INPUT "11", "H" ).
                linea0 = linea0 + 1.       
                RUN escribenumero ( ch_linea(det0,linea0)  + ",117", INPUT STRING(total_articulo,"ZZZZZZ9"), INPUT 8, INPUT NO).
            END.
            linea0 = linea0 + 2.       
            total_articulo = 0.
        END. 
    
    END.

    RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "FIN DE LOS ITEMS DE O/COMPRA", INPUT 12, INPUT YES).
    
    
    IF Ocm_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Ocm_header.leyenda, 
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

    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    offset = DECIMAL(ENTRY(2,ENTRY(1,RightJustify(TRIM(texto), s-font, ancho),">"),",")) * 12.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")) + offset.
    /*
    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
    */
    linea = '<FGCOLOR=BLACK' + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
            TRIM(STRING(i-columna,">>9.999999")) + '>' +
            ( IF negrita THEN '<B>' ELSE '')  + 
            "<DECIMAL=+0>" + texto + 
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
