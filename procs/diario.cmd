time /T  >> c:\dynasys10\logs\diario.log
echo "Arranca" >> c:\dynasys10\logs\diario.log
set DLC=C:\Progress102\OpenEdge
set PATH=%DLC%\BIN;%PATH%
set LIB=%DLC%\LIB;%LIB
REM call proserve c:\bases\dynasys102 -n 20 -S 2500 -N tcp -H 127.0.0.1 -B 100000 -spin 50000 -bibufs 25
REM call probiw c:\bases\dynasys102 
REM call proapw c:\bases\dynasys102 
REM call proapw c:\bases\dynasys102 
REM call proapw c:\bases\dynasys102
time /T >>  c:\dynasys10\logs\diario.log
echo "Servers Arriba" >> c:\dynasys10\logs\diario.log
for /f  "usebackq tokens=1,2,3 delims=/" %%i in (`date /t`) do set tmpfecha=%%k%%j%%i
for /f  "usebackq tokens=1,2,3 delims= " %%i in (`echo %tmpfecha%`) do set mifecha=%%i%%j%%k
rem set DLC=C:\Progress102\OpenEdge
rem set PATH=%DLC%\BIN;%PATH%
rem set LIB=%DLC%\LIB;%LIB%
call probkup online c:\bases\dynasys102 c:\backup\dyn%mifecha%.bkp > null 
time /T >>  c:\dynasys10\logs\diario.log
echo "Fin Backup" >> c:\dynasys10\logs\diario.log
"C:\Program Files\7-Zip\7z" a -t7z c:\backup\BKP%mifecha% c:\backup\dyn%mifecha%.bkp -r mt=4
del c:\backup\dyn%mifecha%.bkp
echo "Fin" >> c:\dynasys10\logs\diario.log
