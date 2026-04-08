/*=================================================================================*/
/*   TRIGGERS DE BASE DE DATOS PARA CONTROLAR EL NUMERO DE VERSION DE O/COMPRA     */
/*=================================================================================*/

DEFINE SHARED VARIABLE hubo_cambio    AS LOGICAL.
                                                 
ON WRITE OF Ocm_header
DO:
   hubo_cambio = YES.
END.   

ON DELETE OF Ocm_detalle
DO:
   hubo_cambio = YES.
END.   

ON CREATE OF Ocm_detalle
DO:
   hubo_cambio = YES.
END.   

ON WRITE OF Ocm_detalle NEW BUFFER New_det OLD BUFFER Old_det
DO:

  IF New_det.cantidad         <> Old_det.cantidad         OR
     New_det.fecha_tardia     <> Old_det.fecha_tardia     OR
     New_det.fecha_temprana   <> Old_det.fecha_temprana   OR
     New_det.granel           <> Old_det.granel           OR
     New_det.nro_articulo     <> Old_det.nro_articulo
     THEN hubo_cambio = YES.

END.   

ON CREATE OF Ocm_detalle_entr
DO:
   hubo_cambio = YES.
END.   

ON WRITE OF Ocm_detalle_entr NEW BUFFER New_ent OLD BUFFER Old_ent
DO:

  IF New_ent.cantidad         <> Old_ent.cantidad         OR
     New_ent.fecha_tardia     <> Old_ent.fecha_tardia     OR
     New_ent.fecha_temprana   <> Old_ent.fecha_temprana   OR
     New_ent.granel           <> Old_ent.granel           
     THEN hubo_cambio = YES.

END.   

ON DELETE OF Ocm_detalle_entr
DO:
   hubo_cambio = YES.
END.   

/*===================================================================================*/
/*                             P R O C E D I M I E N T O S                           */
/*===================================================================================*/

PROCEDURE DESTRUIR_CONTEXTO_BD:

   DELETE PROCEDURE THIS-PROCEDURE.
   
END.   