DEFINE VAR pok AS LOGICAL NO-UNDO.  

SESSION:IMMEDIATE-DISPLAY = TRUE.
DEFINE VAR habupdate AS LOGICAL INITIAL FALSE NO-UNDO.
DEFINE VAR nroc AS INT NO-UNDO.
DEFINE VAR prfc AS INT64 NO-UNDO.
DEFINE VAR tipc AS CHAR NO-UNDO.

FIND FIRST fac_header WHERE cdg_empresa = "P"  and fac_header.prf_comprob = 64 AND 
    ( LENGTH( fac_header.cai ) < 5 OR cai = "" ) 
     and tip_comprob = "CC" NO-ERROR.
IF NOT AVAILABLE fac_header THEN LEAVE.
nroc = fac_header.nro_comprob.
prfc = fac_header.prf_comprob.
tipc = fac_header.tip_comprob.
denuevo:
REPEAT:

FIND FIRST fac_header WHERE cdg_empresa = "P"  and fac_header.prf_comprob = prfc AND 
    ( fac_header.cai=? OR cai = "" ) 
     and tip_comprob = tipc AND nro_comprob = nroc NO-ERROR.
IF NOT AVAILABLE fac_header THEN LEAVE.
    
        display fac_header.nro_comprob.
        FIND fac_header_impuesto OF fac_header NO-ERROR.
        IF AVAILABLE fac_header_impuesto THEN DO:
            IF fac_header.imp_total - fac_header.imp_bruto - fac_header.imp_iva <> 0 THEN DO:
                fac_header.imp_iva = fac_header.imp_total - fac_header.imp_bruto.
                
                UPDATE  fac_header_impuesto.importe  fac_header.imp_iva.
                IF fac_header_impuesto.importe <> fac_header.imp_iva THEN STOP.
            END.
        END.
        PAUSE 0.
        IF habupdate THEN DO: 
            UPDATE fac_header.imp_iva LABEL "IVA" Fac_header_impuesto.monto_imponible LABEL "Imponible" Fac_header_impuesto.importe LABEL "Impuesto"
            fac_header.imp_bruto LABEL "Bruto"
                    fac_header.imp_iva  LABEL "IVA"
                    fac_header.imp_neto LABEL "Neto"
                    fac_header.imp_total LABEL "Total" WITH SIDE-LABELS.
            habupdate = FALSE.
            END.
RUN facturaelectronica.p(ROWID(fac_header),OUTPUT pok).
        IF fac_header.cai = "" THEN do:
            MESSAGE RETURN-VALUE VIEW-AS ALERT-BOX ERROR.
            habupdate = TRUE.
            UNDO ,RETRY.
        END.
         ELSE DO:
            display nro_comprob cai pok.
             PAUSE 0.
             nroc  = nroc + 1.
         END.
END.
