/*----------------------------------------------------------------------------------*/
/*                             CONFIGURACION DE LA PANTALLA                         */
/*----------------------------------------------------------------------------------*/

ON CTRL-G ANYWHERE 
DO:
  IF modo_configurar THEN RUN GRABAR_TABULACION.
                     ELSE BELL.
END.    

ON CTRL-F ANYWHERE 
DO:
  modo_configurar = NOT modo_configurar. 
  RUN CAMBIAR_MODO.
END.    

ON MOUSE-MENU-DOWN ANYWHERE
DO:
  RUN SETATRWG.P (INPUT SELF:HANDLE ).
END.  

ON END-MOVE ANYWHERE
DO:
  RUN END_MOVER.
END.  

ON START-MOVE ANYWHERE
DO:   
  RUN START_MOVER.
END.  