    FIND FIRST Tipocomprobante OF {3} NO-LOCK NO-ERROR. 
    IF   Tipocomprobante.debita THEN
        {1} = {1} + {3}.debito.
    ELSE
        {2} = {2} + {3}.credito.
         
