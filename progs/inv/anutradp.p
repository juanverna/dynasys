/*=================================================================================*/
/*                    ANULACION DE LAS TRANSFERENCIAS DE INVENTARIO                */
/*=================================================================================*/

DEFINE INPUT PARAMETER  act_header      AS ROWID.
DEFINE OUTPUT PARAMETER puede_anular    AS INTEGER.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE BUFFER B-Transdep_dt         FOR Transdep_dt.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

    FIND Transdep_hd WHERE ROWID(Transdep_hd) = act_header EXCLUSIVE-LOCK.
    
    FOR EACH Transdep_dt OF Transdep_hd EXCLUSIVE-LOCK, EACH Articulo OF Transdep_dt NO-LOCK:
    
         FIND Partida OF Transdep_dt EXCLUSIVE-LOCK.

                  /*------------------------------------------------*/
                  /* Al derecho, se EGRESA desde el DESPACHO, ahora */
                  /* se INGRESA al deposito que DESPACHO            */
                  /*------------------------------------------------*/

         FIND Deposito          OF Transdep_dt NO-LOCK NO-ERROR.
         FIND Articulo-deposito 
              WHERE Articulo-deposito.nro_articulo = Transdep_dt.nro_articulo
                AND Articulo-deposito.nro_deposito = Transdep_dt.nro_deposito 
                AND Articulo-deposito.cdg_empresa  = Transdep_hd.cdg_empresa 
                    EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Articulo-deposito
         THEN DO:
              CREATE Articulo-deposito.
              ASSIGN Articulo-deposito.nro_deposito = Transdep_dt.nro_deposito
                     Articulo-deposito.nro_articulo = Transdep_dt.nro_articulo
                     Articulo-deposito.cdg_empresa  = Transdep_hd.cdg_empresa.
         
         END.

         FIND Partida-deposito
              WHERE Partida-deposito.nro_deposito = Transdep_dt.nro_deposito
                AND Partida-deposito.nro_articulo = Transdep_dt.nro_articulo
                AND Partida-deposito.nro_partida  = Transdep_dt.nro_partida
                AND Partida-deposito.cdg_empresa  = Transdep_hd.cdg_empresa
                    EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Partida-deposito
         THEN DO:
              CREATE Partida-deposito.
              ASSIGN Partida-deposito.nro_deposito = Transdep_dt.nro_deposito
                     Partida-deposito.nro_articulo = Transdep_dt.nro_articulo
                     Partida-deposito.nro_partida  = Transdep_dt.nro_partida
                     Partida-deposito.cdg_empresa  = Transdep_hd.cdg_empresa.
         END.

         ASSIGN   
              Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Transdep_dt.cantidad.
              Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Transdep_dt.granel.
              Partida.remanente_cantidad           = Partida.remanente_cantidad + Transdep_dt.cantidad.
              Partida.remanente_granel             = Partida.remanente_granel + Transdep_dt.granel.
              Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Transdep_dt.cantidad.
              Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Transdep_dt.granel.

         FIND Cct_stock 
                WHERE Cct_stock.cdg_empresa    = Transdep_hd.cdg_empresa
                  AND Cct_stock.nro_deposito   = Deposito.nro_deposito
                  AND Cct_stock.tip_comprob    = "TS"
                  AND Cct_stock.prf_comprob    = 0
                  AND Cct_stock.nro_comprob    = Transdep_hd.nro_comprob
                  AND Cct_stock.nro_linea      = Transdep_dt.nro_linea
                      EXCLUSIVE-LOCK NO-ERROR.
         
         IF AVAILABLE Cct_stock 
         THEN DO: 
             RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "B").
             DELETE Cct_stock.
         END.

                  /*----------------------------------------------*/
                  /* Generamos el EGRESO del deposito que RECIBIO */
                  /*----------------------------------------------*/


         FIND Deposito OF Transdep_hd NO-LOCK NO-ERROR.
         FIND Articulo-deposito 
              WHERE Articulo-deposito.nro_articulo = Transdep_dt.nro_articulo
                AND Articulo-deposito.nro_deposito = Transdep_hd.nro_deposito 
                AND Articulo-deposito.cdg_empresa  = Transdep_hd.cdg_empresa 
                    EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Articulo-deposito
         THEN DO:
              CREATE Articulo-deposito.
              ASSIGN Articulo-deposito.nro_deposito = Transdep_hd.nro_deposito
                     Articulo-deposito.nro_articulo = Transdep_dt.nro_articulo
                     Articulo-deposito.cdg_empresa  = Transdep_hd.cdg_empresa.
         
         END.

         FIND Partida-deposito
              WHERE Partida-deposito.nro_deposito = Transdep_hd.nro_deposito
                AND Partida-deposito.nro_articulo = Transdep_dt.nro_articulo
                AND Partida-deposito.nro_partida  = Transdep_dt.nro_partida
                AND Partida-deposito.cdg_empresa  = Transdep_hd.cdg_empresa
                    EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Partida-deposito
         THEN DO:
              CREATE Partida-deposito.
              ASSIGN Partida-deposito.nro_deposito = Transdep_hd.nro_deposito
                     Partida-deposito.nro_articulo = Transdep_dt.nro_articulo
                     Partida-deposito.nro_partida  = Transdep_dt.nro_partida
                     Partida-deposito.cdg_empresa  = Transdep_hd.cdg_empresa.
         END.

         ASSIGN
              Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Transdep_dt.cantidad.
              Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Transdep_dt.granel.
              Partida.remanente_cantidad           = Partida.remanente_cantidad - Transdep_dt.cantidad.
              Partida.remanente_granel             = Partida.remanente_granel - Transdep_dt.granel.
              Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Transdep_dt.cantidad.
              Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Transdep_dt.granel.

         FIND Cct_stock 
                WHERE Cct_stock.cdg_empresa    = Transdep_hd.cdg_empresa
                  AND Cct_stock.nro_deposito   = Transdep_hd.nro_deposito
                  AND Cct_stock.tip_comprob    = "TE"
                  AND Cct_stock.prf_comprob    = 0
                  AND Cct_stock.nro_comprob    = Transdep_hd.nro_comprob
                  AND Cct_stock.nro_linea      = Transdep_dt.nro_linea
                      EXCLUSIVE-LOCK NO-ERROR.

         IF AVAILABLE Cct_stock 
         THEN DO: 
             RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "B").
             DELETE Cct_stock.
         END.
    
    
        Transdep_hd.estado = "A".
    
    END.
    
    /*=================================================================================*/
    /*                     ANULA IMPUTACION CONTABLE DEL COMPROBANTE                   */
    /*=================================================================================*/
    
    FIND Sub_header_inv
         WHERE Sub_header_inv.cdg_empresa   = Transdep_hd.cdg_empresa
           AND Sub_header_inv.tip_comprob   = Transdep_hd.tip_comprob
           AND Sub_header_inv.prf_comprob   = Transdep_hd.prf_comprob
           AND Sub_header_inv.nro_comprob   = Transdep_hd.nro_comprob
           AND Sub_header_inv.nro_proveedor = 0
               EXCLUSIVE-LOCK NO-ERROR.
    
    IF AVAILABLE Sub_header_inv 
        THEN Sub_header_inv.anulado = YES.
    
    puede_anular = 1.
    FIND Transdep_hd WHERE ROWID(Transdep_hd) = act_header EXCLUSIVE-LOCK NO-ERROR.
         
    IF Transdep_hd.tip_comprob = "RM" 
    THEN DO:
        FIND Sre_header WHERE Sre_header.nro_solicitud = Transdep_hd.nro_solicitud 
                          AND Sre_header.cdg_estado = "RE" EXCLUSIVE-LOCK NO-ERROR.
        IF AVAILABLE Sre_header 
        THEN DO:

            Sre_header.cdg_estado = "AA".
            Sre_header.estado = "E".
    
            FOR EACH Sre_detalle OF Sre_header EXCLUSIVE-LOCK:
                Sre_detalle.cdg_estado = "AA".
            END.

            Transdep_hd.anulado = YES.
            puede_anular = 0.
          
       END.

    END.

    /*=================================================================================*/
    /*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
    /*=================================================================================*/

END.
