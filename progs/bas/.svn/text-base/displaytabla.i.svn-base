
       FIND {1} WHERE {1}.{4} = {&TABLA-MAESTRA}.{5} NO-LOCK NO-ERROR.
       IF AVAILABLE {1}
       THEN DO:  
            ASSIGN
                 v-cdg_{1} = {1}.{2}
                 v-dsc_{1} = {1}.{3}.
            DISPLAY v-cdg_{1} 
                    v-dsc_{1}
                    WITH FRAME {&FRAME-NAME}.

       END.
       ELSE DO:
            ASSIGN
                 v-cdg_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                 v-dsc_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       END.     
