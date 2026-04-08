/*=================================================================================*/
/*         IMPRESION DE FORMULARIO DE FACTURACION TIPO A                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

&GLOBAL-DEFINE MUDO SILENT

/*
{VRSHARED.I}
{VPERSINM.I}
*/

{NOMMESES.I}

DEFINE VARIABLE nmax_det       AS INTEGER INITIAL 20. /* Cantidad de lineas de detalle */
DEFINE VARIABLE v-leng_detalle AS INTEGER INITIAL 55. /* Ancho en chars del detalle    */

DEFINE VARIABLE v-reng_leyenda AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda AS INTEGER INITIAL 72. /* Ancho en chars de la leyenda  */

DEFINE VARIABLE v-reng_monto   AS INTEGER INITIAL 2.  /* Cantidad de lineas de monto   */
DEFINE VARIABLE v-leng_monto   AS INTEGER INITIAL 60. /* Ancho en chars del monto      */

DEFINE VARIABLE j              AS INTEGER.
DEFINE VARIABLE nreng          AS INTEGER.
DEFINE VARIABLE linea0         AS INTEGER.

DEFINE VARIABLE que_dia        AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes        AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano        AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE str_fecha      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE f-titulo       AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-detallada    AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-monto_letras AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE v-leyenda      AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE ltexto         AS CHARACTER FORMAT "X(75)".
DEFINE VARIABLE prciva         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE prcnoi         LIKE Impuesto.tasa FORMAT "ZZ9.99".
DEFINE VARIABLE importe_iva    LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi    LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".

FUNCTION nomcampo RETURNS CHARACTER (INPUT prefijo AS CHARACTER, INPUT k AS INTEGER).
    RETURN TRIM(prefijo + STRING(k,"99")). 
END FUNCTION.   

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

DO TRANSACTION:

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura EXCLUSIVE-LOCK.
    FIND Condicion_impos OF Fac_header NO-LOCK.
    FIND Condicion_venta OF Fac_header NO-LOCK.
    FIND Provincia OF Fac_header NO-LOCK.
    FIND Cliente   OF Fac_header NO-LOCK NO-ERROR.
    FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Fac_header NO-LOCK NO-ERROR.
    FIND Cobrador OF Cliente NO-LOCK.
    
    FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
    IF AVAILABLE Rem_header 
       THEN FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.

    FIND Impuesto 2 NO-LOCK.
    prcnoi = Impuesto.tasa.
    FIND FIRST Sub_detalle_vta OF Fac_header WHERE Sub_detalle_vta.nro_cuenta = Impuesto.nro_cuenta NO-ERROR.
    IF AVAILABLE Sub_detalle_vta 
        THEN importe_noi = Sub_detalle_vta.valor.
        ELSE importe_noi = 0.
    
    que_mes = STRING(MONTH(Fac_header.fecha),"99").
    que_ano = STRING(YEAR(Fac_header.fecha),"9999").
    que_dia = STRING(DAY(Fac_header.fecha),"99").
    str_fecha = que_dia + " de " + nom_mes [ MONTH(Fac_header.fecha) ] + " de " + que_ano.
        
    OUTPUT TO "./prl/faa918.txt".
  
    PUT "DD," + que_dia FORMAT "X(7)" SKIP.
    PUT "MM," + que_mes FORMAT "X(7)" SKIP.
    PUT "AA," + que_ano FORMAT "X(7)" SKIP.
    PUT "DMA," + que_dia + "/" + que_mes + "/" + que_ano FORMAT "X(15)" SKIP.
    PUT "FECH," + str_fecha FORMAT "X(35)" SKIP.

    PUT "NOM," + Cliente.nom_cliente FORMAT "X(40)" SKIP.
    PUT "CUIT," + Cliente.cuit FORMAT "X(20)" SKIP.
    PUT "DIR," + Domicilio.direccion FORMAT "X(40)" SKIP.
    PUT "LOC," + "(" + Domicilio.cdg_postal + ") " +  
                 Domicilio.localidad FORMAT "X(40)" SKIP.
    PUT "CNV," + Condicion_venta.descripcion FORMAT "X(40)" SKIP.
    PUT "CIV," + Condicion_impos.texto FORMAT "X(40)" SKIP.
    PUT "NCLI," + "[" + Cliente.cdg_cliente + "]" FORMAT "X(16)" SKIP.
    PUT "NCOB," + "[" + Cobrador.cdg_cobrador + "]" FORMAT "X(12)" SKIP.


    linea0 = 1.
    FOR EACH Fac_detalle OF Fac_header:
    
        IF Fac_detalle.detallada <> ""
            THEN RUN RENGLONS.P (INPUT  Fac_detalle.detallada, 
                                 INPUT  v-leng_detalle,
                                 OUTPUT v-detallada,
                                 INPUT  "|").
                                 
        DO j = 1 TO NUM-ENTRIES(v-detallada, "|"):
            
            ltexto = nomcampo( INPUT "D", INPUT linea0 ) + "," +
                        ENTRY(j,v-detallada, "|") .
                         
            PUT  ltexto FORMAT "X(90)" SKIP.

            IF j = NUM-ENTRIES(v-detallada, "|")
               THEN ltexto = nomcampo( INPUT "I", INPUT linea0 ) + "," +
                        STRING(Fac_detalle.subtotal_neto,"->>>,>>9.99").

               ELSE ltexto = nomcampo( INPUT "I", INPUT linea0 ) + ",  " .
    
            PUT ltexto FORMAT "X(16)" SKIP.
            linea0 = linea0 + 1.

        END.

    END.

    nreng = linea0.
    DO linea0 = nreng TO nmax_det:
        PUT nomcampo( INPUT "D", INPUT linea0 ) + "," FORMAT "X(22)" SKIP.
        PUT nomcampo( INPUT "I", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
    END.

    RUN RENGLONS.P (INPUT  Fac_header.monto_letras, 
                    INPUT  v-leng_monto,
                    OUTPUT v-monto_letras,
                    INPUT  "|").

    DO j = 1 TO v-reng_monto:
        IF j <= NUM-ENTRIES(v-monto_letras, "|")
           THEN PUT "ILE" + STRING(j,"9") +  "," + ENTRY(j,v-monto_letras, "|") FORMAT "X(90)" SKIP.
           ELSE PUT "ILE" + STRING(j,"9") +  ", "  FORMAT "X(90)" SKIP.
    END.

    IF Fac_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Fac_header.leyenda, 
                        INPUT  v-leng_leyenda,
                        OUTPUT v-leyenda,
                        INPUT  "|").
    
        DO j = 1 TO v-reng_leyenda:
            IF j <= NUM-ENTRIES(v-leyenda, "|")
               THEN PUT "LEY" + STRING(j,"9") + "," + ENTRY(j,v-leyenda, "|") FORMAT "X(90)" SKIP.
               ELSE PUT "LEY" + STRING(j,"9") + ", " FORMAT "X(90)" SKIP.
        END.
    END.
    ELSE DO:
        DO j = 1 TO v-reng_leyenda:
           PUT "LEY" + STRING(j,"9")+ ", " FORMAT "X(90)" SKIP.
        END.

    END.
   
    PUT "BRUT," + STRING(Fac_header.imp_neto,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "IIVA," + STRING(Fac_header.imp_iva,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "ITOT," + STRING(Fac_header.imp_total,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "INOI," + STRING(importe_noi,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "CTL," + STRING(Fac_header.prf_comprob,"9999") + " " + STRING(Fac_header.nro_comprob,"99999999") 
                 FORMAT "X(18)" SKIP.

    PUT "!PAGE!" SKIP.
    OUTPUT CLOSE.

    OS-COMMAND {&MUDO}  ".\prl\proform .\prl\faa918.prn < .\prl\faa918.txt > .\prl\faa918.lst".
    OS-COMMAND {&MUDO}  "copy .\prl\faa918.lst prn /b".
    OS-COMMAND {&MUDO}  "copy .\prl\faa918.lst prn /b". 
    
END.
