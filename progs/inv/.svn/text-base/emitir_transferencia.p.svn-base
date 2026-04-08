/*=================================================================================*/
/*                           EMISION DE LOS VALES DE SALIDA                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_remito AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE BUFFER B-Transdep_dt         FOR Transdep_dt.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */


    FIND Transdep_hd WHERE ROWID(Transdep_hd) = rid_remito EXCLUSIVE-LOCK.
    FIND Imputacion OF Transdep_hd NO-LOCK.
    
    
    /*=================================================================================*/
    /*                                      STOCK                                      */
    /*=================================================================================*/
    
    FOR EACH Transdep_dt OF Transdep_hd EXCLUSIVE-LOCK, EACH Articulo OF Transdep_dt NO-LOCK:
        
    
         FIND Partida OF Transdep_dt EXCLUSIVE-LOCK.

                  /*-----------------------------------------------*/
                  /* Generamos el EGRESO del deposito que DESPACHA */
                  /*-----------------------------------------------*/

         FIND Deposito OF Transdep_dt NO-LOCK NO-ERROR.

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
              Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Transdep_dt.cantidad.
              Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Transdep_dt.granel.
              Partida.remanente_cantidad           = Partida.remanente_cantidad - Transdep_dt.cantidad.
              Partida.remanente_granel             = Partida.remanente_granel - Transdep_dt.granel.
              Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Transdep_dt.cantidad.
              Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Transdep_dt.granel.

         CREATE Cct_stock.
         ASSIGN Cct_stock.nro_deposito    = Deposito.nro_deposito
                Cct_stock.cdg_empresa     = Transdep_hd.cdg_empresa
                Cct_stock.tipo_mov        = "E"
                Cct_stock.tip_comprob     = "TS"
                Cct_stock.prf_comprob     = 0
                Cct_stock.nro_comprob     = Transdep_hd.nro_comprob
                Cct_stock.fecha           = Transdep_hd.fecha
                Cct_stock.nro_linea       = Transdep_dt.nro_linea
                Cct_stock.cantidad        = Transdep_dt.cantidad
                Cct_stock.granel          = Transdep_dt.granel
                Cct_stock.nro_articulo    = Transdep_dt.nro_articulo
                Cct_stock.nro_partida     = Transdep_dt.nro_partida
                Cct_stock.nro_entidad     = Transdep_dt.nro_entidad.

         RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "A").

                  /*---------------------------------------------*/
                  /* Generamos el INGRESO al deposito que RECIBE */
                  /*---------------------------------------------*/

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

         ASSIGN Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Transdep_dt.cantidad.
                Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Transdep_dt.granel.
                Partida.remanente_cantidad           = Partida.remanente_cantidad + Transdep_dt.cantidad.
                Partida.remanente_granel             = Partida.remanente_granel + Transdep_dt.granel.
                Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Transdep_dt.cantidad.
                Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Transdep_dt.granel.

         CREATE Cct_stock.
         ASSIGN Cct_stock.nro_deposito   = Transdep_hd.nro_deposito
                Cct_stock.cdg_empresa    = Transdep_hd.cdg_empresa
                Cct_stock.tipo_mov       = "I"
                Cct_stock.tip_comprob    = "TE"
                Cct_stock.prf_comprob    = 0
                Cct_stock.nro_comprob    = Transdep_hd.nro_comprob
                Cct_stock.fecha          = Transdep_hd.fecha
                Cct_stock.nro_linea      = Transdep_dt.nro_linea
                Cct_stock.cantidad       = Transdep_dt.cantidad
                Cct_stock.granel         = Transdep_dt.granel
                Cct_stock.nro_articulo   = Transdep_dt.nro_articulo
                Cct_stock.nro_partida    = Transdep_dt.nro_partida
                Cct_stock.nro_entidad    = Transdep_dt.nro_entidad.

         RUN acumular_movimiento_stock.p ( INPUT ROWID(Cct_stock), INPUT "A").

    END.
    
    /*=================================================================================*/
    /*                     GENERA IMPUTACION CONTABLE DEL COMPROBANTE                  */
    /*=================================================================================*/
    
    {CALCTRDP.I } /* Genera el registro contable */
    
    /*=================================================================================*/
    /*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
    /*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */


OUTPUT CLOSE.

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN IMPRIMIR_VALE.


/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/

PROCEDURE IMPRIMIR_VALE:

   DEFINE VARIABLE ncopias    AS INTEGER.
   DEFINE VARIABLE j          AS INTEGER.
   DEFINE VARIABLE que_rutina AS CHARACTER.

   {parlocales.i}

   RUN getparametro.p (  INPUT  "NCOPIARM",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   ncopias = v-valor_n.

   RUN getparametro.p (  INPUT  "NFTRADEP",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   que_rutina = "PRTRA" + STRING(v-valor_n, "999") + ".P".

   RUN getparametro.p (  INPUT  "FACTHOJA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   DO j = 1 TO ncopias:
      IF v-valor_l
      THEN DO:
         MESSAGE "Por Favor, coloque formulario en la impresora para"
                 + " imprimir copia de remito Nro.:" + STRING(j,"9")
                 VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
      END.

      RUN VALUE(que_rutina) (INPUT ROWID(Transdep_hd)).

   END.

END PROCEDURE.

