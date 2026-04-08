/*=================================================================================*/
/*                     IMPRESION DE FORMULARIO DE PEDIDOS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_articulo AS ROWID.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}

DEFINE VARIABLE TextColor              AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color               AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente              AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                      AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f                AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c                AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia                 AS INTEGER.
DEFINE VARIABLE det0                   AS INTEGER INITIAL 62.
                                       
DEFINE VARIABLE ancho                  AS DECIMAL INITIAL 1.0.
                                        
DEFINE VARIABLE max_det                AS INTEGER INITIAL 47. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle         AS INTEGER INITIAL 72. /* Ancho en chars del detalle    */
                                        
DEFINE VARIABLE v-reng_observacion     AS INTEGER INITIAL 5.  /* Cantidad de lineas de observacion */
DEFINE VARIABLE v-leng_observacion     AS INTEGER INITIAL 70. /* Ancho en chars de la observacion  */

DEFINE VARIABLE j                      AS INTEGER.
DEFINE VARIABLE j-tomo                 AS INTEGER.
DEFINE VARIABLE nt_lineas              AS INTEGER.
DEFINE VARIABLE v-leng_detallada       AS INTEGER INITIAL 160.
DEFINE VARIABLE nreng_art              AS INTEGER.
DEFINE VARIABLE nreng_esp              AS INTEGER.
DEFINE VARIABLE linea0                 AS INTEGER.
DEFINE VARIABLE n_hoja                 AS INTEGER.
DEFINE VARIABLE interlinea             AS INTEGER INITIAL 4.
                                       
DEFINE VARIABLE que_dia                AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes                AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano                AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha              AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo               AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada            AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-tomo                 AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-observacion          AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto                 AS CHARACTER FORMAT "X(75)".

DEFINE STREAM Formulario.
DEFINE BUFFER Componente FOR Articulo.

FUNCTION ch_linea RETURN CHARACTER ( INPUT n0 AS INTEGER, INPUT n AS INTEGER).
    RETURN STRING(n0 + n * interlinea,"9999").
END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
DO TRANSACTION:

    FIND Articulo WHERE ROWID(Articulo) = rid_articulo EXCLUSIVE-LOCK.
    FIND Aliart-cliente OF Articulo NO-LOCK NO-ERROR.
    IF AVAILABLE Aliart-cliente
    THEN DO:
        FIND Cliente OF Aliart-cliente NO-LOCK.
    END.
    FIND Tipo_articulo OF Articulo NO-LOCK.
    FIND Lineaproceso OF Tipo_articulo NO-LOCK.

    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DEL PEDIDO                                  */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\rutaproceso.xpr" CONVERT TARGET "iso8859-1".

    ncopia = 1.
    n_hoja = 0.
    RUN forma.
   
    OUTPUT STREAM Formulario CLOSE.
    FILE-INFO:File-NAME = "c:\sic-temp\rutaproceso.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
    /*
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */
    */

END.
RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE inicia_hoja:

    n_hoja = n_hoja + 1.
    
    RUN grabar_linea ( '<PREVIEW=70>') /*=ZoomToWidth>'*/.  
    /*
    RUN grabar_linea ( '<TOOLBAR=!PRINT>').                 
    
    RUN grabar_linea ( "<PREVIEW=PDF><PDF-TITLE=Impresión de Ruta de Articulo:" + 
                                   Articulo.cdg_articulo + "><PDF-FONTS=BASE14><PDF-OUTPUT=C:\sic-temp\Articulo_operacion.pdf>").
    */
    RUN grabar_linea ( "<OPORTRAIT><Title=Impresión de Ruta de Articulo:" + 
                                   Articulo.cdg_articulo + " Hoja:" + STRING(n_hoja,'>9') + "><UNITS=mm><|2>").
    RUN grabar_linea ( "<FORMAT=A4>").
    RUN grabar_linea ( "<AT=5,5><#1>").    
    
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+10,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+26,+190><RECT>"). 
    RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+257,+5><FROM><AT=+25,+190><RECT>"). 

    RUN escribir ( INPUT "07,70", INPUT "RUTA DE PROCESO", INPUT 14, INPUT YES, INPUT "BLACK"). 
        
    RUN escribir ( INPUT "17,10", INPUT "ARTICULO", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "17,34", INPUT ":", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "17,36", INPUT Articulo.cdg_articulo + " - " + Articulo.descripcion, INPUT 12, INPUT NO, INPUT "BLUE"). 
    RUN escribir ( INPUT "23,10", INPUT "TIPO", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "23,34", INPUT ":", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "23,36", INPUT Tipo_articulo.dsc_tipoart, INPUT 12, INPUT NO, INPUT "BLUE"). 
    RUN escribir ( INPUT "29,10", INPUT "RUTA", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "29,34", INPUT ":", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "29,36", INPUT Lineaproceso.cdg_lineaproceso + " - " + Lineaproceso.cdg_lineaproceso, INPUT 12, INPUT NO, INPUT "BLUE"). 
    RUN escribir ( INPUT "35,10", INPUT "CLIENTE", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "35,34", INPUT ":", INPUT 12, INPUT YES, INPUT "BLACK").
    IF AVAILABLE Cliente
        THEN RUN escribir ( INPUT "35,36", INPUT "[" + Cliente.cdg_cliente + "] " + Cliente.nom_cliente, INPUT 10, INPUT NO, INPUT "BLUE").
    
    linea0 = 48. /* Aqui comienza el detalle */

    RUN grabar_linea ( "<AT=48,5><#1>").    
    FOR EACH Articulo_operacion OF Articulo NO-LOCK, Operacionfabrica OF Articulo_operacion NO-LOCK:

        nreng_art = 0.
        FOR EACH Formula_articulo WHERE Formula_articulo.nro_art_compuesto = Articulo.nro_articulo
                                    AND Formula_articulo.nro_operacion = Articulo_operacion.nro_operacion,
                                        FIRST Componente WHERE Componente.nro_articulo = Formula_articulo.nro_art_componente NO-LOCK:
            nreng_art = nreng_art + 1. 
        END.
        nreng_esp = 0.
        FOR EACH Especif_operarticulo WHERE Especif_operarticulo.nro_articulo = Articulo.nro_articulo
                                        AND Especif_operarticulo.nro_operacion = Articulo_operacion.nro_operacion NO-LOCK:
            nreng_esp = nreng_esp + 1. 
        END.

        IF nreng_art <> 0 OR nreng_esp <> 0
        THEN DO:

            /* --------------------------------------------------------- */
            /*            Nombre de la operacion de fabrica              */
            /* --------------------------------------------------------- */

            RUN grabar_linea ( "<=#1><BGCOLOR=BLACK><AT=+0,+5><FROM><AT=+7,+190><RECT>"). 
            RUN escribir ( INPUT "01,70", INPUT Operacionfabrica.dsc_operacion, INPUT 12, INPUT YES, INPUT "BLACK").


            /* --------------------------------------------------------- */
            /*   Titulos de cada operación y lineas verticales           */
            /* --------------------------------------------------------- */

            RUN grabar_linea ( "<=#1><BGCOLOR=BLACK><AT=+8,+5><FROM><AT=+5,+190><RECT>"). 

            RUN escribir    ( "9,11", INPUT "CODIGO", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir    ( "9,36", INPUT "DESCRIPCION", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir    ( "9,110", INPUT "XANTIDAD", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir    ( "9,132", INPUT "ESPECIFICACION", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir    ( "9,180", INPUT "VALOR", INPUT 8, INPUT YES, INPUT "BLACK").

            RUN grabar_linea ( "<=#1><BGCOLOR=WHITE><AT=+13,+5><FROM><AT=+" + STRING( 1 + MAXIMUM(nreng_art,nreng_esp) * interlinea,"9999") + ",+190><RECT>"). 
            RUN linea    ( "8,034", INPUT STRING( 6 + MAXIMUM(nreng_art,nreng_esp) * 4,"9999"), "V" ).
            RUN linea    ( "8,110", INPUT STRING( 6 + MAXIMUM(nreng_art,nreng_esp) * 4,"9999"), "V" ).
            RUN linea    ( "8,130", INPUT STRING( 6 + MAXIMUM(nreng_art,nreng_esp) * 4,"9999"), "V" ).
            RUN linea    ( "8,178", INPUT STRING( 6 + MAXIMUM(nreng_art,nreng_esp) * 4,"9999"), "V" ).

            /* --------------------------------------------------------- */
            /*   Artículos y especificaciones de cada operación          */
            /* --------------------------------------------------------- */

            det0 = 0.
            OPEN QUERY q-formula
                FOR EACH Formula_articulo WHERE Formula_articulo.nro_art_compuesto = Articulo.nro_articulo
                                        AND Formula_articulo.nro_operacion = Articulo_operacion.nro_operacion,
                                            FIRST Componente WHERE Componente.nro_articulo = Formula_articulo.nro_art_componente,
                                            FIRST Unidad OF Componente NO-LOCK.
            OPEN QUERY q-espec
                FOR EACH Especif_operarticulo WHERE Especif_operarticulo.nro_articulo = Articulo.nro_articulo
                                                AND Especif_operarticulo.nro_operacion = Articulo_operacion.nro_operacion,
                                            FIRST Especificacion OF Especif_operarticulo NO-LOCK.

            GET FIRST q-formula.
            GET FIRST q-espec.
            DO WHILE AVAILABLE Formula_articulo OR AVAILABLE Especif_operarticulo:
                IF AVAILABLE Formula_articulo
                THEN DO:
                    RUN escribir ( ch_linea(14,det0)  + ",7", INPUT Componente.cdg_articulo, INPUT 7, INPUT NO, INPUT "BLUE").
                    RUN escribir ( ch_linea(14,det0)  + ",35", INPUT Componente.descripcion , INPUT 7, INPUT NO, INPUT "BLUE").
                    RUN escribenumero ( ch_linea(14,det0)  + ",121", INPUT STRING(Formula_articulo.cantidad_componente,">>>>>>>9.99"), INPUT 7, INPUT NO, INPUT "BLUE").
                    RUN escribir ( ch_linea(14,det0)  + ",125", INPUT Unidad.abrevia, INPUT 7, INPUT NO, INPUT "BLUE").
                END.
                IF AVAILABLE Especif_operarticulo
                THEN DO:
                    RUN escribir ( ch_linea(14,det0)  + ",132", INPUT Especificacion.dsc_especificacion, INPUT 7, INPUT NO, INPUT "BLUE").
                    RUN escribir ( ch_linea(14,det0)  + ",180", INPUT Especif_operarticulo.valor_especificacion, INPUT 7, INPUT NO, INPUT "BLUE").
                END.
                GET NEXT q-formula.
                GET NEXT q-espec.
                det0 = det0 + 1. 
            END.

            /* --------------------------------------------------------- */
            /*   Observaciones de la operación                           */
            /* --------------------------------------------------------- */

            IF Articulo_operacion.observacion <> ""
            THEN DO:

                /* ------------------------------------------- */
                /* Cuenta la cantidad de lineas de observación */
                /* ------------------------------------------- */

                nt_lineas = 0.

                DO j-tomo = 1 TO NUM-ENTRIES(Articulo_operacion.observacion,CHR(10)):
                    v-tomo = ENTRY(j-tomo,Articulo_operacion.observacion,CHR(10)).
                    IF LENGTH(v-tomo) <> 0
                    THEN DO:
                        RUN RENGLONS.P (INPUT  v-tomo, 
                                        INPUT  v-leng_detallada,
                                        OUTPUT v-detallada,
                                        INPUT  "|").
            
                        nt_lineas =  nt_lineas + NUM-ENTRIES(v-detallada,"|").
                    END.
                    ELSE DO:
                        nt_lineas = nt_lineas + 1.
                    END.
                END.

                RUN grabar_linea ( "<=#1><BGCOLOR=BLACK><AT=+" + ch_linea(14,det0)  + ",+5" + "><FROM><AT=+" + STRING(nt_lineas * 4,"9999") + ",+190><RECT>"). 

                DO j-tomo = 1 TO NUM-ENTRIES(Articulo_operacion.observacion,CHR(10)):

                    v-tomo = ENTRY(j-tomo,Articulo_operacion.observacion,CHR(10)).
            
                    IF LENGTH(v-tomo) <> 0
                    THEN DO:
                        
                        RUN RENGLONS.P (INPUT  v-tomo, 
                                        INPUT  v-leng_detallada,
                                        OUTPUT v-detallada,
                                        INPUT  "|").
                        
                        DO j = 1 to NUM-ENTRIES(v-detallada,"|"):
                            RUN escribir ( ch_linea(15,det0)  + ",7", INPUT ENTRY(j,v-detallada, "|"), INPUT 7, INPUT NO, INPUT "BLUE").            
                            det0 = det0 + 1. 
                        END.
            
                    END.
                    ELSE DO:
                        det0 = det0 + 1.
                    END.
            
                END.

            END.

        END.

        linea0 = linea0 + det0 * 4 + 16.
        RUN grabar_linea ( "<AT=" + ch_linea(linea0,0) + ",5><#1>").

    END.
    /*
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",9", INPUT "Código", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",28", INPUT "Descripción", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",114", INPUT "Color", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",128", INPUT "Pedido", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",155", INPUT "Precio", INPUT 8, INPUT NO, INPUT "BLACK").
    RUN escribir ( ch_linea(det0 + 1,-1)  + ",175", INPUT "Preparado", INPUT 8, INPUT NO, INPUT "BLACK").

    RUN linea    ( ch_linea(det0 - 2,1)  + ",5", INPUT "190", "H" ).

    RUN linea    ( "57,26", INPUT "200", "V" ).
    RUN linea    ( "57,110", INPUT "200", "V" ).
    RUN linea    ( "57,124", INPUT "200", "V" ).
    RUN linea    ( "57,138", INPUT "225", "V" ).
    RUN linea    ( "57,168", INPUT "225", "V" ).
    */
    RUN linea    ( "262,138", INPUT "57", "H" ).
    /*
    RUN escribir ( INPUT "258,143", INPUT "Valor Declarado", INPUT 8, INPUT YES, INPUT "BLACK").
    RUN escribir ( INPUT "258,171", INPUT "Cantidad Bultos", INPUT 8, INPUT YES, INPUT "BLACK").
    */
    
    

END PROCEDURE.

PROCEDURE forma:

    RUN inicia_hoja.
    /*
    FOR EACH Ped_detalle OF Ped_header, Articulo OF Ped_detalle,
        Partida OF Ped_detalle
        BREAK BY Articulo.cdg_articulo BY Partida.cdg_partida:

        IF linea0 > max_det
        THEN DO:
           /*RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "CONTINUA EN HOJA " + STRING(n_hoja + 1,">9"), INPUT 12, INPUT YES, INPUT "BLACK").*/
             RUN escribir ( "258,30", INPUT "CONTINUA EN HOJA " + STRING(n_hoja + 1,">9"), INPUT 12, INPUT YES, INPUT "BLACK").
             OUTPUT STREAM Formulario CLOSE.
             FILE-INFO:File-NAME = "c:\sic-temp\rutaproceso.xpr").
             RUN printFile( FILE-INFO:FULL-PATHNAME).
             
             OUTPUT STREAM Formulario TO "c:\sic-temp\rutaproceso.xpr" CONVERT TARGET "iso8859-1").
             RUN inicia_hoja.             
        END.

        RUN escribir      ( ch_linea(det0,linea0)  + ",9", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO, INPUT "BLACK").
        RUN escribir      ( ch_linea(det0,linea0)  + ",28", INPUT Articulo.descripcion, INPUT 8, INPUT NO, INPUT "BLACK").
        RUN escribir      ( ch_linea(det0,linea0)  + ",112", INPUT Partida.cdg_partida, INPUT 8, INPUT NO, INPUT "BLACK").
        RUN escribenumero ( ch_linea(det0,linea0)  + ",142", INPUT STRING(Ped_detalle.precio,"->>>>9.9999"), INPUT 8, INPUT NO, INPUT "BLACK"). 
        RUN escribenumero ( ch_linea(det0,linea0)  + ",117", INPUT STRING(Ped_detalle.cantidad,"ZZZZZZ9"), INPUT 8, INPUT NO, INPUT "BLACK").
        RUN linea         ( ch_linea(det0 + 3,linea0)  + ",170", INPUT "23", "H" ).
        linea0 = linea0 + 1.

        total_articulo = total_articulo + Ped_detalle.cantidad.    
        IF LAST-OF(Articulo.cdg_articulo)
        THEN DO:
            /*
            IF NOT CAN-FIND(FIRST Partida OF Articulo 
                            WHERE Partida.cdg_partida = "" )
            */

            RUN linea         ( ch_linea(det0 + 1,linea0)  + ",126", INPUT "11", "H" ).
            linea0 = linea0 + 1.       
            RUN escribenumero ( ch_linea(det0,linea0)  + ",117", INPUT STRING(total_articulo,"ZZZZZZ9"), INPUT 8, INPUT NO, INPUT "BLACK").

            linea0 = linea0 + 2.       
            total_articulo = 0.
        END. 
    
    END.

    RUN escribir ( ch_linea(det0,linea0 + 1)  + ",30", INPUT "FIN DE LOS ITEMS DE PEDIDO", INPUT 12, INPUT YES, INPUT "BLACK").

    IF Ped_header.observacion <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Ped_header.observacion, 
                        INPUT  v-leng_observacion,
                        OUTPUT v-observacion,
                        INPUT  "|").
    
    
        linea0 = 258.
        DO j = 1 TO v-reng_observacion:
            IF j <= NUM-ENTRIES(v-observacion, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT ENTRY(j,v-observacion, "|"), INPUT 10, INPUT NO, INPUT "BLACK").
            linea0 = linea0 + 3.
        END.
    
    
    END.
    */
END PROCEDURE.
/*
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

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    RUN grabar_linea ( linea.

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

    s-font = 'Arial,' + puntos + IF negrita THEN ',B' ELSE ''.
    offset = DECIMAL(ENTRY(2,ENTRY(1,RightJustify(TRIM(texto), s-font, ancho),">"),",")) * 12.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")) + offset.

    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
/*
    message linea view-as alert-box message title "plot").
*/    
    RUN grabar_linea ( linea.

END PROCEDURE.
*/

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
    message linea view-as alert-box message title "plot").
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

PROCEDURE grabar_linea:

    DEFINE INPUT PARAMETER texto  AS CHARACTER.

    /*c-orden = c-orden + 1 .  Incrementamos el contador de registros */

    PUT STREAM Formulario UNFORMATTED texto.
    /*
    CREATE T-Listado.
    ASSIGN T-Listado.cdg_seccion = v-cdg_seccion
           T-Listado.l-orden   = c-orden
           T-Listado.l-linea   = texto.
    */
END PROCEDURE.
