  /*-------------------------------------------------------------------------------*/
  /* obtiene un nombre unico para un temporal sin extension  */
  /*-------------------------------------------------------------------------------*/

  FUNCTION que_temp RETURNS CHARACTER :

      DEFINE VARIABLE quien_llama AS CHARACTER.
      DEFINE VARIABLE v-valor_c AS CHARACTER.
      DEFINE VARIABLE arch_salida AS CHARACTER.
    
    
    
      RUN getparametro_c.p (  INPUT  "DIRECTMP",
                            OUTPUT v-valor_c
                             ).
    
      IF v-valor_c = ? THEN v-valor_c = SESSION:TEMP-DIRECTORY.
    
      quien_llama = SUBSTRING(PROGRAM-NAME(1),1,INDEX(PROGRAM-NAME(1),".") - 1).
      arch_salida = v-valor_c + quien_llama .
    
      
      RETURN arch_salida.
  END FUNCTION
