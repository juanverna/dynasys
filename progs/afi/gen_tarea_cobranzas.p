FIND usuario WHERE usuario.cdg_usuario = userid("sic") .
OUTPUT TO "c:\dynasys10\logs\gen_tarea_cobranzas.LOG" append.
DISPLAY "Fecha corrida" NOW.
FIND FIRST empresa NO-LOCK.
IF usuario.cdg_empresa = "" THEN usuario.cdg_empresa = empresa.cdg_empresa.
{findempresa.i}
/*generacion de las tareas de cobranzas*/
/*administrador es el per se y el autoadministrado - no existe padron se obtendra de los resumenes*/
/*de cada administrador a cobrar ( ver prinresumenes.p ) generar una tarea 
al cerrar esta tarea se genera un evento.
Al pasar una cobranza se confirma el evento, colocando la frealizado la hora_desde y hora_hasta en el evento*/
/*
Restricciones:
Existe el operario forzado de cobranza y el tentativo, en caso de omision intentara el ultimo cobrador.
Esiste una restriccion de la TAREA que hace que se genere el evento sin tarea en forma automatica*/

/*El simil del aviso de cobranza es el envio de la informacion de coranza generada 
por el prinresumenes.p , la confirmacion de estos esta dada automaticamente descargando en el server de email la confirmacion*/

DEFINE BUFFER administrador FOR cliente.
           
FOR EACH Administrador  
     WHERE CAN-DO(Administrador.lista_empresas,empresa.cdg_empresa) NO-LOCK:
    /*IF administrador.cdg_cliente = "A1398" THEN /*{debug.i}*/.*/
        RUN c:\Dynasys10\progs\afi\gen_tarea_cobranzasH.p (administrador.nro_cliente,"",TODAY).
END.

