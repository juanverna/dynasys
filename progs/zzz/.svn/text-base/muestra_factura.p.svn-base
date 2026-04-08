
DEFINE VARIABLE v-cdg_empresa LIKE Fac_header.cdg_empresa. 
DEFINE VARIABLE v-tip_comprob LIKE Fac_header.tip_comprob. 
DEFINE VARIABLE v-prf_comprob LIKE Fac_header.prf_comprob. 
DEFINE VARIABLE v-nro_comprob LIKE Fac_header.nro_comprob.

REPEAT:

    UPDATE  v-cdg_empresa FORMAT "X(1)"
            v-tip_comprob 
            v-prf_comprob 
            v-nro_comprob.

    FIND Fac_header WHERE Fac_header.cdg_empresa = v-cdg_empresa 
                      AND Fac_header.tip_comprob = v-tip_comprob 
                      AND Fac_header.prf_comprob = v-prf_comprob 
                      AND Fac_header.nro_comprob = v-nro_comprob 
                          NO-LOCK.
 
    DISPLAY Fac_header EXCEPT Fac_header.cdg_empresa Fac_header.tip_comprob Fac_header.prf_comprob Fac_header.nro_comprob fac_header.LEYENDA
                       WITH FRAME f SIDE-LABELS USE-TEXT 2 COLUMNS.
                  
