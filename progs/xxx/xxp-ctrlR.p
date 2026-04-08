&if '{&op_sys}' = 'WIN32' &then
	&scoped-define pathSep '~\'
&else
	&scoped-define pathSep '~/'
&endif
define new global shared var global_user_lang_dir as ch.

if search("gpmnsub.p") <> ? or search(global_user_lang_dir + "gp" + {&pathSep} + "gpmnsub.r") <> ? then do:
	CREATE WIDGET-POOL.
	run gpmnsub.p no-error.
	DELETE WIDGET-POOL.
end.
