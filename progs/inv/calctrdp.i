
CREATE {1}Sub_header_inv.
ASSIGN
       {1}Sub_header_inv.cdg_empresa   = {1}Transdep_hd.cdg_empresa
       {1}Sub_header_inv.tip_comprob   = {1}Transdep_hd.tip_comprob
       {1}Sub_header_inv.prf_comprob   = {1}Transdep_hd.prf_comprob
       {1}Sub_header_inv.nro_comprob   = {1}Transdep_hd.nro_comprob
       {1}Sub_header_inv.fecha         = {1}Transdep_hd.fecha
       {1}Sub_header_inv.nro_entidad   = {1}Transdep_hd.nro_entidad.
/*        {1}Sub_header_inv.nro_cuenta    = Cuenta.nro_cuenta. */
    
FOR EACH B-Transdep_dt EXCLUSIVE-LOCK OF {1}Transdep_hd, 
           Articulo OF B-Transdep_dt, Familia_articulo OF Articulo, Deposito OF B-Transdep_dt:

    FIND {2} {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Transdep_hd.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Transdep_hd.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Transdep_hd.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Transdep_hd.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
           AND {1}Sub_detalle_inv.nro_entidad    = {1}Transdep_hd.nro_entidad
           AND {1}Sub_detalle_inv.nro_obra       = B-Transdep_dt.nro_obra
           AND {1}Sub_detalle_inv.tipo           = 1
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.cdg_empresa    = {1}Transdep_hd.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Transdep_hd.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Transdep_hd.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Transdep_hd.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
              {1}Sub_detalle_inv.nro_entidad    = {1}Transdep_hd.nro_entidad
              {1}Sub_detalle_inv.nro_obra       = B-Transdep_dt.nro_obra
              {1}Sub_detalle_inv.tipo           = 1.
    END.

    B-Transdep_dt.subtotal = 
        ( IF B-Transdep_dt.a_granel 
             THEN ROUND( B-Transdep_dt.costo * B-Transdep_dt.granel   , 2 )
             ELSE ROUND( B-Transdep_dt.costo * B-Transdep_dt.cantidad , 2 ) ).

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + B-Transdep_dt.subtotal.
    {1}Transdep_hd.imp_total  = {1}Transdep_hd.imp_total + B-Transdep_dt.subtotal.

    FIND {2} {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.cdg_empresa    = {1}Transdep_hd.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Transdep_hd.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Transdep_hd.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Transdep_hd.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
           AND {1}Sub_detalle_inv.nro_entidad    = B-Transdep_dt.nro_entidad
           AND {1}Sub_detalle_inv.nro_obra       = B-Transdep_dt.nro_obra
           AND {1}Sub_detalle_inv.tipo           = 2
               EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.cdg_empresa    = {1}Transdep_hd.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Transdep_hd.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Transdep_hd.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Transdep_hd.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_costo
              {1}Sub_detalle_inv.nro_entidad    = B-Transdep_dt.nro_entidad
              {1}Sub_detalle_inv.nro_obra       = B-Transdep_dt.nro_obra
              {1}Sub_detalle_inv.tipo           = 2.
    END.

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor + B-Transdep_dt.subtotal.

END.             

{1}Sub_header_inv.imp_total = {1}Transdep_hd.imp_total.
