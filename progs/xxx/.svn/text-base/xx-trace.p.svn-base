DEFINE VARIABLE i     AS INTEGER.
DEFINE VARIABLE plist AS CHARACTER FORMAT "x(70)".
DEFINE VARIABLE hdlFrame  	 AS WIDGET-HANDLE. /* Dialog-Box Handle */
DEFINE VARIABLE hdlSList  	 AS WIDGET-HANDLE. /* Selection List Handle*/
/*Create Dialog Box*/
CREATE DIALOG-BOX hdlFrame 
	ASSIGN HIDDEN = TRUE 
		X = 20
		Y = 20
		HEIGHT-CHARS = 12
		WIDTH-CHARS = 75
        TITLE-BGCOLOR = 14
		TITLE = "Trace de Programas".

if not valid-handle(hdlFrame) then
	return no-apply.

CREATE SELECTION-LIST hdlSlist
	ASSIGN FRAME = hdlFrame
        Y = 20
		WIDTH-CHARS = 69
		HEIGHT-CHARS = 9
		FONT = 5
    TRIGGERS:
       ON CHOOSE
           DO:
              MESSAGE "HOLA".
           END.
    END TRIGGERS.
.
if not valid-handle(hdlSlist) then
	return no-apply.

i = 2. /* Skip the current routine: PROGRAM-NAME(1) */
DO WHILE PROGRAM-NAME(i) <> ?:
   hdlSlist:ADD-LAST( string(i - 2) + ":" + PROGRAM-NAME(i) ).
   i = i + 1.
END.
ASSIGN   
   hdlFrame:HIDDEN = FALSE
   hdlSlist:SENSITIVE = TRUE.

repeat:
	APPLY "ENTRY":U TO hdlSlist.
	WAIT-FOR 'GO':U,'RETURN':U,"END-ERROR":u,"WINDOW-CLOSE":u,'DEFAULT-ACTION':u OF hdlFrame.
	leave.
end. /* repeat */

DELETE WIDGET hdlSlist hdlFrame.
