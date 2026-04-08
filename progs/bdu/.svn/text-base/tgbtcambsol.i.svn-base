   Sre_header.cdg_estado = "{1}".
   FOR EACH Sre_detalle EXCLUSIVE-LOCK OF Sre_header:
       Sre_detalle.cdg_estado = "{1}".
   END.   
   FIND CURRENT Sre_header NO-LOCK.

   RUN dispatch IN THIS-PROCEDURE ( INPUT 'display-fields').

   /*------------------------------------------------------------------------
       Indicamos al browse que debe reflejar el cambio de estado
   ------------------------------------------------------------------------*/

   RUN get-link-handle IN adm-broker-hdl
       (THIS-PROCEDURE, 'Record-Source':U, OUTPUT c_handle).
   IF NUM-ENTRIES (c_handle) eq 1 THEN DO:
      h_handle = WIDGET-HANDLE (c_handle).
      RUN refrescar_browse IN h_handle.
   END.

