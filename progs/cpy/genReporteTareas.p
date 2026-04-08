    DEFINE TEMP-TABLE btarea 
    FIELD 
reportado_ref      LIKE      Tarea.reportado_ref 
FIELD reportado_por    LIKE        Tarea.reportado_por 
FIELD titulo            LIKE       Tarea.titulo 
FIELD descripcion       LIKE       Tarea.descripcion 
FIELD dg_usuario      LIKE        Tarea.cdg_usuario.
    DEFINE DATASET dset FOR btarea.
    FOR EACH tarea:
     CREATE btarea.
     BUFFER-COPY tarea TO btarea.
END.
 
DATASET DSET:WRITE-XML("file", 
                               "c:\tareas.xml", 
                               YES, 
                               ?, 
                               ?, 
                               NO, 
                               no). 

