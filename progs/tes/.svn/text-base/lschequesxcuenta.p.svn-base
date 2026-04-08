/*=================================================================================*/
/*                  CHEQUES EMITIDOS DE UNA CUENTA BANCARIA                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_cuenta       LIKE Cuenta_bancaria.cdg_cuenta_ban.
DEFINE INPUT PARAMETER des_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER v-lista_estados  AS CHARACTER.
DEFINE OUTPUT PARAMETER p-xfile         AS CHAR NO-UNDO.

/*=================================================================================*/
/*                                VARIABLE                                         */
/*=================================================================================*/

DEFINE TEMP-TABLE TT-Cuenta_bancaria    LIKE Cuenta_bancaria.
DEFINE TEMP-TABLE TT-Cheque             LIKE Cheque.

{crystal_dyna.p}

/*=================================================================================*/
/*                              BLOQUE PRINCIPAL                                   */
/*=================================================================================*/

FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = que_cuenta NO-LOCK. 
FIND Empresa OF Cuenta_bancaria NO-LOCK.
CREATE TT-Cuenta_bancaria.
BUFFER-COPY Cuenta_bancaria TO TT-Cuenta_bancaria.
FOR EACH Cheque OF Cuenta_bancaria NO-LOCK WHERE LOOKUP(Cheque.estado,v-lista_estados) <> 0:
    CREATE TT-Cheque.
    BUFFER-COPY Cheque TO TT-Cheque.
END.

p-xfile = tempfile("") + ".xml".
RUN exportToXmlDset ( "dset", STRING(TEMP-TABLE TT-Cuenta_bancaria:HANDLE) + "," + 
                              STRING(TEMP-TABLE TT-Cheque:HANDLE), p-xfile).

