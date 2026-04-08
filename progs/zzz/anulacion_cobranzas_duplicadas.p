/*OUTPUT TO c:\temp\anulaciones3.*/
DEFINE BUFFER re FOR rendicion_hd.
    FOR EACH rendicion_hd WHERE Rendicion_hd.fch_rendicion >= 11/01/2012 AND Rendicion_hd.st_tesoreria <> "A" AND rendicion_hd.canal = "MD"
        BY rendicion_hd.nro_rendicion :
        FOR EACH re WHERE re.canal = "MD" AND 
            re.nro_admin = rendicion_hd.nro_admin AND 
            Rendicion_hd.fch_rendicion = Re.fch_rendicion AND
            re.st_tesoreria <> "A" AND
            ROWID(rendicion_hd) <> ROWID(re) AND
            re.nro_rendicion > rendicion_hd.nro_rendicion:
            FIND cliente WHERE cliente.nro_cliente = rendicion_hd.nro_admin.
            DISPLAY cdg_cliente rendicion_hd.nro_rendicion Re.fch_rendicion re.nro_rendicion re.st_tesoreria re.abierta .
           /* RUN desaplicar.p ( INPUT ROWID(re),yes, string(now) + "|" + userid + "|" + "Cobranza duplicada".*/
        END.

END.


