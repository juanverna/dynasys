DEFINE VAR pcnombre AS CHAR.

SETUSERID("Fernando","hymperion","SIC").
FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic")  NO-LOCK NO-ERROR.
RUN pcname1.p ( OUTPUT pcnombre ).
  IF NOT CAN-DO(Usuario.estaciones_habilitadas,pcnombre) 
  THEN DO:
      RUN ponmensj.p ( INPUT "SEGU009" ).
      RETURN.
  END.
  DO TRANSACTION:

      FIND CURRENT Usuario EXCLUSIVE-LOCK.  
      Usuario.lista_empresas = "".
      FOR EACH User_empresa OF Usuario 
          WHERE User_empresa.rige_desde <= today
            AND User_empresa.rige_hasta >= today
            AND CAN-FIND(FIRST Empresa OF User_empresa) NO-LOCK:

                Usuario.lista_empresas = Usuario.lista_empresas + "," + User_empresa.cdg_empresa.

      END.

      Usuario.lista_empresas = SUBSTRING(Usuario.lista_empresas,2).
      Usuario.cdg_empresa = ENTRY(1,Usuario.lista_empresas,",").
      Usuario.cambiar_clave = NO.
      Usuario.fch_ultimologin = today.

      FIND FIRST Logusuario OF Usuario WHERE Logusuario.abierta EXCLUSIVE-LOCK NO-ERROR.

      IF AVAILABLE Logusuario
      THEN DO:
          ASSIGN Logusuario.abierta    = NO
                 Logusuario.fch_hasta  = today
                 Logusuario.hor_hasta  = TIME
                 Logusuario.hms_hasta  = STRING(Logusuario.hor_hasta,"HH:MM:SS").
      END.

      CREATE Logusuario.
      ASSIGN Logusuario.abierta          = YES
             Logusuario.cdg_empresa      = Usuario.cdg_empresa
             Logusuario.fch_desde        = today
             Logusuario.hor_desde        = TIME
             Logusuario.hms_desde        = STRING(Logusuario.hor_desde,"HH:MM:SS")
             Logusuario.fch_hasta        = ?
             Logusuario.hor_hasta        = ?
             Logusuario.hms_hasta        = ?
             Logusuario.fecha_sistema    = today
             Logusuario.nro_sesion       = NEXT-VALUE(proxima_sesion)
             Logusuario.nro_usuario      = Usuario.nro_usuario
             Logusuario.parametros       = ""
             Logusuario.pc_name          = pcnombre.
      FIND CURRENT Usuario NO-LOCK.

      FIND Entidad WHERE Entidad.cdg_entidad = Usuario.cdg_empresa NO-LOCK.

  END.

MESSAGE "LISTO" userid("sic") VIEW-AS ALERT-BOX INFORMATION.
