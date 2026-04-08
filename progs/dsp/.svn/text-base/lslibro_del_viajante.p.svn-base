/*=================================================================================*/
/*                              LIBRO DEL VIAJANTE                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo      LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.
DEFINE INPUT PARAMETER des_cobro       AS DATE.
DEFINE INPUT PARAMETER has_cobro       AS DATE.
DEFINE INPUT PARAMETER v-lista_estados AS CHARACTER.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{xprint.i}

DEFINE VARIABLE TextColor              AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE bg-color               AS CHARACTER INITIAL "BLACK".
DEFINE VARIABLE gradiente              AS LOGICAL INITIAL NO.
DEFINE VARIABLE i                      AS INTEGER INITIAL 10.
DEFINE VARIABLE delta-f                AS INTEGER INITIAL 6.
DEFINE VARIABLE delta-c                AS INTEGER INITIAL 4.
DEFINE VARIABLE ncopia                 AS INTEGER.
DEFINE VARIABLE ancho                  AS DECIMAL INITIAL 1.0.

DEFINE VARIABLE que_comprobante        AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE que_factura            AS CHARACTER FORMAT "X(16)".

DEFINE VARIABLE tit_vendedor           AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE i-cobrado              AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE i-comiscobrado         AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE i-comisvendido         AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-cobrado              AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-vendido              AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-comiscobrado         AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-comisvendido         AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE signo                  AS DECIMAL.
DEFINE VARIABLE signo_pedido           AS DECIMAL.

DEFINE VARIABLE v-nom_vendedor         LIKE Vendedor.nombre.
DEFINE VARIABLE v-cuil_vendedor        AS CHARACTER FORMAT "X(13)".
DEFINE VARIABLE v-legajo_vendedor      AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE v-zona_vendedor        AS CHARACTER FORMAT "X(13)".
DEFINE VARIABLE v-productos_vendedor   AS CHARACTER FORMAT "X(8)".

DEFINE VARIABLE v-fchingreso_vendedor  AS DATE.
DEFINE VARIABLE v-sueldo_vendedor      LIKE Vendedor.imp_minimo. 
DEFINE VARIABLE v-comision_ventas      LIKE Vendedor.prc_ventas.
DEFINE VARIABLE v-comision_cobranzas   LIKE Vendedor.prc_cobranzas.
DEFINE VARIABLE n-pagina               AS INTEGER.
DEFINE VARIABLE n-linea                AS INTEGER.
DEFINE VARIABLE h-linea                AS INTEGER INITIAL 4.
DEFINE VARIABLE linea0                 AS INTEGER INITIAL 64.
DEFINE VARIABLE n-maxlinea             AS INTEGER INITIAL 30.
DEFINE VARIABLE ch_linea               AS CHARACTER.

DEFINE STREAM Formulario.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LoadXprint.

{findempresa.i}
SESSION:NUMERIC-FORMAT = "AMERICAN".        /* for the AT command. restore it if necessary */
RUN LISTAR_TODO.
IF n-linea <> 0 THEN RUN cerrar_hoja.

RUN UnLoadXprint.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FOR EACH Vendedor
     WHERE Vendedor.cdg_vendedor <= has_codigo
       AND Vendedor.cdg_vendedor >= des_codigo,
        EACH Ped_header OF Vendedor
              WHERE Ped_header.cdg_empresa = Empresa.cdg_empresa
                AND Ped_header.fecha <= has_fecha
                AND Ped_header.fecha >= des_fecha,
                      FIRST Estado_pedido OF Ped_header
                BREAK BY Vendedor.cdg_vendedor
                      BY Ped_header.cdg_empresa
                      BY Ped_header.fecha
                      BY Ped_header.tip_comprob
                      BY Ped_header.prf_comprob
                      BY Ped_header.nro_comprob:

       IF FIRST-OF(Vendedor.cdg_vendedor)
       THEN DO:

            IF n-linea <> 0 THEN RUN cerrar_hoja.

            ASSIGN
                v-nom_vendedor        = Vendedor.nombre
                v-cuil_vendedor       = Vendedor.nro_cuil
                v-legajo_vendedor     = STRING(Vendedor.nro_legajo)
                v-zona_vendedor       = Vendedor.zona_asignada 
                v-productos_vendedor  = Vendedor.tipo_productos
                v-fchingreso_vendedor = Vendedor.fecha_ingreso
                v-sueldo_vendedor     = Vendedor.imp_minimo 
                v-comision_ventas     = Vendedor.prc_ventas
                v-comision_cobranzas  = Vendedor.prc_cobranzas.

            RUN iniciar_hoja.

       END.

       que_comprobante = Ped_header.tip_comprob + " " + 
                         STRING(Ped_header.prf_comprob,"9999") + " " +
                         STRING(Ped_header.nro_comprob,"99999999").

       i-cobrado = 0.
       que_factura = "".

       IF Ped_header.cdg_estado = "CC"
       THEN DO:

            FIND Rem_header WHERE Rem_header.nro_pedido = Ped_header.nro_pedido NO-LOCK NO-ERROR.
            IF AVAILABLE Rem_header
            THEN DO: 

                FIND Fac_header WHERE Fac_header.nro_factura = Rem_header.nro_factura NO-LOCK NO-ERROR.
                IF AVAILABLE Fac_header
                THEN DO:

                    que_factura = Fac_header.tip_comprob + " " + 
                                  STRING(Fac_header.prf_comprob,"9999") + " " +
                                  STRING(Fac_header.nro_comprob,"99999999").

                    FOR EACH Rec_detalle 
                        WHERE Rec_detalle.cdg_emprecancela = Fac_header.cdg_empresa 
                          AND Rec_detalle.tip_cancela      = Fac_header.tip_comprob 
                          AND Rec_detalle.prf_cancela      = Fac_header.prf_comprob 
                          AND Rec_detalle.nro_cancela      = Fac_header.nro_comprob,
                          FIRST Rec_header OF Rec_detalle
                                WHERE Rec_header.fecha <= has_cobro
                                  AND Rec_header.fecha >= des_cobro:
                          
                          IF Rec_header.tip_comprob BEGINS "R" THEN i-cobrado = i-cobrado + Rec_detalle.importe.
             
                    END. 

                    i-cobrado = IF i-cobrado = Fac_header.imp_total 
                                   THEN Fac_header.imp_neto 
                                   ELSE i-cobrado * Fac_header.imp_neto / Fac_header.imp_total.
                    signo = IF LOOKUP(Fac_header.tip_comprob,str_debitan) <> 0 THEN 1 ELSE -1. /* Cambiamos signo de NC */
                    i-comisvendido = Fac_header.imp_neto * Vendedor.prc_ventas / 100.
                    i-comiscobrado = i-cobrado * Vendedor.prc_cobranzas / 100.

                    Ped_header.imp_neto = Fac_header.imp_neto.

                END.

            END.

            t-cobrado = t-cobrado + i-cobrado.
            t-comiscobrado = t-comiscobrado + i-comiscobrado.
     
            IF AVAILABLE Fac_header
            THEN DO:
                 t-vendido = t-vendido + Fac_header.imp_neto.        
                 t-comisvendido = t-comisvendido + i-comisvendido.        
            END.

       END.
       
       n-linea = n-linea + 1.
       IF n-linea > n-maxlinea
       THEN DO:
            RUN cerrar_hoja.
            RUN iniciar_hoja.
            n-linea = 1.
       END.

       ch_linea = STRING(linea0 + ( n-linea - 1 ) * h-linea,">>9").  

       IF FIRST-OF(Ped_header.fecha) 
          THEN RUN escribir ( INPUT ch_linea + ",16", INPUT STRING(Ped_header.fecha,"99/99/99"), INPUT 8, INPUT NO).

       RUN escribir ( INPUT ch_linea + ",36", INPUT que_comprobante, INPUT 8, INPUT NO).             
       RUN escribir ( INPUT ch_linea + ",66", INPUT Estado_pedido.descripcion, INPUT 8, INPUT NO).   
       RUN escribenumero ( INPUT ch_linea + ",93", INPUT STRING(Ped_header.imp_neto,"->>>,>>9.99"), INPUT 8, INPUT NO).

       IF AVAILABLE Fac_header AND Ped_header.cdg_estado = "CC"
       THEN DO:

            RUN escribir ( INPUT ch_linea + ",116", INPUT que_factura, INPUT 8, INPUT NO).       
            RUN escribenumero ( INPUT ch_linea + ",156", INPUT STRING(Fac_header.imp_neto,"->>>,>>9.99"), INPUT 8, INPUT NO).
            RUN escribenumero ( INPUT ch_linea + ",176", INPUT STRING(i-comisvendido,"->>>,>>9.99"), INPUT 8, INPUT NO).    
            IF i-cobrado <> 0
            THEN DO:   
                 RUN escribenumero ( INPUT ch_linea + ",196", INPUT STRING(i-cobrado,"->>>,>>9.99"), INPUT 8, INPUT NO).      
                 RUN escribenumero ( INPUT ch_linea + ",216", INPUT STRING(i-comiscobrado,"->>>,>>9.99"), INPUT 8, INPUT NO). 
            END.

       END.        
               
       IF LAST-OF(Vendedor.cdg_vendedor)
       THEN DO:

            n-linea = n-linea + 2.
            ch_linea = STRING(linea0 + ( n-linea - 1 ) * h-linea,">>9").  

            RUN escribir ( INPUT ch_linea + ",36", INPUT "Total " + Vendedor.nombre, INPUT 8, INPUT NO).             
            RUN escribenumero ( INPUT ch_linea + ",156", INPUT STRING(t-vendido,"->>>,>>9.99"), INPUT 8, INPUT NO).
            RUN escribenumero ( INPUT ch_linea + ",176", INPUT STRING(t-comisvendido,"->>>,>>9.99"), INPUT 8, INPUT NO).    
            RUN escribenumero ( INPUT ch_linea + ",196", INPUT STRING(t-cobrado,"->>>,>>9.99"), INPUT 8, INPUT NO).      
            RUN escribenumero ( INPUT ch_linea + ",216", INPUT STRING(t-comiscobrado,"->>>,>>9.99"), INPUT 8, INPUT NO). 

            n-pagina = n-pagina + 1.

            t-cobrado = 0.
            t-vendido = 0.        
            t-comiscobrado = 0.
            t-comisvendido = 0.        

       END.

    END.   

END PROCEDURE.  

PROCEDURE iniciar_hoja:

    OUTPUT STREAM Formulario TO "c:\sic-temp\libro.xpr" CONVERT TARGET "iso8859-1".

    n-pagina = n-pagina + 1.
    n-linea = 0.
    
    PUT STREAM Formulario CONTROL '<PREVIEW=70>' /*=ZoomToWidth>'*/. 
/*  PUT STREAM Formulario CONTROL '<TOOLBAR=!PRINT>'.  */
    
    PUT STREAM Formulario CONTROL "<OLANDSCAPE><Title=Impresión de Libro del Viajante><UNITS=mm><|2>".
    PUT STREAM Formulario CONTROL "<FORMAT=A4>".
    PUT STREAM Formulario CONTROL "<#1>".    

                   /* datos variables del encabezado */

    RUN escribir ( INPUT "18,140", INPUT STRING(des_fecha,"99/99/99") + " al " + STRING(has_fecha,"99/99/99"), INPUT 8, INPUT NO).
 
    RUN escribir ( INPUT "26,132", INPUT v-nom_vendedor, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "34,45",  INPUT v-zona_vendedor, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "34,170", INPUT v-productos_vendedor, INPUT 8, INPUT NO).

    RUN escribir ( INPUT "38,45",  INPUT v-cuil_vendedor, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "38,170", INPUT v-legajo_vendedor, INPUT 8, INPUT NO).
    RUN escribir ( INPUT "38,265", INPUT STRING(v-fchingreso_vendedor,"99/99/99") , INPUT 8, INPUT NO).

    RUN escribir ( INPUT "42,50",  INPUT STRING(v-sueldo_vendedor,">>>>9.99"), INPUT 8, INPUT NO).   
    RUN escribir ( INPUT "42,170", INPUT STRING(v-comision_ventas,"%>>9.9999"), INPUT 8, INPUT NO).
    RUN escribir ( INPUT "42,265", INPUT STRING(v-comision_cobranzas,"%>>9.9999"), INPUT 8, INPUT NO).

END PROCEDURE.

PROCEDURE cerrar_hoja:

  OUTPUT STREAM Formulario CLOSE.
  FILE-INFO:File-NAME = "c:\sic-temp\libro.xpr".
  RUN printFile( FILE-INFO:FULL-PATHNAME). /* Primera copia */
  
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

    linea = '<FGCOLOR=' + textColor + '><=#1><AT=+' + TRIM(STRING(i-linea,">>9")) + ',+' + TRIM(STRING(i-columna,">>9")) + '><FArial><P' + puntos + '>'.

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
    message linea view-as alert-box message title "plot".
*/    
    PUT STREAM Formulario UNFORMATTED linea.

END PROCEDURE.
