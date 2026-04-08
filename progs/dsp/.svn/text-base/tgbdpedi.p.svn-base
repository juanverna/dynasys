DEFINE SHARED VARIABLE hubo_cambio    AS LOGICAL.

ON WRITE OF Ped_header
DO:
   hubo_cambio = YES.
END.   

ON DELETE OF Ped_detalle
DO:
   hubo_cambio = YES.
END.   

ON CREATE OF Ped_detalle
DO:
   hubo_cambio = YES.
END.   

ON WRITE OF Ped_detalle NEW BUFFER New_det OLD BUFFER Old_det
DO:

  IF New_det.ano_elab         <> Old_det.ano_elab         OR
     New_det.cantidad         <> Old_det.cantidad         OR
     New_det.cdg_mlateral     <> Old_det.cdg_mlateral     OR
     New_det.cdg_mtapa        <> Old_det.cdg_mtapa        OR
     New_det.fecha_tardia     <> Old_det.fecha_tardia     OR
     New_det.fecha_temprana   <> Old_det.fecha_temprana   OR
     New_det.granel           <> Old_det.granel           OR
     New_det.nro_articulo     <> Old_det.nro_articulo     OR
     New_det.nro_partida      <> Old_det.nro_partida
     THEN hubo_cambio = YES.

END.   

ON CREATE OF Ped_detalle_entr
DO:
   hubo_cambio = YES.
END.   

ON WRITE OF Ped_detalle_entr NEW BUFFER New_ent OLD BUFFER Old_ent
DO:

  IF New_ent.cantidad         <> Old_ent.cantidad         OR
     New_ent.fecha_tardia     <> Old_ent.fecha_tardia     OR
     New_ent.fecha_temprana   <> Old_ent.fecha_temprana   OR
     New_ent.granel           <> Old_ent.granel           OR
     New_ent.flete_estimado   <> Old_ent.flete_estimado
     THEN hubo_cambio = YES.

END.   

ON DELETE OF Ped_detalle_entr
DO:
   hubo_cambio = YES.
END.   

PROCEDURE DESTRUIR_CONTEXTO_BD:

   DELETE PROCEDURE THIS-PROCEDURE.
   
END.   