/*============================================================================================*/
/*             DEVUELVE UNA LISTA CON TODOS LOS PROCESOS ACTIVOS                              */
/*============================================================================================*/

DEFINE OUTPUT PARAMETER p-list AS CHARACTER NO-UNDO.

&GLOB TH32CS_SNAPPROCESS 2
 
RUN ListProcesses.
 
PROCEDURE ListProcesses:
 
    DEFINE VARIABLE hSnapShot   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE lpPE        AS MEMPTR    NO-UNDO. /* PROCESSENTRY32 structure */
    DEFINE VARIABLE ReturnValue AS INTEGER   NO-UNDO.
    
 
    /* Create and open SnapShot-p-list */
    RUN CreateToolhelp32Snapshot({&TH32CS_SNAPPROCESS}, 
                                 0, 
                                 OUTPUT hSnapShot).
    IF hSnapShot = -1 THEN RETURN.
 
    /* init buffer for lpPE */
    SET-SIZE(lpPE)    = 336.
    PUT-LONG(lpPE, 1) = GET-SIZE(lpPE).
 
    /* Cycle thru process-records */
    RUN Process32First(hSnapShot, 
                       lpPE,
                       OUTPUT ReturnValue).
    DO WHILE ReturnValue NE 0:
       p-list = p-list + "~n".
 
       /* show process identifier (pid): */
       p-list = p-list + STRING(GET-LONG(lpPE, 9)) + " ".
 
       /* show path and filename of executable: */
       p-list = p-list + GET-STRING(lpPE, 37).
 
       RUN Process32Next(hSnapShot, 
                         lpPE,
                         OUTPUT ReturnValue).
    END.
 
    /* Close SnapShot-p-list */
    RUN CloseHandle(hSnapShot, OUTPUT ReturnValue).
 
END PROCEDURE.

PROCEDURE CreateToolhelp32Snapshot EXTERNAL "kernel32" :
  DEFINE INPUT  PARAMETER dwFlags           AS LONG.
  DEFINE INPUT  PARAMETER th32ProcessId     AS LONG.
  DEFINE RETURN PARAMETER hSnapShot         AS LONG.
END PROCEDURE.
 
PROCEDURE Process32First EXTERNAL "kernel32" :
  DEFINE INPUT  PARAMETER hSnapShot         AS LONG.
  DEFINE INPUT  PARAMETER lpProcessEntry32  AS MEMPTR.
  DEFINE RETURN PARAMETER ReturnValue       AS LONG.
END PROCEDURE.
 
PROCEDURE Process32Next EXTERNAL "kernel32" :
  DEFINE INPUT  PARAMETER hSnapShot         AS LONG.
  DEFINE INPUT  PARAMETER lpProcessEntry32  AS MEMPTR.
  DEFINE RETURN PARAMETER ReturnValue       AS LONG.
END PROCEDURE.
 
PROCEDURE CloseHandle EXTERNAL "kernel32" :
  DEFINE INPUT  PARAMETER hObject           AS LONG.
  DEFINE RETURN PARAMETER ReturnValue       AS LONG.
END PROCEDURE.
