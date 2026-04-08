PROCEDURE TRAER_EMPLEADO:

   IF NOT puso_empleado
   THEN DO:
   
     puso_empleado = YES.
     FIND Empleado USING FRAME frm-Empleado Empleado.nro_legajo EXCLUSIVE-LOCK NO-ERROR.

     IF NOT AVAILABLE Empleado
     THEN DO:
     
        CREATE Empleado.
        ASSIGN Empleado.nro_legajo.        
        ASSIGN Empleado.nro_empleado = NEXT-VALUE(proximo_Empleado).
               Empleado.fecha_ingreso = TODAY.
               
        DISPLAY Empleado.fecha_ingreso
                WITH FRAME frm-Empleado.
     END.
     ELSE DO:   
        FIND Provincia       OF Empleado.
        FIND Especialidad    OF Empleado.
        FIND C_Postal        OF Empleado.
        FIND Sexo            OF Empleado.
        FIND Estado_civil    OF Empleado.
        FIND Categoria       OF Empleado.
        IF Empleado.cdg_estado <> "" THEN FIND Estado OF Empleado.
        CLEAR FRAME frm-Empleado ALL.
        DISPLAY 
             Empleado.nro_legajo 
             Empleado.nombre   
             Empleado.nro_cuil 
             Empleado.fecha_ingreso   
             Empleado.fecha_baja   
             Empleado.cdg_estado
  
             Empleado.calle 
             Empleado.numero   
             Empleado.piso 
             Empleado.depto 
             Empleado.cdg_postal 
             Empleado.localidad   
             Empleado.cdg_provincia 
             Empleado.telefono   
             Empleado.zona

             Empleado.cdg_sexo 
             Empleado.tipo_doc 
             Empleado.numero_doc 
             Empleado.expedido_por 
             Empleado.fecha_nac 
             Empleado.cdg_est_civil 
             Empleado.lugar_nac 
             Empleado.nacionalid 
             Empleado.nom_madre 
             Empleado.nom_padre 

             Empleado.convenio 
             Empleado.carac_servicios 
             Empleado.cdg_categoria 
             Empleado.cdg_especialidad 
             Empleado.cdg_sector 
             Empleado.forma_de_pago 
             Empleado.cdg_banco   
             Empleado.cuenta_nro

             Empleado.jubilacion 
             Empleado.obra_social 
             Empleado.sindicato               
             WITH FRAME frm-Empleado.

     END.
     
     ENABLE ALL WITH FRAME frm-Empleado.
     act_Empleado = ROWID(Empleado).
     IF NEW Empleado THEN DISABLE Empleado.cdg_estado WITH FRAME frm-Empleado.
  END.
  ELSE DO:   
  
     act_empleado = ROWID(Empleado).
     IF CAN-FIND(Empleado USING FRAME frm-Empleado Empleado.nro_legajo 
                                WHERE act_Empleado <> ROWID(Empleado) NO-LOCK)
     THEN DO:
        BELL.
        MESSAGE "Ya existe un Empleado con ese legajo"
           VIEW-AS ALERT-BOX ERROR BUTTONS OK TITLE "Se ha detectado un error".
        RETURN.
     END.
         
  END.
  
END.  
