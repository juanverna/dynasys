  IF v-cdg_{1}:SCREEN-VALUE IN FRAME {&FRAME-NAME} <> ""
  THEN DO:
              /*    {msg.i "ejecuta trigger" "traducetabla.i"}*/

        {findempresa.i}

        FIND {1} WHERE {1}.{2} = INPUT FRAME {&FRAME-NAME} v-cdg_{1}
                AND {1}.{4} = Empresa.cdg_empresa NO-LOCK NO-ERROR.
        IF NOT AVAILABLE {1} 
        THEN DO:
             RUN PONMENSJ.P ( 'IREF002' ).
             RETURN NO-APPLY.
        END.
        
        v-dsc_{1} = {1}.{3}.
        DISPLAY v-dsc_{1} 
                WITH FRAME {&FRAME-NAME}. 
        {&PONER-TABLA}    
  END.          
