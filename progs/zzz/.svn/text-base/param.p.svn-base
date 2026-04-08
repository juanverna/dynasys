DEFINE VARIABLE listap AS CHARACTER INITIAL "FRMETIQE,IMAGENBG,NCOPIFPR,NFFACPRO,NFRBDUCL,NFRBDUPV,NFRBDUTR".
DEFINE VARIABLE j      AS INTEGER.

OUTPUT TO "c:\sic-temp\crear_parametros.p" PAGE-SIZE 0.
DO j = 1 TO NUM-ENTRIES(listap,","):
    FIND Parametro WHERE Parametro.cdg_empresa = "M" AND Parametro.cdg_parametro = ENTRY(j,listap,",") NO-ERROR.
    IF NOT AVAILABLE Parametro THEN MESSAGE ENTRY(j,listap,",") VIEW-AS ALERT-BOX MESSAGE.
    PUT UNFORMATTED "RUN crea_parametro.p ( "  
       " INPUT '" Parametro.cdg_empresa   "',"
       " INPUT '" Parametro.cdg_parametro "',"
       " INPUT '" Parametro.cdg_sigla-sic "',"
       " INPUT '" Parametro.descripcion   "',"
       " INPUT '" Parametro.observacion   "',"
       " INPUT '" Parametro.tipo          "',"
       " INPUT '" Parametro.valor_c       "',"
       " INPUT " Parametro.valor_d       ","
       " INPUT '" Parametro.valor_l       "',"
       " INPUT " Parametro.valor_n       ")." SKIP.

END.

