/*=================================================================================*/
/*         ARMA EL STRING DE DETALLE EN UN MOVIMIENTO DE TESORERIA                 */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_detalle  AS ROWID.
DEFINE OUTPUT PARAMETER dtl_rubro    AS CHARACTER.

/*=================================================================================*/
/*                      B L O Q U E     P R I N C I P A L                          */
/*=================================================================================*/

FIND Caj_detalle WHERE ROWID(Caj_detalle) = rid_detalle NO-LOCK.
FIND Rubro OF Caj_detalle NO-ERROR.
dtl_rubro = "".
CASE Rubro.tipo:
   WHEN "D"
     THEN DO:
          dtl_rubro = "".
     END.
   WHEN "C"
     THEN DO:
          dtl_rubro = TRIM(STRING(Caj_detalle.divisas,"->,>>>,>>9.99")) + " * " +
                      TRIM(STRING(Caj_detalle.cambio,">>,>>9.9999")).
     END.
   WHEN "P"
     THEN DO:
          FIND Cheque OF Caj_detalle NO-LOCK.
          FIND Cuenta_bancaria OF Cheque NO-LOCK.
          FIND Banco OF Cuenta_bancaria NO-LOCK.
          ASSIGN
               OVERLAY(dtl_rubro,01,08) = STRING(Cheque.numero_cheque,"99999999")
               OVERLAY(dtl_rubro,11,26) = Banco.nombre
               OVERLAY(dtl_rubro,38,08) = STRING(Cheque.fecha_emision).

     END.
   WHEN "V"
     THEN DO:
          FIND Valor OF Caj_detalle NO-LOCK.
          FIND Banco OF Valor NO-LOCK.
          ASSIGN
               OVERLAY(dtl_rubro,01,08) = STRING(Valor.numero_cheque,"99999999")
               OVERLAY(dtl_rubro,11,26) = Banco.nombre
               OVERLAY(dtl_rubro,38,08) = STRING(Valor.fecha_emision).
     END.

   WHEN "A" 
     THEN DO:
          FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
          ASSIGN
               dtl_rubro = Cuenta_bancaria.cdg_cuenta_ban + " " +
                           Cuenta_bancaria.denominacion_cta.
     END.

   WHEN "B" 
     THEN DO:
          FIND Cuenta_bancaria OF Caj_detalle NO-LOCK.
          ASSIGN
               dtl_rubro = Cuenta_bancaria.cdg_cuenta_ban + " " +
                           Cuenta_bancaria.denominacion_cta.
     END.


   WHEN "R"
     THEN DO:
          dtl_rubro = Caj_detalle.observacion.
     END.

END CASE.
