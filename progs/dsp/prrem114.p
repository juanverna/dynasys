/*=================================================================================*/
/*                  IMPRESION DE FORMULARIO DE REMITOS                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_remito AS ROWID.

/*=================================================================================*/
/*                                  VARIABLES                                      */
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

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 40. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 55. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 50. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE v-cantidad     LIKE Fac_detalle.cantidad.
DEFINE VARIABLE v-subtotal     LIKE Fac_detalle.subtotal_neto.
DEFINE VARIABLE v-declarado    AS DECIMAL.

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.

DEFINE VARIABLE ch_linea       AS CHARACTER.
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
DEFINE VARIABLE importe_iva    LIKE Rem_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Rem_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Rem_header WHERE ROWID(Rem_header) = rid_remito EXCLUSIVE-LOCK.
    FIND Condicion_impos OF Rem_header NO-LOCK.
    FIND Condicion_venta OF Rem_header NO-LOCK.
    FIND Provincia OF Rem_header NO-LOCK.
    FIND Cliente   OF Rem_header NO-LOCK NO-ERROR.
    FIND Vendedor OF Rem_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Rem_header NO-LOCK NO-ERROR.
    FIND Cobrador OF Cliente NO-LOCK.
    
    FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.
    
    que_mes = STRING(MONTH(Rem_header.fecha),"99").
    que_ano = STRING(YEAR(Rem_header.fecha),"9999").
    que_dia = STRING(DAY(Rem_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Rem_header.fecha) ] + " de " + que_ano.
        
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DE LA FACTURA                               */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\rem114.xpr" CONVERT TARGET "iso8859-1".
      
 /* PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. */
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    PUT STREAM Formulario CONTROL "<#1>".    
    PUT STREAM Formulario CONTROL "<R172><C1><#2>".    

    ncopia = 1.
    RUN forma.
    
    OUTPUT STREAM Formulario CLOSE.
     
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = "c:\sic-temp\rem114.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */
END.
RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE forma:

/*  RUN escribir ( INPUT "20,145", INPUT str_fecha, INPUT 8, INPUT NO). */

    RUN escribir ( INPUT "20,177", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 8, INPUT NO).
/*
    RUN escribir ( INPUT "24,150", INPUT que_mes, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "22,160", INPUT que_ano, INPUT 8, INPUT NO).
*/    
    RUN escribir ( INPUT "41,30", INPUT Cliente.nom_cliente, INPUT 10, INPUT YES).
    RUN escribir ( INPUT "41,133", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 10, INPUT NO).

    RUN escribir ( INPUT "45,30", INPUT Domicilio.direccion, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "45,133", INPUT "(" + Domicilio.cdg_postal + ") " +  
                 Domicilio.localidad, INPUT 8, INPUT YES).

    RUN escribir ( INPUT "49,30", INPUT Provincia.nombre, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "53,30", INPUT Condicion_impos.texto, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "53,140", INPUT Cliente.cuit, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "57,30", INPUT "[" + Cobrador.cdg_cobrador + "]", INPUT 8, INPUT NO).
    
    RUN escribir ( INPUT "64,43", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO).
    IF AVAILABLE Ped_header
       THEN RUN escribir ( INPUT "64,108", INPUT STRING(Ped_header.nro_comprob,">>>>>9"), INPUT 8, INPUT NO).

    linea0 = 1.
    v-cantidad = 0.
    v-subtotal = 0.
    v-declarado = 0.

    FOR EACH Rem_detalle OF Rem_header, Articulo OF Rem_detalle, Partida OF Rem_detalle BREAK BY Articulo.cdg_articulo:

        v-declarado = v-declarado + Rem_detalle.cantidad * Rem_detalle.precio.
        v-cantidad = v-cantidad + Rem_detalle.cantidad.
        
        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:

            ch_linea = STRING(73 + linea0 * 4,">>9").  
    
            RUN escribenumero ( ch_linea  + ",2", INPUT STRING(v-cantidad,"ZZZZZZ9"), INPUT 8, INPUT NO).
    
            RUN escribir      ( ch_linea  + ",32", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
            RUN escribir      ( ch_linea  + ",62", INPUT Articulo.descripcion, INPUT 8, INPUT NO).
    
            v-cantidad = 0.
    
            linea0 = linea0 + 1.

        END.
        
    END.
    
    IF Rem_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Rem_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
    
        linea0 = 230.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT ENTRY(j,v-leyenda, "|"), INPUT 10, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    
    END.

/*
    RUN escribenumero ( INPUT "242,170", INPUT STRING(Rem_header.imp_neto,"-ZZZ,ZZ9.99"), INPUT 10, INPUT NO).
      
    RUN escribenumero ( INPUT "246,170", INPUT STRING(Rem_header.imp_iva,"-ZZZ,ZZ9.99"), INPUT 10, INPUT NO).
    RUN escribenumero ( INPUT "250,170", INPUT STRING(importe_noi,"-ZZZ,ZZ9.99"), INPUT 10, INPUT NO).

*/
    RUN escribir ( INPUT "250,10", INPUT "Valor Declarado:" + STRING(v-declarado,"-ZZZ,ZZ9.99"), INPUT 10, INPUT YES).
    RUN escribir ( INPUT "254,10", INPUT "   Total Bultos:" + STRING(Rem_header.tot_bultos,">>>>>9"), INPUT 10, INPUT YES).

    RUN escribir      ( INPUT "271,120", INPUT STRING(Rem_header.prf_comprob,"9999") + " " + STRING(Rem_header.nro_comprob,"99999999"), INPUT 8, INPUT NO).

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

