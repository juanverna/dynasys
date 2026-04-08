time /T > c:\dynasys10\logs\diario.log
cd c:\dynasys10\progs
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p C:\dynasys10\progs\opr\enviocertif.p  -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey INI -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -nb 200 -bibufs 25 -q 
time /T >>  c:\dynasys10\logs\diario.log
rem echo "Envio Certif" >> c:\dynasys10\logs\diario.log
echo "Fin" >> c:\dynasys10\logs\diario.log
