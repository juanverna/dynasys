/*=================================================================================*/
/*                 IMPRESION DE FORMULARIO DE FACTURACION TIPO B                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}

DEFINE VARIABLE TextColor         AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color          AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente         AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                 AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f           AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c           AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia            AS INTEGER.
                                  
DEFINE VARIABLE ancho             AS DECIMAL INITIAL 1.0.
                                  
DEFINE VARIABLE nmax_det          AS INTEGER INITIAL 40. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle    AS INTEGER INITIAL 55. /* Ancho en chars del detalle    */
                                  
DEFINE VARIABLE v-reng_leyenda    AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda    AS INTEGER INITIAL 72. /* Ancho en chars de la leyenda  */
                                  
DEFINE VARIABLE v-reng_monto      AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto      AS INTEGER INITIAL 60. /* Ancho en chars del monto      */
                                  
DEFINE VARIABLE j                 AS INTEGER.
DEFINE VARIABLE nreng             AS INTEGER.
DEFINE VARIABLE linea0            AS INTEGER.
                                  
DEFINE VARIABLE v-cantidad        LIKE Fac_detalle.cantidad.
DEFINE VARIABLE v-subtotal        LIKE Fac_detalle.subtotal_neto.

DEFINE VARIABLE ch_linea          AS CHARACTER.
DEFINE VARIABLE que_dia           AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes           AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano           AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha         AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo          AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada       AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-monto_letras    AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-leyenda         AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto            AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE prciva            LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi            LIKE Impuesto.tasa FORMAT "ZZ9.99".
                                    
DEFINE VARIABLE importe_iva       LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi       LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-descuentos      AS CHARACTER FORMAT "X(28)" .
DEFINE VARIABLE v-desc            LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-importe_descuentos        AS DECIMAL.
DEFINE VARIABLE v-importe_bruto   AS DECIMAL.
DEFINE VARIABLE v-importe         AS DECIMAL.
DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura EXCLUSIVE-LOCK.
    FIND Tipocomprobante OF Fac_header NO-LOCK.
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

    v-importe_bruto = 0.
    FOR EACH Fac_detalle OF Fac_header:
        v-importe_bruto = v-importe_bruto + Fac_detalle.subtotal_bruto_cf.
    END.
    v-importe_descuentos = Fac_header.imp_total - v-importe_bruto. 
        
    v-descuentos = "".
    FOR EACH Fac_header-bon OF Fac_header:
        v-descuentos = v-descuentos + STRING(Fac_header-bon.porcentaje," %>>9.99").
    END.
    v-descuentos = SUBSTRING(v-descuentos,2).
    
    Fac_header.impreso = "S".    

    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DE LA FACTURA                               */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\prfab114.xpr" CONVERT TARGET "iso8859-1".
      
  /*PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. */
  /*PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    IF SESSION:PRINTER-NAME = "HP Laserjet 1100"
       THEN PUT STREAM Formulario CONTROL "<AT=12,8><#1>".    
       ELSE PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    
    PUT STREAM Formulario CONTROL "<AT=172,10><#2>".    

    ncopia = 1.
    RUN forma.
    
    OUTPUT STREAM Formulario CLOSE.
     
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = "c:\sic-temp\prfab114.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE forma:

    RUN escribir ( INPUT "10,115", INPUT Tipocomprobante.denominacion_impresa, INPUT 12, INPUT YES). 

/*  RUN escribir ( INPUT "10,135", INPUT str_fecha, INPUT 8, INPUT NO). */

    RUN escribir ( INPUT "10,167", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 8, INPUT NO).
/*
    RUN escribir ( INPUT "14,140", INPUT que_mes, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "12,150", INPUT que_ano, INPUT 8, INPUT NO).
*/    
    RUN escribir ( INPUT "31,22", INPUT Cliente.nom_cliente, INPUT 10, INPUT YES).
    RUN escribir ( INPUT "31,125", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 10, INPUT NO).

    RUN escribir ( INPUT "35,22", INPUT Domicilio.direccion, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "35,125", INPUT "(" + Domicilio.cdg_postal + ") " +  
                 Domicilio.localidad, INPUT 8, INPUT YES).

    RUN escribir ( INPUT "39,22", INPUT Provincia.nombre, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "43,22", INPUT Condicion_impos.texto, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "43,132", INPUT Cliente.cuit, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "43,155", INPUT Fac_header.pc_name, INPUT 8, INPUT YES).
    
    RUN escribir ( INPUT "47,22", INPUT "[" + Vendedor.cdg_vendedor + "]", INPUT 8, INPUT NO).
    
    RUN escribir ( INPUT "54,35", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO).
    IF AVAILABLE Ped_header
    THEN DO:
         RUN escribir ( INPUT "54,98", INPUT STRING(Ped_header.nro_comprob,">>>>>9"), INPUT 8, INPUT NO).
         RUN escribir ( INPUT "54,108", INPUT "O/C:" + Ped_header.nro_ocm, INPUT 8, INPUT NO).
    END.     
    IF AVAILABLE Rem_header
       THEN RUN escribir ( INPUT "54,160", INPUT STRING(Rem_header.nro_comprob,">>>>>9"), INPUT 8, INPUT NO).

    linea0 = 1.
    v-cantidad = 0.
    v-subtotal = 0.

    FOR EACH Fac_detalle OF Fac_header 
             WHERE Fac_detalle.cantidad <> 0 OR Fac_detalle.granel <> 0,
                   Articulo OF Fac_detalle 
                   BREAK BY Articulo.cdg_articulo 
                         BY Fac_detalle.precio_cf DESCENDING:

        v-cantidad = v-cantidad + Fac_detalle.cantidad.
        v-subtotal = v-subtotal + Fac_detalle.subtotal_bruto_cf.

        IF LAST-OF(Fac_detalle.precio_cf)
        THEN DO:

            ch_linea = STRING(63 + linea0 * 4,">>9").  

            RUN escribenumero ( ch_linea  + ",0",   INPUT STRING(v-cantidad,"ZZZZ9"), INPUT 8, INPUT NO).
            RUN escribir      ( ch_linea  + ",20",  INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
            RUN escribir      ( ch_linea  + ",30",  INPUT Articulo.descripcion, INPUT 8, INPUT NO).
            IF Fac_detalle.precio <> 0
            THEN DO:
                RUN escribenumero ( ch_linea  + ",134", INPUT STRING(Fac_detalle.precio_cf,"-ZZZ,ZZ9.9999"), INPUT 8, INPUT NO).
                RUN escribenumero ( ch_linea  + ",164", INPUT STRING(v-subtotal,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
            END.
            ELSE DO:
                RUN escribir ( ch_linea  + ",138", INPUT "Bonificado", INPUT 8, INPUT NO).
            END.
    
            linea0 = linea0 + 1.
    
            v-cantidad = 0.
            v-subtotal = 0.
        END.
        
    END.
    
    RUN RENGLONS.P (INPUT  Fac_header.monto_letras, 
                    INPUT  v-leng_monto,
                    OUTPUT v-monto_letras,
                    INPUT  "|").
    
    linea0 = 230.
    DO j = 1 TO v-reng_monto:
        IF j <= NUM-ENTRIES(v-monto_letras, "|")
           THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",4", INPUT ENTRY(j,v-monto_letras, "|"), INPUT 8, INPUT NO).
        linea0 = linea0 + 4.
    END.
    
    IF Fac_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Fac_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
    
        linea0 = 220.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",0", INPUT ENTRY(j,v-leyenda, "|"), INPUT 10, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    
    END.

    RUN escribir      ( INPUT "230,100", INPUT "Neto", INPUT 10, INPUT NO).
    RUN escribenumero ( INPUT "230,162", INPUT STRING(v-importe_bruto,"-ZZZ,ZZ9.99"), INPUT 10, INPUT NO).

    RUN escribir      ( INPUT "234,100", INPUT "Descuento " + v-descuentos, INPUT 10, INPUT NO).
/*     RUN escribenumero ( INPUT "234,162", INPUT STRING(Fac_header.imp_descuentos,"-ZZZ,ZZ9.99"), INPUT 10, INPUT NO). */
    
    RUN escribenumero ( INPUT "234,163", INPUT STRING(v-importe_descuentos,"ZZZ,ZZ9.99-"), INPUT 10, INPUT NO).


    RUN escribir      ( INPUT "251,100", INPUT "Total a Pagar", INPUT 10, INPUT NO).
    RUN escribenumero ( INPUT "251,162", INPUT STRING(Fac_header.imp_total,"-ZZZ,ZZ9.99"), INPUT 10, INPUT YES).

    RUN escribir      ( INPUT "259,110", INPUT STRING(Fac_header.prf_comprob,"9999") + " " + STRING(Fac_header.nro_comprob,"99999999"), INPUT 8, INPUT NO).

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

