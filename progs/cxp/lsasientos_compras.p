/*=================================================================================*/
/*          IMPRIME UN DETALLE Y UN RESUMEN DE LOS ASIENTOS DE COMPRAS             */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        AS DATE. 
DEFINE INPUT PARAMETER has_fecha        AS DATE. 
DEFINE INPUT PARAMETER des_ptovta       AS INTEGER.
DEFINE INPUT PARAMETER has_ptovta       AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos      AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha        AS LOGICAL.
DEFINE INPUT PARAMETER gen_asiento      AS CHARACTER FORMAT "X(12)".
DEFINE INPUT PARAMETER ver_movim        AS LOGICAL LABEL "Listar Movimientos" INITIAL YES.
DEFINE INPUT PARAMETER ver_resum        AS LOGICAL LABEL "Listar Resumen" INITIAL YES.
DEFINE INPUT PARAMETER fecha_contable   LIKE Asn_header.fecha    LABEL "Fecha Contable".
DEFINE INPUT PARAMETER p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion    AS LOGICAL.


/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I "NEW"}
{dfvarimp.i}

DEFINE VARIABLE asiento_resumido        AS LOGICAL.
DEFINE VARIABLE que_asiento             AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE que_leyenda             AS CHARACTER.
DEFINE VARIABLE n-asiento_resumen       AS INTEGER INITIAL 0.

{WGLISTAR.I}

{acumasie.i}   
       
{framecontables.i "<< Asientos de Compras >>" "Asiento Resumen de Compras"}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

/*FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.*/

{findempresa.i}
que_empresa = Empresa.nombre.

RUN getparametro.p (  INPUT  "ASIENCXP",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

asiento_resumido = v-valor_l. 

RUN procesar.
IF gen_asiento <> "No Generado" THEN RUN bajar_datos.

IF ver_movim OR ver_resum
THEN DO:

    {dirprinfile.i}
    IF ver_movim   THEN RUN listar_detalle.
    IF ver_resum   THEN RUN listar_resumen.
    OUTPUT CLOSE.
    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22).
END.     
  
/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE procesar:

   tgn_debitos_tot  = 0.
   tgn_creditos_tot = 0.
   n-asiento        = 0.

   EMPTY TEMP-TABLE Acumulado.

   titulo_det = "Del " + STRING(des_fecha) + " al " + STRING(has_fecha).

   RUN pcname1.p ( OUTPUT v-pc_name ).

   FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
   v-moneda_expresion = Moneda.nro_moneda.
   IF p-reexpresion 
       THEN titulo_moneda = "Importes expresados en " + Moneda.descripcion.
       ELSE titulo_moneda = "Importes en Moneda de Origen".

   FOR EACH Sub_header_prv
        WHERE Sub_header_prv.cdg_empresa = Empresa.cdg_empresa
          AND Sub_header_prv.fecha <= has_fecha
          AND Sub_header_prv.fecha >= des_fecha
          AND CAN-DO(lista_tipos,Sub_header_prv.tip_comprob)
          AND Sub_header_prv.prf_comprob <= has_ptovta 
          AND Sub_header_prv.prf_comprob >= des_ptovta 
          AND NOT Sub_header_prv.anulado EXCLUSIVE-LOCK
              BREAK BY Sub_header_prv.fecha WITH FRAME frm-listado:
        
       FIND Proveedor OF Sub_header_prv NO-LOCK.
       FIND Tipocomprobante OF Sub_header_prv NO-LOCK.
       FIND Fac_header_prv OF Sub_header_prv NO-LOCK.

       CREATE T-Asn_header.
       ASSIGN n-asiento                       = n-asiento + 1

              T-Asn_header.cambio             = Sub_header_prv.cambio
              T-Asn_header.cambio_dolar       = 1  
              T-Asn_header.cdg_estadoasiento  = "0"
              T-Asn_header.cdg_librocontable  = "ZZZ"                
              T-Asn_header.fecha_grab         = TODAY                
              T-Asn_header.hora_grab          = TIME                 
              T-Asn_header.nro_entidad        = 0                    
              T-Asn_header.nro_idcabecera     = Fac_header_prv.nro_facprov
              T-Asn_header.nro_secuencia      = 0                     
              T-Asn_header.num_sucursal       = ""                    
              T-Asn_header.observacion        = ""                    
              T-Asn_header.pc_name            = v-pc_name             
              T-Asn_header.posteo             = "0"                   
              T-Asn_header.presupuestado      = ""                    
              T-Asn_header.prf_comprob        = 0                     
              T-Asn_header.reexpresa_saldos   = Tipocomprobante.reexpresa_movimiento
              T-Asn_header.tabla_comprobante  = "Fac_header_prv"      

              T-Asn_header.anulado            = NO
              T-Asn_header.cdg_empresa        = Sub_header_prv.cdg_empresa
              T-Asn_header.cdg_sigla-sic      = "CXP"
              T-Asn_header.fecha              = Sub_header_prv.fecha
              T-Asn_header.leyenda            = Sub_header_prv.tip_comprob + " " +
                                                STRING(Sub_header_prv.prf_comprob,"9999") + " " +
                                                STRING(Sub_header_prv.nro_comprob,"99999999") +  " " +
                                                IF AVAILABLE Proveedor 
                                                   THEN "[" + Proveedor.cdg_proveedor + "] " + Proveedor.nombre
                                                   ELSE ""
              T-Asn_header.nro_asiento        = n-asiento
              T-Asn_header.nro_comprob        = n-asiento
              T-Asn_header.nro_usuario        = Usuario.nro_usuario
              T-Asn_header.nro_moneda         = Sub_header_prv.nro_moneda
              T-Asn_header.origen             = "A"
              T-Asn_header.tip_comprob        = "AS"
              T-Asn_header.estado             = IF Sub_header_prv.contable THEN "*" ELSE "P".
              
       
       IF Tipocomprobante.debita  /* Debitamos encabezado si corresponde */
       THEN DO: 
          tgn_debitos_tot = tgn_debitos_tot + Sub_header_prv.imp_total.
          CREATE T-Asn_detalle.
          ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                 /*T-Asn_detalle.bimonetario    = NO*/
                 T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                 T-Asn_detalle.credito        = 0
                 T-Asn_detalle.debito         = Sub_header_prv.imp_total
                 T-Asn_detalle.cambio         = Sub_header_prv.cambio
                 T-Asn_detalle.cambio_dolar   = 1
                 T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                 T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                 T-Asn_detalle.nro_cuenta     = Sub_header_prv.nro_cuenta
                 T-Asn_detalle.nro_entidad    = Sub_header_prv.nro_entidad
                 T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                 T-Asn_detalle.nro_moneda     = Sub_header_prv.nro_moneda
                 T-Asn_detalle.nro_obra       = 0
                 T-Asn_detalle.nro_subcuenta  = 0.
       
          RUN acumular_debcred.

       END.     

       FOR EACH Sub_detalle_prv WHERE Sub_detalle_prv.cdg_empresa   = Sub_header_prv.cdg_empresa
                                  AND Sub_detalle_prv.tip_comprob   = Sub_header_prv.tip_comprob
                                  AND Sub_detalle_prv.prf_comprob   = Sub_header_prv.prf_comprob
                                  AND Sub_detalle_prv.nro_comprob   = Sub_header_prv.nro_comprob
                                  AND Sub_detalle_prv.nro_proveedor = Sub_header_prv.nro_proveedor
                                      EXCLUSIVE-LOCK, Cuenta OF Sub_detalle_prv:

           CREATE T-Asn_detalle.
           ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                  T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                  T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                  T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
                  T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                  T-Asn_detalle.nro_cuenta     = Sub_detalle_prv.nro_cuenta
                  T-Asn_detalle.nro_entidad    = Sub_detalle_prv.nro_entidad
                  T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                  T-Asn_detalle.nro_moneda     = Sub_header_prv.nro_moneda
                  T-Asn_detalle.nro_obra       = Sub_detalle_prv.nro_obra  
                  T-Asn_detalle.nro_subcuenta  = 0
                  T-Asn_detalle.cambio         = Sub_header_prv.cambio
                  T-Asn_detalle.cambio_dolar   = 1.

           IF Tipocomprobante.debita
           THEN DO:
               tgn_creditos_tot = tgn_creditos_tot + Sub_detalle_prv.valor.
               T-Asn_detalle.credito  = Sub_detalle_prv.valor.
               T-Asn_detalle.debito   = 0.
           END.
           ELSE DO:
               tgn_debitos_tot = tgn_debitos_tot + Sub_detalle_prv.valor.
               T-Asn_detalle.credito  = 0.
               T-Asn_detalle.debito   = Sub_detalle_prv.valor.
           END.
           
           RUN acumular_debcred.
         
       END. /* De los detalles de subdiario de Compras */
           
       IF NOT Tipocomprobante.debita /* Acreditamos encabezado si corresponde */
       THEN DO: 
          tgn_creditos_tot = tgn_creditos_tot + Sub_header_prv.imp_total.           
          CREATE T-Asn_detalle.
          ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                 T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                 T-Asn_detalle.credito        = Sub_header_prv.imp_total
                 T-Asn_detalle.debito         = 0

                 T-Asn_detalle.cambio         = Sub_header_prv.cambio
                 T-Asn_detalle.cambio_dolar   = 1

                 T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                 T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
                 T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                 T-Asn_detalle.nro_cuenta     = Sub_header_prv.nro_cuenta
                 T-Asn_detalle.nro_entidad    = Sub_header_prv.nro_entidad
                 T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                 T-Asn_detalle.nro_moneda     = Sub_header_prv.nro_moneda
                 T-Asn_detalle.nro_obra       = 0
                 T-Asn_detalle.nro_subcuenta  = 0.

          RUN acumular_debcred.

        END.     

        IF gen_asiento <> "No Generado" THEN Sub_header_prv.contable = YES.

   END. /* De los movimientos de subdiario */

   RUN planchar_saldos.  /* Acomoda débitos y créditos en el acumulado en formato de asiento */

   /* Reexpresa los movimientos en otras monedas y ajusta las diferencias de redondeo */
   
   FOR EACH T-Asn_header:

       RUN reexpresar_asiento.

       FOR EACH T-Asn_detalle OF T-Asn_header:
           RUN acumular_debcred.
       END.

       FOR EACH T-Asn_totales OF T-Asn_header
           WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos
             AND T-Asn_totales.reexpresion:

           RUN planchar_redondeos.

       END. 

   END.

                      /* Si hay movimientos pendientes de contabilizar, crea asiento resumen de Compras */

   IF tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0
   THEN DO:
        RUN generar_asiento_resumen ( INPUT "CXP",
                                      INPUT "Resumen de compras " + titulo_det).
   END.

END PROCEDURE.

{procontables.i} /* Procesos contables de acumulacion, registro y persistencia de asientos */

