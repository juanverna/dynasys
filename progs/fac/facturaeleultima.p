/*factura electronica*/
/*devuelve el ultimo nomero de comprobante validado por la afip segun el tipo*/
/*http://www.sistemasagiles.com.ar/trac/wiki/ManualPyAfipWs*/
{findempresa.i}
{VRSHARED.I NEW}

DEFINE INPUT PARAMETER ptipo LIKE tipocomprobanteAFIP.tip_comprob NO-UNDO.
DEFINE INPUT PARAMETER pprf LIKE fac_header.prf_comprob NO-UNDO.
DEFINE OUTPUT PARAMETER ultnro AS INT64 NO-UNDO.

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
DEFINE VAR afmaxv LIKE fac_header.imp_total.
DEFINE VAR cae AS CHAR NO-UNDO.
DEFINE VAR ta AS LONGCHAR NO-UNDO.

/*van a ser parametros despues*/
DEFINE VAR token AS CHAR NO-UNDO.
DEFINE VAR sign AS CHAR no-undo.
RUN faceletoken.p (OUTPUT token, OUTPUT sign).

    
/*fin parametros*/

FUNCTION wserr RETURNS LOGICAL ( obj AS COM-HANDLE ):
    DEFINE VAR logf AS CHAR NO-UNDO.
    If obj:Excepcion <> "" THEN DO:
        RUN getparametro_c.p( "AFLOG", OUTPUT logf ).
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
RUN getparametro_c.p( "AFWSFE", OUTPUT afwsfe ).
RUN getparametro_c.p( "AFCACHE", OUTPUT afcache ).
RUN getparametro_c.p( "AFPROXY", OUTPUT afproxy ).
RUN getparametro_c.p( "AFLIB", OUTPUT aflib).


/*FACTURA ELECTRONICA MERCADO INTERNO*/
CREATE "WSFEv1" WSFEv1.

WSFEv1:Token = token.
WSFEv1:Sign = sign.
WSFEv1:Cuit = replace(empresa.cuit,"-","").
    
WSFEv1:LanzarExcepciones = TRUE.
cacert = WSFEv1:InstallDir + "\conf\afip_ca_info.crt".
lok = WSFEv1:Conectar(afcache, afwsfe, afproxy, aflib, cacert) NO-ERROR.
IF wserr(WSFEv1) THEN LEAVE.
    
WSFEv1:Dummy.
IF wserr(WSFEv1) THEN LEAVE.

IF WSFEv1:AppServerStatus <> "OK" OR
   WSFEv1:DbServerStatus <> "OK" OR
   WSFEv1:AuthServerStatus <> "OK" THEN DO:
   MESSAGE "Problema en los servidores de la AFIP momentaneo intente mas tarde" skip
       "appserver status" WSFEv1:AppServerStatus SKIP
       "dbserver status" WSFEv1:DbServerStatus SKIP
       "authserver status" WSFEv1:AuthServerStatus VIEW-AS ALERT-BOX INFORMATION.
END.
/*validar datos y tablas relacionadas*/

FIND tipocomprobanteAFIP WHERE tipocomprobanteAFIP.tip_comprob = ptipo NO-LOCK  NO-ERROR.
IF NOT AVAILABLE tipocomprobanteAFIP THEN DO:
    MESSAGE "No se encuentra tipo comprobante AFIP " ptipo
        VIEW-AS ALERT-BOX ERROR.
    LEAVE.
END.
ultnro = WSFEv1:CompUltimoAutorizado(tipocomprobanteAFIP.cdg_afip, pprf).


RELEASE OBJECT WSFEv1.







