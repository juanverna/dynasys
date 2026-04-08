DEFINE VARIABLE sino AS LOGICAL FORMAT "Si/No".
FOR EACH Tema:
    DISPLAY Tema.cdg_tema Tema.dsc_tema WITH USE-TEXT FONT 2 CENTERED.
    FOR EACH Problema OF Tema EXCLUSIVE-LOCK WHERE Problema.fecha_reportado = ?:
        DISPLAY Problema.titulo SKIP Problema.descripcion
                WITH FONT 2 CENTERED 1 DOWN.
        sino = NO.
        UPDATE sino LABEL "Resuelto".                
        IF sino
        THEN DO:
             UPDATE Problema.accion Problema.tipo
                     WITH FONT 2 CENTERED 1 DOWN FRAME aa VIEW-AS DIALOG-BOX.
             Problema.fecha_reportado = DATE("21/09/99").        
        END.
   END.
END.             
             
