/*estas funciones estan relacionadas con el estado de los avisos, 
de alto impacto en el sistema por lo que se pasa a include */
FUNCTION evavisado
RETURNS INTEGER 
( nevento AS INT ) :
    DEFINE BUFFER staviso FOR evento.
    FIND staviso WHERE NOT staviso.anulado AND
               staviso.refevento = nevento NO-LOCK NO-ERROR.
    IF AVAILABLE staviso THEN DO:
            RETURN staviso.nro_evento.
    END.
END FUNCTION.

FUNCTION sttarea
RETURNS CHARACTER
  ( nevento AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER sttarea FOR tarea.
FIND FIRST tarea WHERE tarea.nro_evento = nevento AND tarea.estado = "A" NO-LOCK NO-ERROR.
IF AVAILABLE tarea THEN RETURN "A".
FOR last tarea NO-LOCK WHERE tarea.nro_evento = nevento BY tarea.nro_tarea:
    RETURN tarea.estado.
END.
END FUNCTION.

FUNCTION stavisado
RETURNS CHARACTER
  ( nevento AS INT ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE BUFFER staviso FOR evento.
DEFINE BUFFER stevento FOR evento.
DEFINE BUFFER stevento3 FOR evento.


FIND stevento WHERE stevento.nro_evento = nevento NO-LOCK. 
IF stevento.origen = "AVISO" THEN RETURN "".
IF stevento.sub_evento > 1 THEN DO:
    FIND FIRST stevento3 WHERE stevento.origen = stevento3.origen AND
        stevento.nro_identificacion = stevento3.nro_identificacion AND
        stevento3.sub_evento = 1 AND stevento.periodo = stevento3.periodo AND 
        NOT stevento3.anulado NO-LOCK NO-ERROR.
    IF NOT AVAILABLE stevento3 THEN DO:
            /*MESSAGE "Error no se encuentra el subevento 1 del evento " + string(stevento.nro_evento) VIEW-AS ALERT-BOX ERROR.*/
            RETURN "N".
    END.
    nevento = stevento3.nro_evento.
END.
/*si es un evento de aviso analizo el evento principal*/
/*IF stevento.origen = "AVISO" THEN DO:
    FIND FIRST stevento3 where stevento3.nro_evento = stevento.refevento NO-LOCK NO-ERROR.
    IF NOT AVAILABLE stevento3 THEN DO:
            MESSAGE "Error no se encuentra el evento " + STRING(stevento.refevento) + " del aviso " + string(stevento.nro_evento) VIEW-AS ALERT-BOX ERROR.
            RETURN "N".
    END.
    nevento = stevento3.nro_evento.
END. */

FIND stevento WHERE stevento.nro_evento = nevento NO-LOCK NO-ERROR. 
IF NOT AVAILABLE stevento THEN DO:
            MESSAGE "Error interno no se encuentra el evento " + STRING(nevento) VIEW-AS ALERT-BOX ERROR.
            RETURN "N".
END.

IF stevento.origen = "CONTRATO" THEN DO:
    FIND restriccion WHERE restriccion.nro_tipo_evento = stevento.nro_tipo_evento AND restriccion.cdg_restriccion BEGINS "AVISO" NO-LOCK NO-ERROR.
    IF NOT AVAILABLE restriccion THEN RETURN "S".
    FIND contrato_restriccion WHERE contrato_restriccion.nro_contrato = INT(stevento.nro_identificacion) AND
        contrato_restriccion.sub_evento = 1 AND /* en todos los caso el sub evento es el 1 que los subeventos subsiguientes muestren el estado del 1 */
        contrato_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
    IF NOT AVAILABLE contrato_restriccion THEN RETURN "S".
END.
ELSE IF stevento.origen = "MANUAL" THEN RETURN "M".
/*tiene que tener aviso*/
FIND staviso WHERE staviso.refevento = nevento AND NOT staviso.anulado NO-LOCK NO-ERROR.
IF NOT AVAILABLE staviso THEN RETURN "N".
ELSE DO:
    IF staviso.frealizado <> ? THEN DO:
        IF staviso.entrega = 1 THEN RETURN "R". /*en mano*/
        IF staviso.entrega = 2 THEN RETURN "B". 
        ELSE RETURN "X" .

/*            FIND tarea OF stevento where ( tarea.cdg_tipotarea = "T" OR tarea.cdg_tipotarea = "Z") AND tarea.estado <> "D" NO-LOCK NO-ERROR.
            IF AVAILABLE tarea THEN DO:
                    IF tarea.estado = "R" THEN RETURN "T".
                    ELSE RETURN IF stevento.entrega = 2 THEN "B" ELSE "X".
            END.
        RETURN IF stevento.entrega = 2 THEN "B" ELSE "X".
*/
    END.
        /*FIND tarea WHERE tarea.nro_evento =  nevento AND ( tarea.cdg_tipotarea = "T" OR tarea.cdg_tipotarea = "Z") AND tarea.estado <> "D" NO-LOCK NO-ERROR.
        IF AVAILABLE tarea THEN DO:
                IF tarea.estado = "R" THEN RETURN "T".
                ELSE RETURN IF staviso.impreso THEN "I" ELSE IF staviso.fasignado <> ? THEN "A" ELSE "P".
        END.
    END.  */
    RETURN IF staviso.impreso THEN "I" ELSE IF staviso.fasignado <> ? THEN "A" ELSE "P".
END.
END FUNCTION.

FUNCTION avisoentregado RETURN LOGICAL
    ( nevento AS INT ) :
    DEFINE BUFFER stevento1 FOR evento.
    RETURN index("RBXTSI", stavisado(nevento)) <> 0.
END FUNCTION.

FUNCTION avisoentregadoEspecial RETURN LOGICAL
    ( nevento AS INT ) :
    DEFINE BUFFER stevento1 FOR evento.
    DEFINE VAR blk AS LOGICAL.
    RETURN index("RSMN", stavisado(nevento)) <> 0.
END FUNCTION.


