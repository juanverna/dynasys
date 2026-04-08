   FIND CURRENT Rendgastos_hd EXCLUSIVE-LOCK.
   Rendgastos_hd.cdg_estado = "{1}".
   FIND CURRENT Rendgastos_hd NO-LOCK.

   RUN dispatch IN THIS-PROCEDURE ( INPUT 'open-query').

