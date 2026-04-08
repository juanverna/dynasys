DEFINE VAR fmin AS DATE.
DEFINE VAR fmax AS DATE.
DEFINE var prest AS CHAR.
DEFINE VAR ct AS LOGICAL.
DEFINE VAR ce AS LOGICAL.
DEFINE VAR daux AS DATE NO-UNDO.

DEFINE VAR fperiodo1 AS DATE NO-UNDO.
DEFINE VAR fanal AS DATE.
DEFINE VAR fbase AS DATE NO-UNDO.
DEFINE VAR meshoy AS INT NO-UNDO.
DEFINE VAR anohoy AS INT NO-UNDO.
DEFINE VAR hoy AS DATE.
DEFINE VAR pperiodo AS INT.
DEFINE VAR p-precorte AS DATE NO-UNDO.
DEFINE VAR fpremoroso AS DATE NO-UNDO.
DEFINE VAR fmoroso AS DATE NO-UNDO.
DEFINE VAR totdeuda AS DECIMAL NO-UNDO.
DEFINE VAR totmoroso AS DECIMAL NO-UNDO.
DEFINE VAR p-corte AS DATE NO-UNDO.
DEFINE VAR rrr AS CHAR NO-UNDO.
DEFINE VAR pvisualizar          AS INT   NO-UNDO.
DEFINE VAR confc_valor          AS CHAR NO-UNDO.
{tiempo.i}
                  
FUNCTION cdate RETURNS DATE ( mm AS INT , dd AS INT ,yy AS INT,vdef AS CHAR):
DEFINE VAR ff AS DATE NO-UNDO.
                    ff = DATE ( mm ,  dd , yy ) NO-ERROR.
                IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
                    ff = DATE ( mm , dd - 1, yy ) NO-ERROR.
                IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
                    ff = DATE ( mm ,  dd - 2, yy ) NO-ERROR. 
                IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
                    ff = DATE ( mm , dd - 3, yy ) NO-ERROR. 
                IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
                    ff = DATE ( mm , dd - 4, yy ) NO-ERROR. 
                IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
                IF vdef = "PRI" THEN
                    RETURN DATE( mm, 1, yy).
                IF vdef = "ULT" THEN
                    RETURN ultimodia( DATE( mm , 1 , yy )).
                RETURN ?.
END function.
FUNCTION DOW returns int (dd as date , fwd as int ):
    IF weekday(dd) < fwd THEN return weekday(dd) + 8 - fwd .
    else return weekday(dd) - fwd + 1 .
END function.
FUNCTION fechado returns date ( tnMes AS int, tnAnio AS INT , tnDiaSem AS INT , tnOrdinal AS INT ) :
/*retorna una fecha data un dia de la semana y su ordinal en el mes*/
    define variable dd as date.
    define var daju as int.
    return DATE(  tnMes , 1 , tnAnio ) + tnOrdinal * 7 - dow( DATE(  tnMes , 1, tnAnio ) + tnOrdinal * 7 - 1 ,tnDiasem ).
END function.
DEFINE BUFFER administrador FOR cliente.
DEFINE VAR tipo_evento_cobranza LIKE tipo_evento.nro_tipo_evento NO-UNDO.

DEFINE VAR ss AS CHAR.
rrr = "".
UPDATE ss.
/**********************************************************************************/
FIND administrador WHERE administrador.cdg_cliente = ss.
/**********************************************************************************/
hoy = TODAY.
fperiodo1 = ultimodia(sumarmeses(hoy,2)).
meshoy = MONTH(hoy).
anohoy = YEAR(hoy).
pperiodo = anohoy * 100 + meshoy.
p-precorte = DATE(meshoy,1,anohoy) - 1.
p-precorte = DATE(MONTH(p-precorte),1,YEAR(p-precorte)).
fpremoroso = DATE(MONTH(p-precorte - 1 ),1,YEAR(p-precorte - 1)).
FIND tipo_evento WHERE tipo_evento.cdg_tipo_evento = "CO" NO-LOCK.


FIND restriccion NO-LOCK WHERE restriccion.cdg_restriccion = "CORTE"  NO-ERROR.
FIND cliente_restriccion NO-LOCK OF administrador WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion  NO-ERROR.
IF NOT AVAILABLE cliente_restriccion THEN p-corte = p-precorte + 9.
ELSE do:
        p-corte = p-precorte + INT(cliente_restriccion.valor) - 1 NO-ERROR.
        IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 2 NO-ERROR.
        IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 3 NO-ERROR.
        IF ERROR-STATUS:ERROR THEN p-corte = p-precorte + INT(cliente_restriccion.valor) - 4 NO-ERROR.
END.
REPEAT:
     IF es_habil(p-corte,"23456") THEN LEAVE.
     p-corte = p-corte + 1.
END.
/*p-corte esta ok*/
FIND cliente_restriccion OF administrador WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
IF NOT AVAILABLE cliente_restriccion THEN fmoroso = fpremoroso + 9.
ELSE do:
fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 1 NO-ERROR.
        IF ERROR-STATUS:ERROR THEN fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 2 NO-ERROR.
        IF ERROR-STATUS:ERROR THEN fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 3 NO-ERROR.
        IF ERROR-STATUS:ERROR THEN fmoroso = fpremoroso + INT(cliente_restriccion.valor) - 4 NO-ERROR.
END.
REPEAT:
     IF es_habil(fmoroso,"23456") THEN LEAVE.
     fmoroso = fmoroso + 1.
END.
totdeuda = 0.0.
totmoroso = 0.0.
/*esto esta mal porque no tiene en cuenta la fecha de vencimiento de las facturas*/

RUN deuda_administracion-corte.p ( administrador.nro_cliente, p-corte , OUTPUT totdeuda ).
RUN deuda_administracion-corte.p ( administrador.nro_cliente, fmoroso , OUTPUT totmoroso ).

tipo_evento_cobranza = tipo_evento.nro_tipo_evento.
hoy = TODAY.
prest="FECHAI".

        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
              WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF available cliente_restriccion THEN do:
                rrr = rrr + "," + prest.
                daux = DATE(cliente_restriccion.valor) NO-ERROR.
                IF daux <> ? THEN DO:
                    IF daux > hoy THEN DO:
                            fmin = daux.
                            fmax = daux.
                            ce = true.
                    END.
                END.
        END.
        ELSE DO:
            
    prest="DFIJOC".
    
    FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
            IF NOT AVAILABLE restriccion THEN DO:
                DISPLAY "No se encuentra restriccion " + prest .
            END.
            FIND cliente_restriccion OF administrador 
                  WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
            IF available cliente_restriccion THEN do:
                    rrr = rrr + "," + prest.
                    ce = true.
                    fmin = cDATE ( meshoy , int(entry( 1 , cliente_restriccion.valor , "|" )) , anohoy,? ).
                    fmax = fmin.
                    IF fmax < TODAY OR fmin = ? THEN DO:
                        ct = TRUE.
                        ce = FALSE.
                    END.
            END.  
            
            prest="CONFC".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO: 
            ct = TRUE.
            confc_valor = cliente_restriccion.valor.
            IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 2 THEN 
                pvisualizar = INT(ENTRY(2,cliente_restriccion.valor,"|")).
        END.
        prest="CONFCD".
        FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
        IF NOT AVAILABLE restriccion THEN 
        DO:
            DISPLAY "No se encuentra restriccion " + prest .
        END.
        FIND cliente_restriccion OF administrador 
            WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE cliente_restriccion THEN 
        DO: 
            ct = TRUE.
        /*      confc_valor = cliente_restriccion.valor.
              IF NUM-ENTRIES(cliente_restriccion.valor,"|") >= 2 THEN DO:
                     /*Corresponde crear la tarea*/
/*no esta implementado*/
                     pvisualizar = INT(ENTRY(2,cliente_restriccion.valor,"|")). 
    
              END.*/
        END.

            prest="RDiasSem".
            FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
            IF NOT AVAILABLE restriccion THEN DO:
                DISPLAY "No se encuentra restriccion " + prest .
            END.
            FIND cliente_restriccion OF administrador 
                  WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
            IF available cliente_restriccion THEN do:
                    rrr = rrr + "," + prest.
                    ce = true.
                    daux = fechado( meshoy , anohoy , int(SUBSTRING( entry( 3 , cliente_restriccion.valor , "|" ), LENGTH( entry( 3 , cliente_restriccion.valor , "|" )) , 1 )),int( SUBSTRING( entry( 2 , cliente_restriccion.valor , "|" ),LENGTH( entry( 2 , cliente_restriccion.valor ,"|" )) , 1 ))).
                    fmax = IF daux < cdate(meshoy, INT(ENTRY( 6 , cliente_restriccion.valor , "|" )), anohoy,"ULT") THEN daux ELSE cdate(meshoy, INT(ENTRY( 6 , cliente_restriccion.valor , "|" )), anohoy,"ULT").
                    daux = fechado( meshoy , anohoy , int(SUBSTRING( entry( 3 , cliente_restriccion.valor , "|" ), 1 , 1 )),int( SUBSTRING( entry( 2 , cliente_restriccion.valor , "|" ), 1 ))).
                    fmin = IF daux < cdate(meshoy, INT(ENTRY( 5 , cliente_restriccion.valor , "|" )), anohoy,"PRI") THEN daux ELSE cdate(meshoy, INT(ENTRY( 5 , cliente_restriccion.valor , "|" )), anohoy,"PRI").
                    IF fmax < TODAY OR fmax = ? OR fmin = ? THEN DO:
                        ct = TRUE.
                        ce = FALSE.
                    END.
            END.
            prest="RANGOC".
            FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
            IF NOT AVAILABLE restriccion THEN DO:
                DISPLAY "No se encuentra restriccion " + prest .
            END.
            FIND cliente_restriccion OF administrador 
                  WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
            IF available cliente_restriccion THEN do:
                    rrr = rrr + "," + prest.
                    ce = true.
                    fmin = cDATE ( meshoy , int(entry( 1 , cliente_restriccion.valor , "|" )) , anohoy ,"PRI").
                    fmax = cDATE ( meshoy , int(entry( 2 , cliente_restriccion.valor , "|" )) , anohoy,"ULT" ).
                    IF fmax < TODAY OR fmin = ? OR fmax = ? THEN DO:
                        ct = TRUE.
                        ce = FALSE.
                    END.
            END.
            
            prest="CRONO".
            FIND restriccion WHERE restriccion.nro_tipo_evento = tipo_evento_cobranza AND restriccion.cdg_restriccion = prest NO-LOCK NO-ERROR.
            IF NOT AVAILABLE restriccion THEN DO:
                DISPLAY "No se encuentra restriccion " + prest .
            END.
            
            FIND cliente_restriccion OF administrador 
                  WHERE cliente_restriccion.nro_restriccion = restriccion.nro_restriccion NO-LOCK NO-ERROR.
            IF available cliente_restriccion THEN do:
                    rrr = rrr + "," + prest.
                    ce = true.
                    fmin = cDATE ( meshoy , int(entry(1,entry( meshoy , cliente_restriccion.valor , "|" ))) , anohoy ,"PRI").
                    IF NUM-ENTRIES(entry( meshoy , cliente_restriccion.valor , "|" ),",") > 1 THEN
                        fmax = cDATE ( meshoy , int(entry(2,entry( meshoy , cliente_restriccion.valor , "|" ))) , anohoy,"ULT" ).
                    ELSE fmax = fmin.
                    IF fmax < TODAY OR fmin = ? OR fmax = ? THEN DO:
                        ct = TRUE.
                        ce = FALSE.
                    END.
            END.
            IF AVAILABLE rendicion_hd THEN DO:
                IF year(rendicion_hd.fch_rendicion) * 100 + MONTH(rendicion_hd.fch_rendicion) = pperiodo THEN ct = TRUE.
            END.
/*            IF totmoroso <> 0 THEN do: /*si tiene deuda moroso ignora las restricciones y le genera una tarea*/
                ce = FALSE.
                ct = TRUE.
            END.*/
        END.
DISPLAY rrr FORMAT "X(70)" SKIP  ct ce fmin fmax totmoroso totdeuda pvisualizar.
