DEFINE VARIABLE v-pc_name AS CHARACTER.
{findempresa.i}

RUN pcname1.p ( OUTPUT v-pc_name ).
MESSAGE "Estacion:" v-pc_name SKIP "Usuario:" Usuario.cdg_usuario SKIP "Empresa:" Empresa.cdg_empresa 
    VIEW-AS ALERT-BOX MESSAGE TITLE "Datos de la conexión".
