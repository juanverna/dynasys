/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE FACTURACION TIPO A                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}
{parlocales.i}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.
DEFINE VARIABLE v-equivale     AS INTEGER.
DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 40. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 85. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 160. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.

DEFINE VARIABLE v-cantidad     LIKE Ped_detalle.cantidad.
DEFINE VARIABLE v-subtotal     LIKE Ped_detalle.subtotal_neto.

DEFINE VARIABLE ch_linea       AS CHARACTER.
DEFINE VARIABLE que_dia        AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes        AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano        AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo       AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada    AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-monto_letras AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-leyenda      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto         AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-descuentos   AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-ley_anexo    AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE arch_salida    AS CHARACTER INITIAL "c:\sic-temp\prped103.xpr".
DEFINE VARIABLE v-reimpresion  AS CHARACTER.
DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Ped_header.imp_neto FORMAT "Z,ZZZ,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Ped_header.imp_neto FORMAT "Z,ZZZ,ZZZ,ZZ9.99-".

DEFINE BUFFER Provlegal FOR Provincia.
DEFINE BUFFER Unigranel FOR Unidad.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Ped_header WHERE ROWID(Ped_header) = rid_factura EXCLUSIVE-LOCK.

    arch_salida = "c:\sic-temp\" + Ped_header.tip_comprob + "-"+ 
                        STRING(Ped_header.prf_comprob,"9999") + "-" + 
                        STRING(Ped_header.nro_comprob,"99999999").

    FIND Punto-venta WHERE Punto-venta.cdg_empresa = Ped_header.cdg_empresa
                       AND Punto-venta.cdg_puntovta = Ped_header.prf_comprob
                           NO-LOCK.

    FIND Empresa OF Ped_header NO-LOCK.
    FIND Condicion_impos OF Ped_header NO-LOCK.
    FIND Condicion_venta OF Ped_header NO-LOCK.
    FIND Provincia OF Ped_header NO-LOCK.
    FIND Cliente   OF Ped_header NO-LOCK NO-ERROR.
    FIND Provlegal OF Cliente NO-LOCK.    
    FIND Vendedor OF Ped_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Ped_header NO-LOCK NO-ERROR.
    FIND Usuario OF Ped_header NO-LOCK.
    FIND Cobrador OF Cliente NO-LOCK.
    
    que_mes = STRING(MONTH(Ped_header.fecha),"99").
    que_ano = STRING(YEAR(Ped_header.fecha),"9999").
    que_dia = STRING(DAY(Ped_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Ped_header.fecha) ] + " de " + que_ano.
    
    RUN getparametro.p (  INPUT  "ANEXOPED",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    v-ley_anexo = v-observacion.

    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DE LA FACTURA                               */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO VALUE(arch_salida + ".XPR") CONVERT TARGET "iso8859-1".

    ncopia = 1.
    RUN imprimir.
    
    OUTPUT STREAM Formulario CLOSE.
     
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = arch_salida + ".XPR".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
/*  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */*/

       
    IF Ped_header.version = 0 THEN RUN despachar_mails.

    Ped_header.version = Ped_header.version + 1.
    
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE inicia_formulario:
    
    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.
    PUT STREAM Formulario CONTROL '<HTML-DIR=c:\sic-temp><HTML-Title=xPrint HTML interface><HTML-BGCOLOR=WHITE>'
                    '<HTML-LZW=FALSE><HTML>'.
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OLANDSCAPE><Title=Impresion de pedidos><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Letter>".
    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    
    PUT STREAM Formulario CONTROL "<AT=172,10><#2>".    

END PROCEDURE.

PROCEDURE imprimir:

    RUN inicia_formulario.
    
    RUN cabecera_forma.
    RUN cabecera_datos.
    
    RUN detalle_forma.
    RUN detalle_datos.

    RUN pie_forma.
    
    RUN pie_datos.

END PROCEDURE.

PROCEDURE cabecera_forma:
    
    RUN escribir ( INPUT "0,5", INPUT v-ley_anexo, INPUT 12, INPUT NO). 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+39,+225><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+44,+5><FROM><AT=+06,+225><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+50,+5><FROM><AT=+27,+225><RECT>". 
    
    RUN escribir ( "45,45", INPUT "CLIENTE", INPUT 10, INPUT YES).    
    RUN escribir ( "45,148", INPUT "DOMICILIO DE ENTREGA", INPUT 10, INPUT YES).    
    
    RUN escribir ( INPUT "22,10", INPUT Empresa.nombre, INPUT 12, INPUT NO). 
    RUN escribir ( INPUT "28,10", INPUT Punto-venta.direccion, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "28,145", INPUT "C.U.I.T.: " + Empresa.cuit, INPUT 8, INPUT NO). 

    RUN escribir ( INPUT "32,10", INPUT Punto-venta.localidad + " - " + Punto-venta.provincia, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "32,145", INPUT "Ingresos Brutos(Conv.Multil.): 902-871143-5", INPUT 8, INPUT NO). 

    RUN escribir ( INPUT "36,10", INPUT Punto-venta.telefono, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "36,145", INPUT "INICIO DE ACTIVIDADES 10/2002", INPUT 8, INPUT NO). 
    
    RUN escribir ( INPUT "39,160", INPUT v-reimpresion, INPUT 10, INPUT YES). 

    RUN escribir ( INPUT "40,10", INPUT "I.V.A. RESPONSABLE INSCRIPTO", INPUT 8, INPUT NO). 

    RUN escribir ( INPUT "7,93", INPUT "NOTA DE PEDIDO", INPUT 16, INPUT YES). 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+91><FROM><AT=+10,+52><RECT>". 
    RUN linea    ( "15,115", INPUT "35", "V" ).

    RUN escribir ( INPUT "6,172", INPUT "NRO.: ", INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "16,172", INPUT "FECHA: ", INPUT 12, INPUT YES).
    RUN escribir ( INPUT "20,172", INPUT "HOJA: ", INPUT 12, INPUT YES).
    
    RUN escribir ( INPUT "67,10", INPUT "C.U.I.T.:", INPUT 8, INPUT YES).
    RUN escribir ( INPUT "67,55", INPUT "I.BRUTOS:" , INPUT 8, INPUT NO).
    RUN escribir ( INPUT "67,135", INPUT "USUARIO:", INPUT 8, INPUT NO).

    RUN escribir ( INPUT "71,135", INPUT "TRANSP:" , INPUT 8, INPUT NO).


END PROCEDURE.

PROCEDURE detalle_forma:
    
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+78,+5><FROM><AT=+6,+225><RECT>". 
    
    RUN escribir ( "79,45", INPUT "DESCRIPCION", INPUT 8, INPUT YES).    
    
    RUN linea    ( "78,91", INPUT "6", "V" ).
    RUN escribir ( "79,93", INPUT "SABOR", INPUT 8, INPUT YES).

    RUN linea    ( "78,105", INPUT "6", "V" ).
    RUN escribir ( "79,108", INPUT "ARTICULO", INPUT 8, INPUT YES).

    RUN linea    ( "78,124", INPUT "6", "V" ).
    RUN escribir ( "79,133", INPUT "CANTIDAD", INPUT 8, INPUT YES).

    RUN linea    ( "78,153", INPUT "6", "V" ).
    RUN escribir ( "79,159", INPUT "GRANEL", INPUT 8, INPUT YES).

    RUN linea    ( "78,178", INPUT "6", "V" ).
    RUN escribir ( "79,180", INPUT "ENTREGA EL", INPUT 8, INPUT YES).

    RUN linea    ( "78,199", INPUT "6", "V" ).
    RUN escribir ( "79,203", INPUT "HASTA EL", INPUT 8, INPUT YES).

    /*
    RUN linea    ( "78,220", INPUT "6", "V" ).
    RUN escribir ( "79,224", INPUT "OBSERVACIONES", INPUT 8, INPUT YES).
    */
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+84,+5><FROM><AT=+53,+225><RECT>". 

END PROCEDURE.

PROCEDURE cabecera_datos:

    RUN escribir ( INPUT "6,185", INPUT Ped_header.tip_comprob + "-" + STRING(Ped_header.prf_comprob,"9999") + "-" + STRING(Ped_header.nro_comprob,"99999999"), INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "16,190", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT YES).
    RUN escribir ( INPUT "20,190", INPUT "1/1", INPUT 12, INPUT YES).
    RUN escribir ( INPUT "51,10", INPUT Cliente.nom_cliente, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "51,85", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "55,10", INPUT Cliente.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "59,10", INPUT "(" + Cliente.cdg_postal + ") " + Cliente.localidad, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "63,10", INPUT Provlegal.nombre , INPUT 8, INPUT NO).
    RUN escribir ( INPUT "63,85", INPUT "[" + Provlegal.cdg_provincia + "]", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "67,20", INPUT Cliente.cuit, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "67,65", INPUT Cliente.ing_brutos, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "71,10", INPUT "I.V.A." + Condicion_impos.texto, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "51,135", INPUT Domicilio.nombre, INPUT 8, INPUT YES).
    RUN escribir ( INPUT "51,210", INPUT "[" + STRING(Domicilio.nro_domicilio,"9999") + "]", INPUT 8, INPUT NO).
    RUN escribir ( INPUT "55,135", INPUT Domicilio.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "59,135", INPUT "(" + Domicilio.cdg_postal + ") " + Domicilio.localidad, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "63,135", INPUT Provincia.nombre, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "67,149", INPUT Usuario.nombre, INPUT 8, INPUT NO).


END PROCEDURE.

PROCEDURE detalle_datos:

    
    linea0 = 1.
    v-cantidad = 0.
    v-subtotal = 0.

    FOR EACH Ped_detalle OF Ped_header 
             WHERE Ped_detalle.cantidad <> 0 OR Ped_detalle.granel <> 0 OR TRUE,
                   Articulo OF Ped_detalle 
                   BREAK BY Ped_detalle.fecha_temprana BY Articulo.cdg_articulo /*
                         BY Ped_detalle.precio*/:

        FIND Unigranel WHERE Unigranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
        FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
        
        IF NOT Articulo.extendida
        THEN DO:
            
                ch_linea = STRING(84 + linea0 * 4,">>9").  
                
                FIND FIRST Articulo_atributo OF Articulo 
                     WHERE Articulo_atributo.cdg_tipoatributo = "SABOR"
                       AND Articulo_atributo.cdg_atributo = ENTRY(3,Articulo.cdg_articulo,"-")
                           NO-ERROR.
                FIND Atributo OF Articulo_atributo NO-LOCK.
    
                RUN escribir      ( ch_linea  + ",106", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",93",  INPUT Atributo.abreviatura, INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",10",  INPUT Articulo.descripcion, INPUT 8, INPUT NO).
                RUN escribenumero ( ch_linea  + ",127", INPUT STRING(Ped_detalle.cantidad,"ZZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",150", INPUT Unidad.abrevia, INPUT 8, INPUT NO).
                
                IF Articulo.unidxpres <> 0
                THEN DO:
                     v-equivale = Ped_detalle.cantidad / Articulo.unidxpres.
                     RUN escribenumero ( ch_linea  + ",153", INPUT STRING(v-equivale,"-ZZZZZZ9"), INPUT 8, INPUT NO).
                END.
                
             /* RUN escribir      ( ch_linea  + ",174", INPUT Unigranel.abrevia, INPUT 8, INPUT NO).                */
                RUN escribir      ( ch_linea  + ",182", INPUT STRING(Ped_detalle.fecha_temprana,"99/99/9999"), INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",203", INPUT STRING(Ped_detalle.fecha_tardia,"99/99/9999"), INPUT 8, INPUT NO).

                linea0 = linea0 + 1.
        
                v-cantidad = 0.
                v-subtotal = 0.
            END.
            ELSE DO:
                
                RUN RENGLONS.P (INPUT  Ped_detalle.detallada, 
                                INPUT  v-leng_detalle,
                                OUTPUT v-detallada,
                                INPUT  "|").

                DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
                    ch_linea = STRING(84 + linea0 * 4,">>9").                     
                    RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO).
                    IF j = NUM-ENTRIES(v-detallada,"|")
                    THEN DO:
                        v-cantidad = Ped_detalle.cantidad.
                        RUN escribenumero ( ch_linea  + ",128", INPUT STRING(v-cantidad,"ZZZ,ZZZ,ZZ9.99  ") + Unidad.abrevia, INPUT 8, INPUT NO).
                        RUN escribenumero ( ch_linea  + ",145", INPUT STRING(Ped_detalle.precio,"-ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
                        RUN escribenumero ( ch_linea  + ",166", INPUT STRING(Ped_detalle.subtotal_bruto,"-Z,ZZZ,ZZZ,ZZ9.99"), INPUT 8, INPUT NO).
                    END.
                    linea0 = linea0 + 1.
                END.
            
            END.
        
    END.

    IF Ped_header.leyenda <> ""
    THEN DO:   

        RUN RENGLONS.P (INPUT  Ped_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
        DO j = v-reng_leyenda TO 1 BY -1:
            ch_linea = STRING(126 + j * 3,">>9").                     
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-leyenda, "|"), INPUT 8, INPUT NO).
        END.

    END.

END PROCEDURE.

PROCEDURE pie_forma:

    PUT STREAM Formulario CONTROL "<AT=150,8><#1>".    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+2,+5><FROM><AT=+10,+225><RECT>". 
    RUN escribir ( "4,10",  INPUT "OBSERVACIONES:", INPUT 8, INPUT YES).
/*    
    RUN linea    ( "2,68",  INPUT "7", "V" ).

    RUN escribir ( "4,70",  INPUT "NO GRAVADO C/IVA:", INPUT 8, INPUT YES).
    RUN linea    ( "2,136", INPUT "7", "V" ).    
    RUN escribir ( "4,138", INPUT "SUBTOTAL:", INPUT 8, INPUT YES).

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+9,+5><FROM><AT=+7,+270><RECT>". 
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+7,+270><RECT>". 
    
    RUN escribir ( "11,14", INPUT "SUBTOTAL", INPUT 8, INPUT YES).
    
    RUN linea    ( "9,36", INPUT "14", "V" ).
    RUN escribir ( "11,44", INPUT "IMPUESTOS", INPUT 8, INPUT YES).
    
    RUN linea    ( "9,68", INPUT "14", "V" ).
    RUN escribir ( "11,77", INPUT "SUBTOTAL", INPUT 8, INPUT YES).

    RUN linea    ( "9,102", INPUT "14", "V" ).
    RUN escribir ( "11,112", INPUT "IVA " + STRING(prciva,">>9.99 %"), INPUT 8, INPUT YES).

    RUN linea    ( "9,136", INPUT "14", "V" ).    
    RUN escribir ( "11,140", INPUT "IVA N.I 10.5 %", INPUT 8, INPUT YES).

    RUN linea    ( "9,166", INPUT "14", "V" ).    
    RUN escribir ( "11,174", INPUT "TOTAL", INPUT 8, INPUT YES).
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+23,+5><FROM><AT=+7,+270><RECT>". 
    RUN escribir ( INPUT "25,10", INPUT "IMPRIME MASTELLONE HNOS S.A", INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "25,75", INPUT "C.A.I.: 22020024448233", INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "24,119", INPUT "FECHA DE VENCIMIENTO: 20/11/2003", INPUT 10, INPUT YES). 
*/
END PROCEDURE.

PROCEDURE pie_datos:
/*
    IF Ped_header.leyenda <> ""
    THEN DO:   
        
        RUN RENGLONS.P (INPUT  Ped_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
        
        linea0 = 1.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",10", INPUT ENTRY(j,v-leyenda, "|"), INPUT 10, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    END.

*/
    FIND FIRST  Cliente-observacion OF Cliente NO-ERROR.
    IF AVAILABLE Cliente-observacion
       THEN RUN escribir ( "4,37",  INPUT Cliente-observacion.titulo, INPUT 8, INPUT YES).


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

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FCourierNew><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + texto.
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM FORMULARIO UNFORMATTED linea.

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

    linea = '<FGCOLOR=' + textColor + '><FArial><P' + puntos + '>' +
            '<=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + 
             TRIM(STRING(i-columna,">>9.999999")) + '>' +
             ( IF negrita THEN '<B>' ELSE '')  + 
             texto + 
             ( IF negrita THEN '</B>' ELSE '' ). 
/*
    message linea view-as alert-box message title "plot".
*/    
    PUT STREAM Formulario UNFORMATTED linea.

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

    PUT STREAM Formulario UNFORMATTED linea.
    

END PROCEDURE.

PROCEDURE despachar_mails:

    DEFINE VARIABLE retCode    AS INT NO-UNDO.

    FOR EACH Copias_pedido WHERE Copias_pedido.nro_pedido = Ped_header.nro_pedido, Area OF Copias_pedido:

        RUN mail(    Area.reporte,
                    "Pedido Nro." + Ped_header.tip_comprob + "-"+ 
                                            STRING(Ped_header.prf_comprob,"9999") + "-" + 
                                            STRING(Ped_header.nro_comprob,"99999999"),
                    "Por favor, vea el archivo adjunto con los datos del pedido " + Ped_header.tip_comprob + "-"+ 
                                            STRING(Ped_header.prf_comprob,"9999") + "-" + 
                                            STRING(Ped_header.nro_comprob,"99999999"),
                    arch_salida + "1.htm",  		    /* files to send 	           */           
                    0,						/* show dialog window */
                    OUTPUT retCode).

        IF retCode <> 0 THEN MESSAGE "Error nùmero:" retCode VIEW-AS ALERT-BOX INFO TITLE "Error de mail".
    END.

END PROCEDURE.

PROCEDURE mail EXTERNAL "xpMail.dll":
    DEFINE INPUT  PARAMETER mailto		    AS CHAR.
    DEFINE INPUT  PARAMETER mailsubject		AS CHAR.
    DEFINE INPUT  PARAMETER mailText		AS CHAR.
    DEFINE INPUT  PARAMETER mailFiles		AS CHAR.
    DEFINE INPUT  PARAMETER mailDialog		AS LONG.
    DEFINE OUTPUT PARAMETER retCode		    AS LONG.
END.
