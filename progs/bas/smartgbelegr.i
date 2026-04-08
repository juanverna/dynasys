ON CHOOSE OF btn_elegir IN FRAME frm-entidad
DO:

   DEFINE VARIABLE j-elegir    AS INTEGER.
   DEFINE VARIABLE sel_codigos AS CHARACTER FORMAT "X(60)".
   DEFINE VARIABLE sel_nombres AS CHARACTER FORMAT "X(60)".
   DEFINE VARIABLE dis_nombres AS CHARACTER FORMAT "X(60)".
   DEFINE VARIABLE sel_todos   AS LOGICAL.

   sel_codigos = {1}.{2}.
   sel_todos = IF {1}.{2} = "*" THEN YES ELSE NO.
   sel_nombres = "".
   dis_nombres = "".
   FOR EACH {3} NO-LOCK BY {3}.{5}:
       IF LOOKUP({3}.{4},sel_codigos) <> 0 OR sel_todos
          THEN sel_nombres = sel_nombres + {3}.{5} + ",".
          ELSE dis_nombres = dis_nombres + {3}.{5} + ",".
   END.                                                               
   sel_nombres = SUBSTRING(sel_nombres,1,LENGTH(sel_nombres) - 1 ).   
   dis_nombres = SUBSTRING(dis_nombres,1,LENGTH(dis_nombres) - 1 ).   
   
   RUN d-selectar.w ( INPUT-OUTPUT sel_nombres,
                      INPUT-OUTPUT dis_nombres, 
                      INPUT "{6}").

   IF NUM-ENTRIES(dis_nombres) = 0 OR NUM-ENTRIES(dis_nombres) = ?
   THEN DO:
        sel_codigos = "*".
   END.
   ELSE DO:
        sel_codigos = "".
        DO j-elegir = 1 TO NUM-ENTRIES(sel_nombres):
           FIND FIRST {3} WHERE {3}.{5} = ENTRY(j-elegir,sel_nombres).
           sel_codigos = sel_codigos + {3}.{4} + ",".
        END.
        sel_codigos = SUBSTRING(sel_codigos,1,LENGTH(sel_codigos) - 1 ).   
   END.

   {1}.{2} = sel_codigos.
   DISPLAY {1}.{2} WITH FRAME frm-entidad.

END.

