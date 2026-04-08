/*===============================================================================================================================*/
/*                          PONE EN CERO LA CANTIDAD DE USUARIOS ACTUALES PARA TODOS LOS MÓDULOS                                 */
/*===============================================================================================================================*/  

DO TRANSACTION:
  FOR EACH Modulo-sic EXCLUSIVE-LOCK.
      Modulo-sic.usuarios_actuales = 0.
      Modulo-sic.usuarios_conectados = "".
      Modulo-sic.estaciones_conectadas = "".
  END.
END.
MESSAGE "SE RESETEO LA CUENTA DE USUARIOS CONECTADOS A DYNASYS" VIEW-AS ALERT-BOX INFORMATION TITLE "OPERACION COMPLETADA".

