/*==================================================================================*/
/*                     SUMA LOS DATOS DE UN ARTICULO                                */          
/*==================================================================================*/

DEFINE INPUT  PARAMETER rid_Articulo            AS ROWID.
DEFINE INPUT  PARAMETER des_fecha               AS DATE.
DEFINE INPUT  PARAMETER has_fecha               AS DATE.
DEFINE OUTPUT PARAMETER p-acm_granel            LIKE Lst_estadlin.acm_granel.
DEFINE OUTPUT PARAMETER p-acm_unidades          LIKE Lst_estadlin.acm_unidades.
DEFINE OUTPUT PARAMETER p-acm_subtotal_neto     LIKE Lst_estadlin.acm_subtotal_neto.
DEFINE OUTPUT PARAMETER p-acm_subtotal_bruto    LIKE Lst_estadlin.acm_subtotal_bruto.

FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.

OPEN QUERY q_ventas 
     FOR EACH Fac_detalle OF Articulo, 
              FIRST Fac_header OF Fac_detalle WHERE Fac_header.fecha <= has_fecha
                                                AND Fac_header.fecha >= des_fecha.

ASSIGN
    p-acm_granel         = 0 
    p-acm_unidades       = 0
    p-acm_subtotal_neto  = 0
    p-acm_subtotal_bruto = 0.

GET FIRST q_ventas.
DO WHILE AVAILABLE Fac_detalle:

   ASSIGN
        p-acm_granel         = p-acm_granel   + Fac_detalle.granel
        p-acm_unidades       = p-acm_unidades + Fac_detalle.cantidad
        p-acm_subtotal_neto  = p-acm_subtotal_neto + Fac_detalle.subtotal_neto
        p-acm_subtotal_bruto = p-acm_subtotal_bruto + Fac_detalle.subtotal_bruto.

   GET NEXT q_ventas.

END.    
