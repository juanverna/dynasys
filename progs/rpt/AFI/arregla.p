    /*
    DEFINE VAR p-des_fecha AS DATE INITIAL 03/01/2016.
    DEFINE VAR p-has_fecha AS DATE INITIAL 03/31/2016.
    FIND sic.articulo WHERE sic.articulo.cdg_articulo = "11".
    DEFINE VAR rr AS INT NO-UNDO.
    DEFINE buffer administrador FOR pauantes.cliente.
    FOR EACH pauantes.contrato_hd 
        WHERE pauantes.contrato_hd.estado = "A" AND NOT pauantes.contrato_hd.suspendido AND ( pauantes.contrato_hd.rige_desde <= p-has_fecha  
          AND pauantes.contrato_hd.rige_hasta >= p-des_fecha ) 
          AND ( pauantes.contrato_hd.primer_ano * 100 + pauantes.contrato_hd.primer_mes <= 2016 * 100 + 03 )
          AND ( pauantes.contrato_hd.resto_periodos > 0  ) and pauantes.contrato_hd.cant_periodos <> 0  
          NO-LOCK,
              FIRST pauantes.Cliente OF pauantes.contrato_hd NO-LOCK ,
              FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK
                                BREAK BY administrador.nom_cliente
                                      BY pauantes.cliente.direccion
                                      BY pauantes.contrato_hd.num_contrato :
        
        IF pauantes.contrato_hd.fecha_baja <> ? AND pauantes.contrato_hd.fecha_baja <= p-has_fecha THEN NEXT.
        
            
        FIND sic.contrato_hd WHERE ROWID(sic.contrato_hd ) = ROWID(pauantes.contrato_hd).

        IF pauantes.contrato_hd.resto_periodos - 1 = sic.contrato_hd.resto_periodos  AND
            CAN-FIND( sic.fac_header WHERE sic.fac_header.fecha >= 03/01/2016 AND 
                     sic.fac_header.nro_contrato = pauantes.contrato_hd.nro_contrato ) THEN NEXT.
        
        rr = rr +  1.

        FIND sic.fac_header WHERE sic.fac_header.fecha >= 03/01/2016 AND
            sic.fac_header.nro_contrato = pauantes.contrato_hd.nro_contrato NO-ERROR.
        IF AVAILABLE sic.fac_header  THEN DO:
            IF sic.fac_header.nro_comprob <> 14274 AND
               sic.fac_header.nro_comprob <> 14406 AND
                sic.fac_header.nro_comprob <> 14413 AND     
                sic.fac_header.nro_comprob <> 14436
                 THEN DO:
            FIND sic.fac_detalle OF sic.fac_header where sic.fac_detalle.nro_articulo = sic.articulo.nro_articulo.
            SUBSTRING( sic.fac_detalle.detallada , index(sic.fac_detalle.detallada ,"abono ") + 7 , 1 ) = 
              string(pauantes.contrato_hd.cant_periodos - pauantes.contrato_hd.resto_periodos + 1 ,"9" ).
            fac_header.impreso = "".
            sic.contrato_hd.resto_periodo = pauantes.contrato_hd.resto_periodo - 1.
            END.
        END.
        ELSE sic.contrato_hd.resto_periodo = pauantes.contrato_hd.resto_periodo.
        /*DISPLAY sic.contrato_hd.resto_periodos pauantes.contrato_hd.resto_periodos.*/


    END.                      
    DISPLAY rr.
    */
