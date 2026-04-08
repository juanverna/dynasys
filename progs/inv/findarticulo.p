DEFINE INPUT PARAMETER v-cdg_articulo AS CHARACTER.
DEFINE INPUT-OUTPUT PARAMETER rid_articulo AS ROWID.

IF LOOKUP(SUBSTRING(v-cdg_articulo,1,1),"0,1,2,3,4,5,6,7,8,9") <> 0
THEN DO:
     FIND LAST Articulo 
          WHERE Articulo.cdg_articulo >= v-cdg_articulo NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Articulo 
     THEN DO:
          FIND FIRST Articulo NO-LOCK.
     END.     
END.       
ELSE DO:
     FIND FIRST Articulo 
          WHERE Articulo.descripcion BEGINS(v-cdg_articulo) NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Articulo 
        THEN MESSAGE "No existen articulos cuya descripcion comience con " v-cdg_articulo.
          
END.       

rid_articulo = ROWID(Articulo).
