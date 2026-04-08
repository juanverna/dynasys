DEFINE VAR level AS INT INITIAL 2 no-undo.
DEFINE var stack AS ch column-label 'Self Object Info':c VIEW-AS editor size 75 by 18 SCROLLBAR-VERTICAL no-undo.
DEFINE VAR st AS ch no-undo.
DEFINE VAR st1 AS ch no-undo.
DEFINE VAR flname AS ch no-undo.

FORM 
	with frame a1q1s2w2 size 80 by 22 scrollable
		view-as dialog-box title "Detales - Se puede hacer cut&paste".
on window-close of frame a1q1s2w2
	apply 'end-error':u to frame a1q1s2w2.
		
st = 'FRAME-NAME: ' + self:frame-name no-error.
if st <> ? then stack = stack + st.
st = ''.
st1 = self:dbname + '.' no-error.
if st1 <> ? then st = st1.
st1 = self:table + '.' no-error.
if st1 <> ? then st = st + st1.
st1 = self:name no-error.
if st1 <> ? then st = st + st1.
if st <> ? then stack = stack + '~nNAME: ' + st.
st = '~nTYPE: ' + self:type no-error.
if st <> ? then stack = stack + st.
st = '~nFORMAT: ' + self:format no-error.
if st <> ? then stack = stack + st.
st = '~nLABEL: ' + self:label no-error.
if st <> ? then stack = stack + st.
st = '~nCOLUMN-LABEL: ' + string(self:column-label) no-error.
if st <> ? then stack = stack + st.
st = '~nPOSITION (CHARS): ' + string(self:row) + ' by ' + string(self:column).
if st <> ? then stack = stack + st.
IF CAN-QUERY(SELF,"index") THEN DO:
    st = '~nINDEX: ' + string(self:index).
    if st <> ? then stack = stack + st.
END.

stack = stack + '~n'.

REPEAT WHILE PROGRAM-NAME(level) <> ? and not PROGRAM-NAME(level) begins 'USER-INTERFACE-TRIGGER ':
	assign
		stack = stack + '~n' + program-name(level)
		flname = program-name(level)
		level = level + 1.
	assign
		flname = SUBSTR(flname,R-INDEX(flname,'~/') + 1)
		substr (flname, length(flname),1) = 'r' no-error.
	flname = search(flname).
	if flname = ? then assign
		flname = program-name(level - 1)
		flname = SUBSTR(flname,R-INDEX(flname,'~/') + 1)
		substr (flname, length(flname),1) = 'p' no-error.
	if flname <> ? then
		stack = stack + '~nRan from:~t' + flname.
END. /* repeat */
stack = trim(stack,'~n').
/* run Editable(stack,'   Self Object Info:'). */

disp stack with frame a1q1s2w2.
stack:read-only = yes.
prompt-for stack with frame a1q1s2w2. 
hide frame a1q1s2w2.
