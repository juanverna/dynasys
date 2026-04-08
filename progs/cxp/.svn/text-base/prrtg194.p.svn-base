/*=================================================================================*/
/*                           IMPRESION DE ORDENES DE PAGO                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_certificado     AS ROWID.

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
DEFINE VARIABLE nombre_pie                AS CHARACTER FORMAT "X(25)" EXTENT 2.

DEFINE VARIABLE importe_subtotal          LIKE Certificado_gan.imp_pagado.
DEFINE VARIABLE acumulado_actual          LIKE Certificado_gan.imp_pagado.
DEFINE VARIABLE total_retenido_del_mes    LIKE Certificado_gan.imp_pagado.

DEFINE STREAM Formulario.

DEFINE QUERY qry_aplicacion FOR Opg_detalle,Cta_cte_prv.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Certificado_gan WHERE ROWID(Certificado_gan) = act_certificado EXCLUSIVE-LOCK.

FIND Empresa             OF Certificado_gan NO-LOCK.
FIND Proveedor           OF Certificado_gan NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor       NO-LOCK.
FIND Provincia           OF Domicilio_prv   NO-LOCK.
FIND Tipo_actividad      OF Certificado_gan NO-LOCK.
FIND Opg_header WHERE Opg_header.nro_transaccion = Certificado_gan.nro_transaccion NO-LOCK.

que_mes = nom_mes [ MONTH(Certificado_gan.fecha_deposito) ].
que_ano = STRING(YEAR(Certificado_gan.fecha_deposito),"9999").
que_fecha = TRIM(que_mes) + " de " + que_ano + " .".
nombre_pie [ 1 ] = "Por " + Empresa.nombre.
nombre_pie [ 2 ] = "Recibí en conformidad".

ASSIGN
    importe_subtotal        = Certificado_gan.imponible_anterior + Certificado_gan.imp_pagado
    acumulado_actual        = importe_subtotal - Certificado_gan.no_sujeto_a_retencion
    total_retenido_del_mes  = Certificado_gan.imp_retenido + 
                              Certificado_gan.total_retenido_anterior.

RUN imprimir_certificado.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_certificado:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\prrtg194.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.
    DO ncopia = 1 TO 2:
       RUN certificado.
    END.    
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\prrtg194.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    RUN getparametro_l.p ( INPUT "PRVWRGAN", OUTPUT l-preview ).
    IF l-preview
        THEN PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 

/*  PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de retenciones de ganancias><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    PUT STREAM Formulario CONTROL "<AT=140,0><#2>".    

END PROCEDURE.


PROCEDURE certificado:


    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+17,+13><#3><AT=+8,+60><IMAGE#3=..\imagenes\dyna-logo.jpg>".
    
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+124,+190><FILLRECT)>". 
/*
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+60,+10><FROM><AT=+8,+190><RECT>".  
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+110,+10><FROM><AT=+8,+190><RECT>". 
*/
    RUN escribir ( INPUT "30,40", INPUT "AGENTE DE RETENCION", 10, YES).
    RUN escribir ( INPUT "30,130", INPUT "CONTRIBUYENTE", 10, YES).

    RUN linea         ( INPUT "64,10", INPUT "190", "H" ).
    RUN linea         ( INPUT "72,10", INPUT "190", "H" ).
    RUN linea         ( INPUT "28,100", INPUT "36", "V" ).
    RUN linea         ( INPUT "28,170", INPUT "8",  "V" ).

    RUN linea         ( INPUT "123,10", INPUT "190", "H" ).
    RUN linea         ( INPUT "131,10", INPUT "190", "H" ).

    RUN linea         ( INPUT "28,105", INPUT "25", "H" ).
    RUN linea         ( INPUT "36,10", INPUT "190", "H" ).

    RUN linea         ( INPUT "64,170", INPUT "67", "V" ).

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

    RUN escribir ( INPUT "18,70",  INPUT "RETENCION DE IMPUESTO A LAS GANANCIAS", 10, YES).
    RUN escribir ( INPUT "19,171", INPUT "Cert. Nro:<B>" + STRING(Certificado_gan.nro_certifgan,"999999") + "</B>", INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "30,175", INPUT STRING(Certificado_gan.fecha_emision,"99/99/9999"), INPUT 10, INPUT NO). 

    RUN escribir ( INPUT "38,105",  INPUT Proveedor.nombre + "  [" + Proveedor.cdg_proveedor + "]", 10, YES).
    RUN escribir ( INPUT "42,105",  INPUT Domicilio_prv.direccion, 10, NO).
    RUN escribir ( INPUT "46,105",  INPUT Domicilio_prv.cdg_postal + " " + Domicilio_prv.localidad, 10, NO).
    RUN escribir ( INPUT "50,105",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,105",  INPUT "CUIT:" + Proveedor.cuit, 10, NO). 
    RUN escribir ( INPUT "58,105",  INPUT "Régimen: " + Tipo_actividad.nom_tipactiv, 10, NO). 

    RUN escribir ( INPUT "38,15",  INPUT Empresa.nombre, 10, YES).
    RUN escribir ( INPUT "42,15",  INPUT Empresa.direccion, 10, NO).
    RUN escribir ( INPUT "46,15",  INPUT "(" + Empresa.codigo_postal + ") " + Empresa.localidad, 10, NO).
    RUN escribir ( INPUT "50,15",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,15",  INPUT "CUIT:" + Empresa.cuit, 10, NO).
    RUN escribir ( INPUT "58,15",  INPUT "Orden de Pago:" + STRING(Opg_header.nro_comprob,"999999"), 10, NO).
    /*
    RUN escribir ( INPUT "66,15",  INPUT "Resol.Gral. Nro. 2784 - DGI   Agente de Retencion Nro. (Reemp.Gral F.372) : 115.857-3", 10, NO). 
    */
    RUN escribir ( INPUT "66,179", INPUT "Importes", 10, NO). 

    RUN escribir      ( INPUT "73,20" , INPUT "Importe Neto del Pago", 10, NO).
    RUN escribenumero ( INPUT "73,192", INPUT STRING(Certificado_gan.imp_pagado,"$ ->,>>>,>>9.99"), 10, NO).
    RUN escribir      ( INPUT "77,20" , INPUT "Monto Total anterior acumulado en el mes           ", 10, NO).
    RUN escribenumero ( INPUT "77,192", INPUT STRING(Certificado_gan.imponible_anterior,"$ ->,>>>,>>9.99"), 10, NO).
    RUN escribir      ( INPUT "81,20" , INPUT "Monto Total Actual", 10, NO).
    RUN escribenumero ( INPUT "81,192", INPUT STRING(importe_subtotal,"$ ->,>>>,>>9.99"), 10, NO).
    RUN linea         ( INPUT "87,170", INPUT "30", "H" ).
    RUN escribir      ( INPUT "89,20" , INPUT "                           Subtotal", 10, NO).
    RUN escribenumero ( INPUT "89,192", INPUT STRING(importe_subtotal,"$ ->,>>>,>>9.99"), 10, NO).
    RUN escribir      ( INPUT "94,20" , INPUT "Monto no sujeto a retencion (Rango inferior de la escala)", 10, NO).
    RUN escribenumero ( INPUT "94,192", INPUT STRING(Certificado_gan.no_sujeto_a_retencion,"$ ->,>>>,>>9.99"), 10, NO).
    RUN linea         ( INPUT "99,170", INPUT "30", "H" ).
    RUN escribir      ( INPUT "102,20" , INPUT "Monto Imponible actual acumulado en el mes", 10, NO).
    RUN escribenumero ( INPUT "102,192", INPUT STRING(acumulado_actual,"$ ->,>>>,>>9.99"), 10, NO).
    RUN escribir      ( INPUT "105,20" , INPUT "                           Alicuota %", 10, NO).
    RUN escribenumero ( INPUT "105,192", INPUT STRING(Certificado_gan.alicuota,"% ->,>>>,>>9.99"), 10, NO). 
    RUN escribir      ( INPUT "109,20" , INPUT "Importe Básico de Retención", 10, NO).
    RUN escribenumero ( INPUT "109,192", INPUT STRING(Certificado_gan.imp_basico,"$ ->,>>>,>>9.99"), 10, NO). 
    RUN escribir      ( INPUT "113,20" , INPUT "Retencion total a efectuar en el mes", 10, NO).
    RUN escribenumero ( INPUT "113,192", INPUT STRING(total_retenido_del_mes,"$ ->,>>>,>>9.99"), 10, NO).
    RUN escribir      ( INPUT "118,20" , INPUT "Importe anteriormente retenido", 10, NO).
    RUN escribenumero ( INPUT "118,192", INPUT STRING(Certificado_gan.total_retenido_anterior,"$ ->,>>>,>>9.99"), 10, NO).
    RUN escribir      ( INPUT "125,20" , INPUT "Importe retenido en este acto", 10, NO).
    RUN escribenumero ( INPUT "125,192", INPUT STRING(Certificado_gan.imp_retenido,"$ ->,>>>,>>9.99"), 10, YES).
    RUN escribir      ( INPUT "133,20" , INPUT "El importe retenido se declara en Formulario 384 correspondiente a " + que_fecha, 10, NO).

    RUN linea         ( INPUT "144,130", INPUT "65", "H" ).
    RUN escribir      ( INPUT "145,145", INPUT nombre_pie [ ncopia ], 8, YES).

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
    
    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.
    DEFINE VARIABLE r-texto         AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.
    
    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    
    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).

    linea = f-ref(ncopia) + '<FGCOLOR=' + textcolor + '><FArial><P' + puntos + '>' +
            '<AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             "<DECIMAL=+0>" + texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
/*
    message linea view-as alert-box message title "plot".
*/    

    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

