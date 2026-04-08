   FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK NO-ERROR.
   FIND Empresa OF Usuario NO-LOCK NO-ERROR.
   IF NOT AVAILABLE Empresa
   THEN DO:
        MESSAGE "No se encontro la empresa de LOGIN. Accediendo a la primera empresa definida"
                VIEW-AS ALERT-BOX WARNING TITLE "Aviso!!!".
          FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.
          FIND Empresa OF Usuario NO-LOCK NO-ERROR.      
   END.
