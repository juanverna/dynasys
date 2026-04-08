DEFINE BUFFER baplicacion_pagos FOR aplicacion_pagos.
FIND aplicacion_pagos WHERE
    Aplicacion_pagos.tip_comprob = "CB" AND
    Aplicacion_pagos.prf_comprob = 1 AND
    aplicacion_pagos.nro_comprob = 127251.
FIND cta_cte WHERE 
    Aplicacion_pagos.tip_comprob = cta_cte.tip_comprob AND
    Aplicacion_pagos.prf_comprob = cta_cte.prf_comprob AND
    aplicacion_pagos.nro_comprob = cta_cte.nro_comprob.
   Cta_cte.debito = 0.
FIND cta_cte WHERE 
    Aplicacion_pagos.tip_cancela = cta_cte.tip_comprob AND
    Aplicacion_pagos.prf_cancela = cta_cte.prf_comprob AND
    aplicacion_pagos.nro_cancela = cta_cte.nro_comprob.
    Cta_cte.credito = 0.

DELETE aplicacion_pagos.

