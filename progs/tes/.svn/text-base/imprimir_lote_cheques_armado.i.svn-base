PROCEDURE poner_campo:

    DEFINE INPUT PARAMETER p-fila         AS INTEGER.
    DEFINE INPUT PARAMETER p-columna      AS INTEGER.
    DEFINE INPUT PARAMETER p-posiciones   AS INTEGER.
    DEFINE INPUT PARAMETER p-valorstring  AS CHARACTER.
    DEFINE INPUT PARAMETER p-secuencia_1  AS CHARACTER.
    DEFINE INPUT PARAMETER p-secuencia_2  AS CHARACTER.
    DEFINE INPUT PARAMETER p-cdg_impresora LIKE Impresora.cdg_impresora.

    DEFINE VARIABLE x-sec_1 AS CHARACTER.
    DEFINE VARIABLE x-sec_2 AS CHARACTER.

    FIND T-Imagen_cheque WHERE T-Imagen_cheque.n-fila = p-fila NO-LOCK.

    IF p-secuencia_1 <> ""
    THEN DO:
        RUN traducir_lote_secuencias ( INPUT p-secuencia_1, INPUT p-cdg_impresora, OUTPUT x-sec_1 ).
        OVERLAY(T-Imagen_cheque.ch_linea,p-columna + T-Imagen_cheque.n-offset,LENGTH(x-sec_1)) = x-sec_1.
        T-Imagen_cheque.n-offset = T-Imagen_cheque.n-offset + LENGTH(x-sec_1).
    END.

    OVERLAY(T-Imagen_cheque.ch_linea,p-columna + T-Imagen_cheque.n-offset,p-posiciones) = p-valorstring.

    IF p-secuencia_2 <> ""
    THEN DO:
        RUN traducir_lote_secuencias ( INPUT p-secuencia_2, INPUT p-cdg_impresora, OUTPUT x-sec_2 ).
        OVERLAY(T-Imagen_cheque.ch_linea,p-columna + T-Imagen_cheque.n-offset + p-posiciones + 1,LENGTH(x-sec_2)) = x-sec_2.
        T-Imagen_cheque.n-offset = T-Imagen_cheque.n-offset + LENGTH(x-sec_2).
    END.    
    

END PROCEDURE.

PROCEDURE poner_secuencias:

    DEFINE INPUT PARAMETER p-secuencias    AS CHARACTER.
    DEFINE INPUT PARAMETER p-cdg_impresora LIKE Impresora.cdg_impresora.

    DEFINE VARIABLE x-sec AS CHARACTER.

    RUN traducir_lote_secuencias ( INPUT p-secuencias, INPUT p-cdg_impresora, OUTPUT x-sec ).
    PUT CONTROL x-sec.


END PROCEDURE.

PROCEDURE traducir_lote_secuencias:

    DEFINE INPUT PARAMETER  p-lista_secuencias  AS CHARACTER.
    DEFINE INPUT PARAMETER  p-cdg_impresora     LIKE Impresora.cdg_impresora.
    DEFINE OUTPUT PARAMETER p-codigos_ascii     AS CHARACTER.

    DEFINE VARIABLE j-sec AS INTEGER.
    DEFINE VARIABLE x-sec AS CHARACTER.

    DO j-sec = 1 TO NUM-ENTRIES(p-lista_secuencias,","):
        FIND Ctrl_impresora WHERE Ctrl_impresora.cdg_funcion = ENTRY(j-sec,p-lista_secuencias,",") 
                              AND Ctrl_impresora.cdg_impresora = p-cdg_impresora NO-LOCK.

       /* MESSAGE ctrl_impresora.cdg_impresora SKIP 
                ctrl_impresora.secuencia SKIP 
                ctrl_impresora.cdg_funcion
            VIEW-AS ALERT-BOX INFO BUTTONS OK. */

        p-codigos_ascii = p-codigos_ascii + Ctrl_impresora.secuencia.
    END.

END PROCEDURE.

PROCEDURE busco_lugar_pago:
    
    IF AVAILABLE Cheque THEN
    DO:
        FIND FIRST Opg_header 
             WHERE Opg_header.nro_transaccion = Cheque.nro_transaccion
             NO-LOCK NO-ERROR.
        IF AVAILABLE Opg_header THEN
           v-valorstring = STRING(Opg_header.cdg_lugar_pago).
        ELSE
           v-valorstring = "".
    END.
    ELSE
        v-valorstring = "9999".
    
END PROCEDURE.

PROCEDURE formateo_importe :

    DEFINE VARIABLE v-texto AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE largo   AS INTEGER    NO-UNDO.
    DEFINE VARIABLE largo_importe AS INTEGER    NO-UNDO.
    DEFINE VARIABLE indice  AS INTEGER    NO-UNDO.

    
    IF AVAILABLE cheque THEN
       v-valorstring = TRIM(STRING(Cheque.importe,">>>,>>>,>>>,>>9.99")).
    ELSE
       v-valorstring = TRIM(STRING(999999999999.99,">>>,>>>,>>>,>>9.99")).
    
    v-texto = "****************************************************".
    largo = Campo_modelocheque.n_campomodelo.
    largo_importe = LENGTH(v-valorstring).
    indice = largo - largo_importe + 1.
    SUBSTRING(v-texto,indice,largo_importe) = SUBSTRING(v-valorstring,1,largo_importe).
    v-valorstring = SUBSTRING(v-texto,1,largo).
    
END.
