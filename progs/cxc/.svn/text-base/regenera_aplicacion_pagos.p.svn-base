/*====================================================================================*/
/*          REGENERA LA APLICACION DE PAGOS DE CUENTA CORRIENTE CLIENTES              */
/*====================================================================================*/

/*
DEFINE VARIABLE lista_cobradores AS CHARACTER INITIAL "855,948,949,950,951".
DEFINE VARIABLE j-cobrador AS INTEGER.

DEFINE BUFFER B-Cta_cte FOR Cta_cte.

DO j-cobrador = 1 TO NUM-ENTRIES(lista_cobradores,","):
 
   FIND Cobrador WHERE Cobrador.cdg_cobrador = ENTRY(j-cobrador,lista_cobradores,",") NO-LOCK.

FOR EACH Cobrador:

   FOR EACH Rec_header OF Cobrador WHERE Rec_header.tip_comprob = "RA" OR Rec_header.tip_comprob = "RB":
*/

   FOR EACH Rec_header WHERE Rec_header.tip_comprob = "RA" OR Rec_header.tip_comprob = "RB":

       FOR EACH Rec_detalle OF Rec_header:
       
            IF Rec_detalle.tip_cancela BEGINS "F"
            THEN DO: /* Facturas y N.Deb */
     
                 CREATE Aplicacion_pagos.
                 ASSIGN Aplicacion_pagos.cdg_empresa      = Rec_header.cdg_empresa
                        Aplicacion_pagos.importe          = Rec_detalle.importe
                        Aplicacion_pagos.descuento        = Rec_detalle.descuento
                        Aplicacion_pagos.tip_cancela      = Rec_detalle.tip_cancela
                        Aplicacion_pagos.prf_cancela      = Rec_detalle.prf_cancela
                        Aplicacion_pagos.nro_cancela      = Rec_detalle.nro_cancela
                        Aplicacion_pagos.nro_ven_cancela  = Rec_detalle.nro_vencimiento
                        Aplicacion_pagos.tip_comprob      = Rec_header.tip_comprob
                        Aplicacion_pagos.prf_comprob      = Rec_header.prf_comprob
                        Aplicacion_pagos.nro_comprob      = Rec_header.nro_comprob           
                        Aplicacion_pagos.nro_vencimiento  = 0.
     
            END.
       
       END.
 
   END.

/*
END.   
*/
