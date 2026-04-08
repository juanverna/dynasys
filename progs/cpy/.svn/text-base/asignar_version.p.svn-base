/*=========================================================================================*/
/*       ASIGNA UN NUMERO DE RELEASE A UN GRUPO DE PROBLEMAS RESUELTOS SIN LIBERAR         */
/*=========================================================================================*/

DEFINE VARIABLE que_version LIKE Problema.version-arreglo.
UPDATE que_version AT 10 SPACE(5)
       WITH SIDE-LABELS FONT 4 THREE-D VIEW-AS DIALOG-BOX TITLE "Indique Nueva Versión".

DO TRANSACTION:
    FOR EACH Problema WHERE Problema.estado = "R" AND Problema.version-arreglo = "" EXCLUSIVE-LOCK:
        Problema.version-arreglo = que_version.
    END.    
END.

MESSAGE "Versión " que_version " asignada. Es conveniente que salga del sistema y vuelva a iniciar su sesión."
        VIEW-AS ALERT-BOX MESSAGE TITLE "PROCESO COMPLETADO".
