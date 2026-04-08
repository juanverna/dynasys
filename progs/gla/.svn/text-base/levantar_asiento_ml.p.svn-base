/*==================================================================================================================*/
/*                            INTERFACE PARA LEVANTAR ASIENTOS EXTERNOS                                             */
/*==================================================================================================================*/


DEFINE INPUT PARAMETER p-cambio  LIKE Asn_header.cambio.
DEFINE INPUT PARAMETER p-archivo AS CHARACTER.
DEFINE INPUT PARAMETER p-leyenda AS CHARACTER.

/*DEFINE VARIABLE p-cambio  LIKE Asn_header.cambio INITIAL 28.60.
DEFINE VARIABLE p-archivo AS CHARACTER INITIAL "C:\docs\SD\Ventas\Clientes\Merrill Lynch\Haberes Set2004 Abie sd.txt".*/

/*==================================================================================================================*/
/*                                              VARIABLES                                                           */
/*==================================================================================================================*/

DEFINE VARIABLE h-anulado           LIKE Asn_header.anulado. 
DEFINE VARIABLE h-cambio            LIKE Asn_header.cambio. 
DEFINE VARIABLE h-cambio_dolar      LIKE Asn_header.cambio_dolar. 
DEFINE VARIABLE h-cdg_empresa       LIKE Asn_header.cdg_empresa. 
DEFINE VARIABLE h-estadoasiento     LIKE Asn_header.cdg_estadoasiento. 
DEFINE VARIABLE h-cdg_librocontable LIKE Asn_header.cdg_librocontable. 
DEFINE VARIABLE h-cdg_sigla-sic     LIKE Asn_header.cdg_sigla-sic. 
DEFINE VARIABLE h-estado            LIKE Asn_header.estado. 
DEFINE VARIABLE h-fecha             LIKE Asn_header.fecha. 
DEFINE VARIABLE h-fecha_grab        LIKE Asn_header.fecha_grab. 
DEFINE VARIABLE h-hora_grab         LIKE Asn_header.hora_grab. 
DEFINE VARIABLE h-leyenda           LIKE Asn_header.leyenda. 
DEFINE VARIABLE h-nro_asiento       LIKE Asn_header.nro_asiento. 
DEFINE VARIABLE h-nro_comprob       LIKE Asn_header.nro_comprob. 
DEFINE VARIABLE h-nro_entidad       LIKE Asn_header.nro_entidad. 
DEFINE VARIABLE h-nro_idcabecera    LIKE Asn_header.nro_idcabecera. 
DEFINE VARIABLE h-nro_moneda        LIKE Asn_header.nro_moneda. 
DEFINE VARIABLE h-nro_secuencia     LIKE Asn_header.nro_secuencia. 
DEFINE VARIABLE h-nro_usuario       LIKE Asn_header.nro_usuario. 
DEFINE VARIABLE h-num_sucursal      LIKE Asn_header.num_sucursal. 
DEFINE VARIABLE h-observacion       LIKE Asn_header.observacion. 
DEFINE VARIABLE h-origen            LIKE Asn_header.origen. 
DEFINE VARIABLE h-pc_name           LIKE Asn_header.pc_name. 
DEFINE VARIABLE h-posteo            LIKE Asn_header.posteo. 
DEFINE VARIABLE h-presupuestado     LIKE Asn_header.presupuestado. 
DEFINE VARIABLE h-prf_comprob       LIKE Asn_header.prf_comprob. 
DEFINE VARIABLE h-reexpresa_saldos  LIKE Asn_header.reexpresa_saldos. 
DEFINE VARIABLE h-tabla_comprobante LIKE Asn_header.tabla_comprobante. 
DEFINE VARIABLE h-tip_comprob       LIKE Asn_header.tip_comprob. 
DEFINE VARIABLE h-ultima_linea      LIKE Asn_header.ultima_linea.

DEFINE VARIABLE d-cambio            LIKE Asn_detalle.cambio.
DEFINE VARIABLE d-cambio_dolar      LIKE Asn_detalle.cambio_dolar. 
DEFINE VARIABLE d-cantidad          LIKE Asn_detalle.cantidad. 
DEFINE VARIABLE d-cdg_empresa       LIKE Asn_detalle.cdg_empresa. 
DEFINE VARIABLE d-estadoasiento     LIKE Asn_detalle.cdg_estadoasiento. 
DEFINE VARIABLE d-credito           LIKE Asn_detalle.credito. 
DEFINE VARIABLE d-credito_can       LIKE Asn_detalle.credito_can. 
DEFINE VARIABLE d-debito            LIKE Asn_detalle.debito. 
DEFINE VARIABLE d-debito_can        LIKE Asn_detalle.debito_can. 
DEFINE VARIABLE d-fecha_mayor       LIKE Asn_detalle.fecha_mayor. 
DEFINE VARIABLE d-leyen_detalle     LIKE Asn_detalle.leyen_detalle. 
DEFINE VARIABLE d-nro_asiento       LIKE Asn_detalle.nro_asiento. 
DEFINE VARIABLE d-nro_cuenta        LIKE Asn_detalle.nro_cuenta. 
DEFINE VARIABLE d-nro_entidad       LIKE Asn_detalle.nro_entidad. 
DEFINE VARIABLE d-nro_linea         LIKE Asn_detalle.nro_linea. 
DEFINE VARIABLE d-nro_moneda        LIKE Asn_detalle.nro_moneda. 
DEFINE VARIABLE d-nro_obra          LIKE Asn_detalle.nro_obra. 
DEFINE VARIABLE d-nro_subcuenta     LIKE Asn_detalle.nro_subcuenta. 
DEFINE VARIABLE d-posteo            LIKE Asn_detalle.posteo. 
DEFINE VARIABLE d-presupuestado     LIKE Asn_detalle.presupuestado. 
DEFINE VARIABLE d-reexpresion       LIKE Asn_detalle.reexpresion. 
DEFINE VARIABLE d-stposteo          LIKE Asn_detalle.stposteo. 
DEFINE VARIABLE d-unidades          LIKE Asn_detalle.unidades. 
DEFINE VARIABLE d-valor_unitario    LIKE Asn_detalle.valor_unitario.

DEFINE VARIABLE v-cuenta            LIKE Cuenta.cdg_cuenta.
DEFINE VARIABLE v-ccosto            LIKE Entidad.cdg_entidad.
DEFINE VARIABLE v-fecha             LIKE Asn_header.fecha.
DEFINE VARIABLE v-leyenda           LIKE Asn_header.leyenda.
DEFINE VARIABLE v-debehaber         AS CHARACTER.
DEFINE VARIABLE v-importe           AS DECIMAL FORMAT "->>>>>>>>9.99".

DEFINE VARIABLE linea               AS CHARACTER.
DEFINE VARIABLE c                   AS INTEGER.
DEFINE VARIABLE hay_error           AS LOGICAL.

DEFINE TEMP-TABLE T-Asn_header  LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_totales LIKE Asn_totales.

DEFINE BUFFER     T-Reexpresion         FOR T-Asn_detalle.

DEFINE STREAM Asientos.
DEFINE STREAM Seguimiento.

/*==================================================================================================================*/
/*                           B L O Q U E    P R I N C I P A L                                                       */
/*==================================================================================================================*/

/*----------------------------------------------------------------------------------

                  C U I D A D O !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

FOR EACH Asn_header WHERE Asn_header.cdg_sigla-sic      = "SYJ":
    FOR EACH Asn_detalle OF Asn_header:
        DELETE Asn_detalle.
    END.
    FOR EACH Asn_totales OF Asn_header:
        DELETE Asn_totales.
    END.
    DELETE Asn_header.
END.

-----------------------------------------------------------------------------------*/

{findempresa.i}
SESSION:NUMERIC-FORMAT = "american".
INPUT STREAM Asientos FROM VALUE(p-archivo).

hay_error = NO.
REPEAT:

    /*31/07/2004;"222";"D";"Hab Jul 2004 - to";"D";305704.00*/

    FIND Moneda WHERE Moneda.cdg_moneda = "PE" NO-LOCK.

    IMPORT STREAM Asientos DELIMITER ";" v-fecha v-cuenta v-ccosto v-leyenda v-debehaber v-importe.
    FIND FIRST T-Asn_header NO-ERROR.
    IF NOT AVAILABLE T-Asn_header
    THEN DO:
        CREATE T-Asn_header.
        ASSIGN T-Asn_header.cambio             = p-cambio
               T-Asn_header.cambio_dolar       = 1
               T-Asn_header.cdg_estadoasiento  = "I"
               T-Asn_header.cdg_librocontable  = "ZZZ"                
               T-Asn_header.fecha_grab         = TODAY                
               T-Asn_header.hora_grab          = TIME                 
               T-Asn_header.nro_entidad        = 0                    
               T-Asn_header.nro_idcabecera     = 0
               T-Asn_header.nro_secuencia      = 0                     
               T-Asn_header.num_sucursal       = ""                    
               T-Asn_header.observacion        = p-archivo
                           
               T-Asn_header.posteo             = "0"                   
               T-Asn_header.presupuestado      = ""                    
               T-Asn_header.prf_comprob        = 0                     
               T-Asn_header.reexpresa_saldos   = YES                   
               T-Asn_header.tabla_comprobante  = ""      
               
               T-Asn_header.anulado            = NO
               T-Asn_header.cdg_empresa        = Empresa.cdg_empresa
               T-Asn_header.cdg_sigla-sic      = "SYJ"
               T-Asn_header.fecha              = v-fecha
               T-Asn_header.leyenda            = /*"Haberes correspondientes a la liquidacion de fecha "*/ p-leyenda + " " + STRING(T-Asn_header.fecha,"99/99/99")
               T-Asn_header.nro_asiento        = 0
               T-Asn_header.nro_comprob        = 0
               T-Asn_header.nro_usuario        = Usuario.nro_usuario
               T-Asn_header.nro_moneda         = Moneda.nro_moneda
               T-Asn_header.origen             = "A"
               T-Asn_header.tip_comprob        = "AS"
               T-Asn_header.estado             = "*".

        RUN pcname1.p ( OUTPUT T-Asn_header.pc_name ).
    END.

    FIND Cuenta WHERE Cuenta.cdg_cuenta = v-cuenta NO-LOCK NO-ERROR.
    IF AVAILABLE Cuenta
    THEN DO:
        FIND Entidad WHERE Entidad.cdg_entidad = v-ccosto NO-LOCK NO-ERROR.
        IF AVAILABLE Entidad
        THEN DO:
            CREATE T-Asn_detalle.
            ASSIGN T-Asn_header.ultima_linea   = T-Asn_header.ultima_linea + 1
                   T-Asn_detalle.nro_linea     = T-Asn_header.ultima_linea
                   T-Asn_detalle.nro_cuenta    = Cuenta.nro_cuenta
                   T-Asn_detalle.nro_entidad   = Entidad.nro_entidad
                   T-Asn_detalle.nro_moneda    = T-Asn_header.nro_moneda
                   T-Asn_detalle.cdg_empresa   = T-Asn_header.cdg_empresa
                   T-Asn_detalle.fecha_mayor   = T-Asn_header.fecha
                   T-Asn_detalle.leyen_detalle = T-Asn_header.leyenda
                   T-Asn_detalle.nro_obra      = 0
                   T-Asn_detalle.debito        = IF v-debehaber = "D" THEN v-importe 
                                                                      ELSE 0
                   T-Asn_detalle.credito       = IF v-debehaber = "D" THEN 0 
                                                                      ELSE v-importe
                   T-Asn_detalle.cambio        = p-cambio.
        END.
        ELSE DO:
            MESSAGE "No existe la entidad " v-ccosto " en la linea " c
                VIEW-AS ALERT-BOX MESSAGE.
            hay_error = YES.
        END.
    END.
    ELSE DO:
        MESSAGE "No existe la cuenta " v-cuenta " en la linea " c
            VIEW-AS ALERT-BOX MESSAGE.
        hay_error = YES.
    END.

END.
INPUT STREAM Asientos CLOSE.

DEFINE VARIABLE p-reexpresion AS LOGICAL INITIAL YES.

FIND FIRST T-Asn_header.
RUN reexpresar_asiento.

FOR EACH T-Asn_detalle OF T-Asn_header:
   RUN acumular_debcred.
END.

FOR EACH T-Asn_totales OF T-Asn_header
   WHERE T-Asn_totales.tot_debitos <> T-Asn_totales.tot_creditos
     AND T-Asn_totales.reexpresion:

   RUN planchar_redondeos.

END.
/*
FOR EACH T-asn_detalle:
    DISPLAY nro_linea T-Asn_detalle.nro_moneda debito credito reexpresion T-Asn_detalle.cambio WITH STREAM-IO.
END.
*/

RUN bajar_datos.

/*==================================================================================================================*/
/*                                              PROCEDIMIENTOS                                                      */
/*==================================================================================================================*/

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

PROCEDURE reexpresar_asiento :

   DEFINE VARIABLE x-cotiza_origen AS DATE.

   OUTPUT STREAM Seguimiento TO "c:\sic-temp\seguirasiento.txt" PAGE-SIZE 0.

   FOR EACH T-Asn_detalle OF T-Asn_header WHERE NOT T-Asn_detalle.reexpresion:

               PUT STREAM Seguimiento "Original Moneda" T-Asn_detalle.nro_moneda " Debito " T-Asn_detalle.debito " Credito " T-Asn_detalle.credito " Cambio " T-Asn_detalle.cambio SKIP.

      /* ----------------------------------------------------------------------------- */
      /* Recorre las monedas para las cuales la cuenta del movimiento reexpresa saldos */
      /* ----------------------------------------------------------------------------- */
    
      FOR EACH Cuenta-moneda 
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

              IF T-Reexpresion.nro_moneda <> T-Asn_detalle.nro_moneda
              THEN DO:     
                  ASSIGN T-Reexpresion.cambio = 1
                         T-Reexpresion.debito  = T-Asn_detalle.debito  * ( T-Reexpresion.cambio / T-Asn_detalle.cambio )
                         T-Reexpresion.credito = T-Asn_detalle.credito * ( T-Reexpresion.cambio / T-Asn_detalle.cambio ).
              END.
              ELSE DO:
                  ASSIGN T-Reexpresion.debito  = T-Asn_detalle.debito  
                         T-Reexpresion.credito = T-Asn_detalle.credito
                         T-Reexpresion.cambio  = p-cambio.
              END.           
    
              PUT STREAM Seguimiento "Reexpresion Moneda " T-Reexpresion.nro_moneda " Debito " T-Reexpresion.debito " Credito " T-Reexpresion.credito " Cambio " T-Reexpresion.cambio SKIP.              

          END.
      END.
   END.

   OUTPUT STREAM Seguimiento CLOSE.
   
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

        T-Asn_totales.diferencia = T-Asn_totales.tot_debitos - T-Asn_totales.tot_creditos.

    END.


END PROCEDURE.

PROCEDURE bajar_datos:

   DEFINE VARIABLE n-asiento AS INTEGER.

   DO TRANSACTION:
   
        FIND Parametro 
             WHERE Parametro.cdg_empresa = Empresa.cdg_empresa
               AND Parametro.cdg_parametro = "PROXNASN"
                   EXCLUSIVE-LOCK.
                 
        FIND FIRST T-Asn_header.

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
                        
        RELEASE Parametro.
        RELEASE Asn_header.
        RELEASE Asn_detalle.
   
   END.                      

END PROCEDURE.

