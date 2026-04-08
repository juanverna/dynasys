/*=================================================================================*/
/*           CALCULA EL STOCK DE UN ARTICULO A UNA DETERMINADA FECHA               */
/*=================================================================================*/

DEFINE INPUT  PARAMETER rid_articulo   AS ROWID.
DEFINE INPUT  PARAMETER rid_deposito   AS ROWID.
DEFINE INPUT  PARAMETER rid_partida    AS ROWID.
DEFINE INPUT  PARAMETER que_fecha      AS DATE.
DEFINE INPUT  PARAMETER ficha          AS INTEGER.
DEFINE OUTPUT PARAMETER sal_cantidad   LIKE Cct_stock.cantidad.
DEFINE OUTPUT PARAMETER sal_granel     LIKE Cct_stock.granel.
DEFINE OUTPUT PARAMETER pre_cantidad   LIKE Cct_stock.cantidad.
DEFINE OUTPUT PARAMETER pre_granel     LIKE Cct_stock.granel.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I }
{dfmodoexist.i}

DEFINE VARIABLE total_i_un             LIKE Cct_stock.cantidad.
DEFINE VARIABLE total_e_un             LIKE Cct_stock.cantidad.
DEFINE VARIABLE total_i_gr             LIKE Cct_stock.granel.
DEFINE VARIABLE total_e_gr             LIKE Cct_stock.granel.

DEFINE VARIABLE presup_i_un            LIKE Cct_stock.cantidad.
DEFINE VARIABLE presup_e_un            LIKE Cct_stock.cantidad.
DEFINE VARIABLE presup_i_gr            LIKE Cct_stock.granel.
DEFINE VARIABLE presup_e_gr            LIKE Cct_stock.granel.

DEFINE BUFFER B-Partida                FOR Partida.
DEFINE QUERY qry_movimiento            FOR Cct_stock, B-Partida.

/*=================================================================================*/
/*                      B L O Q U E   P R I N C I P A L                            */
/*=================================================================================*/

{findempresa.i}

FIND Articulo WHERE ROWID(Articulo) = rid_articulo.
IF ficha = dep OR ficha = dep_y_par 
    THEN FIND Deposito WHERE ROWID(Deposito) = rid_deposito NO-LOCK.
IF ficha = par OR ficha = dep_y_par 
    THEN FIND Partida WHERE ROWID(Partida) = rid_partida NO-LOCK.

RUN ABRE_QUERY.

ASSIGN
    total_i_un = 0
    total_e_un = 0
    total_i_gr = 0
    total_e_gr = 0
    presup_i_un = 0
    presup_e_un = 0
    presup_i_gr = 0
    presup_e_gr = 0.

GET FIRST qry_movimiento NO-LOCK.
DO WHILE AVAILABLE Cct_stock:

   IF Cct_stock.tipo_mov = "I"
   THEN DO:
      total_i_gr = total_i_gr + Cct_stock.granel.
      total_i_un = total_i_un + Cct_stock.cantidad.
   END.
   ELSE DO:
      total_e_gr = total_e_gr + Cct_stock.granel.
      total_e_un = total_e_un + Cct_stock.cantidad.
   END.

   IF Cct_stock.presupuestado <> ""
   THEN DO:
        IF Cct_stock.tipo_mov = "I"
        THEN DO:
           presup_i_gr = presup_i_gr + Cct_stock.granel.
           presup_i_un = presup_i_un + Cct_stock.cantidad.
        END.
        ELSE DO:
           presup_e_gr = presup_e_gr + Cct_stock.granel.
           presup_e_un = presup_e_un + Cct_stock.cantidad.
        END.
   END.
   
   GET NEXT qry_movimiento.    

END.     

ASSIGN 
    sal_cantidad = total_i_un  - total_e_un
    sal_granel   = total_i_gr  - total_e_gr
    pre_cantidad = presup_i_un - presup_e_un
    pre_granel   = presup_i_gr - presup_e_gr.

/*=================================================================================*/
/*                                  PROCEDIMIENTOS                                 */
/*=================================================================================*/

PROCEDURE ABRE_QUERY:

    CASE ficha:

       WHEN tod 
       THEN DO:
 
            OPEN QUERY qry_movimiento       
              FOR EACH Cct_stock OF Articulo 
                 WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                   AND Cct_stock.fecha <= que_fecha,
                  EACH B-Partida OF Cct_stock
                    BY Cct_stock.fecha BY B-Partida.cdg_partida . 

       END.

       WHEN dep 
       THEN DO:

            OPEN QUERY qry_movimiento       
              FOR EACH Cct_stock OF Articulo 
                 WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                   AND Cct_stock.fecha <= que_fecha
                   AND Cct_stock.nro_deposito = Deposito.nro_deposito,
                  EACH B-Partida OF Cct_stock
                    BY Cct_stock.fecha BY B-Partida.cdg_partida . 

       END.

       WHEN par 
       THEN DO:

            OPEN QUERY qry_movimiento       
              FOR EACH Cct_stock OF Articulo 
                 WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                   AND Cct_stock.fecha <= que_fecha
                   AND Cct_stock.nro_partida = Partida.nro_partida,
                  EACH B-Partida OF Cct_stock
                    BY Cct_stock.fecha. 

      END.

       WHEN dep_y_par 
       THEN DO:

            OPEN QUERY qry_movimiento       
              FOR EACH Cct_stock OF Articulo 
                 WHERE Cct_stock.cdg_empresa = Empresa.cdg_empresa
                   AND Cct_stock.fecha <= que_fecha
                   AND Cct_stock.nro_deposito = Deposito.nro_deposito                   
                   AND Cct_stock.nro_partida = Partida.nro_partida,
                  FIRST B-Partida OF Cct_stock
                    BY Cct_stock.fecha. 

      END.
      OTHERWISE
      DO:
          MESSAGE "No se reconoce el valor del modo de existencia:" ficha
              VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION".
      END.

  END CASE.

END PROCEDURE.
