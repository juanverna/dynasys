/*===========================================================================================*/
/*                   LEVANTA UN MOVIMIENTO DE CAJA EN TABLAS TEMPORALES                      */
/*===========================================================================================*/   

DEFINE TEMP-TABLE T-Caj_header       NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Caj_detalle      NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caja-imputacion  NO-UNDO LIKE Caja-imputacion.
DEFINE TEMP-TABLE T-Cheque           NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-Valor            NO-UNDO LIKE Valor.

/*===========================================================================================*/
/*                                      PARAMETROS                                           */
/*===========================================================================================*/   

DEFINE INPUT PARAMETER p-nro_transaccion AS INTEGER.
DEFINE OUTPUT PARAMETER TABLE FOR T-Caj_header.
DEFINE OUTPUT PARAMETER TABLE FOR T-Caj_detalle.
DEFINE OUTPUT PARAMETER TABLE FOR T-Caja-imputacion.
DEFINE OUTPUT PARAMETER TABLE FOR T-Cheque.
DEFINE OUTPUT PARAMETER TABLE FOR T-Valor.

/*===========================================================================================*/
/*                                       PROCESOS                                            */
/*===========================================================================================*/   

FIND Caj_header WHERE Caj_header.nro_transaccion = p-nro_transaccion NO-LOCK.
CREATE T-Caj_header.
BUFFER-COPY Caj_header TO T-Caj_header.

FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion:
    CREATE T-Caja-imputacion.
    BUFFER-COPY Caja-imputacion TO T-Caja-imputacion.
END.

FOR EACH Caj_detalle OF Caj_header, Rubro OF Caj_detalle:
    CREATE T-Caj_detalle.
    BUFFER-COPY Caj_detalle TO T-Caj_detalle.
    CASE Rubro.tipo:
        WHEN "P" 
        THEN DO:
            FIND Cheque OF Caj_detalle NO-LOCK.
            CREATE T-Cheque.
            BUFFER-COPY Cheque TO T-Cheque.
        END.
        WHEN "V" 
        THEN DO:
            FIND Valor OF Caj_detalle NO-LOCK.
            CREATE T-Valor.
            BUFFER-COPY Valor TO T-Valor.
        END.

    END CASE.

END.
