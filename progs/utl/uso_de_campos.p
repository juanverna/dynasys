/*=================================================================================*/
/*        LISTA TODAS LAS TABLAS EN LAS QUE SE USA UN DETERMINADO CAMPO            */
/*=================================================================================*/

DEFINE VARIABLE que_campo AS CHARACTER INITIAL "cambio_dolar".
UPDATE que_campo FORMAT "X(30)".

FOR EACH _Field WHERE _Field._Field-name BEGINS que_campo NO-LOCK:
    FIND _File OF _Field NO-LOCK.
    DISPLAY _File._File-name WITH STREAM-IO.
END.    
