/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE FACTURACION TIPO A                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                               FUNCIONES                                         */
/*=================================================================================*/

FUNCTION fnComprobante RETURN CHARACTER ( tip AS CHARACTER, prf AS INTEGER, nro AS INTEGER).
  RETURN tip + "-" + STRING(prf,"9999") + "-" + STRING(nro,"99999999").
END FUNCTION.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}
{parlocales.i}
{nombrecopia.i}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE k              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.
DEFINE VARIABLE nt-lineas      AS INTEGER.
DEFINE VARIABLE nt-copias      AS INTEGER INITIAL 2.
DEFINE VARIABLE nt-hojas       AS INTEGER.
DEFINE VARIABLE n-hoja         AS INTEGER.
DEFINE VARIABLE v-cdg_seccion  AS CHARACTER.
DEFINE VARIABLE c-orden        AS INTEGER.
DEFINE VARIABLE c-linea_detalle AS INTEGER.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE cantidad_hojas     AS INTEGER.
DEFINE VARIABLE lineas_impuestos   AS INTEGER.
DEFINE VARIABLE comienzo_impuestos AS INTEGER.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 27. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 60. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 105. /* Ancho en chars de la leyenda  */
DEFINE VARIABLE v-tomo_leyenda AS CHARACTER. /* Cada una de las porciones de leyenda separadas por chr(10)  */
DEFINE VARIABLE j-tomo         AS INTEGER.

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 105. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.
DEFINE VARIABLE linea1         AS INTEGER.

DEFINE VARIABLE v-cantidad     LIKE Fac_detalle.cantidad.
DEFINE VARIABLE v-subtotal     LIKE Fac_detalle.subtotal_neto.

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
DEFINE VARIABLE v-formulario   AS CHARACTER EXTENT 20.
DEFINE VARIABLE v-registro     AS CHARACTER.
DEFINE VARIABLE v-remitos      AS CHARACTER.
DEFINE VARIABLE ventas_terceros AS CHARACTER.

DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE v-imp_gravado  LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-imp_exento   LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-con_impuestos LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE es_cuenta_y_orden AS LOGICAL.
DEFINE BUFFER Provlegal FOR Provincia.

DEFINE STREAM Formulario.
DEFINE STREAM Seguimiento.

DEFINE BUFFER P-Condicion_impos FOR Condicion_impos.

DEFINE TEMP-TABLE T-Listado
    FIELD cdg_seccion      AS CHARACTER
    FIELD l-orden        AS INTEGER
    FIELD l-linea        AS CHARACTER
    INDEX p-tomo IS UNIQUE PRIMARY cdg_seccion l-orden.

DEFINE TEMP-TABLE T-Detalle
    FIELD n-orden        AS INTEGER
    FIELD n-linea        AS INTEGER
    FIELD n-columna      AS INTEGER
    FIELD l-texto        AS CHARACTER
    INDEX p-orden IS UNIQUE PRIMARY n-orden.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura EXCLUSIVE-LOCK.

    v-reimpresion = IF Fac_header.impreso = "S" THEN "REIMPRESION" ELSE "".
    FIND Punto-venta WHERE Punto-venta.cdg_empresa = Fac_header.cdg_empresa
                       AND Punto-venta.cdg_puntovta = Fac_header.prf_comprob
                           NO-LOCK.

    FIND Moneda OF Fac_header NO-LOCK.
    FIND Tipocomprobante OF Fac_header NO-LOCK.
    FIND Imputacion OF Fac_header NO-LOCK.
    FIND Empresa OF Fac_header NO-LOCK.
    FIND Condicion_impos OF Fac_header NO-LOCK.
    FIND Condicion_venta OF Fac_header NO-LOCK.
    FIND Provincia OF Fac_header NO-LOCK.
    FIND Cliente   OF Fac_header NO-LOCK NO-ERROR.
    FIND Provlegal WHERE Provlegal.cdg_provincia = Fac_header.cdg_provincia_leg NO-LOCK.
    FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Fac_header NO-LOCK NO-ERROR.
    FIND Usuario OF Fac_header NO-LOCK.
    FIND Cobrador OF Cliente NO-LOCK.
    FIND FIRST Cta_cte WHERE Cta_cte.tip_comprob = Fac_header.tip_comprob
                         AND Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                         AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                         AND Cta_cte.nro_comprob = Fac_header.nro_comprob
                             NO-LOCK NO-ERROR.
    
    v-remitos = "".
    FOR EACH Rem_header WHERE Rem_header.nro_factura = Fac_header.nro_factura NO-LOCK:
        v-remitos = v-remitos + "," + fnComprobante(Rem_header.tip_comprob,Rem_header.prf_comprob,Rem_header.nro_comprob).
        FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.
    END.
    v-remitos = SUBSTRING(v-remitos,2).

    FIND Fac_header_impuesto OF Fac_header
         WHERE Fac_header_impuesto.cdg_impuesto = 1
               NO-LOCK NO-ERROR.
    IF AVAILABLE Fac_header_impuesto
    THEN DO:
        prciva = Fac_header_impuesto.tasa.
        prcnoi = prciva / 2.
    END.
    
    que_mes = STRING(MONTH(Fac_header.fecha),"99").
    que_ano = STRING(YEAR(Fac_header.fecha),"9999").
    que_dia = STRING(DAY(Fac_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Fac_header.fecha) ] + " de " + que_ano.
        
    Fac_header.impreso = "S".    
    
    /*---------------------------------------------------------------------------------*/
    /*             DISCRIMINA EL NETO GRAVADO CON IVA DEL NETO EXENTO                  */
    /*---------------------------------------------------------------------------------*/

    v-imp_gravado = 0.
    v-con_impuestos = Fac_header.imp_neto.
    FOR EACH Fac_header_impuesto OF Fac_header, FIRST Impuesto OF Fac_header_impuesto:
        IF Impuesto.es_iva 
           THEN v-imp_gravado = v-imp_gravado + Fac_header_impuesto.monto_imponible.
           ELSE v-con_impuestos = v-con_impuestos + Fac_header_impuesto.importe.
    END.
    v-imp_exento = Fac_header.imp_neto - v-imp_gravado.

    RUN getparametro.p (  INPUT  "LEYSELLO",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).

    v-leyenda = IF v-observacion <> ? THEN v-observacion ELSE "".

    /*---------------------------------------------------------------------------------*/
    /*                          GENERA EL FORMULARIO EN SI                             */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".  /* for the AT command. restore it if necessary */
    
    RUN generar_formulario.

    RUN bajar_copias.
    
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE generar_formulario:

    RUN inicia_formulario.
    RUN cabecera_forma.
    RUN detalle_forma.
    RUN pie_forma.
    RUN cabecera_datos.
    RUN detalle_datos.
    RUN pie_datos.
    RUN pie_relleno.
    RUN pie_nocategorizado.

END PROCEDURE.

PROCEDURE inicia_formulario:

    v-cdg_seccion = "INIT". 
    c-orden = 0.

    RUN grabar_linea ( "<PREVIEW=70>" ) /*=ZoomToWidth>'*/.
    
    RUN grabar_linea ( "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>").
    RUN grabar_linea ( "<FORMAT=Letter>").
    RUN grabar_linea ( "<AT=14,8><#1>").    
    RUN grabar_linea ( "<AT=172,10><#2>").    

END PROCEDURE.

PROCEDURE cabecera_forma:

    v-cdg_seccion = "CAB-FORMA". 
    c-orden = 0.

    RUN grabar_linea ( "<AT=14,8><#1>").    

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+39,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+44,+5><FROM><AT=+06,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+50,+5><FROM><AT=+27,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+77,+5><FROM><AT=+17,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>"). 
    
    RUN escribir ( "45,45", INPUT "CLIENTE", INPUT 10, INPUT YES, INPUT "BLACK").    
    RUN escribir ( "45,123", INPUT "DOMICILIO DE ENTREGA", INPUT 10, INPUT YES, INPUT "BLACK").    
    
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+102,+5><FROM><AT=+120,+190><RECT>"). 

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+07,+11><#3><AT=+14,+58><IMAGE#3=..\imagenes\dynasys.bmp>").
    RUN escribir ( INPUT "22,10", INPUT Empresa.nombre, INPUT 12, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "28,10", INPUT Punto-venta.direccion, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "28,105", INPUT "C.U.I.T.: " + Empresa.cuit, INPUT 8, INPUT NO, INPUT "BLACK"). 

    RUN escribir ( INPUT "32,10", INPUT Punto-venta.localidad + " - " + Punto-venta.provincia, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "32,105", INPUT "Ingresos Brutos(Conv.Multil.): 902-871143-5", INPUT 8, INPUT NO, INPUT "BLACK"). 

    RUN escribir ( INPUT "36,10", INPUT Punto-venta.telefono, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "36,105", INPUT "INICIO DE ACTIVIDADES 10/2002", INPUT 8, INPUT NO, INPUT "BLACK"). 
    
    RUN escribir ( INPUT "39,160", INPUT v-reimpresion, INPUT 10, INPUT YES, INPUT "RED"). 

    RUN escribir ( INPUT "40,10", INPUT "I.V.A. RESPONSABLE INSCRIPTO", INPUT 8, INPUT NO, INPUT "BLACK"). 

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+05,+95><FROM><AT=+10,+10><RECT>"). 
    RUN linea    ( "15,100", INPUT "35", "V" ).

    RUN escribir ( INPUT "6,107", INPUT Tipocomprobante.denominacion_impresa, INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "11,107", INPUT "NRO.: ", INPUT 12, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "16,107", INPUT "FECHA: ", INPUT 12, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "16,165", INPUT "HOJA: ", INPUT 12, INPUT YES, INPUT "BLACK").
    
    RUN escribir ( INPUT "67,10", INPUT "C.U.I.T.:", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "67,55", INPUT "I.BRUTOS:" , INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( INPUT "67,105", INPUT "USUARIO:", INPUT 8, INPUT NO, INPUT "BLACK").

    RUN escribir ( INPUT "71,105", INPUT "TRANSP:" , INPUT 8, INPUT NO, INPUT "BLACK").

    RUN escribir ( INPUT "80,10", INPUT "CONDICION DE VENTA:", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( INPUT "80,110", INPUT "PEDIDO NRO.: ", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( INPUT "84,160", INPUT "O/C:", INPUT 8, INPUT NO, INPUT "BLACK").
     
    RUN escribir ( INPUT "88,10", INPUT "REMITOS: ", INPUT 8, INPUT NO, INPUT "BLACK").

    RUN escribir ( INPUT "84,10", INPUT "VENCIMIENTO:", INPUT 8, INPUT NO, INPUT "BLACK").


END PROCEDURE.

PROCEDURE detalle_forma:

    v-cdg_seccion = "DET-FORMA". 
    c-orden = 0.

    RUN grabar_linea ( "<AT=14,8><#1>").    

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>"). 
    
    RUN escribir ( "97,45", INPUT "DESCRIPCION", INPUT 8, INPUT YES, INPUT "BLACK").    
    
    RUN linea    ( "95,91", INPUT "7", "V" ).
    RUN escribir ( "97,95", INPUT "ARTICULO", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "95,117", INPUT "7", "V" ).
    RUN escribir ( "97,119", INPUT "COLOR", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "95,132", INPUT "7", "V" ).
    RUN escribir ( "97,136", INPUT "CANTIDAD", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "95,155", INPUT "7", "V" ).
    RUN escribir ( "97,159", INPUT "P.UNIT.", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "95,174", INPUT "7", "V" ).
    RUN escribir ( "97,178", INPUT "IMPORTE", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+102,+5><FROM><AT=+120,+190><RECT>"). 

END PROCEDURE.

PROCEDURE cabecera_datos:

    v-cdg_seccion = "CAB-DATOS". 
    c-orden = 0.

    RUN grabar_linea ( "<AT=14,8><#1>").    

    RUN escribir ( INPUT "7,98", INPUT SUBSTRING(Fac_header.tip_comprob,2,1), INPUT 16, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "11,120", INPUT STRING(Fac_header.prf_comprob,"9999") + "-" + STRING(Fac_header.nro_comprob,"99999999"), INPUT 12, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "16,124", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT YES, INPUT "BLACK").
  /*RUN escribir ( INPUT "16,180", INPUT TRIM(STRING(n-hoja,">>9")) + "/" + TRIM(STRING(nt-hojas,">>9")), INPUT 12, INPUT YES, INPUT "BLACK").*/
    RUN escribir ( INPUT "16,180", INPUT "##/@@", INPUT 12, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "51,10", INPUT Fac_header.nombre, INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( INPUT "51,85", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "55,10", INPUT Fac_header.direccion_leg, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "59,10", INPUT "(" + Fac_header.cdg_postal_leg + ") " + Fac_header.localidad_leg, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,10", INPUT Provlegal.nombre , INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,85", INPUT "[" + Provlegal.cdg_provincia + "]", INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "67,21", INPUT Fac_header.cuit, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "67,70", INPUT Cliente.ing_brutos, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "71,10", INPUT "I.V.A." + Condicion_impos.texto, INPUT 8, INPUT NO, INPUT "BLUE").

    RUN escribir ( INPUT "51,105", INPUT Domicilio.nombre, INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( INPUT "51,175", INPUT "[" + STRING(Domicilio.nro_domicilio,"9999") + "]", INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "55,105", INPUT Fac_header.direccion, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "59,105", INPUT "(" + Fac_header.cdg_postal + ") " + Fac_header.localidad, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,105", INPUT Provincia.nombre, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,175", INPUT "[" + Provincia.cdg_provincia + "]", INPUT 8, INPUT NO, INPUT "BLUE").

    RUN escribir ( INPUT "67,119", INPUT Usuario.cdg_usuario, INPUT 8, INPUT NO, INPUT "BLUE").

    RUN escribir ( INPUT "80,42", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "84,170", INPUT Fac_header.nro_ocm, INPUT 8, INPUT NO, INPUT "BLUE").
    
    IF AVAILABLE Ped_header
    THEN DO:
         RUN escribir ( INPUT "80,130", INPUT STRING(Ped_header.nro_comprob,">>>>>9"), INPUT 8, INPUT NO, INPUT "BLUE").
    END.
     
    RUN escribir ( INPUT "88,25", INPUT v-remitos, INPUT 8, INPUT NO, INPUT "BLUE").

    IF AVAILABLE Cta_cte
       THEN RUN escribir ( INPUT "84,32", INPUT STRING(Cta_cte.fecha_vencimiento,"99/99/9999"), INPUT 8, INPUT NO, INPUT "BLUE").

    v-descuentos = "".
    FOR EACH Fac_header-bon OF Fac_header:
        v-descuentos = v-descuentos + STRING(Fac_header-bon.porcentaje," %>>9.99").
    END.
    v-descuentos = SUBSTRING(v-descuentos,2).

END PROCEDURE.

PROCEDURE detalle_datos:

    v-cdg_seccion = "DET-DATOS". 
    c-orden = 0.

    RUN grabar_linea ( "<AT=14,8><#1>").    

    linea0 = 106.
    c-linea_detalle = 1.

    FOR EACH Fac_detalle OF Fac_header NO-LOCK,
                   Articulo OF Fac_detalle NO-LOCK, Partida OF Fac_detalle NO-LOCK 
                   BREAK BY Articulo.cdg_articulo:

        IF Fac_detalle.a_granel 
        THEN DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
             v-cantidad = Fac_detalle.granel.
        END.
        ELSE DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
             v-cantidad = Fac_detalle.cantidad.
        END.

        OPEN QUERY q_cuenta
            FOR EACH Vigencia_cyorden 
               WHERE Vigencia_cyorden.nro_articulo = Fac_detalle.nro_articulo
                 AND Vigencia_cyorden.rige_desde <= Fac_header.fecha
                 AND Vigencia_cyorden.rige_hasta >= Fac_header.fecha,
                     FIRST Proveedor OF Vigencia_cyorden WHERE Proveedor.cyorden_sino.
        GET FIRST q_cuenta.

        es_cuenta_y_orden = AVAILABLE Vigencia_cyorden.
        IF es_cuenta_y_orden
        THEN DO:
            IF LOOKUP(ventas_terceros,Proveedor.cdg_proveedor,",") = 0 /* El codigo de proveedor no esta en la lista */
            THEN DO:
                IF ventas_terceros = "" 
                    THEN ventas_terceros = Proveedor.cdg_proveedor.
                    ELSE ventas_terceros = ventas_terceros + "," + Proveedor.cdg_proveedor.
            END.
        END.

        IF NOT Articulo.extendida
        THEN DO:
            
            ch_linea = STRING(linea0,">>9").  

            IF Imputacion.afecta_stock 
            THEN DO:
                RUN detalle-numr ( ch_linea  + ",144", INPUT STRING(v-cantidad,"ZZZZZZZ9.99"), INPUT 8, INPUT NO, INPUT "BLUE").
                RUN detalle-char ( ch_linea  + ",148", INPUT Unidad.abrevia, INPUT 8, INPUT NO, INPUT "BLUE").
            END.

            RUN detalle-char ( ch_linea  + ",92", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO, INPUT "BLUE").
            RUN detalle-char ( ch_linea  + ",119", INPUT Partida.cdg_partida, INPUT 8, INPUT NO, INPUT "BLUE").
            RUN detalle-char ( ch_linea  + ",10", INPUT Articulo.descripcion, INPUT 8, INPUT NO, INPUT "BLUE").
            IF es_cuenta_y_orden
                THEN RUN detalle-char ( ch_linea  + ",06",  INPUT "(" + STRING(LOOKUP(ventas_terceros,Proveedor.cdg_proveedor,","),"9") + ")", INPUT 7, INPUT NO, INPUT "BLUE").

            IF Articulo.sumaneto > 0
            THEN DO:
                IF Fac_detalle.precio <> 0
                THEN DO:
                    IF Imputacion.afecta_stock 
                        THEN RUN detalle-numr ( ch_linea  + ",168", INPUT STRING(Fac_detalle.precio,"-ZZZ,ZZ9.9999"), INPUT 8, INPUT NO, INPUT "BLUE").
                    RUN detalle-numr ( ch_linea  + ",191", INPUT STRING(Fac_detalle.subtotal_bruto,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO, INPUT "BLUE").
                END.
                ELSE DO:
                    RUN detalle-char ( ch_linea  + ",154", INPUT "Bonificado", INPUT 8, INPUT NO, INPUT "BLUE").
                END.
            END.
    
            c-linea_detalle = c-linea_detalle + 1.
    
        END.
        ELSE DO:
            
            RUN RENGLONS.P (INPUT  Fac_detalle.detallada, 
                            INPUT  v-leng_detalle,
                            OUTPUT v-detallada,
                            INPUT  "|").

            DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
                ch_linea = STRING(linea0,">>9").                     
                RUN detalle-char ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO, INPUT "BLUE").
                IF Articulo.sumaneto > 0
                THEN DO:
                    IF j = NUM-ENTRIES(v-detallada,"|")
                    THEN DO:
                        v-cantidad = Fac_detalle.cantidad.
                        IF Articulo.stock_sino /* Imputacion.afecta_stock */
                        THEN DO:
                            RUN detalle-numr ( ch_linea  + ",128", INPUT STRING(v-cantidad,"ZZZZZZ9.99  ") + Unidad.abrevia, INPUT 8, INPUT NO, INPUT "BLUE").
                            RUN detalle-numr ( ch_linea  + ",145", INPUT STRING(Fac_detalle.precio,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO, INPUT "BLUE").
                        END.
                        RUN detalle-numr ( ch_linea  + ",166", INPUT STRING(Fac_detalle.subtotal_bruto,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO, INPUT "BLUE").
                    END.
                END.
                c-linea_detalle = c-linea_detalle + 1.
            END.
        
        END.
        
    END.

    IF NUM-ENTRIES(ventas_terceros,",") > 0
        THEN c-linea_detalle = c-linea_detalle + 1.

    DO j = 1 TO NUM-ENTRIES(ventas_terceros,","):
        FIND Proveedor WHERE Proveedor.cdg_proveedor = ENTRY(j,ventas_terceros,",") NO-LOCK.
        FIND P-Condicion_impos OF Proveedor NO-LOCK.
        ch_linea = STRING(linea0,">>9").                     
        RUN detalle-char ( INPUT ch_linea  + ",10", 
                       INPUT "(" + STRING(j,"9") + ") " +
                              "Ventas por cuenta y orden de " + 
                              Proveedor.nombre + " C.U.I.T.:" + Proveedor.cuit + "  IVA:" + P-Condicion_impos.texto,
                       INPUT 8, 
                       INPUT NO, 
                       INPUT "BLUE").
        c-linea_detalle = c-linea_detalle + 1.

    END.

    IF Fac_header.leyenda <> ""
    THEN DO:
        c-linea_detalle = c-linea_detalle + 1.
        DO j-tomo = 1 TO NUM-ENTRIES(Fac_header.leyenda,chr(10)):

            v-tomo_leyenda = ENTRY(j-tomo,Fac_header.leyenda,chr(10)).
            IF v-tomo_leyenda <> ""
            THEN DO:
                RUN RENGLONS.P (INPUT  v-tomo_leyenda, 
                                INPUT  v-leng_leyenda,
                                OUTPUT v-detallada,
                                INPUT  "|").

                DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):

                    ch_linea = STRING(linea0,">>9").                     
                    RUN detalle-char ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO, INPUT "BLUE").
                    c-linea_detalle = c-linea_detalle + 1.

                END.
            END.
            ELSE DO:
                c-linea_detalle = c-linea_detalle + 1.
            END.
        END.

    END.

    IF v-leyenda <> ""
    THEN DO:
                      
        c-linea_detalle = c-linea_detalle + 1.

        RUN RENGLONS.P (INPUT  v-leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-detallada,
                        INPUT  "|").
        
        DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
            
            ch_linea = STRING(linea0,">>9").                     
            RUN detalle-char ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO, INPUT "BLUE").
            c-linea_detalle = c-linea_detalle + 1.

        END.

    END.

    IF CAN-FIND(FIRST Fac_header_impuesto OF Fac_header)
    THEN DO:

        lineas_impuestos = 0.
        FOR EACH Fac_header_impuesto OF Fac_header, FIRST Impuesto OF Fac_header_impuesto WHERE NOT Impuesto.es_iva BY Impuesto.cdg_impuesto:
            lineas_impuestos = lineas_impuestos + 1.
        END.

        cantidad_hojas = TRUNC(( c-linea_detalle / nmax_det ),0) + IF c-linea_detalle MOD nmax_det = 0 THEN 0 ELSE 1.
        IF c-linea_detalle + lineas_impuestos > cantidad_hojas * nmax_det THEN cantidad_hojas = cantidad_hojas + 1.
        comienzo_impuestos = cantidad_hojas * nmax_det - lineas_impuestos + 1.

        nreng = c-linea_detalle + 1.
        DO j = nreng TO comienzo_impuestos - 1 BY 1:
            c-linea_detalle = c-linea_detalle + 1.
            RUN detalle-char ( INPUT TRIM(STRING(linea0,">>9")) + ",100", INPUT "", INPUT 8, INPUT NO, INPUT "BLUE").
        END.

        c-linea_detalle = c-linea_detalle + 1.

        FOR EACH Fac_header_impuesto OF Fac_header, FIRST Impuesto OF Fac_header_impuesto WHERE NOT Impuesto.es_iva BY Impuesto.cdg_impuesto:
            RUN detalle-char ( INPUT TRIM(STRING(linea0,">>9")) + ",100", INPUT Impuesto.nombre, INPUT 8, INPUT NO, INPUT "BLUE").
            RUN detalle-numr ( INPUT TRIM(STRING(linea0,">>9")) + ",166", INPUT STRING(Fac_header_impuesto.importe,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO, INPUT "BLUE").        
            c-linea_detalle = c-linea_detalle + 1.
        END.

    END.

END PROCEDURE.

PROCEDURE pie_forma:

    v-cdg_seccion = "PIE-FORMA". 
    c-orden = 0.

    RUN grabar_linea ( "<AT=235,8><#1>").    

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+2,+5><FROM><AT=+7,+190><RECT>"). 
    RUN escribir ( "4,10",  INPUT "NETO GRAVADO C/IVA:", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN linea    ( "2,68",  INPUT "7", "V" ).

    RUN escribir ( "4,70",  INPUT "NO GRAVADO C/IVA / EXENTO:", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN linea    ( "2,136", INPUT "7", "V" ).    
    RUN escribir ( "4,138", INPUT "SUBTOTAL:", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+9,+5><FROM><AT=+7,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+7,+190><RECT>"). 
    
    RUN escribir ( "11,14", INPUT "SUBTOTAL", INPUT 8, INPUT YES, INPUT "BLACK").
    
    RUN linea    ( "9,36", INPUT "14", "V" ).
    RUN escribir ( "11,44", INPUT "IMPUESTOS", INPUT 8, INPUT YES, INPUT "BLACK").
    
    RUN linea    ( "9,68", INPUT "14", "V" ).
    RUN escribir ( "11,77", INPUT "SUBTOTAL", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "9,102", INPUT "14", "V" ).
    RUN escribir ( "11,112", INPUT "IVA " + STRING(prciva,">>9.99 %"), INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "9,136", INPUT "14", "V" ).    
    RUN escribir ( "11,140", INPUT "IVA N.I 10.5 %", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN linea    ( "9,166", INPUT "14", "V" ).    
    RUN escribir ( "11,174", INPUT "TOTAL", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+23,+5><FROM><AT=+7,+190><RECT>"). 
    RUN escribir ( INPUT "25,10", INPUT "IMPRIME ", INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "25,94", INPUT "C.A.I.:", INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "24,129", INPUT "FECHA DE VENCIMIENTO:", INPUT 10, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "25,23", INPUT Empresa.nombre, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "25,102", INPUT Fac_header.cai, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "24,175", INPUT STRING(Fac_header.rige_hasta,"99/99/9999"), INPUT 10, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "32,169", INPUT "Nombrecopia", INPUT 8, INPUT YES, INPUT "BLACK"). 

END PROCEDURE.

PROCEDURE pie_datos:
            
    v-cdg_seccion = "PIE-DATOS". 
    c-orden = 0.

    RUN poner_monto_letras.

    RUN grabar_linea ( "<AT=235,8><#1>").    

    RUN escribir ( "4,48",  INPUT STRING(v-imp_gravado,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,114", INPUT STRING(v-imp_exento,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,158", INPUT STRING(v-con_impuestos,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,16", INPUT STRING(Fac_header.imp_neto ,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,38", INPUT STRING(0,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,76", INPUT STRING(Fac_header.imp_neto,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,113", INPUT STRING(Fac_header.imp_iva,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,138", INPUT STRING(0,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,172", INPUT STRING(Fac_header.imp_total,"-ZZ,ZZZ,ZZ9.99"), INPUT 10, INPUT YES, INPUT "BLUE").


END PROCEDURE.

PROCEDURE pie_relleno:
            
    v-cdg_seccion = "PIE-FILLER". 
    c-orden = 0.

    RUN grabar_linea ( "<AT=235,8><#1>").    
    
    RUN escribir ( "4,50",  INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,114", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,158", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,16", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,38", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,76", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,113", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,138", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,172", INPUT "***************", INPUT 10, INPUT YES, INPUT "BLUE").

END PROCEDURE.

PROCEDURE pie_nocategorizado:
            
    v-cdg_seccion = "PIE-NOCAT". 
    c-orden = 0.
    
    RUN poner_monto_letras.

    RUN grabar_linea ( "<AT=235,8><#1>").    

    RUN escribir ( "4,50",  INPUT "==========", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,114", INPUT "==========", INPUT 8, INPUT YES, INPUT "BLUE").
    
    RUN escribir ( "4,158", INPUT "==============", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,16", INPUT "===========", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,38", INPUT "=============", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,76", INPUT "=============", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,113", INPUT "=============", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,138", INPUT "=============", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,172", INPUT STRING(Fac_header.imp_total,"-ZZ,ZZZ,ZZ9.99"), INPUT 10, INPUT YES, INPUT "BLUE").

END PROCEDURE.

PROCEDURE poner_monto_letras:

    RUN grabar_linea ( "<AT=227,8><#1>").    

    RUN RENGLONS.P (INPUT  Fac_header.monto_letras, 
                    INPUT  v-leng_monto,
                    OUTPUT v-monto_letras,
                    INPUT  "|").
    
    linea0 = 0 .
    IF Moneda.es_local
        THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT "SON " + Moneda.descripcion, INPUT 8, INPUT YES, INPUT "BLACK").
        ELSE RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT "SON " + Moneda.descripcion /*+ " a una razón de cambio de $" + STRING(Fac_header.cambio,">>>9.9999")*/, INPUT 8, INPUT YES, INPUT "BLACK").
    DO j = 1 TO v-reng_monto:
        IF j <= NUM-ENTRIES(v-monto_letras, "|")
           THEN RUN escribir ( INPUT TRIM(STRING(linea0 + j * 4,">>9")) + ",10", INPUT ENTRY(j,v-monto_letras, "|"), INPUT 6, INPUT NO, INPUT "BLUE").
    END.

END PROCEDURE.

PROCEDURE contar_paginas:

    nt-lineas = 0.
    nt-hojas = 1.
    FOR EACH T-Detalle BREAK BY T-Detalle.n-linea:

        IF LAST-OF(T-Detalle.n-linea)
        THEN DO:
            nt-lineas = nt-lineas + 1.
            IF nt-lineas > nmax_det
            THEN DO:
                 nt-hojas = nt-hojas + 1.
                 nt-lineas = 1.
            END.
        END.

    END.

END PROCEDURE.

PROCEDURE detalle-char:

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

    linea = '<FGCOLOR=' + nomcolor + '><=#1><AT=+' + "&&" + ',+' + 
            TRIM(STRING(i-columna,">>9")) + '><FCourierNew><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    c-orden = c-orden + 1.

    CREATE T-Detalle.
    ASSIGN T-Detalle.n-orden = c-orden
           T-Detalle.n-linea = c-linea_detalle
           T-Detalle.l-texto = linea.

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

    linea = '<FGCOLOR=' + nomcolor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FCourierNew><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    RUN grabar_linea ( linea ).

END PROCEDURE.

PROCEDURE detalle-numr:

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
    
    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    
    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=' + nomcolor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + "&&" + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             "<DECIMAL=+0>" + texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 

    c-orden = c-orden + 1.

    CREATE T-Detalle.
    ASSIGN T-Detalle.n-orden = c-orden
           T-Detalle.n-linea = c-linea_detalle
           T-Detalle.l-texto = linea.

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
    
    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    
    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=' + nomcolor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             "<DECIMAL=+0>" + texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
/*
    message linea view-as alert-box message title "plot".
*/    

    RUN grabar_linea ( linea ).

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

    RUN grabar_linea ( linea ).

END PROCEDURE.

PROCEDURE bajar_copias:

   /*
   OUTPUT STREAM Formulario TO "c:\sic-temp\prfaa103.txt" CONVERT TARGET "iso8859-1".
   FOR EACH T-Detalle:
       PUT STREAM Formulario UNFORMATTED
            T-Detalle.n-orden ";" 
            T-Detalle.n-linea ";" 
            T-Detalle.n-columna ";"
            T-Detalle.l-texto SKIP.
   END.
   OUTPUT CLOSE.
   RUN VERESULT.W ( INPUT "c:\sic-temp\prfaa103.txt", INPUT 22 ).
   */
   
   RUN contar_paginas.

   DO ncopia = 1 TO nt-copias:    

        OUTPUT STREAM Formulario TO "c:\sic-temp\prfaa103.xpr" CONVERT TARGET "iso8859-1".

        n-hoja = 1.

        RUN bajar_seccion ("INIT").
        RUN bajar_seccion ("CAB-FORMA").
        RUN bajar_seccion ("DET-FORMA").
        RUN bajar_seccion ("PIE-FORMA").
        RUN bajar_seccion ("CAB-DATOS").

        FOR EACH T-Listado WHERE T-Listado.cdg_seccion = "DET-DATOS":
            DELETE T-Listado.
        END.

        c-orden = 0.
        v-cdg_seccion = "DET-DATOS".
        linea0 = 102.

        c-linea_detalle = 0.
        FOR EACH T-Detalle BREAK BY T-Detalle.n-linea:

            IF FIRST-OF(T-Detalle.n-linea)
            THEN DO:
                c-linea_detalle = T-Detalle.n-linea - ( n-hoja - 1 ) * nmax_det.
                IF c-linea_detalle > nmax_det
                THEN DO:

                    RUN bajar_seccion ("DET-DATOS").
                    RUN bajar_seccion ("PIE-FILLER").

                    OUTPUT STREAM Formulario CLOSE.
                    FILE-INFO:File-NAME = "c:\sic-temp\prfaa103.xpr".
                    RUN printFile( FILE-INFO:FULL-PATHNAME).
                    OUTPUT STREAM Formulario TO "c:\sic-temp\prfaa103.xpr" CONVERT TARGET "iso8859-1".

                    n-hoja = n-hoja + 1.

                    RUN bajar_seccion ("INIT").
                    RUN bajar_seccion ("CAB-FORMA").
                    RUN bajar_seccion ("DET-FORMA").
                    RUN bajar_seccion ("PIE-FORMA").
                    RUN bajar_seccion ("CAB-DATOS").

                    FOR EACH T-Listado WHERE T-Listado.cdg_seccion = "DET-DATOS":
                        DELETE T-Listado.
                    END.

                    c-orden = 0.
                    c-linea_detalle = 1.

                END.
            
            END.

            RUN grabar_linea ( INPUT REPLACE(T-Detalle.l-texto,"&&",TRIM(STRING(linea0 + c-linea_detalle * 4 ,">>>9")))).

        END.

        RUN bajar_seccion ("DET-DATOS").        
        IF Condicion_impos.cdg_condiva = 8
            THEN RUN bajar_seccion ("PIE-NOCAT").
            ELSE RUN bajar_seccion ("PIE-DATOS").

        OUTPUT STREAM Formulario CLOSE.
        
        FILE-INFO:File-NAME = "c:\sic-temp\prfaa103.xpr".
        RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */

    END.

END PROCEDURE.

PROCEDURE bajar_seccion:

    DEFINE INPUT PARAMETER p-seccion AS CHARACTER.

    FOR EACH T-Listado WHERE T-Listado.cdg_seccion = p-seccion:
        v-registro = REPLACE(T-Listado.l-linea,"Nombrecopia",nombre_copia [ ncopia ]).
        v-registro = REPLACE(v-registro,"##",STRING(n-hoja,"99")).
        v-registro = REPLACE(v-registro,"@@",STRING(nt-hojas,"99")).
        PUT STREAM Formulario UNFORMATTED v-registro SKIP.
    END.

END PROCEDURE.

PROCEDURE grabar_linea:

    DEFINE INPUT PARAMETER texto  AS CHARACTER.

    c-orden = c-orden + 1 . /* Incrementamos el contador de registros */

    CREATE T-Listado.
    ASSIGN T-Listado.cdg_seccion = v-cdg_seccion
           T-Listado.l-orden   = c-orden
           T-Listado.l-linea   = texto.

END PROCEDURE.
