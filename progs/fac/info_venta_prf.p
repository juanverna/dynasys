   FUNCTION veranticipos 
     RETURNS DECIMAL
  ( ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF BUFFER bdetalle FOR contrato_dt.
    DEF VAR v-anticipo AS DECIMAL NO-UNDO.
    FOR EACH bdetalle OF contrato_hd:
        v-anticipo = bdetalle.anticipo.
    END.
    RETURN v-anticipo.   /* Function return value. */
END FUNCTION.


   /*Generacion de los aumentos de los abonos*/
    DEF VAR I AS INT NO-UNDO.
    DEFINE TEMP-TABLE t-contrato_hd like contrato_hd.
    DEFINE TEMP-TABLE t-contrato_dt LIKE contrato_dt.
    DEFINE BUFFER administrador FOR cliente.
    DEFINE VAR aumento AS DECIMAL LABEL "Aumento en porcentaje" NO-UNDO.

    DEFINE VAR p-has_fecha AS DATE NO-UNDO.
    DEFINE VAR p-des_fecha AS DATE NO-UNDO.
    DEFINE VAR p-fecha AS DATE NO-UNDO.
    DEFINE VAR p-des_punto        AS INTEGER INITIAL 0.  
    DEFINE var p-has_punto        AS INTEGER INITIAL 999. 
    
    DEFINE TEMP-TABLE listado
    FIELD cdg_cliente       LIKE Cliente.cdg_cliente  
    FIELD nom_cliente       LIKE Cliente.nom_cliente 
    FIELD DIR_cliente       LIKE cliente.direccion
    FIELD cdg_condiva LIKE  contrato_hd.cdg_condiva 
    FIELD cdg_administrador LIKE administrador.cdg_cliente LABEL "Admin"
    FIELD nom_administrador LIKE administrador.nom_cliente LABEL "Adm Nombre"
    FIELD ListaArticulos    AS CHAR FORMAT "X(20)"
    FIELD prf_contrato      LIKE Contrato_hd.prf_contrato
    FIELD num_contrato      LIKE Contrato_hd.num_contrato
    FIELD total_aumento   LIKE contrato_hd.imp_total
    FIELD total_anterior  LIKE contrato_hd.imp_total
    FIELD neto_aumento      LIKE contrato_hd.imp_neto
    FIELD neto_anterior     LIKE contrato_hd.imp_neto
    FIELD rige_desde        LIKE Contrato_hd.rige_desde 
    FIELD rige_hasta        LIKE Contrato_hd.rige_hasta
    FIELD primer_ano        LIKE Contrato_hd.primer_ano
    FIELD primer_mes        LIKE Contrato_hd.primer_mes
    FIELD resto_periodos    LIKE Contrato_hd.resto_periodos
    FIELD tip_contrato      LIKE contrato_hd.tip_contrato
    FIELD cuit              LIKE Contrato_hd.cuit
    FIELD Unidades          LIKE Cliente_otros_datos.Unidades.
{tt2xls.i}
    DEFINE VAR preciocuota AS DECIMAL.
DEFINE DATASET dset FOR listado.

EMPTY TEMP-TABLE listado.
EMPTY TEMP-TABLE t-contrato_hd.
EMPTY TEMP-TABLE t-contrato_dt.

    p-fecha = 01/4/2009.
    UPDATE p-fecha aumento
    p-des_fecha = p-fecha.
    p-has_fecha = 01/01/3000.
    aumento = 1 + aumento / 100.

    FOR EACH Contrato_hd 
    WHERE ( Contrato_hd.rige_desde <= p-has_fecha  
      AND Contrato_hd.rige_hasta >= p-des_fecha )
      AND contrato_hd.estado = "A"
      AND ( Contrato_hd.cant_periodos = 0  OR ( Contrato_hd.cant_periodos <> 0 AND contrato_hd.resto_periodos <> 0 ))
      AND Contrato_hd.fecha_baja = ?
      AND Contrato_hd.prf_contrato <= p-has_punto 
      AND Contrato_hd.prf_contrato >= p-des_punto 
      ,

      /* FIRST estado OF contrato_hd WHERE estado.activo = TRUE ,*/
          FIRST Cliente OF Contrato_hd  ,
          FIRST administrador WHERE administrador.nro_cliente = cliente.nro_administrador 
                            BREAK BY administrador.nom_cliente
                                  BY cliente.direccion
                                  BY Contrato_hd.num_contrato: 
        IF contrato_hd.fecha_baja <> ? AND contrato_hd.fecha_baja <=  p-des_fecha THEN NEXT.
        CREATE t-contrato_hd.
        BUFFER-COPY contrato_hd TO t-contrato_hd.
        FIND FIRST Cliente_otros_datos OF cliente NO-LOCK NO-ERROR.
        FOR EACH contrato_dt OF contrato_hd:
            CREATE t-contrato_dt.
            BUFFER-COPY contrato_dt TO t-contrato_dt.
            ASSIGN  t-Contrato_hd.imp_bruto = 0
                    t-Contrato_hd.imp_iva = 0
                    t-Contrato_hd.imp_neto = 0
                    t-Contrato_hd.imp_total = 0.
            preciocuota = IF Contrato_hd.cant_periodos = 0 THEN t-contrato_dt.precio ELSE (t-contrato_dt.precio - veranticipos() ) / Contrato_hd.cant_periodos.             
            
            IF t-contrato_hd.cdg_condiva = 1 THEN DO: /*es una A*/
            /*AUMENTAR EL DETALLE Y QUE DE LO QUE DE EL TOTAL*/
                    ASSIGN  
                        t-contrato_dt.precio = round( preciocuota * aumento , 2 )
                        t-contrato_dt.precio_cf = ROUND( preciocuota * 1.21 , 2 ).
            END.
            ELSE DO:
                        IF t-contrato_hd.prf_contrato = 1 THEN DO:
                            t-contrato_dt.precio = ROUND(t-contrato_dt.subtotal_gral * aumento, 0 ) / 1.21 .
                            t-contrato_dt.precio_cf = round( preciocuota * 1.21 , 0 ).
                        END.
                        ELSE DO: 
                            t-contrato_dt.precio = ROUND(t-contrato_dt.subtotal_gral * aumento, 0 ) .
                            t-contrato_dt.precio_cf =  preciocuota .
                        END.
            END.


            ASSIGN
                
                t-contrato_dt.subtotal_bruto = t-contrato_dt.precio
                t-contrato_dt.subtotal_bruto_cf = t-contrato_dt.precio_cf
                t-contrato_dt.subtotal_neto_cf = t-contrato_dt.precio_cf
                t-contrato_dt.subtotal_gral = t-contrato_dt.subtotal_bruto_cf
                t-contrato_dt.subtotal_neto = t-contrato_dt.precio
                t-contrato_dt.subtotal_neto_cf = t-contrato_dt.precio_cf
                t-Contrato_hd.imp_bruto = t-Contrato_hd.imp_bruto + t-contrato_dt.subtotal_bruto
                t-Contrato_hd.imp_iva = t-Contrato_hd.imp_iva + t-contrato_dt.precio_cf - t-contrato_dt.precio
                t-Contrato_hd.imp_neto = t-Contrato_hd.imp_neto + t-contrato_dt.subtotal_neto
                t-Contrato_hd.imp_total = t-Contrato_hd.imp_total + t-contrato_dt.subtotal_gral.
        END.
        CREATE listado.
        ASSIGN listado.cdg_cliente          = cliente.cdg_cliente             
               listado.nom_cliente          = cliente.nom_cliente       
               listado.DIR_cliente          = cliente.direccion    
               listado.cdg_administrador    = administrador.cdg_cliente 
               listado.nom_administrador    = administrador.nom_cliente
               listado.num_contrato         = contrato_hd.num_contrato      
               listado.prf_contrato         = contrato_hd.prf_contrato      
               listado.rige_desde           = contrato_hd.rige_desde        
               listado.rige_hasta           = contrato_hd.rige_hasta        
               listado.primer_ano           = contrato_hd.primer_ano        
               listado.primer_mes           = contrato_hd.primer_mes        
               listado.cuit                 = cliente.cuit
               listado.ListaArticulos       = ""
               listado.total_aumento        = t-contrato_hd.imp_total
               listado.total_anterior       = contrato_hd.imp_total
               listado.neto_aumento         = t-contrato_hd.imp_neto
               listado.neto_anterior        = contrato_hd.imp_neto
               listado.cdg_condiva          = t-contrato_hd.cdg_condiva
               listado.unidades             = IF AVAILABLE Cliente_otros_datos THEN Cliente_otros_datos.Unidades ELSE 0.
        
        FIND contrato_dt OF contrato_hd NO-ERROR.
        IF NOT AVAILABLE contrato_dt THEN DO:
            DISPLAY cliente.nom_cliente contrato_hd.num_contrato.
            NEXT.
        END.

        FOR EACH Contrato_dt OF Contrato_hd , 
               FIRST Articulo OF Contrato_dt :
         ASSIGN listado.ListaArticulos = listado.ListaArticulos + " " +  Articulo.cdg_tipoart.
        END.    
    END.

/*     {crystal_dynaSS.p}                              */
/*     xfile = "c:\sic-temp\aumento03032009.xml".      */
/*     DATASET dset:WRITE-XML ("FILE", xfile, FALSE,   */
/*                                      ?,"",YES,YES). */
/*                                                     */
 RUN pTT2XLS                                                              
   ( INPUT TEMP-TABLE listado:DEFAULT-BUFFER-HANDLE,                       
     INPUT 'c:\temp\a.xls',                                               
     INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ). 
