
      /* Creacion del encabezado de subdiario */

CREATE {1}Sub_header_inv.
ASSIGN
       {1}Sub_header_inv.nro_proveedor = {1}Rem_header_prv.nro_proveedor
       {1}Sub_header_inv.cdg_empresa   = {1}Rem_header_prv.cdg_empresa
       {1}Sub_header_inv.tip_comprob   = {1}Rem_header_prv.tip_comprob
       {1}Sub_header_inv.prf_comprob   = {1}Rem_header_prv.prf_comprob
       {1}Sub_header_inv.nro_comprob   = {1}Rem_header_prv.nro_comprob
       {1}Sub_header_inv.fecha         = {1}Rem_header_prv.fecha.
    
{1}Rem_header_prv.imp_neto = 0.
FOR EACH {1}Rem_detalle_prv OF {1}Rem_header_prv, Articulo OF {1}Rem_detalle_prv,
         Familia_articulo OF Articulo, Deposito OF {1}Rem_header_prv:

    FIND {1}Sub_detalle_inv 
         WHERE {1}Sub_detalle_inv.nro_proveedor  = {1}Rem_header_prv.nro_proveedor
           AND {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header_prv.cdg_empresa
           AND {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header_prv.tip_comprob
           AND {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header_prv.prf_comprob
           AND {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header_prv.nro_comprob
           AND {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
           AND {1}Sub_detalle_inv.nro_entidad    = {1}Rem_detalle_prv.nro_entidad
           AND {1}Sub_detalle_inv.nro_obra       = {1}Rem_detalle_prv.nro_obra
           EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_inv 
    THEN DO:
       CREATE {1}Sub_detalle_inv.
       ASSIGN
              {1}Sub_detalle_inv.nro_proveedor  = {1}Rem_header_prv.nro_proveedor
              {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header_prv.cdg_empresa
              {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header_prv.tip_comprob
              {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header_prv.prf_comprob
              {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header_prv.nro_comprob
              {1}Sub_detalle_inv.nro_cuenta     = Familia_articulo.nro_cuenta_existencia
              {1}Sub_detalle_inv.nro_entidad    = {1}Rem_detalle_prv.nro_entidad
              {1}Sub_detalle_inv.nro_obra       = {1}Rem_detalle_prv.nro_obra
              {1}Sub_detalle_inv.tipo           = 1.
    END.

    {1}Sub_detalle_inv.valor = {1}Sub_detalle_inv.valor +
        ( IF {1}Rem_detalle_prv.a_granel 
             THEN ROUND( {1}Rem_detalle_prv.precio * {1}Rem_detalle_prv.granel   , 2 )
             ELSE ROUND( {1}Rem_detalle_prv.precio * {1}Rem_detalle_prv.cantidad , 2 ) ).
    
    {1}Rem_header_prv.imp_neto = {1}Rem_header_prv.imp_neto +
        ( IF {1}Rem_detalle_prv.a_granel 
             THEN ROUND( {1}Rem_detalle_prv.precio * {1}Rem_detalle_prv.granel   , 2 )
             ELSE ROUND( {1}Rem_detalle_prv.precio * {1}Rem_detalle_prv.cantidad , 2 ) ).

             
END.             

{1}Rem_header_prv.imp_total = {1}Rem_header_prv.imp_neto.

     /* Crea el ultimo renglon de subdiario con un credito a la cuenta del encabezado */

CREATE {1}Sub_detalle_inv.
ASSIGN
       {1}Sub_detalle_inv.nro_proveedor  = {1}Rem_header_prv.nro_proveedor
       {1}Sub_detalle_inv.cdg_empresa    = {1}Rem_header_prv.cdg_empresa
       {1}Sub_detalle_inv.tip_comprob    = {1}Rem_header_prv.tip_comprob
       {1}Sub_detalle_inv.prf_comprob    = {1}Rem_header_prv.prf_comprob
       {1}Sub_detalle_inv.nro_comprob    = {1}Rem_header_prv.nro_comprob
       {1}Sub_detalle_inv.nro_cuenta     = Imputacion.nro_cuenta
       {1}Sub_detalle_inv.nro_entidad    = entidad_logon
       {1}Sub_detalle_inv.nro_obra       = 0
       {1}Sub_detalle_inv.tipo           = 2
       {1}Sub_detalle_inv.valor          = {1}Rem_header_prv.imp_neto. /* 2 es un credito */
