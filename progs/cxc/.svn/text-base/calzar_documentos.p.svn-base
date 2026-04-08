/*===================================================================================================*/
/*         HACE EL CALCE POR ANTIGUEDAD DE LOS DOCUMENTOS DE CUENTA CORRIENTE DE CLIENTES            */
/*===================================================================================================*/

DEFINE INPUT PARAMETER p-que_cliente  LIKE Cliente.nro_cliente.
DEFINE INPUT PARAMETER p-que_empresa  LIKE Empresa.cdg_empresa.

/*===================================================================================================*/
/*                    DEFINICION DE VARIABLES BUFFERS Y TABLAS TEMPORARIAS                           */
/*===================================================================================================*/

{vrshared.i "new"}

DEFINE VARIABLE saldo_factura         AS DECIMAL.
DEFINE VARIABLE saldo_recibo          AS DECIMAL.
DEFINE VARIABLE fin_movimientos       AS LOGICAL.
DEFINE VARIABLE logact                AS LOGICAL INITIAL NO.

DEFINE BUFFER Contra FOR Cta_cte. 
DEFINE STREAM Seguimiento.

/*===================================================================================================*/
/*                                                PROCESO                                            */
/*===================================================================================================*/

FIND Cliente WHERE Cliente.nro_cliente = p-que_cliente NO-LOCK.
FIND Empresa WHERE Empresa.cdg_empresa = p-que_empresa NO-LOCK.

IF logact 
THEN DO:
     OUTPUT STREAM Seguimiento TO ".\QUEHACE.TXT".
     PUT STREAM Seguimiento UNFORMATTED "***:" Cliente.cdg_cliente Cliente.nom_cliente SKIP(2).
END.

DO TRANSACTION:
    FOR EACH Cta_cte OF Cliente 
        WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
          AND Cta_cte.debito <> Cta_cte.credito  
              EXCLUSIVE-LOCK:
    
        IF logact THEN PUT STREAM Seguimiento UNFORMATTED Cta_cte.cdg_empresa + " " +
                                        Cta_cte.tip_comprob + " " +   
                                        STRING(Cta_cte.prf_comprob,"9999")  + " " +
                                        STRING(Cta_cte.nro_comprob,"99999999") SKIP.

        fin_movimientos = NO.
        DO WHILE Cta_cte.debito <> Cta_cte.credito AND NOT fin_movimientos:
    
            IF CAN-DO(str_debitan,Cta_cte.tip_comprob) /* Factura, buscar recibo */
            THEN DO:
                 FIND FIRST Contra OF Cliente 
                      WHERE Contra.cdg_empresa = Empresa.cdg_empresa 
                        AND Contra.debito <> Contra.credito
                        AND NOT CAN-DO(str_debitan,Contra.tip_comprob)
                             EXCLUSIVE-LOCK NO-ERROR.
                    
                 IF AVAILABLE Contra
                 THEN DO:
                      saldo_factura = Cta_cte.debito - Cta_cte.credito.
                      saldo_recibo  = Contra.credito - Contra.debito.
                      Cta_cte.credito = Cta_cte.credito + MINIMUM(saldo_factura,saldo_recibo).
                      Contra.debito = Contra.debito  + MINIMUM(saldo_factura,saldo_recibo).
                      IF logact THEN PUT STREAM Seguimiento UNFORMATTED "    :" + Contra.cdg_empresa + " " + 
                                                      Contra.tip_comprob + " " +
                                                      STRING(Contra.prf_comprob,"9999") + " " + 
                                                      STRING(Contra.nro_comprob,"99999999") + " " +
                                             "Por $:" + STRING(MINIMUM(saldo_factura,saldo_recibo),"->>,>>>,>>9.99") SKIP.

                 END.
                 ELSE DO:
                      fin_movimientos = YES.
                      IF logact THEN PUT STREAM Seguimiento UNFORMATTED "    Fin Movs." SKIP.
                 END.
            END.
            ELSE DO:                                       /* Recibo, busca factura */
                 FIND FIRST Contra OF Cliente 
                      WHERE Contra.cdg_empresa = Empresa.cdg_empresa 
                        AND Contra.debito <> Contra.credito
                        AND CAN-DO(str_debitan,Contra.tip_comprob)
                             EXCLUSIVE-LOCK NO-ERROR.
                 IF AVAILABLE Contra
                 THEN DO:
                      saldo_recibo = Cta_cte.credito - Cta_cte.debito.
                      saldo_factura = Contra.debito - Contra.credito.
                      Cta_cte.debito = Cta_cte.debito + MINIMUM(saldo_factura,saldo_recibo).
                      Contra.credito = Contra.credito  + MINIMUM(saldo_factura,saldo_recibo).
                      IF logact THEN PUT STREAM Seguimiento UNFORMATTED "    :" + Contra.cdg_empresa + " " + 
                                                      Contra.tip_comprob + " " +
                                                      STRING(Contra.prf_comprob,"9999") + " " + 
                                                      STRING(Contra.nro_comprob,"99999999") + " " +
                                             "Por $:" + STRING(MINIMUM(saldo_factura,saldo_recibo),"->>,>>>,>>9.99") SKIP.

                 END.
                 ELSE DO:
                      fin_movimientos = YES.
                      IF logact THEN PUT STREAM Seguimiento UNFORMATTED "    Fin Movs." SKIP.
                 END.

            END.
    
        END.
    
    END.
END.
IF logact 
THEN DO:
    OUTPUT STREAM Seguimiento CLOSE.
    RUN VERESULT.W ( INPUT "C:\DESA\SIC\R3.1\DB\MAROTTA\QUEHACE.TXT",
                     INPUT 22).
END.                 
