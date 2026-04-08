/*=================================================================================*/
/*                 ACUMULACION DE PAGOS DEL PROVEEDOR PARA GANANCIAS               */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_opago AS ROWID.
DEFINE INPUT PARAMETER ope       AS CHARACTER.

/*=================================================================================*/
/*                                  VARIABLES                                      */
/*=================================================================================*/

DEFINE VARIABLE signo AS DECIMAL.

/*=================================================================================*/
/*                       ACUMULA LOS PAGOS POR ACTIVIDAD                           */
/*=================================================================================*/

IF ope = "A"
   THEN signo = 1.
   ELSE signo = ( - 1 ).

FIND Opg_header WHERE ROWID(Opg_header) = rid_opago NO-LOCK.

FOR EACH Pagos_x_actividad OF Opg_header NO-LOCK:

    FIND FIRST Acumulado_pagos
         WHERE Acumulado_pagos.cdg_empresa    = Opg_header.cdg_empresa
           AND Acumulado_pagos.nro_proveedor  = Opg_header.nro_proveedor
           AND Acumulado_pagos.ano            = YEAR(Opg_header.fecha)
           AND Acumulado_pagos.mes            = MONTH(Opg_header.fecha) 
           AND Acumulado_pago.cdg_tiporetgan  = Pagos_x_actividad.cdg_tiporetgan
               EXCLUSIVE-LOCK NO-ERROR.
    
    IF NOT AVAILABLE Acumulado_pagos
    THEN DO:
       CREATE Acumulado_pagos.
       ASSIGN Acumulado_pagos.cdg_empresa    = Opg_header.cdg_empresa
              Acumulado_pagos.nro_proveedor  = Opg_header.nro_proveedor
              Acumulado_pagos.ano            = YEAR(Opg_header.fecha)
              Acumulado_pagos.mes            = MONTH(Opg_header.fecha)
              Acumulado_pagos.cdg_tiporetgan = Pagos_x_actividad.cdg_tiporetgan.
    END.

    ASSIGN Acumulado_pagos.total_retganan  = Acumulado_pagos.total_retganan + signo * Pagos_x_actividad.imp_estareten
           Acumulado_pagos.total_pagado    = Acumulado_pagos.total_pagado + signo * Pagos_x_actividad.imp_estepago.

    IF Acumulado_pagos.total_pagado = 0
        THEN DELETE Acumulado_pagos.

END.
