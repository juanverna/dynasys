/*suspender contrato*/
/* varia razones para suspender*/
/*cuotas impagas por contratos del mismo tipo*/
DEFINE VAR cimpv AS INT INITIAL 4 NO-UNDO.

{VRSHARED.I "NEW"}
DEFINE var tot_debitogr AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR tot_creditogr AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VAR impagas AS INT NO-UNDO.
DEFINE VAR moroso AS int NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
    OUTPUT TO "c:\temp\deuda.csv".
    EXPORT "Tipo" "Contrato" "Debito" "Credito" "Impag>60" "Moroso>120".
FOR EACH Contrato_hd 
    WHERE NOT cumplido and
          contrato_hd.estado = "A"  AND 
          TODAY<= Contrato_hd.rige_hasta AND
          NOT anulado AND 
          contrato_hd.fecha_baja = ? AND
          (( contrato_hd.cant_periodos<>0 AND contrato_hd.resto_periodos = 0 ) OR
          contrato_hd.cant_periodos=0 )
      ,    
          FIRST Cliente OF Contrato_hd NO-LOCK ,
          FIRST tipo_evento OF contrato_hd NO-LOCK,
          FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK
                               /*   BY administrador.nom_cliente
                                  BY cliente.direccion*/
                                  BY Contrato_hd.nro_contrato DESC:
    tot_debitogr = 0.
    tot_creditogr = 0.
    impagas = 0.
    moroso = 0.
  
    FOR EACH Cta_cte
      WHERE Cta_cte.nro_cliente = contrato_hd.nro_cliente AND Cta_cte.nro_contrato = contrato_hd.nro_contrato :
      IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
         THEN  tot_debitogr  = tot_debitogr + Cta_cte.debito.
         ELSE  tot_creditogr = tot_creditogr + Cta_cte.credito.
        FIND fac_header WHERE
          cta_cte.cdg_empresa = fac_header.cdg_empresa AND
          cta_cte.tip_comprob = fac_header.tip_comprob AND
          cta_cte.prf_comprob = fac_header.prf_comprob AND
          cta_cte.nro_comprob = fac_header.nro_comprob and
          Cta_cte.debito <> Cta_cte.credito NO-LOCK NO-ERROR.
        IF NOT AVAILABLE fac_header THEN next.
        IF fac_header.fecha < TODAY - 120 THEN moroso = moroso + 1.
        IF fac_header.fecha < TODAY - 60 THEN impagas = impagas + 1.
   END.
    IF tot_debitogr = tot_creditogr THEN DO:
        contrato_hd.cumplido = TRUE.
        NEXT.
    END.
    IF moroso > 0 OR impagas >= 2 THEN
    EXPORT contrato_hd.nro_tipo_evento contrato_hd.nro_contrato tot_debitogr tot_creditogr impagas moroso.
END.

