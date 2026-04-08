PROCEDURE COPIAR-{1}:

    /*===========================================================================================*/
    /*   COPIA TODO EL CONTENIDO DE UNA TABLA EN LA BASE ORIGEN HACIA LA BASE DESTINO            */
    /*===========================================================================================*/

    que_copio = "Copiando {1}...".
    DISPLAY que_copio WITH FRAME f-copia.
    DOWN WITH FRAME f-copia.
    
    FOR EACH {&ORIGEN}.{1}:
    
        CREATE {&DESTINO}.{1}.
        BUFFER-COPY {&ORIGEN}.{1} TO {&DESTINO}.{1}.
    
    END.                  
              
END PROCEDURE.
