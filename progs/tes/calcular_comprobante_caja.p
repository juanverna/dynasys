/*===============================================================================================*/
/*                 REALIZA EL CALCULO DE UN COMPROBANTE DE CAJA                                  */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

   DEFINE TEMP-TABLE T-Caj_header               NO-UNDO LIKE Caj_header.
   DEFINE TEMP-TABLE T-Caj_detalle              NO-UNDO LIKE Caj_detalle.
   DEFINE TEMP-TABLE T-Caja-imputacion          NO-UNDO LIKE Caja-imputacion.
   DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
   DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
   DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.
                                                                                                       
/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/
    
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_header.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caj_detalle.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Caja-imputacion.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_header.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_detalle.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_totales.

/*===============================================================================================*/
/*                               DEFINICION DE VARIABLES                                         */
/*===============================================================================================*/

   DEFINE VARIABLE x-tasa             AS DECIMAL DECIMALS 4.
   DEFINE VARIABLE x-importe          AS DECIMAL.
   DEFINE VARIABLE x-monto_imponible  AS DECIMAL.
   DEFINE VARIABLE tasa_iva           AS DECIMAL.
   DEFINE VARIABLE hubo_iva           AS LOGICAL.
   DEFINE VARIABLE v-debug            AS LOGICAL.
   DEFINE VARIABLE v-saldo_renglon    AS DECIMAL.
   DEFINE VARIABLE v-aux_importe      AS DECIMAL.
   DEFINE VARIABLE v-dif_redondeo     AS DECIMAL.

/*===============================================================================================*/
/*                                       PROCESO                                                 */
/*===============================================================================================*/

   {findempresa.i}

   FIND FIRST T-Caj_header EXCLUSIVE-LOCK.
   FIND Tipocomprobante OF T-Caj_header NO-LOCK.
   FIND Obra OF T-Caj_header NO-LOCK NO-ERROR.
   
/*----------------------------------------------------------------------------------------------*/
/*                              Borrado de las tablas temporales                                */
/*----------------------------------------------------------------------------------------------*/

   EMPTY TEMP-TABLE T-Asn_header.
   EMPTY TEMP-TABLE T-Asn_detalle.
   EMPTY TEMP-TABLE T-Asn_totales.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de asiento                               */
/*----------------------------------------------------------------------------------------------*/

   CREATE T-Asn_header.
   ASSIGN T-Asn_header.cambio             = T-Caj_header.cambio
          T-Asn_header.cambio_dolar       = T-Caj_header.cambio_dolar  
          T-Asn_header.cdg_estadoasiento  = "I"
          T-Asn_header.cdg_librocontable  = "ZZZ"                
          T-Asn_header.fecha_grab         = TODAY                
          T-Asn_header.hora_grab          = TIME                 
          T-Asn_header.nro_entidad        = 0                    
          T-Asn_header.nro_idcabecera     = T-Caj_header.nro_transaccion
          T-Asn_header.nro_secuencia      = 0                     
          T-Asn_header.num_sucursal       = ""                    
          T-Asn_header.observacion        = T-Caj_header.observacion                    
          T-Asn_header.pc_name            = T-Caj_header.pc_name             
          T-Asn_header.posteo             = "0"
          T-Asn_header.presupuestado      = ""                    
          T-Asn_header.prf_comprob        = 0                     
          T-Asn_header.reexpresa_saldos   = Tipocomprobante.reexpresa_movimiento
          T-Asn_header.tabla_comprobante  = "T-Caj_header"      

          T-Asn_header.anulado            = NO
          T-Asn_header.cdg_empresa        = T-Caj_header.cdg_empresa
          T-Asn_header.cdg_sigla-sic      = "TES"
          T-Asn_header.fecha              = T-Caj_header.fecha
          T-Asn_header.leyenda            = T-Caj_header.tip_comprob + " " +
                                            STRING(T-Caj_header.prf_comprob,"9999") + " " +
                                            STRING(T-Caj_header.nro_comprob,"99999999") +  " " +
                                            T-Caj_header.observacion
          T-Asn_header.nro_asiento        = 0
          T-Asn_header.nro_comprob        = T-Caj_header.nro_comprob
          T-Asn_header.nro_usuario        = Usuario.nro_usuario  
          T-Asn_header.nro_moneda         = T-Caj_header.nro_moneda
          T-Asn_header.origen             = "A"
          T-Asn_header.tip_comprob        = "AS"
          T-Asn_header.estado             = "*".


   IF T-Caj_header.tipo_mov = "E"
   THEN DO: 
       FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion:                          

          CREATE T-Asn_detalle.
          ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                 T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                 T-Asn_detalle.credito        = 0
                 T-Asn_detalle.debito         = Caja-imputacion.valor              
                 T-Asn_detalle.cambio         = T-Caj_header.cambio
                 T-Asn_detalle.cambio_dolar   = T-Caj_header.cambio_dolar

                 T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                 T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                 T-Asn_detalle.nro_cuenta     = Caja-imputacion.nro_cuenta          
                 T-Asn_detalle.nro_entidad    = Caja-imputacion.nro_entidad         
                 T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                 T-Asn_detalle.nro_moneda     = T-Caj_header.nro_moneda
                 T-Asn_detalle.nro_obra       = Caja-imputacion.nro_obra            
                 T-Asn_detalle.nro_subcuenta  = 0
                 T-Asn_detalle.leyen_detalle  = IF Caja-imputacion.observacion <> "" 
                                                   THEN Caja-imputacion.observacion    
                                                   ELSE T-Asn_header.leyenda.

       END.
   END.     

   FOR EACH Caj_detalle OF T-Caj_header NO-LOCK,
        Rubro OF Caj_detalle NO-LOCK, Cuenta OF Rubro NO-LOCK:

       CREATE T-Asn_detalle.
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
              T-Asn_detalle.nro_cuenta     = Rubro.nro_cuenta
              T-Asn_detalle.nro_entidad    = T-Caj_header.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = T-Caj_header.nro_moneda /* Moneda.nro_moneda OJO !!!! */
              T-Asn_detalle.nro_obra       = 0
              T-Asn_detalle.nro_subcuenta  = 0
              T-Asn_detalle.cambio         = T-Caj_header.cambio
              T-Asn_detalle.cambio_dolar   = T-Caj_header.cambio_dolar.

        IF Caj_detalle.observacion <> ""
           THEN T-Asn_detalle.leyen_detalle  = Caj_detalle.observacion.
           ELSE RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT T-Asn_detalle.leyen_detalle ).

        FIND FIRST Cheque OF Caj_detalle NO-LOCK NO-ERROR.
        IF AVAILABLE Cheque
            THEN T-Asn_detalle.leyen_detalle = STRING(Cheque.numero_cheque) + " - " + T-Asn_detalle.leyen_detalle.

       IF T-Caj_header.tipo_mov = "E"
       THEN DO:
            ASSIGN
                T-Asn_detalle.credito        = Caj_detalle.importe
                T-Asn_detalle.debito         = 0.

       END.
       ELSE DO:
           ASSIGN
                T-Asn_detalle.credito        = 0
                T-Asn_detalle.debito         = Caj_detalle.importe.
       END.

   END. /* De los detalles de subdiario de Compras */

   IF T-Caj_header.tipo_mov = "I"
   THEN DO: 

       FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = T-Caj_header.nro_transaccion NO-LOCK:

          CREATE T-Asn_detalle.
          ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                 T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                 T-Asn_detalle.credito        = Caja-imputacion.valor
                 T-Asn_detalle.debito         = 0
                 T-Asn_detalle.cambio         = T-Caj_header.cambio
                 T-Asn_detalle.cambio_dolar   = 1

                 T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                 T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                 T-Asn_detalle.nro_cuenta     = Caja-imputacion.nro_cuenta
                 T-Asn_detalle.nro_entidad    = Caja-imputacion.nro_entidad
                 T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                 T-Asn_detalle.nro_moneda     = T-Caj_header.nro_moneda
                 T-Asn_detalle.nro_obra       = Caja-imputacion.nro_obra
                 T-Asn_detalle.nro_subcuenta  = 0
                 T-Asn_detalle.leyen_detalle  = IF Caja-imputacion.observacion <> "" 
                                                   THEN Caja-imputacion.observacion 
                                                   ELSE T-Asn_header.leyenda.

       END.

   END.     

   RUN reexpresar_asiento.p ( INPUT-OUTPUT TABLE T-Asn_header,
                              INPUT-OUTPUT TABLE T-Asn_detalle,
                              INPUT-OUTPUT TABLE T-Asn_totales).
   FIND FIRST T-Asn_header.
    
   OUTPUT TO "c:\sic-temp\nobalancea.txt".
   FOR EACH t-asn_totales WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos,
      T-Asn_header OF T-Asn_totales:
    
      PUT T-Asn_header.tip_comprob T-Asn_header.prf_comprob T-Asn_header.nro_comprob
          " " T-Asn_header.leyenda T-Asn_totales.nro_moneda T-Asn_totales.reexpresion T-Asn_totales.tot_debitos T-Asn_totales.tot_creditos 
          SKIP.
    
   END.
   OUTPUT CLOSE.

/*===============================================================================================*/
/*                                PROCEDIMIENTOS                                                 */
/*===============================================================================================*/


