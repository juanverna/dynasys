{windows.i}
 
DEF VAR lpVersionInfo AS MEMPTR.
DEF VAR dwPlatformID AS INTEGER NO-UNDO.
DEF VAR chPlatformID AS CHAR NO-UNDO.
DEF VAR BuildNumber AS INTEGER NO-UNDO.
DEF VAR MajorVersion AS INTEGER NO-UNDO.
DEF VAR MinorVersion AS INTEGER NO-UNDO.
DEF VAR ReturnValue  AS INTEGER NO-UNDO.
 
SET-SIZE(lpVersionInfo)   = 148.
PUT-LONG(lpVersionInfo,1) = 148.
RUN GetVersionExA IN hpApi( GET-POINTER-VALUE(lpVersionInfo), 
                            OUTPUT ReturnValue).
dwPlatformID = GET-LONG(lpVersionInfo,17).
 
CASE dwPlatformID :
  WHEN 0 THEN chPlatformID = "Win32s on Windows 3.1".
  WHEN 1 THEN chPlatformID = "Win32 on Windows 95 or 98".
  WHEN 2 THEN chPlatformID = "Win32 on Windows NT".
END.        
 
CASE dwPlatformID :
  WHEN 1 THEN BuildNumber = GET-SHORT(lpVersionInfo,13).
  WHEN 2 THEN BuildNumber = GET-LONG (lpVersionInfo,13).
  /* what about 'when 0' for 3.1 with win32s ?? */
END.
 
/* You have Windows 95 OSR 2 if:
     dwPlatformID=1
         and 
     LOWORD(BuildNumber)=1111 (probably hex??)
   Unfortunately I have not had a chance to test that.
*/
 
CASE dwPlatformID :
  WHEN 1 THEN DO:
                 MinorVersion = GET-BYTE(lpVersionInfo,15).
                 MajorVersion = GET-BYTE(lpVersionInfo,16).
              END.
  OTHERWISE DO:
                 MajorVersion = GET-LONG(lpVersionInfo, 5).
                 MinorVersion = GET-LONG(lpVersionInfo, 9).
              END.
END.
 
MESSAGE "MajorVersion=" MajorVersion SKIP
        "MinorVersion=" MinorVersion SKIP
        "BuildNumber="  BuildNumber SKIP
        "PlatformID="   chPlatFormId SKIP
        "CSDversion="   GET-STRING(lpVersionInfo,21) SKIP(2)
        "on NT, CSDversion contains version of latest Service Pack" SKIP
        "on 95/98, CSDversion contains arbitrary extra info, if any"
        VIEW-AS ALERT-BOX.
 
SET-SIZE(lpVersionInfo) = 0.
