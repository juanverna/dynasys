/*----------------------------------------------------------------------------------------------*/
/*                 REGENERA EL SUBDIARIO DE UN COMPROBANTE INTERNO DE FACTURACION               */
/*----------------------------------------------------------------------------------------------*/
   
   DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
   DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
   
/*----------------------------------------------------------------------------------------------*/
/*                                    Trae tablas relacionadas                                  */
/*----------------------------------------------------------------------------------------------*/
   
   FIND Fac_header
       WHERE Fac_header.cdg_empresa = "M"
         AND Fac_header.tip_comprob = "CI"
         AND Fac_header.prf_comprob = 8888
         AND Fac_header.nro_comprob = 1
             NO-LOCK.

   FIND Tipocomprobante OF Fac_header NO-LOCK.
   FIND Obra OF Fac_header NO-LOCK.
   FIND Cliente OF Fac_header NO-LOCK.
   FIND Familia_cliente OF Cliente NO-LOCK.

/*----------------------------------------------------------------------------------------------*/
/*                        Crear registro de encabezado de subdiario                             */
/*----------------------------------------------------------------------------------------------*/
              
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.

   CREATE T-Sub_header_vta.
   BUFFER-COPY Fac_header TO T-Sub_header_vta
        ASSIGN T-Sub_header_vta.nro_cuenta      = Familia_cliente.nro_cuenta
               T-Sub_header_vta.nro_obra        = Obra.nro_obra.

   FOR EACH Fac_detalle OF Fac_header, 
       FIRST Articulo NO-LOCK OF Fac_detalle, 
            FIRST Familia_articulo NO-LOCK OF Articulo, 
                       FIRST Familia_impositiva OF Articulo, 
                             FIRST Familia_cuenta OF Familia_articulo 
                                  WHERE Familia_cuenta.cdg_imputacion = Fac_header.cdg_imputacion NO-LOCK:
    

       FIND  T-Sub_detalle_vta 
            WHERE T-Sub_detalle_vta.cdg_empresa   = Fac_header.cdg_empresa
              AND T-Sub_detalle_vta.tip_comprob   = Fac_header.tip_comprob
              AND T-Sub_detalle_vta.prf_comprob   = Fac_header.prf_comprob
              AND T-Sub_detalle_vta.nro_comprob   = Fac_header.nro_comprob
              AND T-Sub_detalle_vta.nro_cuenta    = Familia_cuenta.nro_cuenta
              AND T-Sub_detalle_vta.nro_entidad   = Fac_header.nro_entidad
              AND T-Sub_detalle_vta.nro_obra      = Fac_detalle.nro_obra
                  EXCLUSIVE-LOCK NO-ERROR.
    
       IF NOT AVAILABLE T-Sub_detalle_vta 
       THEN DO:
           CREATE T-Sub_detalle_vta.
           ASSIGN T-Sub_detalle_vta.cdg_empresa    = Fac_header.cdg_empresa
                  T-Sub_detalle_vta.tip_comprob    = Fac_header.tip_comprob
                  T-Sub_detalle_vta.prf_comprob    = Fac_header.prf_comprob
                  T-Sub_detalle_vta.nro_comprob    = Fac_header.nro_comprob
                  T-Sub_detalle_vta.nro_cuenta     = Familia_cuenta.nro_cuenta
                  T-Sub_detalle_vta.nro_entidad    = Fac_header.nro_entidad
                  T-Sub_detalle_vta.nro_obra       = Fac_detalle.nro_obra
                  T-Sub_detalle_vta.tipo           = 1.
       END.
    
       T-Sub_detalle_vta.valor = T-Sub_detalle_vta.valor + Fac_detalle.subtotal_neto.

   END.

   DISPLAY T-Sub_header_vta WITH SIDE-LABELS 2 COLUMNS.
   FOR EACH T-Sub_detalle_vta:
       DISPLAY T-Sub_detalle_vta WITH SIDE-LABELS 2 COLUMNS.
   END.

   MESSAGE "Sandri, bajamos los registros a la base?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirmando...."
       SET sino AS LOGICAL .

   IF sino
   THEN DO:
       CREATE Sub_header_vta.
       BUFFER-COPY T-Sub_header_vta TO Sub_header_vta.
       FOR EACH T-Sub_detalle_vta:
           CREATE Sub_detalle_vta.
           BUFFER-COPY T-Sub_detalle_vta TO Sub_detalle_vta.
       END.
   END.
