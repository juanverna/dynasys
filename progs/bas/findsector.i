   FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
   FIND FIRST User_empresa WHERE  User_empresa.nro_usuario = Usuario.nro_usuario
                             AND  User_empresa.cdg_empresa = Usuario.cdg_empresa
                                  NO-LOCK.
   FIND Area OF User_empresa NO-LOCK NO-ERROR.
   IF NOT AVAILABLE Area
   THEN DO:
        MESSAGE "No se encontro el area del usuario empresa."
                VIEW-AS ALERT-BOX WARNING TITLE "Aviso!!!".
   END.
