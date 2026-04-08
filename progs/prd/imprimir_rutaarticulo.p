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
DEFINE VARIABLE det1                   AS INTEGER INITIAL 62.
DEFINE VARIABLE det_obs                AS INTEGER INITIAL 62.
                                       
DEFINE VARIABLE ancho                  AS DECIMAL INITIAL 1.0.
DEFINE VARIABLE x-cantidad             AS DECIMAL INITIAL 1.0.
                                        
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
DEFINE VARIABLE xn                     AS INTEGER.
DEFINE VARIABLE interlinea             AS INTEGER INITIAL 3.
DEFINE VARIABLE alto_operacion         AS INTEGER INITIAL 7.
DEFINE VARIABLE alto_titulos           AS INTEGER INITIAL 5.
DEFINE VARIABLE alto_detalle           AS INTEGER.
DEFINE VARIABLE alto_observacion       AS INTEGER.

DEFINE VARIABLE que_dia                AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes                AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano                AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha              AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo               AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada            AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-tomo                 AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-observacion          AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto                 AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE a-cdg_tipoespec        LIKE Tipo_especificacion.cdg_tipoespec.

DEFINE STREAM Formulario.
DEFINE BUFFER Componente FOR Articulo.

FUNCTION ch_linea RETURN CHARACTER ( INPUT n0 AS INTEGER, INPUT n AS INTEGER).
    RETURN STRING(n0 + n * interlinea,"9999").
END FUNCTION.

FUNCTION fnchar RETURN CHARACTER ( INPUT n0 AS INTEGER ).
    RETURN TRIM(STRING(n0,">>>9")).
END FUNCTION.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.
DO TRANSACTION:

    FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
    FIND Aliart-cliente OF Articulo NO-LOCK NO-ERROR.
    IF AVAILABLE Aliart-cliente
    THEN DO:
        FIND Cliente OF Aliart-cliente NO-LOCK.
    END.
    FIND Tipo_articulo OF Articulo NO-LOCK.
    FIND Lineaproceso OF Tipo_articulo NO-LOCK.
    FIND Unidad OF Articulo NO-LOCK.

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
    
    RUN rectangulo (5,5,10,190).
    RUN rectangulo (16,5,26,190).
    RUN rectangulo ( 16,160,7,35). 

    RUN escribir ( INPUT "07,70", INPUT "RUTA DE ARTICULO", INPUT 14, INPUT YES, INPUT "BLACK"). 
        
    RUN escribir ( INPUT "17,10", INPUT "ARTICULO", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "17,34", INPUT ":", INPUT 12, INPUT YES, INPUT "BLACK"). 
    RUN escribir ( INPUT "17,36", INPUT Articulo.cdg_articulo + " - " + Articulo.descripcion, INPUT 12, INPUT NO, INPUT "BLUE"). 
    RUN escribenumero ( INPUT "17,179", INPUT STRING(100.00,">>>>>>>9.99"), INPUT 12, INPUT NO, INPUT "BLUE").
    RUN escribenumero ( INPUT "17,191", INPUT Unidad.abrevia, INPUT 12, INPUT NO, INPUT "BLUE").
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
    FOR EACH Articulo_operacion OF Articulo NO-LOCK, 
        Operacionfabrica OF Articulo_operacion NO-LOCK,
         EACH Centrotrabajo OF Articulo_operacion NO-LOCK:

        nreng_art = 0.
        FOR EACH Formula_articulo WHERE Formula_articulo.nro_art_compuesto = Articulo_operacion.nro_articulo
                                    AND Formula_articulo.nro_operacion = Articulo_operacion.nro_operacion  NO-LOCK,
                                        FIRST Componente WHERE Componente.nro_articulo = Formula_articulo.nro_art_componente NO-LOCK:
            nreng_art = nreng_art + 1. 
        END.

        nreng_esp = 0.
        OPEN QUERY q-espec
            FOR EACH Especif_operarticulo 
               WHERE Especif_operarticulo.nro_articulo = Articulo.nro_articulo
                 AND Especif_operarticulo.nro_operacion = Articulo_operacion.nro_operacion  NO-LOCK,
                     FIRST Especificacion OF Especif_operarticulo NO-LOCK
                            BY Especif_operarticulo.num_orden BY Especificacion.cdg_especificacion.

        GET FIRST q-espec.
        a-cdg_tipoespec = "".
        DO WHILE AVAILABLE Especif_operarticulo:
            IF a-cdg_tipoespec <> Especificacion.cdg_tipoespec
            THEN DO:
                nreng_esp = nreng_esp + 1. 
            END.
            nreng_esp = nreng_esp + 1. 
            a-cdg_tipoespec = Especificacion.cdg_tipoespec.
            GET NEXT q-espec.
        END.

        IF nreng_art <> 0 OR nreng_esp <> 0
        THEN DO:

            /* --------------------------------------------------------- */
            /*            Nombre de la operacion de fabrica              */
            /* --------------------------------------------------------- */

            RUN rectangulo ( 0,5,alto_operacion,190). 
            RUN linea    ( "0,110", INPUT fnchar(alto_operacion), "V" ).
            RUN escribir ( INPUT "01,10", INPUT Operacionfabrica.dsc_operacion, INPUT 12, INPUT YES, INPUT "BLACK").
            RUN escribir ( INPUT "01,115", INPUT Centrotrabajo.dsc_centrotrabajo, INPUT 12, INPUT YES, INPUT "BLACK").

            /* --------------------------------------------------------- */
            /*   Titulos de cada operación y lineas verticales           */
            /* --------------------------------------------------------- */

            RUN rectangulo ( alto_operacion,5,alto_titulos,190). 

            RUN escribir ( fnchar(alto_operacion + 1) + ",11", INPUT "CODIGO", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir ( fnchar(alto_operacion + 1) + ",36", INPUT "DESCRIPCION", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir ( fnchar(alto_operacion + 1) + ",112", INPUT "CANTIDAD", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir ( fnchar(alto_operacion + 1) + ",130", INPUT "ESPECIFICACION", INPUT 8, INPUT YES, INPUT "BLACK").
            RUN escribir ( fnchar(alto_operacion + 1) + ",178", INPUT "VALOR", INPUT 8, INPUT YES, INPUT "BLACK").

            alto_detalle = ( 1 + MAXIMUM(nreng_art,nreng_esp) ) * interlinea.

            RUN rectangulo ( alto_operacion + alto_titulos,5,alto_detalle,190). 
            
            RUN linea ( fnchar(alto_operacion ) + ",034", INPUT STRING(alto_detalle + alto_titulos,"9999"), "V" ).
            RUN linea ( fnchar(alto_operacion ) + ",110", INPUT STRING(alto_detalle + alto_titulos,"9999"), "V" ).
            RUN linea ( fnchar(alto_operacion ) + ",127", INPUT STRING(alto_detalle + alto_titulos,"9999"), "V" ).
            RUN linea ( fnchar(alto_operacion ) + ",168", INPUT STRING(alto_detalle + alto_titulos,"9999"), "V" ).
            
            /* --------------------------------------------------------- */
            /*   Artículos y especificaciones de cada operación          */
            /* --------------------------------------------------------- */

            det0 = 0.
            det1 = 0.
            OPEN QUERY q-formula
                FOR EACH Formula_articulo 
                   WHERE Formula_articulo.nro_articulo = Articulo.nro_articulo
                     AND Formula_articulo.nro_operacion = Articulo_operacion.nro_operacion NO-LOCK,
                         FIRST Componente WHERE Componente.nro_articulo = Formula_articulo.nro_art_componente,
                         FIRST Unidad OF Componente NO-LOCK.
            OPEN QUERY q-espec
                FOR EACH Especif_operarticulo 
                   WHERE Especif_operarticulo.nro_articulo = Articulo.nro_articulo
                     AND Especif_operarticulo.nro_operacion = Articulo_operacion.nro_operacion  NO-LOCK,
                         FIRST Especificacion OF Especif_operarticulo NO-LOCK
                                BY Especif_operarticulo.num_orden BY Especificacion.cdg_especificacion.

            GET FIRST q-formula.
            GET FIRST q-espec.
            a-cdg_tipoespec = "".
            DO WHILE AVAILABLE Formula_articulo OR AVAILABLE Especif_operarticulo:
                IF AVAILABLE Formula_articulo
                THEN DO:
                    RUN escribir ( ch_linea(alto_operacion + alto_titulos,det0)  + ",7", INPUT Componente.cdg_articulo, INPUT 7, INPUT NO, INPUT "BLUE").
                    RUN escribir ( ch_linea(alto_operacion + alto_titulos,det0)  + ",35", INPUT Componente.descripcion , INPUT 7, INPUT NO, INPUT "BLUE").
                    x-cantidad = Formula_articulo.cantidad_componente / Formula_articulo.cantidad_compuesto * 100.
                    RUN escribenumero ( ch_linea(alto_operacion + alto_titulos,det0)  + ",119", INPUT STRING(x-cantidad,">>>>>>>9.99"), INPUT 7, INPUT NO, INPUT "BLUE").
                    RUN escribir ( ch_linea(alto_operacion + alto_titulos,det0)  + ",123", INPUT Unidad.abrevia, INPUT 7, INPUT NO, INPUT "BLUE").
                    det0 = det0 + 1. 
                END.
                IF AVAILABLE Especif_operarticulo
                THEN DO:
                    IF a-cdg_tipoespec <> Especificacion.cdg_tipoespec
                    THEN DO:
                        FIND Tipo_especificacion OF Especificacion NO-LOCK.
                        RUN escribir ( ch_linea(alto_operacion + alto_titulos,det1)  + ",130", INPUT Tipo_especificacion.dsc_tipoespec, INPUT 7, INPUT NO, INPUT "BLACK").
                        det1 = det1 + 1. 
                    END.
                    RUN escribir ( ch_linea(alto_operacion + alto_titulos,det1)  + ",134", INPUT Especificacion.dsc_especificacion, INPUT 7, INPUT NO, INPUT "BLACK").
                    RUN escribir ( ch_linea(alto_operacion + alto_titulos,det1)  + ",170", INPUT Especif_operarticulo.valor_especificacion, INPUT 7, INPUT NO, INPUT "BLUE").
                    det1 = det1 + 1. 
                    a-cdg_tipoespec = Especificacion.cdg_tipoespec.
                END.
                GET NEXT q-formula.
                GET NEXT q-espec.
                
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

                alto_observacion = (1 + nt_lineas ) * interlinea.

                RUN rectangulo ( alto_operacion + alto_titulos + alto_detalle ,5,alto_observacion,190). 
                /*
                RUN grabar_linea ( "<=#1><BGCOLOR=BLACK><AT=+" + ch_linea(alto_operacion + alto_titulos + 2,det0)  + ",+5" + "><FROM><AT=+" + STRING(2 + nt_lineas * interlinea,"9999") + ",+190><RECT>"). 
                */

                det_obs = 0.
                DO j-tomo = 1 TO NUM-ENTRIES(Articulo_operacion.observacion,CHR(10)):

                    v-tomo = ENTRY(j-tomo,Articulo_operacion.observacion,CHR(10)).
            
                    IF LENGTH(v-tomo) <> 0
                    THEN DO:
                        
                        RUN RENGLONS.P (INPUT  v-tomo, 
                                        INPUT  v-leng_detallada,
                                        OUTPUT v-detallada,
                                        INPUT  "|").
                        
                        DO j = 1 to NUM-ENTRIES(v-detallada,"|"):
                            RUN escribir ( ch_linea(alto_operacion + alto_titulos + alto_detalle,det_obs)  + ",7", INPUT ENTRY(j,v-detallada, "|"), INPUT 7, INPUT NO, INPUT "BLUE").            
                            det_obs = det_obs + 1. 
                        END.
            
                    END.
                    ELSE DO:
                        det_obs = det_obs + 1.
                    END.
            
                END.

            END.
            ELSE DO:
                alto_observacion = 0.
            END.

        END.
        
        linea0 = linea0 + ( alto_operacion + alto_titulos + alto_detalle + alto_observacion + 2) .
        RUN grabar_linea ( "<AT=" + ch_linea(linea0,0) + ",5><#1>").

    END.

    RUN linea    ( "262,138", INPUT "57", "H" ).

END PROCEDURE.

PROCEDURE forma:

    RUN inicia_hoja.

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

PROCEDURE rectangulo:

    DEFINE INPUT PARAMETER or-x        AS INTEGER.
    DEFINE INPUT PARAMETER or-y        AS INTEGER.
    DEFINE INPUT PARAMETER alto        AS INTEGER.
    DEFINE INPUT PARAMETER ancho       AS INTEGER.

    RUN grabar_linea ( "<=#1><BGCOLOR=BLACK><AT=+" + 
                       fnchar(or-x) +  
                       ",+" +
                       fnchar(or-y) +  
                       "><FROM><AT=+" + 
                       fnchar(alto) + 
                       ",+" + 
                       fnchar(ancho) + 
                       "><RECT>"). 

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
