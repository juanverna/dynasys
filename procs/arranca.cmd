set DLC=C:\Progress102\OpenEdge
set PATH=%DLC%\BIN;%PATH%
set LIB=%DLC%\LIB;%LIB
call proshut c:\bases\dynasys102 -by
rem call proutil c:\bases\dynasys102 -C truncate bi
rem call proutil c:\bases\dynasys102 -C idxbuild ALL
call proserve c:\bases\dynasys102 -n 20 -S 2500 -N tcp -H 127.0.0.1 -B 50000 -spin 50000 -bibufs 25
call probiw c:\bases\dynasys102 
call proapw c:\bases\dynasys102 
call proapw c:\bases\dynasys102 
call prowdog c:\bases\dynasys102


