DEFINE VARIABLE j AS INTEGER.
DEFINE VARIABLE v-cambio AS CHARACTER. 
DEFINE BUFFER Viejo FOR Cobrador.
DEFINE BUFFER Nuevo FOR Cobrador.

v-cambio = v-cambio +  "007:AMAR,006:AMAR,002:MGUG,003:MGUG,012:CFER,015:AMAR,016:AMAR,017:AMAR,451:JPER,100:MGUG,011:CFER,".    
v-cambio = v-cambio +  "011:CFER,453:JPER,454:JPER,452:JPER,460:JPER,050:JPER,053:JPER,052:JPER,051:JPER,301:MGUG,288:CFER,".
v-cambio = v-cambio +  "291:CDAL,290:CDAL,292:CDAL,293:CDAL,294:CDAL,295:CDAL,455:JPER,296:CDAL,297:CDAL,462:CDAL,501:DGOM,".
v-cambio = v-cambio +  "502:DGOM,504:DGOM,503:DGOM,101:MGUG,102:MGUG,103:MGUG,010:CFER,013:CFER,021:CDAL,022:CDAL,023:CDAL,".
v-cambio = v-cambio +  "024:CDAL,025:CDAL,026:DGOM,027:DGOM,028:DGOM,029:DGOM,033:JPER,034:JPER,035:JPER,036:JPER,037:JPER,".
v-cambio = v-cambio +  "038:JPER,039:JPER,040:JPER".    

DO j = 1 TO NUM-ENTRIES(v-cambio,","):

  FIND Viejo WHERE Viejo.cdg_cobrador = ENTRY(1,ENTRY(j,v-cambio,","),":").
  FIND Nuevo WHERE Nuevo.cdg_cobrador = ENTRY(2,ENTRY(j,v-cambio,","),":").

  DISPLAY j ENTRY(j,v-cambio,",") ENTRY(1,ENTRY(j,v-cambio,","),":") ENTRY(2,ENTRY(j,v-cambio,","),":") WITH FRAME AA DOWN.

  FOR EACH Cliente OF Viejo:
      Cliente.nro_cobrador = Nuevo.nro_cobrador.
  END.    

  FOR EACH Rec_header OF Viejo:
      Rec_header.nro_cobrador = Nuevo.nro_cobrador.
  END.    

  FOR EACH Cta_cte OF Viejo:
      Cta_cte.nro_cobrador = Nuevo.nro_cobrador.
  END.    
  
  DOWN WITH FRAME AA.

END.  
