ON RETURN OF {1} IN FRAME {2}
DO:
   ASSIGN {1}.
   {3}
END.


ON  "+" OF {1} IN FRAME {2}
DO:

   {1} = {1} + 1.
   DISPLAY {1} WITH FRAME {2}.
   RETURN NO-APPLY.
      
END.

ON "-" OF {1} IN FRAME {2}
DO:

   {1} = {1} - 1.
   DISPLAY {1} WITH FRAME {2}.
   RETURN NO-APPLY.
      
END.

ON  UP-ARROW OF {1} IN FRAME {2}
DO:

   RUN SUMARMES.P (INPUT-OUTPUT {1}).
   DISPLAY {1} WITH FRAME {2}.
   RETURN NO-APPLY.
      
END.

ON DOWN-ARROW OF {1} IN FRAME {2}
DO:

   RUN RESTAMES.P (INPUT-OUTPUT {1}).
   DISPLAY {1} WITH FRAME {2}.
   RETURN NO-APPLY.
      
END.