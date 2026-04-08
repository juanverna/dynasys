DEFINE INPUT PARAMETER nn AS INT NO-UNDO.
DEFINE TEMP-TABLE T-Fac_header_prv NO-UNDO LIKE Fac_header_prv.
DEFINE TEMP-TABLE T-Fac_detalle_prv NO-UNDO LIKE Fac_detalle_prv.         
DEFINE TEMP-TABLE T-Sub_header_prv NO-UNDO LIKE Sub_header_prv.          
DEFINE TEMP-TABLE T-Sub_detalle_prv NO-UNDO LIKE Sub_detalle_prv.        
DEFINE TEMP-TABLE T-Fac_header_prv_bon NO-UNDO LIKE Fac_header_prv_bon.
DEFINE TEMP-TABLE T-Fac_detalle_prv_bon NO-UNDO LIKE Fac_detalle_prv_bon.
DEFINE TEMP-TABLE T-Fac_header_prv_impuesto NO-UNDO LIKE Fac_header_prv_impuesto. 
DEFINE TEMP-TABLE T-Fac_detalle_prv_impuesto NO-UNDO LIKE Fac_detalle_prv_impuesto.
DEFINE TEMP-TABLE T-Asn_header NO-UNDO LIKE  Asn_header.     
DEFINE TEMP-TABLE T-Asn_detalle NO-UNDO like Asn_detalle.    
DEFINE TEMP-TABLE T-Asn_totales NO-UNDO LIKE Asn_totales.   
DEFINE VAR ll AS INT64 NO-UNDO.
{findempresa.i}
FIND FIRST moneda NO-LOCK.
FIND Tipocomprobante 
        WHERE Tipocomprobante.cdg_empresa     = empresa.cdg_empresa
          AND Tipocomprobante.cdg_comprobante = "FAHATPRO" NO-LOCK.
FIND FIRST Comprobante_concepto OF Tipocomprobante NO-LOCK.
FIND Imputacion OF Comprobante_concepto NO-LOCK.
             
FIND articulo WHERE cdg_articulo = "DEVHAT" NO-LOCK.
FIND rubro WHERE rubro.cdg_rubro = 100 NO-LOCK.

FIND caj_header WHERE caj_header.nro_transaccion = nn.
FIND rendicion_hd  OF caj_header NO-LOCK.
IF rendicion_hd.st_tesoreria = "A" THEN leave.
FIND cliente OF caj_header NO-LOCK.
FIND domicilio OF cliente NO-LOCK.

FIND proveedor WHERE proveedor.nombre = cliente.nom_cliente NO-ERROR.
    IF NOT AVAILABLE proveedor THEN DO:
        CREATE proveedor.
        BUFFER-COPY cliente EXCEPT convenio_sino TO proveedor
            ASSIGN Proveedor.nombre = cliente.nom_cliente
                   proveedor.cdg_proveedor = cliente.cdg_cliente
                   Proveedor.nro_proveedor = NEXT-VALUE(proximo_proveedor)
                   proveedor.cdg_famprove = "0005"
                   Proveedor.dfl_cndventa = "0"
                   proveedor.cdg_condiva = 08
                   proveedor.dfl_cndventa = "00".
        FIND FIRST domicilio_prv OF proveedor NO-ERROR.
        IF NOT AVAILABLE domicilio_prv THEN DO:
            CREATE domicilio_prv.
            BUFFER-COPY domicilio TO domicilio_prv
                ASSIGN domicilio_prv.nro_proveedor = proveedor.nro_proveedor
                       domicilio_prv.nro_domicilio = 1.
        END.
    END.
    FIND FIRST domicilio_prv OF proveedor NO-LOCK.
    FIND Familia_proveedor OF Proveedor NO-LOCK.
    EMPTY TEMP-TABLE T-Fac_detalle_prv.
    EMPTY TEMP-TABLE T-Fac_header_prv.
    EMPTY TEMP-TABLE T-Fac_header_prv_bon.
    EMPTY TEMP-TABLE T-Fac_detalle_prv.
    EMPTY TEMP-TABLE T-Fac_detalle_prv_bon.
    EMPTY TEMP-TABLE T-Fac_header_prv.
    EMPTY TEMP-TABLE T-Sub_detalle_prv.
    EMPTY TEMP-TABLE T-Sub_header_prv.
    EMPTY TEMP-TABLE T-Asn_header.
    EMPTY TEMP-TABLE T-Asn_detalle.
    EMPTY TEMP-TABLE T-Asn_totales.
    CREATE t-fac_header_prv.
    BUFFER-COPY proveedor TO t-fac_header_prv.
    ASSIGN T-Fac_header_prv.nro_moneda = Moneda.nro_moneda
           t-fac_header_prv.nro_proveedor = proveedor.nro_proveedor
           T-Fac_header_prv.cdg_comprobante  = Tipocomprobante.cdg_comprobante 
           t-fac_header_prv.fecha = TODAY
           t-fac_header_prv.nro_domicilio = domicilio_prv.nro_domicilio
           T-Fac_header_prv.origen           = "R"
           T-Fac_header_prv.cambio           = Moneda.cambio
           T-Fac_header_prv.ultima_linea     = T-Fac_header_prv.ultima_linea + 1
           T-Fac_header_prv.mes              = MONTH(T-Fac_header_prv.fecha) 
           T-Fac_header_prv.ano              = YEAR(T-Fac_header_prv.fecha)
           T-Fac_header_prv.cdg_empresa      = Empresa.cdg_empresa 
           T-Fac_header_prv.tip_comprob      = "FH" 
           T-Fac_header_prv.prf_comprob      = 0
           T-Fac_header_prv.nro_comprob      = rendicion_hd.nro_rendicion
           T-Fac_header_prv.nro_facprov      = 0  
           T-Fac_header_prv.estado           = "E"
           t-Fac_header_prv.cdg_imputacion = imputacion.cdg_imputacion.
    ll = 1.
    FOR each caj_detalle OF rubro WHERE caj_detalle.nro_transaccion = nn NO-LOCK:
        CREATE t-fac_detalle_prv.
        ASSIGN T-Fac_detalle_prv.cantidad = 1
               T-Fac_detalle_prv.num_subcolumna = 1
               T-Fac_detalle_prv.subtotal_neto = caj_detalle.importe
               T-fac_detalle_prv.detallada = "Rendicion " + string(rendicion_hd.nro_rendicion)
               t-fac_header_prv.leyenda_cc = t-fac_detalle_prv.detallada
               T-Fac_detalle_prv.nro_facprov     = T-Fac_header_prv.nro_facprov
               T-Fac_detalle_prv.nro_linea = ll
               ll = ll + 1
               T-Fac_detalle_prv.nro_articulo = articulo.nro_articulo
               T-Fac_detalle_prv.precio = caj_detalle.importe
               t-fac_header_prv.cta_cte = TRUE.
    END.
    RUN calcular_comprobante_proveedor.p (
                             INPUT-OUTPUT TABLE T-Fac_header_prv,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv,
                             INPUT-OUTPUT TABLE T-Sub_header_prv,
                             INPUT-OUTPUT TABLE T-Sub_detalle_prv,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_bon,
                             INPUT-OUTPUT TABLE T-Fac_header_prv_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_prv_impuesto,
                             INPUT-OUTPUT TABLE T-Asn_header,
                             INPUT-OUTPUT TABLE T-Asn_detalle,
                             INPUT-OUTPUT TABLE T-Asn_totales).
    RUN emitir_comprobante_proveedor.p ( 
                                 INPUT TABLE T-Fac_header_prv,
                                 INPUT TABLE T-Fac_detalle_prv,
                                 INPUT TABLE T-Sub_header_prv,
                                 INPUT TABLE T-Sub_detalle_prv,
                                 INPUT TABLE T-Fac_header_prv_bon,
                                 INPUT TABLE T-Fac_detalle_prv_bon,
                                 INPUT TABLE T-Fac_header_prv_impuesto,
                                 INPUT TABLE T-Fac_detalle_prv_impuesto).


  
