/*====================================================================================*/
/*           INICIALIZA EL REGISTRO DE MOVIMIENTOS DE STOCK                           */
/*====================================================================================*/

FOR EACH cct_stock WHERE Cct_stock.fecha <= 12/31/2005:
    DELETE cct_stock.
END.

FOR EACH sub_header_inv WHERE sub_header_inv.fecha <= 12/31/2005 :
    FOR EACH sub_detalle_inv OF sub_header_inv:
        DELETE sub_detalle_inv.
    END.
    DELETE sub_header_inv.
END.


MESSAGE "termino"
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
