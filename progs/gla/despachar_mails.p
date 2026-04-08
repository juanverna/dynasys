DEFINE INPUT  PARAMETER p-mailto     AS CHARACTER.
DEFINE INPUT  PARAMETER p-mailsubjet AS CHARACTER.
DEFINE INPUT  PARAMETER p-mailtext   AS CHARACTER.
DEFINE INPUT  PARAMETER p-mailfiles  AS CHARACTER.
DEFINE INPUT  PARAMETER p-maildialog AS INTEGER.

DEFINE VARIABLE retCode    AS INTEGER NO-UNDO.

    RUN mail( INPUT  p-mailto,
              INPUT  p-mailsubjet,
              INPUT  p-mailtext,
              INPUT  p-mailfiles,
              INPUT  p-maildialog,
              OUTPUT retCode).

    IF retCode <> 0 THEN MESSAGE "Error nùmero:" retCode VIEW-AS ALERT-BOX INFO TITLE "Error de mail".

PROCEDURE mail EXTERNAL "xpMail.dll":
    DEFINE INPUT  PARAMETER mailto		    AS CHAR.
    DEFINE INPUT  PARAMETER mailsubject		AS CHAR.
    DEFINE INPUT  PARAMETER mailText		AS CHAR.
    DEFINE INPUT  PARAMETER mailFiles		AS CHAR.
    DEFINE INPUT  PARAMETER mailDialog		AS LONG.
    DEFINE OUTPUT PARAMETER retCode		    AS LONG.
END.
