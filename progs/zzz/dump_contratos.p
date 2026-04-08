INPUT FROM c:\temp\contrato_hd.d.
FOR EACH contrato_hd:
    DELETE contrato_hd.
END.
REPEAT:
    CREATE contrato_hd.
    IMPORT contrato_hd.
END.
INPUT from c:\temp\contrato_dt.d.
FOR EACH contrato_dt:
    delete contrato_dt.
END.
REPEAT:
    CREATE contrato_dt.
    IMPORT contrato_dt.
END.

