/*=========================================================================================*/
/*                 REALIZA LA EMISION FACTURAS MENSUALES DE SERVICIO                       */
/* Tiene encuenta las facturas electronicas                                                */ 
/*=========================================================================================*/

                                                                            
/*
DEFINE INPUT PARAMETER p-des_punto        AS INTEGER.  
DEFINE INPUT PARAMETER p-has_punto        AS INTEGER.  
DEFINE INPUT PARAMETER p-des_fecha        AS DATE.               
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.
DEFINE INPUT PARAMETER p-mes_imputa       AS INTEGER.
DEFINE INPUT PARAMETER p-ano_imputa       AS INTEGER.
DEFINE INPUT PARAMETER p-fecha_emision    AS DATE.
DEFINE INPUT PARAMETER p-generar_facturas  AS LOGICAL.
DEFINE INPUT PARAMETER codigo_empresa LIKE empresa.cdg_empresa NO-UNDO.
DEFINE INPUT PARAMETER uusuario LIKE usuario.cdg_usuario NO-UNDO.
DEFINE OUTPUT PARAMETER xfile AS CHAR NO-UNDO.
*/

DEFINE var p-des_punto        AS INTEGER INITIAL 3.
DEFINE var p-has_punto        AS INTEGER INITIAL 3.  
DEFINE var p-des_fecha        AS DATE INITIAL 02/01/2017.               
DEFINE var p-has_fecha        AS DATE INITIAL 02/28/2017.
DEFINE var p-mes_imputa       AS INTEGER INITIAL 02.
DEFINE var p-ano_imputa       AS INTEGER INITIAL 2017.
DEFINE var p-fecha_emision    AS DATE INITIAL 02/01/2017.
DEFINE var p-generar_facturas  AS LOGICAL INITIAL YES.
DEFINE var codigo_empresa LIKE empresa.cdg_empresa INITIAL "P" NO-UNDO.
DEFINE var uusuario LIKE usuario.cdg_usuario INITIAL "ferver" NO-UNDO.
DEFINE var xfile AS CHAR NO-UNDO.

DEFINE VAR que_empresa AS CHAR.
DEFINE VAR vtanque AS char NO-UNDO.
DEFINE VAR v-listaArticulo AS CHAR NO-UNDO.
DEFINE STREAM errores.
OS-DELETE "..\logs\erroresfacturacion.LOG" NO-ERROR.


/*=========================================================================================*/
/*                              TABLAS TEMPORALES                                          */
/*=========================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.

DEFINE BUFFER administrador FOR cliente.
/*=========================================================================================*/
/*                                      VARIABLES                                          */
/*=========================================================================================*/

{parlocales.i}
{nommeses.i}

DEFINE VARIABLE v-reemplazos              AS CHARACTER FORMAT "X(40)" NO-UNDO.
DEFINE VARIABLE v-cdg_factura               AS CHARACTER.

DEFINE VARIABLE cotiza_dolar              AS DECIMAL DECIMALS 2 NO-UNDO.
DEFINE VARIABLE saldo_cc_anterior         AS DECIMAL DECIMALS 2 NO-UNDO FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE v-importe_factura         AS DECIMAL DECIMALS 2 NO-UNDO FORMAT "->>>,>>>,>>9.99".

DEFINE VARIABLE g-pesos                   AS DECIMAL DECIMALS 2 FORMAT "->>>,>>>,>>9.99" NO-UNDO.
DEFINE VARIABLE g-_facturaes                 AS INTEGER FORMAT ">>>>9" NO-UNDO.

DEFINE VARIABLE v-proxima_transaccion     AS INTEGER    NO-UNDO.
DEFINE VARIABLE v-transcurridos           AS INTEGER    NO-UNDO.
DEFINE VARIABLE v-ciclo_facturacion       AS INTEGER    NO-UNDO.
DEFINE VARIABLE j-reemplazo               AS INTEGER    NO-UNDO.
DEFINE VAR afmaxv LIKE fac_header.imp_total NO-UNDO.
DEFINE VAR hayerror AS LOGICAL NO-UNDO.
DEFINE BUFFER B-Contrato_hd FOR Contrato_hd.

DEFINE TEMP-TABLE parametros
     FIELD des_pto AS CHAR
     FIELD has_pto AS CHAR
     FIELD des_fecha AS CHAR
     FIELD has_fecha AS CHAR.


DEFINE TEMP-TABLE listado
    FIELD cdg_cliente       LIKE Cliente.cdg_cliente  
    FIELD nom_cliente       LIKE Cliente.nom_cliente 
    FIELD DIR_cliente       LIKE cliente.direccion
    FIELD cdg_administrador LIKE administrador.cdg_cliente
    FIELD nom_administrador LIKE administrador.nom_cliente
    FIELD ListaArticulos    AS CHAR FORMAT "X(20)"
    FIELD prf_contrato      LIKE Contrato_hd.prf_contrato
    FIELD num_contrato      LIKE Contrato_hd.num_contrato
    FIELD importe_factura   LIKE v-importe_factura
    FIELD saldo_cc_anterior LIKE saldo_cc_anterior
    FIELD rige_desde        LIKE Contrato_hd.rige_desde 
    FIELD rige_hasta        LIKE Contrato_hd.rige_hasta
    FIELD primer_ano        LIKE Contrato_hd.primer_ano
    FIELD primer_mes        LIKE Contrato_hd.primer_mes
    FIELD resto_periodos    LIKE Contrato_hd.resto_periodos
    FIELD tip_contrato      LIKE contrato_hd.tip_contrato
    FIELD cuit              LIKE Contrato_hd.cuit.

DEFINE DATASET dset FOR listado,parametros.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/
FIND empresa WHERE empresa.cdg_empresa = codigo_empresa.
que_empresa = Empresa.nombre.
FIND usuario WHERE usuario.cdg_usuario = uusuario.

RUN getparametroAPP.p (  INPUT  "DFMONEDA",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion,
                      INPUT empresa.cdg_empresa,
                      INPUT usuario.cdg_usuario ).
FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.

RUN getparametroAPP.p (  INPUT  "DFDEPOSI",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion, 
                      INPUT empresa.cdg_empresa,
                      INPUT usuario.cdg_usuario).

RUN getparametro_d.p( "AFMAXV", OUTPUT afmaxv).
afmaxv = 1000 - 24.

FIND Deposito WHERE Deposito.cdg_deposito = v-valor_c NO-LOCK.


FIND Entidad WHERE Entidad.cdg_entidad = Empresa.cdg_empresa NO-LOCK.

CREATE parametros.
        ASSIGN parametros.des_pto = string(p-des_punto) 
            parametros.has_pto = string(p-has_punto) 
            parametros.des_fecha = string(p-des_fecha) 
            parametros.has_fecha = string(p-has_fecha). 

/*RUN carparam.p.*/

    FOR EACH Contrato_hd 
        WHERE contrato_hd.estado = "A" AND NOT contrato_hd.suspendido AND ( Contrato_hd.rige_desde <= p-has_fecha  
          AND Contrato_hd.rige_hasta >= p-des_fecha )
          AND ( Contrato_hd.primer_ano * 100 + Contrato_hd.primer_mes <= p-ano_imputa * 100 + p-mes_imputa )
          AND ( Contrato_hd.resto_periodos > 0  or Contrato_hd.cant_periodos = 0 ) 
          AND Contrato_hd.prf_contrato <= p-has_punto 
          AND Contrato_hd.prf_contrato >= p-des_punto 
          NO-LOCK,
              FIRST Cliente OF Contrato_hd NO-LOCK ,
              FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador NO-LOCK
                                BREAK BY administrador.nom_cliente
                                      BY cliente.direccion
                                      BY Contrato_hd.num_contrato :
        FIND Condicion_impos OF Contrato_hd NO-LOCK.
        v-ciclo_facturacion = INTEGER(Contrato_hd.modo_facturacion).
        FIND punto-venta WHERE Punto-venta.cdg_puntovta = Contrato_hd.prf_contrato NO-LOCK NO-ERROR.
        
        IF contrato_hd.fecha_baja <> ? AND contrato_hd.fecha_baja <= p-has_fecha THEN NEXT.

        IF NOT punto-venta.habilitado THEN do:
            OUTPUT STREAM errores TO "..\logs\erroresfacturacion.LOG" append.
            PUT STREAM errores NOW "Cliente " cliente.cdg_cliente "-" Cliente.nom_cliente contrato_hd.prf_contrato "-" contrato_hd.num_contrato 
                "Punto de venta no habilitado, verifique" SKIP.
            hayerror = TRUE.
            OUTPUT STREAM errores CLOSE.
            NEXT.
        END.
        
        v-transcurridos = ( p-ano_imputa - Contrato_hd.primer_ano ) * 12 + 
                          ( p-mes_imputa - Contrato_hd.primer_mes ).

        IF v-transcurridos MOD v-ciclo_facturacion = 0
        THEN DO:
        
            IF NOT CAN-FIND(FIRST   Cta_cte OF Cliente 
                              WHERE Cta_cte.ano = p-ano_imputa
                                AND Cta_cte.mes = p-mes_imputa
                                AND Cta_cte.nro_contrato = Contrato_hd.nro_contrato
                                AND Cta_cte.cdg_imputacion = Contrato_hd.cdg_imputacion)
            THEN DO:                      
    
                
                /*verificamos condiciones de facturas segun reglamentecion*/
                /*sin cuit >= afmaxv*/
                IF cliente.cod_docu = ""  THEN DO:
                            OUTPUT STREAM errores TO "..\logs\erroresfacturacion.LOG" append.
                            put STREAM errores "Cliente " cliente.cdg_cliente "-" Cliente.nom_cliente contrato_hd.prf_contrato "-" contrato_hd.num_contrato 
                                " No se encuentra el tipo documento." SKIP.
                            hayerror = TRUE.
                            OUTPUT STREAM errores CLOSE.
                END.
                IF punto-venta.impresor = "E" AND Punto-venta.TP = "E" THEN DO: /*es electronica*/
                    RUN generar_facturacion ( OUTPUT v-importe_factura, OUTPUT v-listaArticulo, FALSE ). /*solo para generar cuanto hay que facturar*/ 
                    IF v-importe_factura <= 1 THEN DO:
                              OUTPUT STREAM errores TO "..\logs\erroresfacturacion.LOG" append.
                              PUT STREAM errores NOW "Cliente " cliente.cdg_cliente "-" Cliente.nom_cliente contrato_hd.prf_contrato "-" contrato_hd.num_contrato 
                                    "Facturacion en 0,verifique" SKIP.
                              hayerror = TRUE.
                              OUTPUT STREAM errores CLOSE.
                              NEXT.
                    END.
                    IF v-importe_factura >= afmaxv THEN DO:
                        IF ( cliente.factu_admin AND administrador.cod_docu = "NO" ) or
                           ( NOT cliente.factu_admin AND cliente.cod_docu = "NO" ) THEN DO:
                            OUTPUT STREAM errores TO "..\logs\erroresfacturacion.LOG" append.
                            put STREAM errores "Cliente " cliente.cdg_cliente "-" Cliente.nom_cliente contrato_hd.prf_contrato contrato_hd.num_contrato 
                                " Supera los " afmaxv " sin identificacion CUIT/CUIL/CDI" SKIP.
                            CREATE listado.
                            ASSIGN listado.cdg_cliente          = cliente.cdg_cliente             
                                   listado.nom_cliente          = IF cliente.factu_admin THEN administrador.nom_cliente ELSE cliente.nom_cliente       
                                   listado.DIR_cliente          = IF cliente.factu_admin THEN administrador.direccion ELSE cliente.direccion   
                                   listado.cdg_administrador    = administrador.cdg_cliente 
                                   listado.nom_administrador    = administrador.nom_cliente
                                   listado.num_contrato         = contrato_hd.num_contrato
                                   listado.ListaArticulos       = "ERROR"
                                   listado.importe_factura    = v-importe_factura.              
                            hayerror = TRUE.
                            OUTPUT STREAM errores CLOSE.
                            NEXT.
                        END.
                    END.
                END.

                RUN generar_facturacion ( OUTPUT v-importe_factura, OUTPUT v-listaArticulo, p-generar_facturas ). 
    
                CREATE listado.
                ASSIGN listado.cdg_cliente          = cliente.cdg_cliente             
                       listado.nom_cliente          = IF cliente.factu_admin THEN administrador.nom_cliente ELSE cliente.nom_cliente       
                       listado.DIR_cliente          = IF cliente.factu_admin THEN administrador.direccion ELSE cliente.direccion   
                       listado.cdg_administrador    = administrador.cdg_cliente 
                       listado.nom_administrador    = administrador.nom_cliente
                       listado.num_contrato         = contrato_hd.num_contrato      
                       listado.prf_contrato         = contrato_hd.prf_contrato      
                       listado.saldo_cc_anterior    = saldo_cc_anterior 
                       listado.rige_desde           = contrato_hd.rige_desde        
                       listado.rige_hasta           = contrato_hd.rige_hasta        
                       listado.primer_ano           = contrato_hd.primer_ano        
                       listado.primer_mes           = contrato_hd.primer_mes        
                       listado.resto_periodos       = IF p-generar_facturas THEN contrato_hd.resto_periodos ELSE ( IF Contrato_hd.cant_periodos > 0 AND contrato_hd.resto_periodos > 0 THEN contrato_hd.resto_periodos - 1 ELSE 0 )  
                       listado.cuit                 = IF cliente.factu_admin THEN administrador.cuit ELSE cliente.cuit       
                       listado.ListaArticulos       = v-listaarticulo
                       listado.importe_factura    = v-importe_factura.              
                /*
                IF saldo_cc_anterior + v-importe_factura >= 0
                THEN DO:
                */
                     g-_facturaes = g-_facturaes + 1.
                     g-pesos   = g-pesos + v-importe_factura.
                /*
                END.
                */
    
            END.
        END.
    END.       

    xfile = SUBST('&1/cr-' + userid("sic") + ".xml" , SESSION:TEMP-DIRECTORY).
    xfile = REPLACE(xfile,"/","\").
    DATASET dset:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).
                                   
/*A fin de tener las definiciones solamente grabo la estructura y con eso desarrollo el reporte*/
/*
dataset dset:WRITE-XMLSCHEMA("FILE",'AFI/cr-generar_abonos.xsd',
                                     yes,?,no).
*/

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

PROCEDURE generar_facturacion:

    /*----------------------------------------------------------------*/
    /* PARAMETRO DE SALIDA: IMPORTE DE LA FACTURA DEL CONTRATO        */
    /*----------------------------------------------------------------*/

    DEFINE OUTPUT PARAMETER p-importe_factura LIKE Fac_header.imp_total NO-UNDO.
    DEFINE OUTPUT PARAMETER lista AS CHAR NO-UNDO.
    DEFINE INPUT PARAM pgene AS LOGICAL NO-UNDO.
    DEFINE VAR oblea AS CHAR NO-UNDO.
    DEFINE VAR oblea_precio AS DECIMAL DECIMALS 2 NO-UNDO.
    DEFINE VAR precio23F AS DECIMAL INITIAL 260.00 NO-UNDO.
    DEFINE VAR precio01f AS DECIMAL INITIAL 65.00 NO-UNDO.
    DEFINE BUFFER t-contrato_dt FOR contrato_dt.
    /*----------------------------------------------------------------*/
    /*                        PROCESO                                 */
    /*----------------------------------------------------------------*/
    
    FIND FIRST Domicilio OF Cliente NO-LOCK.
    FIND Vendedor OF Contrato_hd NO-LOCK.
    FIND Condicion_venta OF Contrato_hd NO-LOCK.
    FIND punto-venta WHERE Punto-venta.cdg_puntovta = Contrato_hd.prf_contrato NO-LOCK.
    lista = "".
    CREATE  T-Fac_header.
    ASSIGN  T-Fac_header.prf_comprob        = Contrato_hd.prf_contrato
            T-fac_header.cdg_comprobante    = IF punto-venta.tp = "E" THEN "FACTUCLI" ELSE "FACTUCLM" 
            T-fac_header.tip_comprob        = IF T-fac_header.cdg_comprobante = "FACTUCLI" THEN "F" + Condicion_impos.tipo_factura ELSE "FC" 
            T-Fac_header.cdg_empresa        = Empresa.cdg_empresa
            T-Fac_header.nro_usuario        = Usuario.nro_usuario 
            T-Fac_header.fecha              = p-fecha_emision 
            T-Fac_header.fecha_iva          = p-fecha_emision 
            T-Fac_header.mes                = p-mes_imputa
            T-Fac_header.ano                = p-ano_imputa 
            T-Fac_header.nro_factura        = 0
            T-Fac_header.nro_comprob        = T-Fac_header.nro_factura 
            T-Fac_header.nro_moneda         = Moneda.nro_moneda 
            T-Fac_header.cambio             = Moneda.cambio  
            T-Fac_header.cdg_imputacion     = Contrato_hd.cdg_imputacion  
            T-Fac_header.origen             = "A"            
            T-Fac_header.num_sucursal       = ""
            T-Fac_header.nro_cliente        = Cliente.nro_cliente
            T-Fac_header.nro_contrato       = Contrato_hd.nro_contrato
            T-Fac_header.nro_domicilio      = Domicilio.nro_domicilio
            T-Fac_header.cdg_provincia      = Domicilio.cdg_provincia
            T-Fac_header.nombre             = IF cliente.factu_admin THEN administrador.nom_cliente ELSE Cliente.nom_cliente
            T-Fac_header.cdg_condiva        = IF cliente.factu_admin THEN administrador.cdg_condiva ELSE Cliente.cdg_condiva
            t-fac_header.cod_docu           = IF cliente.factu_admin THEN administrador.cod_docu ELSE cliente.cod_docu 
            T-Fac_header.cuit               = IF cliente.factu_admin THEN administrador.cuit ELSE Cliente.cuit
            T-Fac_header.direccion          = IF cliente.factu_admin THEN administrador.direccion ELSE Domicilio.direccion
            T-Fac_header.localidad          = IF cliente.factu_admin THEN administrador.localidad ELSE Domicilio.localidad
            T-Fac_header.cdg_postal         = IF cliente.factu_admin THEN administrador.cdg_postal ELSE cliente.cdg_postal
            T-Fac_header.nro_vendedor       = Vendedor.nro_vendedor
            T-Fac_header.nro_deposito       = Deposito.nro_deposito
            T-Fac_header.cdg_lista          = IF cliente.factu_admin THEN administrador.dfl_lista ELSE cliente.dfl_lista
            T-Fac_header.ultima_linea       = 1
            T-Fac_header.cta_cte            = YES
            T-Fac_header.estado             = "E"
            T-Fac_header.nro_cndventa       = Condicion_venta.nro_cndventa
            T-Fac_header.imp_total          = 0
            T-Fac_header.codigo_cliente     = cliente.cdg_cliente
            T-Fac_header.texto_iva = condicion_impos.texto_iva
            T-Fac_header.texto_condicion_venta = condicion_venta.texto
            T-Fac_header.direccion_administrador = administrador.direccion
            T-Fac_header.nom_Administrador = administrador.nom_cliente
            T-Fac_header.cdg_administrador = administrador.cdg_cliente
            t-Fac_header.nro_administrador = administrador.nro_cliente
            t-Fac_header.cdg_postal_leg    = t-Fac_header.cdg_postal   
            t-Fac_header.cdg_provincia_leg = t-Fac_header.cdg_provincia
            t-Fac_header.direccion_leg     = t-Fac_header.direccion   
            t-Fac_header.localidad_leg     = t-Fac_header.localidad    
            T-fac_header.mostrar_admin = administrador.mostrar_admin .
        IF ( Contrato_hd.cant_periodos - Contrato_hd.resto_periodos = 0 OR Contrato_hd.cant_periodos = 0 ) AND t-Fac_header.estado_2_impresion <> "OT" and
            t-Fac_header.estado_2_impresion <> "I" THEN
            t-Fac_header.estado_2_impresion = "OT".

            
       FOR EACH Contrato_dt OF Contrato_hd , 
             FIRST Articulo OF Contrato_dt NO-LOCK, 
                   FIRST Familia_impositiva OF Articulo NO-LOCK:
        FOR EACH Impuesto_condicion OF  Familia_impositiva 
           WHERE Impuesto_condicion.cdg_condiva = T-Fac_header.cdg_condiva
             AND Impuesto_condicion.cdg_empresa = T-Fac_header.cdg_empresa 
             AND Impuesto_condicion.fch_desde <= T-Fac_header.fecha_iva
             AND Impuesto_condicion.fch_hasta >= T-Fac_header.fecha_iva
             AND CAN-DO(Impuesto_condicion.lista_provincias,T-Fac_header.cdg_provincia) NO-LOCK, 
                 Impuesto OF Impuesto_condicion NO-LOCK:
                  
              FIND FIRST  Cliente_excencion OF Cliente 
                  WHERE Cliente_excencion.cdg_empresa  = T-Fac_header.cdg_empresa
                    AND Cliente_excencion.cdg_impuesto = Impuesto_condicion.cdg_impuesto
                    AND Cliente_excencion.fch_desde <= T-Fac_header.fecha_iva
                    AND Cliente_excencion.fch_hasta >= T-Fac_header.fecha_iva 
                        NO-LOCK NO-ERROR.
    
        END.
             
        IF articulo.cdg_articulo = "01F" AND contrato_dt.precio <> precio01f AND contrato_dt.precio <> 0 THEN DO:
                 contrato_dt.precio = precio01f.
                 contrato_dt.precio_cf = precio01f.
                 FIND CURRENT contrato_hd EXCLUSIVE-LOCK.
                 ASSIGN Contrato_hd.imp_bruto = 0
                    Contrato_hd.imp_iva = 0
                    Contrato_hd.imp_neto = 0
                    Contrato_hd.imp_total = 0.
                 FOR EACH t-contrato_dt OF contrato_hd:
                     ASSIGN 
                        t-contrato_dt.subtotal_bruto = t-contrato_dt.precio
                        t-contrato_dt.subtotal_bruto_cf = t-contrato_dt.precio_cf
                        t-contrato_dt.subtotal_neto_cf = t-contrato_dt.precio_cf
                        t-contrato_dt.subtotal_gral = t-contrato_dt.subtotal_bruto_cf
                        t-contrato_dt.subtotal_neto = t-contrato_dt.precio
                        t-contrato_dt.subtotal_neto_cf = t-contrato_dt.precio_cf
                        Contrato_hd.imp_bruto = contrato_hd.imp_bruto + t-contrato_dt.subtotal_bruto
                        Contrato_hd.imp_iva = Contrato_hd.imp_iva + t-contrato_dt.precio_cf - t-contrato_dt.precio
                        Contrato_hd.imp_neto = Contrato_hd.imp_neto + t-contrato_dt.subtotal_neto
                        Contrato_hd.imp_total = Contrato_hd.imp_total + t-contrato_dt.subtotal_gral.
                 END.
        END.
        IF articulo.cdg_articulo = "23F" AND contrato_dt.precio <> precio23f AND contrato_dt.precio <> 0 THEN DO:
                 contrato_dt.precio = precio23f.
                 contrato_dt.precio_cf = precio23f.
                 FIND CURRENT contrato_hd EXCLUSIVE-LOCK.
        ASSIGN Contrato_hd.imp_bruto = 0
           Contrato_hd.imp_iva = 0
           Contrato_hd.imp_neto = 0
           Contrato_hd.imp_total = 0.
        FOR EACH t-contrato_dt OF contrato_hd:
            ASSIGN 
               t-contrato_dt.subtotal_bruto = t-contrato_dt.precio
               t-contrato_dt.subtotal_bruto_cf = t-contrato_dt.precio_cf
               t-contrato_dt.subtotal_neto_cf = t-contrato_dt.precio_cf
               t-contrato_dt.subtotal_gral = t-contrato_dt.subtotal_bruto_cf
               t-contrato_dt.subtotal_neto = t-contrato_dt.precio
               t-contrato_dt.subtotal_neto_cf = t-contrato_dt.precio_cf
               Contrato_hd.imp_bruto = contrato_hd.imp_bruto + t-contrato_dt.subtotal_bruto
               Contrato_hd.imp_iva = Contrato_hd.imp_iva + t-contrato_dt.precio_cf - t-contrato_dt.precio
               Contrato_hd.imp_neto = Contrato_hd.imp_neto + t-contrato_dt.subtotal_neto
               Contrato_hd.imp_total = Contrato_hd.imp_total + t-contrato_dt.subtotal_gral.
        END.

        END.
        
        
        
        IF contrato_dt.solocuota1 AND Contrato_hd.cant_periodos > 0 AND Contrato_hd.cant_periodos = Contrato_hd.resto_periodos THEN DO:
            CREATE T-Fac_detalle.
            ASSIGN T-Fac_detalle.a_granel           = NO 
                   T-Fac_detalle.cantidad           = Contrato_dt.cantidad
                   T-Fac_detalle.costo              = truncate(contrato_dt.precio,2)
                   T-Fac_detalle.detallada          = IF contrato_dt.detallada = ""  THEN Articulo.descripcion ELSE contrato_dt.detallada
                   T-Fac_detalle.granel             = 0
                   T-Fac_detalle.nro_articulo       = Articulo.nro_articulo
                   T-Fac_detalle.nro_entidad        = 0
                   T-Fac_detalle.nro_factura        = T-Fac_header.nro_factura
                   T-Fac_detalle.nro_linea          = T-Fac_header.ultima_linea
                   T-Fac_detalle.nro_obra           = 0
                   T-Fac_detalle.nro_partida        = 0 
                   T-Fac_detalle.ver_codigo         = NO
                   T-Fac_detalle.ver_unidades       = NO
                   T-Fac_header.ultima_linea        = T-Fac_header.ultima_linea + 1
                   T-Fac_detalle.precio             = truncate(contrato_dt.precio,2).
                  /* T-Fac_detalle.precio_cf          = truncate(contrato_dt.precio_cf,2).*/
        END.
        ELSE do:
            IF contrato_dt.solocuota1 THEN NEXT.
            CREATE T-Fac_detalle.
            ASSIGN T-Fac_detalle.a_granel           = NO 
                   T-Fac_detalle.cantidad           = Contrato_dt.cantidad
                   T-Fac_detalle.costo              = truncate(contrato_dt.precio,2)
                   T-Fac_detalle.detallada          = IF contrato_dt.detallada = ""  THEN Articulo.descripcion ELSE contrato_dt.detallada
                   T-Fac_detalle.granel             = 0
                   T-Fac_detalle.nro_articulo       = Articulo.nro_articulo
                   T-Fac_detalle.nro_entidad        = 0
                   T-Fac_detalle.nro_factura        = T-Fac_header.nro_factura
                   T-Fac_detalle.nro_linea          = T-Fac_header.ultima_linea
                   T-Fac_detalle.nro_obra           = 0
                   T-Fac_detalle.nro_partida        = 0 
                   T-Fac_detalle.ver_codigo         = NO
                   T-Fac_detalle.ver_unidades       = NO
                   T-Fac_header.ultima_linea        = T-Fac_header.ultima_linea + 1
                   T-Fac_detalle.precio             = truncate(contrato_dt.precio,2)
                   T-Fac_detalle.precio             = truncate(IF Contrato_hd.cant_periodos = 0 THEN T-Fac_detalle.precio ELSE T-Fac_detalle.precio / Contrato_hd.cant_periodos ,2).
   /*   T-Fac_detalle.precio_cf          = truncate(contrato_dt.precio_cf,2)
      T-Fac_detalle.precio_cf          = truncate(IF Contrato_hd.cant_periodos = 0 THEN T-Fac_detalle.precio_cf ELSE T-Fac_detalle.precio_cf / Contrato_hd.cant_periodos ,2).*/
        END.
        
        vtanque = "".
        FIND Cliente_otros_datos OF cliente NO-ERROR.
        IF AVAILABLE  Cliente_otros_datos THEN vtanque = STRING(  Cliente_otros_datos.Tanques ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&DESC", trim(articulo.descripcion) ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&DETALLADA", trim(articulo.detallada) ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&TANQUES", vtanque ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&TANQUE", vtanque ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&MES",nom_mes [ p-mes_imputa ] ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&ANO",string( p-ano_imputa ,"9999" )).
        IF Contrato_hd.cant_periodos - Contrato_hd.resto_periodos < 0 THEN DO:
            OUTPUT STREAM errores TO "..\logs\erroresfacturacion.LOG" append.
            PUT STREAM errores NOW "Cliente " cliente.cdg_cliente "-" Cliente.nom_cliente contrato_hd.prf_contrato "-" contrato_hd.num_contrato 
                "La cantidad de periodos y los facturados tienen problemas" SKIP.
            hayerror = TRUE.
            OUTPUT STREAM errores CLOSE.
            NEXT.
        END.
        ELSE T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&CUOTA", string(Contrato_hd.cant_periodos - Contrato_hd.resto_periodos + 1, ">9") ).
        T-Fac_detalle.detallada = REPLACE(T-Fac_detalle.detallada,"&DECUOTA",string(Contrato_hd.cant_periodos,">9" )).
        IF LOOKUP(Articulo.cdg_tipoart , substring(lista, 2 ) ," " ) = 0 THEN
                         ASSIGN lista = lista + " " +  Articulo.cdg_tipoart.
       END.
       /*vemos si la factura anterior la oblea estaba correcta*/
       FIND fac_header WHERE fac_header.nro_contrato = contrato_hd.nro_contrato AND fac_header.mes = 1 AND fac_header.ano = 2017 AND fac_header.tip_comprob = t-fac_header.tip_comprob NO-LOCK NO-ERROR.
       IF AVAILABLE fac_header THEN DO: 
       FOR each fac_detalle OF fac_header, articulo OF fac_detalle:
           IF articulo.cdg_articulo = "23F" AND fac_detalle.precio <> precio23f THEN DO:
            CREATE T-Fac_detalle.
            FIND articulo WHERE articulo.cdg_articulo = "R23F" NO-LOCK.
            ASSIGN T-Fac_detalle.a_granel           = NO 
                   T-Fac_detalle.cantidad           = 1
                   T-Fac_detalle.costo              = truncate( precio23f - fac_detalle.precio ,2)
                   T-Fac_detalle.detallada          = articulo.detallada
                   T-Fac_detalle.granel             = 0
                   T-Fac_detalle.nro_articulo       = Articulo.nro_articulo
                   T-Fac_detalle.nro_entidad        = 0
                   T-Fac_detalle.nro_factura        = T-Fac_header.nro_factura
                   T-Fac_detalle.nro_linea          = T-Fac_header.ultima_linea
                   T-Fac_detalle.nro_obra           = 0
                   T-Fac_detalle.nro_partida        = 0 
                   T-Fac_detalle.ver_codigo         = NO
                   T-Fac_detalle.ver_unidades       = NO
                   T-Fac_header.ultima_linea        = T-Fac_header.ultima_linea + 1
                   T-Fac_detalle.precio             = truncate( precio23f - fac_detalle.precio ,2).

           END.
           IF articulo.cdg_articulo = "01F" AND fac_detalle.precio <> precio01f THEN DO:
               IF lookup(trim(string(contrato_hd.nro_contrato)),"366,12922,30768,30794,30796,30797,30798,30799,30800,30801,30805,30806,30808,30961,323") = 0 THEN DO:
                CREATE T-Fac_detalle.
            FIND articulo WHERE articulo.cdg_articulo = "R01F" NO-LOCK.
            ASSIGN T-Fac_detalle.a_granel           = NO 
                   T-Fac_detalle.cantidad           = 1
                   T-Fac_detalle.costo              = truncate( precio01f - fac_detalle.precio ,2)
                   T-Fac_detalle.detallada          = articulo.detallada
                   T-Fac_detalle.granel             = 0
                   T-Fac_detalle.nro_articulo       = Articulo.nro_articulo
                   T-Fac_detalle.nro_entidad        = 0
                   T-Fac_detalle.nro_factura        = T-Fac_header.nro_factura
                   T-Fac_detalle.nro_linea          = T-Fac_header.ultima_linea
                   T-Fac_detalle.nro_obra           = 0
                   T-Fac_detalle.nro_partida        = 0 
                   T-Fac_detalle.ver_codigo         = NO
                   T-Fac_detalle.ver_unidades       = NO
                   T-Fac_header.ultima_linea        = T-Fac_header.ultima_linea + 1
                   T-Fac_detalle.precio             = truncate( precio01f - fac_detalle.precio ,2).
           END.
           END.
       END.
       END.
    IF pgene
          THEN DO:
              FIND B-Contrato_hd WHERE ROWID(B-Contrato_hd) = ROWID(Contrato_hd) EXCLUSIVE-LOCK.
              ASSIGN B-Contrato_hd.ultimo_ano     = p-ano_imputa
                     B-Contrato_hd.ultimo_mes     = p-mes_imputa.
              IF B-Contrato_hd.cant_periodos > 0 AND  B-Contrato_hd.resto_periodos > 0
                  THEN B-Contrato_hd.resto_periodos = B-Contrato_hd.resto_periodos - 1.
              RELEASE B-Contrato_hd.
    END.

    RUN calcular_comprobante_cliente.p (
                             INPUT-OUTPUT TABLE T-Fac_header,
                             INPUT-OUTPUT TABLE T-Fac_detalle,
                             INPUT-OUTPUT TABLE T-Sub_header_vta,
                             INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                             INPUT-OUTPUT TABLE T-Fac_header-bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                             INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).

    FIND FIRST T-Fac_header.
    p-importe_factura = T-Fac_header.imp_total.
    
    IF pgene
    THEN DO:

        RUN emitir_comprobante_cliente.p ( 
                              INPUT-OUTPUT TABLE T-Fac_header,
                              INPUT-OUTPUT TABLE T-Fac_detalle,
                              INPUT-OUTPUT TABLE T-Registrable-factura,
                              INPUT-OUTPUT TABLE T-Sub_header_vta,
                              INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                              INPUT-OUTPUT TABLE T-Fac_header-bon,
                              INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                              INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                              INPUT-OUTPUT TABLE T-Fac_detalle_impuesto).
        FIND FIRST T-Fac_header.

    END.
    lista = SUBSTRING(lista ,  2).

    RUN borrar_tablas_temporales.

END PROCEDURE.

PROCEDURE borrar_tablas_temporales:

   EMPTY TEMP-TABLE T-Fac_header.
   EMPTY TEMP-TABLE T-Fac_detalle.
   EMPTY TEMP-TABLE T-Fac_header-bon.
   EMPTY TEMP-TABLE T-Fac_detalle-bon.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Fac_header_impuesto.
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.
       
END PROCEDURE.

