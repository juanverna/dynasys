DEFINE VAR fdesde AS DATE LABEL "Desde" INITIAL 01/01/2014 .
DEFINE VAR fhasta AS DATE LABEL "Hasta" INITIAL 02/01/2014.
DEFINE VAR ar01f AS INT NO-UNDO.
UPDATE fdesde fhasta.
OUTPUT TO c:\temp\a.csv.
EXPORT DELIMITER ";" "Evento" "Direccion""Fecha" "Oblea" "Articulo".
FIND articulo WHERE articulo.cdg_articulo = "01f" NO-LOCK.
ar01f = articulo.nro_articulo.
FOR EACH evento NO-LOCK WHERE evento.frealizado >= fdesde AND 
    evento.frealizado <= fhasta AND
    NOT evento.anulado AND evento.nro_certif <> 0 AND evento.nro_tipo_evento = 1:
    FOR EACH contrato_dt NO-LOCK where contrato_dt.nro_contrato = evento.nro_identificacion and
        contrato_dt.nro_articulo <> ar01f, articulo NO-LOCK OF contrato_dt:
        FIND contrato_hd NO-LOCK OF contrato_dt.
        FIND cliente NO-LOCK OF contrato_hd.
        EXPORT DELIMITER ";" evento.nro_evento cliente.direccion  evento.frealizado Evento.LetraPrefijo + "-" + string(evento.nro_certif ) articulo.cdg_articulo.
        END.
END.
OUTPUT CLOSE.
MESSAGE "Archivo generado" view-as alert-box information.
