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
DEFINE VARIABLE linea0                    AS INTEGER.
DEFINE VARIABLE ch_linea                  AS CHARACTER.
DEFINE VARIABLE nombre_pie                AS CHARACTER FORMAT "X(25)" EXTENT 2.

DEFINE VARIABLE que_fecha                 AS CHARACTER FORMAT "X(25)".
DEFINE VARIABLE que_mes                   AS CHARACTER FORMAT "X(15)".
DEFINE VARIABLE que_ano                   AS CHARACTER FORMAT "X(4)".

DEFINE STREAM Formulario.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Certificado_sus WHERE ROWID(Certificado_sus) = act_certificado EXCLUSIVE-LOCK.

FIND Empresa             OF Certificado_sus NO-LOCK.
FIND Proveedor           OF Certificado_sus NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor       NO-LOCK.
FIND Provincia           OF Domicilio_prv   NO-LOCK.
FIND Tipo_retsus         OF Certificado_sus NO-LOCK. 

FIND Opg_header WHERE Opg_header.nro_transaccion = Certificado_sus.nro_transaccion NO-LOCK.

que_mes = nom_mes [ MONTH(Certificado_sus.fecha_deposito) ].
que_ano = STRING(YEAR(Certificado_sus.fecha_deposito),"9999").
que_fecha = TRIM(que_mes) + " de " + que_ano + " .".
nombre_pie [ 1 ] = "Por " + Empresa.nombre.
nombre_pie [ 2 ] = "Recibí en conformidad".

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

    RUN getparametro_l.p ( INPUT "PRVWRIBR", OUTPUT l-preview ).
    IF l-preview
        THEN PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 

  /*PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de retenciones de Ingresos Brutos><UNITS=mm><|2>".
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

    RUN linea         ( INPUT "64,73", INPUT "67", "V" ).
    RUN linea         ( INPUT "64,100", INPUT "67", "V" ).
    RUN linea         ( INPUT "64,148", INPUT "67", "V" ).
    RUN linea         ( INPUT "64,170", INPUT "67", "V" ).

    RUN escribir ( INPUT "66,15", INPUT "Documento", 10, NO). 
    RUN escribir ( INPUT "66,80", INPUT "Fecha", 10, NO). 
    RUN escribir ( INPUT "66,115", INPUT "Base Imponible", 10, NO). 
    RUN escribir ( INPUT "66,153", INPUT "Alicuota", 10, NO). 
    RUN escribir ( INPUT "66,172", INPUT "Total Retenido", 10, NO). 

    RUN escribir ( INPUT "18,70",  INPUT "RETENCION DE IMPUESTO SUSS", 10, YES).
    RUN escribir ( INPUT "19,171", INPUT "Cert. Nro:<B>" + STRING(Certificado_sus.nro_certifsus,"999999") + "</B>", INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "30,175", INPUT STRING(Certificado_sus.fecha_emision,"99/99/9999"), INPUT 10, INPUT NO). 

    RUN escribir ( INPUT "38,105",  INPUT Proveedor.nombre + "  [" + Proveedor.cdg_proveedor + "]", 10, YES).
    RUN escribir ( INPUT "42,105",  INPUT Domicilio_prv.direccion, 10, NO).
    RUN escribir ( INPUT "46,105",  INPUT Domicilio_prv.cdg_postal + " " + Domicilio_prv.localidad, 10, NO).
    RUN escribir ( INPUT "50,105",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,105",  INPUT "CUIT:" + Proveedor.cuit, 10, NO). 
    RUN escribir ( INPUT "58,105",  INPUT "Régimen:" + Tipo_retsus.nom_retsus, 10, NO). 
    /*RUN escribir ( INPUT "58,105",  INPUT "Régimen: " + Tipo_actividad.nom_tipactiv, 10, NO). */

    RUN escribir ( INPUT "38,15",  INPUT Empresa.nombre, 10, YES).
    RUN escribir ( INPUT "42,15",  INPUT Empresa.direccion, 10, NO).
    RUN escribir ( INPUT "46,15",  INPUT "(" + Empresa.codigo_postal + ") " + Empresa.localidad, 10, NO).
    RUN escribir ( INPUT "50,15",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "54,15",  INPUT "CUIT:" + Empresa.cuit, 10, NO).
    RUN escribir ( INPUT "58,15",  INPUT "Orden de Pago:" + STRING(Opg_header.nro_comprob,"999999"), 10, NO).
    /*
    RUN escribir ( INPUT "66,15",  INPUT "Resol.Gral. Nro. 2784 - DGI   Agente de Retencion Nro. (Reemp.Gral F.372) : 115.857-3", 10, NO). 
    */
    
    linea0 = 73.
    FOR EACH Cert_sus-detalle OF Certificado_sus NO-LOCK:

        FIND FIRST Cta_cte_prv 
             WHERE Cta_cte_prv.cdg_empresa      = Certificado_sus.cdg_empresa
               AND Cta_cte_prv.nro_comprob      = Cert_sus-detalle.nro_comprob 
               AND Cta_cte_prv.prf_comprob      = Cert_sus-detalle.prf_comprob 
               AND Cta_cte_prv.tip_comprob      = Cert_sus-detalle.tip_comprob
               AND Cta_cte_prv.nro_vencimiento  = Cert_sus-detalle.nro_vencimiento
               AND Cta_cte_prv.nro_proveedor    = Proveedor.nro_proveedor NO-LOCK.

        ch_linea = STRING(linea0,">>9").  

        RUN escribir      ( INPUT ch_linea  + ",20" , INPUT Cert_sus-detalle.tip_comprob + " " + 
                                                      STRING(Cert_sus-detalle.prf_comprob,"9999") + " " +
                                                      STRING(Cert_sus-detalle.nro_comprob,"99999999"), 10, NO).
        RUN escribir      ( INPUT ch_linea  + ",80" , INPUT STRING(Cta_cte_prv.fecha_emision,"99/99/99"), 10, NO).
        RUN escribenumero ( INPUT ch_linea  + ",140", INPUT STRING(Cert_sus-detalle.base_imponible,"->,>>>,>>9.99"), 10, NO).
        RUN escribenumero ( INPUT ch_linea  + ",162", INPUT STRING(Cert_sus-detalle.alicuota,"% ->,>>>,>>9.99"), 10, NO).
        RUN escribenumero ( INPUT ch_linea  + ",192", INPUT STRING(Cert_sus-detalle.imp_retenido,"Z,ZZZ,ZZ9.99-"), 10, NO).

        linea0 = linea0 + 4.

    END.

    RUN escribenumero ( INPUT "125,192", INPUT STRING(Certificado_sus.imp_retenido,"->,>>>,>>9.99"), 10, YES).

    RUN linea         ( INPUT "145,130", INPUT "65", "H" ).
    RUN escribir      ( INPUT "146,137",  INPUT nombre_pie [ ncopia ], 8, YES).

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

