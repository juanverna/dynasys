/*crea notas de credito para las facturas pasadas en la tabla
se genera una NC por cada factura a anular*/
{findempresa.i}
DEFINE TEMP-TABLE tcredito NO-UNDO
    FIELD trid AS ROWID.
DEFINE TEMP-TABLE t-fac_header NO-UNDO LIKE fac_header.
DEFINE TEMP-TABLE t-fac_detalle NO-UNDO LIKE fac_detalle.
DEFINE INPUT PARAMETER TABLE FOR tcredito.
    RETURN.
FOR EACH tcredito:
FIND fac_header WHERE ROWID(fac_header) = tcredito.trid NO-LOCK.
FIND cliente OF fac_header NO-LOCK.
/*crear documento*/
DO TRANSACTION:
      FIND Punto-venta WHERE Punto-venta.cdg_puntovta = fac_header.prf_comprob 
                         AND Punto-venta.cdg_empresa  = Empresa.cdg_empresa
                             NO-LOCK.
      IF NOT punto-venta.habilitado  THEN RETURN ERROR "Punto de venta " + string(fac_header.prf_comprob,"9999") + " no habilitado".
      CREATE T-Fac_header.
      ASSIGN T-Fac_header.cdg_comprobante = Tipocomprobante.cdg_comprobante 
             T-Fac_header.nro_usuario     = Usuario.nro_usuario 
             T-Fac_header.cdg_empresa     = Empresa.cdg_empresa
             T-Fac_header.fecha           = IF Punto-venta.modo_fecha = "T" THEN Punto-venta.fch_cierre + 1 ELSE TODAY
             T-Fac_header.fecha_iva       = T-Fac_header.fecha 
             T-Fac_header.fecha_precios   = T-Fac_header.fecha 
             T-Fac_header.mes             = MONTH(T-Fac_header.fecha) 
             T-Fac_header.ano             = YEAR(T-Fac_header.fecha)
             T-Fac_header.cdg_empresa     = Empresa.cdg_empresa 
             T-Fac_header.nro_deposito    = Deposito.nro_deposito 
             T-Fac_header.tip_comprob     = ""                  
             T-Fac_header.nro_factura     = 0  
             T-Fac_header.estado          = "E"  
             T-Fac_header.nro_comprob     = T-Fac_header.nro_factura
             T-Fac_header.prf_comprob     = v-cdg_punto-venta
             T-Fac_header.nro_moneda      = Moneda.nro_moneda 
             T-Fac_header.cambio          = Moneda.cambio  
             T-Fac_header.cdg_imputacion  = x-primero
             T-Fac_header.cta_cte         = YES /*Imputacion.cta_cte */
             T-Fac_header.num_sucursal    = sucursal-id    
             T-Fac_header.origen          = "M"
             T-Fac_header.leyenda         = v-leyenda. 

             RUN asignar_cambio.

  END.

  DISPLAY
         T-Fac_header.fecha   
         T-Fac_header.cdg_imputacion
         v-cdg_punto-venta
         v-comprobante
         v-cdg_administrador
         v-dsc_administrador
         WITH FRAME {&FRAME-NAME}.
                                       
  codigo_salir = ?.

  IF    modo = MD_MULTIPLE
     OR modo = MD_ANULACION
     OR modo = MD_EMISION
  THEN DO:
       DO WITH FRAME {&FRAME-NAME}:
          T-Fac_header.tip_comprob:FGCOLOR = 9.
          T-Fac_header.tip_comprob:BGCOLOR = 15.

          v-cdg_punto-venta:FGCOLOR = 9.
          v-cdg_punto-venta:BGCOLOR = 15.

          T-Fac_header.nro_comprob:FGCOLOR = 9.
          T-Fac_header.nro_comprob:BGCOLOR = 15.
       END.
  END.






































  FIND administrador WHERE administrador.nro_cliente = cliente.nro_admin NO-LOCK NO-ERROR.
  IF cliente.factu_admin AND AVAILABLE administrador THEN DO:
      IF LOOKUP(que_sector, administrador.lista_sectores) = 0
      THEN DO:
        RUN PONMENSJ.P ( 'IREF002' ).
        RETURN ERROR.
      END.
      
      IF NOT administrador.permite_nominar THEN DO:
        IF administrador.cod_docu = ""  THEN DO:
            MESSAGE "El codigo de documento esta en blanco"VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
        IF administrador.cod_docu <> "NO"  THEN DO:
           run validar_cuit_param.p ( administrador.cuit,? ).
            if return-value <> "OK" THEN RETURN NO-APPLY.
        END.
      END.
      IF NOT CAN-DO(administrador.lista_empresas,Empresa.cdg_empresa)
      THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE050" ).
        no_aplicar = YES.
        RETURN ERROR.
      END.
      IF LOOKUP(administrador.cdg_estado,",A") = 0
      THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE051" ).
        no_aplicar = YES.
        RETURN ERROR.
      END.
      FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = administrador.dfl_cndventa NO-LOCK.
      FIND Familia_cliente OF administrador NO-LOCK.
      FIND Cuenta OF Familia_cliente NO-LOCK.
      FIND Condicion_impos OF administrador NO-LOCK.
      FIND Vendedor OF administrador NO-LOCK.
      FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK NO-ERROR.
        
      ASSIGN
        T-Fac_header.cdg_condiva          = Condicion_impos.cdg_condiva
        T-Fac_header.nro_cndventa         = Condicion_venta.nro_cndventa
        T-Fac_header.prc_canje            = IF hay_canje THEN administrador.prc_canje ELSE 0
        T-Fac_header.cuit                 = administrador.cuit
        t-fac_header.cod_docu             = administrador.cod_docu
        T-Fac_header.nro_cliente          = administrador.nro_cliente
        T-Fac_header.cdg_lista            = administrador.dfl_lista
        T-Fac_header.nro_vendedor         = administrador.nro_vendedor
        T-Fac_header.nro_entidad          = administrador.nro_entidad
        T-Fac_header.nombre               = administrador.nom_cliente                
        T-Fac_header.direccion            = administrador.direccion
        T-Fac_header.cdg_provincia        = administrador.cdg_provincia
        T-Fac_header.localidad            = administrador.localidad
        T-Fac_header.cdg_postal           = administrador.cdg_postal.
  END.
  ELSE DO:
      IF LOOKUP(que_sector, administrador.lista_sectores) = 0
      THEN DO:
        RUN PONMENSJ.P ( 'IREF002' ).
        no_aplicar = YES.
        RETURN ERROR.
      END.
      IF cliente.cod_docu = ""  THEN DO:
            MESSAGE "El codigo de documento esta en blanco"VIEW-AS ALERT-BOX ERROR.
            RETURN NO-APPLY.
        END.
      IF NOT Cliente.permite_nominar THEN DO:
        IF cliente.cod_docu <> "NO"  THEN DO:
            run validar_cuit_param.p ( Cliente.cuit,? ).
            if return-value <> "OK" THEN RETURN NO-APPLY.
        END.
      END.
      IF NOT CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
      THEN DO:
                RUN PONMENSJ.P ( INPUT "CLIE050" ).
                no_aplicar = YES.
                RETURN ERROR.
      END.
      IF LOOKUP(Cliente.cdg_estado,",A") = 0
      THEN DO:
                 RUN PONMENSJ.P ( INPUT "CLIE051" ).
                 no_aplicar = YES.
                 RETURN ERROR.
      END.
      FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Cliente.dfl_cndventa NO-LOCK.
      FIND Familia_cliente OF Cliente NO-LOCK.
      FIND Cuenta OF Familia_cliente NO-LOCK.
      FIND Condicion_impos OF Cliente NO-LOCK.
      FIND Vendedor OF Cliente NO-LOCK.
      FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK NO-ERROR.
        
      ASSIGN
        T-Fac_header.cdg_condiva          = Condicion_impos.cdg_condiva
        T-Fac_header.nro_cndventa         = Condicion_venta.nro_cndventa
        T-Fac_header.prc_canje            = IF hay_canje THEN Cliente.prc_canje ELSE 0
        T-Fac_header.cuit                 = Cliente.cuit
        T-Fac_header.cod_docu             = Cliente.cod_docu
        T-Fac_header.nro_cliente          = Cliente.nro_cliente
        T-Fac_header.cdg_lista            = Cliente.dfl_lista
        T-Fac_header.nro_vendedor         = Cliente.nro_vendedor
        T-Fac_header.nro_entidad          = Cliente.nro_entidad
        T-Fac_header.nombre               = Cliente.nom_cliente                
        T-Fac_header.direccion            = Cliente.direccion
        T-Fac_header.cdg_provincia        = Cliente.cdg_provincia
        T-Fac_header.localidad            = Cliente.localidad
        T-Fac_header.cdg_postal           = Cliente.cdg_postal.
  END.
            
  ASSIGN
        T-Fac_header.nombre_leg           = Cliente.nom_cliente                                
        T-Fac_header.direccion_leg        = Cliente.direccion
        T-Fac_header.cdg_provincia_leg    = Cliente.cdg_provincia
        T-Fac_header.localidad_leg        = Cliente.localidad
        T-Fac_header.cdg_postal_leg       = Cliente.cdg_postal
        T-Fac_header.clausula_dolar       = Cliente.clausula_dolar
        T-fac_header.nro_administrador    = cliente.nro_administrador
        v-cdg_cliente                     = Cliente.cdg_cliente
        v-cdg_punto-venta                 = Cliente.dfl_cdg_puntovta.
    
    RUN poner_administrador.

    IF AVAILABLE Obra 
        THEN T-Fac_header.nro_obra        = Obra.nro_obra.
    ASSIGN
        T-Fac_header.tip_comprob          = v-tip_comprob
        T-Fac_header.cta_cte              = Cliente.tiene_ctacte.

    ASSIGN   v-tip_remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "" 
             v-prf_remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
             v-nro_remito:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
             v-tip_remito:SENSITIVE IN FRAME {&FRAME-NAME} = NO 
             v-prf_remito:SENSITIVE IN FRAME {&FRAME-NAME} = NO
             v-nro_remito:SENSITIVE IN FRAME {&FRAME-NAME} = NO.

    RUN traer_condicion_venta.
    RUN traer_condicion_impos.
    RUN traer_lista.
    RUN traer_vendedor.
    RUN traer_administrador.
    IF Cliente.factu_admin AND AVAILABLE administrador THEN
        FOR EACH Cliente-bonificacion OF Cliente 
           WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa
             AND Cliente-bonificacion.desde_fecha <= T-Fac_header.fecha 
             AND Cliente-bonificacion.hasta_fecha >= T-Fac_header.fecha 
                NO-LOCK:
          
             CREATE T-Fac_header-bon.
             ASSIGN T-Fac_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
                    T-Fac_header-bon.importe          = 0
                    T-Fac_header-bon.nro_factura      = T-Fac_header.nro_factura
                    T-Fac_header-bon.porcentaje       = Cliente-bonificacion.porcentaje.
        END.
    ELSE
         FOR EACH Cliente-bonificacion OF Cliente 
           WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa
             AND Cliente-bonificacion.desde_fecha <= T-Fac_header.fecha 
             AND Cliente-bonificacion.hasta_fecha >= T-Fac_header.fecha 
                NO-LOCK:
          
             CREATE T-Fac_header-bon.
             ASSIGN T-Fac_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
                    T-Fac_header-bon.importe          = 0
                    T-Fac_header-bon.nro_factura      = T-Fac_header.nro_factura
                    T-Fac_header-bon.porcentaje       = Cliente-bonificacion.porcentaje.
        END.

    IF T-Fac_header.clausula_dolar
        THEN RUN asignar_dolar.


    IF CAN-FIND(FIRST Tipo_puntovta 
                WHERE Tipo_puntovta.cdg_comprobante = T-Fac_header.cdg_comprobante
                  AND Tipo_puntovta.cdg_puntovta = Cliente.dfl_cdg_puntovta)
    THEN DO:
        v-cdg_punto-venta = Cliente.dfl_cdg_puntovta.
        RUN asignar_fecha_puntovta.
    END.
  
    DISPLAY  v-cdg_cliente 
             T-Fac_header.nombre
             T-Fac_header.direccion     
             T-Fac_header.cdg_provincia 
             T-Fac_header.localidad     
             T-Fac_header.cdg_postal    

             T-Fac_header.nombre_leg       
             T-Fac_header.direccion_leg       
             T-Fac_header.cdg_provincia_leg   
             T-Fac_header.localidad_leg       
             T-Fac_header.cdg_postal_leg      

             T-Fac_header.cdg_imputacion
             T-Fac_header.cuit
             T-Fac_header.cod_docu 
             v-cdg_vendedor
             v-dsc_vendedor

             v-cdg_condicion_venta
             v-dsc_condicion_venta
  
             T-Fac_header.tip_comprob
             T-Fac_header.cta_cte

             v-cdg_administrador
             v-dsc_administrador
             
             v-cdg_punto-venta

             WITH FRAME {&FRAME-NAME}.
             
  
     FIND Domicilio OF Cliente NO-LOCK NO-ERROR.
     IF AVAILABLE Domicilio 
     THEN DO:
        FIND Provincia OF Domicilio NO-LOCK.
        ASSIGN  T-Fac_header.nro_domicilio = Domicilio.nro_domicilio.
     END.

     RUN habilitar_campos ( YES ).

             END PROCEDURE.





