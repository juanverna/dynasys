@ECHO OFF
for /f  "usebackq tokens=1,2,3 delims=/" %%i in (`date /t`) do set tmpfecha=%%k%%j%%i
for /f  "usebackq tokens=1,2,3 delims= " %%i in (`echo %tmpfecha%`) do set mifecha=%%i%%j%%k

set DLC=C:\Progress102\OpenEdge
set PATH=%DLC%\BIN;%PATH%
set LIB=%DLC%\LIB;%LIB%
call probkup online c:\bases\dynasys102 c:\backup\dyn%mifecha%.bkp > nul 
call "C:\Program Files\7-Zip"\7z a -t7z c:\backup\BKP%mifecha% c:\backup\dyn%mifecha%.bkp -r mt=4
del c:\backup\dyn%mifecha%.bkp


