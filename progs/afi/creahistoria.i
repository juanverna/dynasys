    DO:
       CREATE {&HISTORICA}.
       BUFFER-COPY {&MAESTRO} TO {&HISTORICA} 
              ASSIGN {&HISTORICA}.fecha_cambio = TODAY
                     {&HISTORICA}.hora_cambio  = STRING(TIME,"HH:MM:SS")
                     {&HISTORICA}.user_cambio  = USERID("sic").
       RELEASE {&HISTORICA}.              
    END.
