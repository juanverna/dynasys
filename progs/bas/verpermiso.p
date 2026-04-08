/*=================================================================================*/
/*                         VALIDA LA LICENCIA DE USO DE SIC                        */
/*=================================================================================*/

 DEFINE OUTPUT PARAMETER codigo_aut AS INTEGER.
 
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

  {findempresa.i}
  RUN autorizar_empresa.p ( INPUT 0 , OUTPUT codigo_aut).

  IF codigo_aut <> 0
  THEN DO:
     BELL.
     MESSAGE "DYNASYS ha detectado un error de autorización, identificado con el" 
             "código " codigo_aut ". Póngase en contacto con Sistemas Dinámicos S.A."
              VIEW-AS ALERT-BOX WARNING TITLE "ERROR DE AUTORIZACION".
  END.
  ELSE DO:
     IF Empresa.fecha_limite - TODAY < 15
     THEN DO:
        IF Empresa.fecha_limite < TODAY 
        THEN DO:
           codigo_aut = 10.
           BELL.
           MESSAGE "Su licencia de uso de DYNASYS se halla expirada." SKIP
                   "Póngase en contacto con Sistemas Dinámicos S.A."
                 VIEW-AS ALERT-BOX WARNING TITLE "ACCESO AL SISTEMA DENEGADO".
        END.
        ELSE DO:
           BELL.
           MESSAGE "Su licencia de uso de DYNASYS expira en " STRING(Empresa.fecha_limite - TODAY) 
                   "dias. Póngase en contacto con Sistemas Dinámicos S.A. para extender el período de uso"
                 VIEW-AS ALERT-BOX WARNING TITLE "AVISO DE EXPIRACION".
        END.
     END.
  END.   
