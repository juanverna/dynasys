time /T  >> c:\dynasys10\logs\diario.log
echo "Baja" >> c:\dynasys10\logs\diario.log
set DLC=C:\Progress102\OpenEdge
set PATH=%DLC%\BIN;%PATH%
set LIB=%DLC%\LIB;%LIB
call proshut c:\bases\dynasys102 -by 


