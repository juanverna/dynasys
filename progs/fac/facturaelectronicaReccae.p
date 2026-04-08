/*factura electronica*/
/*buscar factura ya enviada*/

DEFINE VAR  rok AS LOGICAL.
/*http://www.sistemasagiles.com.ar/trac/wiki/ManualPyAfipWs*/
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
DEFINE VAR lcuit LIKE fac_header.cuit NO-UNDO.

DEFINE VAR cae AS CHAR NO-UNDO.
DEFINE VAR ta AS LONGCHAR NO-UNDO.
DEFINE VAR token AS CHAR NO-UNDO.
DEFINE VAR sign AS CHAR no-undo.
DEFINE VAR aa AS INT LABEL "Numero" NO-UNDO.
DEFINE VAR bb AS char LABEL "Fipo" NO-UNDO.


FOR EACH fac_header WHERE fac_header.cdg_empresa = empresa.cdg_empresa AND 
    ( fac_header.prf_comprob = 3 OR fac_header.prf_comprob = 64 ) AND ((LENGTH( cai ) < 5 OR cai = ? ) OR fac_header.rige_hasta = ? )BY nro_comprob :
    DISPLAY nro_comprob prf_comprob.
    PAUSE 2.
    FIND punto-venta WHERE punto-venta.cdg_puntovta= fac_header.prf_comprob NO-LOCK.
RUN faceletoken.p (INPUT string(punto-venta.prf_real,"9999"),OUTPUT token, OUTPUT sign).    
/*fin parametros*/

FUNCTION wserr RETURNS LOGICAL ( obj AS COM-HANDLE ):
    DEFINE VAR logf AS CHAR NO-UNDO.
    If obj:Excepcion <> "" THEN DO:
        RUN getparametro_c.p( "AFLOG" + STRING( punto-venta.prf_real,"9999"), OUTPUT logf ).
        OUTPUT STREAM wserr TO VALUE(logf) APPEND.
        PUT STREAM wserr UNFORMATTED NOW SKIP.
        PUT STREAM wserr UNFORMATTED obj:Excepcion SKIP.
        PUT STREAM wserr UNFORMATTED obj:Traceback SKIP.
        PUT STREAM wserr UNFORMATTED obj:XmlRequest SKIP.
        PUT STREAM wserr UNFORMATTED obj:XmlResponse SKIP.
        OUTPUT STREAM wserr CLOSE.
        MESSAGE "Ha ocurrido un error" SKIP obj:Excepcion VIEW-AS ALERT-BOX ERROR.
        RETURN TRUE.
    END.
    RETURN FALSE.
END.
RUN getparametro_c.p( "AFWSFE" + STRING( punto-venta.prf_real,"9999") , OUTPUT afwsfe ).
RUN getparametro_c.p( "AFCACHE" + STRING( punto-venta.prf_real,"9999") , OUTPUT afcache ).
RUN getparametro_c.p( "AFPROXY" + STRING( punto-venta.prf_real,"9999") , OUTPUT afproxy ).
RUN getparametro_c.p( "AFLIB" + STRING( punto-venta.prf_real,"9999") , OUTPUT aflib).


/*FACTURA ELECTRONICA MERCADO INTERNO*/
CREATE "WSFEv1" WSFEv1.
WSFEv1:Token = token.
WSFEv1:Sign = sign.
WSFEv1:Cuit = replace(empresa.cuit,"-","").
    
WSFEv1:LanzarExcepciones = FALSE.
cacert= WSFEv1:InstallDir + "\conf\afip_ca_info.crt".
lok = WSFEv1:Conectar(afcache, afwsfe, afproxy, aflib, "") NO-ERROR.
IF wserr(WSFEv1) THEN LEAVE.
    
/*WSFEv1:Dummy.
IF wserr(WSFEv1) THEN LEAVE.

IF WSFEv1:AppServerStatus <> "OK" OR
   WSFEv1:DbServerStatus <> "OK" OR
   WSFEv1:AuthServerStatus <> "OK" THEN DO:
   MESSAGE "Problema en los servidores de la AFIP momentaneo intente mas tarde" skip
       "appserver status" WSFEv1:AppServerStatus SKIP
       "dbserver status" WSFEv1:DbServerStatus SKIP
       "authserver status" WSFEv1:AuthServerStatus VIEW-AS ALERT-BOX INFORMATION.
END.  */
   FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = fac_header.tip_comprob NO-LOCK  NO-ERROR.
IF NOT AVAILABLE tipocomprobanteAFIP THEN DO:
    MESSAGE "No se encuentra tipo comprobante AFIP " fac_header.tip_comprob
        VIEW-AS ALERT-BOX ERROR.
    LEAVE.
END.

DEF VAR aanro AS INT.
aanro = WSFEv1:CompUltimoAutorizado(TipocomprobanteAFIP.cdg_afip, 3).

    cae = WSFEv1:CompConsultar(TipocomprobanteAFIP.cdg_afip /*tipo_cbte*/, 
                               punto-venta.prf_real /*punto_vta*/, 
                         string(fac_header.nro_comprob) /*numero cbt*/ ).
/*OUTPUT TO c:\temp\vererror.txt.    
PUT UNFORMATTED  WSFEv1:Excepcion SKIP(1) "##########################" SKIP(1).
PUT UNFORMATTED WSFEv1:Traceback SKIP(1) "##########################" SKIP(1).
PUT UNFORMATTED WSFEv1:XmlRequest SKIP(1) "##########################" SKIP(1).
PUT UNFORMATTED WSFEv1:XmlResponse SKIP(1) "##########################" SKIP(1).*/
    DEF VAR ddd AS CHAR NO-UNDO.
    lok = WSFEv1:AnalizarXml("XmlResponse").
     IF lok THEN DO:
    IF WSFEv1:ObtenerTagXml("Resultado") = "A" THEN DO:
        fac_header.cai = WSFEv1:ObtenerTagXml("CodAutorizacion").
        ddd = WSFEv1:ObtenerTagXml("FchVto").
        fac_header.rige_hasta = date( int(substring( ddd,5,2)), int(substring( ddd,7,2 )), int(substring( ddd ,1,4))).
    END.
 END.
    DEF VAR ttemp AS CHAR.
    ttemp = (IF lok THEN WSFEv1:ObtenerTagXml("DocTipo") ELSE "") + '/' + (IF lok THEN WSFEv1:ObtenerTagXml("DocNro") ELSE "").
    MESSAGE "Ultimo numero" aanro SKIP 
        ttemp 
        "Fecha Comprobante:" WSFEv1:ObtenerTagXml("CbteFch") SKIP
     "Fecha Vencimiento CAE" WSFEv1:ObtenerTagXml("FchVto") SKIP
     "Importe Total:" WSFEv1:ObtenerTagXml("ImpTotal") SKIP
        "CAE:" WSFEv1:ObtenerTagXml("CodAutorizacion")
     "Resultado:" WSFEv1:ObtenerTagXml("Resultado") VIEW-AS ALERT-BOX.

    /*
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




END.


