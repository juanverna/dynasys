       CREATE Asiento_auditoria.  
       ASSIGN Asiento_auditoria.cdg_estadoasiento  = Asn_header.cdg_estadoasiento
              Asiento_auditoria.fch_cambio         = TODAY
              Asiento_auditoria.hor_cambio         = TIME
              Asiento_auditoria.hms_cambio         = STRING(Asiento_auditoria.hor_cambio,"HH:MM:SS")
              Asiento_auditoria.nro_asiento        = Asn_header.nro_asiento
              Asiento_auditoria.nro_usuario        = Asn_header.nro_usuario
              Asiento_auditoria.observacion        = "".
       
       RELEASE Asiento_auditoria.
