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

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 50.
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

DEFINE QUERY qry_aplicacion FOR Opg_detalle,Cta_cte_prv.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).
   RETURN "<=#" + STRING(n,"9") + ">".
END FUNCTION.

ncopia =1.

/*=========================================================================================*/
/*                              B L O Q U E   P R I N C I P A L                            */
/*=========================================================================================*/

RUN LoadXprint.

FIND Opg_header WHERE ROWID(Opg_header) = act_recibo EXCLUSIVE-LOCK.
FIND Condicion_impos   OF Opg_header NO-LOCK.
FIND Proveedor OF Opg_header NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
FIND Provincia OF Domicilio_prv NO-LOCK.
FIND Usuario OF Opg_header NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = 
Opg_header.nro_transaccion NO-LOCK.

RUN toletras.p ( INPUT Opg_header.imp_total, OUTPUT letras ).

ASSIGN
    v-desc  = 0
    v-bruto = 0
    v-valores = 0.

RUN imprimir_orden.

RUN UnLoadXprint.

/*=================================================================================*/
/*                                PROCEDIMIENTOS                             
       */
/*=================================================================================*/

PROCEDURE imprimir_orden:

    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* Para el comando AT, para que no ponga "," */
    OUTPUT STREAM Formulario TO "c:\sic-temp\propg194.xpr" CONVERT TARGET   "iso8859-1".

    RUN inicia_formulario.
    RUN encabezado.
    RUN pie.
    RUN detalle.
    RUN escribir     ( INPUT "230,15", INPUT "<B>Son Pesos:</B>" + letras, 8, NO).     /*valores originales 112*/
    RUN escribenumero( INPUT "230,195", INPUT STRING(v-valores,"->,>>>,>>9.99"), 8, YES).

    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\propg194.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
    RUN printFile( FILE-INFO:FULL-PATHNAME).

END PROCEDURE.

PROCEDURE inicia_formulario:

    
    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.  /*70*/
    /*
    PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.
    */
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de órdenes de pago><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".
    PUT STREAM Formulario CONTROL "<AT=140,0><#2>".

END PROCEDURE.

PROCEDURE detalle:

    
/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

    OPEN QUERY qry_aplicacion
         FOR EACH Opg_detalle OF Opg_header,
              FIRST Cta_cte_prv WHERE Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
                                  AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
                                  AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela
                                  AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                                  AND Cta_cte_prv.nro_proveedor   = Proveedor.nro_proveedor.

    OPEN QUERY qry_valores
         FOR EACH Caj_detalle OF Caj_header.

    GET FIRST qry_valores    NO-LOCK.
    GET FIRST qry_aplicacion NO-LOCK.

    n-linea0 = 58.
    n-linea = 0.
    DO WHILE AVAILABLE Opg_detalle OR AVAILABLE Caj_detalle:

      n-linea = n-linea + 1.

      IF n-linea > nmax_det
      THEN DO:
          RUN escribir     ( INPUT "130,15", INPUT "Continúa en hoja " + STRING(n_hoja + 1, ">9"), 8, NO).
          RUN escribenumero( INPUT "130,185", INPUT STRING(v-valores,"->,>>>,>>9.99"), 8, YES).
          OUTPUT STREAM Formulario CLOSE.
          FILE-INFO:FILE-NAME = "c:\sic-temp\propg194.xpr".
          RUN printFile(FILE-INFO:FULL-PATHNAME).

          n_hoja = n_hoja + 1.
          n-linea = 1.

          OUTPUT STREAM Formulario TO "c:\sic-temp\propg194.xpr" CONVERT TARGET "iso8859-1".
          RUN inicia_formulario.
          RUN encabezado.
          RUN pie.
      END.

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

      chr_linea = TRIM(STRING(n-linea0 + n-linea * 4,">>9")).

      IF AVAILABLE Opg_detalle
      THEN DO:

            v-aplicacion = Cta_cte_prv.tip_comprob + " " +
                           STRING(Cta_cte_prv.prf_comprob,"9999") + " " +
                           STRING(Cta_cte_prv.nro_comprob,"99999999") + "   " +
                           STRING(Cta_cte_prv.fecha_vencimiento,"99/99/99").
            RUN escribir ( INPUT chr_linea + ",15",  INPUT v-aplicacion, 8,NO).
            RUN escribenumero( INPUT chr_linea + ",71", INPUT STRING(Opg_detalle.importe,"->,>>>,>>9.99"), 8, NO).

      END.

      IF AVAILABLE Caj_detalle
      THEN DO:
          RUN escribir ( INPUT chr_linea + ",78", INPUT Rubro.abrevia , 8, NO).
          RUN armar_detalle.
          RUN escribenumero( INPUT chr_linea + ",195", INPUT STRING(Caj_detalle.importe,"->,>>>,>>9.99"), 8, NO).
      END.

      GET NEXT qry_valores    NO-LOCK.
      GET NEXT qry_aplicacion NO-LOCK.
    END.

END PROCEDURE.

PROCEDURE encabezado:

    
/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+237,+190><FILLRECT)>". /*los valores originales son +28,+10 y +120,+190*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><FILLRECT)>". /*los valores  originales son +15,+10 y +12,+190*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+17,+13><#3><AT=+8,+60><IMAGE#3=.\imagenes\dynasys.bmp>".

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+53,+10><FROM><AT=+8,+190><RECT>".  /*los valores originales son +53,+10 y +8,+190*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+229,+10><FROM><AT=+8,+190><RECT>".   /*los valores originales son +110,+10 y +8,+190*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+53,+76><FROM><AT=+176><LINE>". /*53,76   57*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+61,+55><FROM><AT=+168><LINE>".  /*61*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+61,+180><FROM><AT=+168><LINE>". /*61*/

    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+250,+10><FROM><AT=,+190><LINE>". /*todas son 125*/
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+242,+10><FROM><AT=,+190><LINE>".
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+242,+57><FROM><AT=+23><LINE>".
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+242,+104><FROM><AT=+23><LINE>".
    PUT STREAM Formulario UNFORMATTED f-ref(ncopia) + "<AT=+242,+151><FROM><AT=+23><LINE>".

    RUN escribir ( INPUT "226,27", INPUT "ASIENTO MFG", 8, YES).
    RUN escribir ( INPUT "226,74", INPUT "PREPARO", 8, YES).
    RUN escribir ( INPUT "226,120", INPUT "AUTORIZO", 8, YES).
    RUN escribir ( INPUT "226,161", INPUT "RECIBIO CONFORME", 8, YES).

    RUN escribir ( INPUT "55,23", INPUT "APLICACION DE PAGO", 10, YES).
    RUN escribir ( INPUT "55,118", INPUT "VALORES ENTREGADOS", 10, YES).

    RUN escribir ( INPUT "18,80",  INPUT "ORDEN DE PAGO", 14, YES).
    RUN escribir ( INPUT "30,165", INPUT "Nro:<B>" +  STRING(Opg_header.nro_comprob,"999999") + "</B>", INPUT 10, INPUT NO).
    IF Opg_header.estado <> "E" THEN a_confirmar = "A CONFIRMAR".
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

PROCEDURE pie:

    
/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

     RUN escribir( INPUT "250,15", INPUT Opg_header.leyenda, 8, NO).
     RUN escribircentrado( INPUT "262,70", INPUT Usuario.nro_usuario, 7, NO, 10.0). /*143,70 */
     RUN escribircentrado( INPUT "262,158", INPUT "Por " + Proveedor.nombre, 7, NO, 10.0).

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
              dtl_rubro = STRING(Cheque.numero_cheque,"99999999") + "  " + Banco.nombre.
              RUN escribir ( INPUT chr_linea + ",92", INPUT dtl_rubro, 8, NO).
              RUN escribir ( INPUT chr_linea + ",167", INPUT STRING(Cheque.fecha_emision), 8, NO).

         END.
       WHEN "V"
         THEN DO:
              FIND Valor OF Caj_detalle NO-LOCK.
              FIND Banco OF Valor NO-LOCK.
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
    
    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.
    DEFINE VARIABLE r-texto         AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.

    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).
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







