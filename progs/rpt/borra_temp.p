/*borra el archivo el archivo pasado como parametro*/
DEFINE INPUT PARAMETER xfile AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER errcdg AS INT NO-UNDO.
OS-DELETE VALUE(xfile).
errcdg = OS-ERROR.
