/* 
TABLAS DE LA BASE agregado del buscador inteligente de Ferver
*/
DEFINE STREAM xxx.
DEFINE VARIABLE c_word       AS CHARACTER  NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE hdlEdit AS WIDGET-HANDLE       NO-UNDO. /* Editor Handle */
DEFINE NEW GLOBAL SHARED VARIABLE preserve_hdlEdit AS LOGI       NO-UNDO. /* Store whether called from 'f4' or 'f5' */
DEFINE VAR encontrada AS CHAR NO-UNDO.
if not preserve_hdlEdit then
	hdlEdit = SELF:HANDLE.
else
	preserve_hdlEdit = no.
if not valid-handle(hdlEdit) then
	return no-apply.
c_word = hdlEdit:SELECTION-TEXT.
c_word = TRIM(c_word).
FILE-INFO:FILE-NAME = c_word.
 FILE-INFO:FULL-PATHNAME.
encontrada = FILE-INFO:FULL-PATHNAME.
IF encontrada = ? THEN DO:
    FILE-INFO:FILE-NAME =  c_word + ".p".
    encontrada = FILE-INFO:PATHNAME.
END.
IF encontrada = ? THEN DO:
    FILE-INFO:FILE-NAME =  c_word + ".w".
    encontrada = FILE-INFO:PATHNAME.
END.
IF encontrada = ? THEN DO:
    FILE-INFO:FILE-NAME =  c_word + ".i".
    encontrada = FILE-INFO:PATHNAME.
END.
IF encontrada <> ? THEN DO:
    OUTPUT STREAM xxx TO "CLIPBOARD".
    PUT STREAM xxx UNFORMATTED encontrada.
    OUTPUT STREAM xxx CLOSE.
END.
    ELSE
    MESSAGE c_word "No se encuentra en el PROPATH" VIEW-AS ALERT-BOX INFORMATION.

return no-apply.
