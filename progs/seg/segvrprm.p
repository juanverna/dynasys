/*=================================================================================*/
/*                   CHEQUEA LA SEGURIDAD POR USUARIO-PROGRAMA                     */
/*=================================================================================*/

/*DEFINE INPUT  PARAMETER quien_llama AS CHARACTER.*/
DEFINE INPUT  PARAMETER modo_llamada AS INTEGER.
DEFINE OUTPUT PARAMETER hay_permiso  AS LOGICAL INITIAL NO.

{VRSHARED.I "NEW"}

          /*=====================================*/
          /*      REMOVER PARA PRODUCCION        */
          /*=====================================*/

                    HAY_PERMISO = YES.
                    RETURN.

          /*=====================================*/
          /*                                     */
          /*=====================================*/

DEFINE VARIABLE quien_llama AS CHARACTER.
quien_llama = PROGRAM-NAME(2).
quien_llama = SUBSTRING(quien_llama,1,INDEX(quien_llama,".") - 1).

{findempresa.i}

/*---------- se autoriza la lista de administradores  para todo -----------------------*/
FIND Parametro OF Empresa WHERE Parametro.cdg_parametro = "LSTADMIN" NO-LOCK.
IF AVAILABLE Parametro THEN lista_admin = Parametro.valor_c. /* Toma ADMIN por defecto */
IF LOOKUP(Usuario.cdg_usuario,lista_admin) <> 0 
THEN DO:
   hay_permiso = YES.
   RETURN.
END.   

/*---------------------------------------------------------------------------*/

FIND Programa WHERE Programa.cdg_sigla-sic = quien_llama NO-LOCK NO-ERROR.
IF NOT AVAILABLE Programa
THEN DO:
   RUN PONMENSJ.P ( INPUT "SEGU001" ).
   /* QUIT. */ RETURN.
END.

IF CAN-FIND(FIRST Usuario_funcion OF Usuario 
                  WHERE CAN-DO(Usuario_funcion.cdg_empresa,Usuario.cdg_empresa)
                    AND Usuario_funcion.cdg_funcion = "SIC"
                    AND Usuario_funcion.permiso     = "A")
THEN DO:

          HAY_PERMISO = YES. 
          RETURN.

END.
   
FIND FIRST Usuario_funcion OF Usuario 
     WHERE Usuario_funcion.cdg_funcion = Programa.cdg_funcion 
       AND Usuario_funcion.cdg_empresa = Empresa.cdg_empresa
           NO-LOCK NO-ERROR.

IF AVAILABLE Usuario_funcion
THEN DO:
     IF Usuario_funcion.permiso = "D"  /* No hay permiso de acceso */
     THEN DO:
          RUN PONMENSJ.P ( INPUT "SEGU002" ).
          RETURN.
     END.                                                          
     ELSE DO: /* Hay permiso a la funcion, buscamos el programa */
          FIND FIRST Usuario_programa OF Usuario 
               WHERE Usuario_programa.modulo      = quien_llama 
                 AND Usuario_programa.cdg_empresa = Empresa.cdg_empresa
                     NO-LOCK NO-ERROR.      
          IF AVAILABLE Usuario_programa
          THEN DO:
              /* Hay Acceso a la funcion y no hay restricciones */
              IF Usuario_programa.permiso = "D"
              THEN DO:
                   RUN PONMENSJ.P ( INPUT "SEGU003" ).
                   RETURN.            
              END.
              ELSE DO:
            /* Hay Acceso a la funcion y hay restricciones */
                   IF LOOKUP(STRING(modo_llamada),Usuario_programa.modos_permitidos) = 0 AND
                             Usuario_programa.modos_permitidos <> "*"
                   THEN DO:
               /* Hay permiso para el programa, pero no para el modo */
                        RUN PONMENSJ.P ( INPUT "SEGU004" ).
                        RETURN.            
                   END.
              END.
          END.   
          ELSE DO:
              /* Hay Acceso a la funcion y no hay restricciones */
              /* Por lo que sale del IF con permiso             */
          END.
     END.
END.
ELSE DO:
   RUN PONMENSJ.P ( INPUT "SEGU002" ).
   /* QUIT. */ RETURN.
END.   

   /* Finalmente, nos damos por vencidos y, no habiendo podido retornar   */
   /* por ninguna de las condiciones de restriccion de acceso, bueno, que */
   /* lo ejecute nomas y listo.                                           */

                    HAY_PERMISO = YES. 
