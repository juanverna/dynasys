FOR EACH Cliente WHERE CAN-FIND(FIRST Cta_cte OF Cliente), FIRST Grupofam OF Cliente:
    DISPLAY Cliente.cdg_cliente FORMAT "X(12)"
            Cliente.nom_cliente
            Grupofam.cdg_plan
            Grupofam.cant_capitas
            WITH CENTERED USE-TEXT FONT 2.
    FOR EACH Cta_cte OF Cliente:
         display cta_cte.tip_comprob prf_comprob nro_comprob debito credito
            WITH CENTERED USE-TEXT FONT 2.
    END.
END.                     
