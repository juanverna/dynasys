time /T > c:\dynasys10\logs\diario.log
cd c:\dynasys10\progs
echo "Confirma Tanques" >> c:\dynasys10\logs\diario.log
C:\Progress102\OpenEdge\bin\prowin32.exe -b -p gen_confirmacionfumi.p -db c:\bases\dynasys102  -ld sic  -U BATCH -P batch -T c:\temp -basekey "INI" -ininame c:\dynasys10\procs\dynasys10.ini -s 200 -inp 8192 -bibufs 25 -q
time /T >>  c:\dynasys10\logs\diario.log
