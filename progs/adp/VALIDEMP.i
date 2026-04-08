PROCEDURE VALIDAR_MEDICO:

     hay_error = YES.

     IF ROWID(Empleado) = ?
     THEN DO:
        RUN PONMENSJ (INPUT "EMPL000").
        RETURN.
     END.

     IF INPUT Empleado.nombre = "" OR INPUT Empleado.nombre = ?  
     THEN DO:
        RUN PONMENSJ (INPUT "EMPL001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Empleado 
                       WHERE Empleado.nro_legajo = INPUT FRAME frm-empleado Empleado.nro_legajo  
                         AND ROWID(Empleado) <> act_empleado )
     THEN DO:
        RUN PONMENSJ (INPUT "EMPL002").
        RETURN.
     END.            
     
{IFNOTAVA.I "Especialidad" "cdg_especialidad" "EMPL003" }
{IFNOTAVA.I "C_Postal" "cdg_postal" "EMPL004" }
{IFNOTAVA.I "Sexo" "cdg_sexo" "EMPL005" }
{IFNOTAVA.I "Banco" "cdg_banco" "EMPL006" }

     hay_error = NO.
   
END.
