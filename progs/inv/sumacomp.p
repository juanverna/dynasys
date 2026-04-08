/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_articulo   AS ROWID.
DEFINE INPUT  PARAMETER rid_deposito   AS ROWID.
DEFINE OUTPUT PARAMETER com_cantidad   LIKE Cct_stock.cantidad.
DEFINE OUTPUT PARAMETER com_granel     LIKE Cct_stock.granel.

{VRSHARED.I }

/*=================================================================================*/
/*                       ACUMULA LAS REQUISICIONES PENDIENTES                      */
/*=================================================================================*/

FIND Articulo WHERE ROWID(Articulo) = rid_articulo NO-LOCK.
FIND Deposito WHERE ROWID(Deposito) = rid_deposito NO-LOCK.

ASSIGN
   com_cantidad  = 0
   com_granel    = 0.

FOR EACH Rqs_detalle OF Articulo 
    WHERE Rqs_detalle.cdg_estado <> "CC" 
      AND Rqs_detalle.cdg_estado <> "CA"
      AND Rqs_detalle.cdg_estado <> "ZZ", 
    FIRST Rqs_header OF Rqs_detalle 
          WHERE Rqs_header.cdg_deposito-rep = Deposito.nro_deposito 
            AND Rqs_header.es_reposicion NO-LOCK:

    IF Rqs_detalle.cdg_estado = "IN"
       THEN ASSIGN
                  com_cantidad  = com_cantidad + Rqs_detalle.cantidad_sol
                  com_granel    = com_granel   + Rqs_detalle.granel_sol.
       ELSE ASSIGN
                  com_cantidad  = com_cantidad + Rqs_detalle.cantidad
                  com_granel    = com_granel   + Rqs_detalle.granel.

END.

