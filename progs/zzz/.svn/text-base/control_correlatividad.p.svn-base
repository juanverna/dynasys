DEFINE VARIABLE AA AS INTEGER.
 
FOR EACH FAC_HEADER WHERE tip_comprob = "FA" BY cdg_empresa BY tip_comprob BY prf_comprob BY nro_comprob:
    IF aa <> nro_comprob - 1 AND aa <> 0 THEN DISPLAY aa nro_comprob fac_header.fecha WITH STREAM-IO.
    aa = nro_comprob.
END.
