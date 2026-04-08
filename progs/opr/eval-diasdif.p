/*evaluador de v-difdias.w*/
/*entregara un valor decreciente dentro de los 10( variable cuantos) dias +- de la realizacion del evento anterior si existe*/
/*independiente de los meses*/
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.

DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR d AS date NO-UNDO.  /* ver de donde obtenerlo*/
DEF VAR vss AS INT NO-UNDO.
def var diasmes as int no-undo.
def var pridia as date no-undo.
def var fechacomp as date no-undo.
DEFINE VAR cuantos AS INT NO-UNDO.
DEFINE BUFFER bevento FOR evento.
DEFINE VAR almenos AS LOGICAL.
v = 0.
cuantos = INT(ss) NO-ERROR.
FIND bevento WHERE bevento.nro_evento = nroE.
almenos = FALSE.

FOR EACH evento where evento.origen = bevento.origen and
     evento.nro_identificacion = bevento.nro_identificacion and
     evento.sub_evento = bevento.sub_evento and
     NOT evento.anulado AND
     evento.periodo < bevento.periodo NO-LOCK BY evento.periodo DESC BY evento.nro_evento DESC:
    almenos = TRUE.
    fechacomp = IF Evento.Frealizado <> ?  THEN Evento.Frealizado else Evento.FAsignado.
    i = day(fecha) - day(fechacomp).
    IF ABS(i) <= cuantos THEN DO:
       v = 1 - absolute(i - vss) * 1 / cuantos.
       IF v <> 1 THEN DO:
        esdesborde = TRUE.
        vmobs = "DEA[" + string(day(fechacomp)) + "<->" + string( i - vss, "-99" ) + "]".
       END.
    END.
    ELSE do:
        esdesborde = FALSE.
        vmobs = "FUERA DEA[" + string(day(fechacomp)) + "<->" + string( i - vss, "-99" ) + "]".
    END.
    LEAVE.
END.
IF NOT almenos THEN
    v = 1. /*cualquier fecha le viene bien*/

/*reajuste del impacto de la diferencia de dias*/
v = v / 2.
