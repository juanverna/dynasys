/*=================================================================================*/
/*     GENERA RECURSIVAMENTE LAS ORDENES DE FABRICA DE UN PLAN DE PRODUCCION       */
/*=================================================================================*/

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER         p-nro_articulo         LIKE Articulo.nro_articulo.
DEFINE INPUT PARAMETER         p-cantidad_compuesto   AS DECIMAL.
DEFINE INPUT PARAMETER         p-granel_compuesto     AS DECIMAL.
DEFINE INPUT PARAMETER         p-nro_planprod         AS INTEGER.
DEFINE OUTPUT PARAMETER        p-nro_ofabrica         AS INTEGER.
DEFINE INPUT-OUTPUT PARAMETER  p-num_ofabrica         AS INTEGER.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

DEFINE VARIABLE x-cantidad_componente         AS DECIMAL.
DEFINE VARIABLE x-granel_componente           AS DECIMAL.
DEFINE VARIABLE x-cantidad_compuesto          AS DECIMAL.
DEFINE VARIABLE x-granel_compuesto            AS DECIMAL.

DEFINE VARIABLE stock_compuesto_cantidad      LIKE Cct_stock.cantidad. /* Existencia real compuesto */
DEFINE VARIABLE stock_compuesto_granel        LIKE Cct_stock.granel.   /* Existencia real compuesto */
DEFINE VARIABLE presup_compuesto_cantidad     LIKE Cct_stock.cantidad. /* Existencia presupuestada ompuesto */
DEFINE VARIABLE presup_compuesto_granel       LIKE Cct_stock.granel.   /* Existencia presupuestada ompuesto */

{dfmodoexist.i}

DEFINE STREAM Seguimiento.
DEFINE BUFFER B-Articulo FOR Articulo.

DEFINE VARIABLE arch_log AS CHARACTER.

/*=================================================================================*/
/*                                     PROCESO                                     */
/*=================================================================================*/

FIND Planprod_hd WHERE Planprod_hd.nro_planprod = p-nro_planprod NO-LOCK.

RUN getparametro_c.p (  INPUT  "DIRECTMP", OUTPUT arch_log).
IF arch_log = ? THEN arch_log = SESSION:TEMP-DIRECTORY.
arch_log = arch_log + "\" + Planprod_hd.tip_comprob + 
                            STRING(Planprod_hd.prf_comprob,"9999") + 
                            STRING(Planprod_hd.nro_comprob,"99999999")  + " .log".

OUTPUT STREAM Seguimiento TO VALUE(arch_log) APPEND PAGE-SIZE 0.

FIND Articulo WHERE Articulo.nro_articulo = p-nro_articulo NO-LOCK.

RUN calcular_stock.p ( INPUT ROWID(Articulo),
                       INPUT ?, /* No especificamos deposito. Todos los depositos */
                       INPUT ?, /* No especificamos partidas. Todas las partidas */
                       INPUT Planprod_hd.fecha_inicio,
                       INPUT tod, /* Especificamos todos los depositos */
                       OUTPUT stock_compuesto_cantidad,  
                       OUTPUT stock_compuesto_granel,    
                       OUTPUT presup_compuesto_cantidad,  
                       OUTPUT presup_compuesto_granel ).    

IF CAN-FIND(FIRST Formula_articulo WHERE Formula_articulo.nro_art_compuesto = Articulo.nro_articulo)
THEN DO:

    PUT STREAM Seguimiento "==============================================================" SKIP
                           "O/F:" p-num_ofabrica " Articulo:" Articulo.cdg_articulo SKIP
                           "necesidad cantidad......:"  p-cantidad_compuesto SKIP                     
                           "necesidad granel........:"  p-granel_compuesto   SKIP
                           "--------------------------------------------------------------" SKIP
                           "stock_cantidad .........:"  stock_compuesto_cantidad   SKIP
                           "stock_granel ...........:"  stock_compuesto_granel     SKIP
                           "presup_cantidad ........:"  presup_compuesto_cantidad  SKIP
                           "presup_granel ..........:"  presup_compuesto_granel    SKIP
                           "--------------------------------------------------------------" SKIP.
    CREATE Ofabrica_hd.
    ASSIGN Ofabrica_hd.cdg_empresa       = Planprod_hd.cdg_empresa
           Ofabrica_hd.cdg_estado        = ""                 
           Ofabrica_hd.estado            = "E"                
           Ofabrica_hd.fecha             = Planprod_hd.fecha_inicio
           Ofabrica_hd.fecha_grab        = TODAY              
           Ofabrica_hd.hora              = ""                 
           Ofabrica_hd.hora_grab         = TIME
           Ofabrica_hd.leyenda           = ""
           Ofabrica_hd.nro_area          = 0
           Ofabrica_hd.nro_comprob       = p-num_ofabrica
           Ofabrica_hd.nro_empleado_resp = 0
           Ofabrica_hd.nro_ofabrica      = NEXT-VALUE(proxima_ofabrica)
           Ofabrica_hd.nro_planprod      = Planprod_hd.nro_planprod
           Ofabrica_hd.origen            = "A"
           Ofabrica_hd.prf_comprob       = 0
           Ofabrica_hd.tip_comprob       = "OF"
           Ofabrica_hd.ultima_linea      = 1
           p-num_ofabrica                = p-num_ofabrica + 1
           p-nro_ofabrica                = Ofabrica_hd.nro_ofabrica.
    
    RUN completar_auditoria.p ( OUTPUT Ofabrica_hd.nro_usuario, 
                                OUTPUT Ofabrica_hd.fecha_grab,
                                OUTPUT Ofabrica_hd.hora_grab,
                                OUTPUT Ofabrica_hd.pc_name ).
            
    CREATE Ofabrica_dt.
    ASSIGN Ofabrica_dt.cantidad          = MAXIMUM(p-cantidad_compuesto - stock_compuesto_cantidad,0) /* Se produce lo necesario */
           Ofabrica_dt.cantidad_cum      = 0
           Ofabrica_dt.cantidad_sol      = p-cantidad_compuesto /* Se reserva el total */
           Ofabrica_dt.cantidad_ult      = 0
           Ofabrica_dt.cdg_estado        = Ofabrica_hd.cdg_estado
           Ofabrica_dt.cumplido          = NO
           Ofabrica_dt.granel            = MAXIMUM(p-granel_compuesto - stock_compuesto_granel,0) /* Se produce lo necesario */
           Ofabrica_dt.granel_cum        = 0
           Ofabrica_dt.granel_sol        = p-granel_compuesto /* Se reserva el total */
           Ofabrica_dt.granel_ult        = 0
           Ofabrica_dt.nro_articulo      = Articulo.nro_articulo
           Ofabrica_dt.nro_linea         = Ofabrica_hd.ultima_linea
           Ofabrica_dt.nro_obra          = 0
           Ofabrica_dt.nro_ofabrica      = Ofabrica_hd.nro_ofabrica
           Ofabrica_dt.nro_partida       = 0
           Ofabrica_dt.nro_pedido        = 0 
           Ofabrica_dt.observacion       = ""
           Ofabrica_dt.tipo_detalle      = "P"
           Ofabrica_hd.ultima_linea      = Ofabrica_hd.ultima_linea + 1.
    

    ASSIGN x-cantidad_compuesto  = Ofabrica_dt.cantidad
           x-granel_compuesto    = Ofabrica_dt.granel.

    PUT STREAM Seguimiento "elaboracion cantidad ...:"  x-cantidad_compuesto SKIP                     
                           "elaboracion granel .....:"  x-granel_compuesto   SKIP
                           "--------------------------------------------------------------" SKIP.

    IF x-cantidad_compuesto <> 0 OR x-granel_compuesto <> 0
    THEN DO:

        FOR EACH Formula_articulo NO-LOCK WHERE Formula_articulo.nro_art_compuesto = Articulo.nro_articulo:

            ASSIGN x-cantidad_componente  = x-cantidad_compuesto / 
                                            Formula_articulo.cantidad_compuesto * 
                                            Formula_articulo.cantidad_componente
        
                   x-granel_componente    = x-granel_compuesto / 
                                            Formula_articulo.granel_compuesto * 
                                            Formula_articulo.granel_componente.

            FIND B-Articulo WHERE B-Articulo.nro_articulo = Formula_articulo.nro_art_componente NO-LOCK.
            PUT STREAM Seguimiento "Componente .............:" Articulo.cdg_articulo " " Articulo.descripcion
                                   "form.cantidad compuesto.:" Formula_articulo.cantidad_compuesto SKIP
                                   "form.granel compuesto...:" Formula_articulo.granel_compuesto SKIP
                                   "form.cantidad componen .:" Formula_articulo.cantidad_componente SKIP
                                   "form.granel componente .:" Formula_articulo.granel_componente SKIP
                                   "consumo cantidad .......:" x-cantidad_componente SKIP                     
                                   "consumo granel .........:" x-granel_componente   SKIP
                                   "--------------------------------------------------------------" SKIP.

            CREATE Ofabrica_dt.
            ASSIGN Ofabrica_dt.cantidad          = x-cantidad_componente
                   Ofabrica_dt.cantidad_cum      = 0
                   Ofabrica_dt.cantidad_sol      = x-cantidad_componente
                   Ofabrica_dt.cantidad_ult      = 0
                   Ofabrica_dt.cdg_estado        = Ofabrica_hd.cdg_estado
                   Ofabrica_dt.cumplido          = NO
                   Ofabrica_dt.granel            = x-granel_componente
                   Ofabrica_dt.granel_cum        = 0
                   Ofabrica_dt.granel_sol        = x-granel_componente
                   Ofabrica_dt.granel_ult        = 0
                   Ofabrica_dt.nro_articulo      = Formula_articulo.nro_art_componente
                   Ofabrica_dt.nro_linea         = Ofabrica_hd.ultima_linea
                   Ofabrica_dt.nro_obra          = 0
                   Ofabrica_dt.nro_ofabrica      = Ofabrica_hd.nro_ofabrica
                   Ofabrica_dt.nro_partida       = 0
                   Ofabrica_dt.nro_pedido        = 0 
                   Ofabrica_dt.observacion       = ""
                   Ofabrica_dt.tipo_detalle      = "C"
                   Ofabrica_hd.ultima_linea      = Ofabrica_hd.ultima_linea + 1.
        
            RUN generar_ofabrica.p ( INPUT Formula_articulo.nro_art_componente,
                                     INPUT x-cantidad_componente,
                                     INPUT x-granel_componente,
                                     INPUT Planprod_hd.nro_planprod,
                                     OUTPUT Ofabrica_dt.nro_ofsiguiente,
                                     INPUT-OUTPUT p-num_ofabrica).
        
            RELEASE Ofabrica_dt.
        
        END.

    END.
    
    RUN emitir_ofabrica.p ( INPUT ROWID(Ofabrica_hd) ).
    
    RELEASE Ofabrica_hd.

END.

