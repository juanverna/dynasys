FUNCTION fnpendiente RETURN LOGICAL
    ( INPUT p-abierta AS LOGICAL,
      INPUT p-que_tipo AS CHARACTER, 
      INPUT p-que_estado AS CHARACTER /*LIKE Rendgastos_hd.cdg_estado*/):

    FIND FIRST Tipo_rendgastos 
         WHERE Tipo_rendgastos.cdg_tiporendgastos  = p-que_tipo
         NO-LOCK NO-ERROR.

    FIND Estados_autorizaciones WHERE Estados_autorizaciones.cdg_estado = p-que_estado NO-LOCK.
    
    IF Tipo_rendgastos.tipo = "F" 
        THEN IF p-abierta 
                THEN RETURN (      Estados_autorizaciones.es_anulacion = NO
                               AND Estados_autorizaciones.es_rechazo   = NO
                               AND Estados_autorizaciones.es_final     = NO 
                               AND Estados_autorizaciones.es_anticipo  = YES ).
                ELSE RETURN Estados_autorizaciones.es_cerrado.
        ELSE IF p-abierta
                THEN RETURN ( Estados_autorizaciones.es_anticipo  = YES  OR
                              Estados_autorizaciones.es_inicial = YES ).
                ELSE RETURN Estados_autorizaciones.es_cerrado. 

END FUNCTION.
