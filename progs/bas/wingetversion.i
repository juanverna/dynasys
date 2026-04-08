{windows.i}

FUNCTION WINGetVersion RETURNS CHARACTER () :
/*-----------------------------------------------------------------------------
  Purpose: Calls the WINAPI function GetVersionExA to determine the version
           of the Windows operating system that is running on the machine.
    Notes: Returns "95" for Windows 95, "98" for Windows 98, "NT" for Windows NT
           Returns "undef" if unable to determine platform.
------------------------------------------------------------------------------*/
 
    DEF VAR v_version-buf AS MEMPTR.
    DEF VAR v_platform-id AS INTEGER NO-UNDO.
    DEF VAR v_platform-desc AS CHAR NO-UNDO.
    DEF VAR v_major-version AS INTEGER NO-UNDO.
    DEF VAR v_minor-version AS INTEGER NO-UNDO.
    DEF VAR v_return-value  AS INTEGER NO-UNDO.
 
    SET-SIZE(v_version-buf)   = 148.
    PUT-LONG(v_version-buf,1) = 148.
 
    RUN GetVersionExA IN HpApi (INPUT GET-POINTER-VALUE(v_version-buf),
                       OUTPUT v_return-value).
 
    v_platform-id = GET-LONG(v_version-buf,17).
 
    CASE v_platform-id:
        WHEN 1 THEN DO:
            v_minor-version = GET-BYTE(v_version-buf,15).
            v_major-version = GET-BYTE(v_version-buf,16).
        END.
        OTHERWISE DO:
            v_major-version = GET-LONG(v_version-buf,5).
            v_minor-version = GET-LONG(v_version-buf,9).
        END.
    END.
 
    CASE v_platform-id:
        WHEN 0 THEN v_platform-desc = "3.1".
        WHEN 1 THEN
        DO:
            IF v_minor-version EQ 0 THEN v_platform-desc = "95".
            ELSE IF v_minor-version GT 0 THEN v_platform-desc = "98".
            ELSE v_platform-desc = "undef".
        END.
        WHEN 2 THEN
            v_platform-desc = "NT".
        OTHERWISE
            v_platform-desc = "undef".
    END.
 
    SET-SIZE(v_version-buf) = 0.
 
    RETURN v_platform-desc.
 
END FUNCTION.

MESSAGE WINGetVersion() VIEW-AS ALERT-BOX MESSAGE.
