/*determinal el canal de venta mas optimo para el cliente y tipo de evento*/
DEFINE INPUT PARAMETER pnro_cliente LIKE cliente.nro_cliente.
DEFINE INPUT PARAMETER pnro_tipo_evento LIKE evento.nro_tipo_evento.
DEFINE INPUT PARAMETER p-cdg_comprobante LIKE Tipo_puntovta.cdg_comprobante.
DEFINE OUTPUT PARAMETER pprf AS INT.
{findempresa.i}

FIND canal WHERE canal.nro_cliente = pnro_cliente AND 
                 canal.nro_tipo_evento = pnro_tipo_evento NO-LOCK NO-ERROR.
IF AVAILABLE canal THEN
    pprf = canal.cdg_puntovta.
ELSE DO:
        /*determinar en funcion de la carga el canal mas optimo entre los canales posibles*/
        /*no ahora*/
        pprf = 2.
    END.
FIND FIRST Tipo_puntovta 
        WHERE Tipo_puntovta.cdg_comprobante = p-cdg_comprobante
          AND Tipo_puntovta.cdg_empresa = Empresa.cdg_empresa
          AND Tipo_puntovta.cdg_puntovta = pprf
              NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Tipo_puntovta
    THEN DO:
        MESSAGE "NO SE ENCUENTRA EL PRIMER CENTRO EMISOR HABILITADO PARA ESTE COMPROBANTE O BIEN NO SE ENCUENTRA EL PREFERIDO"
                VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION- NO PROSIGA!!!!".
        pprf = 0.
        RETURN ERROR.
    END.

