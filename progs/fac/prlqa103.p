/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE LIQUIDO PRODUCTO A                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Forma NO-UNDO
    FIELD n-reg      AS INTEGER
    FIELD t-tomo     AS INTEGER
    FIELD c-reg      AS CHARACTER
    INDEX por-reg IS UNIQUE n-reg.

{NOMMESES.I}
{xprint.i}

FUNCTION fnComprobante RETURN CHARACTER ( tip AS CHARACTER, prf AS INTEGER, nro AS INTEGER).
  RETURN tip + "-" + STRING(prf,"9999") + "-" + STRING(nro,"99999999").
END FUNCTION.

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE k              AS INTEGER INITIAL 10.
DEFINE VARIABLE k-reg          AS INTEGER INITIAL 0.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.
DEFINE VARIABLE nt-lineas      AS INTEGER.
DEFINE VARIABLE nt-copias      AS INTEGER INITIAL 2.
DEFINE VARIABLE nt-hojas       AS INTEGER.
DEFINE VARIABLE n-hoja         AS INTEGER.
DEFINE VARIABLE n-tomo         AS INTEGER.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 25. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 85. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 135. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 105. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.
DEFINE VARIABLE lineal         AS INTEGER.

DEFINE VARIABLE v-cantidad     LIKE Fac_detalle_prv.cantidad.
DEFINE VARIABLE v-subtotal     LIKE Fac_detalle_prv.subtotal_neto.

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

DEFINE VARIABLE nombre_copia   AS CHARACTER EXTENT 10 
    INITIAL ["Original","Duplicado","Triplicado","Cuadruplicado","Quinutplicado",
             "Sextuplicado","Septuplicado","Octuplicado","Nonuplicado","Decuplicado"].

DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Fac_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Fac_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE v-imp_gravado  LIKE Fac_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-imp_exento   LIKE Fac_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-con_impuestos LIKE Fac_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE t-cantidad     AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE t-pesos        AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE s-cantidad     AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE s-pesos        AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".

DEFINE BUFFER Provlegal FOR Provincia.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = rid_factura EXCLUSIVE-LOCK.
    /*
    v-reimpresion = IF Fac_header_prv.impreso = "S" THEN "REIMPRESION" ELSE "".
    */
    FIND Punto-venta WHERE Punto-venta.cdg_empresa = Fac_header_prv.cdg_empresa
                       AND Punto-venta.cdg_puntovta = Fac_header_prv.prf_comprob
                           NO-LOCK.
    FIND FIRST Vigencia_cai 
         WHERE Vigencia_cai.cdg_empresa = Fac_header_prv.cdg_empresa
           AND Vigencia_cai.tip_comprob = Fac_header_prv.tip_comprob
           AND Vigencia_cai.prf_comprob = Fac_header_prv.prf_comprob
           AND Vigencia_cai.rige_hasta  >= Fac_header_prv.fecha
               NO-LOCK NO-ERROR.

    FIND Tipocomprobante OF Fac_header_prv NO-LOCK.
    FIND Empresa OF Fac_header_prv NO-LOCK.
    FIND Condicion_impos OF Fac_header_prv NO-LOCK.
    FIND Condicion_venta OF Fac_header_prv NO-LOCK.
    FIND Provincia OF Fac_header_prv NO-LOCK.
    FIND Proveedor   OF Fac_header_prv NO-LOCK.
    FIND Provlegal OF Proveedor NO-LOCK.    
    FIND Domicilio_prv OF Fac_header_prv NO-LOCK NO-ERROR.
    FIND Usuario OF Fac_header_prv NO-LOCK.
    FIND FIRST Cta_cte_prv WHERE Cta_cte_prv.tip_comprob = Fac_header_prv.tip_comprob
                             AND Cta_cte_prv.cdg_empresa = Fac_header_prv.cdg_empresa
                             AND Cta_cte_prv.prf_comprob = Fac_header_prv.prf_comprob
                             AND Cta_cte_prv.nro_comprob = Fac_header_prv.nro_comprob
                                 NO-LOCK NO-ERROR.
    

    FIND Fac_header_prv_impuesto OF Fac_header_prv
         WHERE Fac_header_prv_impuesto.cdg_impuesto = 1
               NO-LOCK NO-ERROR.
    IF AVAILABLE Fac_header_prv_impuesto
    THEN DO:
        prciva = Fac_header_prv_impuesto.tasa.
        prcnoi = prciva / 2.
    END.
    
    que_mes = STRING(MONTH(Fac_header_prv.fecha),"99").
    que_ano = STRING(YEAR(Fac_header_prv.fecha),"9999").
    que_dia = STRING(DAY(Fac_header_prv.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Fac_header_prv.fecha) ] + " de " + que_ano.
        
    /*Fac_header_prv.impreso = "S".    */
    
    /*---------------------------------------------------------------------------------*/
    /*             DISCRIMINA EL NETO GRAVADO CON IVA DEL NETO EXENTO                  */
    /*---------------------------------------------------------------------------------*/

    v-imp_gravado = 0.
    v-con_impuestos = Fac_header_prv.imp_neto.
    FOR EACH Fac_header_prv_impuesto OF Fac_header_prv, FIRST Impuesto OF Fac_header_prv_impuesto:
        IF Impuesto.es_iva 
           THEN v-imp_gravado = v-imp_gravado + Fac_header_prv_impuesto.monto_imponible.
           ELSE v-con_impuestos = v-con_impuestos + Fac_header_prv_impuesto.importe.
    END.
    v-imp_exento = Fac_header_prv.imp_neto - v-imp_gravado.

    /*---------------------------------------------------------------------------------*/
    /*                CUENTA LA CANTIDAD TOTAL DE HOJAS A IMPRIMIR                     */
    /*---------------------------------------------------------------------------------*/

    nt-lineas = 0.
    nt-hojas = 0.
    FOR EACH Fac_detalle_prv OF Fac_header_prv 
             WHERE Fac_detalle_prv.cantidad <> 0 OR Fac_detalle_prv.granel <> 0 OR TRUE:

        nt-lineas = nt-lineas + 1.
        IF nt-lineas = nmax_det
        THEN DO:
             nt-lineas = 0.
             nt-hojas = nt-hojas + 1.
        END.

    END.
    IF nt-lineas <> 0 THEN nt-hojas = nt-hojas + 1.
     
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DE LA FACTURA                               */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    n-hoja = 1.
    RUN imprimir.

    RUN bajar_copias.

/*  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */*/
    
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE inicia_formulario:

    RUN poner ( INPUT '<PREVIEW=70>' ) /*=ZoomToWidth>'*/.
 /* RUN poner ( INPUT '<TOOLBAR=!PRINT>'. */
    
    RUN poner ( INPUT "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>" ).
    RUN poner ( INPUT "<FORMAT=Letter>" ).
    RUN poner ( INPUT "<AT=14,8><#1>" ).    
    RUN poner ( INPUT "<AT=172,10><#2>" ).    

END PROCEDURE.

PROCEDURE imprimir:

    n-tomo = 1.
    RUN inicia_formulario.
    n-tomo = 2.
    RUN cabecera_forma.
    n-tomo = 3.
    RUN detalle_forma.
    n-tomo = 4.
    RUN pie_forma.
    n-tomo = 5.    
    RUN cabecera_datos.
    n-tomo = 6.
    RUN detalle_datos.
    n-tomo = 7.
    RUN pie_datos.

END PROCEDURE.

PROCEDURE cabecera_forma:

    RUN poner ( INPUT "<AT=14,8><#1>" ).    

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+39,+190><RECT>" ). 
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+44,+5><FROM><AT=+06,+190><RECT>" ). 
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+50,+5><FROM><AT=+27,+190><RECT>" ). 
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+77,+5><FROM><AT=+10,+190><RECT>" ). 
    /*
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>" ). 
    */
    RUN escribir ( "45,91", INPUT "COMITENTE", INPUT 10, INPUT YES, INPUT "BLACK").    
    
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+102,+5><FROM><AT=+120,+190><RECT>" ). 

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+07,+13><#3><AT=+12,+60><IMAGE#3=.\imagenes\logo.bmp>" ).
    RUN escribir ( INPUT "22,10", INPUT Empresa.nombre, INPUT 12, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "28,10", INPUT Punto-venta.direccion, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "28,105", INPUT "C.U.I.T.: " + Empresa.cuit, INPUT 8, INPUT NO, INPUT "BLACK"). 

    RUN escribir ( INPUT "32,10", INPUT Punto-venta.localidad + " - " + Punto-venta.provincia, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "32,105", INPUT "Ingresos Brutos(Conv.Multil.): 902-871143-5", INPUT 8, INPUT NO, INPUT "BLACK"). 

    RUN escribir ( INPUT "36,10", INPUT Punto-venta.telefono, INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "36,105", INPUT "INICIO DE ACTIVIDADES 10/2002", INPUT 8, INPUT NO, INPUT "BLACK"). 
    
    RUN escribir ( INPUT "39,160", INPUT v-reimpresion, INPUT 10, INPUT YES, INPUT "RED"). 

    RUN escribir ( INPUT "40,10", INPUT "I.V.A. RESPONSABLE INSCRIPTO", INPUT 8, INPUT NO, INPUT "BLACK"). 

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+05,+95><FROM><AT=+10,+10><RECT>" ). 
    RUN linea    ( "15,100", INPUT "29", "V" ).

    RUN escribir ( INPUT "6,107", INPUT Tipocomprobante.denominacion_impresa, INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "11,107", INPUT "NRO.: ", INPUT 12, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "16,107", INPUT "FECHA: ", INPUT 12, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "16,165", INPUT "HOJA: ", INPUT 12, INPUT YES, INPUT "BLACK").
    
    RUN escribir ( INPUT "67,10", INPUT "C.U.I.T.:", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "67,55", INPUT "I.BRUTOS:" , INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( INPUT "78,10", INPUT "CONDICION DE VENTA:", INPUT 8, INPUT NO, INPUT "BLACK").

    RUN escribir ( INPUT "78,140", INPUT "VENCIMIENTO:", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( INPUT "82,10", INPUT "HEMOS VENDIDO POR VUESTRA CUENTA Y ORDEN LO SIGUIENTE:", INPUT 8, INPUT NO, INPUT "BLACK").

END PROCEDURE.

PROCEDURE detalle_forma:

    RUN poner ( INPUT "<AT=14,8><#1>" ).    

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+88,+5><FROM><AT=+7,+190><RECT>" ). 
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>" ). 
    
    RUN escribir ( "90,10", INPUT "CODIGO DE", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN escribir ( "97,10", INPUT "ARTICULO", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN linea    ( "88,31", INPUT "14", "V" ).

    RUN escribir ( "90,53", INPUT "UNIDADES", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN escribir ( "90,136", INPUT "PESOS", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN escribir ( "97,34", INPUT "VENTA BRUTA", INPUT 6, INPUT YES, INPUT "BLACK").
    RUN linea    ( "95,51", INPUT "7", "V" ).
    RUN escribir ( "97,53", INPUT "DEVOLUCIONES", INPUT 6, INPUT YES, INPUT "BLACK").

    RUN linea    ( "95,71", INPUT "7", "V" ).
    RUN escribir ( "97,74", INPUT "VENTA NETA", INPUT 6, INPUT YES, INPUT "BLACK").
    RUN linea    ( "88,91", INPUT "14", "V" ).
    RUN escribir ( "97,94", INPUT "VENTA BRUTA", INPUT 6, INPUT YES, INPUT "BLACK").
    RUN linea    ( "95,111", INPUT "7", "V" ).
    RUN escribir ( "97,114", INPUT "DEVOLUCION", INPUT 6, INPUT YES, INPUT "BLACK").
    RUN linea    ( "95,131", INPUT "7", "V" ).
    RUN escribir ( "97,133", INPUT "BONIFICACION", INPUT 6, INPUT YES, INPUT "BLACK").
    RUN linea    ( "95,151", INPUT "7", "V" ).
    RUN escribir ( "97,153", INPUT "BON.POR PROM.", INPUT 6, INPUT YES, INPUT "BLACK").
    RUN linea    ( "95,171", INPUT "7", "V" ).
    RUN escribir ( "97,175", INPUT "NETO LIQUIDO", INPUT 6, INPUT YES, INPUT "BLACK").

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+102,+5><FROM><AT=+113,+190><RECT>" ). 

    RUN linea    ( "215,91", INPUT "7", "V" ).
    RUN linea    ( "215,111", INPUT "7", "V" ).
    RUN linea    ( "215,131", INPUT "7", "V" ).
    RUN linea    ( "215,151", INPUT "7", "V" ).
    RUN linea    ( "215,171", INPUT "7", "V" ).

    RUN escribir ( "217,20", INPUT "SUMATORIAS", INPUT 8, INPUT YES, INPUT "BLACK").

END PROCEDURE.

PROCEDURE cabecera_datos:

    RUN poner ( INPUT "<AT=14,8><#1>" ).    

    RUN escribir ( INPUT "7,98", INPUT SUBSTRING(Fac_header_prv.tip_comprob,2,1), INPUT 16, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "11,120", INPUT STRING(Fac_header_prv.prf_comprob,"9999") + "-" + STRING(Fac_header_prv.nro_comprob,"99999999"), INPUT 12, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "16,124", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "16,180", INPUT TRIM(STRING(n-hoja,">>9")) + "/" + TRIM(STRING(nt-hojas,">>9")), INPUT 12, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "51,10", INPUT Proveedor.nombre, INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( INPUT "51,85", INPUT "[" + Proveedor.cdg_Proveedor + "]", INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "55,10", INPUT Proveedor.direccion, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "59,10", INPUT "(" + Proveedor.cdg_postal + ") " + Proveedor.localidad, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,10", INPUT Provlegal.nombre , INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,85", INPUT "[" + Provlegal.cdg_provincia + "]", INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "67,20", INPUT Proveedor.cuit, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "67,75", INPUT Proveedor.numero_ibr, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "71,10", INPUT "I.V.A." + Condicion_impos.texto, INPUT 8, INPUT NO, INPUT "BLUE").
/*
    RUN escribir ( INPUT "51,105", INPUT Domicilio_prv.nombre, INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( INPUT "51,175", INPUT "[" + STRING(Domicilio_prv.nro_domicilio,"9999") + "]", INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "55,105", INPUT Domicilio_prv.direccion, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "59,105", INPUT "(" + Domicilio_prv.cdg_postal + ") " + Domicilio_prv.localidad, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,105", INPUT Provincia.nombre, INPUT 8, INPUT NO, INPUT "BLUE").
    RUN escribir ( INPUT "63,175", INPUT "[" + Provincia.cdg_provincia + "]", INPUT 8, INPUT NO, INPUT "BLUE").

    RUN escribir ( INPUT "67,119", INPUT Usuario.nombre, INPUT 8, INPUT NO, INPUT "BLUE").
*/
    RUN escribir ( INPUT "78,42", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO, INPUT "BLUE").

    IF AVAILABLE Cta_cte_prv
       THEN RUN escribir ( INPUT "78,160", INPUT STRING(Cta_cte_prv.fecha_vencimiento,"99/99/9999"), INPUT 8, INPUT NO, INPUT "BLUE").

END PROCEDURE.

PROCEDURE detalle_datos:

    RUN poner ( INPUT "<AT=14,8><#1>" ).    

    linea0 = 1.
    v-cantidad = 0.
    v-subtotal = 0.
    s-cantidad = 0.
    s-pesos = 0.

    FOR EACH Fac_detalle_prv OF Fac_header_prv 
             WHERE Fac_detalle_prv.cantidad <> 0 OR Fac_detalle_prv.granel <> 0 OR fac_detalle_prv.subtotal_neto <> 0,
                   Articulo OF Fac_detalle_prv 
                   BREAK BY Articulo.cdg_articulo:
/*MESSAGE LENGTH(v-formulario [ n-tomo ]) VIEW-AS ALERT-BOX MESSAGE.*/
        IF Fac_detalle_prv.a_granel 
        THEN DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
             v-cantidad = Fac_detalle_prv.granel.
        END.
        ELSE DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
             v-cantidad = Fac_detalle_prv.cantidad.
        END.

        RUN verificar_fin_hoja.

        ch_linea = STRING(102 + linea0 * 4,">>9").  
        
        t-cantidad = 0.
        t-pesos = 0.

        FOR EACH Detalle_liquido OF Fac_detalle_prv, Imputacion OF Detalle_liquido:
            t-cantidad [ 1 ] = t-cantidad [ 1 ] + Detalle_liquido.cantidad.
            t-cantidad [ 2 ] = t-cantidad [ 2 ] + Detalle_liquido.cantidad_dev.
            t-pesos [ Imputacion.num_columna ] = t-pesos [ Imputacion.num_columna ] + Detalle_liquido.subtotal_neto.
        END.

        t-pesos [ 5 ] = t-pesos [ 1 ].
        DO j = 2 TO 4:
           t-pesos [ 5 ] = t-pesos [ 5 ] + t-pesos [ j ].
        END.
        t-cantidad [ 3 ] = t-cantidad [ 1 ] + t-cantidad [ 2 ].

        DO j = 1 TO 5:
           s-pesos [ j ] = s-pesos [ j ] + t-pesos [ j ].
        END.

        RUN escribenumero ( ch_linea  + ",027", INPUT STRING(t-cantidad [ 1 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",047", INPUT STRING(t-cantidad [ 2 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",067", INPUT STRING(t-cantidad [ 3 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",087", INPUT STRING(t-pesos [ 1 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",107", INPUT STRING(t-pesos [ 2 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",127", INPUT STRING(t-pesos [ 3 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",147", INPUT STRING(t-pesos [ 4 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        RUN escribenumero ( ch_linea  + ",170", INPUT STRING(t-pesos [ 5 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
        
        RUN escribir      ( ch_linea  + ",7", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO, INPUT "BLUE").
        
        linea0 = linea0 + 1.

        v-cantidad = 0.
        v-subtotal = 0.
        
    END.

    IF Fac_header_prv.leyenda <> ""
    THEN DO:
                      
        linea0 = linea0 + 2.

        RUN RENGLONS.P (INPUT  Fac_header_prv.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-detallada,
                        INPUT  "|").
        
        DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
            
            RUN verificar_fin_hoja.
            ch_linea = STRING(102 + linea0 * 4,">>9").                     
            RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO, INPUT "BLUE").
            linea0 = linea0 + 1.
 
        END.
    
    END.

    linea0 = 211 .
    FOR EACH Fac_header_prv_impuesto OF Fac_header_prv, FIRST Impuesto OF Fac_header_prv_impuesto WHERE NOT Impuesto.es_iva BY Impuesto.cdg_impuesto DESCENDING:
        RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",100", INPUT Impuesto.nombre, INPUT 8, INPUT NO, INPUT "BLUE").
        RUN escribenumero ( INPUT TRIM(STRING(linea0,">>9")) + ",166", INPUT STRING(Fac_header_prv_impuesto.importe,"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE").        
        linea0 = linea0 - 4.
    END.

    RUN escribenumero ( "217,087", INPUT STRING(s-pesos [ 1 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
    RUN escribenumero ( "217,107", INPUT STRING(s-pesos [ 2 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
    RUN escribenumero ( "217,127", INPUT STRING(s-pesos [ 3 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
    RUN escribenumero ( "217,147", INPUT STRING(s-pesos [ 4 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 
    RUN escribenumero ( "217,170", INPUT STRING(s-pesos [ 5 ],"ZZ,ZZZ,ZZ9.99-"), INPUT 8, INPUT NO, INPUT "BLUE"). 

END PROCEDURE.

PROCEDURE pie_forma:

    RUN poner ( INPUT "<AT=235,8><#1>" ).    

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+2,+5><FROM><AT=+7,+190><RECT>" ). 
    RUN escribir ( "4,10",  INPUT "NETO GRAVADO C/IVA:", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN linea    ( "2,68",  INPUT "7", "V" ).

    RUN escribir ( "4,70",  INPUT "NO GRAVADO C/IVA:", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN linea    ( "2,136", INPUT "7", "V" ).    
    RUN escribir ( "4,138", INPUT "SUBTOTAL:", INPUT 8, INPUT YES, INPUT "BLACK").

    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+9,+5><FROM><AT=+7,+190><RECT>" ). 
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+7,+190><RECT>" ). 
    
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
    RUN poner ( INPUT "<=#1><BGCOLOR=WHITE><AT=+23,+5><FROM><AT=+7,+190><RECT>" ). 
    RUN escribir ( INPUT "25,10", INPUT "IMPRIME ", INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "25,94", INPUT "C.A.I.:", INPUT 8, INPUT NO, INPUT "BLACK"). 
    RUN escribir ( INPUT "24,129", INPUT "FECHA DE VENCIMIENTO:", INPUT 10, INPUT YES, INPUT "BLACK"). 

    RUN escribir ( INPUT "25,23", INPUT Empresa.nombre, INPUT 8, INPUT NO, INPUT "BLACK"). 
    IF AVAILABLE Vigencia_cai
    THEN DO:
         RUN escribir ( INPUT "25,102", INPUT Vigencia_cai.cai, INPUT 8, INPUT NO, INPUT "BLACK"). 
         RUN escribir ( INPUT "24,175", INPUT STRING(Vigencia_cai.rige_hasta,"99/99/9999"), INPUT 10, INPUT YES, INPUT "BLACK"). 
    END.
    ELSE DO:
         RUN escribir ( INPUT "25,102", INPUT "<<NO HALLADO>>", INPUT 8, INPUT NO, INPUT "BLACK"). 
         RUN escribir ( INPUT "24,175", INPUT "????????", INPUT 10, INPUT YES, INPUT "BLACK"). 
    END.
    RUN escribir ( INPUT "32,169", INPUT "Nombrecopia", INPUT 8, INPUT YES, INPUT "BLACK"). 

END PROCEDURE.

PROCEDURE pie_datos:
            
    RUN poner ( INPUT "<AT=235,8><#1>" ).    
    
    IF Fac_header_prv.leyenda <> ""
    THEN DO:   
        
        RUN RENGLONS.P (INPUT  Fac_header_prv.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
        
        linea0 = 220.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",0", INPUT ENTRY(j,v-leyenda, "|"), INPUT 10, INPUT NO, INPUT "BLACK").
            linea0 = linea0 + 3.
        END.
    
    END.

    RUN escribir ( "4,50",  INPUT STRING(v-imp_gravado,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,110", INPUT STRING(v-imp_exento,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,158", INPUT STRING(v-con_impuestos,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").

    RUN escribir ( "18,16", INPUT STRING(Fac_header_prv.imp_neto,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    
    RUN escribir ( "18,38", INPUT STRING(0,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").
    
    RUN escribir ( "18,76", INPUT STRING(Fac_header_prv.imp_neto,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").

    RUN escribir ( "18,113", INPUT STRING(Fac_header_prv.imp_iva,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").

    RUN escribir ( "18,138", INPUT STRING(0,"-ZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT YES, INPUT "BLUE").

    RUN escribir ( "18,172", INPUT STRING(Fac_header_prv.imp_total,"-ZZ,ZZZ,ZZ9.99"), INPUT 10, INPUT YES, INPUT "BLUE").


END PROCEDURE.

PROCEDURE pie_relleno:
            
    RUN poner ( INPUT "<AT=235,8><#1>" ).    
    
    RUN escribir ( "4,50",  INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,110", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "4,158", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,16", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,38", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,76", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,113", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,138", INPUT "***************", INPUT 8, INPUT YES, INPUT "BLUE").
    RUN escribir ( "18,172", INPUT "***************", INPUT 10, INPUT YES, INPUT "BLUE").


END PROCEDURE.

PROCEDURE poner:

    DEFINE INPUT PARAMETER texto    AS CHARACTER.

 /* IF LENGTH(v-formulario [ n-tomo ] +  texto) > 31000  THEN MESSAGE n-tomo texto.*/

    k-reg = k-reg + 1.
    CREATE T-Forma.
    ASSIGN T-Forma.n-reg = k-reg
           T-Forma.t-tomo = n-tomo
           T-Forma.c-reg = texto.
    /*
    v-formulario [ n-tomo ] = v-formulario [ n-tomo ] +  texto.    
    */
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

   /* RUN poner ( INPUT linea.*/
    RUN poner ( INPUT linea ).

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

    RUN poner ( INPUT linea ).

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

   /* RUN poner ( INPUT linea.*/
    RUN poner ( INPUT linea ).
    

END PROCEDURE.

PROCEDURE verificar_fin_hoja:

   IF linea0 > nmax_det
   THEN DO:

        linea0 = linea0 + 1.
        ch_linea = STRING(100 + linea0 * 4,">>9").  

        RUN escribir ( ch_linea  + ",97", INPUT "Continúa en hoja " + STRING(n-hoja + 1 ,">>9"), INPUT 10, INPUT NO, INPUT "BLACK").

        n-tomo = 7.
        RUN pie_relleno.
        RUN bajar_copias.
        
        n-hoja = n-hoja + 1.
        n-tomo = 1.
        RUN inicia_formulario.
        n-tomo = 2.
        RUN cabecera_forma.
        n-tomo = 3.
        RUN detalle_forma.
        n-tomo = 4.
        RUN pie_forma.
        n-tomo = 5.    
        RUN cabecera_datos.
        n-tomo = 6.
        linea0 = 1.

   END.

END PROCEDURE.

PROCEDURE bajar_copias:

   DO ncopia = 1 TO nt-copias:    

        OUTPUT STREAM Formulario TO "c:\sic-temp\prlqa103.xpr" CONVERT TARGET "iso8859-1".
        FOR EACH T-Forma:
            v-registro = REPLACE(T-Forma.c-reg,"Nombrecopia",nombre_copia [ ncopia ]).
            PUT STREAM Formulario UNFORMATTED v-registro.
        END.
        OUTPUT STREAM Formulario CLOSE.
        FILE-INFO:File-NAME = "c:\sic-temp\prlqa103.xpr".
        RUN printFile( FILE-INFO:FULL-PATHNAME). 

   END.

   EMPTY TEMP-TABLE T-Forma.
   k-reg = 0.

END PROCEDURE.
