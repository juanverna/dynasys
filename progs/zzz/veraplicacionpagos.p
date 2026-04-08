FIND proveedor WHERE cdg_proveedor = "004".
DISPLAY proveedor.nombre.
FOR EACH  Aplicacion_pagos_prv NO-LOCK OF proveedor:

    DISPLAY Aplicacion_pagos_prv.cdg_empresa   COLUMN-LABEL "emp"
            Aplicacion_pagos_prv.tip_comprob   COLUMN-LABEL "tipcom"
            Aplicacion_pagos_prv.prf_comprob   COLUMN-LABEL "prfcom" 
            Aplicacion_pagos_prv.nro_comprob   COLUMN-LABEL "nrocom" 
            Aplicacion_pagos_prv.tip_cancela   COLUMN-LABEL "tipcan" 
            Aplicacion_pagos_prv.prf_cancela   COLUMN-LABEL "prfcan" 
            Aplicacion_pagos_prv.nro_cancela   COLUMN-LABEL "nrocan" 
            WITH STREAM-IO.
    /*cdg_empresa  = "F".*/
