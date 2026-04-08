/*===============================================================================================*/
/*                              REEXPRESA UN ASIENTO CONTABLE                                    */
/*===============================================================================================*/

/*===============================================================================================*/
/*                           DEFINICION DE LAS TABLAS TEMPORALES                                 */
/*===============================================================================================*/

   DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
   DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
   DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.

/*===============================================================================================*/
/*                               DEFINICION DE PARAMETROS                                        */
/*===============================================================================================*/
    
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_header.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_detalle.
   DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Asn_totales.

/*===============================================================================================*/
/*                               DEFINICION DE VARIABLES                                         */
/*===============================================================================================*/

   DEFINE BUFFER T-Reexpresion         FOR T-Asn_detalle.
  
/*===============================================================================================*/
/*                                      PROCESO                                                  */
/*===============================================================================================*/

   FIND FIRST T-Asn_header.

   RUN reexpresar_asiento.

   FOR EACH T-Asn_detalle /*OF T-Asn_header*/:
       RUN acumular_debcred.
   END.

   FOR EACH T-Asn_totales /*OF T-Asn_header*/
       WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos
         AND T-Asn_totales.reexpresion:

       RUN planchar_redondeos.

   END. 

/*===============================================================================================*/
/*                                    PROCEDIMIENTOS                                             */
/*===============================================================================================*/

PROCEDURE reexpresar_asiento :

   DEFINE VARIABLE x-cotiza_origen AS DATE.

   FOR EACH T-Asn_detalle OF T-Asn_header WHERE NOT T-Asn_detalle.reexpresion:

      /* ----------------------------------------------------------------------------- */
      /* Recorre las monedas para las cuales la cuenta del movimiento reexpresa saldos */
      /* ----------------------------------------------------------------------------- */
    
       IF T-Asn_header.reexpresa_saldos
       THEN DO:

           FOR EACH  Cuenta-moneda 
              WHERE Cuenta-moneda.nro_cuenta = T-Asn_detalle.nro_cuenta NO-LOCK: 

              /* ---------------------------------------- */
              /* Busca la reexpresion en esta moneda.     */
              /* ---------------------------------------- */

              FIND T-Reexpresion 
                   WHERE T-Reexpresion.nro_asiento = T-Asn_detalle.nro_asiento
                     AND T-Reexpresion.nro_linea   = T-Asn_detalle.nro_linea
                     AND T-Reexpresion.nro_moneda  = Cuenta-moneda.nro_moneda
                     AND T-Reexpresion.reexpresion
                         EXCLUSIVE-LOCK NO-ERROR.

              /* ---------------------------------------- */
              /* Si no esta, la crea, asignando el cambio */
              /* ---------------------------------------- */

              IF NOT AVAILABLE T-Reexpresion
              THEN DO:

                  CREATE T-Reexpresion.
                  BUFFER-COPY T-Asn_detalle TO T-Reexpresion
                        ASSIGN T-Reexpresion.nro_moneda  = Cuenta-moneda.nro_moneda
                               T-Reexpresion.reexpresion = YES.

              END.


              IF Cuenta-moneda.nro_moneda <> T-Asn_detalle.nro_moneda
              THEN DO:     
                  FIND Moneda OF T-Reexpresion NO-LOCK.
                  RUN cotizar_moneda.p  ( INPUT   Moneda.cdg_moneda, 
                                          INPUT   T-Asn_header.cdg_empresa,  
                                          INPUT   T-Asn_header.fecha, 
                                          OUTPUT  T-Reexpresion.cambio, 
                                          OUTPUT  x-cotiza_origen).

                  ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  /  T-Reexpresion.cambio * T-Asn_detalle.cambio
                         T-Reexpresion.credito = T-Asn_detalle.credito /  T-Reexpresion.cambio * T-Asn_detalle.cambio.
              END.
              ELSE DO:
                  ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  
                         T-Reexpresion.credito = T-Asn_detalle.credito
                         T-Reexpresion.cambio  = T-Asn_detalle.cambio.
              END.

          END.

       END.
       ELSE DO:
           CREATE T-Reexpresion.
           BUFFER-COPY T-Asn_detalle TO T-Reexpresion
                 ASSIGN T-Reexpresion.reexpresion = YES.
       END.

   END.

END PROCEDURE.

PROCEDURE acumular_debcred:

   FIND T-Asn_totales
       WHERE T-Asn_totales.nro_asiento = T-Asn_header.nro_asiento
         AND T-Asn_totales.nro_moneda  = T-Asn_detalle.nro_moneda 
         AND T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion 
             NO-ERROR.

   IF NOT AVAILABLE T-Asn_totales
   THEN DO:
       CREATE T-Asn_totales.
       ASSIGN T-Asn_totales.nro_asiento = T-Asn_header.nro_asiento 
              T-Asn_totales.nro_moneda  = T-Asn_detalle.nro_moneda
              T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion.
   END.

   ASSIGN T-Asn_totales.tot_debitos  = T-Asn_totales.tot_debitos  + T-Asn_detalle.debito
          T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + T-Asn_detalle.credito
          T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

END PROCEDURE.

PROCEDURE planchar_redondeos:

   DEFINE VARIABLE v-saldo_diferencia  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Diferencia".

   v-saldo_diferencia = ABS(T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos).

   IF v-saldo_diferencia < 1
   THEN DO:

       DO WHILE v-saldo_diferencia <> 0:

           FOR EACH T-Asn_detalle OF T-Asn_header 
               WHERE T-Asn_detalle.reexpresion 
                 AND T-Asn_detalle.nro_moneda = T-Asn_totales.nro_moneda
                     BY T-Asn_detalle.debito + T-Asn_detalle.credito DESCENDING WHILE v-saldo_diferencia <> 0:

               IF T-Asn_totales.tot_debitos > T-Asn_totales.tot_creditos 
               THEN DO:
                   IF T-Asn_detalle.debito <> 0
                       THEN ASSIGN T-Asn_detalle.debito = T-Asn_detalle.debito - 0.01
                                   T-Asn_totales.tot_debitos = T-Asn_totales.tot_debitos - 0.01.
                       ELSE ASSIGN T-Asn_detalle.credito = T-Asn_detalle.credito + 0.01
                                   T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + 0.01.
    
                END.
                ELSE DO:
                    IF T-Asn_detalle.debito <> 0
                        THEN ASSIGN T-Asn_detalle.debito = T-Asn_detalle.debito + 0.01
                                    T-Asn_totales.tot_debitos = T-Asn_totales.tot_debitos + 0.01.
                        ELSE ASSIGN T-Asn_detalle.credito = T-Asn_detalle.credito - 0.01
                                    T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos - 0.01.
                END.
            
                v-saldo_diferencia = v-saldo_diferencia - 0.01.
    
           END.

       END.
    
       T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

   END.

END PROCEDURE.

/*{procedimientos_asientos.i}*/
