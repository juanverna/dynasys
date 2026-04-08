/*=================================================================================*/
/*                           EMISION DE LOS VALES DE SALIDA                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_remito AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE NEW SHARED VARIABLE act_cctstk   AS ROWID.

/* {VRSHARED.I} */
/* {parlocales.i}  */

{VPERSINM.I}

DEFINE SHARED VARIABLE emitir_remito  AS LOGICAL.
DEFINE SHARED VARIABLE emitir_factura AS LOGICAL.

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE modo_emision        AS INTEGER INITIAL 0.
DEFINE VARIABLE indep               AS INTEGER INITIAL 0.
DEFINE VARIABLE rem_y_fac           AS INTEGER INITIAL 1.
DEFINE VARIABLE fac_y_rem           AS INTEGER INITIAL 2.
DEFINE VARIABLE lado_a_lado         AS INTEGER INITIAL 3.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Rem_detalle_prv         FOR Rem_detalle_prv.

/*=================================================================================*/
/*                     ARRANCA LA TRANSACCION DE ACTUALIZACION                     */
/*=================================================================================*/
/*
DEFINE VARIABLE demora AS INTEGER.
OUTPUT TO VALUE(SESSION:TEMP-DIRECTORY + "emitradp.log") PAGED.
PUT TODAY "  " STRING(TIME,"HH:MM:SS") SKIP.
demora = ETIME(YES).
*/

DO ON ERROR UNDO, LEAVE: /* ARRANCAMOS AQUI LA TRANSACCION */


/* {putime.i "Arranca Transaccion:" }*/

FIND Rem_header_prv WHERE ROWID(Rem_header_prv) = rid_remito EXCLUSIVE-LOCK.
FIND Imputacion OF Rem_header_prv NO-LOCK.
/* FIND Cuenta OF Imputacion NO-LOCK. */

/*=================================================================================*/
/*                                      STOCK                                      */
/*=================================================================================*/

FOR EACH Rem_detalle_prv OF Rem_header_prv EXCLUSIVE-LOCK, EACH Articulo OF Rem_detalle_prv NO-LOCK:

/*    {putime.i "Arranca Linea de Transferencia:" } */

    IF TRUE /*Articulo.hay_partida*/ /* Todos los articulos tienen partidas, sean reales o ficticias */
    THEN DO:

         FIND Partida OF Rem_detalle_prv EXCLUSIVE-LOCK.

                  /*-----------------------------------------------*/
                  /* Generamos el EGRESO del deposito que DESPACHA */
                  /*-----------------------------------------------*/

/*          FIND Deposito OF Rem_detalle_prv NO-LOCK NO-ERROR.                                                           */
/*                                                                                                                       */
/*          FIND Articulo-deposito                                                                                       */
/*               WHERE Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                     */
/*                 AND Articulo-deposito.cdg_deposito = Rem_detalle_prv.cdg_deposito                                     */
/*                 AND Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa                                       */
/*                     EXCLUSIVE-LOCK NO-ERROR.                                                                          */
/*                                                                                                                       */
/*          IF NOT AVAILABLE Articulo-deposito                                                                           */
/*          THEN DO:                                                                                                     */
/*               CREATE Articulo-deposito.                                                                               */
/*               ASSIGN Articulo-deposito.cdg_deposito = Rem_detalle_prv.cdg_deposito                                    */
/*                      Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                    */
/*                      Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa.                                     */
/*                                                                                                                       */
/*          END.                                                                                                         */
/*                                                                                                                       */
/*          FIND Partida-deposito                                                                                        */
/*               WHERE Partida-deposito.cdg_deposito = Rem_detalle_prv.cdg_deposito                                      */
/*                 AND Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                      */
/*                 AND Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida                                       */
/*                 AND Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa                                        */
/*                     EXCLUSIVE-LOCK NO-ERROR.                                                                          */
/*                                                                                                                       */
/*          IF NOT AVAILABLE Partida-deposito                                                                            */
/*          THEN DO:                                                                                                     */
/*               CREATE Partida-deposito.                                                                                */
/*               ASSIGN Partida-deposito.cdg_deposito = Rem_detalle_prv.cdg_deposito                                     */
/*                      Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                     */
/*                      Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida                                      */
/*                      Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa.                                      */
/*          END.                                                                                                         */
/*                                                                                                                       */
/*          ASSIGN                                                                                                       */
/*               Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad - Rem_detalle_prv.cantidad. */
/*               Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel - Rem_detalle_prv.granel.     */
/*               Partida.remanente_cantidad           = Partida.remanente_cantidad - Rem_detalle_prv.cantidad.           */
/*               Partida.remanente_granel             = Partida.remanente_granel - Rem_detalle_prv.granel.               */
/*               Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad - Rem_detalle_prv.cantidad.  */
/*               Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel - Rem_detalle_prv.granel.      */
/*                                                                                                                       */
/*          CREATE Cct_stock.                                                                                            */
/*          ASSIGN                                                                                                       */
/*                 Cct_stock.cdg_deposito    = Deposito.cdg_deposito                                                     */
/*                 Cct_stock.cdg_empresa     = Rem_header_prv.cdg_empresa                                                */
/*                 Cct_stock.tipo_mov        = "E"                                                                       */
/*                 Cct_stock.tip_comprob     = "TS"                                                                      */
/*                 Cct_stock.prf_comprob     = 0                                                                         */
/*                 Cct_stock.nro_comprob     = Rem_header_prv.nro_comprob                                                */
/*                 Cct_stock.fecha           = Rem_header_prv.fecha                                                      */
/*                 Cct_stock.nro_linea       = Rem_detalle_prv.nro_linea                                                 */
/*                 Cct_stock.cantidad        = Rem_detalle_prv.cantidad                                                  */
/*                 Cct_stock.granel          = Rem_detalle_prv.granel                                                    */
/*                 Cct_stock.nro_articulo    = Rem_detalle_prv.nro_articulo                                              */
/*                 Cct_stock.nro_partida     = Rem_detalle_prv.nro_partida                                               */
/*                 Cct_stock.nro_entidad     = Rem_detalle_prv.nro_entidad.                                              */
/*                                                                                                                       */
/*          act_cctstk = ROWID(Cct_stock).                                                                               */
/*                                                                                                                       */
/*      /*    {putime.i "Invoca la acumulacion. Acumula:" }*/                                                            */
/*                                                                                                                       */
/*          RUN acumstck.p ( INPUT "A").                                                                                 */

/*         {putime.i "Acumulo y empieza el ingreso:" }*/


                  /*---------------------------------------------*/
                  /* Generamos el INGRESO al deposito que RECIBE */
                  /*---------------------------------------------*/

/*          FIND Deposito OF Rem_header_prv NO-LOCK NO-ERROR. */
/*                                                            */
/*          FIND Articulo-deposito                                                                                       */
/*               WHERE Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                     */
/*                 AND Articulo-deposito.cdg_deposito = Rem_header_prv.cdg_deposito                                      */
/*                 AND Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa                                       */
/*                     EXCLUSIVE-LOCK NO-ERROR.                                                                          */
/*                                                                                                                       */
/*          IF NOT AVAILABLE Articulo-deposito                                                                           */
/*          THEN DO:                                                                                                     */
/*               CREATE Articulo-deposito.                                                                               */
/*               ASSIGN Articulo-deposito.cdg_deposito = Rem_header_prv.cdg_deposito                                     */
/*                      Articulo-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                    */
/*                      Articulo-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa.                                     */
/*                                                                                                                       */
/*          END.                                                                                                         */
/*                                                                                                                       */
/*          FIND Partida-deposito                                                                                        */
/*               WHERE Partida-deposito.cdg_deposito = Rem_header_prv.cdg_deposito                                       */
/*                 AND Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                      */
/*                 AND Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida                                       */
/*                 AND Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa                                        */
/*                     EXCLUSIVE-LOCK NO-ERROR.                                                                          */
/*                                                                                                                       */
/*          IF NOT AVAILABLE Partida-deposito                                                                            */
/*          THEN DO:                                                                                                     */
/*               CREATE Partida-deposito.                                                                                */
/*               ASSIGN Partida-deposito.cdg_deposito = Rem_header_prv.cdg_deposito                                      */
/*                      Partida-deposito.nro_articulo = Rem_detalle_prv.nro_articulo                                     */
/*                      Partida-deposito.nro_partida  = Rem_detalle_prv.nro_partida                                      */
/*                      Partida-deposito.cdg_empresa  = Rem_header_prv.cdg_empresa.                                      */
/*          END.                                                                                                         */
/*                                                                                                                       */
/*          ASSIGN                                                                                                       */
/*               Articulo-deposito.remanente_cantidad = Articulo-deposito.remanente_cantidad + Rem_detalle_prv.cantidad. */
/*               Articulo-deposito.remanente_granel   = Articulo-deposito.remanente_granel + Rem_detalle_prv.granel.     */
/*               Partida.remanente_cantidad           = Partida.remanente_cantidad + Rem_detalle_prv.cantidad.           */
/*               Partida.remanente_granel             = Partida.remanente_granel + Rem_detalle_prv.granel.               */
/*               Partida-deposito.remanente_cantidad  = Partida-deposito.remanente_cantidad + Rem_detalle_prv.cantidad.  */
/*               Partida-deposito.remanente_granel    = Partida-deposito.remanente_granel + Rem_detalle_prv.granel.      */
/*                                                                                                                       */
/*          CREATE Cct_stock.                                                                                            */
/*          ASSIGN                                                                                                       */
/*                 Cct_stock.cdg_deposito   = Rem_header_prv.cdg_deposito                                                */
/*                 Cct_stock.cdg_empresa    = Rem_header_prv.cdg_empresa                                                 */
/*                 Cct_stock.tipo_mov       = "I"                                                                        */
/*                 Cct_stock.tip_comprob    = "TE"                                                                       */
/*                 Cct_stock.prf_comprob    = 0                                                                          */
/*                 Cct_stock.nro_comprob    = Rem_header_prv.nro_comprob                                                 */
/*                 Cct_stock.fecha          = Rem_header_prv.fecha                                                       */
/*                 Cct_stock.nro_linea      = Rem_detalle_prv.nro_linea                                                  */
/*                 Cct_stock.cantidad       = Rem_detalle_prv.cantidad                                                   */
/*                 Cct_stock.granel         = Rem_detalle_prv.granel                                                     */
/*                 Cct_stock.nro_articulo   = Rem_detalle_prv.nro_articulo                                               */
/*                 Cct_stock.nro_partida    = Rem_detalle_prv.nro_partida                                                */
/*                 Cct_stock.nro_entidad    = Rem_detalle_prv.nro_entidad.                                               */
/*                                                                                                                       */
/*          act_cctstk = ROWID(Cct_stock).                                                                               */
/*                                                                                                                       */
       /*  {putime.i "Termina de generar ingreso. Acumula:" } */

/*          RUN acumstck.p ( INPUT "A"). */

       /*  {putime.i "Termina de acumular y termina transaccion:" } */

    END.

END.

/*=================================================================================*/
/*                     GENERA IMPUTACION CONTABLE DEL COMPROBANTE                  */
/*=================================================================================*/

/*  {putime.i "Termina transferencia. Inicia asiento:" }*/

/* {CALCTRDP.I } /* Genera el registro contable */  */

/*  {putime.i "Termina asiento:" }*/

/*=================================================================================*/
/*                     FINALIZA LA TRANSACCION DE ACTUALIZACION                    */
/*=================================================================================*/

END.  /* FIN DE LA TRANSACCION */

/*  {putime.i "Termina transaccion:" }*/

OUTPUT CLOSE.

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

/*RUN IMPRIMIR_VALE.*/

/*  {imprimir_remito_bdu.i "Rem_header_prv"}. */
/*                                         */
RUN prprv122.p (INPUT ROWID(Rem_header_prv)). /*Reemplaza a IMPRIMIR_VALE*/

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/
/*                                                                        */
/* PROCEDURE IMPRIMIR_VALE:                                               */
/*                                                                        */
/*    RUN getparametro.p (  INPUT  "NCOPIARM",                            */
/*                          OUTPUT v-valor_c,                             */
/*                          OUTPUT v-valor_d,                             */
/*                          OUTPUT v-valor_l,                             */
/*                          OUTPUT v-valor_n,                             */
/*                          OUTPUT v-observacion ).                       */
/*    ncopias = v-valor_n.                                                */
/*                                                                        */
/*    RUN getparametro.p (  INPUT  "NFTRADEP",                            */
/*                          OUTPUT v-valor_c,                             */
/*                          OUTPUT v-valor_d,                             */
/*                          OUTPUT v-valor_l,                             */
/*                          OUTPUT v-valor_n,                             */
/*                          OUTPUT v-observacion ).                       */
/*                                                                        */
/*    que_rutina = "PRTRA" + STRING(v-valor_n, "999") + ".P".             */
/*                                                                        */
/*    RUN getparametro.p (  INPUT  "FACTHOJA",                            */
/*                          OUTPUT v-valor_c,                             */
/*                          OUTPUT v-valor_d,                             */
/*                          OUTPUT v-valor_l,                             */
/*                          OUTPUT v-valor_n,                             */
/*                          OUTPUT v-observacion ).                       */
/*                                                                        */
/*    DO j = 1 TO ncopias:                                                */
/*       IF v-valor_l                                                     */
/*       THEN DO:                                                         */
/*          MESSAGE "Por Favor, coloque formulario en la impresora para"  */
/*                  + " imprimir copia de remito Nro.:" + STRING(j,"9")   */
/*                  VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion". */
/*       END.                                                             */
/*                                                                        */
/*       RUN VALUE(que_rutina) (INPUT ROWID(Rem_header_prv)).                */
/*                                                                        */
/*    END.                                                                */
/*                                                                        */
/* END PROCEDURE.                                                         */
/*                                                                        */
