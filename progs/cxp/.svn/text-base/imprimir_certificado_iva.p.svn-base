/*=================================================================================*/
/*               IMPRESION DE CERTIFICADO DE RETENCION DE GANANCIAS                */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_certificado AS ROWID.

DEFINE VARIABLE que_rutina             AS CHARACTER.
DEFINE VARIABLE ncopias                AS INTEGER.
DEFINE VARIABLE j                      AS INTEGER.

{VRSHARED.I}
{VPERSINM.I}

DO TRANSACTION:

    FIND Certificado_iva WHERE ROWID(Certificado_iva) = que_certificado EXCLUSIVE-LOCK.
    
    RUN getparametro.p (  INPUT  "NFRETIVA",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    que_rutina = "PRRTIVA" + STRING(v-valor_n, "999") + ".P".
    
    RUN getparametro.p (  INPUT  "NCOPRIVA",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    
    ncopias = v-valor_n.
    
    DO j = 1 TO ncopias:
       RUN VALUE(que_rutina) (INPUT que_certificado).
    END.
    
    Certificado_iva.emitido = YES.

END.
