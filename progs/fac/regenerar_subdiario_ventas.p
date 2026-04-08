/*===============================================================================================*/
/*                 REALIZA EL CALCULO DE UN COMPROBANTE DE CLIENTE                               */
/*===============================================================================================*/

/*===============================================================================================*/
/*                               PARAMETROS                                                      */      
/*===============================================================================================*/

   DEFINE INPUT PARAMETER rid_fac AS ROWID.
                                                                                                      
/*===============================================================================================*/
/*                                       PROCESO                                                 */
/*===============================================================================================*/

   FIND FIRST Fac_header WHERE ROWID(Fac_header) = rid_fac NO-LOCK.

   FIND Tipocomprobante OF Fac_header NO-LOCK NO-ERROR.
   IF NOT AVAILABLE tipocomprobante THEN DISPLAY fac_header.cdg_empresa fac_header.tip_comprob fac_header.prf_comprob fac_header.nro_comprob.
   FIND Cliente OF Fac_header NO-LOCK NO-ERROR.
   FIND Familia_cliente OF Cliente NO-LOCK NO-ERROR.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/
              
   FIND FIRST Impuesto WHERE Impuesto.es_iva NO-LOCK.
   FIND sub_header_vta OF fac_header NO-ERROR.
   IF AVAILABLE sub_header_vta THEN DO:
             FOR EACH sub_detalle_vta OF sub_header_vta:
                DELETE sub_detalle_vta.
             END.
             DELETE sub_header_vta.
   END.
   CREATE Sub_header_vta.
   BUFFER-COPY Fac_header TO Sub_header_vta.
   IF AVAILABLE familia_cliente THEN 
        ASSIGN Sub_header_vta.nro_cuenta      = Familia_cliente.nro_cuenta.

   FOR FIRST Fac_detalle OF Fac_header  NO-LOCK:
       FIND Articulo NO-LOCK OF Fac_detalle NO-ERROR.
       FIND Familia_articulo NO-LOCK OF Articulo NO-ERROR.
       FIND Familia_impositiva OF Articulo NO-LOCK NO-ERROR.
       IF AVAILABLE familia_articulo THEN DO:
       
       FIND FIRST Familia_cuenta OF Familia_articulo 
            WHERE Familia_cuenta.cdg_imputacion = Fac_header.cdg_imputacion 
              AND Familia_cuenta.cdg_empresa    = Fac_header.cdg_empresa 
                           NO-LOCK NO-ERROR.
    
        IF NOT AVAILABLE Familia_cuenta AND NOT fac_header.anulado
        THEN DO: 
            MESSAGE "Cdg familia art: " Familia_articulo.cdg_familia " Buscar si existe Familia_Cuenta donde Cod_imputacion: " Fac_header.cdg_imputacion "Cod_empresa: " Fac_header.cdg_empresa
                VIEW-AS ALERT-BOX MESSAGE TITLE "Familia_cuenta no encontrada".
            RETURN.
        END.
       END.
        CREATE Sub_detalle_vta.
        ASSIGN Sub_detalle_vta.cdg_empresa    = Fac_header.cdg_empresa
               Sub_detalle_vta.tip_comprob    = Fac_header.tip_comprob
               Sub_detalle_vta.prf_comprob    = Fac_header.prf_comprob
               Sub_detalle_vta.nro_comprob    = Fac_header.nro_comprob
               Sub_detalle_vta.nro_cuenta     = IF AVAILABLE Familia_cuenta THEN Familia_cuenta.nro_cuenta ELSE Sub_detalle_vta.nro_cuenta
               Sub_detalle_vta.nro_entidad    = Fac_detalle.nro_entidad
               Sub_detalle_vta.nro_obra       = Fac_detalle.nro_obra
               Sub_detalle_vta.tipo           = 1
               Sub_detalle_vta.valor          = Fac_detalle.subtotal_neto.
    
       CREATE Sub_detalle_vta.
       ASSIGN Sub_detalle_vta.cdg_empresa    = Fac_header.cdg_empresa
              Sub_detalle_vta.tip_comprob    = Fac_header.tip_comprob
              Sub_detalle_vta.prf_comprob    = Fac_header.prf_comprob
              Sub_detalle_vta.nro_comprob    = Fac_header.nro_comprob
              Sub_detalle_vta.nro_cuenta     = Impuesto.nro_cuenta
              Sub_detalle_vta.tipo           = 2
              Sub_detalle_vta.valor          = Fac_header.imp_total - Fac_detalle.subtotal_neto.
              Sub_header_vta.imp_total       = Fac_header.imp_total.
   END.
