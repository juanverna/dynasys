/*=================================================================================*/
/*              IMPRESION DE FORMULARIO DE FACTURACION TIPO A                      */
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

DEFINE VARIABLE v-cantidad     LIKE Sre_detalle.cantidad.

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
DEFINE VARIABLE importe_iva    LIKE Sre_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Sre_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

DEFINE VARIABLE v-imp_gravado  LIKE Sre_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-imp_exento   LIKE Sre_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-solicitante AS CHARACTER.
DEFINE VARIABLE v-autorizante AS CHARACTER.
/* DEFINE BUFFER Provlegal FOR Provincia. */

DEFINE STREAM Formulario.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

RUN LoadXprint.

DO TRANSACTION:

    FIND Sre_header WHERE ROWID(Sre_header) = rid_factura EXCLUSIVE-LOCK.
/*    
    FIND Punto-venta WHERE Punto-venta.cdg_empresa = Sre_header.cdg_empresa
                       AND Punto-venta.cdg_puntovta = Sre_header.prf_comprob
                           NO-LOCK.
                           
    FIND FIRST Vigencia_cai 
         WHERE Vigencia_cai.cdg_empresa = Sre_header.cdg_empresa
           AND Vigencia_cai.tip_comprob = Sre_header.tip_comprob
           AND Vigencia_cai.prf_comprob = Sre_header.prf_comprob
           AND Vigencia_cai.rige_hasta  >= Sre_header.fecha.
               NO-LOCK NO-ERROR.
    */
    
    FIND Empresa OF Sre_header NO-LOCK.
    FIND Destinatario   OF Sre_header NO-LOCK NO-ERROR.
/*     FIND Usuario OF Sre_header NO-LOCK. */

/*========================================================================*/

    FIND Area OF Sre_header NO-LOCK.
    FIND Deposito OF Sre_header NO-LOCK.

    FIND Destinatario OF Sre_header NO-LOCK.

    IF Destinatario.hab_cliente THEN
        FIND Cliente OF Destinatario NO-LOCK.
/*         FIND FIRST Provlegal OF Cliente NO-LOCK.       */
/*         FIND FIRST Condicion_impos OF Cliente NO-LOCK. */
/*         FIND FIRST Domicilio OF Cliente NO-LOCK.       */
/*         FIND FIRST Provincia OF Cliente NO-LOCK.       */
    ELSE IF Destinatario.hab_proveedor THEN
        FIND Proveedor OF Destinatario NO-LOCK.
    ELSE IF Destinatario.hab_deposito THEN
        FIND Deposito OF Destinatario NO-LOCK.
     
     FIND Empleado WHERE Empleado.nro_legajo = Sre_header.nro_empleado_sol. 
     v-solicitante = Empleado.nombre.

     FIND Empleado WHERE Empleado.nro_legajo = Sre_header.nro_empleado_aut. 
     v-autorizante = Empleado.nombre.

     FIND Motivo_retiro WHERE Motivo_retiro.cdg_motivo_retiro = Sre_header.cdg_motivo_retiro. 
     
/*========================================================================*/
    
    que_mes = STRING(MONTH(Sre_header.fecha_ingreso),"99").
    que_ano = STRING(YEAR(Sre_header.fecha_ingreso),"9999").
    que_dia = STRING(DAY(Sre_header.fecha_ingreso),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Sre_header.fecha_ingreso) ] + " de " + que_ano.
    
    /*---------------------------------------------------------------------------------*/
    /*                CUENTA LA CANTIDAD TOTAL DE HOJAS A IMPRIMIR                     */
    /*---------------------------------------------------------------------------------*/

    nt-lineas = 0.
    nt-hojas = 0.
    FOR EACH Sre_detalle OF Sre_header 
             WHERE Sre_detalle.cantidad <> 0 OR Sre_detalle.granel <> 0 OR TRUE:

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
    
    OUTPUT STREAM Formulario TO "c:\sic-temp\prsre103.xpr" CONVERT TARGET "iso8859-1".

    n-hoja = 1.
    RUN imprimir.
    
    OUTPUT STREAM Formulario CLOSE.
     
    OUTPUT TO TERMINAL.
    
    FILE-INFO:File-NAME = "c:\sic-temp\prsre103.xpr".
      
    RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
/*  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Segunda copia */*/
    
END.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          PROCEDIMIENTOS                                         */
/*=================================================================================*/

PROCEDURE imprimir:

    RUN inicia_formulario.
    
    RUN cabecera_forma.
    RUN detalle_forma.
    RUN pie_forma.

    RUN cabecera_datos.


    RUN detalle_datos.

    RUN pie_datos.


END PROCEDURE.

PROCEDURE inicia_formulario:

    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/.
 /* PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'. */
    
    PUT STREAM Formulario CONTROL "<OPORTRAIT><Title=Impresion de remitos><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=Letter>".
    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    
    PUT STREAM Formulario CONTROL "<AT=172,10><#2>".    

END PROCEDURE.

PROCEDURE cabecera_forma:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".

    RUN rectangulo ( INPUT "5,5,39,190" ).
    RUN rectangulo ( INPUT "44,5,3,190" ). 
    RUN rectangulo ( INPUT "47,5,27,190" ).

/*     PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+05,+5><FROM><AT=+39,+190><RECT>". */
/*     PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+44,+5><FROM><AT=+06,+190><RECT>". */
/*     PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+50,+5><FROM><AT=+27,+190><RECT>". */
/*     PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+77,+5><FROM><AT=+17,+190><RECT>". */
/*     PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+95,+5><FROM><AT=+7,+190><RECT>".  */
    
/*     RUN escribir ( "45,45", INPUT "DESTINATARIO", INPUT 10, INPUT YES). */
/*     RUN escribir ( "45,123", INPUT "REMITENTE", INPUT 10, INPUT YES).   */
    

    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+07,+13><#3><AT=+12,+60><IMAGE#3=.\imagenes\logo.bmp>".

    RUN escribir ( INPUT "22,10", INPUT Empresa.nombre, INPUT 12, INPUT NO).
    RUN escribir ( INPUT "28,10", INPUT Empresa.direccion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "28,105", INPUT "C.U.I.T.: " + Empresa.cuit, INPUT 8, INPUT YES).

    RUN escribir ( INPUT "32,10", INPUT Empresa.localidad + " - " + Empresa.provincia, INPUT 8, INPUT NO). 
    RUN escribir ( INPUT "32,105", INPUT "Ingresos Brutos(Conv.Multil.): 902-871143-5", INPUT 8, INPUT YES). 

    RUN escribir ( INPUT "36,10", INPUT Empresa.telefono, INPUT 8, INPUT NO). 
 /* RUN escribir ( INPUT "36,105", INPUT "INICIO DE ACTIVIDADES 10/2002", INPUT 8, INPUT NO). */
    
    RUN escribir ( INPUT "39,160", INPUT v-reimpresion, INPUT 10, INPUT YES). 

 /* RUN escribir ( INPUT "40,10", INPUT "I.V.A. RESPONSABLE INSCRIPTO", INPUT 8, INPUT NO). */

/*    RUN rectangulo ( INPUT "15,100,15,15" ).*/
    RUN linea    ( "5,100", INPUT "42", "V" ). 
                                                 
    RUN escribir ( INPUT "6,107", INPUT "SOLICITUD DE RETIRO", INPUT 12, INPUT YES). 
    RUN escribir ( INPUT "11,107", INPUT "NRO.: ", INPUT 12, INPUT YES). 

    RUN escribir ( INPUT "16,107", INPUT "FECHA: ", INPUT 12, INPUT YES).
    RUN escribir ( INPUT "16,165", INPUT "HOJA: ", INPUT 12, INPUT YES).
    
    RUN escribir ( INPUT "48,7", INPUT "Sector:" , INPUT 8, INPUT YES).
    RUN escribir ( INPUT "58,7", INPUT "Autorizante:" , INPUT 8, INPUT YES).    
    RUN escribir ( INPUT "68,7", INPUT "Solicitante:", INPUT 8, INPUT YES). 
    RUN escribir ( INPUT "48,80", INPUT "Estado:" , INPUT 8, INPUT YES).
    RUN escribir ( INPUT "58,80", INPUT "Deposito:" , INPUT 8, INPUT YES).
    RUN escribir ( INPUT "68,80", INPUT "Destinatario:" , INPUT 8, INPUT YES).
/*  RUN escribir ( INPUT "48,155", INPUT "Fecha Alta:" , INPUT 8, INPUT YES).*/
    RUN escribir ( INPUT "58,155", INPUT "Fecha Retiro:" , INPUT 8, INPUT YES).
    

    RUN rectangulo ( INPUT "74,5,10,190" ).
    RUN escribir ( INPUT "76,7", INPUT "Motivo:" , INPUT 8, INPUT YES).

    RUN rectangulo ( INPUT "84,5,10,190" ).
    RUN escribir ( INPUT "85,6", INPUT "Ovservacion:" , INPUT 8, INPUT YES).
    
    
 
    
    


/*     RUN escribir ( INPUT "80,10", INPUT "CONDICION DE VENTA:", INPUT 8, INPUT NO). */
/*     RUN escribir ( INPUT "80,110", INPUT "PEDIDO NRO.: ", INPUT 8, INPUT NO).      */
/*     RUN escribir ( INPUT "84,160", INPUT "O/C:", INPUT 8, INPUT NO).               */
/*                                                                                    */
/*     RUN escribir ( INPUT "84,110", INPUT "REMITO: ", INPUT 8, INPUT NO).           */
/*                                                                                    */
/*     RUN escribir ( INPUT "84,10", INPUT "VENCIMIENTO:", INPUT 8, INPUT NO).        */
/*                                                                                    */

END PROCEDURE.

PROCEDURE detalle_forma:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".

    RUN rectangulo ( INPUT "94,5,7,190" ).
    RUN rectangulo ( INPUT "101,5,150,190" ).

    RUN escribir ( "96,9", INPUT "ARTICULO", INPUT 8, INPUT YES).
        
    RUN linea    ( "94,27", INPUT "157", "V" ).
    RUN escribir ( "96,65", INPUT "DESCRIPCION", INPUT 8, INPUT YES).
    
    RUN linea    ( "94,124", INPUT "157", "V" ).
    RUN escribir ( "96,125", INPUT "Nº DE SERIE", INPUT 8, INPUT YES).

    RUN linea    ( "94,143", INPUT "157", "V" ).
    RUN escribir ( "96,144", INPUT "CANTIDAD", INPUT 8, INPUT YES).

    RUN linea    ( "94,159", INPUT "157", "V" ).
    RUN escribir ( "96,160", INPUT "RETORNO", INPUT 8, INPUT YES).

    RUN linea    ( "94,175", INPUT "157", "V" ).
    RUN escribir ( "96,176", INPUT "INVENTARIO", INPUT 8, INPUT YES).

 
END PROCEDURE.

PROCEDURE cabecera_datos:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".

    /*N escribir ( INPUT "7,94", INPUT "SRE", INPUT 16, INPUT YES).*/

    RUN escribir ( INPUT "11,120", INPUT STRING(Sre_header.prf_comprob,"9999") + "-" + STRING(Sre_header.nro_comprob,"99999999"), INPUT 12, INPUT YES).

    RUN escribir ( INPUT "16,124", INPUT que_dia + "/" + que_mes + "/" + que_ano, INPUT 12, INPUT YES).
    RUN escribir ( INPUT "16,180", INPUT TRIM(STRING(n-hoja,">>9")) + "/" + TRIM(STRING(nt-hojas,">>9")), INPUT 12, INPUT YES).

    IF AVAILABLE Cliente THEN
        RUN escribir ( INPUT "68,99", INPUT Cliente.nom_cliente, INPUT 8, INPUT NO).
    ELSE IF AVAILABLE Proveedor THEN
        RUN escribir ( INPUT "68,99", INPUT Proveedor.nombre, INPUT 8, INPUT NO).
    ELSE IF AVAILABLE Deposito THEN
        RUN escribir ( INPUT "68,99", INPUT Deposito.nombre, INPUT 8, INPUT NO).

    /*RUN escribir ( INPUT "48,171", INPUT Sre_header.fecha_ingreso, INPUT 8, INPUT NO).*/
    RUN escribir ( INPUT "58,174", INPUT Sre_header.fecha_retiro, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "48,18", INPUT Area.denominacion, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,95", INPUT Deposito.nombre, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "68,25", INPUT v-solicitante, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "58,25", INPUT v-autorizante, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "48,91", INPUT Sre_header.cdg_estado, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "76,19", INPUT Motivo_retiro.dsc_motivo_retiro, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "85,25", INPUT Sre_header.leyenda, INPUT 8, INPUT NO).


/*     RUN escribir ( INPUT "51,85", INPUT "[" + Cliente.cdg_cliente + "]", INPUT 8, INPUT NO).                      */
/*     RUN escribir ( INPUT "55,10", INPUT Cliente.direccion, INPUT 8, INPUT YES).                                   */
/*     RUN escribir ( INPUT "59,10", INPUT "(" + Cliente.cdg_postal + ") " + Cliente.localidad, INPUT 8, INPUT YES). */
/*     RUN escribir ( INPUT "63,10", INPUT Provlegal.nombre , INPUT 8, INPUT YES). */
/*     RUN escribir ( INPUT "63,85", INPUT "[" + Provlegal.cdg_provincia + "]", INPUT 8, INPUT NO). */
/*     RUN escribir ( INPUT "67,20", INPUT Cliente.cuit, INPUT 8, INPUT YES).                                            */
/*     RUN escribir ( INPUT "67,65", INPUT Cliente.ing_brutos, INPUT 8, INPUT YES).                                      */
/*     RUN escribir ( INPUT "71,10", INPUT "I.V.A." + Condicion_impos.texto, INPUT 8, INPUT NO).                         */
/*     RUN escribir ( INPUT "51,105", INPUT Domicilio.nombre, INPUT 8, INPUT YES).                                       */
/*     RUN escribir ( INPUT "55,105", INPUT Domicilio.direccion, INPUT 8, INPUT YES).                                    */
/*     RUN escribir ( INPUT "59,105", INPUT "(" + Domicilio.cdg_postal + ") " + Domicilio.localidad, INPUT 8, INPUT NO). */
/*     RUN escribir ( INPUT "63,105", INPUT Provincia.nombre, INPUT 8, INPUT NO).                                        */
/*     RUN escribir ( INPUT "63,175", INPUT "[" + Provincia.cdg_provincia + "]", INPUT 8, INPUT NO).                     */
/*                                                                                                                                 */
/*     RUN escribir ( INPUT "67,119", INPUT Usuario.nombre, INPUT 8, INPUT NO).                                                    */

/*     RUN escribir ( INPUT "80,42", INPUT Condicion_venta.descripcion, INPUT 8, INPUT NO). */
    
    
/*     IF AVAILABLE Ped_header                                                                                                                                                               */
/*     THEN DO:                                                                                                                                                                              */
/*          RUN escribir ( INPUT "80,130", INPUT Ped_header.tip_comprob + "-" + STRING(Ped_header.prf_comprob,"9999") + "-" + STRING(Ped_header.nro_comprob,"99999999"), INPUT 8, INPUT NO). */
/*     END.                                                                                                                                                                                  */

END PROCEDURE.

PROCEDURE detalle_datos:

    PUT STREAM Formulario CONTROL "<AT=14,8><#1>".    

    linea0 = 1.
    v-cantidad = 0.

    FOR EACH Sre_detalle OF Sre_header 
             WHERE Sre_detalle.cantidad <> 0 OR Sre_detalle.granel <> 0 OR TRUE,
                   Articulo OF Sre_detalle 
                   BREAK BY Articulo.cdg_articulo /*
                         BY Sre_detalle.precio*/:

        IF Sre_detalle.a_granel 
        THEN DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
             v-cantidad = Sre_detalle.granel.
        END.
        ELSE DO:
             FIND Unidad WHERE Unidad.cdg_umed = Articulo.cdg_umed NO-LOCK.
             v-cantidad = Sre_detalle.cantidad.
        END.
            

        RUN verificar_fin_hoja.

        IF NOT Articulo.extendida
        THEN DO:
                RUN verificar_fin_hoja.

                ch_linea = STRING(98 + linea0 * 4,">>9").  
                
                RUN escribir      ( ch_linea  + ",7", INPUT Articulo.cdg_articulo, INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",29",  INPUT Articulo.descripcion, INPUT 8, INPUT NO).
                RUN escribenumero ( ch_linea  + ",136", INPUT STRING(v-cantidad,"ZZZ9.99"), INPUT 8, INPUT NO).
                RUN escribir      ( ch_linea  + ",154", INPUT Unidad.abrevia, INPUT 8, INPUT NO). 
                RUN escribir      ( ch_linea  + ",160", INPUT STRING(Sre_detalle.fecha_retorno,"99/99/9999"), INPUT 8, INPUT NO).
                linea0 = linea0 + 1.
                v-cantidad = 0.
                
            END.
            ELSE DO:
                
/*                 RUN RENGLONS.P (INPUT  Sre_detalle.detallada,                                                                                 */
/*                                 INPUT  v-leng_detalle,                                                                                        */
/*                                 OUTPUT v-detallada,                                                                                           */
/*                                 INPUT  "|").                                                                                                  */
/*                                                                                                                                               */
/*                 DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):                                                                                     */
/*                     ch_linea = STRING(102 + linea0 * 4,">>9").                                                                                */
/*                     RUN escribir ( INPUT ch_linea  + ",10", INPUT ENTRY(j,v-detallada, "|"), INPUT 8, INPUT NO).                              */
/*                     IF j = NUM-ENTRIES(v-detallada,"|")                                                                                       */
/*                     THEN DO:                                                                                                                  */
/*                         RUN verificar_fin_hoja.                                                                                               */
/*                         v-cantidad = Sre_detalle.cantidad.                                                                                    */
/*                         RUN escribenumero ( ch_linea  + ",128", INPUT STRING(v-cantidad,"ZZZZZZ9.99  ") + Unidad.abrevia, INPUT 8, INPUT NO). */
/*                                                                                                                                               */
/*                     END.                                                                                                                      */
/*                     linea0 = linea0 + 1.                                                                                                      */
/*                 END.                                                                                                                          */
/*                                                                                                                                               */
            END.

            IF Articulo.es_registrable
            THEN DO:
                linea0 = linea0 - 1.
                FOR EACH Registrable-solicitud OF Sre_detalle, Registrable OF Registrable-solicitud:

                    ch_linea = STRING(98 + linea0 * 4,">>9").  

                    RUN escribir      ( ch_linea  + ",177", INPUT Registrable.cdg_registrable, INPUT 8, INPUT NO).
                    /*
                    RUN escribir      ( ch_linea  + ",7", INPUT , INPUT 8, INPUT NO).
                    RUN escribir      ( ch_linea  + ",29",  INPUT Articulo.descripcion, INPUT 8, INPUT NO).
                    */
                    linea0 = linea0 + 1.

                END.
            END.
        
    END.
    
    IF Sre_header.leyenda <> ""
    THEN DO:
                      
        linea0 = linea0 + 2.

        RUN RENGLONS.P (INPUT  Sre_header.leyenda, 
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

/*     RUN rectangulo ( INPUT "164,5,10,190" ).                                  */
/*     RUN escribir   ( "166,7", INPUT "MOTIVO DE ENTREGA:", INPUT 8, INPUT NO). */
    /*
    PUT STREAM Formulario UNFORMATTED "<=#1><BGCOLOR=WHITE><AT=+16,+5><FROM><AT=+7,+190" ).. 
    */

    
    
/* RUN rectangulo ( INPUT "174,5,36,190" ).                                */
/* RUN escribir ( "176,6", INPUT "TRANSPORTISTA:", INPUT 8, INPUT YES).    */
/* RUN escribir ( "185,6", INPUT "Razon Socia:l", INPUT 8, INPUT YES).     */
/* RUN escribir ( "191,6", INPUT "Domicilio:", INPUT 8, INPUT YES).        */
/* RUN escribir ( "197,6", INPUT "Chofer:", INPUT 8, INPUT YES).           */
/* RUN escribir ( "203,6", INPUT "Pantente:", INPUT 8, INPUT YES).         */
/* RUN escribir ( "194,80", INPUT "DNI:", INPUT 8, INPUT YES).             */
/* RUN escribir ( "200,80", INPUT "Nros. Precintos:", INPUT 8, INPUT YES). */
/* RUN escribir ( "185,140", INPUT "CUIT:", INPUT 8, INPUT YES).           */
/* RUN escribir ( "191,140", INPUT "I.B:", INPUT 8, INPUT YES).            */



/* RUN rectangulo ( INPUT "210,5,10,190" ).                                                                                        */
/* RUN escribir ( "213,7", INPUT "OBSERVACIONES:", INPUT 8, INPUT YES).                                                            */
/*                                                                                                                                 */
/* RUN rectangulo ( INPUT "220,5,46,190" ).                                                                                        */
/* RUN linea    ( "220,70.3", INPUT "46", "V" ).                                                                                   */
/* RUN linea    ( "220,130.6", INPUT "46", "V" ).                                                                                  */
/*                                                                                                                                 */
/* RUN escribir ( "221,30", INPUT "Remitente", INPUT 8, INPUT YES).                                                                */
/* RUN escribir ( "231,10", INPUT ".......................................................................", INPUT 8, INPUT YES).  */
/* RUN escribir ( "235,25", INPUT "Apellido y Nombre", INPUT 8, INPUT YES).                                                        */
/* RUN escribir ( "251,10", INPUT ".......................................................................", INPUT 8, INPUT YES).  */
/* RUN escribir ( "255,33", INPUT "legajo", INPUT 8, INPUT YES).                                                                   */
/*                                                                                                                                 */
/* RUN escribir ( "221,94", INPUT "Chofer", INPUT 8, INPUT YES).                                                                   */
/* RUN escribir ( "231,75", INPUT ".......................................................................", INPUT 8, INPUT YES).  */
/* RUN escribir ( "234,95", INPUT "Firma", INPUT 8, INPUT YES).                                                                    */
/* RUN escribir ( "244,75", INPUT ".......................................................................", INPUT 8, INPUT YES).  */
/* RUN escribir ( "247,92", INPUT "Aclaracion", INPUT 8, INPUT YES).                                                               */
/* RUN escribir ( "258,75", INPUT ".......................................................................", INPUT 8, INPUT YES).  */
/* RUN escribir ( "261,91", INPUT "Dni o Legajo", INPUT 8, INPUT YES).                                                             */
/*                                                                                                                                 */
/* RUN escribir ( "221,155", INPUT "Destinatario", INPUT 8, INPUT YES).                                                            */
/* RUN escribir ( "231,136", INPUT ".......................................................................", INPUT 8, INPUT YES). */
/* RUN escribir ( "235,158", INPUT "Firma", INPUT 8, INPUT YES).                                                                   */
/* RUN escribir ( "251,136", INPUT ".......................................................................", INPUT 8, INPUT YES). */
/* RUN escribir ( "255,155", INPUT "Aclaracion", INPUT 8, INPUT YES).                                                              */
/*                                                                                                                                 */
RUN escribir ( "270,5", INPUT "Imprime Mastellone Hermanos S.A", INPUT 8, INPUT YES).


RUN escribir ( "270,160", INPUT "C.A.I nº:", INPUT 8, INPUT YES).
RUN escribir ( "275,160", INPUT "Fecha Vto:", INPUT 8, INPUT YES).




END PROCEDURE.
 
PROCEDURE pie_datos:
            
    PUT STREAM Formulario CONTROL "<AT=235,8><#1>".    
    
    IF Sre_header.leyenda <> ""
    THEN DO:   
        
        RUN RENGLONS.P (INPUT  Sre_header.leyenda, 
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
        FILE-INFO:File-NAME = "c:\sic-temp\prsre103.xpr".
        RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
        n-hoja = n-hoja + 1.      
        OUTPUT STREAM Formulario TO "c:\sic-temp\prsre103.xpr" CONVERT TARGET "iso8859-1".
    
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

