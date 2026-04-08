{findempresa.i}
  que_empresa = Empresa.cdg_empresa. 
FIND Rem_header_prv WHERE Rem_header_prv.nro_remprov = {&TABLA-MAESTRA}.nro_remprov
                AND Rem_header_prv.cdg_empresa = que_empresa NO-LOCK NO-ERROR.

 IF AVAILABLE Rem_header_prv 
 THEN DO:
       ASSIGN
            v-transportista = Rem_header_prv.nom_transportista.
            v-tipo = Rem_header_prv.tip_comprob.
            v-prefijo = Rem_header_prv.prf_comprob.
            v-numero = Rem_header_prv.nro_comprob.
            
            FIND Area OF Rem_header_prv.
                 IF AVAILABLE Area THEN
                 ASSIGN v-sector = Area.denominacion.

                 FIND Proveedor OF Rem_header_prv.
                 IF AVAILABLE Proveedor THEN
                 ASSIGN v-proveedor = Proveedor.nombre.
          
                 DISPLAY
                    v-transportista 
                    v-tipo
                    v-prefijo
                    v-numero
                    v-sector
                    v-proveedor
                    WITH FRAME {&FRAME-NAME}.

  END.
    
       ELSE DO:
           ASSIGN
                 v-tipo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                 v-prefijo:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                 v-numero:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                 v-transportista:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                 v-sector:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
                 v-proveedor:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "".
       END.
