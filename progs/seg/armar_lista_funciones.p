/*==============================================================================*/
/*  DEVUELVE UNA LISTA CON TODAS LAS FUNCIONES QUE TIENE ASIGNADAS UN USUARIO   */
/*==============================================================================*/

  DEFINE INPUT PARAMETER p-cdg_usuario      LIKE Usuario.cdg_usuario.
  DEFINE OUTPUT PARAMETER p-lista_funciones AS CHARACTER.
  
/*==============================================================================*/
/*                            BLOQUE PRINCIPAL                                  */
/*==============================================================================*/

  FIND Usuario WHERE Usuario.cdg_usuario = p-cdg_usuario NO-LOCK.

  p-lista_funciones = "".
  FOR EACH Usuario_funcion OF Usuario NO-LOCK 
      WHERE Usuario_funcion.cdg_empresa = Usuario.cdg_empresa:

      p-lista_funciones = p-lista_funciones +  "," + Usuario_funcion.cdg_funcion.

  END.
  p-lista_funciones = SUBSTRING(p-lista_funciones,2).

  /*
      MESSAGE "usuario:" p-cdg_usuario SKIP "funciones:" p-lista_funciones
            VIEW-AS ALERT-BOX MESSAGE TITLE "armar_lista_funciones".
  */            
