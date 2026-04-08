/*=================================================================================*/
/*       LISTA ASIENTOS DE CAJA Y GENERA LOS ASIENTOS PARA CONTABILIDAD            */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_caja         LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER has_caja         LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER ver_movim        AS LOGICAL.
DEFINE INPUT PARAMETER ver_resum        AS LOGICAL.
DEFINE INPUT PARAMETER gen_asiento      AS CHARACTER.
DEFINE INPUT PARAMETER fecha_contable   LIKE Asn_header.fecha.
DEFINE INPUT PARAMETER p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion    AS LOGICAL.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{parlocales.i}
{dfvarimp.i }

DEFINE VARIABLE asiento_resumido        AS LOGICAL.
DEFINE VARIABLE que_leyenda             AS CHARACTER.
DEFINE VARIABLE n-asiento_resumen       AS INTEGER INITIAL 0.

DEFINE BUFFER B-Cuenta     FOR Cuenta.
DEFINE BUFFER B-Caj_header FOR Caj_header.

{wglistar.i}
{acumasie.i}   
{framecontables.i "<< Asientos de Tesorería >>" "Asiento Resumen de Tesorería"}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FIND FIRST Moneda WHERE Moneda.es_local NO-LOCK.

{findempresa.i}
que_empresa = Empresa.nombre.

RUN getparametro.p (  INPUT  "ASIENTES",
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

   FOR EACH Acumulado:
       DELETE Acumulado.
   END.    

   titulo_det = "Del " + STRING(des_fecha) + " al " + STRING(has_fecha).

   RUN pcname1.p ( OUTPUT v-pc_name ).

   FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
   v-moneda_expresion = Moneda.nro_moneda.
   IF p-reexpresion 
       THEN titulo_moneda = "Importes expresados en " + Moneda.descripcion.
       ELSE titulo_moneda = "Importes en Moneda de Origen".

   FOR EACH  Caj_header
       WHERE Caj_header.fecha >= des_fecha 
         AND Caj_header.fecha <= has_fecha
         AND Caj_header.cdg_caja >= des_caja 
         AND Caj_header.cdg_caja <= has_caja
         AND Caj_header.cdg_empresa = Empresa.cdg_empresa
         AND Caj_header.estado <> "A" NO-LOCK
             /*BREAK BY Caj_header.fecha*/ WITH FRAME frm-listado:

       FIND Tipocomprobante OF Caj_header NO-LOCK.

       CREATE T-Asn_header.
       ASSIGN n-asiento                       = n-asiento + 1

              T-Asn_header.cambio             = Caj_header.cambio
              T-Asn_header.cambio_dolar       = Caj_header.cambio_dolar  
              T-Asn_header.cdg_estadoasiento  = "I"
              T-Asn_header.cdg_librocontable  = "ZZZ"                
              T-Asn_header.fecha_grab         = TODAY                
              T-Asn_header.hora_grab          = TIME                 
              T-Asn_header.nro_entidad        = 0                    
              T-Asn_header.nro_idcabecera     = Caj_header.nro_transaccion
              T-Asn_header.nro_secuencia      = 0                     
              T-Asn_header.num_sucursal       = ""                    
              T-Asn_header.observacion        = Caj_header.observacion                    
              T-Asn_header.pc_name            = v-pc_name             
              T-Asn_header.posteo             = "0"
              T-Asn_header.presupuestado      = ""                    
              T-Asn_header.prf_comprob        = 0                     
              T-Asn_header.reexpresa_saldos   = Tipocomprobante.reexpresa_movimiento
              T-Asn_header.tabla_comprobante  = "Caj_header"      

              T-Asn_header.anulado            = NO
              T-Asn_header.cdg_empresa        = Caj_header.cdg_empresa
              T-Asn_header.cdg_sigla-sic      = "TES"
              T-Asn_header.fecha              = Caj_header.fecha
              T-Asn_header.leyenda            = Caj_header.tip_comprob + " " +
                                                STRING(Caj_header.prf_comprob,"9999") + " " +
                                                STRING(Caj_header.nro_comprob,"99999999") +  " " +
                                                Caj_header.observacion
              T-Asn_header.nro_asiento        = n-asiento
              T-Asn_header.nro_comprob        = n-asiento
              T-Asn_header.nro_usuario        = Usuario.nro_usuario  
              T-Asn_header.nro_moneda         = Caj_header.nro_moneda
              T-Asn_header.origen             = "A"
              T-Asn_header.tip_comprob        = "AS"
              T-Asn_header.estado             = IF Caj_header.contable THEN "*" ELSE "P".
              
       
       IF Caj_header.tipo_mov = "E"
       THEN DO: 
           FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion:                          

              tgn_debitos_tot = tgn_debitos_tot + Caj_header.importe.
              CREATE T-Asn_detalle.
              ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                     T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                     T-Asn_detalle.credito        = 0
                     T-Asn_detalle.debito         = Caja-imputacion.valor              
                     T-Asn_detalle.cambio         = Caj_header.cambio
                     T-Asn_detalle.cambio_dolar   = Caj_header.cambio_dolar
    
                     T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                     T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                     T-Asn_detalle.nro_cuenta     = Caja-imputacion.nro_cuenta          
                     T-Asn_detalle.nro_entidad    = Caja-imputacion.nro_entidad         
                     T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                     T-Asn_detalle.nro_moneda     = Caj_header.nro_moneda
                     T-Asn_detalle.nro_obra       = Caja-imputacion.nro_obra            
                     T-Asn_detalle.nro_subcuenta  = 0
                     T-Asn_detalle.leyen_detalle  = IF Caja-imputacion.observacion <> "" 
                                                       THEN Caja-imputacion.observacion    
                                                       ELSE T-Asn_header.leyenda.
    
              RUN acumular_debcred.
           END.
       END.     

       FOR EACH Caj_detalle OF Caj_header NO-LOCK,
            Rubro OF Caj_detalle NO-LOCK, Cuenta OF Rubro NO-LOCK:
                     
           CREATE T-Asn_detalle.
           ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                  T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                  T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                  T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                  T-Asn_detalle.nro_cuenta     = Rubro.nro_cuenta
                  T-Asn_detalle.nro_entidad    = Caj_header.nro_entidad
                  T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                  T-Asn_detalle.nro_moneda     = Caj_header.nro_moneda /* Moneda.nro_moneda OJO !!!! */
                  T-Asn_detalle.nro_obra       = 0
                  T-Asn_detalle.nro_subcuenta  = 0
                  T-Asn_detalle.cambio         = Caj_header.cambio
                  T-Asn_detalle.cambio_dolar   = Caj_header.cambio_dolar.
                  
            IF Caj_detalle.observacion <> ""
               THEN T-Asn_detalle.leyen_detalle  = Caj_detalle.observacion.
               ELSE RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT T-Asn_detalle.leyen_detalle ).
               
            FIND FIRST Cheque OF Caj_detalle NO-LOCK NO-ERROR.
            IF AVAILABLE Cheque
                THEN T-Asn_detalle.leyen_detalle = STRING(Cheque.numero_cheque) + " - " + T-Asn_detalle.leyen_detalle.

           IF Caj_header.tipo_mov = "E"
           THEN DO:
                tgn_creditos_tot = tgn_creditos_tot + Caj_detalle.importe.           
                ASSIGN
                    T-Asn_detalle.credito        = Caj_detalle.importe
                    T-Asn_detalle.debito         = 0.

           END.
           ELSE DO:
               tgn_debitos_tot = tgn_debitos_tot + Caj_detalle.importe.
                ASSIGN
                    T-Asn_detalle.credito        = 0
                    T-Asn_detalle.debito         = Caj_detalle.importe.
           END.

           RUN acumular_debcred.
         
       END. /* De los detalles de subdiario de Compras */
           
       IF Caj_header.tipo_mov = "I"
       THEN DO: 

           FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion NO-LOCK:

              tgn_debitos_tot = tgn_debitos_tot + Caj_header.importe.
              CREATE T-Asn_detalle.
              ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
                     T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
                     T-Asn_detalle.credito        = Caja-imputacion.valor
                     T-Asn_detalle.debito         = 0
                     T-Asn_detalle.cambio         = Caj_header.cambio
                     T-Asn_detalle.cambio_dolar   = 1
    
                     T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
                     T-Asn_detalle.nro_asiento    = T-Asn_header.nro_asiento
                     T-Asn_detalle.nro_cuenta     = Caja-imputacion.nro_cuenta
                     T-Asn_detalle.nro_entidad    = Caja-imputacion.nro_entidad
                     T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
                     T-Asn_detalle.nro_moneda     = Caj_header.nro_moneda
                     T-Asn_detalle.nro_obra       = Caja-imputacion.nro_obra
                     T-Asn_detalle.nro_subcuenta  = 0
                     T-Asn_detalle.leyen_detalle  = IF Caja-imputacion.observacion <> "" 
                                                       THEN Caja-imputacion.observacion 
                                                       ELSE T-Asn_header.leyenda.
    
              RUN acumular_debcred.

           END.

       END.     

       IF gen_asiento <> "No Generado" 
       THEN DO:
           FIND B-Caj_header WHERE ROWID(B-Caj_header) = ROWID(Caj_header) EXCLUSIVE-LOCK.
           B-Caj_header.contable = YES.
           RELEASE B-Caj_header.
       END.

   END. /* De los movimientos de subdiario */

   RUN planchar_saldos.  /* Acomoda débitos y créditos en el acumulado en formato de asiento */

   /* Reexpresa los movimientos en otras monedas y ajusta las diferencias de redondeo */

   FOR EACH T-Asn_header:

       IF T-Asn_header.reexpresa_saldos
           THEN RUN reexpresar_asiento.

       FOR EACH T-Asn_detalle OF T-Asn_header:
           RUN acumular_debcred.
       END.

       FOR EACH T-Asn_totales OF T-Asn_header
           WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos
             AND T-Asn_totales.reexpresion:

           RUN planchar_redondeos.

       END.

   END.

   OUTPUT TO "c:\sic-temp\nobalancea.txt".
   FOR EACH t-asn_totales WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos,
       T-Asn_header OF T-Asn_totales:

       PUT T-Asn_header.tip_comprob T-Asn_header.prf_comprob T-Asn_header.nro_comprob
           " " T-Asn_header.leyenda T-Asn_totales.nro_moneda T-Asn_totales.reexpresion T-Asn_totales.tot_debitos T-Asn_totales.tot_creditos 
           SKIP.

   END.
   OUTPUT CLOSE.

END PROCEDURE.

{procontables.i} /* Procesos contables de acumulacion, registro y persistencia de asientos */


