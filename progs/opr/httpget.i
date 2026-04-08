/* httpget.i */
DEFINE STREAM outfile.
DEFINE VARIABLE vSocket AS HANDLE    NO-UNDO.
DEFINE VARIABLE wstatus AS LOGICAL   NO-UNDO.
DEFINE VARIABLE vStr    AS CHARACTER NO-UNDO.
DEFINE VARIABLE vBuffer AS MEMPTR    NO-UNDO.
DEFINE VARIABLE wloop   AS LOGICAL   NO-UNDO.

PROCEDURE UrlParser:
    DEFINE INPUT PARAMETER purl AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER phost AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER pport AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER ppath AS CHARACTER NO-UNDO.
    
    DEFINE VARIABLE vStr AS CHARACTER NO-UNDO.
    
    IF purl BEGINS "http://" THEN DO:
        vStr = SUBSTRING(purl, 8).
        phost = ENTRY(1, vStr, "/").
        IF NUM-ENTRIES(vStr, "/") = 1 THEN vStr = vStr + "/".
        ppath = SUBSTRING(vStr, INDEX(vStr,"/")).
        IF NUM-ENTRIES(phost, ":") > 1 THEN DO:
            pport = ENTRY(2, phost, ":").
            phost = ENTRY(1, phost, ":").
        END.
        ELSE DO:
            pport = "80".
        END.
    END.
    ELSE DO:
        phost = "".
        pport = "".
        ppath = purl.
    END.
END PROCEDURE.

PROCEDURE HTTPGet:
    DEFINE INPUT PARAMETER phost AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER pport AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER ppath AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER pfile AS CHARACTER NO-UNDO.
    
    wloop = YES.
    CREATE SOCKET vSocket.
    vSocket:SET-READ-RESPONSE-PROCEDURE ("readHandler",THIS-PROCEDURE).
    wstatus = vSocket:CONNECT("-H " + phost + " -S " + pport) NO-ERROR.
    
    IF wstatus = NO THEN DO:
        MESSAGE "Connection to http server:" phost "port" pport "is unavailable".
        DELETE OBJECT vSocket.
        RETURN.
    END.
    
    OUTPUT STREAM outfile TO VALUE(pfile) BINARY NO-CONVERT.

    vStr = "GET " + ppath + " HTTP/1.0" + chr(10) + "Host: " + phost + chr(10) + "Accept: */*" + chr(10) + chr(10) /*"~n~n~n"*/.
    SET-SIZE(vBuffer) = LENGTH(vStr) + 1.
    PUT-STRING(vBuffer,1) = vStr.
    vSocket:WRITE(vBuffer, 1, LENGTH(vStr)).
    SET-SIZE(vBuffer) = 0.
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
    vSocket:DISCONNECT().
    DELETE OBJECT vSocket.
    OUTPUT STREAM outfile CLOSE.
END PROCEDURE.

PROCEDURE readHandler:
    DEFINE VARIABLE l AS INTEGER NO-UNDO.
    DEFINE VARIABLE str AS CHARACTER NO-UNDO.
    DEFINE VARIABLE b AS MEMPTR NO-UNDO.

    IF SELF:CONNECTED() = FALSE THEN DO:
        APPLY 'CLOSE' TO THIS-PROCEDURE.
        RETURN.
    END.
    l = vSocket:GET-BYTES-AVAILABLE().
    IF l > 0 THEN DO:
        SET-SIZE(b) = l + 1.
        vSocket:READ(b, 1, l, 1).
        str = GET-STRING(b,1).
        PUT STREAM outfile CONTROL str.
        SET-SIZE(b) = 0.
        wloop = YES.
    END.
    ELSE DO:
        wloop = NO.
        OUTPUT STREAM outfile CLOSE.
    END.
END PROCEDURE.
