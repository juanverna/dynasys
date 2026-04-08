FOR EACH SIC.Usuario WHERE SIC.Usuario.cdg_usuario <> "carlos":

        FIND SIC._User WHERE SIC._User._Userid = SIC.Usuario.cdg_usuario EXCLUSIVE-LOCK NO-ERROR.
        IF NOT AVAILABLE SIC._User
        THEN DO:
             CREATE SIC._User.
             ASSIGN SIC._User._Userid    = SIC.Usuario.cdg_usuario.
        END.        
     
        ASSIGN
               SIC._User._User-name = SIC.Usuario.nombre
               SIC._User._password  = SIC.Usuario.clave.
               
        RELEASE SIC._User.       

END.
