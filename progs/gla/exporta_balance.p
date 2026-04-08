/*===============================================================================================*/
/*                       EXPORTA EL BALANCE A UN ARCHIVO TXT SEPARADO POR ";"                    */
/*===============================================================================================*/

DEFINE INPUT PARAMETER arch_salida AS CHARACTER.

OUTPUT TO VALUE(arch_salida) PAGE-SIZE 0.
PUT 
     "cdg_empresa" ";"
     "cdg_nombalance" ";"
     "linea" ";"

     "que_codigo" ";"
     "que_nombre" ";"

     "acm_creditos_per" ";"
     "acm_debitos_per" ";"
     "saldo_per" ";"

     "acm_creditos_tot" ";"
     "acm_debitos_tot" ";"
     "saldo_tot" ";" SKIP.

FOR EACH Lst_sumysal:
    PUT 
     Lst_sumysal.cdg_empresa      ";"
     Lst_sumysal.cdg_nombalance   ";"
     Lst_sumysal.linea            ";"

     Lst_sumysal.que_codigo       ";"
     Lst_sumysal.que_nombre       ";"

     Lst_sumysal.acm_creditos_per FORMAT "->>>,>>>,>>>,>>9.99" ";"
     Lst_sumysal.acm_debitos_per  FORMAT "->>>,>>>,>>>,>>9.99" ";"
     Lst_sumysal.saldo_per        FORMAT "->>>,>>>,>>>,>>9.99" ";"

     Lst_sumysal.acm_creditos_tot FORMAT "->>>,>>>,>>>,>>9.99" ";"
     Lst_sumysal.acm_debitos_tot  FORMAT "->>>,>>>,>>>,>>9.99" ";"
     Lst_sumysal.saldo_tot        FORMAT "->>>,>>>,>>>,>>9.99" ";" SKIP.
END.
