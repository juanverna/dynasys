/*=========================================================================================================*/
/*      DEFINICION DE PROCESOS PERTINENTES A LOS PROCESOS DE GENERACION DE ASIENTOS DESDE LOS MODULOS      */
/*=========================================================================================================*/


PROCEDURE listar_detalle:
DEFINE VARIABLE o-cambio_local AS DECIMAL    NO-UNDO.
   DEFINE VARIABLE v-balancea AS CHARACTER.

   FOR EACH T-Asn_header WHERE T-Asn_header.nro_asiento > 0:
       
       VIEW FRAME frm-titulo.

       FIND Moneda WHERE Moneda.nro_moneda = T-Asn_header.nro_moneda.

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
           FIRST Entidad OF T-Asn_detalle, FIRST Moneda OF T-Asn_detalle
                 BREAK BY Moneda.cdg_moneda:

           FIND Obra OF Asn_detalle NO-LOCK NO-ERROR.
           
          /* DEFINE BUFFER b_moneda FOR Moneda.
           FIND FIRST Caj_detalle
                WHERE ROWID(Caj_detalle) = T-Asn_detalle.rid_caj_detalle
                NO-LOCK NO-ERROR.
           IF AVAILABLE Caj_detalle THEN
           DO:
               FIND FIRST Rubro OF Caj_detalle NO-LOCK NO-ERROR.
               IF rubro.tipo = "C" THEN
               DO:
                  FIND FIRST b_moneda 
                       WHERE b_moneda.nro_moneda = Caj_header.nro_moneda
                       NO-LOCK NO-ERROR.
                  IF B_Moneda.es_local THEN
                     ASSIGN 
                     T-Asn_detalle.leyen_detalle = "".
                  ELSE
                  DO:
                     FIND FIRST Caj_header
                          WHERE Caj_header.nro_transaccion = Caj_detalle.nro_transaccion
                          NO-LOCK NO-ERROR.
                     IF AVAILABLE Caj_header THEN
                     DO:
                     RUN cambiolocal.p(INPUT  Caj_header.fecha,
                                       OUTPUT o-cambio_local).
                     
                     T-Asn_detalle.leyen_detalle = 
                                        STRING(Caj_detalle.divisas) + " * " + 
                                        STRING(o-cambio_local) +
                                        "/" + STRING(Caj_detalle.cambio). 
                     MESSAGE o-cambio_local SKIP
                             Caj_detalle.divisas SKIP
                             Caj_detalle.cambio
                         VIEW-AS ALERT-BOX INFO BUTTONS OK.
                     END.
                  END.
               END.
           END. */
            
           DISPLAY T-Asn_detalle.nro_linea
                  Cuenta.cdg_cuenta
                  Cuenta.nombre
                  Entidad.cdg_entidad
                  Obra.cdg_obra              WHEN AVAILABLE Obra
                  Moneda.abrevia
                  T-Asn_detalle.debito         WHEN T-Asn_detalle.debito  <> 0
                  T-Asn_detalle.credito        WHEN T-Asn_detalle.credito <> 0
                  T-Asn_detalle.cambio         WHEN NOT Moneda.es_local OR TRUE    
                  T-Asn_detalle.leyen_detalle    
                /*   reexpreso_cambio             WHEN NOT Moneda.es_local OR TRUE     */
                  WITH FRAME frm-movimiento.
           DOWN WITH FRAME frm-movimiento.

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
    
   CLEAR FRAME frm-movimiento-res ALL NO-PAUSE.
   
   lst_d_tot-c = 0.
   lst_c_tot-c = 0.
   lst_d_pen-c = 0.
   lst_c_pen-c = 0.

   FOR EACH Acumulado, Cuenta OF Acumulado BREAK BY Acumulado.codigo_dbcr 
                                                 BY Cuenta.cdg_cuenta
                                                 BY Acumulado.nro_entidad
                                                 BY Acumulado.nro_obra:

       lst_d_tot = Acumulado.debitos.
       lst_c_tot = Acumulado.creditos.
       lst_d_pen = Acumulado.debitos_pen.
       lst_c_pen = Acumulado.creditos_pen.

       lst_d_tot-c = lst_d_tot-c + Acumulado.debitos.
       lst_c_tot-c = lst_c_tot-c + Acumulado.creditos.
       lst_d_pen-c = lst_d_pen-c + Acumulado.debitos_pen.
       lst_c_pen-c = lst_c_pen-c + Acumulado.creditos_pen.

       FIND Entidad OF Acumulado NO-LOCK NO-ERROR.
       FIND Obra    OF Acumulado NO-LOCK NO-ERROR.
              
       VIEW FRAME frm-titulo-res.
       DISPLAY
             Cuenta.cdg_cuenta WHEN FIRST-OF(Cuenta.cdg_cuenta) 
             Cuenta.nombre     WHEN FIRST-OF(Cuenta.cdg_cuenta)  
             Entidad.cdg_entidad WHEN AVAILABLE Entidad
             Obra.cdg_obra     WHEN AVAILABLE Obra
             lst_d_tot         WHEN lst_d_tot <> 0
             lst_c_tot         WHEN lst_c_tot <> 0
             lst_d_pen         WHEN lst_d_pen <> 0
             lst_c_pen         WHEN lst_c_pen <> 0
             WITH FRAME frm-movimiento-res.
       DOWN WITH FRAME frm-movimiento-res.

       IF LAST-OF(Cuenta.cdg_cuenta)
       THEN DO:
            UNDERLINE
                lst_d_tot
                lst_c_tot
                lst_d_pen 
                lst_c_pen 
                WITH FRAME frm-movimiento-res.
            DISPLAY    
                lst_d_tot-c @ lst_d_tot
                lst_c_tot-c @ lst_c_tot
                lst_d_pen-c @ lst_d_pen
                lst_c_pen-c @ lst_c_pen
                WITH FRAME frm-movimiento-res.
            DOWN 2 WITH FRAME frm-movimiento-res.

            lst_d_tot-c = 0.
            lst_c_tot-c = 0.
            lst_d_pen-c = 0.
            lst_c_pen-c = 0.

       END.   

   END.

   UNDERLINE lst_d_tot 
             lst_c_tot 
             lst_d_pen 
             lst_c_pen 
             WITH FRAME frm-movimiento-res.
   DISPLAY tgn_debitos_tot   @ lst_d_tot
           tgn_creditos_tot  @ lst_c_tot
           tgn_debitos_pen   @ lst_d_pen
           tgn_creditos_pen  @ lst_c_pen
           WITH FRAME frm-movimiento-res.

END PROCEDURE.

PROCEDURE acumular_imputacion:

   DEFINE INPUT PARAMETER p-nro_cuenta  LIKE Cuenta.nro_cuenta.
   DEFINE INPUT PARAMETER p-nro_entidad LIKE Entidad.nro_entidad.
   DEFINE INPUT PARAMETER p-nro_obra    LIKE Obra.nro_obra.
   DEFINE INPUT PARAMETER p-debitan     AS LOGICAL.
   DEFINE INPUT PARAMETER p-contable    AS LOGICAL.
   DEFINE INPUT PARAMETER p-imp_total   AS DECIMAL.
   DEFINE INPUT PARAMETER p-nro_moneda  LIKE Moneda.nro_moneda.

   FIND FIRST Acumulado 
        WHERE Acumulado.nro_cuenta  = p-nro_cuenta 
          AND Acumulado.nro_entidad = p-nro_entidad 
          AND Acumulado.nro_obra    = p-nro_obra
          AND Acumulado.nro_moneda  = p-nro_moneda 
              NO-ERROR.

   IF NOT AVAILABLE Acumulado
   THEN DO:
      CREATE Acumulado.
      ASSIGN Acumulado.nro_cuenta   = p-nro_cuenta
             Acumulado.nro_entidad  = p-nro_entidad
             Acumulado.nro_obra     = p-nro_obra
             Acumulado.nro_moneda   = p-nro_moneda.
   END.

   IF p-debitan
      THEN Acumulado.debitos  = Acumulado.debitos  + p-imp_total.
      ELSE Acumulado.creditos = Acumulado.creditos + p-imp_total.

   IF NOT p-contable 
   THEN DO:

      IF p-debitan
         THEN Acumulado.debitos_pen  = Acumulado.debitos_pen  + p-imp_total.
         ELSE Acumulado.creditos_pen = Acumulado.creditos_pen + p-imp_total.

   END.

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

/*                       Acumulacion de Versión 3.4 inclusive

   T-Asn_header.tot_debitos  = T-Asn_header.tot_debitos  + T-Asn_detalle.debito.
   T-Asn_header.tot_creditos = T-Asn_header.tot_creditos + T-Asn_detalle.credito.

   T-Asn_header.tot_debitos_div  = T-Asn_header.tot_debitos_div  + T-Asn_detalle.debito_div.
   T-Asn_header.tot_creditos_div = T-Asn_header.tot_creditos_div + T-Asn_detalle.credito_div.
*/

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

   T-Asn_totales.tot_debitos  = T-Asn_totales.tot_debitos  + T-Asn_detalle.debito.
   T-Asn_totales.tot_creditos = T-Asn_totales.tot_creditos + T-Asn_detalle.credito.
   T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

END PROCEDURE.

PROCEDURE planchar_saldos:

   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.
   tgn_debitos_pen = 0.
   tgn_creditos_pen = 0.
   
              /* Halla el neto de débitos y créditos para cada cuenta en el asiento resumen */

   FOR EACH Acumulado:

       IF Acumulado.debitos > Acumulado.creditos
       THEN DO:
          ASSIGN Acumulado.codigo_dbcr = 1
                 Acumulado.debitos = Acumulado.debitos - Acumulado.creditos
                 Acumulado.creditos = 0.
       END.
       ELSE DO:          
          ASSIGN Acumulado.codigo_dbcr = 2
                 Acumulado.creditos = Acumulado.creditos - Acumulado.debitos
                 Acumulado.debitos = 0.
       END.

       IF Acumulado.debitos_pen > Acumulado.creditos_pen
       THEN DO:
          ASSIGN Acumulado.codigo_dbcr = 1
                 Acumulado.debitos_pen = Acumulado.debitos_pen - Acumulado.creditos_pen
                 Acumulado.creditos_pen = 0.
       END.
       ELSE DO:          
          ASSIGN Acumulado.codigo_dbcr = 2
                 Acumulado.creditos_pen = Acumulado.creditos_pen - Acumulado.debitos_pen
                 Acumulado.debitos_pen = 0.
       END.

       tgn_debitos_tot   = tgn_debitos_tot   + Acumulado.debitos.
       tgn_creditos_tot  = tgn_creditos_tot  + Acumulado.creditos.

       tgn_debitos_pen   = tgn_debitos_pen   + Acumulado.debitos_pen.
       tgn_creditos_pen  = tgn_creditos_pen  + Acumulado.creditos_pen.

   END.

END PROCEDURE.

PROCEDURE generar_asiento_resumen:

   DEFINE INPUT PARAMETER p-sigla_sic AS CHARACTER.
   DEFINE INPUT PARAMETER p-leyenda   AS CHARACTER.
   
   CREATE T-Asn_header.
   ASSIGN T-Asn_header.anulado          = NO
          T-Asn_header.cdg_empresa      = Empresa.cdg_empresa
          T-Asn_header.cdg_sigla-sic    = p-sigla_sic
          T-Asn_header.fecha            = fecha_contable
          T-Asn_header.leyenda          = p-leyenda
          T-Asn_header.nro_asiento      = 0
          T-Asn_header.nro_comprob      = 0
          T-Asn_header.nro_usuario      = Usuario.nro_usuario
          T-Asn_header.origen           = "A"
          T-Asn_header.tip_comprob      = "AS"
          T-Asn_header.estado           = "P".

   FOR EACH Acumulado WHERE Acumulado.creditos_pen <> 0 OR Acumulado.debitos_pen <> 0, 
                        Cuenta OF Acumulado BREAK BY Acumulado.codigo_dbcr 
                                                  BY Cuenta.cdg_cuenta
                                                  BY Acumulado.nro_entidad
                                                  BY Acumulado.nro_obra:
       
       CREATE T-Asn_detalle.
       ASSIGN T-Asn_header.ultima_linea    = T-Asn_header.ultima_linea + 1
              T-Asn_detalle.cdg_empresa    = T-Asn_header.cdg_empresa
              T-Asn_detalle.credito        = Acumulado.creditos_pen
              T-Asn_detalle.debito         = Acumulado.debitos_pen

              T-Asn_detalle.cambio         = 1
              T-Asn_detalle.cambio_dolar   = 1

              T-Asn_detalle.fecha_mayor    = T-Asn_header.fecha
              T-Asn_detalle.leyen_detalle  = T-Asn_header.leyenda
              T-Asn_detalle.nro_asiento    = 0
              T-Asn_detalle.nro_cuenta     = Acumulado.nro_cuenta
              T-Asn_detalle.nro_entidad    = Acumulado.nro_entidad
              T-Asn_detalle.nro_linea      = T-Asn_header.ultima_linea
              T-Asn_detalle.nro_moneda     = Acumulado.nro_moneda
              T-Asn_detalle.nro_obra       = Acumulado.nro_obra
              T-Asn_detalle.nro_subcuenta  = 0.

        RUN acumular_debcred.
       
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


END PROCEDURE.

