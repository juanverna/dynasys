/*============================================================================================*/
/*    CREA Y EMITE LOS DEBITOS Y CREDITOS CORRESPONDIENTES A UNA OPERACION DE CANJE           */
/*============================================================================================*/

DEFINE INPUT PARAMETER act_factura AS ROWID.

{VRSHARED.I}
{VPERSINM.I}
{findempresa.i}

    /* 
       1.- Crear el CI del Proveedor
       2.- Emitir el CI Proveedor
       3.- Levantar el Cliente asociado
       4.- Crear el CI del Cliente
       5.- Emitir el CI del cliente
    */


FIND Fac_header_prv WHERE ROWID(Fac_header_prv) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Fac_header_prv NO-LOCK NO-ERROR.

RUN CREAR_CREDITO_PROVEEDOR.
RUN CREAR_CREDITO_CLIENTE.

PROCEDURE CREAR_CREDITO_PROVEEDOR:

    RUN getparametro.p (  INPUT  "DFCCANJP",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).

    FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.
    FIND Cuenta OF Imputacion NO-LOCK.
    act_concepto = ROWID(Imputacion).
    act_cuenta = ROWID(Cuenta).

    CREATE  Opg_header.
    ASSIGN  Opg_header.nro_usuario    = Usuario.nro_usuario 
            Opg_header.cdg_empresa    = Fac_header_prv.cdg_empresa 
            Opg_header.fecha          = Fac_header_prv.fecha 
            Opg_header.tip_comprob    = "CI" 
            Opg_header.prf_comprob    = 9900 
            Opg_header.nro_ordpago    = NEXT-VALUE(proxima_transaccion) 
            Opg_header.nro_moneda     = Fac_header_prv.nro_moneda 
            Opg_header.cambio         = Fac_header_prv.cambio  
            Opg_header.cdg_imputacion = Imputacion.cdg_imputacion  
            Opg_header.origen         = "A"            
            Opg_header.num_sucursal   = sucursal-id    
            Opg_header.leyenda        = "Por canje factura " + 
                                        Fac_header_prv.tip_comprob + " " + 
                                        STRING(Fac_header_prv.prf_comprob) + " " +
                                        STRING(Fac_header_prv.nro_comprob)
            Opg_header.cdg_condiva    = Fac_header_prv.cdg_condiva
            Opg_header.nro_cndventa   = Fac_header_prv.nro_cndventa
            Opg_header.nro_proveedor  = Fac_header_prv.nro_proveedor
            Opg_header.nombre         = Fac_header_prv.nombre
            Opg_header.cuit           = Fac_header_prv.cuit
            Opg_header.cdg_postal     = Fac_header_prv.cdg_postal
            Opg_header.cdg_provincia  = Fac_header_prv.cdg_provincia
            Opg_header.cdg_tiporetgan   = Fac_header_prv.cdg_tiporetgan
            Opg_header.cdg_zonag      = Fac_header_prv.cdg_zonag
            Opg_header.direccion      = Fac_header_prv.direccion
            Opg_header.entregada      = NO
            Opg_header.estado         = "E"
            Opg_header.imp_bruto      = ROUND(Fac_header_prv.imp_neto * Fac_header_prv.prc_canje / 100 ,2)
            Opg_header.imp_difcambio  = 0 
            Opg_header.imp_neto       = Opg_header.imp_bruto
            Opg_header.imp_pesos      = Opg_header.imp_bruto
            Opg_header.imp_total      = Opg_header.imp_bruto
            Opg_header.localidad      = Fac_header_prv.localidad
            Opg_header.nro_entidad    = Fac_header_prv.nro_entidad
            Opg_header.nro_obra       = 0
            Opg_header.num_sucursal   = Fac_header_prv.num_sucursal
            Opg_header.tipo_pago      = 2
            Opg_header.tot_iva        = 0
            Opg_header.tot_neto       = Opg_header.imp_neto
            Opg_header.tot_total      = Opg_header.imp_total
            Opg_header.ultima_linea   = 0.
    
    FIND Parametro 
         WHERE Parametro.cdg_empresa = Empresa.cdg_empresa 
           AND Parametro.cdg_parametro =  "PCRI" + 
               STRING(Opg_header.prf_comprob,"9999") 
               EXCLUSIVE-LOCK NO-ERROR.
    
    ASSIGN
         Opg_header.nro_comprob  = Parametro.valor_n
         Parametro.valor_n       = Parametro.valor_n + 1.
    
    RELEASE Parametro.
    
    act_opg_head = ROWID(Opg_header).
    RUN EMICREPVI.P. 

END PROCEDURE.

PROCEDURE CREAR_CREDITO_CLIENTE:

    RUN getparametro.p (  INPUT  "DFCCANJC",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).

    FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.
    FIND Cuenta OF Imputacion NO-LOCK.
    act_concepto = ROWID(Imputacion).
    act_cuenta = ROWID(Cuenta).

    FIND Proveedor OF Fac_header_prv NO-LOCK.
    FIND Cliente WHERE Cliente.nro_cliente = Proveedor.nro_cliente NO-LOCK.

    CREATE  Rec_header.
    ASSIGN  Rec_header.nro_usuario    = Usuario.nro_usuario 
            Rec_header.cdg_empresa    = Fac_header_prv.cdg_empresa 
            Rec_header.fecha          = Fac_header_prv.fecha 
            Rec_header.tip_comprob    = "CI" 
            Rec_header.prf_comprob    = Opg_header.prf_comprob 
            Rec_header.nro_recibo     = NEXT-VALUE(proxima_transaccion) 
            Rec_header.nro_moneda     = Fac_header_prv.nro_moneda 
            Rec_header.cambio         = Fac_header_prv.cambio  
            Rec_header.cdg_imputacion = Imputacion.cdg_imputacion  
            Rec_header.origen         = "A"            
            Rec_header.num_sucursal   = sucursal-id    
            Rec_header.leyenda        = "Por canje factura " + 
                                        Fac_header_prv.tip_comprob + " " + 
                                        STRING(Fac_header_prv.prf_comprob) + " " +
                                        STRING(Fac_header_prv.nro_comprob)
            Rec_header.cdg_condiva    = Fac_header_prv.cdg_condiva
            Rec_header.nro_cndventa   = Fac_header_prv.nro_cndventa
            Rec_header.nro_cliente    = Cliente.nro_cliente
            Rec_header.cuit           = Cliente.cuit
            Rec_header.cdg_postal     = Fac_header_prv.cdg_postal
            Rec_header.cdg_provincia  = Fac_header_prv.cdg_provincia
            Rec_header.cdg_zonag      = Fac_header_prv.cdg_zonag
            Rec_header.direccion      = Fac_header_prv.direccion
            Rec_header.estado         = "E"
            Rec_header.imp_bruto      = Opg_header.imp_bruto
            Rec_header.imp_difcambio  = 0 
            Rec_header.imp_neto       = Rec_header.imp_bruto
            Rec_header.imp_pesos      = Rec_header.imp_bruto
            Rec_header.imp_total      = Rec_header.imp_bruto
            Rec_header.localidad      = Fac_header_prv.localidad
            Rec_header.nro_entidad    = Fac_header_prv.nro_entidad
            Rec_header.nro_domicilio  = 1
            Rec_header.num_sucursal   = Fac_header_prv.num_sucursal
            Rec_header.tipo_pago      = 2
            Rec_header.ultima_linea   = 0
      
            Rec_header.nro_comprob    = Opg_header.nro_comprob.
    
    act_rec_head = ROWID(Rec_header).
    RUN EMICREDSI.P. 

END PROCEDURE.
