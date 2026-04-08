/*evaluador de v-difEVdias.w*/
/*distancia a otro evento es exacto no una distribucion */
/*si es 0 es exacto el mismo dia sino una pequeña campana a derecha*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO. /*nro_identificacion|sub_evento|distancia*/
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.

DEFINE VAR I AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
v = 0.
esdesborde = FALSE.
IF nroE > 1 THEN do:
    FIND bevento WHERE bevento.nro_evento = nroE.
    find evento where evento.nro_evento = bevento.evsigue no-lock no-error.
    IF available evento THEN
    DO:
        IF evento.fasignado<>? THEN do:
            i = day( fecha ) - day( evento.fasignado ) - int( entry(3,ss ,"|" )).
            IF int( entry(3,ss ,"|" )) = 0 THEN
                IF i = 0  THEN v = 1.
                 ELSE v = 0.
            ELSE DO:
                IF WEEKDAY(fecha) = 7 THEN
                    v = 0.
                ELSE
                 IF i >= 0 THEN
                    IF i <= 3 THEN v  = 1.00 - DECIMAL( i ) * 0.33.
            END.
        END.
    END.
END.
IF v <> 1 AND v > 0 THEN DO:
        esdesborde = TRUE.
        vmobs = "DEV[" + ss + "<->" + string( i , "9" ) + "]".
    END.
ELSE esdesborde = FALSE.


