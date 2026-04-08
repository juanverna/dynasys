    DEFINE BUFFER bbatch FOR BATCH.
        SESSION:immediate-display = TRUE.
        /*{debug.i}*/
    FOR EACH bBATCH WHERE tipo = ""  NO-LOCK:
       /* PAUSE 0.   */
        IF bbatch.fecha > NOW THEN NEXT.
        FIND BATCH WHERE rowid(batch) = rowid(bbatch) EXCLUSIVE-LOCK NO-WAIT NO-ERROR.
        IF NOT AVAILABLE BATCH THEN NEXT.
      /*  DISPLAY BATCH. */
        IF search(batch.prgm) = ?   THEN DO:
            BATCH.tipo = "E".
            NEXT.
        END.
        
        RUN value(batch.prgm) (ROWID(BATCH)) NO-ERROR.
        IF ERROR-STATUS:ERROR THEN DO:
            BATCH.tipo = "E".
            NEXT.
        END.
        BATCH.tipo = RETURN-VALUE.
        IF batch.tipo = "" THEN DELETE BATCH.
        RELEASE BATCH.
    END.
                                 
