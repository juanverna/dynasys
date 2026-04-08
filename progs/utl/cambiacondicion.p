/*==========================================================================================*/
/*                      CAMBIO MASIVO DE CONDICIONES DE VENTA DE CLIENTES                   */
/*==========================================================================================*/

DEFINE VARIABLE v-cdg_cliente LIKE Cliente.cdg_cliente.
DEFINE VARIABLE v-nueva_cnd   LIKE Condicion_venta.cdg_cndventa.

UPDATE v-nueva_cnd LABEL "Nueva Condición" WITH SIDE-LABELS.

REPEAT ON ERROR UNDO, RETRY WITH FRAME aa:

    UPDATE v-cdg_cliente.
    FIND Cliente WHERE Cliente.cdg_cliente = v-cdg_cliente EXCLUSIVE-LOCK.
    DISPLAY Cliente.dfl_cndventa COLUMN-LABEL "Condición!Anterior". 
    Cliente.dfl_cndventa = v-nueva_cnd.
END.    


