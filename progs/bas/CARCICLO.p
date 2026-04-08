
FIND FIRST Ciclo_novedades WHERE Ciclo_novedades.actual NO-LOCK NO-ERROR.
IF NOT AVAILABLE Ciclo_novedades
THEN DO:
   FIND FIRST Ciclo_novedades EXCLUSIVE-LOCK.
   Ciclo_novedades.actual = YES.
   FIND CURRENT Ciclo_novedades NO-LOCK.
END.   

RETURN.
