/*=================================================================================*/
/*         IMPRESION DE FORMULARIO DE FACTURACION TIPO A                           */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.
/*
{VRSHARED.I}
{VPERSINM.I}
*/
{NOMMESES.I}

DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 20.
DEFINE VARIABLE linea0      AS INTEGER.

DEFINE VARIABLE que_dia     AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_mes     AS CHARACTER FORMAT "X(2)".
DEFINE VARIABLE que_ano     AS CHARACTER FORMAT "X(4)".
DEFINE VARIABLE f-titulo    AS CHARACTER FORMAT "X(75)".

FUNCTION nomcampo RETURNS CHARACTER (INPUT prefijo AS CHARACTER, INPUT k AS INTEGER).
    RETURN prefijo + STRING(k,"99"). 
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
    
    FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
    IF AVAILABLE Rem_header 
       THEN FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.
    
    que_mes = STRING(MONTH(Fac_header.fecha),"99").
    que_ano = STRING(YEAR(Fac_header.fecha),"9999").
    que_dia = STRING(DAY(Fac_header.fecha),"99").
    
    OUTPUT TO "./prl/prfaa920.txt".
  
    PUT "NOM," + Cliente.nom_cliente FORMAT "X(40)" SKIP.
    PUT "CUIT," + Cliente.cuit FORMAT "X(20)" SKIP.
    PUT "DIR," + Domicilio.direccion FORMAT "X(40)" SKIP.
    PUT "LOC," + "(" + Domicilio.cdg_postal + ") " +  
                 Domicilio.localidad FORMAT "X(40)" SKIP.
    PUT "CNV," + Condicion_venta.descripcion FORMAT "X(40)" SKIP.


    linea0 = 1.
    FOR EACH Fac_detalle OF Fac_header:
    
        IF Fac_detalle.detallada <> ""
            THEN RUN RENGLONS.P (INPUT  Fac_detalle.detallada, 
                                 INPUT  60,
                                 OUTPUT Fac_detalle.detallada,
                                 INPUT  "|").
        DO j = 1 TO NUM-ENTRIES(Fac_detalle.detallada, "|"):
        
            PUT nomcampo( INPUT "D", INPUT linea0 ) + ","
                        ENTRY(j,Fac_detalle.detallada, "|") FORMAT "X(60)" SKIP.

            IF j = NUM-ENTRIES(Fac_detalle.detallada, "|")
               THEN PUT nomcampo( INPUT "I", INPUT linea0 ) + ","
                        STRING(Fac_detalle.subtotal_neto,"->,>>>,>>9.99") FORMAT "X(20)" SKIP.

               ELSE PUT nomcampo( INPUT "I", INPUT linea0 ) + ",  " FORMAT "X(6)" SKIP.
    
            linea0 = linea0 + 1.

        END.

    END.

    nreng = linea0.
    DO linea0 = nreng TO nmax_det:
        PUT nomcampo( INPUT "D", INPUT linea0 ) + "," FORMAT "X(22)" SKIP.
        PUT nomcampo( INPUT "I", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
    END.

    RUN TOLETRAS.P (INPUT  Fac_header.imp_total, OUTPUT Fac_header.monto_letras ).
    RUN RENGLONS.P (INPUT  Fac_header.monto_letras, 
                    INPUT  90,
                    OUTPUT Fac_header.monto_letras,
                    INPUT  "|").

    PUT "ILE1," + ENTRY(1,Fac_header.monto_letras, "|") FORMAT "X(40)" SKIP.
    IF NUM-ENTRIES(Fac_header.monto_letras, "|") = 2
       THEN PUT "ILE2," + ENTRY(2,Fac_header.monto_letras, "|") FORMAT "X(40)" SKIP.
       ELSE PUT "ILE2,       "  FORMAT "X(40)" SKIP.



    IF Fac_header.leyenda <> ""
    THEN DO:    
        RUN RENGLONS.P (INPUT  Fac_header.leyenda, 
                        INPUT  90,
                        OUTPUT Fac_header.leyenda,
                        INPUT  "|").
    
        DO j = 1 TO 4:
            IF NUM-ENTRIES(Fac_header.leyenda, "|") >= j
               THEN PUT "LEY" + STRING(j,"9")+ "," + ENTRY(j,Fac_header.leyenda, "|") FORMAT "X(90)" SKIP.
               ELSE PUT "LEY" + STRING(j,"9")+ ", " FORMAT "X(90)" SKIP.
        END.
    END.

   
    PUT "BRUT," + STRING(Fac_header.imp_bruto,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "IIVA," + STRING(Fac_header.imp_iva,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
    PUT "ITOT," + STRING(Fac_header.imp_total,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.

    PUT "!PAGE!" SKIP.
    OUTPUT CLOSE.

    OS-COMMAND SILENT  ".\prl\proform .\prl\prfaa920.prn < .\prl\prfaa920.txt > .\prl\prfaa920.lst".
    OS-COMMAND SILENT  "copy .\prl\prfaa920.lst prn /b".
    
END.
