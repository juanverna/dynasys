DEFINE VARIABLE QUE_CAMPO AS CHARACTER FORMAT "x(20)".
UPDATE que_campo.
    FOR EACH _Field WHERE _Field._Field-name BEGINS que_campo, _File OF _Field NO-LOCK:

                     display _Field._Field-name _File._File-name WITH stream-io.
