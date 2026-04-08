/*=================================================================================*/
/*             GENERACION DE LIQUIDO PRODUCTO PARA UN PROVEEDOR DADO               */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_proveedor LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_fecha     LIKE Fac_header.fecha.
DEFINE INPUT PARAMETER has_fecha     LIKE Fac_header.fecha.

/*=================================================================================*/
/*                              TABLA TEMPORAL                                     */
/*=================================================================================*/

{tblliquidoproducto.i} /* Definicion de la tabla temporal de liquido producto */

DEFINE TEMP-TABLE T-Fac_header_prv           LIKE Fac_header_prv.
/*DEFINE TEMP-TABLE T-Fac_header_prv_impuesto  LIKE Fac_header_prv_impuesto.*//* Definida en el inlcude */
DEFINE TEMP-TABLE T-Fac_detalle_prv          LIKE Fac_detalle_prv.
DEFINE TEMP-TABLE T-Detalle_liquido          LIKE Detalle_liquido.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE t-cantidad AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE p-cantidad AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE a-cantidad AS DECIMAL EXTENT 4 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE t-pesos    AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE p-pesos    AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE a-pesos    AS DECIMAL EXTENT 5 FORMAT "->>>,>>>,>>9.99".

DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE ntcols     AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE idproveedor AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE columnas   AS CHARACTER FORMAT "X(124)".

DEFINE VARIABLE a-cdg_proveedor LIKE Proveedor.cdg_proveedor.
DEFINE VARIABLE a-cdg_articulo  LIKE Articulo.cdg_articulo.

/*=================================================================================*/
/*                                FRAMES                                           */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Generación de Liquido Producto" AT 55
   "Página:" AT 129 PAGE-NUMBER FORMAT ">>>9" AT 137
   SKIP
   fecha_lis
   "Período" AT 55
   des_fecha " - " has_fecha
   hora_lis AT 129
   SKIP
   idproveedor AT 55
   SKIP(1)
   WITH WIDTH 256 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM 
   header_sry 
   WITH FRAME f-subraya WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   Articulo.cdg_articulo
   t-cantidad [ 1 ] COLUMN-LABEL "Unidades!Vta.Bruta"
   t-cantidad [ 2 ] COLUMN-LABEL "Unidades!Devolucion"
   t-cantidad [ 3 ] COLUMN-LABEL "Unidades!Vta.Neta"
   t-pesos [ 1 ] COLUMN-LABEL "Pesos!Vta.Neta"
   t-pesos [ 2 ] COLUMN-LABEL "Pesos!Devolución"
   t-pesos [ 3 ] COLUMN-LABEL "Pesos!Bonificación"
   t-pesos [ 4 ] COLUMN-LABEL "Pesos!Promoción"
   t-pesos [ 5 ] COLUMN-LABEL "Neto!Líquido"
   WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

DO TRANSACTION:
    RUN LISTAR.
END.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22 ).

RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
 
    DEFINE VARIABLE v-cenfac_liquido LIKE Fac_header_prv.prf_comprob.

    RUN calcular_liquidoproducto.p ( INPUT que_proveedor,
                                     INPUT que_proveedor, /* Forzamos primer proveedor igual al último */
                                     INPUT des_fecha,
                                     INPUT has_fecha,
                                     INPUT NO, /* Forzamos comprobantes no procesados*/
                                     INPUT YES, /* Marcamos los comprobantes como procesados */
                                     OUTPUT TABLE T-Fac_header_prv_impuesto,
                                     OUTPUT TABLE T-Liquido_producto ).
    que_empresa = Empresa.nombre.
    FIND Proveedor WHERE Proveedor.cdg_proveedor = que_proveedor NO-LOCK.
    idproveedor = Proveedor.cdg_proveedor + " - " + Proveedor.nombre.
    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.

    {dirprinfile.i}
    
    fecha_lis = STRING(TODAY,"99/99/99").
    hora_lis = STRING(TIME,"HH:MM:SS").
    
    p-cantidad = 0.
    p-pesos = 0.

    IF CAN-FIND(FIRST T-Liquido_producto)
    THEN DO:
             
        RUN getparametro.p (  INPUT  "CFACLQPR",
                              OUTPUT v-valor_c,
                              OUTPUT v-valor_d,
                              OUTPUT v-valor_l,
                              OUTPUT v-valor_n,
                              OUTPUT v-observacion ).
        IF v-valor_n <> ? 
            THEN v-cenfac_liquido = v-valor_n.
            ELSE v-cenfac_liquido = 777.

        CREATE  T-Fac_header_prv.
        ASSIGN  T-Fac_header_prv.afecta_stock    = NO
                T-Fac_header_prv.ano             = MONTH(has_fecha)
                T-Fac_header_prv.anulado         = NO
                T-Fac_header_prv.cambio          = 1
                T-Fac_header_prv.cambio_dolar    = 1
                T-Fac_header_prv.cdg_condiva     = Proveedor.cdg_condiva
                T-Fac_header_prv.nro_deposito    = 1
                T-Fac_header_prv.cdg_empresa     = "M"
                T-Fac_header_prv.cdg_imputacion  = 1
                T-Fac_header_prv.cdg_lista       = 1
                T-Fac_header_prv.cdg_provincia   = Proveedor.cdg_provincia
                T-Fac_header_prv.cdg_tiporetgan  = "000"
                T-Fac_header_prv.cdg_tiporetibr  = "000"
                T-Fac_header_prv.cdg_tiporetiva  = "000"
                T-Fac_header_prv.cdg_tiporetsus  = "000"
                T-Fac_header_prv.cta_cte         = YES
                T-Fac_header_prv.cuit            = Proveedor.cuit
                T-Fac_header_prv.fecha           = has_fecha
                T-Fac_header_prv.fecha_grab      = TODAY
                T-Fac_header_prv.fecha_iva       = has_fecha
                T-Fac_header_prv.mes             = MONTH(has_fecha)
                T-Fac_header_prv.nro_cndventa    = Condicion_venta.nro_cndventa
                T-Fac_header_prv.nro_comprob     = 0
                T-Fac_header_prv.nro_deposito    = 1
                T-Fac_header_prv.nro_domicilio   = 1
                T-Fac_header_prv.nro_entidad     = 0
                T-Fac_header_prv.nro_facprov     = 0
                T-Fac_header_prv.nro_moneda      = 1
                T-Fac_header_prv.nro_obra        = 0
                T-Fac_header_prv.nro_proveedor   = Proveedor.nro_proveedor
                T-Fac_header_prv.nro_usuario     = Usuario.nro_usuario
                T-Fac_header_prv.origen          = "A"
                T-Fac_header_prv.prf_comprob     = v-cenfac_liquido
                T-Fac_header_prv.tip_comprob     = "LA"
                T-Fac_header_prv.ultima_linea    = 0
                T-Fac_header_prv.cdg_comprobante = "LIQPRODU".    

        FOR EACH T-Liquido_producto, Articulo OF T-Liquido_producto, Imputacion OF T-Liquido_producto
                       BREAK BY Articulo.cdg_articulo BY Imputacion.cdg_imputacion:
            
            VIEW FRAME frm-titulo.
    
                         /* Articulo nuevo, creamos la linea de factura de proveedor */
    
            IF FIRST-OF(Articulo.cdg_articulo)
            THEN DO:
                CREATE T-Fac_detalle_prv.
                ASSIGN T-Fac_header_prv.ultima_linea  = T-Fac_header_prv.ultima_linea + 1
                       T-Fac_detalle_prv.nro_linea    = T-Fac_header_prv.ultima_linea
                       T-Fac_detalle_prv.nro_articulo = Articulo.nro_articulo.
            END.
    
            IF FIRST-OF(Imputacion.cdg_imputacion)
            THEN DO:
    
                      /* Nueva Imputacion, creamos el acumulador para la linea de factura */
    
                CREATE T-Detalle_liquido.
                ASSIGN T-Detalle_liquido.cdg_imputacion   = Imputacion.cdg_imputacion
                       T-Detalle_liquido.granel           = 0
                       T-Detalle_liquido.granel_dev       = 0
                       T-Detalle_liquido.nro_facprov      = T-Fac_detalle_prv.nro_facprov
                       T-Detalle_liquido.nro_linea        = T-Fac_detalle_prv.nro_linea.
    
            END.
    
                        /* Acumulamos los valores para el listado y para el comprobante */
                 
            T-Detalle_liquido.cantidad      = T-Detalle_liquido.cantidad + T-Liquido_producto.cantidad.
            T-Detalle_liquido.cantidad_dev  = T-Detalle_liquido.cantidad_dev + T-Liquido_producto.cantidad_dev.
            T-Detalle_liquido.subtotal_neto = T-Detalle_liquido.subtotal_neto + T-Liquido_producto.subtotal.
    
            IF LAST-OF(Imputacion.cdg_imputacion)
            THEN DO:
                
                t-cantidad [ 1 ] = t-cantidad [ 1 ] + T-Detalle_liquido.cantidad.
                t-cantidad [ 2 ] = t-cantidad [ 2 ] + T-Detalle_liquido.cantidad_dev.
                t-pesos [ Imputacion.num_columna ] = t-pesos [ Imputacion.num_columna ] + T-Detalle_liquido.subtotal_neto.
    
            END.
    
            IF LAST-OF(Articulo.cdg_articulo)
            THEN DO:
    
                t-pesos [ 5 ] = t-pesos [ 1 ].
                DO j = 2 TO 4:
                   t-pesos [ 5 ] = t-pesos [ 5 ] + t-pesos [ j ].
                END.
    
                t-cantidad [ 3 ] = t-cantidad [ 1 ] + t-cantidad [ 2 ].
                DISPLAY Articulo.cdg_articulo   /*WHEN FIRST-OF(Articulo.cdg_articulo)*/
                        t-cantidad [ 1 ] 
                        t-cantidad [ 2 ] 
                        t-cantidad [ 3 ] 
                        t-pesos [ 1 ] 
                        t-pesos [ 2 ] 
                        t-pesos [ 3 ] 
                        t-pesos [ 4 ] 
                        t-pesos [ 5 ] 
                        WITH FRAME frm-listado STREAM-IO.
                DOWN WITH FRAME frm-listado.
    
                       /* Guarda las columnas totales en el detalle de factura de proveedor */
    
                T-Fac_detalle_prv.cantidad = t-cantidad [ 3 ].
                T-Fac_detalle_prv.subtotal_neto /*T-Fac_detalle_prv.subtotal*/  = t-pesos [ 5 ].
    
                       /* Acumula el total del proveedor para el final del listado */
    
                DO j = 1 TO 5:
                   p-pesos [ j ] = p-pesos [ j ] + t-pesos [ j ].
                END.
    
                DO j = 1 TO 4:
                   p-cantidad [ j ] = p-cantidad [ j ] + t-cantidad [ j ].
                END.
    
                t-cantidad = 0.
                t-pesos = 0.
    
            END.
    
        END.
    
                    /* Pone el total del listado que tiene que coincidir con el total de la factura */
    
        DO j = 1 TO 5:
           t-pesos [ j ] = p-pesos [ j ].
        END.
    
        DO j = 1 TO 4:
           t-cantidad [ j ] = p-cantidad [ j ].
        END.
    
        UNDERLINE
                t-cantidad [ 1 ] 
                t-cantidad [ 2 ] 
                t-cantidad [ 3 ] 
                t-pesos [ 1 ] 
                t-pesos [ 2 ] 
                t-pesos [ 3 ] 
                t-pesos [ 4 ] 
                t-pesos [ 5 ] 
                WITH FRAME frm-listado STREAM-IO.
    
        DISPLAY 
                t-cantidad [ 1 ] 
                t-cantidad [ 2 ] 
                t-cantidad [ 3 ] 
                t-pesos [ 1 ] 
                t-pesos [ 2 ] 
                t-pesos [ 3 ] 
                t-pesos [ 4 ] 
                t-pesos [ 5 ] 
                WITH FRAME frm-listado STREAM-IO.
        DOWN 2 WITH FRAME frm-listado.
    
        /*
        FOR EACH T-Fac_detalle_prv, articulo OF t-fac_detalle_prv:
            DISPLAY cdg_articulo T-Fac_detalle_prv.cantidad T-Fac_detalle_prv.subtotal.
            FOR EACH T-Detalle_liquido OF T-Fac_detalle_prv, Imputacion :
                DISPLAY T-Detalle_liquido.cantidad T-Detalle_liquido.cantidad_dev T-Detalle_liquido.subtotal T-Detalle_liquido.cdg_imputacion
                    WITH STREAM-IO NO-LABEL.
            END.
        END.
        */
    
        RUN calcular_impuestos.
        RUN bajar_tablas.
    
    END.
    ELSE DO:

        PUT "================================================================" SKIP.
        PUT "No existen operaciones por cuenta y orden pendientes de liquidar" SKIP.
        PUT "================================================================" SKIP.

    END.

    OUTPUT CLOSE.

END PROCEDURE.

PROCEDURE calcular_impuestos:

    T-Fac_header_prv.imp_neto = 0.
    FOR EACH T-fac_detalle_prv:
        T-Fac_header_prv.imp_neto = T-Fac_header_prv.imp_neto + T-Fac_detalle_prv.subtotal_neto. /*T-Fac_detalle_prv.subtotal*/
    END.

    T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_neto.
    FOR EACH T-Fac_header_prv_impuesto:
        T-Fac_header_prv.imp_total = T-Fac_header_prv.imp_total + T-Fac_header_prv_impuesto.importe.
    END.
    T-Fac_header_prv.imp_iva = T-Fac_header_prv.imp_total - T-Fac_header_prv.imp_neto.

END PROCEDURE.

PROCEDURE bajar_tablas:

    DO TRANSACTION:

        FIND Parametro WHERE Parametro.cdg_parametro = "PLQA" + STRING(T-Fac_header_prv.prf_comprob,"9999")
                         AND Parametro.cdg_empresa   = T-Fac_header_prv.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
    
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Fac_header_prv.cdg_empresa
                    Parametro.cdg_parametro = "PLQA" + STRING(T-Fac_header_prv.prf_comprob,"9999")
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Fac_header_prv.nro_comprob = Parametro.valor_n
           Parametro.valor_n        = Parametro.valor_n + 1.

        CREATE Fac_header_prv.
        BUFFER-COPY T-Fac_header_prv TO Fac_header_prv
            ASSIGN Fac_header_prv.nro_facprov = NEXT-VALUE(proxima_transaccion).
        
        FOR EACH T-Fac_detalle_prv:

            FOR EACH T-Detalle_liquido OF T-Fac_detalle_prv:
                CREATE Detalle_liquido.
                BUFFER-COPY T-Detalle_liquido TO Detalle_liquido
                    ASSIGN Detalle_liquido.nro_facprov = Fac_header_prv.nro_facprov.
            END.

            CREATE Fac_detalle_prv.
            BUFFER-COPY T-Fac_detalle_prv TO Fac_detalle_prv
                ASSIGN Fac_detalle_prv.nro_facprov = Fac_header_prv.nro_facprov.
        END.

        FOR EACH T-Fac_header_prv_impuesto:
            CREATE Fac_header_prv_impuesto.
            BUFFER-COPY T-Fac_header_prv_impuesto TO Fac_header_prv_impuesto
                ASSIGN Fac_header_prv_impuesto.nro_facprov = Fac_header_prv.nro_facprov.

        END.

        RELEASE Fac_header_prv.
        RELEASE Fac_detalle_prv.
        RELEASE Fac_header_prv_impuesto.
        RELEASE Detalle_liquido.
        RELEASE Parametro.
    
    END.

END PROCEDURE.
