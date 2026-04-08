/*ver el sp1 https://github.com/reingart/pyafipws/releases/tag/2.7.1872 */
/*https://groups.google.com/forum/#!forum/pyafipws*/
/*factura electronica*/
/*Obtiene el CAE para la factura solicitadas*/
/*si retorna ok el cae esta grabado sino dio un error y se debe detener el proceso*/
/*en caso de dar ERROR retorno en FALSE se debe mostrar el return-error*/
/*para debugguer mas complejos no olvidar el parametro AFLOG que indica el archivos de errores.*/
DEFINE INPUT PARAMETER pnro AS ROWID NO-UNDO.
DEFINE OUTPUT PARAMETER pok AS LOGICAL NO-UNDO.

DEFINE var pprf LIKE fac_header.prf_comprob NO-UNDO.
DEFINE VAR ptipo LIKE fac_header.tip_comprob NO-UNDO.
DEFINE VAR pdesde AS INT NO-UNDO.
DEFINE VAR phasta AS INT NO-UNDO.
DEF VAR ddd AS CHAR NO-UNDO.
DEFINE VAR  rok AS LOGICAL.
/*http://www.sistemasagiles.com.ar/trac/wiki/ManualPyAfipWs*/
/*https://code.google.com/p/pyafipws/source/browse/ejemplos/factura_electronica.php*/
{findempresa.i}
{VRSHARED.I NEW}
DEFINE VAR test AS LOGICAL INITIAL FALSE.
DEFINE VAR afwsfe AS CHARACTER NO-UNDO.
DEFINE VAR WSFEv1 AS COM-HANDLE NO-UNDO.
DEFINE VAR WSAA AS COM-HANDLE NO-UNDO.
DEFINE VAR tra AS LONGCHAR NO-UNDO.
DEFINE STREAM wserr .
DEFINE VAR lok AS LOGICAL NO-UNDO.
DEFINE VAR cacert AS CHARACTER NO-UNDO.
DEFINE VAR afcache AS CHARACTER NO-UNDO.
DEFINE VAR afproxy AS CHAR No-undo.
DEFINE VAR aflib AS CHAR NO-UNDO.
DEFINE VAR cbte_nro AS INT64 NO-UNDO.
DEFINE VAR ccbte_nro AS char NO-UNDO.
DEFINE VAR lcuit LIKE fac_header.cuit NO-UNDO.
DEFINE VAR afmaxv LIKE fac_header.imp_total.
DEFINE VAR cae AS CHAR NO-UNDO.
DEFINE VAR ta AS LONGCHAR NO-UNDO.
DEFINE VAR token AS CHAR NO-UNDO.
DEFINE VAR sign AS CHAR no-undo.
DEFINE VAR tipo_doc AS char NO-UNDO.
DEFINE VAR imponible AS DECIMAL  DECIMALS 2 NO-UNDO.
DEFINE VAR otros_trib AS DECIMAL  DECIMALS 2 NO-UNDO.
DEFINE VAR excento AS DECIMAL  DECIMALS 2 NO-UNDO.
DEFINE VAR printipo LIKE TipocomprobanteAFIP.cdg_afip NO-UNDO.
DEFINE TEMP-TABLE ttap
    FIELD cdg_afip LIKE TipocomprobanteAFIP.cdg_afip
    FIELD prf_cancela LIKE aplicacion_pagos.prf_cancela
    FIELD nro_cancela LIKE aplicacion_pagos.nro_cancela.
pok = FALSE.



FIND fac_header WHERE rowid(fac_header) = pnro.
IF fac_header.cai <> "" THEN LEAVE.
FIND punto-venta WHERE punto-venta.cdg_puntovta= fac_header.prf_comprob NO-LOCK.
RUN faceletoken.p (INPUT string(punto-venta.cdg_puntovta,"9999"),OUTPUT token, OUTPUT sign).
EMPTY TEMP-TABLE ttap.
/*fin parametros*/
FUNCTION nro RETURN CHAR ( n AS DECIMAL ):
    DEFINE VAR nn AS DECIMAL DECIMALS 2 NO-UNDO.
    nn = n.
    RETURN REPLACE( RIGHT-TRIM(trim(STRING(nn))) ,",",".").
END.

FUNCTION wserr RETURNS LOGICAL ( obj AS COM-HANDLE ):
    DEFINE VAR logf AS CHAR NO-UNDO.
    If obj:Excepcion <> "" THEN DO:
        RUN getparametro_c.p( "AFLOG" +  string(punto-venta.cdg_puntovta,"9999") , OUTPUT logf ).
        OUTPUT STREAM wserr TO VALUE(logf) APPEND.
        PUT STREAM wserr UNFORMATTED NOW SKIP.
        PUT STREAM wserr UNFORMATTED obj:Excepcion SKIP(2).
        PUT STREAM wserr UNFORMATTED obj:Traceback SKIP(2).
        PUT STREAM wserr UNFORMATTED obj:XmlRequest SKIP(2).
        PUT STREAM wserr UNFORMATTED obj:XmlResponse SKIP.
        PUT STREAM wserr UNFORMATTED "---------------------------------------" SKIP.
        OUTPUT STREAM wserr CLOSE.
        RETURN TRUE.
    END.
    RETURN FALSE.
END.
RUN getparametro_c.p( "AFWSFE"+   string(punto-venta.cdg_puntovta,"9999"), OUTPUT afwsfe ).
RUN getparametro_c.p( "AFCACHE"+   string(punto-venta.cdg_puntovta,"9999"), OUTPUT afcache ).
RUN getparametro_c.p( "AFPROXY"+   string(punto-venta.cdg_puntovta,"9999"), OUTPUT afproxy ).
RUN getparametro_c.p( "AFLIB"+   string(punto-venta.cdg_puntovta,"9999"), OUTPUT aflib).


/*FACTURA ELECTRONICA MERCADO INTERNO*/
CREATE "WSFEv1" WSFEv1.
WSFEv1:Token = token.
WSFEv1:Sign = sign.
WSFEv1:Cuit = replace(Punto-venta.cuit-real,"-","").

WSFEv1:LanzarExcepciones = true.
cacert = WSFEv1:InstallDir + "\conf\afip_ca_info.crt".
lok = WSFEv1:Conectar(afcache, afwsfe, afproxy, aflib, "") NO-ERROR.
IF wserr(WSFEv1) THEN RETURN WSFEv1:ObtenerTagXml("Code") + " " + WSFEv1:ObtenerTagXml("Msg").
    
WSFEv1:Dummy.
IF wserr(WSFEv1) THEN RETURN WSFEv1:ObtenerTagXml("Code") + " " + WSFEv1:ObtenerTagXml("Msg").

IF WSFEv1:AppServerStatus <> "OK" OR
   WSFEv1:DbServerStatus <> "OK" OR
   WSFEv1:AuthServerStatus <> "OK" THEN DO:
   RETURN "Problema en los servidores de la AFIP momentaneo intente mas tarde," +
       "appserver status" + WSFEv1:AppServerStatus +
       "dbserver status" + WSFEv1:DbServerStatus +
       "authserver status" + WSFEv1:AuthServerStatus .
END.

/*validar datos y tablas relacionadas*/
FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = fac_header.tip_comprob NO-LOCK  NO-ERROR.
IF NOT AVAILABLE tipocomprobanteAFIP THEN DO:
    return "Factura " + fac_header.tip_comprob + "-" + string(punto-venta.prf_real,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " No se encuentra tipo comprobante AFIP " + fac_header.tip_comprob.
END.
printipo = TipocomprobanteAFIP.cdg_afip.
FIND condicion_impos NO-LOCK OF fac_header.
IF NOT AVAILABLE condicion_impos THEN DO:
    RETURN "Factura " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " No se encuentra condicion impositiva".
END.

FIND moneda NO-LOCK OF fac_header.
IF NOT AVAILABLE moneda THEN DO:
    RETURN "Factura " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " No se encuentra moneda".
END.
FIND LAST cotizacion OF moneda NO-LOCK.

/*todo esta ok a facturar*/
/*
ccbte_nro = WSFEv1:CompUltimoAutorizado( int(tipocomprobanteAFIP.cdg_AFIP), fac_header.prf_comprob).
IF wserr(WSFEv1) THEN do:
    RETURN "Error al intentar obtener el ultimo comprobante procesado para tipo " + tipocomprobanteAFIP.cdg_AFIP + " PRF:" + string(fac_header.prf_comprob).
END.
/*MESSAGE ccbte_nro VIEW-AS ALERT-BOX ERROR.
*/
if ccbte_nro = "" THEN cbte_nro = 0.
ELSE cbte_nro = INT(ccbte_nro).
*/
cbte_nro = fac_header.nro_comprob - 1.
IF fac_header.nro_comprob <> cbte_nro + 1  THEN DO:
    RETURN "Factura " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " Debe resolver antes el comprobante " + fac_header.tip_comprob +  "-" +  string(fac_header.prf_comprob)  + "-" +  string(cbte_nro + 1,"99999999") +
         " para continuar" .
END.
/*MESSAGE " Pase :" ccbte_nro VIEW-AS ALERT-BOX ERROR.*/

IF fac_header.cuit = "" OR fac_header.cuit = "0" OR fac_header.cuit = "1" or
        fac_header.cod_docu = "NO" THEN DO:
   
    IF substring(fac_header.tip_comprob,2,1) = "A" THEN DO:
        return "Factura " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " Si es factura A debe tener CUIT valido" .
    END.
    ELSE DO:
         RUN getparametro_d.p("AFMAXV", OUTPUT afmaxv).
         IF fac_header.imp_total > AFMAXV THEN DO:
                RETURN "Factura " + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob,"9999") + "-" + string(fac_header.nro_comprob,"99999999") + " supera el valor maximo a Consumidor final sin CUIT" + 
                "Parametro AFMAXV=" + string(afmaxv).
         END.
    END.
    tipo_doc = "99".
    lcuit = "0".
END.
ELSE DO:
    FIND tipo_docu WHERE tipo_docu.cod_docu = fac_header.cod_docu NO-LOCK.
    tipo_doc = tipo_docu.cdg_afip.
    lcuit = replace(fac_header.cuit,"-","").
END.

imponible = 0.
otros_trib = 0.
excento = 0.
IF substring(fac_header.tip_comprob,2,1) = "C" THEN DO:
    imponible = Fac_header.imp_total.
END.
ELSE DO:
    FOR EACH fac_header_impuesto NO-LOCK OF fac_header, 
        impuesto NO-LOCK OF fac_header_impuesto :
        IF impuesto.es_iva THEN 
            imponible = imponible + Fac_header_impuesto.monto_imponible.
        ELSE
            otros_trib = otros_trib +  Fac_header_impuesto.importe.
    END.
    excento = fac_header.imp_total - fac_header.imp_iva - imponible.
    IF excento < 0 THEN excento = 0.
END.
lok = WSFEv1:CrearFactura( 2 /*1-bienes 2-servicios 3-bienes y servicios*/, 
                         tipo_doc /*tipo_doc*/, 
                         lcuit,
                         TipocomprobanteAFIP.cdg_afip /*tipo_cbte*/, 
                         punto-venta.prf_real /*punto_vta*/, 
                         string(fac_header.nro_comprob) /*cbt_desde*/, 
                         string(fac_header.nro_comprob) /*cbt_hasta*/, 
                         nro(fac_header.imp_total) /*imp_total*/,
                         "0" /*imp_tot_conc*/,
                         nro(imponible) /*imp_neto*/,
                         nro(fac_header.imp_iva) /*imp_iva*/,
                         nro(otros_trib) /*imp_trib*/,
                         nro(excento) /*op exento*/, 
                         string( YEAR( fac_header.fecha ) * 10000 + MONTH( fac_header.fecha )* 100 + DAY( fac_header.fecha ) , "99999999" ) /*fecha_cbte*/,
                         string( YEAR( fac_header.fecha ) * 10000 + MONTH( fac_header.fecha )* 100 + DAY( fac_header.fecha ) , "99999999" ) /*fecha_venc_pago*/ , 
                         string( YEAR( fac_header.fecha  ) * 10000 + MONTH( fac_header.fecha )* 100 + DAY( fac_header.fecha ) , "99999999" ) /*fecha_serv_desde*/, 
                         string( YEAR( fac_header.fecha ) * 10000 + MONTH( fac_header.fecha )* 100 + DAY( fac_header.fecha ) , "99999999" ) /*fecha_serv_hasta*/,
                         moneda.cdg_afip /*moneda_id*/, 
                         nro(cotizacion.cambio) /*moneda_ctz*/ ).


/*si es nota de credito agregar comprobante asociado*/
    IF fac_header.tip_comprob BEGINS "C" THEN DO:
        FOR EACH Aplicacion_pagos WHERE 
                 Aplicacion_pagos.cdg_empresa      = empresa.cdg_empresa AND
                 Aplicacion_pagos.tip_comprob      = fac_header.tip_comprob AND
                 Aplicacion_pagos.prf_comprob      = fac_header.prf_comprob AND 
                 Aplicacion_pagos.nro_comprob      = fac_header.nro_comprob NO-LOCK ,
                 FIRST tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = aplicacion_pagos.tip_cancela NO-LOCK:
            FIND ttap WHERE ttap.cdg_afip = TipocomprobanteAFIP.cdg_afip AND  ttap.prf_cancela = aplicacion_pagos.prf_cancela AND 
                ttap.nro_cancela = aplicacion_pagos.nro_cancela NO-ERROR.
            IF AVAILABLE ttap THEN NEXT.
                CREATE ttap.
                ASSIGN ttap.cdg_afip = TipocomprobanteAFIP.cdg_afip
                       ttap.prf_cancela = punto-venta.prf_real
                       ttap.nro_cancela = aplicacion_pagos.nro_cancela.
            lok = WSFEv1:AgregarCmpAsoc(TipocomprobanteAFIP.cdg_afip, aplicacion_pagos.prf_cancela, aplicacion_pagos.nro_cancela).
         
        END.
    END.

    FOR EACH fac_header_impuesto NO-LOCK OF fac_header, impuesto NO-LOCK OF fac_header_impuesto :
        IF NOT impuesto.es_iva THEN DO:
            lok = WSFEv1:AgregarTributo( impuesto.cdg_afip, 
                                        Impuesto.nombre, 
                                        nro(Fac_header_impuesto.monto_imponible),
                                        nro(Fac_header_impuesto.tasa), 
                                        nro(Fac_header_impuesto.importe) ).
        END.
        ELSE
            lok = WSFEv1:AgregarIva(impuesto.cdg_afip, 
                                   nro(Fac_header_impuesto.monto_imponible), 
                                   nro(Fac_header_impuesto.importe)).
    END.

    /*
    ' Agrego datos opcionales  Impuesto al Valor Agregado - Art.12 ("presunci??e no vinculaci??on la actividad gravada", F.8001):
    If tipo_cbte = 1 Then  ' solo para facturas A
        ok = WSFEv1.AgregarOpcional(5, "02")             ' IVA Excepciones (01: Locador/Prestador, 02: Conferencias, 03: RG 74, 04: Bienes de cambio, 05: Ropa de trabajo, 06: Intermediario).
        ok = WSFEv1.AgregarOpcional(61, "80")            ' Firmante Doc Tipo (80: CUIT, 96: DNI, etc.)
        ok = WSFEv1.AgregarOpcional(62, "20267565393")   ' Firmante Doc Nro
        ok = WSFEv1.AgregarOpcional(7, "01")             ' Car?er del Firmante (01: Titular, 02: Director/Presidente, 03: Apoderado, 04: Empleado)
    End If
    */
    /* Habilito reprocesamiento automático (predeterminado)*/
    WSFEv1:Reprocesar = True.
 
    /* Solicito CAE*/
    CAE = WSFEv1:CAESolicitar() NO-ERROR.
    lok = WSFEv1:AnalizarXml("XmlResponse").
    IF lok THEN DO:
        IF  WSFEv1:ObtenerTagXml("Resultado") = "A" THEN DO:
            cae = WSFEv1:ObtenerTagXml("CAE").
            fac_header.cai = cae. 
            ddd = WSFEv1:ObtenerTagXml("CAEFchVto").
            fac_header.rige_hasta = date( int(substring( ddd,5,2)), int(substring( ddd,7,2 )), int(substring( ddd ,1,4))).
            pok = TRUE.
        END.
        ELSE DO:
                pok = FALSE.
                RETURN WSFEv1:ObtenerTagXml("Code") + " " + WSFEv1:ObtenerTagXml("Msg").
        END.
    END.
    ELSE DO: 
        pok = FALSE.
        RETURN " No se pudo analizar resultado".
    END.


    /*message  "Resultado:" + WSFEv1:Resultado + " CAE: " + cae + " Venc: " + WSFEv1:Vencimiento + " Obs: " + WSFEv1:Obs.*/
    
    
    /*
    
    MESSAGE "cae:" WSFEv1:CAE SKIP "Msg:" WSFEv1:XmlResponse VIEW-AS ALERT-BOX ERROR.
    cae = WSFEv1:CompConsultar(printipo /*tipo_cbte*/, 
                               fac_header.prf_comprob /*punto_vta*/, 
                         string(fac_header.nro_comprob) /*numero cbt*/ ).

    
    lok = WSFEv1:AnalizarXml("XmlResponse").
    IF lok THEN DO:
        DEFINE VAR raa AS CHAR no-undo.
        raa = WSFEv1:ObtenerTagXml("Resultado").
        IF  raa = "A" THEN DO:
            fac_header.cai = WSFEv1:ObtenerTagXml("CodAutorizacion").
            ddd = WSFEv1:ObtenerTagXml("FchVto").
            fac_header.rige_hasta = date( int(substring( ddd,5,2)), int(substring( ddd,7,2 )), int(substring( ddd ,1,4))).
            pok = TRUE.
        END.
        ELSE DO:
            pok = FALSE.
            RETURN WSFEv1:ObtenerTagXml("Code") + " " + WSFEv1:ObtenerTagXml("Msg").
    END.
    END.
        */
    
    /*
    ' Muestro los eventos (mantenimiento programados y otros mensajes de la AFIP)
    For Each evento In WSFEv1.eventos:
        MsgBox evento, vbInformation, "Evento"
    Next
    
    ' Buscar la factura
    cae2 = WSFEv1.CompConsultar(tipo_cbte, punto_vta, cbte_nro)
    ControlarExcepcion WSFEv1

    Debug.Print "Fecha Comprobante:", WSFEv1.FechaCbte
    Debug.Print "Fecha Vencimiento CAE", WSFEv1.Vencimiento
    Debug.Print "Importe Total:", WSFEv1.ImpTotal
    Debug.Print "Resultado:", WSFEv1.Resultado
    
    If WSFEv1.Version >= "1.12a" Then
        ok = WSFEv1.AnalizarXml("XmlResponse")
        If ok Then
            Debug.Print "CAE:", WSFEv1.ObtenerTagXml("CodAutorizacion"), WSFEv1.CAE
            Debug.Print "CbteFch:", WSFEv1.ObtenerTagXml("CbteFch"), WSFEv1.FechaCbte
            Debug.Print "Moneda:", WSFEv1.ObtenerTagXml("MonId")
            Debug.Print "Cotizacion:", WSFEv1.ObtenerTagXml("MonCotiz")
            Debug.Print "DocTIpo:", WSFEv1.ObtenerTagXml("DocTipo")
            Debug.Print "DocNro:", WSFEv1.ObtenerTagXml("DocNro")
            
            ' ejemplos con arreglos (primer elemento = 0):
            Debug.Print "Primer IVA (alci id):", WSFEv1.ObtenerTagXml("Iva", "AlicIva", 0, "Id")
            Debug.Print "Primer IVA (importe):", WSFEv1.ObtenerTagXml("Iva", "AlicIva", 0, "Importe")
            Debug.Print "Segundo IVA (alic id):", WSFEv1.ObtenerTagXml("Iva", "AlicIva", 1, "Id")
            Debug.Print "Segundo IVA (importe):", WSFEv1.ObtenerTagXml("Iva", "AlicIva", 1, "Importe")
            Debug.Print "Primer Tributo (ds):", WSFEv1.ObtenerTagXml("Tributos", "Tributo", 0, "Desc")
            Debug.Print "Primer Tributo (importe):", WSFEv1.ObtenerTagXml("Tributos", "Tributo", 0, "Importe")
            Debug.Print "Segundo Tributo (ds):", WSFEv1.ObtenerTagXml("Tributos", "Tributo", 1, "Desc")
            Debug.Print "Segundo Tributo (importe):", WSFEv1.ObtenerTagXml("Tributos", "Tributo", 1, "Importe")
            Debug.Print "Tercer Tributo (ds):", WSFEv1.ObtenerTagXml("Tributos", "Tributo", 2, "Desc")
            Debug.Print "Tercer Tributo (importe):", WSFEv1.ObtenerTagXml("Tributos", "Tributo", 2, "Importe")
        Else
            ' hubo error, muestro mensaje
            Debug.Print WSFEv1.Excepcion
        End If
    End If
    
    If CAE = "" Then
        ' hubo error, no comparo
    ElseIf CAE <> cae2 Then
        MsgBox "El CAE de la factura no concuerdan con el recuperado en la AFIP!: " & CAE & " vs " & cae2
    Else
        MsgBox "El CAE de la factura concuerdan con el recuperado de la AFIP"
    End If

    Exit Sub
ManejoError:
    ' Si hubo error (tradicional, no controlado):
    
    ' Depuración (grabar a un archivo los detalles del error)
    fd = FreeFile
    Open "c:\error.txt" For Append As fd
    If Not WSAA Is Nothing Then
        If WSAA.Version >= "1.02a" Then
            Print #fd, WSAA.Excepcion
            Print #fd, WSAA.Traceback
            Print #fd, WSAA.XmlRequest
            Print #fd, WSAA.XmlResponse
            ' guardo mensaje de error para mostrarlo:
            Excepcion = WSAA.Excepcion
        End If
    End If
    If Not WSFEv1 Is Nothing Then
        If WSFEv1.Version >= "1.10a" Then
            Print #fd, WSFEv1.Excepcion
            Print #fd, WSFEv1.Traceback
            Print #fd, WSFEv1.XmlRequest
            Print #fd, WSFEv1.XmlResponse
            Print #fd, WSFEv1.DebugLog()
            ' guardo mensaje de error para mostrarlo:
            Excepcion = WSFEv1.Excepcion
        End If
    End If
    Close fd
    
    Debug.Print Err.Description            ' descripción error afip
    Debug.Print Err.Number - vbObjectError ' codigo error afip
    If Excepcion = "" Then                 ' si no tengo mensaje de excepcion
        Excepcion = Err.Description        ' uso el error de VB
    End If
    
    ' Mostrar el mensaje de error
    Select Case MsgBox(Excepcion, vbCritical + vbRetryCancel, "Error:" & Err.Number - vbObjectError & " en " & Err.Source)
        Case vbRetry
            Debug.Assert False
            Resume
        Case vbCancel
            Debug.Print Err.Description
    End Select
End Sub


*/

RELEASE OBJECT WSFEv1.







