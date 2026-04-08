/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_empresa   LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-fch_cierre    LIKE Cierre_diario.fch_cierre.
DEFINE OUTPUT PARAMETER p-cierre_ok     AS INTEGER.

/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

    p-cierre_ok = 0.

    FOR EACH rendgastos_hd WHERE rendgastos_hd.fch_aprobacion  =   ?     AND 
                                 rendgastos_hd.anulado         =   NO    AND
                                 rendgastos_hd.cdg_estado      <>  "AN"  AND
                                 rendgastos_hd.fch_rendicion   <=  p-fch_cierre :
        FIND rendgastos_dt  OF rendgastos_hd NO-LOCK NO-ERROR.
        IF AVAILABLE rendgastos_dt  THEN
        DO:
           /*DISPLAY rendgastos_dt EXCEPT observacion.*/
           p-cierre_ok = 1.
        END.

    END.
