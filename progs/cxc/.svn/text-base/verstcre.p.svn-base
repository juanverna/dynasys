/*===============================================================================*/
/*            MUESTRA EL ESTADO CREDITICIO DE UN DETERMINADO CLIENTE             */
/*===============================================================================*/

  DEFINE INPUT PARAMETER p-rid_cliente    AS ROWID.

  DEFINE VARIABLE saldo_cc       AS DECIMAL.
  DEFINE VARIABLE saldo_ccv      AS DECIMAL.
  DEFINE VARIABLE tot_valores    AS DECIMAL.
  DEFINE VARIABLE tot_remitos    AS DECIMAL.
  DEFINE VARIABLE tot_pedidos    AS DECIMAL.
  DEFINE VARIABLE cant_rech      AS INTEGER.
  DEFINE VARIABLE tot_credito    AS DECIMAL.


  RUN SUMSTCRE.P (  p-rid_cliente,
                    OUTPUT saldo_cc,
                    OUTPUT saldo_ccv,
                    OUTPUT tot_valores,
                    OUTPUT tot_remitos,
                    OUTPUT tot_pedidos,
                    OUTPUT cant_rech,
                    OUTPUT tot_credito ).

  RUN d-verstcre.w ( p-rid_cliente,
                     INPUT saldo_cc,
                     INPUT saldo_ccv,
                     INPUT tot_valores,
                     INPUT tot_remitos,
                     INPUT tot_pedidos,
                     INPUT cant_rech,
                     INPUT tot_credito ).
