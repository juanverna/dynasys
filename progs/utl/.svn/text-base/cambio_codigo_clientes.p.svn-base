/*--------------------------------------------------------------------------------*/
/*                          Cambio masivo de codigos de cliente                   */
/*--------------------------------------------------------------------------------*/

DEFINE VARIABLE v-cdg_cliente LIKE Cliente.cdg_cliente.
REPEAT :
    UPDATE v-cdg_cliente WITH TITLE "Presione ESC para terminar".
    FIND Cliente WHERE Cliente.cdg_cliente = v-cdg_cliente EXCLUSIVE-LOCK NO-ERROR.
    IF NOT AVAILABLE Cliente
    THEN DO:
        MESSAGE "No existe el cliente"
            VIEW-AS ALERT-BOX ERROR.
        UNDO, NEXT.
    END.
    ELSE DO:
        DISPLAY Cliente.nom_cliente Cliente.cdg_cliente.
        UPDATE Cliente.cdg_cliente.
    END.
END.
