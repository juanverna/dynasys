/*===========================================================================================*/
/*   COPIA TODO EL CONTENIDO DE UNA TABLA EN LA BASE ORIGEN HACIA LA BASE DESTINO            */
/*===========================================================================================*/

DEFINE VARIABLE reemplazar AS LOGICAL INITIAL {&REEMPLAZAR}.

FOR EACH {&ORIGEN}.{&TABLA}:

    FIND {&DESTINO}.{&TABLA} WHERE {&DESTINO}.{&TABLA}.{&CDG_TABLA} = {&ORIGEN}.{&TABLA}.{&CDG_TABLA} EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE {&DESTINO}.{&TABLA}
    THEN DO:
         CREATE {&DESTINO}.{&TABLA}.
         BUFFER-COPY {&ORIGEN}.{&TABLA} TO {&DESTINO}.{&TABLA}.
    END.
    ELSE DO:
         IF reemplazar
            THEN BUFFER-COPY {&ORIGEN}.{&TABLA} TO {&DESTINO}.{&TABLA}.
    END.
END.                  
              
