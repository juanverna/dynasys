/*=================================================================================*/
/*                         EMITE UN REMITO DE PROVEEDOR                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_remito AS ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Rem_detalle_prv FOR Rem_detalle_prv.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */

FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remito EXCLUSIVE-LOCK.
FIND Imputacion OF  Rem_header_prv NO-LOCK.
FIND Deposito   OF  Rem_header_prv NO-LOCK.

/*=================================================================================*/
/*                                      STOCK                                      */
/*=================================================================================*/

FOR EACH Rem_detalle_prv OF Rem_header_prv EXCLUSIVE-LOCK, 
         FIRST Articulo EXCLUSIVE-LOCK OF Rem_detalle_prv:

    IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
    THEN DO:

         FIND Deposito          OF Rem_detalle_prv NO-LOCK NO-ERROR.
         FIND Articulo-deposito 
              WHERE Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                AND Articulo-deposito.nro_deposito = Rem_detalle_prv.nro_deposito
                AND Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo
                    EXCLUSIVE-LOCK.
                
         FIND Partida           OF Rem_detalle_prv EXCLUSIVE-LOCK.
         FIND Partida-deposito  
              WHERE Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                AND Partida-deposito.nro_deposito = Rem_detalle_prv.nro_deposito
                AND Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo
                AND Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida
                    EXCLUSIVE-LOCK NO-ERROR.

         IF NOT AVAILABLE Partida-deposito
         THEN DO:
              CREATE Partida-deposito.
              ASSIGN Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa
                     Partida-deposito.nro_deposito = Rem_detalle_prv.nro_deposito
                     Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo
                     Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida.
         END.

         IF Rem_header_prv.tip_comprob = "RP"
         THEN DO:
              Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.
              Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Rem_detalle_prv.granel.
              Partida.remanente_cantidad           = Partida.remanente_cantidad + Rem_detalle_prv.cantidad.
              Partida.remanente_granel             = Partida.remanente_granel + Rem_detalle_prv.granel.
              Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.
              Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Rem_detalle_prv.granel.
         END.
         ELSE DO:   
              Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.
              Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Rem_detalle_prv.granel.
              Partida.remanente_cantidad           = Partida.remanente_cantidad - Rem_detalle_prv.cantidad.
              Partida.remanente_granel             = Partida.remanente_granel - Rem_detalle_prv.granel.
              Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.
              Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Rem_detalle_prv.granel.
         END.

    END.

    CREATE Cct_stock.
    ASSIGN
           Cct_stock.nro_deposito   = Deposito.nro_deposito
           Cct_stock.tipo_mov       = ( IF Rem_header_prv.tip_comprob = "RP" THEN "I" ELSE "E" )
           Cct_stock.cdg_empresa    = Rem_header_prv.cdg_empresa
           Cct_stock.tip_comprob    = Rem_header_prv.tip_comprob
           Cct_stock.prf_comprob    = Rem_header_prv.prf_comprob
           Cct_stock.nro_comprob    = Rem_header_prv.nro_comprob
           Cct_stock.nro_proveedor  = Rem_header_prv.nro_proveedor
           Cct_stock.fecha          = Rem_header_prv.fecha
           Cct_stock.nro_linea      = Rem_detalle_prv.nro_linea
           Cct_stock.cantidad       = Rem_detalle_prv.cantidad
           Cct_stock.granel         = Rem_detalle_prv.granel
           Cct_stock.nro_articulo   = Rem_detalle_prv.nro_articulo
           Cct_stock.nro_partida    = Rem_detalle_prv.nro_partida
           Cct_stock.nro_entidad    = Rem_detalle_prv.nro_entidad.

   act_cctstk = ROWID(Cct_stock).
   RUN ACUMSTCK.P ("A").

               /*--------------------------------------------*/
               /*      ACTUALIZA EL P.P.P. DEL ARTICULO      */
               /*--------------------------------------------*/

   Articulo.total_comprado = Articulo.total_comprado + 
           ( IF Articulo.a_granel 
                THEN ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.granel   , 2 )
                ELSE ROUND( Rem_detalle_prv.precio * Rem_detalle_prv.cantidad , 2 ) ).
                
   Articulo.unidades_compradas = Articulo.unidades_compradas + Rem_detalle_prv.cantidad.
   Articulo.granel_comprado    = Articulo.granel_comprado + Rem_detalle_prv.granel.
   
  IF Articulo.a_granel 
     THEN Articulo.costo = Articulo.total_comprado / Articulo.granel_comprado.
     ELSE Articulo.costo = Articulo.total_comprado / Articulo.unidades_compradas.

               /*--------------------------------------------*/
               /* ACTUALIZA EL ESTADO DE LA O/COMPRA, SI HAY */
               /*--------------------------------------------*/

                       /* ACA DEBEMOS ACTUALIZAR */

/* --- Esto es lo que hace el remito -----------------------------------------------

  total_pendiente = Ocm_detalle.cantidad.
  FOR EACH B-Recepcion-ocompra 
      WHERE B-Recepcion-ocompra.nro_ocompra   = Ocm_detalle.nro_ocompra
        AND B-Recepcion-ocompra.nro_linea_ocm = Ocm_detalle.nro_linea NO-LOCK:
        
        total_pendiente = total_pendiente - B-Recepcion-ocompra.cantidad.

  END.

-----------------------------------------------------------------------------------*/
END.

/*=================================================================================*/
/*                     GENERA IMPUTACION CONTABLE DEL COMPROBANTE                  */
/*=================================================================================*/

{CALCRPRO.I } /* Genera el registro contable */

/*=================================================================================*/
/*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
/*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */


/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

RUN IMPRIMIR_REMITO.

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/

PROCEDURE IMPRIMIR_REMITO:

   RUN getparametro.p (  INPUT  "NCOPIARM",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   ncopias = Parametro.valor_n.

   RUN getparametro.p (  INPUT  "NFREMPRV",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   que_rutina = "PRRPV" + STRING(v-valor_n, "999") + ".P".

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

      RUN VALUE(que_rutina) (INPUT ROWID(Rem_header_prv)).

   END.

END PROCEDURE.

