/*=================================================================================*/
/*                           IMPRESION DE ORDENES DE PAGO                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

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
DEFINE VARIABLE v-vigencia                AS CHARACTER.
DEFINE VARIABLE letras                    AS CHARACTER.
DEFINE VARIABLE renglones                 AS CHARACTER.
DEFINE VARIABLE monto_letras1             AS CHARACTER.
DEFINE VARIABLE monto_letras2             AS CHARACTER.

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 12.
DEFINE VARIABLE linea0                    AS INTEGER.
DEFINE VARIABLE chr_linea                 AS CHARACTER.
DEFINE VARIABLE dtl_rubro                 AS CHARACTER.
DEFINE VARIABLE a_confirmar               AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-aplicacion              AS CHARACTER FORMAT "X(20)".

DEFINE VARIABLE n_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE t_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE ancho                     AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE v-bruto                   LIKE Opg_header.imp_neto.
DEFINE VARIABLE v-desc                    LIKE Opg_header.imp_neto.
DEFINE VARIABLE v-valores                 LIKE Opg_header.imp_neto.

DEFINE STREAM Formulario.

DEFINE QUERY qry_aplicacion FOR Opg_detalle,Cta_cte_prv.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<#" + STRING(n,"9") + ">".

END.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Opg_header WHERE ROWID(Opg_header) = act_recibo EXCLUSIVE-LOCK.
FIND Condicion_impos   OF Opg_header NO-LOCK.
FIND Proveedor OF Opg_header NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
FIND Provincia OF Domicilio_prv NO-LOCK.
FIND Usuario OF Opg_header NO-LOCK.

RUN toletras.p ( INPUT Opg_header.imp_total, OUTPUT letras ).

ASSIGN
    v-desc  = 0
    v-bruto = 0
    v-valores = 0.

RUN imprimir_orden.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_orden:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "./prl/propg193.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.

    DO ncopia = 1 TO 2:
       RUN encabezado.
       RUN pie.
    END.    
    
    RUN detalle.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "./prl/propg193.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de órdenes de pago><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    PUT STREAM Formulario CONTROL "<AT=140,0><#2>".    

END PROCEDURE.

PROCEDURE detalle:

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

FIND Caj_header
     WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.

OPEN QUERY qry_aplicacion
     FOR EACH Opg_detalle OF Opg_header,
          FIRST Cta_cte_prv WHERE Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                              AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                              AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela
                              AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                              AND Cta_cte_prv.nro_proveedor   = Proveedor.nro_proveedor.

OPEN QUERY qry_valores
     FOR EACH Caj_detalle OF Caj_header.

GET FIRST qry_valores    NO-LOCK.
GET FIRST qry_aplicacion NO-LOCK.

linea0 = 0.
DO WHILE AVAILABLE Opg_detalle OR AVAILABLE Caj_detalle:

  IF AVAILABLE Caj_detalle
  THEN DO:
     v-valores = v-valores + Caj_detalle.importe.
     FIND Rubro OF Caj_detalle NO-LOCK.
     RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT dtl_rubro ).
  END.

  IF AVAILABLE Opg_detalle
  THEN DO:
     v-bruto = v-bruto + Opg_detalle.importe.
     v-desc  = v-desc  + Opg_detalle.descuento.
  END.

  chr_linea = TRIM(STRING(63 + linea0 * 4,">>9")).

  IF AVAILABLE Opg_detalle
  THEN DO:
  
        v-aplicacion = Cta_cte_prv.tip_comprob + " " + 
                       STRING(Cta_cte_prv.prf_comprob,"9999") + " " +
                       STRING(Cta_cte_prv.nro_comprob,"99999999") + "   " +
                       STRING(Cta_cte_prv.fecha_vencimiento,"99/99/99").
        RUN escribir ( INPUT chr_linea + ",15",  INPUT v-aplicacion, 8, NO).
  
        RUN escribenumero( INPUT chr_linea + ",68", INPUT STRING(Opg_detalle.importe,"->,>>>,>>9.99"), 8, NO).
                     
  END.

  IF AVAILABLE Caj_detalle
  THEN DO:

        RUN escribir ( INPUT chr_linea + ",93", INPUT Rubro.abrevia , 8, NO).
        RUN escribir ( INPUT chr_linea + ",107", INPUT dtl_rubro, 8, NO).
        RUN escribenumero( INPUT chr_linea + ",176", INPUT STRING(Caj_detalle.importe,"->,>>>,>>9.99"), 8, NO).
                     
  END.

  IF linea0 = nmax_det
  THEN DO:
        RUN pie.
        OUTPUT STREAM Formulario CLOSE.
        FILE-INFO:File-NAME = "./prl/propg193.xpr".
        RUN printFile( FILE-INFO:FULL-PATHNAME).

        n_hoja = n_hoja + 1.
        OUTPUT STREAM Formulario TO "./prl/propg193.xpr" CONVERT TARGET "iso8859-1".
        RUN inicia_formulario.
        RUN encabezado.    

  END.
  
  GET NEXT qry_valores    NO-LOCK.
  GET NEXT qry_aplicacion NO-LOCK.
  linea0 = linea0 + 1.
END.

END PROCEDURE.

PROCEDURE pie:

    /*---------------------------------------------------------------------------------*/
    /*                                       PIE                                       */
    /*---------------------------------------------------------------------------------*/

    RUN escribir     ( INPUT "112,15", INPUT "<B>Son Pesos:</B>" + letras, 8, NO).
    RUN escribenumero( INPUT "112,176", INPUT STRING(Caj_header.importe,"->,>>>,>>9.99"), 8, YES).
    
    
    RUN escribir( INPUT "120,15", INPUT Opg_header.leyenda, 8, NO).
    RUN escribir( INPUT "143,70", INPUT Usuario.nombre, 8, YES).
    RUN escribir( INPUT "143,164", INPUT "Por " + Proveedor.nombre, 8, YES).

END PROCEDURE.

PROCEDURE encabezado:

    /*---------------------------------------------------------------------------------*/
    /*                                    ENCABEZADO                                   */
    /*---------------------------------------------------------------------------------*/

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+120,+190><FILLRECT)>". 

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+16,+13><#2><AT=+10,+10><IMAGE#2=c:\desa\sic\xprint\cliparts\trigger1.jpg>".

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+53,+10><FROM><AT=+8,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+110,+10><FROM><AT=+8,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+53,+91><FROM><AT=+57><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+61,+70><FROM><AT=+49><LINE>".  
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+61,+180><FROM><AT=+57><LINE>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+133,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+57><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+104><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+151><FROM><AT=+23><LINE>". 

    RUN escribir ( INPUT "127,27", INPUT "SOLICITO", 8, YES).
    RUN escribir ( INPUT "127,74", INPUT "PREPARO", 8, YES).
    RUN escribir ( INPUT "127,120", INPUT "AUTORIZO", 8, YES).
    RUN escribir ( INPUT "127,169", INPUT "RECIBIO", 8, YES).

    RUN escribir ( INPUT "55,30", INPUT "APLICACION DE PAGO", 10, YES).
    RUN escribir ( INPUT "55,125", INPUT "VALORES ENTREGADOS", 10, YES).

    RUN escribir ( INPUT "18,80",  INPUT "ORDEN DE PAGO", 14, YES).
    RUN escribir ( INPUT "30,165", INPUT "Nro:<B>" + STRING(Opg_header.nro_comprob,"999999") + "</B>", INPUT 10, INPUT NO). 
    IF Opg_header.estado = "E" THEN a_confirmar = "A CONFIRMAR".
                               ELSE a_confirmar = "".
    RUN escribir ( INPUT "18,165", INPUT a_confirmar, 10, YES).

    RUN escribir ( INPUT "34,165", INPUT "Fecha:" + STRING(Opg_header.fecha,"99/99/9999"), INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "38,165", INPUT "Hoja:" + STRING(n_hoja,"99"), 10, NO).

    RUN escribir ( INPUT "30,20",  INPUT "Proveedor:", 10, YES).
    RUN escribir ( INPUT "30,40",  INPUT Proveedor.nombre + "  [" + Proveedor.cdg_proveedor + "]", 10, YES).
    RUN escribir ( INPUT "34,40",  INPUT Domicilio_prv.direccion, 10, NO).
    RUN escribir ( INPUT "38,40",  INPUT Domicilio_prv.cdg_postal + " " + Domicilio_prv.localidad, 10, NO).
    RUN escribir ( INPUT "42,40",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "46,40",  INPUT "CUIT:" + Proveedor.cuit + " - " + Condicion_impos.texto, 10, NO). 

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
    /*
    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
    */
    linea = '<FGCOLOR=BLACK' + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
            TRIM(STRING(i-columna,">>9.999999")) + '>' +
            ( IF negrita THEN '<B>' ELSE '')  + 
            "<DECIMAL=+0>" + texto + 
            ( IF negrita THEN '</B>' ELSE '' ). 

/*
    message linea view-as alert-box message title "plot".
*/    
    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.

