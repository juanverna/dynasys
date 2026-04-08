/*=================================================================================*/
/*                     IMPRESION DE FORMULARIO DE FACTURA DE CREDITO               */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-que_empresa     LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-tip_comprob     LIKE Cta_cte.tip_comprob.
DEFINE INPUT  PARAMETER p-prf_comprob     LIKE Cta_cte.prf_comprob.
DEFINE INPUT  PARAMETER p-nro_comprob     LIKE Cta_cte.nro_comprob.
DEFINE INPUT  PARAMETER p-nro_vencimiento LIKE Cta_cte.nro_vencimiento.
DEFINE OUTPUT PARAMETER p-anduvo_bien     AS LOGICAL.

/*
DEFINE VARIABLE p-que_empresa     LIKE Empresa.cdg_empresa INITIAL "C".
DEFINE VARIABLE p-tip_comprob     LIKE Cta_cte.tip_comprob INITIAL "FA".
DEFINE VARIABLE p-prf_comprob     LIKE Cta_cte.prf_comprob INITIAL 1.
DEFINE VARIABLE p-nro_comprob     LIKE Cta_cte.nro_comprob INITIAL 11126.
DEFINE VARIABLE p-nro_vencimiento LIKE Cta_cte.nro_vencimiento INITIAL 1.
DEFINE VARIABLE p-anduvo_bien AS LOGICAL.
*/
/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{nommeses.i}
{xprint.i}

DEFINE VARIABLE TextColor                 AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color                  AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente                 AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                         AS INTEGER INITIAL 10.
DEFINE VARIABLE ncopia                    AS INTEGER.

DEFINE VARIABLE que_fecha                 AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE que_mes                   AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano                   AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE v-monto_letras            AS CHARACTER.
DEFINE VARIABLE v-renglones               AS CHARACTER.

DEFINE VARIABLE v-saldo_total             LIKE Cta_cte.imp_total.
DEFINE VARIABLE v-saldo_neto              LIKE Cta_cte.imp_neto.
DEFINE VARIABLE v-saldo_iva               LIKE Cta_cte.imp_iva.

DEFINE STREAM Formulario.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Cta_cte WHERE Cta_cte.cdg_empresa     = p-que_empresa
               AND Cta_cte.tip_comprob     = p-tip_comprob
               AND Cta_cte.prf_comprob     = p-prf_comprob
               AND Cta_cte.nro_comprob     = p-nro_comprob
               AND Cta_cte.nro_vencimiento = p-nro_vencimiento
                   NO-ERROR.

IF AVAILABLE Cta_cte
THEN DO:                   

    FIND Empresa             OF Cta_cte NO-LOCK.
    FIND Cliente             OF Cta_cte NO-LOCK.
    FIND FIRST Domicilio     OF Cliente       NO-LOCK.
    FIND Provincia           OF Domicilio   NO-LOCK.
    
    que_mes = nom_mes [ MONTH(Cta_cte.fecha_emision) ].
    que_ano = STRING(YEAR(Cta_cte.fecha_emision),"9999").
    que_fecha = TRIM(que_mes) + " de " + que_ano + " .".
    
    v-saldo_total = Cta_cte.debito - Cta_cte.credito.
    v-saldo_neto  = v-saldo_total * ( Cta_cte.imp_neto / Cta_cte.imp_total ).
    v-saldo_iva   = v-saldo_total - v-saldo_neto.

    RUN toletras.p ( INPUT v-saldo_total, OUTPUT v-monto_letras ).
    RUN renglons.p ( INPUT v-monto_letras,
                     INPUT 40,
                     OUTPUT v-renglones,
                     INPUT "@").
    
    RUN imprimir_factura_credito.
    p-anduvo_bien = YES.

END.
ELSE DO:

    p-anduvo_bien = YES.

END.
/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_factura_credito:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\facredito.xpr" CONVERT TARGET "iso8859-1".

    ncopia = 1.
    RUN inicia_formulario.
    RUN factura_credito.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\facredito.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    /*
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  
    */

    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de facturas de credito><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    PUT STREAM Formulario CONTROL "<AT=140,0><#2>".    

END PROCEDURE.


PROCEDURE factura_credito:

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+17,+13><#3><AT=+8,+60><IMAGE#3=.\imagenes\logo.bmp>".

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+220,+190><FILLRECT)>". 

    RUN linea    ( INPUT "36,10", INPUT "190", "H" ).
    RUN linea    ( INPUT "64,10", INPUT "190", "H" ).
    RUN linea    ( INPUT "72,10", INPUT "190", "H" ).
    RUN linea    ( INPUT "111,10", INPUT "190", "H" ).
    RUN linea    ( INPUT "119,10", INPUT "190", "H" ).
    RUN linea    ( INPUT "139,10", INPUT "190", "H" ).

    RUN linea    ( INPUT "28,100", INPUT "111", "V" ).

    RUN escribir ( INPUT "18,75",  INPUT "FACTURA DE CREDITO", 14, YES).
 /* RUN escribir ( INPUT "19,171", INPUT "Nro:<B>" + STRING(Cta_cte.nro_comprob,"999999") + "</B>", INPUT 10, INPUT NO). */
    RUN escribir ( INPUT "19,171", INPUT "<B>Nro:________</B>", INPUT 10, INPUT NO). 

    RUN escribir ( INPUT "30,30",  INPUT "IDENTIFICACION DEL EMISOR", 10, YES).
    RUN escribir ( INPUT "30,120", INPUT "IDENTIFICACION DEL ACEPTANTE", 10, YES).

    RUN escribir ( INPUT "38,105", INPUT Cliente.nom_cliente + "  [" + Cliente.cdg_Cliente + "]", 10, YES).
    RUN escribir ( INPUT "42,105", INPUT Domicilio.direccion, 10, NO).
    RUN escribir ( INPUT "46,105", INPUT Domicilio.cdg_postal + " " + Domicilio.localidad, 10, NO).
    RUN escribir ( INPUT "50,105", INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,105", INPUT "CUIT:" + Cliente.cuit, 10, NO). 
    RUN escribir ( INPUT "58,105", INPUT "Fecha de Vencimiento:<B>" + STRING(Cta_cte.fecha_vencimiento,"99/99/9999") + "</B>", INPUT 10, INPUT NO). 

    RUN escribir ( INPUT "38,15",  INPUT Empresa.nombre, 10, YES).
    RUN escribir ( INPUT "42,15",  INPUT Empresa.direccion, 10, NO).
    RUN escribir ( INPUT "46,15",  INPUT Empresa.localidad, 10, NO).
    RUN escribir ( INPUT "50,15",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,15",  INPUT "CUIT:" + Empresa.cuit, 10, NO).

    RUN escribir ( INPUT "66,25",  INPUT "IDENTIFICACION DE LA OPERACION", 10, YES).
    RUN escribir ( INPUT "66,115", INPUT "DETERMINACION DEL IMPORTE A PAGAR", 10, YES).

    RUN escribir ( INPUT "74,15",  INPUT "Factura Nro.:" + Cta_cte.tip_comprob + " " + 
                                                           STRING(Cta_cte.prf_comprob,"9999") + " " +
                                                           STRING(Cta_cte.nro_comprob,"99999999"), 10, NO).

    RUN escribir      ( INPUT "74,105", INPUT "Importe Total de la Factura", 10, NO).
    RUN escribenumero ( INPUT "74,172", INPUT STRING(Cta_cte.debito,"->,>>>,>>9.99"), 10, NO,1.0).

    RUN escribir      ( INPUT "78,15",  INPUT "Fecha de Emisión:" + STRING(Cta_cte.fecha_emision,"99/99/9999"), INPUT 10, INPUT NO). 

    RUN escribir      ( INPUT "78,105", INPUT "Importe Previamente Cancelado", 10, NO).
    RUN escribenumero ( INPUT "78,172", INPUT STRING(Cta_cte.credito,"->,>>>,>>9.99"), 10, NO,1.0).

    RUN escribir      ( INPUT "82,15",  INPUT "C.A.I.:", INPUT 10, INPUT NO). 
    RUN escribir      ( INPUT "82,105", INPUT "Saldo Total de la Operación", 10, NO).
    RUN escribenumero ( INPUT "82,172", INPUT STRING( Cta_cte.debito - Cta_cte.credito,"->,>>>,>>9.99"), 10, NO,1.0).

    RUN escribir      ( INPUT "102,15",  INPUT "Fecha de Aceptación:____/____/____", INPUT 10, INPUT NO). 

    RUN escribir      ( INPUT "90,105", INPUT "Detracciones", 10, NO).
    RUN escribir      ( INPUT "94,105", INPUT "Retenciones", 10, NO).
    RUN escribenumero ( INPUT "94,172", INPUT STRING(0,"->,>>>,>>9.99"), 10, NO,1.0).

    RUN escribir      ( INPUT "102,105", INPUT "Importe Neto de la Operación", 10, NO).
    RUN escribenumero ( INPUT "102,172", INPUT STRING(Cta_cte.debito - Cta_cte.credito,"->,>>>,>>9.99"), 10, YES,1.0).

    RUN escribir      ( INPUT "113,30",  INPUT "IMPORTE TOTAL A PAGAR", 10, YES).
    RUN escribir      ( INPUT "113,130", INPUT "DOMICILIO DE PAGO", 10, YES).

    RUN escribir      ( INPUT "121,105", INPUT Domicilio.direccion, 10, NO).
    RUN escribir      ( INPUT "125,105", INPUT Domicilio.cdg_postal + " " + Domicilio.localidad, 10, NO).
    RUN escribir      ( INPUT "129,105", INPUT Provincia.nombre, 10, NO).

    RUN escribir      ( INPUT "121,15",  INPUT ENTRY(1,v-renglones,"@"), 10, NO).
    IF NUM-ENTRIES(v-renglones,"@") > 1
       THEN RUN escribir      ( INPUT "125,15",  INPUT ENTRY(2,v-renglones,"@"), 10, NO).
    IF NUM-ENTRIES(v-renglones,"@") > 2
       THEN RUN escribir      ( INPUT "129,15",  INPUT ENTRY(3,v-renglones,"@"), 10, NO).

    RUN escribir      ( INPUT "141,15",  INPUT "La firma por parte del comprador, locatario oprestatario tendrá " +
                                               "el efecto irrevocable de su", 12, NO).

    RUN escribir      ( INPUT "149,15",  INPUT "exactitud y el recomocimiento de la obligación de pago.", 12, NO).

    RUN escribir      ( INPUT "197,35",  INPUT "________________________", 10, NO).
    RUN escribir      ( INPUT "197,125", INPUT "________________________", 10, NO).

    RUN escribir      ( INPUT "205,40",  INPUT "Firma del Vendedor", 12, NO).
    RUN escribir      ( INPUT "205,129", INPUT "Firma del Comprador", 12, NO).

END PROCEDURE.

PROCEDURE comprobante:

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+17,+13><#3><AT=+8,+60><IMAGE#3=.\imagenes\logo.bmp>".

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+120,+190><FILLRECT)>". 
/*
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+60,+10><FROM><AT=+8,+190><RECT>".  
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+110,+10><FROM><AT=+8,+190><RECT>". 
*/
    RUN escribir ( INPUT "30,40", INPUT "IDENTIFICACION DEL EMISOR", 10, YES).
    RUN escribir ( INPUT "30,130", INPUT "IDENTIFICACION DEL ACEPTANTE", 10, YES).

    RUN linea         ( INPUT "64,10", INPUT "190", "H" ).
    RUN linea         ( INPUT "72,10", INPUT "190", "H" ).
    RUN linea         ( INPUT "28,100", INPUT "36", "V" ).
    RUN linea         ( INPUT "28,170", INPUT "8",  "V" ).

    RUN linea         ( INPUT "119,10", INPUT "190", "H" ).
    RUN linea         ( INPUT "127,10", INPUT "190", "H" ).

    RUN linea         ( INPUT "28,105", INPUT "25", "H" ).
    RUN linea         ( INPUT "36,10", INPUT "190", "H" ).

    RUN linea         ( INPUT "64,170", INPUT "63", "V" ).

/*
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+78,+170><FROM><AT=,+30><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+28,+105><FROM><AT=+25><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+38,+10><FROM><AT=,+190><LINE>". 
  
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+133,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+57><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+104><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+151><FROM><AT=+23><LINE>". 
*/

    RUN escribir ( INPUT "18,50",  INPUT "FACTURA DE CREDITO", 14, YES).
    RUN escribir ( INPUT "19,171", INPUT "Cert. Nro:<B>" + STRING(Cta_cte.nro_comprob,"999999") + "</B>", INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "30,175", INPUT STRING(Cta_cte.fecha_emision,"99/99/9999"), INPUT 10, INPUT NO). 

    RUN escribir ( INPUT "38,105",  INPUT Cliente.nom_cliente + "  [" + Cliente.cdg_Cliente + "]", 10, YES).
    RUN escribir ( INPUT "42,105",  INPUT Domicilio.direccion, 10, NO).
    RUN escribir ( INPUT "46,105",  INPUT Domicilio.cdg_postal + " " + Domicilio.localidad, 10, NO).
    RUN escribir ( INPUT "50,105",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,105",  INPUT "CUIT:" + Cliente.cuit, 10, NO). 

    RUN escribir ( INPUT "38,15",  INPUT Empresa.nombre, 10, YES).
    RUN escribir ( INPUT "42,15",  INPUT Empresa.direccion, 10, NO).
    RUN escribir ( INPUT "46,15",  INPUT Empresa.localidad, 10, NO).
    RUN escribir ( INPUT "50,15",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,15",  INPUT "CUIT:" + Empresa.cuit, 10, NO).
    RUN escribir ( INPUT "58,15",  INPUT "Factura Nro.:" + STRING(Cta_cte.nro_comprob,"999999"), 10, NO).
    /*
    RUN escribir ( INPUT "66,15",  INPUT "Resol.Gral. Nro. 2784 - DGI   Agente de Retencion Nro. (Reemp.Gral F.372) : 115.857-3", 10, NO). 
    RUN escribir ( INPUT "66,179", INPUT "Importes", 10, NO). 

    RUN escribir      ( INPUT "73,20" , INPUT "Importe del Pago", 10, NO).
    RUN escribenumero ( INPUT "73,172", INPUT STRING(Cta_cte.imp_pagado,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "77,20" , INPUT "Monto Imponible", 10, NO).
    RUN escribenumero ( INPUT "77,172", INPUT STRING(Cta_cte.base_imponible,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "81,20" , INPUT "Monto Imponible anterior acumulado en el mes           ", 10, NO).
    RUN escribenumero ( INPUT "81,172", INPUT STRING(Cta_cte.imponible_anterior,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN linea         ( INPUT "87,170", INPUT "30", "H" ).
    RUN escribir      ( INPUT "89,20" , INPUT "                           Subtotal", 10, NO).
    RUN escribenumero ( INPUT "89,172", INPUT STRING(importe_subtotal,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "94,20" , INPUT "Monto no sujeto a retencion", 10, NO).
    RUN escribenumero ( INPUT "94,172", INPUT STRING(Cta_cte.no_sujeto_a_retencion,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN linea         ( INPUT "99,170", INPUT "30", "H" ).
    RUN escribir      ( INPUT "102,20" , INPUT "Monto Imponible actual acumulado en el mes", 10, NO).
    RUN escribenumero ( INPUT "102,172", INPUT STRING(acumulado_actual,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "105,20" , INPUT "                           Alicuota %", 10, NO).
    RUN escribenumero ( INPUT "105,172", INPUT STRING(Cta_cte.alicuota,"->,>>>,>>9.99"), 10, NO,1.0). 
    RUN escribir      ( INPUT "109,20" , INPUT "Retencion total a efectuar en el mes", 10, NO).
    RUN escribenumero ( INPUT "109,172", INPUT STRING(total_retenido_del_mes,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "114,20" , INPUT "Importe anteriormente retenido", 10, NO).
    RUN escribenumero ( INPUT "114,172", INPUT STRING(Cta_cte.total_retenido_anterior,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "120,20" , INPUT "Importe retenido en este acto", 10, NO).
    RUN escribenumero ( INPUT "120,172", INPUT STRING(Cta_cte.imp_retenido,"->,>>>,>>9.99"), 10, NO,1.0).
    RUN escribir      ( INPUT "129,20" , INPUT "El importe retenido se declara en Formulario 384 correspondiente a " + que_fecha, 10, NO).

    RUN linea         ( INPUT "141,130", INPUT "65", "H" ).
    RUN escribir      ( INPUT "143,140",  INPUT "Por " + Empresa.nombre, 8, YES).
    */

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

    linea = f-ref(ncopia) + 
           '<FGCOLOR=' + 
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

    linea = f-ref(ncopia) + '<FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

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

    linea = f-ref(ncopia) + '<FGCOLOR=' + textColor + '><AT=+' + TRIM(STRING(i-linea,">>9")) + 
            ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + CenterText(TRIM(texto), s-font, f-width).
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

PROCEDURE escribenumero:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER f-width  AS DECIMAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.
    DEFINE VARIABLE r-texto         AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.
    DEFINE VARIABLE offset          AS DECIMAL.

    s-font = 'Arial,' + puntos + IF negrita THEN ',B' ELSE ''.
    offset = DECIMAL(ENTRY(2,ENTRY(1,RightJustify(TRIM(texto), s-font, f-width),">"),",")) * 12.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")) + offset.

    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            f-ref(ncopia) + '<AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '' ) + 
             texto + 
             ( IF negrita THEN '</B>' ELSE ''). 

    /*
    message linea view-as alert-box message title "plot".
    */
    
    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

/*---------------------------------------------------------------------------------------------------------------

{VRSHARED.I}
{VPERSINM.I}

DEFINE FRAME frm-factura_credito
    "Establecimientos San Ignacio S.A."
    "CONSTANCIA DE RETENCION NRO:"  TO 70
    Cta_cte.nro_certifgan AT 71
    SKIP
    "Ruta Nac. 11 Km 447 - TE (0342)4950900"
    "Fecha:" TO 70
    Cta_cte.fecha_emision       AT 71
    SKIP
    "(3017) Sauce Viejo - Pcia. de Santa Fe" 
    SKIP
    "====================================================================================="
    SKIP
    "IMPUESTO A LAS GANANCIAS"
    SKIP
    "Resol.Gral. Nro. 2784 - DGI   Agente de Retencion Nro. (Reemp.Gral F.372) : 115.857-3" 
    SKIP
    "-------------------------------------------------------------------------------------"
    SKIP
    "Contribuyente                : ["
    Cliente.cdg_Cliente
    "]"
    Cliente.nombre
    SKIP 
    "Domicilio                    :"
    Domicilio.direccion
    SKIP 
    "                             :"
    Provincia.nombre
    SKIP 
    "C.U.I.T.                     :"
    Cliente.cuit
    SKIP 
    "Concepto de la Retencion     :" Tipo_actividad.nom_tipactiv 
    SKIP 
    "Orden de Pago                :" Opg_header.nro_comprob 
    SKIP
    "====================================================================================="
    SKIP
    "Importe del Pago                                       :" Cta_cte.imp_pagado
    SKIP
    "Monto Imponible                                        :" Cta_cte.base_imponible
    SKIP
    "Monto Imponible anterior acumulado en el mes           :" Cta_cte.imponible_anterior
    SKIP
    "                                                       :  --------------------------"
    SKIP
    "                           Subtotal                    :" importe_subtotal
    SKIP
    "Monto no sujeto a retencion                            :" Cta_cte.no_sujeto_a_retencion
    SKIP
    "                                                       :  --------------------------"
    SKIP
    "Monto Imponible actual acumulado en el mes             :" acumulado_actual
    SKIP
    "                           Alicuota                    :" Cta_cte.alicuota "%"
    SKIP
    "Retencion total a efectuar en el mes                   :" total_retenido_del_mes
    SKIP
    "Importe anteriormente retenido                         :" Cta_cte.total_retenido_anterior
    SKIP
    "                                                       :  --------------------------"
    SKIP
    "Importe retenido en este acto                          :" Cta_cte.imp_retenido
    SKIP
    "====================================================================================="
    SKIP(1)
    "El importe retenido se declara en Formulario 384 correspondiente a " que_fecha
     WITH USE-TEXT STREAM-IO WIDTH 132 NO-LABEL.

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/


OUTPUT TO PRINTER PAGE-SIZE 36.

PUT CONTROL CHR(18).
PUT CONTROL "~033C$".
PUT CONTROL CHR(27) + CHR(67) + CHR(0) + CHR(36). /* Hoja de 6 pulgadas */

DISPLAY Cta_cte.nro_certifgan
        Cta_cte.fecha_emision
        Cliente.cdg_Cliente
        Cliente.nombre
        Domicilio.direccion
        Provincia.nombre
        Cliente.cuit
        Tipo_actividad.nom_tipactiv 
        Opg_header.nro_comprob 
        Cta_cte.imp_pagado
        Cta_cte.base_imponible
        Cta_cte.imponible_anterior
        importe_subtotal
        Cta_cte.no_sujeto_a_retencion
        acumulado_actual
        Cta_cte.alicuota
        total_retenido_del_mes
        Cta_cte.total_retenido_anterior
        Cta_cte.imp_retenido
        que_fecha
        WITH FRAME frm-factura_credito.

PAGE.

OUTPUT CLOSE.

Cta_cte.emitido = YES.

*/
