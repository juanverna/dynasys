/*=====================================================================================================*/
/*            HALLA EL TOTAL COBRADO PARA UNA FACTURA. SI ES UNA NOTA DE CREDITO, COBRADO = 0          */
/*=====================================================================================================*/

DEFINE INPUT PARAMETER     rid_factura   AS ROWID.
DEFINE INPUT PARAMETER     des_cobro     AS DATE.
DEFINE INPUT PARAMETER     has_cobro     AS DATE.
DEFINE OUTPUT PARAMETER    i-cobrado     AS DECIMAL.
DEFINE OUTPUT PARAMETER    signo         AS INTEGER.

/*=====================================================================================================*/
/*                                            VARIABLES                                                */
/*=====================================================================================================*/

{strdebitan.i}

/*=====================================================================================================*/
/*                                         BLOQUE PRINCIPAL                                            */
/*=====================================================================================================*/
FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.


OUTPUT TO value("c:\sic-temp\" + Fac_header.cdg_empresa + Fac_header.tip_comprob +
                                 STRING(Fac_header.prf_comprob,"9999") +
                                 STRING(Fac_header.nro_comprob,"99999999") + ".txt").

IF CAN-DO(str_debitan,Fac_header.tip_comprob)
THEN DO:

    signo = 1.
    i-cobrado = 0.
    FOR EACH Rec_detalle 
        WHERE Rec_detalle.cdg_emprecancela = Fac_header.cdg_empresa 
          AND Rec_detalle.tip_cancela      = Fac_header.tip_comprob 
          AND Rec_detalle.prf_cancela      = Fac_header.prf_comprob 
          AND Rec_detalle.nro_cancela      = Fac_header.nro_comprob,
          FIRST Rec_header OF Rec_detalle
                WHERE Rec_header.fecha <= has_cobro
                  AND Rec_header.fecha >= des_cobro
                  AND Rec_header.anulado = NO:

          
          IF Rec_header.tip_comprob BEGINS "R" 
          THEN do:
              
              PUT Rec_header.fecha        " "
                  Rec_header.tip_comprob  " "
                  Rec_header.prf_comprob  " "
                  Rec_header.nro_comprob  " "
                  Rec_detalle.importe      SKIP.

              i-cobrado = i-cobrado + Rec_detalle.importe.
          END.
    END. 
END.
ELSE DO:

    ASSIGN
        signo     = -1 /* Cambiamos signo de NC */
        i-cobrado = 0.
END.

OUTPUT CLOSE.
