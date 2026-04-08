CASE ver_antes:

     WHEN 0
     THEN DO:
          RUN veresult.w ( INPUT dire_tmp + "{1}", INPUT 8).
     END.

     WHEN 1     
     THEN DO:
          RUN PROPRINT.P ( INPUT dire_tmp + "{1}").
     END.

     WHEN 2
     THEN DO:
          RUN veresult.w ( INPUT dire_tmp + "{1}", INPUT 8).
          RUN PROPRINT.P ( INPUT dire_tmp + "{1}").
     END.

END CASE.          
