/*

        PROCESO DE HABILITACION DE PANELES Y FOLDERS EN INGRESO/CONSULTA DE SOLICITUDES

*/

  
IF AVAILABLE Sre_header
THEN DO:

    DEFINE VARIABLE page-hdl      AS HANDLE.
    DEFINE VARIABLE c-handle      AS CHARACTER.
    
    RUN get-link-handle IN adm-broker-hdl
                  (THIS-PROCEDURE, 'CONTAINER-SOURCE',OUTPUT c-handle).
    
    page-hdl = WIDGET-HANDLE(c-handle).
    
    IF VALID-HANDLE(page-hdl)
    THEN DO:
    
      RUN poner-alt-mod IN page-hdl (NO).
      RUN poner-mod-mod IN page-hdl (NO).
      RUN poner-mod-mod-alt IN page-hdl (NO).
    
      IF es_header THEN /*si es detalle ya tengo el Sre_header*/
            FIND FIRST Sre_detalle OF Sre_header NO-LOCK NO-ERROR.
      IF NOT AVAILABLE Sre_detalle THEN DO:
    
          RUN set-estado-registrables IN page-hdl ( NO ).
          RUN poner_estado_paneles IN page-hdl ( NO ).
          
          IF Sre_header.cdg_estado = "XX" 
          THEN DO: 
               RUN poner-alt-mod IN page-hdl (YES).
          END.
      END.
      ELSE DO:
    
          FIND Articulo OF Sre_detalle NO-LOCK NO-ERROR.
          IF AVAILABLE Articulo THEN DO:
    
              IF Articulo.es_registrable = NO THEN 
                  RUN set-estado-registrables IN page-hdl ( NO ).
              ELSE 
                  RUN set-estado-registrables IN page-hdl ( YES ).
    
              IF Articulo.es_registrable AND Sre_header.cdg_estado = "XX" 
                  THEN DO:
    
                  FIND FIRST Registrable-solicitud OF Sre_detalle NO-LOCK NO-ERROR.
                  IF AVAILABLE Registrable-solicitud 
                      THEN RUN poner_estado_paneles IN page-hdl ( YES ).
                  ELSE DO: 
                      RUN poner_estado_paneles IN page-hdl ( NO ).
                      RUN poner-mod-mod-alt IN page-hdl (YES).
                  END.
              END.
              ELSE IF NOT Articulo.es_registrable AND Sre_header.cdg_estado = "XX" THEN DO:
                  RUN poner_estado_paneles IN page-hdl ( NO ).
                  RUN poner-mod-mod IN page-hdl (YES).              
              END.
              ELSE 
                  RUN poner_estado_paneles IN page-hdl ( NO ).
    
          END.
      END.
    
    END.
END.
