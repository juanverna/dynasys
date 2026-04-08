time /T > c:\dynasys10\logs\diario.log
cd c:\dynasys10\progs
#echo "Arranca diariofuerza" >> c:\dynasys10\logs\diario.log
# C:\Progress102\OpenEdge\bin\prowin32.exe -b -p regenera_agenda_recursos.p  -db c:\bases\dynasys102 -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
# time /T >>  c:\dynasys10\logs\diario.log
# echo "Regenera agenda" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_evento_protocolo.p -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25
time /T >>  c:\dynasys10\logs\diario.log
echo "Protocolos" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p desasignareventosnorealizados.p -db c:\bases\dynasys102  -ld sic -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -nb 150 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Eventos no realizados" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p asignarEC.p -db c:\bases\dynasys102  -ld sic -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -nb 150 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Entrega Certif." >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_confirmaciontanques.p -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Confirma Tanques" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_confirmacionfumi.p -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Confirma Fumi" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_confirmacionDT.p -db c:\bases\dynasys102 -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "ConfirmaDT" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p genera_evento_entrega_fac.p -db c:\bases\dynasys102 -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Evento Entrega" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_datos_clientes.p -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Datos Clientes" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p recalcula_acumulados_punto_venta.p  -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
echo "Acumulados" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_tarea_cobranzas.p  -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey INI -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -nb 200 -bibufs 25 -q 
time /T >>  c:\dynasys10\logs\diario.log
echo "Tarea Cobranzas" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_emailcobranzas.p  -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey INI -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -nb 200 -bibufs 25 -q 
time /T >>  c:\dynasys10\logs\diario.log
echo "Email Cobranzas" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p C:\dynasys10\progs\opr\enviocertif.p  -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey INI -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -nb 200 -bibufs 25 -q 
time /T >>  c:\dynasys10\logs\diario.log
rem echo "Envio Certif" >> c:\dynasys10\logs\diario.log
echo "Fin" >> c:\dynasys10\logs\diario.log
