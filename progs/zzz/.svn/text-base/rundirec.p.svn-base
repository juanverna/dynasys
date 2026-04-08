def var Z as integer.
{VRSHARED.I "NEW" }

define new shared variable codigo_iva as integer initial 1.
/*RUN CARPARAM.P.*/

SESSION:DATA-ENTRY-RETURN = YES.

FIND FIRST usuario.
act_usuario = ROWID(usuario).

FIND FIRST Empresa.
act_empresa = ROWID(Empresa).

/*---------------

compile prcdb501.p save.
find first Rec_header where tip_comprob = "CB" EXCLUSIVE-LOCK.
run prcdb501.p (input rowid(Rec_header)).

compile dtlmovcaja.p save.
compile propg004.p save.
find opg_header where nro_comprob = 73 EXCLUSIVE-LOCK.
run propg004.P (input rowid(opg_header)).

compile prctfgan.p save.
find certificado_gan where nro_certifgan = 27 EXCLUSIVE-LOCK.
run prctfgan.P (input rowid(certificado_gan)).

compile prcaj000.p save.
find first caj_header where nro_comprob = 117 and tip_comprob = "CJ" EXCLUSIVE-LOCK.
run prcaj000.P (input rowid(caj_header)).

compile prfaa501.p save.
find first fac_header where nro_factura = 5143 EXCLUSIVE-LOCK.
run prfaa501.P (input rowid(fac_header)).

compile prrem501.p save.
find first rem_header where nro_remito = 5265 EXCLUSIVE-LOCK.
run prrem501.P (input rowid(rem_header)).

compile prtra501.p save.
find first Transdep_hd where nro_transdep = 905 EXCLUSIVE-LOCK.
run prtra501.P (input rowid(Transdep_hd)).

compile prcda501.p save.
find first rec_header where nro_comprob = 5390 and tip_comprob = "CA"  EXCLUSIVE-LOCK.
run prcda501.P (input rowid(rec_header)).

find first rec_header where nro_comprob = 5083 and tip_comprob = "CA"  EXCLUSIVE-LOCK.
run prcda501.P (input rowid(rec_header)).

compile prfaa724.p save.
find first fac_header where nro_comprob = 130 EXCLUSIVE-LOCK.
RUN TOLETRAS.P (INPUT Fac_header.imp_total, OUTPUT Fac_header.monto_letras ).
imp_iva = imp_total - imp_neto.
run prfaa724.P (input rowid(fac_header)).

compile prfaa501.p save.
find first fac_header where nro_factura = 5143 EXCLUSIVE-LOCK.
run prfaa501.P (input rowid(fac_header)). 


RUN exreport.p (  INPUT  ".\prl\sic.prl",            /* Librería desde la que se ejecuta */
                  INPUT "Reclamo de deuda",                         /* Nombre del reporte a ejecutar    */
                  INPUT  "Cliente.cdg_cliente = 'B00001'",                        /* Filtro de registros a imponer    */
                  INPUT  "D",                             /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                              /* Impresora de destino del listado */
                  INPUT  ""                         /* Parametros de Ejecucion          */
               )   


compile rlsalxvendedor.p save.
compile lssalxvendedor.p save.

run rlsalxvendedor.p. 

*/


compile prfaa112.p save.
find first fac_header where nro_comprob = 9894 and tip_comprob = "FA" and fac_header.cdg_empresa = "H" and prf_comprob = 1 EXCLUSIVE-LOCK.
run prfaa112.P (input rowid(fac_header)). 
