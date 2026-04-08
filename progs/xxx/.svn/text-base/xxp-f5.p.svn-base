/*
campos de la base
agregado del buscador inteligende de Ferver

*/
DEFINE VARIABLE hdlSList  	 AS WIDGET-HANDLE. /* Selection List Handle*/
DEFINE VARIABLE hdlFrame  	 AS WIDGET-HANDLE. /* Dialog-Box Handle */
DEFINE VARIABLE chTemp 		 AS CHARACTER NO-UNDO. /*Temporary Character Variable */
DEFINE VARIABLE c_line       AS CHARACTER  NO-UNDO. /*Line in the Editor that is being edited*/
DEFINE VARIABLE c_word       AS CHARACTER  NO-UNDO.
DEFINE VARIABLE i_WordStart  AS INTEGER    NO-UNDO. /* Word Starting Position */
DEFINE VARIABLE i_Wordlength AS INTEGER    NO-UNDO. /* Word Length in Characters*/
DEFINE NEW GLOBAL SHARED VARIABLE hdlEdit AS WIDGET-HANDLE       NO-UNDO. /* Editor Handle */
DEFINE NEW GLOBAL SHARED VARIABLE preserve_hdlEdit AS LOGI       NO-UNDO. /* Store whether called from 'f4' or 'f5' */
DEFINE NEW GLOBAL SHARED VARIABLE xxglobal-f10	 AS CHARACTER    NO-UNDO. /* Store last returned DB */
DEFINE NEW GLOBAL SHARED VARIABLE xxglobal-f4	 AS CHARACTER    NO-UNDO. /* Store last returned Table */
DEFINE VAR hdlWord AS WIDGET-HANDLE.
hdlEdit = SELF:HANDLE.
if not valid-handle(hdlEdit) then
	return no-apply.
IF xxglobal-f10 = ? or xxglobal-f10 = '' then do:
	preserve_hdlEdit = yes.
	apply 'f10':u to default-window.
end.
IF xxglobal-f10 = ? or xxglobal-f10 = '' then
	return no-apply.
IF xxglobal-f4 = ? or xxglobal-f4 = '' then do:
	preserve_hdlEdit = yes.
	apply 'f4':u to default-window.
end.
IF xxglobal-f4 = ? or xxglobal-f4 = '' then
	return no-apply.
assign
    c_line = ENTRY(hdlEdit:CURSOR-LINE, hdlEdit:SCREEN-VALUE, CHR(10))
    c_line       = SUBSTRING(c_line, 1, hdlEdit:CURSOR-CHAR - 1)
    i_WordStart  = max( R-INDEX(c_line, " "),R-INDEX( substring( c_line , 1 , LENGTH(c_line) - 1 ), ".")) + 1
    i_WordLength = hdlEdit:CURSOR-CHAR - i_WordStart
    c_word = SUBSTRING(c_Line, i_WordStart, i_WordLength) no-error.

/* c_word = hdlEdit:SELECTION-TEXT. */
CREATE ALIAS DICTDB FOR DATABASE VALUE(xxglobal-f10) no-error.
for first dictdb._file WHERE dictdb._file._file-name = xxglobal-f4,
	first dictdb._field of dictdb._file WHERE dictdb._field._field-name begins c_word:
	leave.
end.
if not avail dictdb._field then
	return no-apply.

/*Create Dialog Box*/
CREATE DIALOG-BOX hdlFrame 
	ASSIGN HIDDEN = TRUE 
		X = 20
		Y = 20
		HEIGHT-CHARS = 12
		WIDTH-CHARS = 35
        TITLE-BGCOLOR = 14
        TITLE = dictdb._file._FILE-NAME.
if not valid-handle(hdlFrame) then
	return no-apply.
	
/*Create the Selection List */
CREATE SELECTION-LIST hdlSlist
	ASSIGN FRAME = hdlFrame
		WIDTH-CHARS = 33
		HEIGHT-CHARS = 10
		FONT = 5.
if not valid-handle(hdlSlist) then
	return no-apply.
CREATE FILL-IN hdlword
     ASSIGN FRAME = hdlFrame
        FORMAT =  "X(33)"
		WIDTH-CHARS = 33
		HEIGHT-CHARS = 1
        BGCOLOR = 14
		FONT = 5
       TRIGGERS:
       ON ANY-PRINTABLE
           DO:
             c_word =  hdlword:SCREEN-VALUE + CHR(LASTKEY).
             FIND FIRST dictdb._field of dictdb._file WHERE dictdb._field._field-name begins c_word NO-LOCK NO-ERROR.
             IF AVAILABLE dictdb._file THEN
             hdlSlist:SCROLL-TO-ITEM(dictdb._field._field-name).
           END.
       END TRIGGERS.

/*Add all table Fields to the Selection List */
FOR EACH dictdb._field of dictdb._file WHERE dictdb._field._field-name begins c_word:
	hdlSlist:ADD-LAST(dictdb._field._field-name).
END.

/*Enable the Dialog-Box and Field List */
ASSIGN   
   hdlFrame:HIDDEN = FALSE
   hdlSlist:SENSITIVE = TRUE.
hdlword:SENSITIVE = TRUE.
/*Set focus to the frame and selection list */
repeat:
	APPLY "ENTRY":U TO hdlSlist.
	WAIT-FOR 'GO':U,'RETURN':U,"END-ERROR":u,"WINDOW-CLOSE":u,'DEFAULT-ACTION':u OF hdlFrame.
	assign
		chTemp = (if can-do('GO,RETURN,DEFAULT-ACTION':U,last-event:function) then
				hdlSlist:SCREEN-VALUE
	 		 else
				'') no-error.
	leave.
end. /* repeat */
DELETE WIDGET hdlword hdlSlist hdlFrame.
APPLY "ENTRY":U TO hdlEdit.
IF chTemp = ? or chTemp = "" THEN
	return no-apply.

hdlEdit:INSERT-STRING(
	(if length(c_line) > 1 and substr(c_line,length(c_line) - 1, 1) <> '.' and substr(c_line,length(c_line), 1) = ' ' then ' ' else '') +
	substring(chTemp,length(c_word) + 1) + ' '
	) no-error.
return no-apply.
