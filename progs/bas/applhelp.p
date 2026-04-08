/*deteccion de ubicacion del applhelp para el seguimiento del problema*/

DEF VAR r AS CHAR NO-UNDO.

DEFINE VARIABLE i AS INTEGER.

                  r = FRAME-DB + CHR(1) + FRAME-FILE + CHR(1) + FRAME-FIELD + CHR(1) + FRAME-VALUE + CHR(13).
                  i = 2. /* Skip the current routine: PROGRAM-NAME(1) */
                  DO WHILE PROGRAM-NAME(i) <> ?:
                   r = r + PROGRAM-NAME(i) + ( IF i = 2 THEN  " (" + SEARCH( PROGRAM-NAME(i) ) + ") "  ELSE "" ) + chr(13) .
                   i = i + 1.
                  END.
MESSAGE r VIEW-AS ALERT-BOX INFORMATION.
/*RUN w-applhelp.w ( INPUT r ).*/
