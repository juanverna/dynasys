/*===============================================================================*/
/*                            CREA UN MENSAJE DE ERROR                           */
/*===============================================================================*/
           
DEFINE INPUT PARAMETER p-cdg_mensaje LIKE Mensaje.cdg_mensaje.
DEFINE INPUT PARAMETER p-texto       LIKE Mensaje.texto. 
DEFINE INPUT PARAMETER p-tipo        LIKE Mensaje.tipo.
DEFINE INPUT PARAMETER p-sino        AS LOGICAL.

DEFINE VARIABLE sino AS LOGICAL.

FIND Mensaje WHERE Mensaje.cdg_mensaje = p-cdg_mensaje NO-ERROR.
IF AVAILABLE Mensaje
THEN DO:

    CASE p-sino:

        WHEN TRUE
        THEN DO:
            RUN actualizar.
        END.

        WHEN ? 
        THEN DO:
            sino = NO.
            MESSAGE "El mensaje " p-cdg_mensaje " ya existe con el siguiente texto:" SKIP 
                    Mensaje.texto SKIP
                    "Desea sobreescribirlo?"
                VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO TITLE "Advertencia" SET sino.
        
            IF NOT sino 
            THEN DO: 
                MESSAGE "El mensaje " p-cdg_mensaje "NO HA SIDO ACTUALIZADO"
                    VIEW-AS ALERT-BOX INFORMATION.
                RETURN.
            END.
            ELSE DO:
                RUN actualizar.
            END.
        END.

    END CASE.
    
END.
ELSE DO TRANSACTION:
    CREATE Mensaje.
    ASSIGN Mensaje.cdg_mensaje = p-cdg_mensaje
           Mensaje.texto       = p-texto 
           Mensaje.tipo        = p-tipo.
END.


PROCEDURE actualizar:

    DO TRANSACTION:
        FIND CURRENT Mensaje EXCLUSIVE-LOCK.
        ASSIGN Mensaje.cdg_mensaje = p-cdg_mensaje
               Mensaje.texto       = p-texto 
               Mensaje.tipo        = p-tipo.
    END.

END PROCEDURE.
