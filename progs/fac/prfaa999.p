/*=================================================================================*/
/*         IMPRESION DE FORMULARIO DE FACTURACION TIPO A                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

{NOMMESES.I}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 20. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 55. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 72. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE v-bonifs       AS CHARACTER FORMAT "X(21)" .

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.

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
DEFINE VARIABLE importe_iva     LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi     LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

/*=================================================================================*/


DO TRANSACTION:

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura EXCLUSIVE-LOCK.
    FIND Condicion_impos OF Fac_header NO-LOCK.
    FIND Condicion_venta OF Fac_header NO-LOCK.
    FIND Provincia OF Fac_header NO-LOCK.
    FIND Cliente   OF Fac_header NO-LOCK NO-ERROR.
    FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Fac_header NO-LOCK NO-ERROR.
    FIND Cobrador OF Cliente NO-LOCK.
    
    FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
    IF AVAILABLE Rem_header 
       THEN FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.
    
    FIND Impuesto 2 NO-LOCK.
    prcnoi = Impuesto.tasa.
    FIND FIRST Sub_detalle_vta OF Fac_header WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta NO-ERROR.
    IF AVAILABLE Sub_detalle_vta 
        THEN importe_noi = Sub_detalle_vta.valor.
        ELSE importe_noi = 0.
    
    que_mes = STRING(MONTH(Fac_header.fecha),"99").
    que_ano = STRING(YEAR(Fac_header.fecha),"9999").
    que_dia = STRING(DAY(Fac_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Fac_header.fecha) ] + " de " + que_ano.
        
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DE LA FACTURA                               */
    /*---------------------------------------------------------------------------------*/
    
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT TO "./prl/faa928.xpr" CONVERT TARGET "iso8859-1".
      
    PUT CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.
  /*PUT CONTROL '<TOOLBAR=!PRINT>'.*/
    
    PUT CONTROL "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>".
    PUT CONTROL "<FORMAT=LEGAL>".
    PUT CONTROL "<#1>".    
    PUT CONTROL "<R172><C1><#2>".    

    ncopia = 1.
    RUN forma.
    
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = "./prl/faa928.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME).
    
END.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE forma:

    RUN escribir ( INPUT "08,120", INPUT "FACTURA", INPUT 16, INPUT YES).

    RUN escribir ( INPUT "31,169", INPUT que_dia, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "31,183", INPUT que_mes, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "31,194", INPUT que_ano, INPUT 8, INPUT NO).
    
    RUN escribir ( INPUT "44,30", INPUT Cliente.nom_cliente, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "44,133", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "48,30", INPUT Domicilio.direccion, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "48,133", INPUT "(" + Domicilio.cdg_postal + ") " +  
                 Domicilio.localidad, INPUT 8, INPUT YES).

    RUN escribir ( INPUT "53,30", INPUT Condicion_impos.texto, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "53,133", INPUT Cliente.cuit, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "53,170", INPUT "[" + Cobrador.cdg_cobrador + "]", INPUT 8, INPUT NO).
    
    RUN escribir ( INPUT "60,40", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "60,90", INPUT "Período: " + STRING(Fac_header.mes,"99") + " / " + STRING(Fac_header.ano,"9999"), INPUT 8, INPUT NO).

    linea0 = 78.
    FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle:
    
        v-bonifs = "  ".
        FOR EACH Fac_detalle-bon OF Fac_detalle NO-LOCK:
            v-bonifs = v-bonifs + STRING(Fac_detalle-bon.porcentaje,"ZZ9.99") + " ".
        END.    

    
        IF Articulo.extendida
        THEN DO:
            IF Fac_detalle.detallada <> ""
                THEN RUN RENGLONS.P (INPUT  Fac_detalle.detallada, 
                                     INPUT  v-leng_detalle,
                                     OUTPUT v-detallada,
                                     INPUT  "|").
                                     
            DO j = 1 TO NUM-ENTRIES(v-detallada, "|"):
                
               RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",30", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO).
                IF j = NUM-ENTRIES(v-detallada, "|")
                   THEN RUN escribenumero ( INPUT TRIM(STRING(linea0,">>9")) + ",187", INPUT STRING(Fac_detalle.subtotal_neto,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
        
                linea0 = linea0 + 4.
        
            END.
            linea0 = linea0 + 4.
        END.
        ELSE DO:
           RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",30", Articulo.cdg_articulo, INPUT 8, INPUT NO).
           RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",60", Articulo.descripcion, INPUT 8, INPUT NO).
           RUN escribenumero ( INPUT TRIM(STRING(linea0,">>9")) + ",127", INPUT STRING(Fac_detalle.cantidad,"-ZZZ,ZZ9"), INPUT 8, INPUT NO).
           RUN escribenumero ( INPUT TRIM(STRING(linea0,">>9")) + ",140", INPUT STRING(Fac_detalle.precio,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
           RUN escribenumero ( INPUT TRIM(STRING(linea0,">>9")) + ",160", INPUT v-bonifs, INPUT 8, INPUT NO).
           RUN escribenumero ( INPUT TRIM(STRING(linea0,">>9")) + ",187", INPUT STRING(Fac_detalle.subtotal_neto,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
           linea0 = linea0 + 4.

        END.
    
    END.
    
    RUN RENGLONS.P (INPUT  Fac_header.monto_letras, 
                    INPUT  v-leng_monto,
                    OUTPUT v-monto_letras,
                    INPUT  "|").
    
    linea0 = 148.
    DO j = 1 TO v-reng_monto:
        IF j <= NUM-ENTRIES(v-monto_letras, "|")
           THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",20", INPUT ENTRY(j,v-monto_letras, "|"), INPUT 8, INPUT NO).
        linea0 = linea0 + 4.
    END.
    
    IF Fac_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Fac_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
    
        linea0 = 150.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT ENTRY(j,v-leyenda, "|"), INPUT 8, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    
    END.

    RUN escribir ( INPUT "148,187", INPUT STRING(Fac_header.imp_neto,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
      
    RUN escribir ( INPUT "162,187", INPUT STRING(Fac_header.imp_total,"-ZZZ,ZZ9.99"), INPUT 8, INPUT YES).

    RUN escribir ( INPUT "165,132", INPUT STRING(Fac_header.imp_iva,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
    RUN escribir ( INPUT "165,159", INPUT STRING(importe_noi,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).

    RUN escribir ( INPUT "167,40", INPUT STRING(Fac_header.prf_comprob,"9999") + " " + STRING(Fac_header.nro_comprob,"99999999"), INPUT 8, INPUT NO).

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

    linea = '<FGCOLOR=' + textColor + '><AT=' + TRIM(STRING(( ncopia - 1 ) * 177 + i-linea,">>9")) + ',' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT UNFORMATTED linea.

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

    linea = '<FGCOLOR=' + textColor + '><AT=' + TRIM(STRING(( ncopia - 1 ) * 177 + i-linea,">>9")) + ',' + TRIM(STRING(i-columna,">>9")) + '><Flineprinter><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT UNFORMATTED linea.

END PROCEDURE.

PROCEDURE printFile EXTERNAL "xPrint.dll" :

    DEFINE INPUT PARAMETER a AS CHARACTER.

END PROCEDURE.
