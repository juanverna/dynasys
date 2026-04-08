/*=================================================================================*/
/*                          IMPRESION DE CHEQUES                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER de_cuenta      LIKE Cuenta_bancaria.cdg_cuenta_ban.
DEFINE INPUT PARAMETER des_ncheque    LIKE Cheque.numero_cheque.
DEFINE INPUT PARAMETER has_ncheque    LIKE Cheque.numero_cheque.

DEFINE VARIABLE rutina AS CHARACTER.

DEFINE NEW SHARED STREAM lst-cheques.

FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = de_cuenta NO-LOCK.

rutina = "PRCHQ" + STRING(Cuenta_bancaria.cdg_banco,"999") + ".P".

OUTPUT STREAM lst-cheques TO PRINTER PAGE-SIZE 0.

FOR EACH Cheque OF Cuenta_bancaria EXCLUSIVE-LOCK
   WHERE Cheque.numero_cheque <= has_ncheque
     AND Cheque.numero_cheque >= des_ncheque
     AND Cheque.estado = "PP"
      BY Cheque.numero_cheque:
      
      RUN VALUE(rutina) ( INPUT ROWID(Cheque) ).
      
      Cheque.estado = "00".
      
END.      
      
OUTPUT CLOSE.
