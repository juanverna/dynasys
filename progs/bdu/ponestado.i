  DO WITH FRAME {&FRAME-NAME}:

    ASSIGN
        Toggle-1
        Toggle-2
        Toggle-3
        Toggle-4
        Toggle-5
        Toggle-6
        Toggle-7
        Toggle-8
        Toggle-9.

    IF Toggle-1 THEN lista_estados = lista_estados + "," + "XX".
    IF Toggle-2 THEN lista_estados = lista_estados + "," + "IN".
    IF Toggle-3 THEN lista_estados = lista_estados + "," + "AA".
    IF Toggle-4 THEN lista_estados = lista_estados + "," + "RZ".
    IF Toggle-5 THEN lista_estados = lista_estados + "," + "Z".
    IF Toggle-6 THEN lista_estados = lista_estados + "," + "RE".
    IF Toggle-7 THEN lista_estados = lista_estados + "," + "PR".
    IF Toggle-8 THEN lista_estados = lista_estados + "," + "CU".
    IF Toggle-9 THEN lista_estados = lista_estados + "," + "FI".
  END.

  lista_estados = SUBSTRING(lista_estados,2).
