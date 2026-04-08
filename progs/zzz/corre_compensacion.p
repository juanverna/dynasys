FOR EACH caj_detalle WHERE cdg_rubro = 40, caj_header OF caj_detalle:
    RUN zzz\completa_compensacion_cta_cte.p ( INPUT ROWID(caj_header)).
END.
