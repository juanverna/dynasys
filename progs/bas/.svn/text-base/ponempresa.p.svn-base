DEFINE INPUT PARAMETER codigo LIKE sic.Empresa.cdg_empresa.
FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") EXCLUSIVE-LOCK.
Usuario.cdg_empresa = codigo.
