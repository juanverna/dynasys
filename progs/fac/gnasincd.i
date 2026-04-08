
    /*---------------------------------------------------------------------------------------*/
    /* GENERACION DEL ASIENTO DE INVENTARIO DE UNA N/CREDITO DE MOSTRADOR (SIN N/DEVOLUCION) */
    /*---------------------------------------------------------------------------------------*/

          /*----------------------------------------------------------------*/
          /* Realiza las imputaciones de la N/Credito. Es un ingreso de mer-*/
          /* caderia y entonces se debitan los costos de ventas y se acre-  */
          /* ditan las existencias.                                         */
          /*----------------------------------------------------------------*/

FOR EACH B-Fac_detalle EXCLUSIVE-LOCK OF {1}Fac_header,
           Articulo OF B-Fac_detalle, Familia_articulo OF Articulo:

    IF NOT AVAILABLE {1}Sub_header_inv
    THEN DO:
            CREATE {1}Sub_header_inv.
            ASSIGN
                   {1}Sub_header_inv.cdg_empresa   = {1}Fac_header.cdg_empresa
                   {1}Sub_header_inv.tip_comprob   = {1}Fac_header.tip_comprob
                   {1}Sub_header_inv.prf_comprob   = {1}Fac_header.prf_comprob
                   {1}Sub_header_inv.nro_comprob   = {1}Fac_header.nro_comprob
                   {1}Sub_header_inv.fecha         = {1}Fac_header.fecha
                   {1}Sub_header_inv.nro_entidad   = {1}Fac_header.nro_entidad
                   {1}Sub_header_inv.nro_cuenta    = Familia_cliente.nro_cuenta.
    END.

    IF Articulo.stock_sino
    THEN DO:
            FIND {2} {1}Sub_detalle_inv 
                 WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Fac_header.cdg_empresa
                   AND {1}Sub_detalle_inv.tip_comprob    = {1}Fac_header.tip_comprob
                   AND {1}Sub_detalle_inv.prf_comprob    = {1}Fac_header.prf_comprob
                   AND {1}Sub_detalle_inv.nro_comprob    = {1}Fac_header.nro_comprob
                   AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
                   AND {1}Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
        /*         AND {1}Sub_detalle_inv.nro_obra       = B-Fac_detalle.nro_obra */
                   AND {1}Sub_detalle_inv.tipo           = 1
                       EXCLUSIVE-LOCK NO-ERROR.
        
            IF NOT AVAILABLE {1}Sub_detalle_inv 
            THEN DO:
               CREATE {1}Sub_detalle_inv.
               ASSIGN
                      {1}Sub_detalle_inv.cdg_empresa    = {1}Fac_header.cdg_empresa
                      {1}Sub_detalle_inv.tip_comprob    = {1}Fac_header.tip_comprob
                      {1}Sub_detalle_inv.prf_comprob    = {1}Fac_header.prf_comprob
                      {1}Sub_detalle_inv.nro_comprob    = {1}Fac_header.nro_comprob
                      {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
                      {1}Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
        /*            {1}Sub_detalle_inv.nro_obra       = B-Fac_detalle.nro_obra */
                      {1}Sub_detalle_inv.tipo           = 1.
            END.
        
            aux_importe = 
                ( IF B-Fac_detalle.a_granel 
                     THEN ROUND( Articulo.costo * B-Fac_detalle.granel   , 2 )
                     ELSE ROUND( Articulo.costo * B-Fac_detalle.cantidad , 2 ) ).
        
            {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + aux_importe.
    END.
END.             

IF AVAILABLE {1}Sub_header_inv THEN {1}Sub_header_inv.imp_total = {1}Fac_header.imp_total.

          /*--------------------------------------------------------------*/
          /* Volvemos a recorrer el detalle de manera de calcular la otra */
          /* porcion del asiento                                          */
          /*--------------------------------------------------------------*/

FOR EACH B-Fac_detalle EXCLUSIVE-LOCK OF {1}Fac_header,
           Articulo OF B-Fac_detalle, Familia_articulo OF Articulo:

    IF Articulo.stock_sino
    THEN DO:
            FIND {2} {1}Sub_detalle_inv 
                 WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Fac_header.cdg_empresa
                   AND {1}Sub_detalle_inv.tip_comprob    = {1}Fac_header.tip_comprob
                   AND {1}Sub_detalle_inv.prf_comprob    = {1}Fac_header.prf_comprob
                   AND {1}Sub_detalle_inv.nro_comprob    = {1}Fac_header.nro_comprob
                   AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
                   AND {1}Sub_detalle_inv.nro_entidad    = {1}Fac_header.nro_entidad
                   AND {1}Sub_detalle_inv.nro_obra       = {1}Fac_header.nro_obra 
                   AND {1}Sub_detalle_inv.tipo           = 2
                       EXCLUSIVE-LOCK NO-ERROR.
                 
            IF NOT AVAILABLE {1}Sub_detalle_inv 
            THEN DO:
               CREATE {1}Sub_detalle_inv.
               ASSIGN
                      {1}Sub_detalle_inv.cdg_empresa    = {1}Fac_header.cdg_empresa
                      {1}Sub_detalle_inv.tip_comprob    = {1}Fac_header.tip_comprob
                      {1}Sub_detalle_inv.prf_comprob    = {1}Fac_header.prf_comprob
                      {1}Sub_detalle_inv.nro_comprob    = {1}Fac_header.nro_comprob
                      {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
                      {1}Sub_detalle_inv.nro_entidad    = {1}Fac_header.nro_entidad
                      {1}Sub_detalle_inv.nro_obra       = {1}Fac_header.nro_obra 
                      {1}Sub_detalle_inv.tipo           = 2.
            END.
        
            aux_importe = 
                ( IF B-Fac_detalle.a_granel 
                     THEN ROUND( Articulo.costo * B-Fac_detalle.granel   , 2 )
                     ELSE ROUND( Articulo.costo * B-Fac_detalle.cantidad , 2 ) ).
        
            {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + aux_importe.
    END.
END.             

