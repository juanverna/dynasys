/*levanta combo empresa.i*/
     lista = "".
     {4}:DELIMITER = "|".

     FOR EACH {1} WHERE CAN-DO({1}.{5}, {6}) NO-LOCK BY {1}.{2}:
         lista = lista + "|" + TRIM({1}.{2}) + "|" + STRING({1}.{3}).
     END.
     lista = SUBSTRING(lista,2).
     IF lista <> "" THEN
        {4}:LIST-ITEM-PAIRS = SUBSTRING(lista,2).
     IF NUM-ENTRIES(lista,"|") >= 2
     THEN DO:
         {4}:LIST-ITEM-PAIRS = lista.
         {4}:SCREEN-VALUE=ENTRY(2,lista,"|").
     END.
     IF NUM-ENTRIES(lista,"|") <= 2 THEN
        {4}:SENSITIVE = FALSE.

