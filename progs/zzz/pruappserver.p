DEFINE VARIABLE hAppSrv AS HANDLE  NO-UNDO.
DEFINE VARIABLE ret     AS LOGICAL NO-UNDO.
CREATE SERVER hAppSrv.
ret = hAppSrv:CONNECT("-S sicapsv1 -H server_nt") NO-ERROR.
IF NOT ret 
  THEN MESSAGE "Failed to connect to AppServer" VIEW-AS ALERT-BOX MESSAGE.
  ELSE MESSAGE "Like Yesterday Night"           VIEW-AS ALERT-BOX MESSAGE.
  



ret = hAppSrv:DISCONNECT().
DELETE OBJECT hAppSrv.
