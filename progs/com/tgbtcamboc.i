   ASSIGN FRAME {&FRAME-NAME} v-observacion.
   RUN {1}.P ( INPUT ROWID(Ocm_header), 
                    INPUT v-observacion, 
                    OUTPUT tiene_permiso ).
   IF tiene_permiso
   THEN DO:
        FIND CURRENT Ocm_header NO-LOCK.
        &IF DEFINED(PROCESO-ESTADO)
        &THEN
            {&PROCESO-ESTADO}
        &ENDIF
        RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields').
        v-observacion = "".
        DISPLAY v-observacion
                WITH FRAME {&FRAME-NAME}.
                
       /*------------------------------------------------------------------------
           Indicamos al browse que debe reflejar el cambio de estado
       ------------------------------------------------------------------------*/
  
       RUN get-link-handle IN adm-broker-hdl
           (THIS-PROCEDURE, 'Record-Source':U, OUTPUT c).
       IF NUM-ENTRIES (c) eq 1 THEN DO:
          h = WIDGET-HANDLE (c).
          RUN refrescar_browse IN h.
    
        END.
   END.                
