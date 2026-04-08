   DEFINE VARIABLE j-elegir    AS INTEGER.
   DEFINE VARIABLE sel_codigos AS CHARACTER FORMAT "X(60)".
   DEFINE VARIABLE sel_nombres AS CHARACTER FORMAT "X(60)".

   sel_codigos = {1}.{2}.
   IF sel_codigos = "*" THEN sel_codigos = "".
   DO j-elegir = 1 TO NUM-ENTRIES(sel_codigos):
      FIND FIRST {3} WHERE {3}.{4} = ENTRY(j-elegir,sel_codigos).
      sel_nombres = sel_nombres + {3}.{5} + ",".
   END.                                                               
   sel_nombres = SUBSTRING(sel_nombres,1,LENGTH(sel_nombres) - 1 ).   
   
   RUN {6} ( INPUT-OUTPUT sel_nombres ).

   sel_codigos = "".
   DO j-elegir = 1 TO NUM-ENTRIES(sel_nombres):
      FIND FIRST {3} WHERE {3}.{5} = ENTRY(j-elegir,sel_nombres).
      sel_codigos = sel_codigos + {3}.{4} + ",".
   END.
   sel_codigos = SUBSTRING(sel_codigos,1,LENGTH(sel_codigos) - 1 ).   
   DISPLAY sel_codigos @ {1}.{2} WITH FRAME {&FRAME-NAME}.
