/*=================================================================================*/
/*              IMPRESION DE REMITO DE EGRESOS DE BIENES A PROVEEDORES             */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

{NOMMESES.I}
{xprint.i}

DEFINE VARIABLE TextColor      AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color       AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente      AS LOGICAL INITIAL NO.
DEFINE VARIABLE i              AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f        AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c        AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia         AS INTEGER.
DEFINE VARIABLE nt-lineas      AS INTEGER.
DEFINE VARIABLE nt-hojas       AS INTEGER.
DEFINE VARIABLE n-hoja         AS INTEGER.

DEFINE VARIABLE ancho          AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 25. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 85. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 135. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.
DEFINE VARIABLE lineal         AS INTEGER.

DEFINE VARIABLE v-cantidad     LIKE Rem_detalle_prv.cantidad.

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
DEFINE VARIABLE v-reimpresion  AS CHARACTER.

DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Rem_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Rem_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE v-imp_gravado  LIKE Rem_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-imp_exento   LIKE Rem_header_prv.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE nombre_copia   AS CHARACTER EXTENT 10 
    INITIAL ["Original","Duplicado","Triplicado","Cuadruplicado","Quinutplicado",
             "Sextuplicado","Septuplicado","Octuplicado","Nonuplicado","Decuplicado"].

DEFINE VARIABLE v-ingresante   AS CHARACTER.
DEFINE VARIABLE v-autorizante  AS CHARACTER.
DEFINE BUFFER Provlegal FOR Provincia.

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:
    FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_factura EXCLUSIVE-LOCK.   
    v-reimpresion = IF Rem_header_prv.impreso = "S" THEN "REIMPRESION" ELSE "". 
    
    FIND Punto-venta WHERE Punto-venta.cdg_empresa = Rem_header_prv.cdg_empresa  
                       AND Punto-venta.cdg_puntovta = Rem_header_prv.prf_comprob 
                           NO-LOCK NO-ERROR.                                 
    
    FIND Tipocomprobante OF Rem_header_prv NO-LOCK.
    FIND Empresa OF Rem_header_prv NO-LOCK.
    FIND Condicion_impos OF Rem_header_prv NO-LOCK.
    FIND Condicion_venta OF Rem_header_prv NO-LOCK.
    FIND Provincia OF Rem_header_prv NO-LOCK NO-ERROR.
    FIND Proveedor   OF Rem_header_prv NO-LOCK NO-ERROR.
    FIND Provlegal OF Proveedor NO-LOCK.    
    FIND Domicilio_prv OF Rem_header_prv NO-LOCK NO-ERROR.
    FIND usuario OF Rem_header_prv NO-LOCK.
    FIND Area OF Rem_header_prv NO-LOCK.
    v-ingresante = Area.denominacion.
    FIND Empleado WHERE Empleado.nro_legajo = Rem_header_prv.cdg_solicitante NO-LOCK .
    FIND Area WHERE Area.cdg_area = Empleado.cdg_seccion NO-LOCK.
    FIND Sre_header OF Rem_header_prv NO-LOCK. 
    FIND Motivo_retiro OF Sre_header NO-LOCK. 

    FIND Empleado WHERE Empleado.nro_legajo = Sre_header.nro_empleado_aut NO-LOCK .
    v-autorizante = Empleado.nombre.
    
    que_mes = STRING(MONTH(Rem_header_prv.fecha),"99").
    que_ano = STRING(YEAR(Rem_header_prv.fecha),"9999").
    que_dia = STRING(DAY(Rem_header_prv.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Rem_header_prv.fecha) ] + " de " + que_ano.
        
    Rem_header_prv.impreso = "S".    

    /*---------------------------------------------------------------------------------*/
    /*                CUENTA LA CANTIDAD TOTAL DE HOJAS A IMPRIMIR                     */
    /*---------------------------------------------------------------------------------*/

    nt-lineas = 0.
    nt-hojas = 0.
    FOR EACH Rem_detalle_prv OF Rem_header_prv 
             WHERE Rem_detalle_prv.cantidad <> 0 OR Rem_detalle_prv.granel <> 0 OR TRUE:

        nt-lineas = nt-lineas + 1.
        IF nt-lineas = nmax_det
        THEN DO:
             nt-lineas = 0.
             nt-hojas = nt-hojas + 1.
        END.

    END.
    IF nt-lineas <> 0 THEN nt-hojas = nt-hojas + 1.
     
    /*---------------------------------------------------------------------------------*/
    /*                          ENCABEZADO DEL REMITO                                  */
    /*---------------------------------------------------------------------------------*/
    
    SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\prrem103.xpr" CONVERT TARGET "iso8859-1".

    n-hoja = 1.
    RUN imprimir.
    
    OUTPUT STREAM Formulario CLOSE.
     
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = "c:\sic-temp\prrem103.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
/*  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */*/
    
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE imprimir:

    RUN inicia_formulario.
    
    DO ncopia = 1 TO 2:
        RUN cabecera_forma.
        RUN detalle_forma.
        RUN pie_forma.

        RUN cabecera_datos.
        RUN detalle_datos.
        RUN pie_datos.

        PUT STREAM Formulario CONTROL "<AT=5,189><#1>".   

    END.

END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */

    PUT STREAM Formulario CONTROL "<OLANDSCAPE><Title=Impresion de remitos><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Legal>".
    PUT STREAM Formulario CONTROL "<AT=5,15><#1>".   /* /// */
/*     PUT STREAM Formulario CONTROL "<AT=172,10><#2>". */

END PROCEDURE.

PROCEDURE cabecera_forma:

/*     PUT STREAM Formulario CONTROL "<AT=1,1><#2>". */

    RUN rectangulo ( INPUT "0,0,20,160" ).                                           
    RUN rectangulo ( INPUT "20,0,6,160" ).
    RUN rectangulo ( INPUT "26,0,20,160" ).
    
    RUN escribir ( "21,20", INPUT "DESTINATARIO", INPUT 8, INPUT YES).    
    RUN escribir ( "21,110", INPUT "REMITENTE", INPUT 8, INPUT YES).
    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+01,+01><#3><AT=+10,+30><IMAGE#3=.\imagenes\logo.bmp>".

RUN escribir ( INPUT "12,01", INPUT Empresa.nombre, INPUT 6, INPUT NO).   

    RUN escribir ( INPUT "17,01", INPUT "(" + Punto-venta.codigo_postal + ") " + Punto-venta.direccion + " " + Punto-venta.localidad + " - " + Punto-venta.provincia, INPUT 6, INPUT NO).
/* RUN escribir ( INPUT "17,01", INPUT Punto-venta.direccion, INPUT 6, INPUT NO). */
RUN escribir ( INPUT "13,95", INPUT "C.U.I.T.: " + Empresa.cuit, INPUT 6, INPUT NO). 
RUN escribir ( INPUT "12,70", INPUT "Documento no valido", INPUT 6, INPUT NO). 
RUN escribir ( INPUT "14,74", INPUT "como factura", INPUT 6, INPUT NO). 


/* RUN escribir ( INPUT "17,25", INPUT Punto-venta.localidad + " - " + Punto-venta.provincia, INPUT 6, INPUT NO).  */
RUN escribir ( INPUT "15,95", INPUT "Ingresos Brutos(Conv.Multil.): 902-871143-5", INPUT 6, INPUT NO). 

RUN escribir ( INPUT "15,01", INPUT Punto-venta.telefono, INPUT 6, INPUT NO). 
RUN escribir ( INPUT "15,18", INPUT "IVA: Responsable Inscripto", INPUT 6, INPUT NO).
RUN escribir ( INPUT "8,130", INPUT v-reimpresion, INPUT 10, INPUT YES). 

    RUN rectangulo ( INPUT "0,75,10,10" ).
    RUN linea    ( "20,80", INPUT "36", "V" ).
                                                 
    RUN escribir ( INPUT "0,90", INPUT Tipocomprobante.denominacion_impresa, INPUT 10, INPUT YES).

    RUN escribir ( INPUT "4,90", INPUT "Nº: ", INPUT 10, INPUT YES).
    RUN escribir ( INPUT "4,140", INPUT "Hoja: ", INPUT 10, INPUT YES).
    RUN escribir ( INPUT "8,90", INPUT "Fecha: ", INPUT 10, INPUT YES).
    RUN escribir ( INPUT "17,95", INPUT "Inicio de Actividades: 10/2002", INPUT 6, INPUT NO).
    /*
    RUN escribir ( INPUT "30,1", INPUT "DOMICILIO:", INPUT 8, INPUT YES).
    RUN escribir ( INPUT "34,1", INPUT "LOCALIDAD:" , INPUT 8, INPUT YES).
    */
    RUN escribir ( INPUT "38,1", INPUT "CUIT:" , INPUT 8, INPUT YES).
    RUN escribir ( INPUT "42,1", INPUT "CONDICION IVA:" , INPUT 8, INPUT YES).    
    RUN escribir ( INPUT "30,81", INPUT "SECTOR SOLICITANTE:", INPUT 8, INPUT YES). 
    RUN escribir ( INPUT "35,81", INPUT "SECTOR INGRESANTE:" , INPUT 8, INPUT YES).
    RUN escribir ( INPUT "40,81", INPUT "NRO DE SOLICITUD:" , INPUT 8, INPUT YES).

END PROCEDURE.

PROCEDURE detalle_forma:

/*     PUT STREAM Formulario CONTROL "<AT=14,8><#1>". */

    RUN rectangulo ( INPUT "46,0,7,160" ).
    RUN rectangulo ( INPUT "53,0,80,160" ).

    RUN escribir ( "48,3", INPUT "CODIGO", INPUT 7, INPUT YES).

    RUN linea    ( "46,15", INPUT "87", "V" ).
    RUN escribir ( "48,16", INPUT "DESCRIPCION", INPUT 7, INPUT YES).
    RUN linea    ( "46,80", INPUT "87", "V" ).
    RUN escribir ( "48,87", INPUT "CANTIDAD", INPUT 7, INPUT YES).

    RUN linea    ( "46,108", INPUT "87", "V" ).
    RUN escribir ( "48,112", INPUT "NUMERO DE SERIE", INPUT 7, INPUT YES).

    RUN linea    ( "46,139", INPUT "87", "V" ).
    RUN escribir ( "48,140", INPUT "F.RET.", INPUT 7, INPUT YES).

    RUN linea    ( "46,150", INPUT "87", "V" ).                  
    RUN escribir ( "48,152", INPUT "IDENT", INPUT 7, INPUT YES).  
 
    RUN escribeangulo ( "100,-05,90", INPUT nombre_copia [ ncopia ], INPUT 12, INPUT YES).  

    END PROCEDURE.

PROCEDURE cabecera_datos:

/*     PUT STREAM Formulario CONTROL "<AT=3,0><#2>". */

    RUN escribir ( INPUT "1,78", INPUT "R", INPUT 16, INPUT YES). 

    RUN escribir ( INPUT "4,95", INPUT STRING(Rem_header_prv.prf_comprob,"9999") + "-" + STRING(Rem_header_prv.nro_comprob,"99999999"), INPUT 10, INPUT YES). 
    RUN escribir ( INPUT "8,103", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 10, INPUT YES).
    RUN escribir ( INPUT "4,150", INPUT TRIM(STRING(n-hoja,">>9")) + "/" + TRIM(STRING(nt-hojas,">>9")), INPUT 10, INPUT YES).
    RUN escribir ( INPUT "26,1", INPUT Proveedor.nombre, INPUT 8, INPUT YES).  
/*     RUN escribir ( INPUT "51,85", INPUT "[" + Proveedor.cdg_proveedor + "]", INPUT 8, INPUT NO).  */
    RUN escribir ( INPUT "30,1", INPUT Rem_header_prv.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "34,1", INPUT "(" + Rem_header_prv.cdg_postal + ") " + Rem_header_prv.localidad, INPUT 8, INPUT NO).
/*     RUN escribir ( INPUT "63,10", INPUT Provlegal.nombre , INPUT 8, INPUT YES).                                                                                                           */
/*     RUN escribir ( INPUT "63,85", INPUT "[" + Provlegal.cdg_provincia + "]", INPUT 8, INPUT NO).                                                                                          */
    RUN escribir ( INPUT "38,12", INPUT Proveedor.cuit, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "30,113", INPUT v-ingresante, INPUT 8, INPUT NO).

/*     RUN escribir ( INPUT "67,65", INPUT Proveedor.ing_brutos, INPUT 8, INPUT YES).                                                                                                          */
    RUN escribir ( INPUT "42,26", INPUT "I.V.A." + Condicion_impos.texto, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "35,113", INPUT Area.denominacion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "40,113", INPUT  Rem_header_prv.nro_solicitud, INPUT 8, INPUT NO).
/*     RUN escribir ( INPUT "51,105", INPUT Domicilio_prv.nombre, INPUT 8, INPUT YES).                                                                                                           */
/*     RUN escribir ( INPUT "55,105", INPUT Domicilio_prv.direccion, INPUT 8, INPUT YES).                                                                                                        */
/*     RUN escribir ( INPUT "59,105", INPUT "(" + Domicilio_prv.cdg_postal + ") " + Domicilio_prv.localidad, INPUT 8, INPUT NO).                                                                     */
/*     RUN escribir ( INPUT "63,105", INPUT Provincia.nombre, INPUT 8, INPUT NO).                                                                                                            */
/*     RUN escribir ( INPUT "63,175", INPUT "[" + Provincia.cdg_provincia + "]", INPUT 8, INPUT NO).                                                                                         */
/*                                                                                                                                                                                           */
/*     RUN escribir ( INPUT "67,119", INPUT usuario.nombre, INPUT 8, INPUT NO).                                                                                                              */
/*                                                                                                                                                                                           */
/*     RUN escribir ( INPUT "80,42", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO).                                                                                                  */
/*     RUN escribir ( INPUT "84,170", INPUT Rem_header_prv.nro_ocm, INPUT 8, INPUT NO).                                                                                                          */
/*                                                                                                                                                                                           */
/*     FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header_prv.nro_pedido NO-LOCK NO-ERROR.                                                                                                 */
/*     IF AVAILABLE Ped_header                                                                                                                                                               */
/*     THEN DO:                                                                                                                                                                              */
/*          RUN escribir ( INPUT "80,130", INPUT Ped_header.tip_comprob + "-" + STRING(Ped_header.prf_comprob,"9999") + "-" + STRING(Ped_header.nro_comprob,"99999999"), INPUT 8, INPUT NO). */
/*     END.                                                                                                                                                                                  */

END PROCEDURE.
  
PROCEDURE detalle_datos:


/*  PUT STREAM Formulario CONTROL "<AT=14,8><#1>". */

    linea0 = 1.
    v-cantidad = 0.

    FOR EACH Rem_detalle_prv OF Rem_header_prv 
             WHERE Rem_detalle_prv.cantidad <> 0 OR Rem_detalle_prv.granel <> 0 OR TRUE, 
                   Articulo OF Rem_detalle_prv 
                   BREAK BY Articulo.cdg_articulo /*
                         BY Rem_detalle.precio*/:
     
        
        IF Rem_detalle_prv.a_granel
        THEN DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
             v-cantidad = Rem_detalle_prv.granel.
        END.
        ELSE DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
             v-cantidad = Rem_detalle_prv.cantidad.
        END.
        
        RUN verificar_fin_hoja.

        IF NOT Articulo.extendida
        THEN DO:
                    RUN verificar_fin_hoja.

            ch_linea = STRING(52 + linea0 * 3,">>9").
    
           

            RUN escribir      ( ch_linea  + ",1",   INPUT Articulo.cdg_articulo, INPUT 6, INPUT NO).
            RUN escribir      ( ch_linea  + ",16",  INPUT Articulo.descripcion, INPUT 5, INPUT NO).
            RUN escribenumero ( ch_linea  + ",75",  INPUT STRING(v-cantidad,"ZZZZZZ9.99"), INPUT 6, INPUT NO).
            /*
            RUN escribir      ( ch_linea  + ",94",  INPUT Articulo.cdg_umed, INPUT 6, INPUT NO).
            */
            RUN escribir      ( ch_linea  + ",94", INPUT Unidad.abrevia, INPUT 6, INPUT NO).
            
             
             IF Articulo.es_registrable
            THEN DO:
                


                FOR EACH Registrable-remprov OF Rem_detalle_prv,
                    FIRST Registrable OF Registrable-remprov:
                 


                    FIND FIRST Etiqueta 
                         WHERE Etiqueta.nro_articulo     = Articulo.nro_articulo
                           AND Etiqueta.nro_registrable  = Registrable-remprov.nro_registrable
                               NO-LOCK NO-ERROR.

                     IF AVAILABLE Etiqueta THEN DO:  

                    ch_linea = STRING(52 + linea0 * 3,">>9").
                    RUN escribenumero ( ch_linea  + ",143",  INPUT STRING(Etiqueta.num_etiqueta,"99999999"), INPUT 5, INPUT YES).
                    END.  


                    RUN escribir ( ch_linea  + ",109",  INPUT Registrable.nro_serie, INPUT 5, INPUT NO).

                                    FIND Sre_detalle WHERE Sre_detalle.nro_solicitud = Sre_header.nro_solicitud AND Sre_detalle.nro_articulo = Articulo.nro_articulo NO-LOCK NO-ERROR. 
                                    IF AVAILABLE Sre_detalle THEN DO:
                                    IF Sre_detalle.fecha_retorno <> DATE ("  /  /  ") 
                                    THEN RUN escribir ( ch_linea  + ",141",   INPUT Sre_detalle.fecha_retorno, INPUT 6, INPUT NO). 
                                    END.
                   linea0 = linea0 + 1.
                
               END.
            linea0 = linea0 + 1.
            END.
            ELSE DO:

                
                FIND FIRST Etiqueta 
                     WHERE Etiqueta.nro_articulo     = Articulo.nro_articulo
                       AND Etiqueta.nro_registrable  = 0
                           NO-LOCK NO-ERROR.

                IF AVAILABLE Etiqueta 
                    THEN  RUN escribenumero ( ch_linea  + ",143",  INPUT STRING(Etiqueta.num_etiqueta,"99999999"), INPUT 5, INPUT YES).
                    
                    

                FIND Sre_detalle WHERE Sre_detalle.nro_solicitud = Sre_header.nro_solicitud AND Sre_detalle.nro_articulo = Articulo.nro_articulo NO-LOCK NO-ERROR. 
                                IF AVAILABLE Sre_detalle THEN DO:
                                    IF Sre_detalle.fecha_retorno <> DATE ("  /  /  ") 
                                    THEN RUN escribir ( ch_linea  + ",141",   INPUT Sre_detalle.fecha_retorno, INPUT 6, INPUT NO). 
                                END.
                   linea0 = linea0 + 1.
            END.

        END.
        ELSE DO:
            
            RUN RENGLONS.P (INPUT  Rem_detalle_prv.detallada, 
                            INPUT  v-leng_detalle,
                            OUTPUT v-detallada,
                            INPUT  "|").

            DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
                ch_linea = STRING(52 + linea0 * 3,">>9").                     
                RUN escribir ( INPUT ch_linea  + ",16", INPUT ENTRY(j,v-detallada, "|"), INPUT 5, INPUT NO).
                IF j = 1 
                THEN DO:
                    RUN escribir      ( ch_linea  + ",1",   INPUT Articulo.cdg_articulo, INPUT 6, INPUT NO).
                    FIND FIRST Etiqueta 
                         WHERE Etiqueta.nro_articulo     = Articulo.nro_articulo
                           AND Etiqueta.nro_registrable  = 0
                               NO-LOCK NO-ERROR.
                    IF AVAILABLE Etiqueta
                    THEN RUN escribenumero ( ch_linea  + ",143",  INPUT STRING(Etiqueta.num_etiqueta,"99999999"), INPUT 5, INPUT YES).

                    FIND Sre_detalle WHERE Sre_detalle.nro_solicitud = Sre_header.nro_solicitud AND Sre_detalle.nro_articulo = Articulo.nro_articulo NO-LOCK NO-ERROR. 
                IF AVAILABLE Sre_detalle THEN DO:
                    IF Sre_detalle.fecha_retorno <> DATE ("  /  /  ") 
                    THEN RUN escribir ( ch_linea  + ",141",   INPUT Sre_detalle.fecha_retorno, INPUT 6, INPUT NO). 
                END.
             END.

                IF j = NUM-ENTRIES(v-detallada,"|")
                THEN DO:
                    RUN verificar_fin_hoja.
                    v-cantidad = Rem_detalle_prv.cantidad.
                    RUN escribenumero ( ch_linea  + ",75",  INPUT STRING(v-cantidad,"ZZZZZZ9.99"), INPUT 6, INPUT NO).
                    RUN escribir      ( ch_linea  + ",94", INPUT Unidad.abrevia, INPUT 6, INPUT NO).
                END.
                linea0 = linea0 + 1.
            END.
        
        END.
        
    END.
    
    IF Rem_header_prv.leyenda <> ""
    THEN DO:
                      
        linea0 = linea0 + 2.

        RUN RENGLONS.P (INPUT  Rem_header_prv.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-detallada,
                        INPUT  "|").
        
        DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
            
            RUN verificar_fin_hoja.
            ch_linea = STRING(102 + linea0 * 4,">>9").                     
            RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO).
            linea0 = linea0 + 1.

        END.

    END.

END PROCEDURE.

PROCEDURE pie_forma:

/*     PUT STREAM Formulario CONTROL "<AT=235,8><#1>". */

    RUN rectangulo ( INPUT "133,0,5,160" ).
    RUN escribir   ( "134,1", INPUT "MOTIVO DE ENTREGA:", INPUT 8, INPUT YES).
    /*
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+7,+190" ).. 
    */
    
    RUN rectangulo ( INPUT "138,0,20,160" ).
    RUN escribir ( "139,1", INPUT "TRANSPORTISTA", INPUT 8, INPUT YES).    
    RUN escribir ( "144,1", INPUT "Razon Social:", INPUT 8, INPUT YES).
    RUN escribir ( "144,110", INPUT "CUIT:", INPUT 8, INPUT YES).
    RUN escribir ( "147,1", INPUT "Domicilio:", INPUT 8, INPUT YES).
    RUN escribir ( "147,110", INPUT "I.B:", INPUT 8, INPUT YES).
    RUN escribir ( "150,1", INPUT "Chofer:", INPUT 8, INPUT YES).
    RUN escribir ( "150,80", INPUT "DNI:", INPUT 8, INPUT YES).
    RUN escribir ( "150,110", INPUT "Dominio:", INPUT 8, INPUT YES).
    RUN escribir ( "153,1", INPUT "Precintos:", INPUT 8, INPUT YES).
    
    RUN rectangulo ( INPUT "158,0,5,160" ).
    RUN escribir ( "159,1", INPUT "OBSERVACIONES:", INPUT 8, INPUT YES).
    
    RUN rectangulo ( INPUT "163,0,31,160" ).
    RUN linea    ( "163,53.3", INPUT "31", "V" ).
    RUN linea    ( "163,106.6", INPUT "31", "V" ).
    
    RUN escribir ( "164,18", INPUT "Remitente", INPUT 8, INPUT YES).
    RUN escribir ( "173,1", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "176,13", INPUT "Apellido y Nombre", INPUT 8, INPUT YES).
    RUN escribir ( "185,1", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "188,20", INPUT "legajo", INPUT 8, INPUT YES).
    
    RUN escribir ( "164,75", INPUT "Chofer", INPUT 8, INPUT YES).
    RUN escribir ( "171,54", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "174,76", INPUT "Firma", INPUT 8, INPUT YES).
    RUN escribir ( "179,54", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "182,73", INPUT "Aclaracion", INPUT 8, INPUT YES).
    RUN escribir ( "187,54", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "190,72", INPUT "Dni o Legajo", INPUT 8, INPUT YES).
    
    RUN escribir ( "164,125", INPUT "Destinatario", INPUT 8, INPUT YES).
    RUN escribir ( "173,107.6", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "176,129", INPUT "Firma", INPUT 8, INPUT YES).
    RUN escribir ( "185,107.6", INPUT ".................................................................", INPUT 8, INPUT YES).
    RUN escribir ( "188,126", INPUT "Aclaracion", INPUT 8, INPUT YES).
    
    RUN escribir ( "199,1", INPUT "Imprime Mastellone Hermanos S.A", INPUT 8, INPUT YES).
    
    RUN escribir ( "196,108", INPUT "C.A.I nº:", INPUT 10, INPUT YES).
    RUN escribir ( "200,108", INPUT "Fecha Vto:", INPUT 10, INPUT YES).


END PROCEDURE.
 
PROCEDURE pie_datos:
            
/*     PUT STREAM Formulario CONTROL "<AT=235,8><#1>". */
    
    IF Rem_header_prv.leyenda <> ""
    THEN DO:   
        
        RUN RENGLONS.P (INPUT  Rem_header_prv.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
        
        linea0 = 220.
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN RUN escribir ( INPUT TRIM(STRING(linea0,">>9")) + ",0", INPUT ENTRY(j,v-leyenda, "|"), INPUT 10, INPUT NO).
            linea0 = linea0 + 3.
        END.
    
    END.

    RUN escribir ( INPUT "134,35", INPUT Motivo_retiro.dsc_motivo_retiro, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "144,20", INPUT Rem_header_prv.nom_transportista, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "144,118", INPUT Rem_header_prv.cuit_transportista, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "147,15", INPUT Rem_header_prv.domicilio_transportista, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "147,115", INPUT Rem_header_prv.Ibrutos, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "150,12", INPUT Rem_header_prv.chofer, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "150,86", INPUT Rem_header_prv.dni_transportista, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "150,122", INPUT Rem_header_prv.patente, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "153,15", INPUT Rem_header_prv.precintos, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "159,28", INPUT Rem_header_prv.observacion, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "169,1", INPUT v-autorizante, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "181,1", INPUT Empleado.nro_legajo, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "196,122", INPUT Rem_header_prv.cai, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "199,127", INPUT STRING(Rem_header_prv.rige_hasta,"99/99/9999"), INPUT 14, INPUT NO).

    RUN escribebarra ( INPUT "197,50", INPUT STRING(Rem_header_prv.prf_comprob,"9999") + STRING(Rem_header_prv.nro_comprob,"99999999"), INPUT 9, INPUT no).

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

PROCEDURE verificar_fin_hoja:

    IF linea0 > nmax_det
    THEN DO:

        OUTPUT STREAM Formulario CLOSE.            
        FILE-INFO:File-NAME = "c:\sic-temp\prrem103.xpr".
        RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
        n-hoja = n-hoja + 1.      
        OUTPUT STREAM Formulario TO "c:\sic-temp\prrpv103.xpr" CONVERT TARGET "iso8859-1".
    
        RUN inicia_formulario.
        RUN cabecera_forma.
        RUN detalle_forma.
        RUN pie_forma.
        RUN cabecera_datos.
    
        linea0 = 1.

    END.

END PROCEDURE.

PROCEDURE rectangulo:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.

    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS DECIMAL.
    DEFINE VARIABLE i-alto          AS INTEGER.
    DEFINE VARIABLE i-ancho         AS DECIMAL.

    DEFINE VARIABLE offset          AS DECIMAL.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = DECIMAL(ENTRY(2,posicion,",")).

    i-alto    = INTEGER(ENTRY(3,posicion,",")).
    i-ancho   = DECIMAL(ENTRY(4,posicion,",")).


    linea = '<=#1><BGCOLOR=WHITE>' +
            '<AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' +
             TRIM(STRING(i-columna,">>9.999999")) + '><FROM><AT=+' +
             TRIM(STRING(i-alto,">>9")) + ',+' +
             TRIM(STRING(i-ancho,">>9")) + '><RECT>'.
/*
    message linea view-as alert-box message title "plot".
*/
  PUT STREAM Formulario UNFORMATTED linea.

    /*PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+39,+190><RECT>". */

END PROCEDURE.

PROCEDURE escribebarra:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).

    PUT STREAM Formulario UNFORMATTED "<=#1><AT=+" TRIM(STRING(i-linea,">>9")) ",+" TRIM(STRING(i-columna,'>>9')) "><#2>".
    PUT STREAM Formulario UNFORMATTED "<=#2><AT=+7,+55><#3>".
    PUT STREAM Formulario UNFORMATTED "<=#2><FROM><BARCODE#3,TYPE=2_5_interleaved,CHECKSUM=TRUE,VALUE="   texto ">".

END PROCEDURE.

PROCEDURE escribeangulo:

    DEFINE INPUT PARAMETER posicion AS CHARACTER.
    DEFINE INPUT PARAMETER texto    AS CHARACTER.
    DEFINE INPUT PARAMETER puntos   AS CHARACTER.
    DEFINE INPUT PARAMETER negrita  AS LOGICAL.
    
    DEFINE VARIABLE linea           AS CHARACTER.

    DEFINE VARIABLE i-linea         AS INTEGER.
    DEFINE VARIABLE i-columna       AS INTEGER.
    DEFINE VARIABLE i-angulo        AS INTEGER.

    i-linea   = INTEGER(ENTRY(1,posicion,",")).
    i-columna = INTEGER(ENTRY(2,posicion,",")).
    i-angulo  = INTEGER(ENTRY(3,posicion,",")).

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,"->>9")) + '><FCourierNew><P' + puntos + '>'.

    IF negrita THEN linea = linea + '<B>'.
    linea = linea + "<ANGLE=" + TRIM(STRING(i-angulo,"->>9")) + ">" + texto + "</ANGLE>".
    IF negrita THEN linea = linea + '</B>'.

    PUT STREAM FORMULARIO UNFORMATTED linea.

END PROCEDURE.
