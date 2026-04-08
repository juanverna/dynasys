DEF VAR ca AS INT.
DEF VAR cc AS INT.
FOR EACH articulo:
    ca = ca + 1.

END.
FOR EACH clase_de_articulo WHERE NUM-ENTRIES(cdg_subclase,".") = 7:
    cc = cc + 1.
END.
MESSAGE ca cc ca + cc
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
