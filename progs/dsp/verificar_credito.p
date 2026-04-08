/*=================================================================================*/
/*                     APROBACION DE PEDIDOS POR CUENTA CORRIENTE                  */
/*=================================================================================*/

/*=================================================================================*/
/*                            TABLAS TEMPORALES                                    */
/*=================================================================================*/       
       
DEFINE TEMP-TABLE T-Ped_header        NO-UNDO LIKE Ped_header.
DEFINE TEMP-TABLE T-Ped_detalle       NO-UNDO LIKE Ped_detalle.
DEFINE TEMP-TABLE T-Ped_detalle_entr  NO-UNDO LIKE Ped_detalle_entr.

/*=================================================================================*/
/*                                 PARAMETROS                                      */
/*=================================================================================*/       
    
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_header.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle.       
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR T-Ped_detalle_entr.       

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{STPEDIDO.I} /* Posibles estados de pedido */
{VRCNTLDE.I} /* Variables de control de deuda  */

DEFINE VARIABLE v-habilitado AS LOGICAL.

/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

FIND FIRST T-Ped_header EXCLUSIVE-LOCK.

/*---------------------------------------------------------------------------------*/
/*    Fijamos el estado en APROBADO. Si no hay errores, queda con ese valor        */
/*---------------------------------------------------------------------------------*/

T-Ped_header.cdg_estado = stped_aprobado.

/*---------------------------------------------------------------------------------*/
/*            Si está habilitado, revisamos el estado crediticio                   */
/*---------------------------------------------------------------------------------*/

RUN getparametro_l.p ( INPUT "HBPDCCTE", OUTPUT v-habilitado ).

IF v-habilitado
THEN DO:

    FIND Cliente OF T-Ped_header NO-LOCK.
    RUN sumar_estadocred.p ( INPUT ROWID(Cliente),
                             INPUT YES,
                             OUTPUT saldo_cc,
                             OUTPUT saldo_ccv,
                             OUTPUT tot_valores,
                             OUTPUT tot_remitos,
                             OUTPUT tot_pedidos,
                             OUTPUT cant_rech,
                             OUTPUT tot_credito ).
    
    FIND LAST Creditomaximo OF Cliente 
        WHERE Creditomaximo.cdg_empresa = T-Ped_header.cdg_empresa
          AND Creditomaximo.desde_fecha <= T-Ped_header.fecha
              NO-LOCK NO-ERROR.

    IF AVAILABLE Creditomaximo 
    THEN DO:
        dis_credito = Creditomaximo.credito_maximo - tot_credito.
        IF tot_credito = ? 
            THEN dis_credito = 0.
    END.
    ELSE DO:
        dis_credito = 0.
    END.

    IF dis_credito - T-Ped_header.imp_total  <= 0
        THEN T-Ped_header.cdg_estado = stped_creditoins.    

/*     IF saldo_ccv <> 0                                                   */
/*        THEN T-Ped_header.cdg_estado = stped_deuvencida.                 */
/*        ELSE IF cant_rech > Cliente.max_chrechazados                     */
/*                THEN T-Ped_header.cdg_estado = stped_chequerech.         */
/*                ELSE IF dis_credito - T-Ped_header.imp_total  <= 0       */
/*                        THEN T-Ped_header.cdg_estado = stped_creditoins. */
/*                                                                         */

/*
         MESSAGE 
              "saldo_cc        :"   saldo_cc    SKIP  
              "saldo_ccv       :"   saldo_ccv   SKIP 
              "tot_valores     :"   tot_valores SKIP
              "tot_remitos     :"   tot_remitos SKIP
              "tot_pedidos     :"   tot_pedidos SKIP
              "cant_rech       :"   cant_rech   SKIP 
              "tot_credito     :"   tot_credito SKIP
              "pedido          :"   T-Ped_header.imp_total SKIP
              "disponible      :"   dis_credito SKIP
             VIEW-AS ALERT-BOX MESSAGE.
*/

END.

/*---------------------------------------------------------------------------------*/
/*     Si encontro algún error, marca todo el pedido con el codigo ese  vuelve     */
/*---------------------------------------------------------------------------------*/

IF T-Ped_header.cdg_estado <> stped_aprobado 
THEN DO:
    /* Marcamos todos los renglones como retenidos por crédito */
    FOR EACH T-Ped_detalle OF T-Ped_header EXCLUSIVE-LOCK:
        FOR EACH T-Ped_detalle_entr OF T-Ped_detalle EXCLUSIVE-LOCK:
            T-Ped_detalle_entr.cdg_estado = T-Ped_header.cdg_estado.
        END.          
    END.
    RETURN. 
END.

/*---------------------------------------------------------------------------------*/
/*            Si está habilitado, revisamos la condicion de venta                  */
/*---------------------------------------------------------------------------------*/

RUN getparametro_l.p ( INPUT "HBPDCNDV", OUTPUT v-habilitado ).

IF v-habilitado
THEN DO:

    FIND Condicion_venta OF T-Ped_header NO-LOCK.
    IF NOT CAN-FIND(FIRST Cliente_cndventa OF Cliente
                          WHERE Cliente_cndventa.nro_cndventa = Condicion_venta.nro_cndventa
                            AND Cliente_cndventa.cdg_empresa = T-Ped_header.cdg_empresa)
    THEN DO:
        T-Ped_header.cdg_estado = stped_cndventano.
        RETURN.
    END.

END.

IF T-Ped_header.cdg_estado <> stped_aprobado THEN RETURN. /* Si encontro algún error vuelve */

/*---------------------------------------------------------------------------------*/
/*            Si está habilitado, revisamos la lista de precios                    */
/*---------------------------------------------------------------------------------*/

RUN getparametro_l.p ( INPUT "HBPDLPRE", OUTPUT v-habilitado ).

IF v-habilitado
THEN DO:

    IF Cliente.dfl_lista <> T-Ped_header.cdg_lista
        THEN T-Ped_header.cdg_estado = stped_listapreno.

END.

