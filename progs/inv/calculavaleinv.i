DEFINE VARIABLE v-cdg_existencia AS INTEGER INITIAL 1.
DEFINE VARIABLE v-cdg_consumo    AS INTEGER INITIAL 2.

CREATE {1}Sub_header_inv.
ASSIGN
       {1}Sub_header_inv.cdg_empresa   = {1}Valeinv_hd.cdg_empresa
       {1}Sub_header_inv.tip_comprob   = {1}Valeinv_hd.tip_comprob
       {1}Sub_header_inv.prf_comprob   = {1}Valeinv_hd.prf_comprob
       {1}Sub_header_inv.nro_comprob   = {1}Valeinv_hd.nro_comprob
       {1}Sub_header_inv.fecha         = {1}Valeinv_hd.fecha
       {1}Sub_header_inv.nro_entidad   = {1}Valeinv_hd.nro_entidad
       {1}Sub_header_inv.nro_cuenta    = Cuenta.nro_cuenta.
    
          /*--------------------------------------------------------------*/
          /* Realiza las imputaciones de consumo. Es un vale de ingreso   */
          /* se debitan las existencias y se acreditan los consumos       */
          /*--------------------------------------------------------------*/

FOR EACH Valeinv_dt EXCLUSIVE-LOCK OF {1}Valeinv_hd, Deposito OF Valeinv_dt,
           Articulo OF Valeinv_dt, Familia_articulo OF Articulo:

    FIND {2} {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Valeinv_hd.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Valeinv_hd.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Valeinv_hd.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Valeinv_hd.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
           AND {1}Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
           AND {1}Sub_detalle_inv.nro_obra       = Valeinv_dt.nro_obra
           AND {1}Sub_detalle_inv.tipo           = v-cdg_existencia
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.cdg_empresa    = {1}Valeinv_hd.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Valeinv_hd.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Valeinv_hd.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Valeinv_hd.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
              {1}Sub_detalle_inv.nro_entidad    = Deposito.nro_entidad
              {1}Sub_detalle_inv.nro_obra       = Valeinv_dt.nro_obra
              {1}Sub_detalle_inv.tipo           = v-cdg_existencia.
    END.

    Valeinv_dt.subtotal = 
        ( IF Valeinv_dt.a_granel 
             THEN ROUND( Valeinv_dt.costo * Valeinv_dt.granel   , 2 )
             ELSE ROUND( Valeinv_dt.costo * Valeinv_dt.cantidad , 2 ) ).

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + Valeinv_dt.subtotal.
    {1}Valeinv_hd.imp_total  = {1}Valeinv_hd.imp_total + Valeinv_dt.subtotal.

END.             

{1}Sub_header_inv.imp_total = {1}Valeinv_hd.imp_total.

          /*--------------------------------------------------------------*/
          /* Volvemos a recorrer el detalle de manera de calcular la otra */
          /* porcion del asiento                                          */
          /*--------------------------------------------------------------*/

FOR EACH Valeinv_dt EXCLUSIVE-LOCK OF {1}Valeinv_hd, Deposito OF Valeinv_dt,
           Articulo OF Valeinv_dt, Familia_articulo OF Articulo:

    FIND {2} {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Valeinv_hd.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Valeinv_hd.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Valeinv_hd.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Valeinv_hd.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_consumo 
           AND {1}Sub_detalle_inv.nro_entidad    = {1}Valeinv_hd.nro_entidad
           AND {1}Sub_detalle_inv.nro_obra       = Valeinv_dt.nro_obra
           AND {1}Sub_detalle_inv.tipo           = v-cdg_consumo
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.cdg_empresa    = {1}Valeinv_hd.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Valeinv_hd.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Valeinv_hd.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Valeinv_hd.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_consumo
              {1}Sub_detalle_inv.nro_entidad    = {1}Valeinv_hd.nro_entidad
              {1}Sub_detalle_inv.nro_obra       = Valeinv_dt.nro_obra
              {1}Sub_detalle_inv.tipo           = v-cdg_consumo.
    END.

    Valeinv_dt.subtotal = 
        ( IF Valeinv_dt.a_granel 
             THEN ROUND( Valeinv_dt.costo * Valeinv_dt.granel   , 2 )
             ELSE ROUND( Valeinv_dt.costo * Valeinv_dt.cantidad , 2 ) ).

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + Valeinv_dt.subtotal.

END.             
