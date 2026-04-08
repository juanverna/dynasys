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
DEFINE VARIABLE det0           AS INTEGER INITIAL 72.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE max_det        AS INTEGER INITIAL 40. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 72. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 77. /* Ancho en chars de la leyenda  */

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
DEFINE VARIABLE v-leyenda      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto         AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Ped_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Ped_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE STREAM Formulario.

FUNCTION ch_linea RETURN CHARACTER ( INPUT n0 AS INTEGER, INPUT n AS INTEGER).
         RETURN STRING(n0 + n * 4,"9999").
END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
DO TRANSACTION:

    FIND Ped_header WHERE ROWID(Ped_header) = rid_pedido EXCLUSIVE-LOCK.

    FIND Condicion_impos OF Ped_header NO-LOCK.
    FIND Condicion_venta OF Ped_header NO-LOCK.
    FIND Cliente         OF Ped_header NO-LOCK NO-ERROR.
    FIND Domicilio       OF Ped_header NO-LOCK.
    FIND Provincia       OF Domicilio NO-LOCK.
    FIND Empresa         OF Ped_header NO-LOCK.
    FIND Tipo_embarque   OF Ped_header NO-LOCK.
    
    que_mes = STRING(MONTH(Ped_header.fecha),"99").
    que_ano = STRING(YEAR(Ped_header.fecha),"9999").
    que_dia = STRING(DAY(Ped_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Ped_header.fecha) ] + " de " + que_ano.
        
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DEL PEDIDO                                  */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\prpin114.xpr" CONVERT TARGET "iso8859-1".

    ncopia = 1.
    n_hoja = 0.
    RUN forma.
   
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\prpin114.xpr".
      
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

 /* PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. */
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Pro-forma Invoice><UNITS=mm><|2><PREVIEW=40>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    PUT STREAM Formulario CONTROL "<#1>".    
    PUT STREAM Formulario CONTROL "<R172><C1><#2>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+15,+5><FROM><AT=+38,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+53,+5><FROM><AT=+180,+190><FILLRECT)>". 

/*  ---------- Boxes
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+237,+138><FROM><AT=+25,+30><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+237,+168><FROM><AT=+25,+27><FILLRECT)>". 
*/

    RUN escribir ( INPUT "07,150", INPUT "<B>PRO-FORMA INVOICE</B>", INPUT 9, INPUT NO). 
    
    RUN escribir ( INPUT "20,20",Empresa.nombre, INPUT 12, INPUT YES).

    RUN escribir ( INPUT "25,20",INPUT "Adress : " + Empresa.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "28,20",INPUT "CNPJ:",INPUT 8,INPUT NO).
    
    RUN escribir (INPUT "41,20",INPUT "INVOICE Nº : " + STRING(Ped_header.nro_comprob,"999999"),INPUT 8,INPUT NO).
    RUN escribir (INPUT "44,20",INPUT "INVOICE DATE : " + STRING(Ped_header.fecha_comex,"99/99/9999"),INPUT 8,INPUT NO).
    
    RUN escribir (INPUT "31,90",INPUT "Importer",INPUT 8,YES).
    RUN escribir (INPUT "34,90",INPUT Cliente.nom_cliente,INPUT 7,INPUT NO).
    RUN escribir (INPUT "37,90",INPUT Cliente.direccion,INPUT 7,INPUT NO).
    RUN escribir (INPUT "41,90",INPUT Cliente.localidad,INPUT 7,INPUT NO).
    RUN escribir (INPUT "44,90",INPUT "CNPJ : (SEA LO QUE SEA)", INPUT 7,INPUT NO).

    RUN escribir (INPUT "55,20",INPUT "Customer code : " + Cliente.cdg_cliente,INPUT 7,INPUT NO).
    RUN escribir (INPUT "58,20",INPUT "Terms of Delivery : " + Condicion_venta.descripcion,INPUT 7,INPUT NO).
    RUN escribir (INPUT "55,95",INPUT "Forwarding : " + Tipo_embarque.descripcion_ing,INPUT 7,INPUT NO).
    RUN linea ("63,5","190","H").

    RUN escribir ( INPUT "65,9",  INPUT "Code", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "65,70", INPUT "Description", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "65,135",INPUT "Quantity",INPUT 8,INPUT NO).
    RUN escribir ( INPUT "65,155",INPUT "Unit Price", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "65,180",INPUT "Total", INPUT 8, INPUT NO).

    RUN linea ("070,005","190","H").
    RUN linea ("063,022","157","V").
    RUN linea ("063,130","157","V").
    RUN linea ("063,150","157","V").
    RUN linea ("063,170","157","V").
    RUN linea ("220,005","190","H").
    RUN linea ("249,150","040","H").
    
    RUN escribir (INPUT "245,160",INPUT "Seller Signature", INPUT 8,INPUT YES).
    RUN escribir (INPUT "250,160",INPUT "Seller Company", INPUT 8,INPUT YES).
    RUN escribir (INPUT "254,160",INPUT "signatory's name", INPUT 8,INPUT YES).
    
    

    RUN escribir (INPUT "225,140",INPUT "TOTAL - U$S",INPUT 10,INPUT YES).
    RUN escribenumero(INPUT "225,170",INPUT STRING(Ped_header.imp_neto,"->>>>9.99"),INPUT 9, INPUT YES).
    
    RUN escribir (INPUT "240,30",INPUT "Nº CARTONS : " ,INPUT 10,INPUT YES).
    RUN escribir (INPUT "245,30",INPUT "TOTAL GROSS WEIGHT : " ,INPUT 10,INPUT YES).
    RUN escribir (INPUT "250,30",INPUT "TOTAL NET WEIGHT : " ,INPUT 10,INPUT YES).

    linea0 = 1.

END PROCEDURE.

PROCEDURE forma:

    RUN inicia_hoja.

    FOR EACH Ped_detalle OF Ped_header, Articulo OF Ped_detalle,
        Partida OF Ped_detalle
        BREAK BY Articulo.cdg_articulo BY Partida.cdg_partida:

        IF linea0 > max_det
        THEN DO:
             RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "CONTINUA EN HOJA " + STRING(n_hoja + 1,">9"), INPUT 12, INPUT YES).
             OUTPUT STREAM Formulario CLOSE.
             FILE-INFO:File-NAME = "c:\sic-temp\prpin114.xpr".
             RUN printFile( FILE-INFO:FULL-PATHNAME).

             OUTPUT STREAM Formulario TO "c:\sic-temp\prpin114.xpr" CONVERT TARGET "iso8859-1".
             RUN inicia_hoja.             
        END.
        
        RUN escribir      ( ch_linea(det0,linea0)  + ",009", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
        RUN escribir      ( ch_linea(det0,linea0)  + ",025", INPUT Articulo.descripcion, INPUT 8, INPUT NO). 
        RUN escribenumero ( ch_linea(det0,linea0)  + ",130", INPUT STRING(Ped_detalle.cantidad,"ZZZZZZ9"), INPUT 8, INPUT NO).
        RUN escribenumero ( ch_linea(det0,linea0)  + ",145", INPUT STRING(Ped_detalle.precio,"->>>>9.99"), INPUT 8, INPUT NO).
        RUN escribenumero ( ch_linea(det0,linea0)  + ",170", INPUT STRING(Ped_detalle.subtotal_neto,"->>>>9.99"),INPUT 8,INPUT NO).
        linea0 = linea0 + 1.

        total_articulo = total_articulo + Ped_detalle.cantidad.    

/*        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:
             RUN linea         ( ch_linea(det0 + 1,linea0)  + ",144", INPUT "20", "H" ).
             linea0 = linea0 + 1.       
             RUN escribenumero ( ch_linea(det0,linea0)  + ",144", INPUT STRING(total_articulo,"ZZZZZZ9"), INPUT 8, INPUT NO).
             linea0 = linea0 + 2.       
             total_articulo = 0.
        END. */
    
    END.

/*    RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "FIN DE LOS ITEMS DE PEDIDO", INPUT 12, INPUT YES).

    IF Ped_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Ped_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
    
        linea0 = 237.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT ENTRY(j,v-leyenda, "|"), INPUT 10, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    
    END.*/

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
