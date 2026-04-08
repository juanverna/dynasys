/*===============================================================================*/
/*                            CREA UN MENSAJE DE ERROR                           */
/*===============================================================================*/
           
DEFINE INPUT PARAMETER p-cdg_mensaje    LIKE Mensaje.cdg_mensaje.
DEFINE INPUT PARAMETER p-texto          LIKE Mensaje.texto. 
DEFINE INPUT PARAMETER p-tipo           LIKE Mensaje.tipo.
DEFINE INPUT PARAMETER p-sobreescribir  AS LOGICAL.

DEFINE VARIABLE sino AS LOGICAL.

DO TRANSACTION:

    FIND Mensaje WHERE Mensaje.cdg_mensaje = p-cdg_mensaje EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE Mensaje
    THEN DO:
        CASE p-sobreescribir:
            WHEN YES
            THEN DO:
                ASSIGN Mensaje.cdg_mensaje = p-cdg_mensaje
                       Mensaje.texto       = p-texto 
                       Mensaje.tipo        = p-tipo.
            END.
            WHEN NO
            THEN DO:
                /* No hay nada que hacer si no sobreesscribinos y el mensaje existe */
            END.
            OTHERWISE
            DO:
                sino = NO.
                MESSAGE "El mensaje " p-cdg_mensaje " ya existe con el siguiente texto:" SKIP 
                        Mensaje.texto SKIP
                        "Desea sobreescribirlo con este otro?" SKIP
                        p-texto
                    VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO TITLE "Advertencia" SET sino.
            
                IF NOT sino 
                THEN DO: 
                    MESSAGE "El mensaje " p-cdg_mensaje "NO HA SIDO ACTUALIZADO"
                        VIEW-AS ALERT-BOX INFORMATION.
                    RETURN.
                END.
                ELSE DO:
                    ASSIGN Mensaje.cdg_mensaje = p-cdg_mensaje
                           Mensaje.texto       = p-texto 
                           Mensaje.tipo        = p-tipo.
                END.
    
            END.
        END CASE.
    
    END.
    ELSE DO:
        CREATE Mensaje.
        ASSIGN Mensaje.cdg_mensaje = p-cdg_mensaje
               Mensaje.texto       = p-texto 
               Mensaje.tipo        = p-tipo.
    END.
END.

