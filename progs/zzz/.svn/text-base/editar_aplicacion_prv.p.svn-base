DEFINE VARIABLE vv AS CHARACTER FORMAT "X(1)" INITIAL "|".

DEFINE FRAME f-titulo HEADER
       "                  ACTUALIZACION DE APLICACION DE PAGOS" SKIP(1)
       "Documento Cancelado                                 Documento Cancelador"
       WITH FRAME f-titulo TOP-ONLY .

DEFINE FRAME f-actualiza
    Aplicacion_pagos_prv.tip_cancela        COLUMN-LABEL "Ti!po" FORMAT "X(2)"
    Aplicacion_pagos_prv.prf_cancela        COLUMN-LABEL "Pre!fijo"
    Aplicacion_pagos_prv.nro_cancela        COLUMN-LABEL "Número!Factura" FORMAT ">>>>>9"
    Aplicacion_pagos_prv.nro_ven_cancela    COLUMN-LABEL "N.!V." FORMAT ">9"
    "|"                                     
    Aplicacion_pagos_prv.tip_comprob        COLUMN-LABEL "Ti!po" FORMAT "X(2)"
    Aplicacion_pagos_prv.prf_comprob        COLUMN-LABEL "Pre!fijo"
    Aplicacion_pagos_prv.nro_comprob        COLUMN-LABEL "Número!O/Pago" FORMAT ">>>>>9"
    Aplicacion_pagos_prv.nro_vencimiento    COLUMN-LABEL "N.!V." FORMAT ">9"
    Aplicacion_pagos_prv.importe            COLUMN-LABEL "Importe!Aplicado"
    WITH WIDTH 80 FRAME f-actualiza DOWN.

FIND Proveedor WHERE Proveedor.cdg_proveedor = "00348".
FOR EACH Aplicacion_pagos_prv OF Proveedor:

    VIEW FRAME f-titulo.
    UPDATE Aplicacion_pagos_prv.tip_cancela        
           Aplicacion_pagos_prv.prf_cancela        
           Aplicacion_pagos_prv.nro_cancela        
           Aplicacion_pagos_prv.nro_ven_cancela    
           Aplicacion_pagos_prv.tip_comprob        
           Aplicacion_pagos_prv.prf_comprob        
           Aplicacion_pagos_prv.nro_comprob        
           Aplicacion_pagos_prv.nro_vencimiento    
           Aplicacion_pagos_prv.importe            
           WITH FRAME f-actualiza.
    DOWN WITH FRAME f-actualiza. 
END.  
