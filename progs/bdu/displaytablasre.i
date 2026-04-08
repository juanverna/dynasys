{findempresa.i}
  que_empresa = Empresa.cdg_empresa. 
FIND Sre_header WHERE Sre_header.nro_solicitud = {&TABLA-MAESTRA}.nro_solicitud
                AND Sre_header.cdg_empresa = que_empresa NO-LOCK NO-ERROR.

 IF AVAILABLE Sre_header 
 THEN DO:
        ASSIGN
             v-tipo-sol    = Sre_header.tip_comprob
             v-prefijo-sol = Sre_header.prf_comprob
             v-numero-sol  = Sre_header.nro_comprob.            

             FIND Empleado WHERE Sre_header.nro_empleado_sol = Empleado.nro_legajo NO-LOCK NO-ERROR.
             IF AVAILABLE Empleado THEN
             ASSIGN 
                 v-legajoynombre = STRING(Empleado.nro_legajo) + " - " + Empleado.nombre
                 v-email = Empleado.e-mail.

             FIND Destinatario OF Sre_header NO-LOCK NO-ERROR.
             IF AVAILABLE Destinatario THEN
                 ASSIGN
                    v-destinatario = Destinatario.dsc_destinatario.
      
             DISPLAY
                v-legajoynombre
                v-email
                v-tipo-sol
                v-prefijo-sol
                v-numero-sol
                v-destinatario
                WITH FRAME {&FRAME-NAME}.

  END.
    
       ELSE DO:
           ASSIGN
                 v-legajoynombre:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                 v-email:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                 v-tipo-sol:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                 v-prefijo-sol:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                 v-numero-sol:SCREEN-VALUE IN FRAME {&FRAME-NAME} = ""
                 v-destinatario:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       END.
