/*=====================================================================================================*/
/*  REALIZA LA EMISION DE UN MOVIMIENTO DE TESORERIA CONSIDERANDO INGRESOS, EGRESOS Y TRANSFERENCIAS   */
/*=====================================================================================================*/

/*=====================================================================================================*/
/*                                     TABLAS TEMPORALES                                               */
/*=====================================================================================================*/

DEFINE TEMP-TABLE T-Caja-imputacion NO-UNDO LIKE Caja-imputacion.
DEFINE TEMP-TABLE T-Caj_detalle NO-UNDO LIKE Caj_detalle.
DEFINE TEMP-TABLE T-Caj_header NO-UNDO LIKE Caj_header.
DEFINE TEMP-TABLE T-Cheque NO-UNDO LIKE Cheque.
DEFINE TEMP-TABLE T-Valor NO-UNDO LIKE Valor.

/*=====================================================================================================*/
/*                                        PARAMETROS                                                   */
/*=====================================================================================================*/

DEFINE INPUT PARAMETER v-cdg_receptora LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER TABLE FOR T-Caj_header.
DEFINE INPUT PARAMETER TABLE FOR T-Caj_detalle.
DEFINE INPUT PARAMETER TABLE FOR T-Caja-imputacion.
DEFINE INPUT PARAMETER TABLE FOR T-Cheque.
DEFINE INPUT PARAMETER TABLE FOR T-Valor.


/*=====================================================================================================*/
/*                                  PROCESO PROPIAMENTE DICHO                                          */
/*=====================================================================================================*/

DO TRANSACTION:

    FIND FIRST T-Caj_header EXCLUSIVE-LOCK.

    FIND Parametro WHERE Parametro.cdg_parametro = "PROXNCAJ" 
                     AND Parametro.cdg_empresa   = T-Caj_header.cdg_empresa 
                         EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE Parametro
    THEN DO:
         CREATE Parametro.
         ASSIGN Parametro.cdg_empresa   = T-Caj_header.cdg_empresa
                Parametro.cdg_parametro = "PROXNCAJ"
                Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                Parametro.observacion   = ""
                Parametro.tipo          = "N"
                Parametro.valor_n       = 1.
    END.         


    ASSIGN  T-Caj_header.prf_comprob = 0
            T-Caj_header.nro_comprob = Parametro.valor_n
            Parametro.valor_n = Parametro.valor_n + 1.


    CREATE Caj_header.
    BUFFER-COPY T-Caj_header TO Caj_header
        ASSIGN  Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
                Caj_header.hora            = TIME
                Caj_header.tipo_mov = IF T-Caj_header.tipo_mov = "T" THEN "E" ELSE T-Caj_header.tipo_mov
                Caj_header.tip_comprob = IF T-Caj_header.tipo_mov = "T" THEN "TS" ELSE "CJ".

    FOR EACH T-Caj_detalle:

         CREATE Caj_detalle.
         BUFFER-COPY T-Caj_detalle TO Caj_detalle
             ASSIGN Caj_detalle.nro_transaccion = Caj_header.nro_transaccion
                    Caj_detalle.tipo_mov = Caj_header.tipo_mov.
         
         IF T-Caj_detalle.tipo_mov = "I"
         THEN DO:
             FIND T-Valor WHERE T-Valor.nro_valor = T-Caj_detalle.nro_linea NO-ERROR.
             IF AVAILABLE T-Valor
             THEN DO:
                 CREATE Valor.
                 BUFFER-COPY T-Valor TO Valor
                     ASSIGN Valor.nro_valor = NEXT-VALUE(proximo_valor)
                            Valor.nro_transaccion = Caj_header.nro_transaccion
                            Valor.cdg_empresa = T-Caj_header.cdg_empresa 
                            Valor.cdg_caja = Caj_header.cdg_caja
                            Valor.estado = "00"
                            Valor.fecha_recepcion = Caj_header.fecha
                            Caj_detalle.nro_valor = Valor.nro_valor.
                 RELEASE Valor.
             END.
         END.
         ELSE DO:
             FIND Valor WHERE Valor.nro_valor = T-Caj_detalle.nro_valor EXCLUSIVE-LOCK NO-ERROR.
             IF AVAILABLE Valor
             THEN DO:
                 ASSIGN Valor.nro_transaccion = Caj_header.nro_transaccion
                        Valor.estado = IF T-Caj_detalle.tipo_mov = "E" THEN "10" ELSE "00"
                        Valor.fecha_salida = Caj_header.fecha.
                 RELEASE Valor.
             END.
         END.

         FIND T-Cheque WHERE T-Cheque.nro_cheque = T-Caj_detalle.nro_linea NO-ERROR.
         IF AVAILABLE T-Cheque
         THEN DO:
             CREATE Cheque.
             BUFFER-COPY T-Cheque TO Cheque
                 ASSIGN Cheque.nro_cheque = NEXT-VALUE(proximo_cheque)
                        Cheque.nro_transaccion = Caj_header.nro_transaccion
                        Cheque.estado          = "PP"
                        Caj_detalle.nro_cheque = Cheque.nro_cheque.
         END.

         RELEASE Caj_detalle.

    END.

    FOR EACH T-Caja-imputacion:
        CREATE Caja-imputacion.
        BUFFER-COPY T-Caja-imputacion TO Caja-imputacion
            ASSIGN  Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion.
        RELEASE Caja-imputacion.
    END.
   
    RUN emitir_movcaja.p ( INPUT ROWID(Caj_header)).
     
    RELEASE Caj_header.    

    IF T-Caj_header.tipo_mov = "T"
    THEN DO:

        CREATE Caj_header.
        BUFFER-COPY T-Caj_header TO Caj_header
            ASSIGN  Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
                    Caj_header.hora            = TIME
                    Caj_header.tipo_mov = "I"
                    Caj_header.cdg_caja = v-cdg_receptora
                    Caj_header.tip_comprob = "TI".

        FOR EACH T-Caj_detalle:
             
             CREATE Caj_detalle.
             BUFFER-COPY T-Caj_detalle TO Caj_detalle
                 ASSIGN Caj_detalle.nro_transaccion = Caj_header.nro_transaccion
                        Caj_detalle.tipo_mov = Caj_header.tipo_mov.

             FIND Valor WHERE Valor.nro_valor = T-Caj_detalle.nro_valor NO-ERROR.
             IF AVAILABLE Valor
             THEN DO:
                 ASSIGN Valor.nro_transaccion = Caj_header.nro_transaccion
                        Valor.estado = "00"
                        Valor.cdg_empresa = T-Caj_header.cdg_empresa 
                        Valor.fecha_salida = Caj_header.fecha
                        Valor.cdg_caja = Caj_header.cdg_caja.

                 RELEASE Valor.
             END.
             RELEASE Caj_detalle.
        END.
    
        FOR EACH T-Caja-imputacion:
            CREATE Caja-imputacion.
            BUFFER-COPY T-Caja-imputacion TO Caja-imputacion
                ASSIGN  Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion.
            RELEASE Caja-imputacion.
        END.
       
        RUN emitir_movcaja.p ( INPUT ROWID(Caj_header)).
         
        RELEASE Caj_header.    
        
    END.

    RELEASE Parametro.
END.
