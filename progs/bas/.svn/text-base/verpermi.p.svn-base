/*=================================================================================*/
/*                         VALIDA LA LICENCIA DE USO DE SIC                        */
/*=================================================================================*/

 /*
 DEFINE OUTPUT PARAMETER cod_aut AS INTEGER.
 */
 
 {vrshared.i}
 
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

  {findempresa.i}

/*RUN autoriza.p ( INPUT 0 , OUTPUT cod_aut).*/
  RUN autoriza.p ( INPUT 0 ).

  IF cod_aut <> 0
  THEN DO:
     BELL.
     MESSAGE "S.I.C. ha detectado un error de autorización, identificado con el" 
             "código " cod_aut ". Póngase en contacto con Computel S.A."
              VIEW-AS ALERT-BOX WARNING TITLE "ERROR DE AUTORIZACION".
  END.
  ELSE DO:
     IF Empresa.fecha_limite - TODAY < 15
     THEN DO:
        IF Empresa.fecha_limite < TODAY 
        THEN DO:
           cod_aut = 10.
           BELL.
           MESSAGE "Su licencia de uso de S.I.C. se halla expirada." SKIP
                   "Póngase en contacto con Computel S.A."
                 VIEW-AS ALERT-BOX WARNING TITLE "ACCESO AL SISTEMA DENEGADO".
        END.
        ELSE DO:
           BELL.
           MESSAGE "Su licencia de uso de S.I.C. expira en " STRING(Empresa.fecha_limite - TODAY) 
                   "dias. Póngase en contacto con Computel S.A. para extender el período de uso"
                 VIEW-AS ALERT-BOX WARNING TITLE "AVISO DE EXPIRACION".
        END.
     END.
  END.   
