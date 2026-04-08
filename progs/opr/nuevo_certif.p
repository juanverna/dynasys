/*nuevo certificado, busca el nuevo numero*/

DEFINE INPUT PARAM ftipo AS CHAR NO-UNDO.
DEFINE INPUT PARAM nrote AS INT NO-UNDO.
DEFINE OUTPUT PARAM ftipo2 AS CHAR NO-UNDO.
DEFINE OUTPUT PARAM nrocerti AS INT NO-UNDO.
DEFINE OUTPUT PARAM letraprefijo AS CHAR NO-UNDO.

    FOR EACH certificados WHERE certificados.tipo BEGINS ftipo AND /*recupero estampillas*/
        certificados.nro_tipo_evento = nrote AND
        certificados.nro_certificado = 0 AND 
        certificados.nro_desde = certificados.nro_hasta 
        BY  certificados.nro_desde:
            certificados.nro_certificado = certificados.nro_desde.
            LEAVE.
    END.
    IF NOT AVAILABLE certificados THEN DO: 
        FOR EACH certificados WHERE certificados.tipo BEGINS ftipo AND 
            certificados.nro_tipo_evento = nrote AND
            certificados.nro_certificado < certificados.nro_hasta AND
            certificados.nro_certificado >= certificados.nro_desde 
            BY certificados.nro_certificado:
                certificados.nro_certificado = certificados.nro_certificado + 1.
                LEAVE.
        END.
        IF NOT AVAILABLE certificados THEN DO: /*talonario nuevo*/
          FOR each certificados WHERE certificados.tipo BEGINS ftipo AND 
              certificados.nro_tipo_evento = nrote AND
              certificados.nro_certificado = 0 
              BY certificados.nro_desde:
                  certificados.nro_certificado = certificados.nro_desde.
                  LEAVE.
          END.
        END.
    END.
    IF NOT AVAILABLE certificados THEN DO:
        MESSAGE "No hay mas certificados" SKIP "no puede proseguir" VIEW-AS ALERT-BOX ERROR.
        RETURN ERROR.
    END.
    nrocerti = certificados.nro_certificado.
    letraprefijo = certificados.letraprefijo.
    ftipo2 = certificados.tipo.
