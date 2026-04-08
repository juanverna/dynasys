/*comparacion facturas de dos fechas*/
DEFINE VAR f1d AS DATE INITIAL 11/01/2011 NO-UNDO .
DEFINE VAR f2d AS DATE INITIAL 11/01/2011 NO-UNDO .
DEFINE VAR f1h AS DATE INITIAL 11/30/2011 NO-UNDO .
DEFINE VAR f2h AS DATE INITIAL 11/30/2012 NO-UNDO .
DEFINE VAR nte AS INT NO-UNDO INITIAL 1.
{tt2xls.i}
DEFINE BUFFER administracion FOR cliente.
DEFINE TEMP-TABLE co
    FIELD cdg_cliente LIKE cliente.cdg_cliente
    FIELD nom_cliente LIKE cliente.nom_cliente
    FIELD precio1 LIKE fac_header.imp_total
    FIELD precio2 LIKE fac_header.imp_total
    FIELD admin LIKE cliente.cdg_cliente
    FIELD nro_cliente LIKE cliente.nro_cliente
    INDEX nro_cliente nro_cliente.
FOR EACH fac_header WHERE fac_header.fecha >=f1d AND
    fac_header.fecha <= f1h AND fac_header.nro_contrato <> 0:
    FIND contrato_hd OF fac_header NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN NEXT.
    IF contrato_hd.nro_tipo_evento <> nte THEN NEXT.
    FIND cliente OF fac_header NO-LOCK.
    FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK.
    FIND co WHERE co.nro_cliente = cliente.nro_cliente NO-ERROR.
    IF NOT AVAILABLE co THEN DO:
        CREATE co.
        ASSIGN co.nro_cliente = cliente.nro_cliente
            co.cdg_cliente = cliente.cdg_cliente
            co.admin = administracion.cdg_cliente
            co.nom_cliente = cliente.nom_cliente.
    END.
    co.precio1 = fac_header.imp_total.
END.
FOR EACH fac_header WHERE fac_header.fecha >=f2d AND
    fac_header.fecha <= f2h AND fac_header.nro_contrato <> 0:
    FIND contrato_hd OF fac_header NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_hd THEN NEXT.
    IF contrato_hd.nro_tipo_evento <> nte THEN NEXT.
    FIND cliente OF fac_header NO-LOCK.
    FIND administracion WHERE administracion.nro_cliente = cliente.nro_admin NO-LOCK.
    FIND co WHERE co.nro_cliente = cliente.nro_cliente NO-ERROR.
    IF NOT AVAILABLE co THEN DO:
        CREATE co.
        ASSIGN co.nro_cliente = cliente.nro_cliente
            co.cdg_cliente = cliente.cdg_cliente
            co.admin = administracion.cdg_cliente
            co.nom_cliente = cliente.nom_cliente.
    END.
    co.precio2 = fac_header.imp_total.
END.
RUN pTT2XLS                                                              
  ( INPUT TEMP-TABLE co:DEFAULT-BUFFER-HANDLE,                       
    INPUT 'c:\temp\compara.xls',                                               
    INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ). 
