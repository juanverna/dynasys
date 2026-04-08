/*=================================================================================*/
/*             VERIFICA QUE EL CALCE DE PEDIDO Y REMITO SEA FACTIBLE               */
/*=================================================================================*/

DEFINE INPUT  PARAMETER p-nro_pedido       LIKE Ped_header.nro_pedido.
DEFINE INPUT  PARAMETER p-nro_remito       LIKE Rem_header.nro_remito.
DEFINE INPUT  PARAMETER p-fecha            AS DATE.

DEFINE OUTPUT PARAMETER p-rc               AS INTEGER.

/*=================================================================================*/
/*                                  VARIABLE                                       */
/*=================================================================================*/

DEFINE VARIABLE saldo_cantidad             LIKE Rem_detalle.cantidad.
DEFINE VARIABLE saldo_granel               LIKE Rem_detalle.granel.

DEFINE VARIABLE posible_calzar_cantidad    LIKE Rem_detalle.cantidad.
DEFINE VARIABLE posible_calzar_granel      LIKE Rem_detalle.granel.

DEFINE VARIABLE cantidad_a_calzar          LIKE Rem_detalle.cantidad.
DEFINE VARIABLE granel_a_calzar            LIKE Rem_detalle.granel.

DEFINE BUFFER B-Ped_detalle FOR Ped_detalle.

DEFINE STREAM Seguimiento.

/*=================================================================================*/
/*                                    PROCESO                                      */
/*=================================================================================*/

{findempresa.i}

DO TRANSACTION:

   
    p-rc = 0.
   
    MESSAGE p-nro_pedido VIEW-AS ALERT-BOX.

    FIND Ped_header WHERE Ped_header.nro_pedido = p-nro_pedido EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE Ped_header
    THEN DO:
         p-rc = 1.
         RETURN.
    END.

    FIND Rem_header WHERE Rem_header.nro_remito = p-nro_remito EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE Rem_header
    THEN DO:
         p-rc = 2.
         RETURN.
    END.
    FIND Tipocomprobante OF Rem_header NO-LOCK.
    
    /* ---------------------------------------------------------------------------------------- */
    /* Recorre el detalle de los remitos. Para cada uno de los detalles, recorre los del pedido */
    /* que contengan el mismo artículo calzndo las cantidades según corresponda                 */
    /* ---------------------------------------------------------------------------------------- */

/*     OUTPUT STREAM Seguimiento TO VALUE("C:\temp\SEG" + Ped_header.tip_comprob + "-" +       */
/*                                        STRING(Ped_header.prf_comprob,"9999") + "-" +        */
/*                                        STRING(Ped_header.nro_comprob,"99999999") + ".txt" ) */
/*                                         PAGE-SIZE 0 APPEND.                                 */
/*                                                                                             */
    CASE Tipocomprobante.cdg_comprobante:

        WHEN "REMITCLI" /* Remitos. Calza solo contra pedidos pendientes */
        THEN DO:
            RUN calzar_remito.
        END.

        WHEN "AJUSTCLI" /* Es un ajuste. Solo difiere del remito en los estados de pedido que puede modificar */
        THEN DO:
            RUN calzar_ajuste.
        END.

        WHEN "NDEVOCLI" /* Es un ajuste. Difiere del remito en los estados de pedido y en que resta del cumplido */
        THEN DO:
            RUN calzar_devolucion.
        END.

    END CASE.


    /* ------------------------------------------------------------------------------- */
    /* Marcamos el remito como facturable y completamos fechas. De paso, si el pedido  */
    /* es sin cargo se marca el remito como NO FACTURABLE                              */
    /* ------------------------------------------------------------------------------- */

    Rem_header.conformado     = YES.
    Rem_header.fch_conformado = p-fecha.
    Rem_header.nro_pedido     = p-nro_pedido.
    Rem_header.proc_estad     = YES.
    Rem_header.sin_cargo      = Ped_header.sin_cargo.

    /* ------------------------------------------------------------------------------- */
    /* Si no existen renglones de pedido pendientes, entonces el estado de la cabecera */
    /* es cumplido. Si no. el estado de la cabecera sigue siendo pendiente             */
    /* ------------------------------------------------------------------------------- */

    FIND FIRST Ped_detalle OF Ped_header WHERE LOOKUP(Ped_detalle.cdg_estado,"AA","/") <> 0 NO-ERROR.
    IF NOT AVAILABLE Ped_detalle 
       THEN Ped_header.cdg_estado = "CC".
       ELSE Ped_header.cdg_estado = "AA".

/*     PUT STREAM Seguimiento UNFORMATTED                            */
/*         "==========================================" SKIP         */
/*         "Ped_header.cdg_estado:" Ped_header.cdg_estado       SKIP */
/*         "==========================================" SKIP.        */
/*                                                                   */
/*     OUTPUT STREAM Seguimiento CLOSE.                              */

END.

/*=================================================================================*/
/*                             PROCEDIMIENTOS                                      */
/*=================================================================================*/

PROCEDURE relacionar_remito_pedido:

    CREATE Remito-pedido.
    ASSIGN Remito-pedido.nro_remito     = Rem_detalle.nro_remito
           Remito-pedido.nro_linea-rem  = Rem_detalle.nro_linea
           Remito-pedido.nro_pedido     = Ped_detalle.nro_pedido
           Remito-pedido.nro_linea-ped  = Ped_detalle.nro_linea.
    
    ASSIGN Remito-pedido.cantidad       = ABS(cantidad_a_calzar) 
           Remito-pedido.granel         = ABS(granel_a_calzar). 
    
END PROCEDURE.

PROCEDURE calzar_remito:

/*     PUT STREAM Seguimiento UNFORMATTED                                                                      */
/*         "==========================================================================" SKIP                   */
/*         STRING(TODAY,"99/99/99") " " STRING(TIME,"HH:MM:SS") SKIP                                           */
/*         "--------------------------------------------------------------------------" SKIP                   */
/*         "Inicia Pedido :" Ped_header.tip_comprob " " Ped_header.prf_comprob " " Ped_header.nro_comprob SKIP */
/*         "       Remito :" Rem_header.tip_comprob " " Rem_header.prf_comprob " " Rem_header.nro_comprob SKIP */
/*         "==========================================================================" SKIP.                  */
/*                                                                                                             */
    FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK, Articulo OF Rem_detalle NO-LOCK:

/*         PUT STREAM Seguimiento UNFORMATTED                                                                                                        */
/*             "Linea Remito :" Rem_detalle.nro_linea " " Articulo.cdg_articulo " Cantidad:" Rem_detalle.cantidad " Granel:" Rem_detalle.granel SKIP */
/*             "--------------------------------------------------------------------------" SKIP.                                                    */
/*    
                                                                                                                                                       */
        IF ARTICULO.A_GRANEL  THEN
           ASSIGN saldo_cantidad = Rem_detalle.granel
                  saldo_granel   = Rem_detalle.cantidad.
        ELSE
           ASSIGN saldo_cantidad = Rem_detalle.cantidad
                  saldo_granel   = Rem_detalle.granel.

        FOR EACH Ped_detalle EXCLUSIVE-LOCK OF Ped_header
             WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo
               AND LOOKUP(Ped_detalle.cdg_estado,"AA","/") <> 0 /* Solo pedidos pendientes */
                   WHILE ( saldo_cantidad > 0 OR saldo_granel > 0 ):
    
               /* Calcula el saldo pendiente del renglon de pedido */
    
            ASSIGN 
                posible_calzar_cantidad = Ped_detalle.cantidad - Ped_detalle.cantidad_cum
                posible_calzar_granel   = Ped_detalle.granel - Ped_detalle.granel_cum.

/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Linea Pedido (A):" Ped_detalle.nro_linea " Cantidad:" Ped_detalle.cantidad "/" Ped_detalle.cantidad_cum */
/*                                                        " Granel:" Ped_detalle.granel   "/" Ped_detalle.granel_cum           */
/*                                                        " Est:" Ped_detalle.cdg_estado                                       */
/*                 SKIP.                                                                                                       */
    
               /* Determina la cantidad a calzar. Si hay mas renglones */
               /* del mismo articulo, es el minimo de lo que queda en  */
               /* cada uno: remito y pedido. Si no hay mas renglones   */
               /* calza la totalidad del saldo del remito contra el    */
               /* renglon del pedido                                   */
    
            IF CAN-FIND(FIRST B-Ped_detalle OF Ped_header
                              WHERE B-Ped_detalle.nro_articulo = Ped_detalle.nro_articulo
                                AND LOOKUP(B-Ped_detalle.cdg_estado,"AA","/") <> 0 /* Solo pedidos pendientes */
                                AND B-Ped_detalle.nro_linea <> Ped_detalle.nro_linea )                                
            THEN DO:
    
                /* Si hay mas cantidad en el remito que en el pedido, solo    */
                /* calzamos la cantidad del PEDIDO que es menor. Si el remito */
                /* no alcanza al pedido, solo calzamos la cantidad del REMITO */
    

                ASSIGN
                    cantidad_a_calzar = MINIMUM(saldo_cantidad, posible_calzar_cantidad)
                    granel_a_calzar   = MINIMUM(saldo_granel, posible_calzar_granel).
/*                                                                                                               */
/*                 PUT STREAM Seguimiento UNFORMATTED                                                            */
/*                     "       A Calzar: Cantidad:" cantidad_a_calzar " Granel:" granel_a_calzar " VARIOS" SKIP. */
/*                                                                                                               */
               
            END.
            ELSE DO:
    
                /* No hay otro renglón pendiente del mismo artículo. Calzamos */
                /* todo el saldo del remito                                   */
    
                ASSIGN
                    cantidad_a_calzar = saldo_cantidad
                    granel_a_calzar   = saldo_granel.

/*                 PUT STREAM Seguimiento UNFORMATTED                                                           */
/*                     "       A Calzar: Cantidad:" cantidad_a_calzar " Granel:" granel_a_calzar " UNICO" SKIP. */
/*                                                                                                              */
            END.
    
               /* Generamos la relacion del calce del remito con el pedido    */
    
            RUN relacionar_remito_pedido.
    
               /* Actualizamos el cumplido en el pedido con la cantidad calzada */
    
            ASSIGN
                Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum + cantidad_a_calzar
                Ped_detalle.granel_cum     = Ped_detalle.granel_cum + granel_a_calzar.
    
            /* Cambiamos el estado del pedido si este se halla cumplido         */
    
            IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND
               Ped_detalle.granel_cum >= Ped_detalle.granel
            THEN DO:
                 Ped_detalle.cdg_estado = "CC".
            END.
            ELSE DO:
                 Ped_detalle.cdg_estado = "AA".
            END.
    
            /* Descontamos la cantidad calzada del saldo del remito que va quedando */
    
            ASSIGN saldo_cantidad = saldo_cantidad - cantidad_a_calzar
                   saldo_granel   = saldo_granel   - granel_a_calzar.

/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Linea Pedido (D):" Ped_detalle.nro_linea " Cantidad:" Ped_detalle.cantidad "/" Ped_detalle.cantidad_cum */
/*                                                        " Granel:" Ped_detalle.granel   "/" Ped_detalle.granel_cum           */
/*                                                        " Est:" Ped_detalle.cdg_estado                                       */
/*                 SKIP.                                                                                                       */
/*                                                                                                                             */
/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Queda Calce: Cantidad:" saldo_cantidad " Granel:" saldo_granel SKIP                                     */
/*                 "------------------------------------------" SKIP .                                                         */

        END. /* De recorrer el detalle del pedido */

    END. /* De recorrer el detalle del remito */

END PROCEDURE.

PROCEDURE calzar_ajuste:

/*     FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK:                                                                                                 */
/*                                                                                                                                                        */
/*         ASSIGN saldo_cantidad = Rem_detalle.cantidad                                                                                                   */
/*                saldo_granel   = Rem_detalle.granel.                                                                                                    */
/*                                                                                                                                                        */
/*         FOR EACH Ped_detalle EXCLUSIVE-LOCK OF Ped_header                                                                                              */
/*              WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo                                                                                 */
/*                AND LOOKUP(Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Solo pedidos pendientes */                                                       */
/*                    WHILE ( saldo_cantidad > 0 OR saldo_granel > 0 ):                                                                                   */
/*                                                                                                                                                        */
/*                /* Calcula el saldo pendiente del renglon de pedido */                                                                                  */
/*                                                                                                                                                        */
/*             ASSIGN                                                                                                                                     */
/*                 posible_calzar_cantidad = Ped_detalle.cantidad - Ped_detalle.cantidad_cum                                                                   */
/*                 posible_calzar_granel   = Ped_detalle.granel - Ped_detalle.granel_cum.                                                                      */
/*                                                                                                                                                        */
/*                /* Determina la cantidad a calzar. Si hay mas renglones */                                                                              */
/*                /* del mismo articulo, es el minimo de lo que queda en  */                                                                              */
/*                /* cada uno: remito y pedido. Si no hay mas renglones   */                                                                              */
/*                /* calza la totalidad del saldo del remito contra el    */                                                                              */
/*                /* renglon del pedido                                   */                                                                              */
/*                                                                                                                                                        */
/*             IF CAN-FIND(FIRST B-Ped_detalle                                                                                                            */
/*                               WHERE B-Ped_detalle.nro_articulo = Ped_detalle.nro_articulo                                                              */
/*                                 AND B-Ped_detalle.nro_pedido   = Ped_detalle.nro_pedido                                                                */
/*                                 AND LOOKUP(Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Solo pedidos pendientes */                                      */
/*                                 AND B-Ped_detalle.nro_linea <> Ped_detalle.nro_linea )                                                                 */
/*             THEN DO:                                                                                                                                   */
/*                                                                                                                                                        */
/*                 MESSAGE " Varias lineas del mismo articulo " VIEW-AS ALERT-BOX.                                                                        */
/*                                                                                                                                                        */
/*                 /* Si hay mas cantidad en el remito que en el pedido, solo    */                                                                       */
/*                 /* calzamos la cantidad del PEDIDO que es menor. Si el remito */                                                                       */
/*                 /* no alcanza al pedido, solo calzamos la cantidad del REMITO */                                                                       */
/*                 IF posible_calzar_cantidad <> 0 OR posible_calzar_granel <> 0 THEN                                                                               */
/*                 ASSIGN                                                                                                                                 */
/*                     cantidad_a_calzar = MINIMUM(saldo_cantidad, posible_calzar_cantidad)                                                                    */
/*                     granel_a_calzar   = MINIMUM(saldo_granel, posible_calzar_granel).                                                                       */
/*                                                                                                                                                        */
/*                 ELSE ASSIGN cantidad_a_calzar = saldo_cantidad                                                                                         */
/*                             granel_a_calzar   = saldo_granel.                                                                                          */
/*             END.                                                                                                                                       */
/*                                                                                                                                                        */
/*               IF (ABS(cantidad_a_calzar) + ped_detalle.cantidad_cum) > ped_detalle.cantidad                                                            */
/*                  THEN DO:                                                                                                                              */
/*                  ASSIGN                                                                                                                                */
/*                      cantidad_a_calzar = ped_detalle.cantidad - ped_detalle.cantidad_cum                                                               */
/*                     granel_a_calzar   = ped_detalle.granel   - ped_detalle.granel_cum.                                                                 */
/*               END.                                                                                                                                     */
/*                                                                                                                                                        */
/*                                                                                                                                                        */
/*                                                                                                                                                        */
/*                                                                                                                                                        */
/*             ELSE DO:                                                                                                                                   */
/*                                                                                                                                                        */
/*                 /* No hay otro renglón pendiente del mismo artículo. Calzamos */                                                                       */
/*                 /* todo el saldo del remito                                   */                                                                       */
/*                                                                                                                                                        */
/*                 MESSAGE "Una linea del mismo articulo   " VIEW-AS ALERT-BOX.                                                                           */
/*                                                                                                                                                        */
/*                 ASSIGN                                                                                                                                 */
/*                     cantidad_a_calzar = saldo_cantidad                                                                                                 */
/*                     granel_a_calzar   = saldo_granel.                                                                                                  */
/*                                                                                                                                                        */
/*             END.                                                                                                                                       */
/*                                                                                                                                                        */
/*                /* Generamos la relacion del calce del remito con el pedido    */                                                                       */
/*                                                                                                                                                        */
/*             RUN relacionar_remito_pedido.                                                                                                              */
/*                                                                                                                                                        */
/*                /* Actualizamos el cumplido en el pedido con la cantidad calzada */                                                                     */
/*                                                                                                                                                        */
/*             ASSIGN                                                                                                                                     */
/*                 Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum + ABS(cantidad_a_calzar)                                                         */
/*                 Ped_detalle.granel_cum     = Ped_detalle.granel_cum + ABS(granel_a_calzar).                                                            */
/*                                                                                                                                                        */
/*             /* Cambiamos el estado del pedido si este se halla cumplido         */                                                                     */
/*                                                                                                                                                        */
/*             IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND                                                                                    */
/*                Ped_detalle.granel_cum >= Ped_detalle.granel                                                                                            */
/*             THEN DO:                                                                                                                                   */
/*                  Ped_detalle.cdg_estado = "CC".                                                                                                        */
/*             END.                                                                                                                                       */
/*             ELSE DO:                                                                                                                                   */
/*                  Ped_detalle.cdg_estado = "AA".                                                                                                        */
/*             END.                                                                                                                                       */
/*                                                                                                                                                        */
/*             /* Descontamos la cantidad calzada del saldo del remito que va quedando */                                                                 */
/*                                                                                                                                                        */
/*             ASSIGN saldo_cantidad = saldo_cantidad - ABS(cantidad_a_calzar)                                                                            */
/*                    saldo_granel   = saldo_granel   - ABS(granel_a_calzar).                                                                             */
/*                                                                                                                                                        */
/*             MESSAGE "saldo cantidad : " saldo_cantidad "saldo granel   : " saldo_granel "cantidad_a_calzar : " cantidad_a_calzar "granel_a_calzar   :" */
/*                     granel_a_calzar   VIEW-AS ALERT-BOX.                                                                                               */
/*                                                                                                                                                        */
/*         END. /* Del detalle de pedido */                                                                                                               */
/*                                                                                                                                                        */
/*     END. /* De recorrer el detalle del remito */                                                                                                       */
    
/*     PUT STREAM Seguimiento UNFORMATTED                                                                      */
/*         "==========================================================================" SKIP                   */
/*         STRING(TODAY,"99/99/99") " " STRING(TIME,"HH:MM:SS") SKIP                                           */
/*         "--------------------------------------------------------------------------" SKIP                   */
/*         "Inicia Pedido :" Ped_header.tip_comprob " " Ped_header.prf_comprob " " Ped_header.nro_comprob SKIP */
/*         "       Ajuste :" Rem_header.tip_comprob " " Rem_header.prf_comprob " " Rem_header.nro_comprob SKIP */
/*         "==========================================================================" SKIP.                  */

    FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK, Articulo OF Rem_detalle NO-LOCK:

/*         PUT STREAM Seguimiento UNFORMATTED                                                                                                        */
/*             "Linea Ajuste :" Rem_detalle.nro_linea " " Articulo.cdg_articulo " Cantidad:" Rem_detalle.cantidad " Granel:" Rem_detalle.granel SKIP */
/*             "--------------------------------------------------------------------------" SKIP.                                                    */

        IF ARTICULO.A_GRANEL  THEN
           ASSIGN saldo_cantidad = Rem_detalle.granel
                  saldo_granel   = Rem_detalle.cantidad.
        ELSE
           ASSIGN saldo_cantidad = Rem_detalle.cantidad
                  saldo_granel   = Rem_detalle.granel.

        FOR EACH Ped_detalle EXCLUSIVE-LOCK OF Ped_header
             WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo
               AND LOOKUP(Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Pedidos pendientes o cumplidos */
                   WHILE ( saldo_cantidad > 0 OR saldo_granel > 0 ):
    
               /* El maximo a calzar es la cantidad del ajuste y, por tanto, siempre ajusta el primer item */
    
            ASSIGN 
                posible_calzar_cantidad = saldo_cantidad
                posible_calzar_granel   = saldo_granel.  

/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Linea Pedido (A):" Ped_detalle.nro_linea " Cantidad:" Ped_detalle.cantidad "/" Ped_detalle.cantidad_cum */
/*                                                        " Granel:" Ped_detalle.granel   "/" Ped_detalle.granel_cum           */
/*                                                        " Est:" Ped_detalle.cdg_estado                                       */
/*                 SKIP.                                                                                                       */
/*                                                                                                                             */

            ASSIGN
                cantidad_a_calzar = saldo_cantidad
                granel_a_calzar   = saldo_granel.

               /* Generamos la relacion del calce del remito con el pedido    */
    
            RUN relacionar_remito_pedido.
    
               /* Actualizamos el cumplido en el pedido con la cantidad calzada */
    
            ASSIGN
                Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum + cantidad_a_calzar
                Ped_detalle.granel_cum     = Ped_detalle.granel_cum + granel_a_calzar.
    
            /* Cambiamos el estado del pedido si este se halla cumplido         */
    
            IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND
               Ped_detalle.granel_cum >= Ped_detalle.granel
            THEN DO:
                 Ped_detalle.cdg_estado = "CC".
            END.
            ELSE DO:
                 Ped_detalle.cdg_estado = "AA".
            END.
    
            /* Descontamos la cantidad calzada del saldo del remito que va quedando. */
            /* Los saldos quedan en CERO                                             */
    
            ASSIGN saldo_cantidad = saldo_cantidad - cantidad_a_calzar /* Saldo queda en CERO */
                   saldo_granel   = saldo_granel   - granel_a_calzar.  /* Saldo queda en CERO */

/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Linea Pedido (D):" Ped_detalle.nro_linea " Cantidad:" Ped_detalle.cantidad "/" Ped_detalle.cantidad_cum */
/*                                                        " Granel:" Ped_detalle.granel   "/" Ped_detalle.granel_cum           */
/*                                                        " Est:" Ped_detalle.cdg_estado                                       */
/*                 SKIP.                                                                                                       */
/*                                                                                                                             */
/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Queda Calce: Cantidad:" saldo_cantidad " Granel:" saldo_granel SKIP                                     */
/*                 "------------------------------------------" SKIP .                                                         */

        END. /* De recorrer el detalle del pedido */

    END. /* De recorrer el detalle del remito */

END PROCEDURE.

PROCEDURE calzar_devolucion:

/*     FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK:                                                                                                   */
/*                                                                                                                                                          */
/*         ASSIGN saldo_cantidad = Rem_detalle.cantidad                                                                                                     */
/*                saldo_granel   = Rem_detalle.granel.                                                                                                      */
/*                                                                                                                                                          */
/*         FOR EACH Ped_detalle EXCLUSIVE-LOCK OF Ped_header                                                                                                */
/*              WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo                                                                                   */
/*                AND LOOKUP(Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Solo pedidos pendientes */                                                         */
/*                    WHILE ( saldo_cantidad > 0 OR saldo_granel > 0)  :                                                                                    */
/*                                                                                                                                                          */
/*                /* Calcula el saldo pendiente del renglon de pedido */                                                                                    */
/*                                                                                                                                                          */
/*             ASSIGN                                                                                                                                       */
/*                 posible_calzar_cantidad = Ped_detalle.cantidad - Ped_detalle.cantidad_cum                                                                */
/*                 posible_calzar_granel   = Ped_detalle.granel - Ped_detalle.granel_cum.                                                                   */
/*                                                                                                                                                          */
/*                /* ---------------------------------------------------- */                                                                                */
/*                /* Determina la cantidad a calzar. Si hay mas renglones */                                                                                */
/*                /* del mismo articulo, es el minimo de lo que queda en  */                                                                                */
/*                /* cada uno: remito y pedido. Si no hay mas renglones   */                                                                                */
/*                /* calza la totalidad del saldo del remito contra el    */                                                                                */
/*                /* renglon del pedido                                   */                                                                                */
/*                /* ---------------------------------------------------- */                                                                                */
/*                                                                                                                                                          */
/*             IF CAN-FIND(FIRST B-Ped_detalle                                                                                                              */
/*                               WHERE B-Ped_detalle.nro_articulo = Ped_detalle.nro_articulo                                                                */
/*                                 AND B-Ped_detalle.nro_pedido   = Ped_detalle.nro_pedido                                                                  */
/*                                 AND LOOKUP(Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Solo pedidos pendientes */                                        */
/*                                 AND B-Ped_detalle.nro_linea <> Ped_detalle.nro_linea)                                                                    */
/*             THEN DO:                                                                                                                                     */
/*                                                                                                                                                          */
/*                 /* ---------------------------------------------------------- */                                                                         */
/*                 /* Si hay mas cantidad en el remito que en el pedido, solo    */                                                                         */
/*                 /* calzamos la cantidad del PEDIDO que es menor. Si el remito */                                                                         */
/*                 /* no alcanza al pedido, solo calzamos la cantidad del REMITO */                                                                         */
/*                 /* ---------------------------------------------------------- */                                                                         */
/*                 MESSAGE "Varias lineas del mismo articulo   " VIEW-AS ALERT-BOX.                                                                         */
/*                                                                                                                                                          */
/*                 IF posible_calzar_cantidad <> 0 OR posible_calzar_granel <> 0 THEN DO:                                                                   */
/*                    ASSIGN                                                                                                                                */
/*                       cantidad_a_calzar = MINIMUM(saldo_cantidad, posible_calzar_cantidad)                                                               */
/*                       granel_a_calzar   = MINIMUM(saldo_granel, posible_calzar_granel).                                                                  */
/*                                                                                                                                                          */
/*                    IF ped_detalle.cantidad_cum <  ABS(cantidad_a_calzar) THEN                                                                            */
/*                       ASSIGN cantidad_a_calzar = ped_detalle.cantidad_cum                                                                                */
/*                              granel_a_calzar   = ped_detalle.granel_cum.                                                                                 */
/*                 END.                                                                                                                                     */
/*                 ELSE                                                                                                                                     */
/*                  DO:                                                                                                                                     */
/*                    IF ped_detalle.cantidad_cum >= saldo_cantidad THEN                                                                                    */
/*                        ASSIGN cantidad_a_calzar = saldo_cantidad                                                                                         */
/*                               granel_a_calzar   = saldo_granel.                                                                                          */
/*                     ELSE                                                                                                                                 */
/*                        ASSIGN cantidad_a_calzar   =  ped_detalle.cantidad_cum                                                                            */
/*                               granel_a_calzar     =  ped_detalle.granel_cum.                                                                             */
/*                   END.                                                                                                                                   */
/*                 END.                                                                                                                                     */
/*             ELSE DO:                                                                                                                                     */
/*                                                                                                                                                          */
/*                 /* ---------------------------------------------------------- */                                                                         */
/*                 /* No hay otro renglón pendiente del mismo artículo. Calzamos */                                                                         */
/*                 /* todo el saldo del remito                                   */                                                                         */
/*                 /* ---------------------------------------------------------- */                                                                         */
/*                 MESSAGE "Una linea del mismo articulo   " VIEW-AS ALERT-BOX.                                                                             */
/*                                                                                                                                                          */
/*                 ASSIGN                                                                                                                                   */
/*                     cantidad_a_calzar = saldo_cantidad                                                                                                   */
/*                     granel_a_calzar   = saldo_granel.                                                                                                    */
/*                                                                                                                                                          */
/*             END.                                                                                                                                         */
/*                                                                                                                                                          */
/*                /* ----------------------------------------------------------- */                                                                         */
/*                /* Generamos la relacion del calce del remito con el pedido    */                                                                         */
/*                /* ----------------------------------------------------------- */                                                                         */
/*                                                                                                                                                          */
/*             RUN relacionar_remito_pedido.                                                                                                                */
/*                                                                                                                                                          */
/*                /* ------------------------------------------------------------- */                                                                       */
/*                /* Actualizamos el cumplido en el pedido con la cantidad calzada */                                                                       */
/*                /* ------------------------------------------------------------- */                                                                       */
/*                                                                                                                                                          */
/*             ASSIGN                                                                                                                                       */
/*                 Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum - ABS(cantidad_a_calzar)                                                           */
/*                 Ped_detalle.granel_cum     = Ped_detalle.granel_cum - ABS(granel_a_calzar).                                                              */
/*                                                                                                                                                          */
/*               MESSAGE "saldo cantidad : " saldo_cantidad "saldo granel   : " saldo_granel "cantidad_a_calzar : " cantidad_a_calzar "granel_a_calzar   :" */
/*                  granel_a_calzar   VIEW-AS ALERT-BOX.                                                                                                    */
/*                                                                                                                                                          */
/*             /* ---------------------------------------------------------------- */                                                                       */
/*             /* Cambiamos el estado del pedido si este se halla cumplido         */                                                                       */
/*             /* ---------------------------------------------------------------- */                                                                       */
/*                                                                                                                                                          */
/*             IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND                                                                                      */
/*                Ped_detalle.granel_cum >= Ped_detalle.granel                                                                                              */
/*             THEN DO:                                                                                                                                     */
/*                  Ped_detalle.cdg_estado = "CC".                                                                                                          */
/*             END.                                                                                                                                         */
/*             ELSE DO:                                                                                                                                     */
/*                  Ped_detalle.cdg_estado = "AA".                                                                                                          */
/*             END.                                                                                                                                         */
/*                                                                                                                                                          */
/*             /* -------------------------------------------------------------------- */                                                                   */
/*             /* Descontamos la cantidad calzada del saldo del remito que va quedando */                                                                   */
/*             /* -------------------------------------------------------------------- */                                                                   */
/*                                                                                                                                                          */
/*             ASSIGN saldo_cantidad = saldo_cantidad - ABS(cantidad_a_calzar)                                                                              */
/*                    saldo_granel   = saldo_granel   - ABS(granel_a_calzar).                                                                               */
/*                                                                                                                                                          */
/*         END. /* De recorrer el detalle de la devolucion */                                                                                               */
/*                                                                                                                                                          */
/*     END. /* De recorrer el detalle del remito */                                                                                                         */

/*     PUT STREAM Seguimiento UNFORMATTED                                                                      */
/*         "==========================================================================" SKIP                   */
/*         STRING(TODAY,"99/99/99") " " STRING(TIME,"HH:MM:SS") SKIP                                           */
/*         "--------------------------------------------------------------------------" SKIP                   */
/*         "Inicia Pedido :" Ped_header.tip_comprob " " Ped_header.prf_comprob " " Ped_header.nro_comprob SKIP */
/*         "       Devoluc:" Rem_header.tip_comprob " " Rem_header.prf_comprob " " Rem_header.nro_comprob SKIP */
/*         "==========================================================================" SKIP.                  */

    FOR EACH Rem_detalle OF Rem_header EXCLUSIVE-LOCK, Articulo OF Rem_detalle NO-LOCK:

/*         PUT STREAM Seguimiento UNFORMATTED                                                                                                        */
/*             "Linea Devoluc:" Rem_detalle.nro_linea " " Articulo.cdg_articulo " Cantidad:" Rem_detalle.cantidad " Granel:" Rem_detalle.granel SKIP */
/*             "--------------------------------------------------------------------------" SKIP.                                                    */
        
        IF ARTICULO.A_GRANEL  THEN
           ASSIGN saldo_cantidad = Rem_detalle.granel
                  saldo_granel   = Rem_detalle.cantidad.
        ELSE
          ASSIGN saldo_cantidad = Rem_detalle.cantidad
                 saldo_granel   = Rem_detalle.granel.

        FOR EACH Ped_detalle EXCLUSIVE-LOCK OF Ped_header
             WHERE Ped_detalle.nro_articulo = Rem_detalle.nro_articulo
               AND LOOKUP(Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Pedidos pendientes o cumplidos */
               AND ( Ped_detalle.cantidad_cum <> 0 OR Ped_detalle.granel_cum <> 0 ) /* Hay cumplido */
                   WHILE ( saldo_cantidad > 0 OR saldo_granel > 0 ):
    
               /* No puede calzarse mas que el la cantidad cumplida del item de pedido */
    
            ASSIGN 
                posible_calzar_cantidad = Ped_detalle.cantidad_cum
                posible_calzar_granel   = Ped_detalle.granel_cum.
/*                                                                                                                             */
/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Linea Pedido (A):" Ped_detalle.nro_linea " Cantidad:" Ped_detalle.cantidad "/" Ped_detalle.cantidad_cum */
/*                                                        " Granel:" Ped_detalle.granel   "/" Ped_detalle.granel_cum           */
/*                                                        " Est:" Ped_detalle.cdg_estado                                       */
/*                 SKIP.                                                                                                       */
    
               /* Determina la cantidad a calzar. Si hay mas renglones */
               /* del mismo articulo, es el minimo de lo que queda en  */
               /* cada uno: remito y pedido. Si no hay mas renglones   */
               /* calza la totalidad del saldo del remito contra el    */
               /* renglon del pedido                                   */
    
            IF CAN-FIND(FIRST B-Ped_detalle OF Ped_header
                              WHERE B-Ped_detalle.nro_articulo = Ped_detalle.nro_articulo
                                AND LOOKUP(B-Ped_detalle.cdg_estado,"AA/CC","/") <> 0 /* Pedidos pendientes y Cumplidos */
                                AND B-Ped_detalle.nro_linea <> Ped_detalle.nro_linea )                                
            THEN DO:
    
                /* Si hay mas cantidad en la devolucion que en el pedido, solo*/
                /* calzamos la cantidad del PEDIDO que es menor. Si la devoluc*/
                /* no alcanza al pedido, solo calzamos la cantidad de la devol*/
    
                ASSIGN
                    cantidad_a_calzar = MINIMUM(saldo_cantidad, posible_calzar_cantidad)
                    granel_a_calzar   = MINIMUM(saldo_granel, posible_calzar_granel).
    
/*                 PUT STREAM Seguimiento UNFORMATTED                                                            */
/*                     "       A Calzar: Cantidad:" cantidad_a_calzar " Granel:" granel_a_calzar " VARIOS" SKIP. */
/*                                                                                                               */
            END.
            ELSE DO:
    
                /* No hay otro renglón pendiente del mismo artículo. Calzamos */
                /* todo el saldo del remito                                   */
    
                ASSIGN
                    cantidad_a_calzar = saldo_cantidad
                    granel_a_calzar   = saldo_granel.

/*                 PUT STREAM Seguimiento UNFORMATTED                                                           */
/*                     "       A Calzar: Cantidad:" cantidad_a_calzar " Granel:" granel_a_calzar " UNICO" SKIP. */
/*                                                                                                              */
            END.
    
               /* Generamos la relacion del calce del remito con el pedido    */
    
            RUN relacionar_remito_pedido.
    
               /* Actualizamos el cumplido en el pedido con la cantidad calzada */
    
            ASSIGN
                Ped_detalle.cantidad_cum   = Ped_detalle.cantidad_cum - cantidad_a_calzar
                Ped_detalle.granel_cum     = Ped_detalle.granel_cum - granel_a_calzar.
    
            /* Cambiamos el estado del pedido si este se halla cumplido         */
    
            IF Ped_detalle.cantidad_cum >= Ped_detalle.cantidad AND
               Ped_detalle.granel_cum >= Ped_detalle.granel
            THEN DO:
                 Ped_detalle.cdg_estado = "CC".
            END.
            ELSE DO:
                 Ped_detalle.cdg_estado = "AA".
            END.
    
            /* Descontamos la cantidad calzada del saldo del remito que va quedando */
    
            ASSIGN saldo_cantidad = saldo_cantidad - cantidad_a_calzar
                   saldo_granel   = saldo_granel   - granel_a_calzar.

/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Linea Pedido (D):" Ped_detalle.nro_linea " Cantidad:" Ped_detalle.cantidad "/" Ped_detalle.cantidad_cum */
/*                                                        " Granel:" Ped_detalle.granel   "/" Ped_detalle.granel_cum           */
/*                                                        " Est:" Ped_detalle.cdg_estado                                       */
/*                 SKIP.                                                                                                       */
/*                                                                                                                             */
/*             PUT STREAM Seguimiento UNFORMATTED                                                                              */
/*                 "   Queda Calce: Cantidad:" saldo_cantidad " Granel:" saldo_granel SKIP                                     */
/*                 "------------------------------------------" SKIP .                                                         */

        END. /* De recorrer el detalle del pedido */

    END. /* De recorrer el detalle del remito */

END PROCEDURE.
