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
DEFINE VARIABLE v-color_detalle           AS CHARACTER INITIAL "BLUE".
DEFINE VARIABLE gradiente                 AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                         AS INTEGER INITIAL 10.
DEFINE VARIABLE ncopia                    AS INTEGER.
DEFINE VARIABLE v-vigencia                AS CHARACTER.
DEFINE VARIABLE letras                    AS CHARACTER.
DEFINE VARIABLE renglones                 AS CHARACTER.
DEFINE VARIABLE monto_letras1             AS CHARACTER.
DEFINE VARIABLE monto_letras2             AS CHARACTER.

DEFINE VARIABLE nmax_det                  AS INTEGER INITIAL 17.
DEFINE VARIABLE n0-aplicacion             AS INTEGER.
DEFINE VARIABLE nl-aplicacion             AS INTEGER.
DEFINE VARIABLE n0-valores                AS INTEGER.
DEFINE VARIABLE nl-valores                AS INTEGER.
DEFINE VARIABLE nt-lineas                 AS INTEGER.

DEFINE VARIABLE chr_linea                 AS CHARACTER.
DEFINE VARIABLE dtl_rubro                 AS CHARACTER.
DEFINE VARIABLE a_confirmar               AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-aplicacion              AS CHARACTER FORMAT "X(20)".

DEFINE VARIABLE nt_hojas                  AS INTEGER INITIAL 1.
DEFINE VARIABLE n_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE t_hoja                    AS INTEGER INITIAL 1.
DEFINE VARIABLE ancho                     AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE v-bruto                   LIKE Opg_header.imp_neto.
DEFINE VARIABLE v-desc                    LIKE Opg_header.imp_neto.
DEFINE VARIABLE v-valores                 LIKE Opg_header.imp_neto.

DEFINE STREAM Formulario.

DEFINE BUFFER Moneda_aplicacion FOR Moneda.
DEFINE BUFFER Moneda_pago       FOR Moneda.
/*
DEFINE QUERY qry_aplicacion FOR Opg_detalle,Cta_cte_prv,Moneda_aplicacion,Imputacion.
DEFINE QUERY qry_valores    FOR Caj_detalle.
*/
FUNCTION f-ref RETURNS CHARACTER ( INPUT n AS INTEGER).

   RETURN "<=#" + STRING(n,"9") + ">".

END FUNCTION.


/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

FIND Opg_header WHERE ROWID(Opg_header) = act_recibo NO-LOCK.
/*FIND Moneda OF Opg_header NO-LOCK.*/
FIND Moneda WHERE Moneda.es_local NO-LOCK.
FIND Condicion_impos   OF Opg_header NO-LOCK.
FIND Proveedor OF Opg_header NO-LOCK.
FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
FIND Provincia OF Opg_header NO-LOCK.
FIND Usuario OF Opg_header NO-LOCK.
FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.
FIND Caja OF Caj_header NO-LOCK.

RUN toletras.p ( INPUT Opg_header.imp_pesos + Opg_header.imp_difcambio, OUTPUT letras ).

nl-aplicacion = 0.
FOR EACH Opg_detalle OF Opg_header NO-LOCK,
     FIRST Cta_cte_prv WHERE Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                         AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                         AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela
                         AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                         AND Cta_cte_prv.nro_proveedor   = Proveedor.nro_proveedor NO-LOCK,
                         FIRST Moneda_aplicacion OF Opg_detalle NO-LOCK, 
                         FIRST Imputacion OF Cta_cte_prv NO-LOCK:
    nl-aplicacion = nl-aplicacion + 1.
END.

nl-valores = 0.
FOR EACH Caj_detalle OF Caj_header NO-LOCK, 
     FIRST Rubro OF Caj_detalle NO-LOCK:
    nl-valores = nl-valores + 1.
END.
 
nt-lineas = MAXIMUM(nl-aplicacion,nl-valores).
nt_hojas = IF nt-lineas MOD nmax_det = 0 
              THEN TRUNC(nt-lineas / nmax_det, 0) 
              ELSE 1 + TRUNC(nt-lineas / nmax_det, 0).

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
    OUTPUT STREAM Formulario TO "c:\sic-temp\propg016.xpr" CONVERT TARGET "iso8859-1".

    RUN inicia_formulario.
    ncopia = 1.
    RUN encabezado.
    RUN pie.
    RUN detalle.
    
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\propg016.xpr".
    RUN printFile( FILE-INFO:FULL-PATHNAME).
  
END PROCEDURE.

PROCEDURE inicia_formulario:

    RUN getparametro_l.p ( INPUT "PRVWOPAG", OUTPUT l-preview ).
    IF l-preview 
        THEN PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 

  /*PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  */
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresión de Ordenes de Pago><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Letter>".

    PUT STREAM Formulario CONTROL "<AT=0,0><#1>".    
    PUT STREAM Formulario CONTROL "<AT=95,0><#2>".    

END PROCEDURE.

PROCEDURE detalle:

    /*---------------------------------------------------------------------------------*/
    /*                                      DETALLE                                    */
    /*---------------------------------------------------------------------------------*/

    OPEN QUERY qry_aplicacion
         FOR EACH Opg_detalle OF Opg_header NO-LOCK,
              FIRST Cta_cte_prv WHERE Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                              AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                              AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela
                              AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                              AND Cta_cte_prv.nro_proveedor   = Proveedor.nro_proveedor NO-LOCK,
                                  FIRST Moneda_aplicacion OF Opg_detalle NO-LOCK, 
                                  FIRST Imputacion OF Cta_cte_prv NO-LOCK.
    
    OPEN QUERY qry_valores
         FOR EACH Caj_detalle OF Caj_header NO-LOCK, 
              FIRST Rubro OF Caj_detalle NO-LOCK,
              FIRST Moneda_pago OF Rubro NO-LOCK.
    
    GET FIRST qry_valores    NO-LOCK.
    GET FIRST qry_aplicacion NO-LOCK.
    
    n0-aplicacion = 66.
    nl-aplicacion = 0.

    n0-valores = 161.
    nl-valores = 0.

    DO WHILE AVAILABLE Opg_detalle OR AVAILABLE Caj_detalle:
    
      IF nl-aplicacion >= nmax_det OR nl-valores >= nmax_det
      THEN DO:

          RUN escribir     ( INPUT "142,15", INPUT "Continúa en hoja " + STRING(n_hoja + 1, ">9"), 8, NO, "BLACK").
          RUN escribir     ( INPUT "142,152", INPUT "Transporte", 8, NO, "BLACK").
          RUN escribenumero( INPUT "142,195", INPUT STRING(v-bruto,"->,>>>,>>9.99"), 8, YES, "BLACK").

          RUN escribir     ( INPUT "237,152", INPUT "Transporte", 8, NO, "BLACK").
          RUN escribenumero( INPUT "237,195", INPUT STRING(v-valores,"->,>>>,>>9.99"), 8, YES, "BLACK").
          
          OUTPUT STREAM Formulario CLOSE.
          FILE-INFO:File-NAME = "c:\sic-temp\propg016.xpr".
          RUN printFile( FILE-INFO:FULL-PATHNAME).
    
          n_hoja = n_hoja + 1.
          nl-aplicacion = 0.
          nl-valores = 0.
            
          OUTPUT STREAM Formulario TO "c:\sic-temp\propg016.xpr" CONVERT TARGET "iso8859-1".
          RUN inicia_formulario.
          RUN encabezado.    
          RUN pie.
            
      END.

      IF AVAILABLE Caj_detalle
      THEN DO:
         v-valores = v-valores + Caj_detalle.importe.
      END.
    
      IF AVAILABLE Opg_detalle
      THEN DO:
         v-bruto = v-bruto + Opg_detalle.imp_pesos + Opg_detalle.difcambio.
         v-desc  = v-desc  + Opg_detalle.descuento.
      END.
    
      IF AVAILABLE Opg_detalle
      THEN DO:

          nl-aplicacion = nl-aplicacion + 1.
          chr_linea = TRIM(STRING(n0-aplicacion + nl-aplicacion * 4,">>9")).

          v-aplicacion = Cta_cte_prv.tip_comprob + " " + 
                         STRING(Cta_cte_prv.prf_comprob,"9999") + " " +
                         STRING(Cta_cte_prv.nro_comprob,"99999999").
          RUN escribir ( INPUT chr_linea + ",12",  INPUT v-aplicacion, 8, NO, v-color_detalle).

          IF Cta_cte_prv.es_difcambio
          THEN DO:
              RUN escribir ( INPUT chr_linea + ",51",  INPUT Imputacion.abrevia, 8, NO, v-color_detalle).
              RUN escribir ( INPUT chr_linea + ",63",  INPUT Moneda_aplicacion.abrevia, 8, NO, v-color_detalle).
              RUN escribenumero( INPUT chr_linea + ",152", INPUT STRING(Opg_detalle.difcambio,"->,>>>,>>9.99"), 8, NO, v-color_detalle).
              RUN escribenumero( INPUT chr_linea + ",195", INPUT STRING(Opg_detalle.difcambio,"->,>>>,>>9.99"), 8, NO, v-color_detalle).
          END.
          ELSE DO:
              RUN escribir ( INPUT chr_linea + ",38", INPUT STRING(Cta_cte_prv.fecha_vencimiento,"99/99/99"), 8, NO, v-color_detalle).
              RUN escribir ( INPUT chr_linea + ",51",  INPUT Imputacion.abrevia, 8, NO, v-color_detalle).
              RUN escribir ( INPUT chr_linea + ",63",  INPUT Moneda_aplicacion.abrevia, 8, NO, v-color_detalle).
              RUN escribenumero( INPUT chr_linea + ",131", INPUT STRING(Opg_detalle.imp_pesos,"->,>>>,>>9.99"), 8, NO, v-color_detalle). 
              RUN escribenumero( INPUT chr_linea + ",152", INPUT STRING(Opg_detalle.difcambio,"->,>>>,>>9.99"), 8, NO, v-color_detalle). 
              RUN escribenumero( INPUT chr_linea + ",195", INPUT STRING(Opg_detalle.imp_pesos,"->,>>>,>>9.99"), 8, NO, v-color_detalle).
              RUN escribenumero( INPUT chr_linea + ",84", INPUT STRING(Opg_detalle.importe,"->,>>>,>>9.99"), 8, NO, v-color_detalle). 
              IF Cta_cte_prv.clausula_dolar
              THEN DO:
                  RUN escribenumero( INPUT chr_linea + ",96", INPUT STRING(Opg_detalle.cambio_dolar,">>,>>9.9999"), 8, NO, v-color_detalle). 
                  RUN escribenumero( INPUT chr_linea + ",111", INPUT STRING(Opg_detalle.new_cambio_dolar,">>,>>9.9999"), 8, NO, v-color_detalle).
              END.
              ELSE DO:
                  RUN escribenumero( INPUT chr_linea + ",96", INPUT STRING(Opg_detalle.cambio,">>,>>9.9999"), 8, NO, v-color_detalle). 
                  RUN escribenumero( INPUT chr_linea + ",111", INPUT STRING(Opg_detalle.new_cambio,">>,>>9.9999"), 8, NO, v-color_detalle).
              END.

          END.
          
      END.
      
      IF AVAILABLE Caj_detalle
      THEN DO:

          nl-valores = nl-valores + 1.
          chr_linea = TRIM(STRING(n0-valores + nl-valores * 4,">>9")).

          RUN escribir ( INPUT chr_linea + ",12", INPUT Rubro.abrevia , 8, NO, v-color_detalle).
          RUN escribir ( INPUT chr_linea + ",25",  INPUT Moneda_pago.abrevia, 8, YES, v-color_detalle).

          CASE Rubro.tipo:

              WHEN "D"
              THEN DO:
                  /*
                  RUN escribir ( INPUT chr_linea + ",20", INPUT Rubro.nombre, 8, NO, "BLACK").
                  */
              END.
              WHEN "C" 
              THEN DO:
                  RUN escribenumero( INPUT chr_linea + ",159", INPUT STRING(Caj_detalle.divisas,"->,>>>,>>9.99"), 8, NO, v-color_detalle). 
                  RUN escribenumero( INPUT chr_linea + ",171", INPUT STRING(Caj_detalle.cambio,">>,>>9.9999"), 8, NO, v-color_detalle). 
              END.
              WHEN "P"
              THEN DO:
                  FIND Cheque OF Caj_detalle NO-LOCK.
                  FIND Cuenta_bancaria OF Cheque NO-LOCK.
                  FIND Banco OF Cuenta_bancaria NO-LOCK.
                  RUN escribir ( INPUT chr_linea + ",32",  Banco.nombre, 8, NO, v-color_detalle). 
                  RUN escribir ( INPUT chr_linea + ",91",  Cuenta_bancaria.numero_cuenta, 8, NO, v-color_detalle). 
                  RUN escribenumero( INPUT chr_linea + ",131", INPUT STRING(Cheque.numero_cheque,"99999999"), 8, NO, v-color_detalle). 
                  RUN escribir ( INPUT chr_linea + ",135", INPUT STRING(Cheque.fecha_emision), 8, NO, v-color_detalle).
              END.
              WHEN "V"
              THEN DO:
                  FIND Valor OF Caj_detalle NO-LOCK NO-ERROR.
                  IF AVAILABLE Valor
                  THEN DO:
                      FIND Banco OF Valor NO-LOCK.
                      RUN escribir( INPUT chr_linea + ",32",  Banco.nombre, 8, NO, v-color_detalle). 
                      RUN escribenumero( INPUT chr_linea + ",131", INPUT STRING(Valor.numero_cheque,"99999999"), 8, NO, v-color_detalle). 
                      RUN escribir ( INPUT chr_linea + ",135", INPUT STRING(Valor.fecha_emision), 8, NO, v-color_detalle).
                  END.
              END.
              WHEN "A" 
              THEN DO:
                  FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
                  RUN escribir ( INPUT chr_linea + ",32", INPUT Rubro.nombre, 8, NO, v-color_detalle).
                  RUN escribir ( INPUT chr_linea + ",91",  Cuenta_bancaria.numero_cuenta, 8, NO, v-color_detalle). 
              END.
              WHEN "B" 
              THEN DO:
                  FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
                  RUN escribir ( INPUT chr_linea + ",32", INPUT Rubro.nombre, 8, NO, v-color_detalle).
                  RUN escribir ( INPUT chr_linea + ",91",  Cuenta_bancaria.numero_cuenta, 8, NO, v-color_detalle). 
              END.
              WHEN "R"
              THEN DO:
                  RUN escribir( INPUT chr_linea + ",32",  Rubro.nombre, 8, NO, v-color_detalle).
                /*RUN escribir ( INPUT chr_linea + ",32", INPUT Caj_detalle.observacion, 8, NO, "BLACK").*/
              END.
            
          END CASE.

          RUN escribenumero( INPUT chr_linea + ",195", INPUT STRING(Caj_detalle.importe,"->,>>>,>>9.99"), 8, NO, v-color_detalle).
      END.

      GET NEXT qry_valores    NO-LOCK.
      GET NEXT qry_aplicacion NO-LOCK.
    END.

END PROCEDURE.

PROCEDURE encabezado:

    /*---------------------------------------------------------------------------------*/
    /*                                    ENCABEZADO                                   */
    /*---------------------------------------------------------------------------------*/

    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<BGCOLOR=WHITE><AT=+15,+10><FROM><AT=+12,+190><RECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<BGCOLOR=WHITE><AT=+28,+10><FROM><AT=+24,+190><RECT)>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+17,+13><#3><AT=+8,+60><IMAGE#3=..\imagenes\dyna-logo.jpg>".

    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+53,+10><FROM><AT=+8,+190><RECT)>". 
    RUN escribir ( INPUT "55,81", INPUT "APLICACION DE PAGO", 10, YES, "BLACK").

    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+10><FROM><AT=+7,+190><RECT)>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+69,+10><FROM><AT=+70,+190><RECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+139,+10><FROM><AT=+8,+190><RECT)>". 

    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+180><FROM><AT=+78><LINE>". 

    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+37><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+50><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+61><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+69><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+88><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+103><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+118><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+137><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+62,+156><FROM><AT=+7><LINE>". 

    PUT STREAM Formulario UNFORMATTED f-ref(1) + "<AT=+140,+180><FROM><AT=+7><LINE>". 

    RUN escribir ( INPUT "63,17", INPUT "Comprobante", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,17", INPUT "Cancelado", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,39", INPUT "Fecha", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,39", INPUT "Vencim", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,51", INPUT "Con-", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,51", INPUT "cepto", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,62", INPUT "Mo-", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,62", INPUT "neda", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,71", INPUT "Importe", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,71", INPUT "Cancelado", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,90", INPUT "Cambio", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,90", INPUT "Documto", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,105", INPUT "Cambio", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,105", INPUT "Pago", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,120", INPUT "Importe", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,120", INPUT "Equivalente", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,139", INPUT "Diferencia", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,139", INPUT "Cambio", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "63,182", INPUT "Importe", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "66,182", INPUT "Abonado", INPUT 8, INPUT NO, "BLACK"). 


    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+53,+10><FROM><AT=+8,+190><RECT)>". 
    RUN escribir ( INPUT "150,71", INPUT "VALORES ENTREGADOS EN PAGO", 10, YES, "BLACK").

    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+10><FROM><AT=+7,+190><RECT)>". 
    
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+69,+10><FROM><AT=+70,+190><RECT)>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+139,+10><FROM><AT=+8,+190><RECT)>". 

    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+148,+10><FROM><AT=+22,+190><RECT>".  /*los valores originales son +53,+10 y +8,+190*/

    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+148,+45><FROM><AT=+22><LINE>". /*53,76   57*/
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+148,+87><FROM><AT=+22><LINE>".  /*61*/
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+148,+135><FROM><AT=+22><LINE>". /*61*/

    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+154,+10><FROM><AT=,+190><LINE>". /*61*/
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+164,+137><FROM><AT=,+62><LINE>". /*61*/

    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+180><FROM><AT=+85><LINE>". 

    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+23><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+31><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+90><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+117><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+132><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+149><FROM><AT=+7><LINE>". 
    PUT STREAM Formulario UNFORMATTED f-ref(2) + "<AT=+62,+166><FROM><AT=+7><LINE>". 

    RUN escribir ( INPUT "158,13", INPUT "Medio", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,13", INPUT "Pago", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,24", INPUT "Mo-", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,24", INPUT "neda", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,34", INPUT "Entidad", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,34", INPUT "Bancaria", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,94", INPUT "Número", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,94", INPUT "Cuenta", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,119", INPUT "Número", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,119", INPUT "Cheque", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,134", INPUT "Fecha", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,134", INPUT "Emisión", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,151", INPUT "Cantidad", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,151", INPUT "Divisas", INPUT 8, INPUT NO, "BLACK"). 

    RUN escribir ( INPUT "158,168", INPUT "Canbio", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,168", INPUT "Divisas", INPUT 8, INPUT NO, "BLACK"). 
  
    RUN escribir ( INPUT "158,182", INPUT "Importe", INPUT 8, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "161,182", INPUT "Valor", INPUT 8, INPUT NO, "BLACK"). 


    RUN escribir ( INPUT "18,80",  INPUT "ORDEN DE PAGO", 14, YES, "BLACK").
    RUN escribir ( INPUT "30,150", INPUT "Nro:<B>" + Opg_header.tip_comprob + " " +
                                                     STRING(Opg_header.prf_comprob,"9999") + " " +
                                                     STRING(Opg_header.nro_comprob,"99999999") + "</B>", INPUT 10, INPUT NO, "BLACK"). 
    
    RUN escribir ( INPUT "18,160", INPUT a_confirmar, 10, YES, "BLACK").

    RUN escribir ( INPUT "34,150", INPUT "Fecha:" + STRING(Opg_header.fecha,"99/99/9999"), INPUT 10, INPUT NO, "BLACK"). 
    RUN escribir ( INPUT "38,150", INPUT "Hoja:" + STRING(n_hoja,"99") + "/" + STRING(nt_hojas,"99"), 10, NO, "BLACK").
    RUN escribir ( INPUT "42,150", INPUT "Caja:" + STRING(Caja.cdg_caja,"99") + " - " + Caja.nombre, 10, NO, "BLACK").
    RUN escribir ( INPUT "46,150", INPUT "User:" + Usuario.cdg_usuario, 10, NO, "BLACK").
    RUN escribir ( INPUT "46,171", INPUT "-" + STRING(Opg_header.fecha_grab,"99/99/99") + "-" + SUBSTRING(STRING(Opg_header.hora_grab,"HH:MM:SS"),1,5), 10, NO, "BLACK").

    RUN escribir ( INPUT "30,12",  INPUT "Proveedor:", 10, YES, "BLACK").
    RUN escribir ( INPUT "30,32",  INPUT Opg_header.nombre + "  [" + Proveedor.cdg_proveedor + "]", 10, YES, "BLACK").
    RUN escribir ( INPUT "34,32",  INPUT Opg_header.direccion, 10, NO, "BLACK").
    RUN escribir ( INPUT "38,32",  INPUT Opg_header.cdg_postal + " " + Opg_header.localidad, 10, NO, "BLACK").
    RUN escribir ( INPUT "42,32",  INPUT Provincia.nombre, 10, NO, "BLACK").
    RUN escribir ( INPUT "46,32",  INPUT "CUIT:" + Proveedor.cuit + " - " + Condicion_impos.texto, 10, NO, "BLACK"). 

    RUN escribir ( INPUT "244,22", INPUT "SOLICITO", 8, YES, "BLACK").
    RUN escribir ( INPUT "244,60", INPUT "PREPARO", 8, YES, "BLACK").
    RUN escribir ( INPUT "244,103", INPUT "AUTORIZO", 8, YES, "BLACK").
    RUN escribir ( INPUT "244,151", INPUT "EN CONFORMIDAD", 8, YES, "BLACK").
  

END PROCEDURE.

PROCEDURE pie:

    /*---------------------------------------------------------------------------------*/
    /*                                       PIE                                       */
    /*---------------------------------------------------------------------------------*/

    IF n_hoja = nt_hojas
    THEN DO:
        RUN escribir( INPUT "120,15", INPUT Opg_header.leyenda, 8, NO, "BLACK").
        
        RUN escribenumero( INPUT "142,195", INPUT STRING(Opg_header.imp_pesos + Opg_header.imp_difcambio,"->,>>>,>>9.99"), 8, YES, "BLACK").
    
        RUN escribir     ( INPUT "237,15", INPUT "<B>Son " + Moneda.descripcion + ":</B>" + letras, 8, NO, "BLACK").
        RUN escribenumero( INPUT "237,195", INPUT STRING(Opg_header.imp_pesos + Opg_header.imp_difcambio,"->,>>>,>>9.99"), 8, YES, "BLACK").
        RUN escribircentrado ( INPUT "260,138", INPUT "por " + Opg_header.nombre, 8, NO, 2.44, "BLACK" ).
        
    END.

    /*
    RUN escribircentrado( INPUT "143,70", INPUT Usuario.nombre, 7, NO, 10.0).
    RUN escribircentrado( INPUT "143,158", INPUT "Por " + Proveedor.nombre, 7, NO, 10.0).
    */
END PROCEDURE.

PROCEDURE escribir:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER textColor AS CHARACTER.
    
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

    PUT STREAM Formulario UNFORMATTED linea SKIP.

END PROCEDURE.

PROCEDURE escribircentrado:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER f-width  AS DECIMAL.
    DEFINE INPUT PARAMETER textColor AS CHARACTER.

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

    PUT STREAM Formulario UNFORMATTED linea SKIP.

END PROCEDURE.

PROCEDURE escribenumero:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    DEFINE INPUT PARAMETER textColor AS CHARACTER.

    DEFINE VARIABLE linea           AS CHARACTER.
    DEFINE VARIABLE s-font          AS CHARACTER.
    DEFINE VARIABLE r-texto         AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.
    
    s-font = 'CourierNew,' + puntos + IF negrita THEN ',B' ELSE ''.
    
    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).

    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' + 
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             "<DECIMAL=+0>" + texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 

    PUT STREAM Formulario UNFORMATTED linea SKIP.
  /*RUN grabar_linea ( linea ).*/

END PROCEDURE.

