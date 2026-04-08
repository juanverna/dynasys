/*=================================================================================*/
/*   TRIGGERS DE BASE DE DATOS PARA CONTROLAR EL NUMERO DE VERSION DE O/COMPRA     */
/*=================================================================================*/

DEFINE SHARED VARIABLE hubo_cambio    AS LOGICAL.
                                                 
ON WRITE OF Rqs_header
DO:
   hubo_cambio = YES.
END.   

ON DELETE OF Rqs_detalle
DO:
   hubo_cambio = YES.
END.   

ON CREATE OF Rqs_detalle
DO:
   hubo_cambio = YES.
END.   

ON WRITE OF Rqs_detalle NEW BUFFER New_det OLD BUFFER Old_det
DO:

  IF New_det.cantidad         <> Old_det.cantidad         OR
     New_det.fecha_tardia     <> Old_det.fecha_tardia     OR
     New_det.fecha_temprana   <> Old_det.fecha_temprana   OR
     New_det.granel           <> Old_det.granel           OR
     New_det.nro_articulo     <> Old_det.nro_articulo
     THEN hubo_cambio = YES.

END.   

/*===================================================================================*/
/*                             P R O C E D I M I E N T O S                           */
/*===================================================================================*/

PROCEDURE DESTRUIR_CONTEXTO_BD:

   DELETE PROCEDURE THIS-PROCEDURE.
   
END.   