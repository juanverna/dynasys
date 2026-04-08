
FIND Familia_cliente OF Cliente NO-LOCK NO-ERROR.
CREATE {1}Sub_header_inv.
ASSIGN
       {1}Sub_header_inv.cdg_empresa   = {1}Rem_header.cdg_empresa
       {1}Sub_header_inv.tip_comprob   = {1}Rem_header.tip_comprob
       {1}Sub_header_inv.prf_comprob   = {1}Rem_header.prf_comprob
       {1}Sub_header_inv.nro_comprob   = {1}Rem_header.nro_comprob
       {1}Sub_header_inv.fecha         = {1}Rem_header.fecha
       {1}Sub_header_inv.nro_entidad   = {1}Rem_header.nro_entidad
       {1}Sub_header_inv.nro_cuenta    = Familia_cliente.nro_cuenta.

          /*--------------------------------------------------------------*/
          /* Realiza las imputaciones del remito. Es una salida de mercs. */
          /* se debitan los costos de ventas y acreditan las existencias. */
          /*--------------------------------------------------------------*/

{1}Rem_header.imp_total = 0.
FOR EACH {1}Rem_detalle EXCLUSIVE-LOCK OF {1}Rem_header,
           Articulo OF {1}Rem_detalle, Familia_articulo OF Articulo:


    FIND {2} {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
           AND {1}Sub_detalle_inv.nro_entidad    = {1}Rem_header.nro_entidad
           AND {1}Sub_detalle_inv.nro_obra       = {1}Rem_detalle.nro_obra 
           AND {1}Sub_detalle_inv.tipo           = 1
               EXCLUSIVE-LOCK NO-ERROR.

    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
              {1}Sub_detalle_inv.nro_entidad    = {1}Rem_header.nro_entidad
              /*
              {1}Sub_detalle_inv.nro_moneda     = {1}Rem_header.nro_moneda 
              */
              {1}Sub_detalle_inv.nro_obra       = {1}Rem_detalle.nro_obra 
              {1}Sub_detalle_inv.tipo           = 1.
    END.

    {1}Rem_detalle.subtotal_neto = 
        ( IF {1}Rem_detalle.a_granel 
             THEN ROUND( {1}Rem_detalle.costo * {1}Rem_detalle.granel   , 2 )
             ELSE ROUND( {1}Rem_detalle.costo * {1}Rem_detalle.cantidad , 2 ) ).

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + {1}Rem_detalle.subtotal_neto.
    {1}Rem_header.imp_total  = {1}Rem_header.imp_total + {1}Rem_detalle.subtotal_neto.

END.             

{1}Sub_header_inv.imp_total = {1}Rem_header.imp_total.

          /*--------------------------------------------------------------*/
          /* Volvemos a recorrer el detalle de manera de calcular la otra */
          /* porcion del asiento                                          */
          /*--------------------------------------------------------------*/

FOR EACH {1}Rem_detalle EXCLUSIVE-LOCK OF {1}Rem_header,
           Articulo OF {1}Rem_detalle, Familia_articulo OF Articulo:

    FIND {2} {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
           AND {1}Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
           /*
           AND {1}Sub_detalle_inv.nro_obra       = {1}Rem_detalle.nro_obra 
           */
           AND {1}Sub_detalle_inv.tipo           = 2
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
              {1}Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
              /*
              {1}Sub_detalle_inv.nro_moneda     = {1}Rem_header.nro_moneda 
              {1}Sub_detalle_inv.nro_obra       = {1}Rem_detalle.nro_obra 
              */
              {1}Sub_detalle_inv.tipo           = 2.
    END.

    {1}Rem_detalle.subtotal_neto = 
        ( IF {1}Rem_detalle.a_granel 
             THEN ROUND( {1}Rem_detalle.costo * {1}Rem_detalle.granel   , 2 )
             ELSE ROUND( {1}Rem_detalle.costo * {1}Rem_detalle.cantidad , 2 ) ).

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + {1}Rem_detalle.subtotal_neto.

END.             
