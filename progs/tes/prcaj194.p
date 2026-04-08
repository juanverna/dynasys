/*=================================================================================*/
/*                           IMPRESION DE COMPROBANTES DE CAJA                     */
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
DEFINE VARIABLE ntcopias                  AS INTEGER INITIAL 1.
DEFINE VARIABLE v-vigencia                AS CHARACTER.
DEFINE VARIABLE letras                    AS CHARACTER.
DEFINE VARIABLE renglones                 AS CHARACTER.
DEFINE VARIABLE monto_letras1             AS CHARACTER.
DEFINE VARIABLE monto_letras2             AS CHARACTER.

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 12.
DEFINE VARIABLE n-linea0                  AS INTEGER.
DEFINE VARIABLE n-linea                   AS INTEGER.

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

DEFINE QUERY qry_aplicacion FOR Caja-imputacion,Cuenta,Entidad,Obra.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Caj_header WHERE ROWID(Caj_header) = act_recibo EXCLUSIVE-LOCK.
FIND Caja OF Caj_header.
FIND Usuario OF Caj_header NO-LOCK NO-ERROR.

RUN toletras.p ( INPUT Caj_header.importe, OUTPUT letras ).

ASSIGN
    v-desc  = 0
    v-bruto = 0
    v-valores = 0.

RUN imprimir_orden.

RUN UnLoadXprint.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE imprimir_orden:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\prcaj194.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.
    DO ncopia = 1 TO ntcopias:
       RUN encabezado.
       RUN pie.
    END.    
    
    RUN detalle.

    DO ncopia = 1 TO ntcopias:
       RUN escribir     ( INPUT "112,15", INPUT "<B>Son Pesos:</B>" + letras, 8, NO).
       RUN escribenumero( INPUT "112,194", INPUT STRING(v-valores,"->,>>>,>>9.99"), 8, YES).
    END.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\prcaj194.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    /*
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  
    */
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de Comprobantes de Caja><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    PUT STREAM Formulario CONTROL "<AT=140,0><#2>".    

END PROCEDURE.

PROCEDURE detalle:

    /*---------------------------------------------------------------------------------*/
    /*                                      DETALLE                                    */
    /*---------------------------------------------------------------------------------*/

    OPEN QUERY qry_aplicacion
         FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion,
              FIRST Cuenta OF Caja-imputacion,
              FIRST Entidad OF Caja-imputacion,
              FIRST Obra OUTER-JOIN OF Caja-imputacion
              BY Cuenta.cdg_cuenta BY Entidad.cdg_entidad BY Obra.cdg_obra.
    
    OPEN QUERY qry_valores
         FOR EACH Caj_detalle OF Caj_header.
    
    GET FIRST qry_valores    NO-LOCK.
    GET FIRST qry_aplicacion NO-LOCK.
    
    n-linea0 = 58.
    n-linea = 0.
    DO WHILE AVAILABLE Caja-imputacion OR AVAILABLE Caj_detalle:
    
      n-linea = n-linea + 1.
      
      IF n-linea > nmax_det
      THEN DO:

            DO ncopia = 1 TO ntcopias:
               RUN escribir     ( INPUT "112,15", INPUT "Continúa en hoja " + STRING(n_hoja + 1, ">9"), 8, NO).
               RUN escribenumero( INPUT "112,194", INPUT STRING(v-valores,"->,>>>,>>9.99"), 8, YES).
            END.

            OUTPUT STREAM Formulario CLOSE.
            FILE-INFO:File-NAME = "c:\sic-temp\prcaj194.xpr".
            RUN printFile( FILE-INFO:FULL-PATHNAME).
    
            n_hoja = n_hoja + 1.
            n-linea = 1.
            
            OUTPUT STREAM Formulario TO "c:\sic-temp\prcaj194.xpr" CONVERT TARGET "iso8859-1".
            RUN inicia_formulario.
            DO ncopia = 1 TO ntcopias:
               RUN encabezado.    
               RUN pie.
            END.      
      END.

      IF AVAILABLE Caj_detalle
      THEN DO:
         v-valores = v-valores + Caj_detalle.importe.
         FIND Rubro OF Caj_detalle NO-LOCK.
         RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT dtl_rubro ).
      END.
    
      IF AVAILABLE Caja-imputacion
      THEN DO:
         v-bruto = v-bruto + Caja-imputacion.valor.
      END.
    
      chr_linea = TRIM(STRING(n-linea0 + n-linea * 4,">>9")).
    
      IF AVAILABLE Caja-imputacion
      THEN DO:
          DO ncopia = 1 TO ntcopias:
              RUN escribir ( INPUT chr_linea + ",12",  INPUT Cuenta.cdg_cuenta, 8, NO).
              RUN escribir ( INPUT chr_linea + ",25",  INPUT SUBSTRING(Cuenta.nombre_cta,1,20), 8, NO).
              RUN escribir ( INPUT chr_linea + ",65",  INPUT Entidad.cdg_entidad, 8, NO).
              RUN escribir ( INPUT chr_linea + ",75",  INPUT Obra.cdg_obra, 8, NO).
              RUN escribenumero( INPUT chr_linea + ",101", INPUT STRING(Caja-imputacion.valor,"->,>>>,>>9.99"), 8, NO).
          END.                
      END.
    
      IF AVAILABLE Caj_detalle
      THEN DO:
          DO ncopia = 1 TO ntcopias:
              RUN escribir ( INPUT chr_linea + ",108", INPUT Rubro.abrevia , 8, NO).
              RUN armar_detalle.
              RUN escribenumero( INPUT chr_linea + ",194", INPUT STRING(Caj_detalle.importe,"->,>>>,>>9.99"), 8, NO).
          END.             
      END.
    
      GET NEXT qry_valores    NO-LOCK.
      GET NEXT qry_aplicacion NO-LOCK.
    END.

END PROCEDURE.

PROCEDURE encabezado:

    /*---------------------------------------------------------------------------------*/
    /*                                    ENCABEZADO                                   */
    /*---------------------------------------------------------------------------------*/

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+120,+190><FILLRECT)>". 

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+16,+13><#3><AT=+8,+60><IMAGE#3=.\imagenes\logo.bmp>".

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+53,+10><FROM><AT=+8,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+110,+10><FROM><AT=+8,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+53,+106><FROM><AT=+57><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+61,+85><FROM><AT=+49><LINE>".  
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+61,+180><FROM><AT=+57><LINE>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+133,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+57><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+104><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+151><FROM><AT=+23><LINE>". 

    RUN escribir ( INPUT "126,27", INPUT "SOLICITO", 8, YES).
    RUN escribir ( INPUT "126,74", INPUT "PREPARO", 8, YES).
    RUN escribir ( INPUT "126,120", INPUT "AUTORIZO", 8, YES).
    RUN escribir ( INPUT "126,161", INPUT "RECIBIO CONFORME", 8, YES).

    RUN escribir ( INPUT "55,43", INPUT "IMPUTACION DE PAGO", 10, YES).
    RUN escribir ( INPUT "55,138", INPUT "VALORES ENTREGADOS", 10, YES).

    RUN escribir ( INPUT "18,80",  INPUT "COMPROBANTE DE CAJA", 14, YES).
    RUN escribir ( INPUT "30,160", INPUT "Nro:<B>" + 
                                         Caj_header.tip_comprob + " " +
                                         STRING(Caj_header.prf_comprob,"9999") + " " +
                                         STRING(Caj_header.nro_comprob,"99999999") + 
                                         "</B>", INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "30,12", INPUT "Caja:<B>" + STRING(Caja.cdg_caja,"999") + " - " + Caja.nombre + 
                                         "</B>", INPUT 10, INPUT NO). 

    a_confirmar = IF Caj_header.tipo_mov = "I" THEN "INGRESO" ELSE "EGRESO".
    RUN escribir ( INPUT "18,160", INPUT a_confirmar, 10, YES).

    RUN escribir ( INPUT "34,160", INPUT "Fecha:" + STRING(Caj_header.fecha,"99/99/9999"), INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "38,160", INPUT "Hoja:" + STRING(n_hoja,"99"), 10, NO).
/*
    RUN escribir ( INPUT "30,20",  INPUT "Proveedor:", 10, YES).
    RUN escribir ( INPUT "30,40",  INPUT Proveedor.nombre + "  [" + Proveedor.cdg_proveedor + "]", 10, YES).
    RUN escribir ( INPUT "34,40",  INPUT Domicilio_prv.direccion, 10, NO).
    RUN escribir ( INPUT "38,40",  INPUT Domicilio_prv.cdg_postal + " " + Domicilio_prv.localidad, 10, NO).
    RUN escribir ( INPUT "42,40",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "46,40",  INPUT "CUIT:" + Proveedor.cuit + " - " + Condicion_impos.texto, 10, NO). 
*/
END PROCEDURE.

PROCEDURE pie:

    /*---------------------------------------------------------------------------------*/
    /*                                       PIE                                       */
    /*---------------------------------------------------------------------------------*/

    RUN escribir( INPUT "120,15", INPUT Caj_header.observacion, 8, NO).

    /*
    RUN escribircentrado( INPUT "143,70", INPUT Usuario.nombre, 6, NO, 1.0).
    RUN escribircentrado( INPUT "143,158", INPUT "Por " + Proveedor.nombre, 6, NO, 1.0).
    */
    
END PROCEDURE.

PROCEDURE armar_detalle:

    /*=================================================================================*/
    /*         ARMA EL STRING DE DETALLE EN UN MOVIMIENTO DE TESORERIA                 */
    /*=================================================================================*/
    
    FIND Rubro OF Caj_detalle NO-ERROR.
    dtl_rubro = "".
    CASE Rubro.tipo:
       WHEN "D"
         THEN DO:
              dtl_rubro = Rubro.nombre.
         END.
       WHEN "C"
         THEN DO:
              dtl_rubro = TRIM(STRING(Caj_detalle.divisas,"->,>>>,>>9.99")) + " * " +
                          TRIM(STRING(Caj_detalle.cambio,">>,>>9.9999")).
              RUN escribir ( INPUT chr_linea + ",126", INPUT dtl_rubro, 8, NO).
         END.
       WHEN "P"
         THEN DO:
              FIND Cheque OF Caj_detalle NO-LOCK.
              FIND Cuenta_bancaria OF Cheque NO-LOCK.
              FIND Banco OF Cuenta_bancaria NO-LOCK.
              ASSIGN
                   dtl_rubro = STRING(Cheque.numero_cheque,"99999999") + "  " + Banco.abrevia.
              RUN escribir ( INPUT chr_linea + ",126", INPUT dtl_rubro, 8, NO).
              RUN escribir ( INPUT chr_linea + ",167", INPUT STRING(Cheque.fecha_emision), 8, NO).
    
         END.
       WHEN "V"
         THEN DO:
              FIND Valor OF Caj_detalle NO-LOCK.
              FIND Banco OF Valor NO-LOCK.
              ASSIGN
                   dtl_rubro = STRING(Valor.numero_cheque,"99999999") + "  " + Banco.abrevia.
              RUN escribir ( INPUT chr_linea + ",126", INPUT dtl_rubro, 8, NO).
              RUN escribir ( INPUT chr_linea + ",167", INPUT STRING(Valor.fecha_emision), 8, NO).
         END.
    
       WHEN "A" 
         THEN DO:
              FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
              ASSIGN
                   dtl_rubro = Cuenta_bancaria.cdg_cuenta_ban + " " +
                               Cuenta_bancaria.denominacion_cta.
              RUN escribir ( INPUT chr_linea + ",126", INPUT dtl_rubro, 8, NO).

         END.
    
       WHEN "B" 
         THEN DO:
              FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
              ASSIGN
                   dtl_rubro = Cuenta_bancaria.cdg_cuenta_ban + " " +
                               Cuenta_bancaria.denominacion_cta.
              RUN escribir ( INPUT chr_linea + ",126", INPUT dtl_rubro, 8, NO).
         END.
    
    
       WHEN "R"
         THEN DO:
              dtl_rubro = Caj_detalle.observacion.
              RUN escribir ( INPUT chr_linea + ",126", INPUT dtl_rubro, 8, NO).
         END.
    
    END CASE.

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

    linea = '<FGCOLOR=' + textcolor + '><FArial><P' + puntos + '>' +
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



