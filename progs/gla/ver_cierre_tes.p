/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_empresa   LIKE Empresa.cdg_empresa.
DEFINE INPUT  PARAMETER p-fch_cierre    LIKE Cierre_diario.fch_cierre.
DEFINE OUTPUT PARAMETER p-cierre_ok     AS INTEGER.

/*==============================================================================================*/
/*         VERIFICACION DE POSIBILIDAD DE PROCEDER AL CIERRE CONTABLE POR CADA MODULO           */
/*==============================================================================================*/

p-cierre_ok = 3.

IF CAN-FIND(FIRST Cierre_diariocaja 
              WHERE Cierre_diariocaja.cdg_empresa = p-cdg_empresa
                AND Cierre_diariocaja.fch_cierre <= p-fch_cierre
                AND Cierre_diariocaja.cdg_estado_cierre = "0")
THEN DO:
    p-cierre_ok = 1.
    RETURN.
END.

IF CAN-FIND(FIRST Caj_header 
              WHERE Caj_header.cdg_empresa = p-cdg_empresa
                AND Caj_header.fecha = p-fch_cierre
                AND Caj_header.anulado = NO
                AND Caj_header.Contable = NO)
THEN DO:
    p-cierre_ok = 2.
    RETURN.
END.

