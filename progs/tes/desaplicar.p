/*funciones anexas*/
/*anul;acion de rendicion*/
FUNCTION pagado RETURNS CHARACTER
    ( /* parameter-definitions */ ) :
    /*------------------------------------------------------------------------------
      Purpose:  
        Notes:  
    ------------------------------------------------------------------------------*/
    DEFINE VAR paga AS CHAR NO-UNDO.
    FIND cta_cte WHERE
        cta_cte.cdg_empresa = fac_header.cdg_empresa AND
        cta_cte.tip_comprob = fac_header.tip_comprob AND
        cta_cte.prf_comprob = fac_header.prf_comprob AND
        cta_cte.nro_comprob = fac_header.nro_comprob NO-LOCK NO-ERROR.
    IF AVAILABLE cta_cte THEN 
    DO:
IF cta_cte.credito = 0 and cta_cte.debito = 0  then paga = "S".
else
        IF cta_cte.credito = 0 OR cta_cte.debito = 0 
            THEN paga = "N".
        ELSE IF cta_cte.credito = cta_cte.debito 
                THEN paga = "S".
            ELSE paga = "P".
    END.
    ELSE paga = "?".
     
    RETURN paga.

END FUNCTION.
/*=================================================================================*/
/*               DESAPLICA UNA RENDICION DE LA CUENTA CORRIENTE                    */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_rendicion      AS ROWID.
DEFINE INPUT PARAMETER BATCH AS LOGICAL.
DEFINE INPUT PARAMETER porque AS CHAR.

DEFINE BUFFER b-fac_header FOR fac_header.
DEFINE VAR puede_anular AS INTEGER NO-UNDO.
DEFINE VAR todook       AS logical NO-UNDO.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
{vrshared.i NEW }
DO TRANSACTION:

    FIND Rendicion_hd WHERE ROWID(Rendicion_hd) = rid_rendicion EXCLUSIVE-LOCK.
    todook = FALSE.
    FIND Caj_header WHERE Caj_header.nro_transaccion = Rendicion_hd.nro_transaccion EXCLUSIVE-LOCK.
    FOR EACH Caj_detalle OF Caj_header, FIRST Valor OF Caj_header EXCLUSIVE-LOCK:
        IF valor.estado <> "00" THEN DO:
            MESSAGE "No se puede anular la cobranza ya que los valores esta depositados o utilizados"  
                 "el numero interno es " valor.nro_valor " anotelo"
                 VIEW-AS ALERT-BOX error.
            IF USERID <> "Fernando" THEN
            UNDO,RETURN.
        END.
        ELSE
            DELETE Valor.
    END.

    /*anulamos debitos y creditos internos no cobrados en otra cobranza*/
    FOR EACH fac_header OF empresa WHERE fac_header.prf_comprob = 99 AND 
        NOT fac_header.anulado ,EACH fac_detalle WHERE fac_detalle.detallada = "RN-0000-" + STRING(rendicion_hd.nro_rendicion,"99999999"):
        IF pagado() = "S" THEN 
        do:
            MESSAGE "No se puede anular la cobranza ya que los creditos y debitos generados por la misma"  
                SKIP "han sido utilizados en otra cobranza" VIEW-AS ALERT-BOX error.
            RETURN.
        END.
    END.
    
    FOR EACH comprobante_rendicion EXCLUSIVE-LOCK OF Rendicion_hd , fac_header OF comprobante_rendicion EXCLUSIVE-LOCK:
    
        /* -------------------------------------------------- */
        /* Proceso de desaplicacion de la cuenta corriente    */
        /* Elimina el registro de Rec_header correspondiente  */
        /* -------------------------------------------------- */

        FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa     = fac_header.cdg_empresa
            AND Cta_cte.tip_comprob     = fac_header.tip_comprob 
            AND Cta_cte.prf_comprob     = fac_header.prf_comprob
            AND Cta_cte.nro_comprob     = fac_header.nro_comprob
            EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Cta_cte
            THEN 
        DO:
            IF lookup(SUBSTRING( Cta_cte.tip_comprob,1,1),"F,D") <> 0  THEN 
            DO: /*se cancela con recibos*/
                Cta_cte.credito = Cta_cte.credito - comprobante_rendicion.este_pago.
                /*eliminar los recibos*/
                FOR EACH rec_header WHERE
                    rec_header.nro_rendicion = rendicion_hd.nro_rendicion EXCLUSIVE-LOCK:
                    FOR EACH Rec_detalle OF Rec_header EXCLUSIVE-LOCK:    
                        DELETE Rec_detalle.
                    END.
            
                    FOR EACH Aplicacion_pagos OF Rec_header:
                        DELETE Aplicacion_pagos.
                    END.
                    FOR each Cta_cte WHERE Cta_cte.cdg_empresa     = rec_header.cdg_empresa
                        AND Cta_cte.tip_comprob     = rec_header.tip_comprob 
                        AND Cta_cte.prf_comprob     = rec_header.prf_comprob
                        AND Cta_cte.nro_comprob     = rec_header.nro_comprob
                        EXCLUSIVE-LOCK:
                        DELETE cta_cte.
                    END.
                    DELETE rec_header.
                END.
            END.
       
            ELSE 
            DO:
                /*se intentara anular el comprobate de debito de esta transaccion en el caso que ya se utilizo no se podra anular a transaccion*/
                FIND FIRST Cta_cte WHERE Cta_cte.cdg_empresa     = fac_header.cdg_empresa
                    AND Cta_cte.tip_comprob     = fac_header.tip_comprob 
                    AND Cta_cte.prf_comprob     = fac_header.prf_comprob
                    AND Cta_cte.nro_comprob     = fac_header.nro_comprob
                    EXCLUSIVE-LOCK NO-ERROR.
                IF AVAILABLE Cta_cte THEN 
                DO:
                    cta_cte.debito = 0.
                    FIND aplicacion_pagos WHERE
                        Aplicacion_pagos.tip_comprob      = cta_cte.tip_comprob AND
                        Aplicacion_pagos.prf_comprob      = cta_cte.prf_comprob AND
                        Aplicacion_pagos.nro_comprob      = cta_cte.nro_comprob EXCLUSIVE-LOCK .
                    IF NOT AVAILABLE aplicacion_pagos THEN 
                    DO:
                        MESSAGE "Error interno, no puede proseguir"
                            "no se encuentra el comprobante cancelatorio"
                            "de la cuenta corriente" VIEW-AS ALERT-BOX ERROR.
                        UNDO,LEAVE.
                    END.


                    FIND FIRST b-fac_header WHERE b-fac_header.cdg_empresa    = fac_header.cdg_empresa
                        AND b-fac_header.tip_comprob     = Aplicacion_pagos.tip_cancela
                        AND b-fac_header.prf_comprob     = Aplicacion_pagos.prf_cancela 
                        AND b-fac_header.nro_comprob     = Aplicacion_pagos.nro_cancela
                        EXCLUSIVE-LOCK.
                    FIND cta_cte WHERE Cta_cte.cdg_empresa = b-Fac_header.cdg_empresa
                        AND Cta_cte.nro_comprob = b-Fac_header.nro_comprob 
                        AND Cta_cte.prf_comprob = b-Fac_header.prf_comprob
                        AND Cta_cte.tip_comprob = b-Fac_header.tip_comprob EXCLUSIVE-LOCK.
                    DELETE Aplicacion_pagos.
                    Cta_cte.credito = 0. /*desasignar la NC*/
                    RELEASE cta_cte.
                    RUN anular_comprobante_cliente.p (ROWID(b-fac_header) , OUTPUT puede_anular ,BATCH).
                    IF puede_anular <> 0 THEN UNDO,LEAVE.
                    FIND fac_header_prv WHERE fac_header_prv.tip_comprob = "FH" AND
                        fac_header_prv.prf_comprob = 0 AND fac_header_prv.nro_comprob = rendicion_hd.nro_rendicion AND fac_header_prv.cdg_empresa = empresa.cdg_empresa NO-ERROR.
                    IF AVAILABLE fac_header_prv THEN DO:
                        FIND cta_cte_prv OF fac_header_prv NO-LOCK.
                        IF cta_cte_prv.credito <> 0 THEN UNDO,LEAVE.
                        RUN anular_comprobante_proveedor.p (INPUT ROWID(Fac_header_prv), OUTPUT puede_anular).
                        IF puede_anular <> 0 THEN UNDO,LEAVE.
                    END.
                END.
            END.
        END.
    END.

         
                 
    

    /*anular evento relacionado con la cobranza*/
    FIND evento WHERE Rendicion_hd.nro_evento = evento.nro_evento EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE evento THEN 
    DO:
        ASSIGN 
            evento.anulado = TRUE.
        FOR EACH recurso_agenda OF evento: 
            DELETE recurso_agenda. 
        END.
    END.

    ASSIGN 
        Caj_header.anulado        = YES
        Caj_header.estado         = "A"
        Rendicion_hd.st_tesoreria = "A"
        rendicion_hd.observacion = porque.
    
    RELEASE Rendicion_hd.
END.
