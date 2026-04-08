     lista = "".
     {&OBJETO}:DELIMITER = "|".
     FOR EACH {&TABLA} NO-LOCK &IF DEFINED(CONDICION) <> 0 &THEN WHERE {&CONDICION} &ENDIF BY &IF DEFINED(ORDEN) > 0 &THEN {&ORDEN} &ELSE {&TABLA}.{&NOMBRE} &ENDIF :
         lista = lista + "|" + TRIM({&TABLA}.{&NOMBRE}) + "|" + STRING({&TABLA}.{&CODIGO}).
     END.
     lista = SUBSTRING(lista,2).

     IF num-entries(lista,"|") >= 2
     THEN DO:
         {&OBJETO}:LIST-ITEM-PAIRS = lista.
         {&OBJETO}:SCREEN-VALUE=ENTRY(2,lista,"|").
     END.
     IF NUM-ENTRIES(lista,"|") <= 2 THEN
        {&OBJETO}:SENSITIVE = FALSE.
