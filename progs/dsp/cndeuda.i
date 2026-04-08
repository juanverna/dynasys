
   /*------------------------------------------------------------------------*/
   /*                  VERIFICACION DE LOS NIVELES DE CREDITO                */
   /*------------------------------------------------------------------------*/

  estado_credito = "".
/*
         message "revisa deuda cntl:" string(cntrl_deuda)
                view-as alert-box message title "cndeuda.i".
*/
  CASE cntrl_deuda:

       WHEN 0  /* No hay control de deuda */
       THEN DO:
               /* No hay acciones a tomar */
       END.
       
       WHEN 1 /* Solo verifica que haya deuda vencida o credito suficiente */
       THEN DO:
            RUN SUMSTCRE.P ( INPUT ROWID(Cliente),
                             OUTPUT saldo_cc,
                             OUTPUT saldo_ccv,
                             OUTPUT tot_valores,
                             OUTPUT tot_remitos,
                             OUTPUT tot_pedidos,
                             OUTPUT cant_rech,
                             OUTPUT tot_credito ).

            IF saldo_ccv <> 0 THEN RUN PONMENSJ.P ( INPUT "{1}" ).

            IF Cliente.credito_maximo < tot_credito 
            THEN DO:
                 RUN PONMENSJ.P ( INPUT "{2}" ).
                 RUN d-verstcre.w ( INPUT ROWID(Cliente),
                                    INPUT saldo_cc,
                                    INPUT saldo_ccv,
                                    INPUT tot_valores,
                                    INPUT tot_remitos,
                                    INPUT tot_pedidos,
                                    INPUT cant_rech,
                                    INPUT tot_credito ).
            END.

       END.

       WHEN 2 /* Verifica que no haya deuda vencida y sea suficiente el credito pero procede */
       THEN DO:

            RUN SUMSTCRE.P ( INPUT ROWID(Cliente),
                             OUTPUT saldo_cc,
                             OUTPUT saldo_ccv,
                             OUTPUT tot_valores,
                             OUTPUT tot_remitos,
                             OUTPUT tot_pedidos,
                             OUTPUT cant_rech,
                             OUTPUT tot_credito ).

            IF Cliente.credito_maximo < tot_credito 
            THEN DO:
                 estado_credito = stped_creditoins.
                 RUN PONMENSJ.P ( INPUT "{1}" ).
                 RUN VERSTCRE.P ( INPUT 1 ).
            END.

            IF saldo_ccv <> 0 
            THEN DO:
                 estado_credito = stped_deuvencida.
                 RUN PONMENSJ.P ( INPUT "{2}" ).
            END.     

            IF cant_rech <> 0 
            THEN DO:
                 estado_credito = stped_chequerech.
                 RUN PONMENSJ.P ( INPUT "{3}" ).
            END.     

       END.

       WHEN 3 /* Verifica que no haya deuda vencida y sea suficiente el credito 
                 pero NO PROCEDE  */
       THEN DO:

            RUN SUMSTCRE.P ( INPUT ROWID(Cliente),
                             OUTPUT saldo_cc,
                             OUTPUT saldo_ccv,
                             OUTPUT tot_valores,
                             OUTPUT tot_remitos,
                             OUTPUT tot_pedidos,
                             OUTPUT cant_rech,
                             OUTPUT tot_credito ).

            IF Cliente.credito_maximo < tot_credito 
            THEN DO:
                 estado_credito = stped_creditoins.
                 RUN PONMENSJ.P ( INPUT "{1}" ).
                 RUN VERSTCRE.P ( INPUT 1 ).
                 no_aplicar = YES.
                 RETURN.
            END.

            IF saldo_ccv <> 0 
            THEN DO:
                 estado_credito = stped_deuvencida.
                 RUN PONMENSJ.P ( INPUT "{2}" ).
                 no_aplicar = YES.
                 RETURN.
            END.     

            IF cant_rech <> 0 
            THEN DO:
                 estado_credito = stped_chequerech.
                 RUN PONMENSJ.P ( INPUT "{3}" ).
                 no_aplicar = YES.
                 RETURN.
            END.     

       END.

  END CASE.  
