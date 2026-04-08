/*=================================================================================*/
/*                           IMPRESION DE RECIBOS A                                */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{nommeses.i}
{xprint.i}
{valoresrecibo.I}

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

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 24.
DEFINE VARIABLE n-linea0                  AS INTEGER.
DEFINE VARIABLE n-linea                   AS INTEGER.
DEFINE VARIABLE nt-copias                 AS INTEGER INITIAL 2.

DEFINE VARIABLE chr_linea                 AS CHARACTER.
DEFINE VARIABLE dtl_rubro                 AS CHARACTER.
DEFINE VARIABLE a_confirmar               AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-aplicacion              AS CHARACTER FORMAT "X(20)".

DEFINE VARIABLE n_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE t_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE ancho                     AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE v-bruto                   LIKE Rec_header.imp_neto.
DEFINE VARIABLE v-desc                    LIKE Rec_header.imp_neto.
DEFINE VARIABLE v-valores                 LIKE Rec_header.imp_neto.

DEFINE STREAM Formulario.

DEFINE QUERY qry_aplicacion FOR Rec_detalle,Cta_cte.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Rec_header WHERE ROWID(Rec_header) = act_recibo EXCLUSIVE-LOCK.
FIND Condicion_impos   OF Rec_header NO-LOCK.
FIND Cliente OF Rec_header NO-LOCK.
FIND FIRST Domicilio OF Cliente NO-LOCK.
FIND Provincia OF Domicilio NO-LOCK.
FIND Usuario OF Rec_header NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion NO-LOCK.

RUN toletras.p ( INPUT Rec_header.imp_total, OUTPUT letras ).

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
    OUTPUT STREAM Formulario TO "c:\sic-temp\prrescta.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.
    DO ncopia = 1 TO nt-copias:
       RUN encabezado.
       RUN pie.
    END.    
    
    RUN detalle.

    DO ncopia = 1 TO nt-copias:
       
       RUN escribir     ( INPUT "118,15", INPUT "<B>TOTAL A PAGAR:</B>", 8, NO).
       RUN escribenumero( INPUT "118,53", INPUT STRING(Caj_header.importe,"->,>>>,>>9.99"), 8, YES, 1.0).
       RUN escribir     ( INPUT "118,152", INPUT "<B>TOTAL ABONADO:</B>", 8, NO).
    END.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\prrescta.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
    /*
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  
    */
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de recibos de pago><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    
    PUT STREAM Formulario CONTROL "<AT=140,0><#2>".    
    

END PROCEDURE.

PROCEDURE detalle:

    /*---------------------------------------------------------------------------------*/
    /*                                      DETALLE                                    */
    /*---------------------------------------------------------------------------------*/

    OPEN QUERY qry_aplicacion
         FOR EACH Rec_detalle OF Rec_header,
              FIRST Cta_cte WHERE Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                              AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                              AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                              AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento
                              AND Cta_cte.nro_cliente   = Cliente.nro_cliente.
    
    OPEN QUERY qry_valores
         FOR EACH Caj_detalle OF Caj_header.
    
    GET FIRST qry_valores    NO-LOCK.
    GET FIRST qry_aplicacion NO-LOCK.
    
    n-linea0 = 51.
    n-linea = 0.
    DO WHILE AVAILABLE Rec_detalle OR AVAILABLE Caj_detalle:
    
      n-linea = n-linea + 1.
      
      IF n-linea > nmax_det
      THEN DO:

            DO ncopia = 1 TO nt-copias:
               RUN escribir     ( INPUT "112,15", INPUT "Continúa en hoja " + STRING(n_hoja + 1, ">9"), 8, NO).
               RUN escribenumero( INPUT "112,176", INPUT STRING(v-valores,"->,>>>,>>9.99"), 8, YES, 1.0).
            END.

            OUTPUT STREAM Formulario CLOSE.
            FILE-INFO:File-NAME = "c:\sic-temp\prrescta.xpr".
            RUN printFile( FILE-INFO:FULL-PATHNAME).
    
            n_hoja = n_hoja + 1.
            n-linea = 1.
            
            OUTPUT STREAM Formulario TO "c:\sic-temp\prrescta.xpr" CONVERT TARGET "iso8859-1".
            RUN inicia_formulario.
            DO ncopia = 1 TO nt-copias:
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
    
      IF AVAILABLE Rec_detalle
      THEN DO:
         v-bruto = v-bruto + Rec_detalle.importe.
         v-desc  = v-desc  + Rec_detalle.descuento.
      END.
    
      chr_linea = TRIM(STRING(n-linea0 + n-linea * 4,">>9")).
    
      IF AVAILABLE Rec_detalle
      THEN DO:
      
            v-aplicacion = Cta_cte.tip_comprob + " " + 
                           STRING(Cta_cte.prf_comprob,"9999") + " " +
                           STRING(Cta_cte.nro_comprob,"99999999") + "   " +
                           STRING(Cta_cte.fecha_vencimiento,"99/99/99").
            DO ncopia = 1 TO nt-copias:
               RUN escribir ( INPUT chr_linea + ",15",  INPUT v-aplicacion, 8, NO).
               RUN escribenumero( INPUT chr_linea + ",53", INPUT STRING(Rec_detalle.importe,"->,>>>,>>9.99"), 8, NO, 1.0).
            END.                
      END.
    
      IF AVAILABLE Caj_detalle
      THEN DO:
            DO ncopia = 1 TO nt-copias:
               RUN escribir ( INPUT chr_linea + ",78", INPUT Rubro.abrevia , 8, NO).
               RUN armar_detalle.
               RUN escribenumero( INPUT chr_linea + ",176", INPUT STRING(Caj_detalle.importe,"->,>>>,>>9.99"), 8, NO, 1.0).
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

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+116,+190><FILLRECT)>". 

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+17,+13><#8><AT=+8,+60><IMAGE#8=.\imagenes\logo.bmp>".

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+47,+10><FROM><AT=+7,+190><RECT>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+116,+10><FROM><AT=+6,+190><RECT>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+47,+76><FROM><AT=+75><LINE>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+54,+55><FROM><AT=+62><LINE>".  
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+47,+180><FROM><AT=+75><LINE>". 
/*    
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+133,+10><FROM><AT=,+190><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+57><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+104><FROM><AT=+23><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+125,+151><FROM><AT=+23><LINE>". 

    RUN escribir ( INPUT "127,27", INPUT "SOLICITO", 8, YES).
    RUN escribir ( INPUT "127,74", INPUT "PREPARO", 8, YES).
    RUN escribir ( INPUT "127,120", INPUT "AUTORIZO", 8, YES).
    RUN escribir ( INPUT "127,161", INPUT "EN CONFORMIDAD", 8, YES).
*/
    RUN escribir ( INPUT "48,23", INPUT "APLICACION DE PAGO", 10, YES).
    RUN escribir ( INPUT "48,118", INPUT "VALORES RECIBIDOS", 10, YES).

    RUN escribir ( INPUT "18,80",  INPUT "RECIBO DE PAGO", 14, YES).
    RUN escribir ( INPUT "18,160", INPUT "Nro:<B>" + Rec_header.tip_comprob + " " +
                                                     STRING(Rec_header.prf_comprob,"9999") + " " +
                                                     STRING(Rec_header.nro_comprob,"99999999") + "</B>", INPUT 10, INPUT NO). 
    IF Rec_header.estado <> rec_recibo_en_firme THEN a_confirmar = "A CONFIRMAR".
                                                ELSE a_confirmar = "".
    RUN escribir ( INPUT "18,160", INPUT a_confirmar, 10, YES).

    RUN escribir ( INPUT "38,160", INPUT "Fecha:" + STRING(Rec_header.fecha,"99/99/9999"), INPUT 10, INPUT NO). 
    RUN escribir ( INPUT "42,160", INPUT "Hoja:" + STRING(n_hoja,"99"), 10, NO).

    RUN escribir ( INPUT "30,20",  INPUT "Cliente:", 10, YES).
    RUN escribir ( INPUT "30,40",  INPUT Cliente.nom_cliente + "  [" + Cliente.cdg_cliente + "]", 10, YES).
    RUN escribir ( INPUT "34,40",  INPUT Domicilio.direccion, 10, NO).
    RUN escribir ( INPUT "38,40",  INPUT Domicilio.cdg_postal + " " + Domicilio.localidad, 10, NO).
    RUN escribir ( INPUT "42,40",  INPUT Provincia.nombre, 10, NO).
    RUN escribir ( INPUT "30,160",  INPUT "CUIT:" + Cliente.cuit, 10, NO). 
    RUN escribir ( INPUT "34,160",  INPUT Condicion_impos.texto, 10, NO). 

    DEFINE VARIABLE xrec AS CHARACTER.
    xrec = Rec_header.tip_comprob + " " +
           STRING(Rec_header.prf_comprob,"9999") + " " +
           STRING(Rec_header.nro_comprob,"99999999").
    RUN escribarra ( INPUT "132,18" , INPUT xrec , INPUT 8, INPUT no).


END PROCEDURE.

PROCEDURE pie:

    /*---------------------------------------------------------------------------------*/
    /*                                       PIE                                       */
    /*---------------------------------------------------------------------------------*/
/*
    RUN escribir( INPUT "120,15", INPUT Rec_header.leyenda, 8, NO).
    RUN escribircentrado( INPUT "143,70", INPUT Usuario.nombre, 7, NO, 1.0).
    RUN escribircentrado( INPUT "143,158", INPUT "Por " + Cliente.nom_cliente, 7, NO, 1.0).
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
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).
         END.
       WHEN "P"
         THEN DO:
              FIND Cheque OF Caj_detalle NO-LOCK.
              FIND Cuenta_bancaria OF Cheque NO-LOCK.
              FIND Banco OF Cuenta_bancaria NO-LOCK.
              ASSIGN
                   dtl_rubro = STRING(Cheque.numero_cheque,"99999999") + "  " + Banco.nombre.
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).
              RUN escribir ( INPUT chr_linea + ",167", INPUT STRING(Cheque.fecha_emision), 8, NO).
    
         END.
       WHEN "V"
         THEN DO:
              FIND Valor OF Caj_detalle NO-LOCK.
              FIND Banco OF Valor NO-LOCK.
              ASSIGN
                   dtl_rubro = STRING(Valor.numero_cheque,"99999999") + "  " + Banco.nombre.
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).
              RUN escribir ( INPUT chr_linea + ",167", INPUT STRING(Valor.fecha_emision), 8, NO).
         END.
    
       WHEN "A" 
         THEN DO:
              FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
              ASSIGN
                   dtl_rubro = Cuenta_bancaria.cdg_cuenta_ban + " " +
                               Cuenta_bancaria.denominacion_cta.
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).

         END.
    
       WHEN "B" 
         THEN DO:
              FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
              ASSIGN
                   dtl_rubro = Cuenta_bancaria.cdg_cuenta_ban + " " +
                               Cuenta_bancaria.denominacion_cta.
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).
         END.
    
    
       WHEN "R"
         THEN DO:
              dtl_rubro = Caj_detalle.observacion.
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).
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

PROCEDURE escribarra:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) "<AT=+129,130><#5>".
    PUT STREAM Formulario UNFORMATTED "<=#5><AT=+7,+55><#6>".
    PUT STREAM Formulario UNFORMATTED "<FROM><BARCODE#5,TYPE=128A,CHECKSUM=TRUE,VALUE=" texto ">".

END PROCEDURE.
