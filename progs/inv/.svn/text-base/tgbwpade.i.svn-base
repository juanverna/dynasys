/*----------------------------------------------------------------------------------*/
/*             TRATAMIENTO DEL BROWSE DE PARTIDAS POR DEPOSITO                      */
/*----------------------------------------------------------------------------------*/

ON INSERT OF {1} IN FRAME {2}
DO:

   RUN CREAR_DETALLE.
   RETURN NO-APPLY.

END.   

ON DELETE OF {1} IN FRAME {2}
DO:

   RUN ELIMINAR_DETALLE.
   RETURN NO-APPLY.
   
END.   

ON RETURN, MOUSE-SELECT-DBLCLICK OF {1} IN FRAME {2}
DO:

   RUN CORREGIR_DETALLE.
   RETURN NO-APPLY.

END.   

