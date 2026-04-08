/*genera token para acceder a servicios AFIP*/
/*http://www.sistemasagiles.com.ar/trac/wiki/ManualPyAfipWs*/
{findempresa.i}
DEFINE INPUT  PARAMETER prfreal AS CHAR no-undo.
DEFINE OUTPUT PARAMETER token AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER sign AS CHAR NO-UNDO.

DEFINE VAR afwpaa AS CHARACTER NO-UNDO.
DEFINE VAR WSAA AS COM-HANDLE NO-UNDO.
DEFINE VAR afcert AS CHAR NO-UNDO.
DEFINE VAR afkey AS CHAR NO-UNDO.
DEFINE VAR tra AS CHAR NO-UNDO.
DEFINE VAR dafcert AS CHAR NO-UNDO.
DEFINE VAR dafkey AS CHAR NO-UNDO.
DEFINE VAR cc AS CHAR FORMAT "x(70)" NO-UNDO.
DEFINE VAR cms AS CHAR NO-UNDO.
DEFINE STREAM lec.
DEFINE STREAM wserr .
DEFINE VAR cacert AS CHARACTER NO-UNDO.
DEFINE VAR lok AS LOGICAL NO-UNDO.
DEFINE VAR afcache AS CHARACTER NO-UNDO.
DEFINE VAR afproxy AS CHAR No-undo.
DEFINE VAR aflib AS CHAR NO-UNDO.
DEFINE VAR afttl AS INT NO-UNDO.
DEFINE VAR afhora AS CHAR NO-UNDO.
DEFINE VAR dc AS CHAR NO-UNDO.

DEFINE var ta AS LONGCHAR.

FUNCTION wserr RETURNS LOGICAL ( obj AS COM-HANDLE ):
    DEFINE VAR logf AS CHAR NO-UNDO.
    If obj:Excepcion <> "" THEN DO:
        RUN getparametro_c.p( "AFLOG" + prfreal, OUTPUT logf ).
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
RUN getparametro_c.p( "AFHORA" + prfreal, OUTPUT afhora). /*contiene la fecha de expiracion del ultimo valido*/

IF DATETIME(afhora) > NOW THEN DO: /*un margen de seguridad de 30 segundos*/
        RUN getparametro_c.p( "AFTOKEN" + prfreal, OUTPUT token).
        RUN getparametro_c.p( "AFSIGN" + prfreal, OUTPUT sign).
        RETURN "OK". /*no esta expirado salir directamente*/.
END.
/*pedimos otro nuevo*/
RUN getparametro_c.p( "AFWPAA" + prfreal, OUTPUT afwpaa ).
RUN getparametro_c.p( "AFCERT" + prfreal, OUTPUT afcert ).
RUN getparametro_c.p( "AFKEY" + prfreal, OUTPUT afkey ).
RUN getparametro_c.p( "AFCACHE" + prfreal, OUTPUT afcache ).
RUN getparametro_c.p( "AFPROXY" + prfreal, OUTPUT afproxy ).
RUN getparametro_c.p( "AFLIB" + prfreal, OUTPUT aflib).
RUN getparametro_n.p( "AFTTL" + prfreal, OUTPUT afttl).
CREATE "WSAA" WSAA.
tra = WSAA:CreateTRA("wsfe",afttl) NO-ERROR.
IF wserr(WSAA) THEN return error.
/*lectura de certfi y claves*/
INPUT STREAM lec FROM value(afcert)  BINARY NO-ECHO.
REPEAT:
    IMPORT  STREAM lec UNFORMATTED cc  .
    dafcert = dafcert + cc + CHR(10).
END.
/*UPDATE dafcert VIEW-AS EDITOR LARGE SIZE 70 BY 40 WITH FRAME aa WIDTH 95.*/
INPUT STREAM lec CLOSE.

INPUT STREAM lec FROM value(afkey)  BINARY NO-ECHO.
REPEAT:
    IMPORT STREAM lec UNFORMATTED cc.
    dafkey = dafkey + cc + CHR(10).
END.
dafkey = dafkey +  CHR(10).
INPUT STREAM lec CLOSE.

cms = WSAA:SignTRA(tra, dafcert ,dafkey ) NO-ERROR.
IF wserr(WSAA) THEN return error.
cacert = WSAA:InstallDir + "\conf\afip_ca_info.crt". /* certificado de la autoridad de certificante*/

lok = WSAA:Conectar(afcache, afwpaa, afproxy, aflib, "" ) NO-ERROR.
IF wserr(WSAA) THEN return error.
ta = WSAA:LoginCMS(cms) NO-ERROR.
IF wserr(WSAA) THEN return error.
dc = WSAA:ObtenerTagXml("expirationTime").
dc = SUBSTRING(dc,9,2) + "-" + SUBSTRING(dc,6,2) + "-" + SUBSTRING(dc,1,4) + " " + SUBSTRING(dc,12).
RUN setparametro.p("AFHORA" + prfreal,dc,0,TRUE,0,"" ).
token = WSAA:token.
sign = WSAA:Sign.
RUN setparametro.p("AFTOKEN" + prfreal ,token,0,TRUE,0,"" ).
RUN setparametro.p("AFSIGN" + prfreal ,sign,0,TRUE,0,"" ).
RELEASE OBJECT WSAA.
RETURN "OK".


