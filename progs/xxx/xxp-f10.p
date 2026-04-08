DEFINE VARIABLE hdlSList  	 AS WIDGET-HANDLE. /* Selection List Handle*/
DEFINE VARIABLE hdlFrame  	 AS WIDGET-HANDLE. /* Dialog-Box Handle */
DEFINE VARIABLE chTemp 		 AS CHARACTER NO-UNDO. /*Temporary Character Variable */
DEFINE VARIABLE c_line       AS CHARACTER  NO-UNDO. /*Line in the Editor that is being edited*/
DEFINE VARIABLE c_word       AS CHARACTER  NO-UNDO.
DEFINE VARIABLE i_WordStart  AS INTEGER    NO-UNDO. /* Word Starting Position */
DEFINE VARIABLE i_Wordlength AS INTEGER    NO-UNDO. /* Word Length in Characters*/
DEFINE VARIABLE i_dbs 		 AS INTEGER    NO-UNDO. /* Loop index through DBs*/
DEFINE NEW GLOBAL SHARED VARIABLE hdlEdit AS WIDGET-HANDLE       NO-UNDO. /* Editor Handle */
DEFINE NEW GLOBAL SHARED VARIABLE preserve_hdlEdit AS LOGI       NO-UNDO. /* Store whether called from 'f4' or 'f5' */
DEFINE NEW GLOBAL SHARED VARIABLE xxglobal-f10	 AS CHARACTER    NO-UNDO. /* Store last returned Table */
DEFINE NEW GLOBAL SHARED VARIABLE xxglobal-f4	 AS CHARACTER    NO-UNDO. /* Store last returned Table */

IF NUM-DBS = 0 THEN
	return no-apply.
if not preserve_hdlEdit then
	hdlEdit = SELF:HANDLE.
else
	preserve_hdlEdit = no.
if not valid-handle(hdlEdit) then
	return no-apply.
assign
	c_line = ENTRY(hdlEdit:CURSOR-LINE, hdlEdit:SCREEN-VALUE, CHR(10))
	c_line       = TRIM(SUBSTRING(c_line, 1, hdlEdit:CURSOR-CHAR - 1))
	i_WordStart  = max(R-INDEX(c_line, " "),R-INDEX(c_line, ".")) + 1
	i_WordLength = hdlEdit:CURSOR-CHAR - i_WordStart
	c_word = SUBSTRING(c_Line, i_WordStart, i_WordLength) no-error.

/*Create Dialog Box*/
CREATE DIALOG-BOX hdlFrame 
	ASSIGN HIDDEN = TRUE 
		X = 20
		Y = 20
		HEIGHT-CHARS = 12
		WIDTH-CHARS = 26
		BGCOLOR = ?
		FGCOLOR = ?
		TITLE = "Base Datos".
if not valid-handle(hdlFrame) then
	return no-apply.
		
/*Create the Selection List */
CREATE SELECTION-LIST hdlSlist
	ASSIGN FRAME = hdlFrame
		WIDTH-CHARS = 24
		HEIGHT-CHARS = 10
		BGCOLOR = ?
		FGCOLOR = ?
		FONT = 5.
if not valid-handle(hdlSlist) then
	return no-apply.
	
do i_dbs = 1 to num-dbs:
	hdlSlist:ADD-LAST(LDBNAME(i_dbs)).
end. /* do */

/*Enable the Dialog-Box and Field List */
ASSIGN   
   hdlFrame:HIDDEN = FALSE
   hdlSlist:SENSITIVE = TRUE.
/*Set focus to the frame and selection list */
APPLY "ENTRY":U TO hdlSlist.
repeat:
	WAIT-FOR 'GO':U,'RETURN':U,"END-ERROR":u,"WINDOW-CLOSE":u,'DEFAULT-ACTION':u OF hdlFrame.
	assign chTemp = (if can-do('GO,RETURN,DEFAULT-ACTION':U,last-event:function) then
				hdlSlist:SCREEN-VALUE
	 		 else
				'') no-error.
	leave.
end.
DELETE WIDGET hdlSlist hdlFrame.
APPLY "ENTRY":U TO hdlEdit.

if chTemp = ? or chTemp = '' or xxglobal-f10 = chTemp then
	return no-apply.
assign
	xxglobal-f4 = ''
	xxglobal-f10 = chTemp.
return no-apply.
