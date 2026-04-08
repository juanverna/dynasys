/*=========================================================================================================*/
/*      DEFINICION DE PROCESOS PERTINENTES A LOS PROCESOS DE GENERACION DE ASIENTOS DESDE LOS MODULOS      */
/*=========================================================================================================*/

PROCEDURE listar_detalle:

   DEFINE VARIABLE v-balancea AS CHARACTER.

   /* -----------------------------------------------------------------------------------------------
       N-ASIENTO-0 Y N-ASIENTO-1 
       Se utilizan para controlar si se esta imprimiendo el detalle o el resumen. En el primer caso
       tienen valores 1 y 9999999 respectivamente. En el segundo caso, ambos son CERO 
      ----------------------------------------------------------------------------------------------- */

   FOR EACH T-Asn_header 
       WHERE T-Asn_header.nro_asiento >= n-asiento-0 
         AND T-Asn_header.nro_asiento <= n-asiento-1:
       
       VIEW FRAME frm-titulo.

       FIND Moneda WHERE Moneda.nro_moneda = T-Asn_header.nro_moneda NO-LOCK.

       DISPLAY T-Asn_header.fecha
               T-Asn_header.tip_comprob
               T-Asn_header.nro_comprob
               T-Asn_header.estado
               T-Asn_header.leyenda
               Moneda.abrevia
               WITH FRAME frm-encabezado.
       DOWN WITH FRAME frm-encabezado.

       FOR EACH T-Asn_detalle OF T-Asn_header 
           WHERE T-Asn_detalle.reexpresion = p-reexpresion
             AND ( T-Asn_detalle.nro_moneda = v-moneda_expresion OR NOT p-reexpresion ),
           EACH Cuenta OF T-Asn_detalle,

           /* FIRST Entidad OF T-Asn_detalle, FIRST Moneda OF T-Asn_detalle
                 BREAK BY Moneda.cdg_moneda:

           FIND Obra OF Asn_detalle NO-LOCK NO-ERROR. */
           FIRST Moneda OF T-Asn_detalle
                 BREAK BY Moneda.cdg_moneda:

           FIND Entidad OF T-Asn_detalle NO-LOCK NO-ERROR.
           FIND Obra OF T-Asn_detalle NO-LOCK NO-ERROR.

           
           /* IF Moneda.es_local THEN
              reexpreso_cambio = "".
           ELSE
              reexpreso_cambio = STRING() + "/" + STRING(T-Asn_detalle.cambio). */
/*            IF T-Asn_detalle.debito <> 0 AND T-Asn_detalle.credito <> 0 THEN                                     */
/*            DO:                                                                                                  */
/*                                                                                                                 */
/*               DISPLAY T-Asn_detalle.nro_linea                                                                   */
/*                       Cuenta.cdg_cuenta                                                                         */
/*                       Cuenta.nombre                                                                             */
/*                       Entidad.cdg_entidad                                                                       */
/*                       Obra.cdg_obra              WHEN AVAILABLE Obra                                            */
/*                       Moneda.abrevia                                                                            */
/*                       T-Asn_detalle.debito       WHEN T-Asn_detalle.debito  <> 0 OR T-Asn_detalle.credito = 0   */
/*                      /* T-Asn_detalle.credito    WHEN T-Asn_detalle.credito <> 0 OR T-Asn_detalle.debito  = 0*/ */
/*                       T-Asn_detalle.cambio       WHEN NOT Moneda.es_local OR TRUE                               */
/*                       T-Asn_detalle.leyen_detalle                                                               */
/*                                                                                                                 */
/*                   WITH FRAME frm-movimiento.                                                                    */
/*                   DOWN WITH FRAME frm-movimiento.                                                               */
/*                                                                                                                 */
                    DISPLAY T-Asn_detalle.nro_linea
                      Cuenta.cdg_cuenta
                      Cuenta.nombre
                      Entidad.cdg_entidad
                      Obra.cdg_obra              WHEN AVAILABLE Obra
                      Moneda.abrevia
                      T-Asn_detalle.debito     WHEN T-Asn_detalle.debito  <> 0 OR T-Asn_detalle.credito = 0
                      T-Asn_detalle.credito      WHEN T-Asn_detalle.credito <> 0 OR T-Asn_detalle.debito  = 0
                      T-Asn_detalle.cambio       WHEN NOT Moneda.es_local OR TRUE
                      T-Asn_detalle.leyen_detalle

                  WITH FRAME frm-movimiento.
           DOWN WITH FRAME frm-movimiento.
/*            END.                                                                                            */
/*            ELSE                                                                                            */
/*               DISPLAY T-Asn_detalle.nro_linea                                                              */
/*                       Cuenta.cdg_cuenta                                                                    */
/*                       Cuenta.nombre                                                                        */
/*                       Entidad.cdg_entidad                                                                  */
/*                       Obra.cdg_obra           WHEN AVAILABLE Obra                                          */
/*                       Moneda.abrevia                                                                       */
/*                       T-Asn_detalle.debito    WHEN T-Asn_detalle.debito  <> 0 OR T-Asn_detalle.credito = 0 */
/*                       T-Asn_detalle.credito   WHEN T-Asn_detalle.credito <> 0 OR T-Asn_detalle.debito  = 0 */
/*                       T-Asn_detalle.cambio    WHEN NOT Moneda.es_local OR TRUE                             */
/*                       T-Asn_detalle.leyen_detalle                                                          */
/*                                                                                                            */
/*                   WITH FRAME frm-movimiento.                                                               */
/*            DOWN WITH FRAME frm-movimiento.                                                                 */

           IF NOT p-reexpresion
           THEN DO:

               m-debitos  = m-debitos  + T-Asn_detalle.debito.
               m-creditos = m-creditos + T-Asn_detalle.credito.
              
               IF LAST-OF(Moneda.cdg_moneda)
               THEN DO:
    
                   UNDERLINE 
                        T-Asn_detalle.debito     
                        T-Asn_detalle.credito    
                        WITH FRAME frm-movimiento.
                   DOWN WITH FRAME frm-movimiento.
                   DISPLAY 
                        m-debitos  @ T-Asn_detalle.debito     
                        m-creditos @ T-Asn_detalle.credito    
                        WITH FRAME frm-movimiento.
                   DOWN 2 WITH FRAME frm-movimiento.
    
                   ASSIGN
                       m-debitos = 0
                       m-creditos = 0.
    
               END.

           END.
           
       END.

       IF p-reexpresion
       THEN DO:

           UNDERLINE 
               T-Asn_detalle.debito
               T-Asn_detalle.credito
               WITH FRAME frm-movimiento.
           
           FIND FIRST T-Asn_totales OF T-Asn_header 
               WHERE T-Asn_totales.nro_moneda = v-moneda_expresion 
                 AND T-Asn_totales.reexpresion 
                     NO-LOCK.
    
           IF T-Asn_totales.tot_debitos = T-Asn_totales.tot_creditos
               THEN v-balancea = "".
               ELSE v-balancea = "<<< ASIENTO NO BALANCEA >>>".
    
           DISPLAY
    
               T-Asn_totales.tot_debitos  @ T-Asn_detalle.debito
               T-Asn_totales.tot_creditos @ T-Asn_detalle.credito
               v-balancea                 @ T-Asn_detalle.leyen_detalle
    
               WITH FRAME frm-movimiento.
               
           DOWN 1 WITH FRAME frm-movimiento.
    
           RELEASE T-Asn_totales.
       
       END.

   END. 

   HIDE FRAME frm-titulo.

END PROCEDURE.

PROCEDURE listar_resumen:

   IF ver_movim THEN PAGE.
    
   n-asiento-0 = 0.
   n-asiento-1 = 0.
   titulo_lis  = titulo_resumen.

   RUN listar_detalle.

END PROCEDURE.
                
PROCEDURE bajar_datos:

   DEFINE VARIABLE des_asiento AS INTEGER.
   DEFINE VARIABLE has_asiento AS INTEGER.

   CASE gen_asiento:
        WHEN "Resumido"  /* Asiento Resumido */
        THEN DO:
             des_asiento = 0.
             has_asiento = 0.
        END.     
        WHEN "No Generado" /* No generado, no se invoca esta rutina */
        THEN DO:
             des_asiento = 0.
             has_asiento = 0.
        END.     
        WHEN "Detallado"     
        THEN DO:
             des_asiento = 1.
             has_asiento = n-asiento.
        END.     
   END CASE.

   DO TRANSACTION:
   
        FIND Parametro 
             WHERE Parametro.cdg_empresa = Empresa.cdg_empresa
               AND Parametro.cdg_parametro = "PROXNASN"
                   EXCLUSIVE-LOCK.
                 
        FOR EACH T-Asn_header WHERE T-Asn_header.nro_asiento >= des_asiento
                                AND T-Asn_header.nro_asiento <= has_asiento
                                AND T-Asn_header.estado = "P":
        
            n-asiento = NEXT-VALUE(proximo_asiento).
            FOR EACH T-Asn_detalle OF T-Asn_header:
                CREATE Asn_detalle.
                BUFFER-COPY T-Asn_detalle TO Asn_detalle 
                            ASSIGN Asn_detalle.nro_asiento = n-asiento.
            END.
            
            FOR EACH T-Asn_totales OF T-Asn_header:
                CREATE Asn_totales.
                BUFFER-COPY T-Asn_totales TO Asn_totales 
                            ASSIGN Asn_totales.nro_asiento = n-asiento.
            END.

            ASSIGN T-Asn_header.nro_comprob = Parametro.valor_n
                   Parametro.valor_n        = Parametro.valor_n + 1.

            
            CREATE Asn_header.
            BUFFER-COPY T-Asn_header TO Asn_header
                        ASSIGN Asn_header.nro_asiento = n-asiento.
                        
        END.          
        
        RELEASE Parametro.
        RELEASE Asn_header.
        RELEASE Asn_detalle.
   
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
              T-Asn_totales.nro_moneda = T-Asn_detalle.nro_moneda
              T-Asn_totales.reexpresion = T-Asn_detalle.reexpresion.
   END.

   ASSIGN T-Asn_totales.tot_debitos  = T-Asn_totales.tot_debitos  + T-Asn_detalle.debito
          T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + T-Asn_detalle.credito
          T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

END PROCEDURE.

PROCEDURE acumular_resumen:

   /* Acumula las lineas de detalle de cada asiento en las lineas de la mimsma identidad del resumen */

 
   FIND B-T-Asn_detalle
       WHERE B-T-Asn_detalle.nro_asiento = 0
         AND B-T-Asn_detalle.nro_cuenta  = T-Asn_detalle.nro_cuenta 
         AND B-T-Asn_detalle.nro_entidad = T-Asn_detalle.nro_entidad
         AND B-T-Asn_detalle.nro_obra    = T-Asn_detalle.nro_obra   
         AND B-T-Asn_detalle.nro_moneda  = T-Asn_detalle.nro_moneda 
         AND B-T-Asn_detalle.reexpresion = T-Asn_detalle.reexpresion
         AND ((B-T-Asn_detalle.credito <> 0 AND T-Asn_detalle.credito <> 0 ) OR
              (B-T-Asn_detalle.debito  <> 0 AND T-Asn_detalle.debito  <> 0 ))
         NO-ERROR.

   IF NOT AVAILABLE B-T-Asn_detalle
   THEN DO:
       FIND B-T-Asn_header WHERE B-T-Asn_header.nro_asiento = 0.
       CREATE B-T-Asn_detalle.
       BUFFER-COPY T-Asn_detalle TO B-T-Asn_detalle
           ASSIGN B-T-Asn_detalle.nro_asiento     = 0
                  B-T-Asn_header.ultima_linea     = B-T-Asn_header.ultima_linea + 1
                  B-T-Asn_detalle.nro_linea       = B-T-Asn_header.ultima_linea
                  B-T-Asn_detalle.debito          = 0
                  B-T-Asn_detalle.credito         = 0
                  B-T-Asn_detalle.leyen_detalle   = B-T-Asn_header.leyenda.
   END.

   ASSIGN B-T-Asn_detalle.debito  = B-T-Asn_detalle.debito  + T-Asn_detalle.debito
          B-T-Asn_detalle.credito = B-T-Asn_detalle.credito + T-Asn_detalle.credito.

   /* Dentro del asiento resumen, acumula las lineas de detalle en el total del asiento */

   FIND T-Asn_totales
       WHERE T-Asn_totales.nro_asiento = 0
         AND T-Asn_totales.nro_moneda  = B-T-Asn_detalle.nro_moneda 
         AND T-Asn_totales.reexpresion = B-T-Asn_detalle.reexpresion 
             NO-ERROR.

   IF NOT AVAILABLE T-Asn_totales
   THEN DO:
       CREATE T-Asn_totales.
       ASSIGN T-Asn_totales.nro_asiento = 0
              T-Asn_totales.nro_moneda  = B-T-Asn_detalle.nro_moneda
              T-Asn_totales.reexpresion = B-T-Asn_detalle.reexpresion.
   END.

   ASSIGN T-Asn_totales.tot_debitos  = T-Asn_totales.tot_debitos  + T-Asn_detalle.debito
          T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + T-Asn_detalle.credito
          T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

END PROCEDURE.

PROCEDURE planchar_saldos:

   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.
   tgn_debitos_pen = 0.
   tgn_creditos_pen = 0.
   
       /* Halla el neto de débitos y créditos para cada cuenta en el asiento resumen */

   FOR EACH T-Asn_detalle WHERE T-Asn_detalle.nro_asiento = 0:

       IF T-Asn_detalle.debito > T-Asn_detalle.credito
       THEN DO:
          ASSIGN /*T-Asn_detalle.codigo_dbcr = 1*/
                 T-Asn_detalle.debito = T-Asn_detalle.debito - T-Asn_detalle.credito
                 T-Asn_detalle.credito = 0.
       END.
       ELSE DO:          
          ASSIGN /*T-Asn_detalle.codigo_dbcr = 2*/
                 T-Asn_detalle.credito = T-Asn_detalle.credito - T-Asn_detalle.debito
                 T-Asn_detalle.debito = 0.
       END.

       /*
       IF T-Asn_detalle.debitos_pen > T-Asn_detalle.creditos_pen
       THEN DO:
          ASSIGN /*T-Asn_detalle.codigo_dbcr = 1*/
                 T-Asn_detalle.debitos_pen = T-Asn_detalle.debitos_pen - T-Asn_detalle.creditos_pen
                 T-Asn_detalle.creditos_pen = 0.
       END.
       ELSE DO:          
          ASSIGN /*T-Asn_detalle.codigo_dbcr = 2*/
                 T-Asn_detalle.creditos_pen = T-Asn_detalle.creditos_pen - T-Asn_detalle.debitos_pen
                 T-Asn_detalle.debitos_pen = 0.
       END.
       
       tgn_debitos_pen   = tgn_debitos_pen   + T-Asn_detalle.debitos_pen.
       tgn_creditos_pen  = tgn_creditos_pen  + T-Asn_detalle.creditos_pen.
       */
       
       tgn_debitos_tot   = tgn_debitos_tot   + T-Asn_detalle.debito.
       tgn_creditos_tot  = tgn_creditos_tot  + T-Asn_detalle.credito.


   END.

END PROCEDURE.

PROCEDURE reexpresar_asiento :

   DEFINE VARIABLE x-cotiza_origen AS DATE.

   FOR EACH T-Asn_detalle OF T-Asn_header WHERE NOT T-Asn_detalle.reexpresion:

      /* ----------------------------------------------------------------------------- */
      /* Recorre las monedas para las cuales la cuenta del movimiento reexpresa saldos */
      /* ----------------------------------------------------------------------------- */
    
      FOR EACH  Cuenta-moneda 
          WHERE Cuenta-moneda.nro_cuenta = T-Asn_detalle.nro_cuenta 
            AND Cuenta-moneda.reexpresa_saldos: 
    
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

              IF Cuenta-moneda.nro_moneda <> T-Asn_header.nro_moneda
              THEN DO:     
                  FIND Moneda OF T-Reexpresion NO-LOCK.
                  RUN cotizar_moneda.p  ( INPUT   Moneda.cdg_moneda, 
                                          INPUT   T-Asn_header.cdg_empresa,  
                                          INPUT   T-Asn_header.fecha, 
                                          OUTPUT  T-Reexpresion.cambio, 
                                          OUTPUT  x-cotiza_origen).
                  
              END.
    
          END.           
    
          IF Cuenta-moneda.nro_moneda <> T-Asn_header.nro_moneda
          THEN DO:       
              ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  * ( T-Reexpresion.cambio / T-Asn_detalle.cambio)
                     T-Reexpresion.credito = T-Asn_detalle.credito * ( T-Reexpresion.cambio / T-Asn_detalle.cambio).
          END.
          ELSE DO:
              ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  
                     T-Reexpresion.credito = T-Asn_detalle.credito
                     T-Reexpresion.cambio  = T-Asn_detalle.cambio.
          END.
    
      END.

   END.

END PROCEDURE.

PROCEDURE planchar_redondeos:

    DEFINE VARIABLE v-saldo_diferencia  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Diferencia".

    v-saldo_diferencia = ABS(T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos).

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


END PROCEDURE.

