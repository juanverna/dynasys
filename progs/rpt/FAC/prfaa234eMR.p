/*====================================================================================*/
/*                 IMPRESION DE UN LOTE DE FACTURAS CONSECUTIVAS                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER p-tip_comprob LIKE Fac_header.tip_comprob.
DEFINE INPUT PARAMETER p-prf_comprob LIKE Fac_header.prf_comprob.
DEFINE INPUT PARAMETER p-des_nrocomp LIKE Fac_header.nro_comprob.
DEFINE INPUT PARAMETER p-has_nrocomp LIKE Fac_header.nro_comprob.
DEFINE INPUT PARAMETER p-cdg_empresa LIKE empresa.cdg_empresa no-undo.
DEFINE INPUT PARAMETER p-timpre AS integer no-undo.
DEFINE OUTPUT PARAMETER xfile AS CHAR NO-UNDO.

DEF VAR i AS INT NO-UNDO.
DEF VAR j AS INT NO-UNDO.
DEF VAR juntas AS LOGICAL NO-UNDO.
DEF VAR listaposible AS CHAR.
{codificarafip.i}
{findempresa.i}
/*se se imprime en original solamente, solo se pasaran a CR los datos que se necesitan*/
DEFINE TEMP-TABLE ttheader NO-UNDO LIKE Fac_header
    FIELD dsc_provincia         AS CHARACTER
    FIELD dsc_provincia_leg     AS CHARACTER
    FIELD dsc_condicionimpos    AS CHARACTER
    FIELD dsc_comprobante       AS CHARACTER
    FIELD dsc_condicionventa    AS CHARACTER
    FIELD CodigoBarra           AS CHARACTER
    FIELD lecturahumana         AS CHARACTER
    FIELD vencimiento           AS DATE
    FIELD totdeuda AS DECIMAL DECIMALS 2
    FIELD cdg_afip              LIKE TipocomprobanteAfip.cdg_afip.
DEFINE TEMP-TABLE ttdetalle NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE TTDeuda NO-UNDO
    FIELD nro_factura LIKE fac_header.nro_factura
    FIELD tip_comprob LIKE fac_header.tip_comprob
    FIELD prf_comprob LIKE fac_header.prf_comprob
    FIELD nro_comprob LIKE fac_header.nro_comprob
    FIELD imp_total LIKE fac_header.imp_total
    FIELD fecha LIKE fac_header.fecha
    FIELD fecha_vencimiento LIKE cta_cte.fecha_vencimiento.
DEFINE TEMP-TABLE xttdeuda NO-UNDO LIKE TTDeuda.
DEFINE DATASET dset FOR ttheader,ttdetalle,TTDeuda
    DATA-RELATION headerdetalle FOR ttheader,ttdetalle RELATION-FIELDS(nro_factura, nro_factura)
    DATA-RELATION headerdeuda FOR ttheader,TTDeuda RELATION-FIELDS(nro_factura, nro_factura).
DEFINE BUFFER administrador FOR cliente.
DEFINE VAR resdeuda AS INT NO-UNDO.
DEFINE VAR ldeuda AS LONGCHAR NO-UNDO.
DEFINE VAR totdeuda AS DECIMAL DECIMALS 2.
DEFINE VAR rok AS LOGICAL NO-UNDO.

/*====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                   */
/*====================================================================================*/
/*RUN getparametro_l.p( INPUT "CREDEBFC" , OUTPUT juntas ).
  IF juntas THEN
    listaposible = "F" + SUBSTR(p-tip_comprob,2) + ",C" + SUBSTR(p-tip_comprob,2) + ",D" + SUBSTR(p-tip_comprob,2).
 ELSE*/
    listaposible = p-tip_comprob.
j = 0.
RUN getparametro_n.p( INPUT "DEUDA" , OUTPUT resdeuda ).
EMPTY TEMP-TABLE ttheader.
EMPTY TEMP-TABLE ttdetalle.
EMPTY TEMP-TABLE TTDeuda.
EMPTY TEMP-TABLE xttdeuda.

FOR EACH Fac_header 
    WHERE Fac_header.cdg_empresa  = p-cdg_empresa AND
       Fac_header.prf_comprob  = p-prf_comprob
      AND Fac_header.nro_comprob  <= p-has_nrocomp
      AND Fac_header.nro_comprob  >= p-des_nrocomp 
      AND (( p-timpre = 1 AND fac_header.impreso = "S" ) OR 
           ( p-timpre = 0 AND fac_header.impreso <> "S" )):
    IF not CAN-DO(listaposible, Fac_header.tip_comprob) THEN NEXT.
    
    FIND administrador WHERE administrador.nro_cliente = fac_header.nro_admin NO-LOCK NO-ERROR.
    EMPTY TEMP-TABLE xttdeuda.
    totdeuda = 0.
    ldeuda="".
    IF fac_header.fecha_impresion <> ?  THEN DO:
        COPY-LOB fac_header.deuda TO ldeuda.
        IF ldeuda <> ? THEN DO:
            rok = TEMP-TABLE XTTDEUDA:READ-XML("LONGCHAR",ldeuda,"MERGE",?,?) NO-ERROR.
            FOR EACH XTTDEUDA:
                totdeuda =  totdeuda + XTTDEUDA.imp_total.
            END.
        END.
    END.
    ELSE DO:
        IF CAN-FIND( FIRST Cta_cte WHERE cta_cte.nro_cliente = fac_header.nro_cliente
                  AND Cta_cte.cdg_empresa     = empresa.cdg_empresa
                  AND cta_cte.prf_comprob = 3
                  AND Cta_cte.debito <> Cta_cte.credito 
                  AND cta_cte.fecha_vencimiento + resdeuda <= fac_header.fecha ) THEN 
            FOR EACH Cta_cte NO-LOCK
                WHERE cta_cte.nro_cliente = fac_header.nro_cliente
                  AND Cta_cte.cdg_empresa     = empresa.cdg_empresa
                  AND cta_cte.prf_comprob = 3
                  AND Cta_cte.debito <> Cta_cte.credito
                  AND cta_cte.fecha_vencimiento <= fac_header.fecha - 5:
                     CREATE xttdeuda.
                     ASSIGN xttdeuda.nro_factura = fac_header.nro_factura
                         xttdeuda.fecha = Cta_cte.fecha_emision
                         xttdeuda.fecha_vencimiento = Cta_cte.fecha_vencimiento
                         xttdeuda.tip_comprob = cta_cte.tip_comprob
                         xttdeuda.prf_comprob = cta_cte.prf_comprob
                         xttdeuda.nro_comprob = cta_cte.nro_comprob
                         xttdeuda.imp_total = Cta_cte.debito - Cta_cte.credito
                         totdeuda =  totdeuda + xttdeuda.imp_total.
           END.
           FIND FIRST xttdeuda NO-ERROR.
           IF AVAILABLE xttdeuda THEN DO:
                ldeuda = "".
                rok = TEMP-TABLE XTTDEUDA:WRITE-XML("LONGCHAR",ldeuda) .
                IF rok THEN ASSIGN fac_header.deuda = ldeuda.
            END.
        ASSIGN fac_header.fecha_impresion = fac_header.fecha.
    END.
    /*impresion y appenda a crystal*/
     FIND restriccion WHERE restriccion.cdg_restriccion = "NODEU" NO-LOCK.
    FIND cliente_restriccion OF administrador WHERE cliente_restriccion.nro_restriccion  = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF NOT AVAILABLE cliente_restriccion THEN DO:
      IF ldeuda<>? THEN DO:
            EMPTY TEMP-TABLE xttdeuda.
            rok=TEMP-TABLE xTTDeuda:READ-XML( "LONGCHAR",ldeuda,"MERGE",?,?) NO-ERROR.
            FOR EACH xttdeuda NO-LOCK:
                CREATE ttdeuda.
                BUFFER-COPY xttdeuda TO ttdeuda.
            END.
        END.    
    END.
    CREATE ttheader.
    BUFFER-COPY fac_header TO ttheader NO-ERROR.
    ASSIGN ttheader.totdeuda = totdeuda.
      FIND Provincia WHERE Provincia.cdg_provincia = Fac_header.cdg_provincia NO-LOCK NO-ERROR.
    IF AVAILABLE provincia THEN ttheader.dsc_provincia = Provincia.nombre.

    FIND Provincia WHERE Provincia.cdg_provincia = Fac_header.cdg_provincia_leg NO-LOCK NO-ERROR.
    IF AVAILABLE provincia THEN ttheader.dsc_provincia_leg = Provincia.nombre.


    FIND Condicion_impos WHERE Condicion_impos.cdg_condiva = Fac_header.cdg_condiva NO-LOCK.
    ttheader.dsc_condicionimpos = Condicion_impos.texto.

    FIND Condicion_venta WHERE Condicion_venta.nro_cndventa = Fac_header.nro_cndventa NO-LOCK.
    ttheader.dsc_condicionventa = Condicion_venta.descripcion.
    FIND FIRST subcondicion OF Condicion_venta NO-LOCK.
    vencimiento = fac_header.fecha + subcondicion.dias.
    FIND Tipocomprobante OF Fac_header NO-LOCK.
    Ttheader.dsc_comprobante = Tipocomprobante.denominacion_impresa.

    FIND TipocomprobanteAfip WHERE TipocomprobanteAfip.tip_comprob = Fac_header.tip_comprob AND TipocomprobanteAfip.cdg_circuito = "VE".
    RUN codificar( REPLACE(Empresa.cuit,"-","") + 
                   TipocomprobanteAfip.cdg_afip + 
                   STRING(Fac_header.prf_comprob,"9999") + 
                   Fac_header.cai + 
                   STRING(YEAR(Fac_header.rige_hasta) ,"9999") + STRING(MONTH(Fac_header.rige_hasta) ,"99") + STRING(DAY(Fac_header.rige_hasta) ,"99")
                   , OUTPUT  ttheader.CodigoBarra , OUTPUT  ttheader.LecturaHumana ).
    IF fac_header.nombre  BEGINS "CP." THEN ttheader.nombre = "CONSORCIO DE PROPIETARIOS".
    FOR EACH fac_detalle OF fac_header /* WHERE fac_detalle.precio <> 0 */ :
        CREATE ttdetalle.
        BUFFER-COPY fac_detalle TO ttdetalle NO-ERROR.
    END.
END.

xfile = SUBST('&1/cr-' + userid("sic") + ".xml" , SESSION:TEMP-DIRECTORY).
xfile = REPLACE(xfile,"/","\").
xfile = REPLACE(xfile,"\\","\").

DATASET dset:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).


FOR EACH Fac_header 
    WHERE Fac_header.cdg_empresa  = p-cdg_empresa
      AND Fac_header.prf_comprob  = p-prf_comprob
      AND Fac_header.nro_comprob  <= p-has_nrocomp
      AND Fac_header.nro_comprob  >= p-des_nrocomp:
    IF NOT CAN-DO(listaposible, Fac_header.tip_comprob) THEN NEXT.
    ASSIGN fac_header.impreso = "S".
END.
/*test
DEFINE VAR sal AS CHAR NO-UNDO.
RUN prfaa234eMR.p( "FA" ,3,1,1, "P", output sal).
*/
