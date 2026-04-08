DEFINE INPUT PARAMETER v-cdg_proveedor AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER rid_proveedor AS ROWID.

IF LOOKUP(SUBSTRING(v-cdg_proveedor,1,1),"0,1,2,3,4,5,6,7,8,9") <> 0
THEN DO:
     FIND FIRST Proveedor 
          WHERE Proveedor.cdg_proveedor >= v-cdg_proveedor NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Proveedor 
     THEN DO:
          FIND FIRST Proveedor NO-LOCK.
     END.     
END.       
ELSE DO:
     FIND FIRST Proveedor 
          WHERE Proveedor.nombre BEGINS(v-cdg_proveedor) NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Proveedor 
        THEN MESSAGE "No existen proveedores cuya descripcion comience con " v-cdg_proveedor.
          
END.       

rid_proveedor = ROWID(Proveedor).
