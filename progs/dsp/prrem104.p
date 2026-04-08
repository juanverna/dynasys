/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE FACTURACION TIPO A                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                               VARIABLES                                         */
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
DEFINE VARIABLE nt-lineas      AS INTEGER.
DEFINE VARIABLE nt-hojas       AS INTEGER.
DEFINE VARIABLE n-hoja         AS INTEGER.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 25. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 85. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 135. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.
DEFINE VARIABLE lineal         AS INTEGER.

DEFINE VARIABLE v-cantidad     LIKE Rem_detalle.cantidad.
DEFINE VARIABLE v-subtotal     LIKE Rem_detalle.subtotal_neto.

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
DEFINE VARIABLE v-descuentos   AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-reimpresion  AS CHARACTER.

DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Rem_header.imp_neto FORMAT "Z,ZZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Rem_header.imp_neto FORMAT "Z,ZZZ,ZZZ,ZZ9.99-".

DEFINE VARIABLE v-imp_gravado  LIKE Rem_header.imp_neto FORMAT "Z,ZZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-imp_exento   LIKE Rem_header.imp_neto FORMAT "Z,ZZZ,ZZZ,ZZ9.99-".

DEFINE BUFFER Provlegal FOR Provincia.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Rem_header WHERE ROWID(Rem_header) = rid_factura EXCLUSIVE-LOCK.
    v-reimpresion = IF Rem_header.impreso = "S" THEN "REIMPRESION" ELSE "".
    
    FIND Punto-venta WHERE Punto-venta.cdg_empresa = Rem_header.cdg_empresa
                       AND Punto-venta.cdg_puntovta = Rem_header.prf_comprob
                           NO-LOCK.
    /*                       
    FIND FIRST Vigencia_cai 
         WHERE Vigencia_cai.cdg_empresa = Rem_header.cdg_empresa
           AND Vigencia_cai.tip_comprob = Rem_header.tip_comprob
           AND Vigencia_cai.prf_comprob = Rem_header.prf_comprob
           AND Vigencia_cai.rige_hasta  >= Rem_header.fecha.
               NO-LOCK NO-ERROR.
    */
    FIND Tipocomprobante OF Rem_header NO-LOCK.
    FIND Empresa OF Rem_header NO-LOCK.
    FIND Condicion_impos OF Rem_header NO-LOCK.
    FIND Condicion_venta OF Rem_header NO-LOCK.
    FIND Provincia OF Rem_header NO-LOCK.
    FIND Cliente   OF Rem_header NO-LOCK NO-ERROR.
    FIND Provlegal OF Cliente NO-LOCK.    
    FIND Vendedor OF Rem_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Rem_header NO-LOCK NO-ERROR.
    FIND Usuario OF Rem_header NO-LOCK.
    FIND Cobrador OF Cliente NO-LOCK.
    
    FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.

    que_mes = STRING(MONTH(Rem_header.fecha),"99").
    que_ano = STRING(YEAR(Rem_header.fecha),"9999").
    que_dia = STRING(DAY(Rem_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Rem_header.fecha) ] + " de " + que_ano.
        
    Rem_header.impreso = "S".    
    
    /*---------------------------------------------------------------------------------*/
    /*                CUENTA LA CANTIDAD TOTAL DE HOJAS A IMPRIMIR                     */
    /*---------------------------------------------------------------------------------*/

    nt-lineas = 0.
    nt-hojas = 0.
    FOR EACH Rem_detalle OF Rem_header 
             WHERE Rem_detalle.cantidad <> 0 OR Rem_detalle.granel <> 0 OR TRUE:

        nt-lineas = nt-lineas + 1.
        IF nt-lineas = nmax_det
        THEN DO:
             nt-lineas = 0.
             nt-hojas = nt-hojas + 1.
        END.

    END.
    IF nt-lineas <> 0 THEN nt-hojas = nt-hojas + 1.
     
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DEL REMITO                                  */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\prrem103.xpr" CONVERT TARGET "iso8859-1".

    n-hoja = 1.
    RUN imprimir.
    
    OUTPUT STREAM Formulario CLOSE.
     
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = "c:\sic-temp\prrem103.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
/*  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */*/
    
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Letter>".
    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    
    PUT STREAM Formulario CONTROL "<AT=172,10><#2>".    

END PROCEDURE.

PROCEDURE imprimir:

    RUN inicia_formulario.
    
    RUN cabecera_forma.
    RUN detalle_forma.
    RUN pie_forma.
    
    RUN cabecera_datos.
    RUN detalle_datos.
    RUN pie_datos.

END PROCEDURE.

PROCEDURE cabecera_forma:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+39,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+44,+5><FROM><AT=+06,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+50,+5><FROM><AT=+27,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+77,+5><FROM><AT=+17,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>". 
    
    RUN escribir ( "45,45", INPUT "CLIENTE", INPUT 10, INPUT YES).    
    RUN escribir ( "45,123", INPUT "DOMICILIO DE ENTREGA", INPUT 10, INPUT YES).    
    
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+102,+5><FROM><AT=+120,+190><RECT>". 

    
    RUN escribir ( INPUT "22,10", INPUT Empresa.nombre, INPUT 12, INPUT NO). 
    RUN escribir ( INPUT "28,10", INPUT Punto-venta.direccion, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "28,105", INPUT "C.U.I.T.: " + Empresa.cuit, INPUT 8, INPUT NO). 

    RUN escribir ( INPUT "32,10", INPUT Punto-venta.localidad + " - " + Punto-venta.provincia, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "32,105", INPUT "Ingresos Brutos(Conv.Multil.): 902-871143-5", INPUT 8, INPUT NO). 

    RUN escribir ( INPUT "36,10", INPUT Punto-venta.telefono, INPUT 8, INPUT NO). 
 /* RUN escribir ( INPUT "36,105", INPUT "INICIO DE ACTIVIDADES 10/2002", INPUT 8, INPUT NO). */
    
    RUN escribir ( INPUT "39,160", INPUT v-reimpresion, INPUT 10, INPUT YES). 

 /* RUN escribir ( INPUT "40,10", INPUT "I.V.A. RESPONSABLE INSCRIPTO", INPUT 8, INPUT NO). */

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+95><FROM><AT=+10,+10><RECT>". 
    RUN linea    ( "15,100", INPUT "35", "V" ).

    RUN escribir ( INPUT "6,107", INPUT Tipocomprobante.denominacion_impresa, INPUT 12, INPUT YES). 
    RUN escribir ( INPUT "11,107", INPUT "NRO.: ", INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "16,107", INPUT "FECHA: ", INPUT 12, INPUT YES).
    RUN escribir ( INPUT "16,165", INPUT "HOJA: ", INPUT 12, INPUT YES).
    
    RUN escribir ( INPUT "67,10", INPUT "C.U.I.T.:", INPUT 8, INPUT YES).
    RUN escribir ( INPUT "67,55", INPUT "I.BRUTOS:" , INPUT 8, INPUT NO).
    RUN escribir ( INPUT "67,105", INPUT "USUARIO:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "71,105", INPUT "TRANSP:" , INPUT 8, INPUT NO).

    RUN escribir ( INPUT "80,10", INPUT "CONDICION DE VENTA:", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "80,110", INPUT "PEDIDO NRO.: ", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "84,160", INPUT "O/C:", INPUT 8, INPUT NO).
     
    RUN escribir ( INPUT "84,110", INPUT "REMITO: ", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "84,10", INPUT "VENCIMIENTO:", INPUT 8, INPUT NO).


END PROCEDURE.

PROCEDURE detalle_forma:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>". 
    
    RUN escribir ( "97,45", INPUT "DESCRIPCION", INPUT 8, INPUT YES).    
    
    RUN linea    ( "95,91", INPUT "7", "V" ).
    RUN escribir ( "97,93", INPUT "SABOR", INPUT 8, INPUT YES).

    RUN linea    ( "95,105", INPUT "7", "V" ).
    RUN escribir ( "97,109", INPUT "ARTICULO", INPUT 8, INPUT YES).

    RUN linea    ( "95,126", INPUT "7", "V" ).
    RUN escribir ( "97,133", INPUT "CANTIDAD", INPUT 8, INPUT YES).

    RUN linea    ( "95,151", INPUT "7", "V" ).
    RUN escribir ( "97,164", INPUT "OBSERVACIONES", INPUT 8, INPUT YES).

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+102,+5><FROM><AT=+120,+190><RECT>". 

END PROCEDURE.

PROCEDURE cabecera_datos:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    

    RUN escribir ( INPUT "7,98", INPUT "X", INPUT 16, INPUT YES). 

    RUN escribir ( INPUT "11,120", INPUT STRING(Rem_header.prf_comprob,"9999") + "-" + STRING(Rem_header.nro_comprob,"99999999"), INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "16,124", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT YES).
    RUN escribir ( INPUT "16,180", INPUT TRIM(STRING(n-hoja,">>9")) + "/" + TRIM(STRING(nt-hojas,">>9")), INPUT 12, INPUT YES).
    RUN escribir ( INPUT "51,10", INPUT Cliente.nom_cliente, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "51,85", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "55,10", INPUT Cliente.direccion, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "59,10", INPUT "(" + Cliente.cdg_postal + ") " + Cliente.localidad, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "63,10", INPUT Provlegal.nombre , INPUT 8, INPUT YES).
    RUN escribir ( INPUT "63,85", INPUT "[" + Provlegal.cdg_provincia + "]", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "67,20", INPUT Cliente.cuit, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "67,65", INPUT Cliente.ing_brutos, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "71,10", INPUT "I.V.A." + Condicion_impos.texto, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "51,105", INPUT Domicilio.nombre, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "55,105", INPUT Domicilio.direccion, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "59,105", INPUT "(" + Domicilio.cdg_postal + ") " + Domicilio.localidad, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "63,105", INPUT Provincia.nombre, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "63,175", INPUT "[" + Provincia.cdg_provincia + "]", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "67,119", INPUT Usuario.nombre, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "80,42", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "84,170", INPUT Rem_header.nro_ocm, INPUT 8, INPUT NO).
    
    FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.
    IF AVAILABLE Ped_header
    THEN DO:
         RUN escribir ( INPUT "80,130", INPUT Ped_header.tip_comprob + "-" + STRING(Ped_header.prf_comprob,"9999") + "-" + STRING(Ped_header.nro_comprob,"99999999"), INPUT 8, INPUT NO).
    END.

END PROCEDURE.

PROCEDURE detalle_datos:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    

    linea0 = 1.
    v-cantidad = 0.
    v-subtotal = 0.

    FOR EACH Rem_detalle OF Rem_header 
             WHERE Rem_detalle.cantidad <> 0 OR Rem_detalle.granel <> 0 OR TRUE,
                   Articulo OF Rem_detalle 
                   BREAK BY Articulo.cdg_articulo /*
                         BY Rem_detalle.precio*/:

        IF Rem_detalle.a_granel 
        THEN DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
             v-cantidad = Rem_detalle.granel.
        END.
        ELSE DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
             v-cantidad = Rem_detalle.cantidad.
        END.
            

        RUN verificar_fin_hoja.

        IF NOT Articulo.extendida
        THEN DO:
                RUN verificar_fin_hoja.

                ch_linea = STRING(102 + linea0 * 4,">>9").  
                
                FIND FIRST Articulo_atributo OF Articulo 
                     WHERE Articulo_atributo.cdg_tipoatributo = "SABOR"
                       AND Articulo_atributo.cdg_atributo = ENTRY(3,Articulo.cdg_articulo,"-")
                           NO-ERROR.
                FIND Atributo OF Articulo_atributo NO-LOCK.
    
                RUN escribenumero ( ch_linea  + ",127", INPUT STRING(v-cantidad,"ZZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",149", INPUT Unidad.abrevia, INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",107", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",93",  INPUT Atributo.abreviatura, INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",10",  INPUT Articulo.descripcion, INPUT 8, INPUT NO).
        
                linea0 = linea0 + 1.
        
                v-cantidad = 0.
                v-subtotal = 0.
            END.
            ELSE DO:
                
                RUN RENGLONS.P (INPUT  Rem_detalle.detallada, 
                                INPUT  v-leng_detalle,
                                OUTPUT v-detallada,
                                INPUT  "|").

                DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
                    ch_linea = STRING(102 + linea0 * 4,">>9").                     
                    RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO).
                    IF j = NUM-ENTRIES(v-detallada,"|")
                    THEN DO:
                        RUN verificar_fin_hoja.
                        v-cantidad = Rem_detalle.cantidad.
                        RUN escribenumero ( ch_linea  + ",128", INPUT STRING(v-cantidad,"ZZZ,ZZZ,ZZ9.99  ") + Unidad.abrevia, INPUT 8, INPUT NO).
                        RUN escribenumero ( ch_linea  + ",145", INPUT STRING(Rem_detalle.precio,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
                        RUN escribenumero ( ch_linea  + ",166", INPUT STRING(Rem_detalle.subtotal_bruto,"-Z,ZZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
                    END.
                    linea0 = linea0 + 1.
                END.
            
            END.
        
    END.
    
    IF Rem_header.leyenda <> ""
    THEN DO:
                      
        linea0 = linea0 + 2.

        RUN RENGLONS.P (INPUT  Rem_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-detallada,
                        INPUT  "|").
        
        DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
            
            RUN verificar_fin_hoja.
            ch_linea = STRING(102 + linea0 * 4,">>9").                     
            RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO).
            linea0 = linea0 + 1.

        END.
    
    END.

END PROCEDURE.

PROCEDURE pie_forma:

    PUT STREAM Formulario CONTROL "<AT=235,8><#1>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+1,+5><FROM><AT=+22,+190><RECT>".
    RUN escribir ( "5,10", INPUT "Observaciones:", INPUT 8, INPUT NO).
    /*
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+7,+190><RECT>". 
    */


END PROCEDURE.

PROCEDURE pie_datos:
            
    PUT STREAM Formulario CONTROL "<AT=235,8><#1>".    
    
    IF Rem_header.leyenda <> ""
    THEN DO:   
        
        RUN RENGLONS.P (INPUT  Rem_header.leyenda, 
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

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FCourierNew><P' + puntos + '>'.

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

PROCEDURE verificar_fin_hoja:

    IF linea0 > nmax_det
    THEN DO:

        OUTPUT STREAM Formulario CLOSE.            
        FILE-INFO:File-NAME = "c:\sic-temp\prrem103.xpr".
        RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
        n-hoja = n-hoja + 1.      
        OUTPUT STREAM Formulario TO "c:\sic-temp\prrem103.xpr" CONVERT TARGET "iso8859-1".
    
        RUN inicia_formulario.
        RUN cabecera_forma.
        RUN detalle_forma.
        RUN pie_forma.
        RUN cabecera_datos.
    
        linea0 = 1.

    END.

END PROCEDURE.
