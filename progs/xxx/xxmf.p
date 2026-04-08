/**** xxmf.p **
Author: Yuval Papish
MFG Version: All
Description: Adding functionality to MFG and Progress devlopers
Details:
  Alt-g (Unix: Esc-g): Open Progress editor from anywhere
  Ctrl-f: An advanced Ctrl-f from anywhere
  Ctrl-r: Ctrl-r from anywhere
  Alt-d (Unix: Esc-d): Open Progress DB Dictionary from anywhere
  F10: Choose a connected DB
  F4: Choose a table from F10 DB, and insert the table name to editor
  F5: Choose a field from F4 DB, and insert the field name to editor
  
  F10,F4,F5 can used on partial names, so that only names that begins with the already typed characters would appear.
  
***********/
&if '{&op_sys}' = 'WIN32' &then
	&scoped-define AltEsc Alt
&else
	&scoped-define AltEsc Esc
&endif
	
ON "{&AltEsc}-G":u ANYWHERE persistent run xxp-altG.p.
ON "{&AltEsc}-F":u ANYWHERE persistent run xxp-ctrlF.p.
ON "{&AltEsc}-T":u ANYWHERE persistent run xx-trace.p.
ON "{&AltEsc}-E":u ANYWHERE persistent run xxp-altD.p.
ON "{&AltEsc}-N":u ANYWHERE persistent RUN largar.p.
ON "{&AltEsc}-L":u ANYWHERE persistent run asig_xxx.p.
ON "{&AltEsc}-P":u ANYWHERE persistent run xx-fullpath.p.
on f12 anywhere run w-abmparametros.w.
on f10 anywhere persistent run xxp-f10.p.
on f4 anywhere persistent run xxp-f4.p.
on f5 anywhere persistent run xxp-f5.p.


	CREATE WIDGET-POOL.
	run _desk.p no-error.
	DELETE WIDGET-POOL.
QUIT.
