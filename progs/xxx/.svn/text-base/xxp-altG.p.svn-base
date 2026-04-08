if search("adeedit\_proedit.r") <> ? then do:
	def var return-save-state as logical no-undo.
	def var save-frame as widget-handle no-undo.
	def var save-window as widget-handle no-undo. 
	assign
		save-frame = self:frame
		save-window = current-window
		return-save-state = session:data-entry-return.
	run "adeedit\_proedit.r" ("", "").
	assign
		session:data-entry-return = return-save-state
		current-window = save-window.
	if valid-handle(save-window) then
		apply 'entry':u to save-window.
	view save-frame.
end. /* if search */
