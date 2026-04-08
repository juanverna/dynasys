PROCEDURE ARREGLAR_FRAME:

  DEFINE VARIABLE nt_but         AS   INTEGER.
  DEFINE VARIABLE ancho_bt       AS   DECIMAL.
  DEFINE VARIABLE base_col       AS   DECIMAL.
  DEFINE VARIABLE base_row       AS   DECIMAL.

  DEFINE VARIABLE que_boton      AS WIDGET-HANDLE.
  DEFINE VARIABLE primero        AS WIDGET-HANDLE.
  DEFINE VARIABLE grupo          AS WIDGET-HANDLE.
  DEFINE VARIABLE proximo        AS WIDGET-HANDLE.

  nt_but = 0.
  grupo = FRAME {1}:FIRST-CHILD.
  proximo = grupo:FIRST-CHILD.
  DO WHILE proximo <> ?:   
     IF proximo:TYPE = "BUTTON" 
     THEN DO:
        nt_but = nt_but + 1.
        CREATE Boton.
        ASSIGN Boton.puntero = proximo:HANDLE
               Boton.orden   = nt_but.
     END.   
     proximo = proximo:NEXT-SIBLING.
  END.      
  ancho_bt = ( {2}:WIDTH - delta_btn * ( 2 * nt_but + 1 ) ) / nt_but.
  base_col = {2}:COLUMN.

  FOR EACH Boton BREAK BY Boton.orden WITH FRAME {1}:

      que_boton        = Boton.puntero.
      que_boton:WIDTH  = ancho_bt.
      que_boton:COLUMN = base_col + ( delta_btn + ancho_bt ) * ( Boton.orden - 1 ).
      IF FIRST(Boton.orden) THEN base_row = que_boton:ROW.
     
  END.
     
  rtn_botones:WIDTH = {2}:WIDTH .

  IF base_col - 0.1 >= 1
     THEN rtn_botones:COLUMN = base_col - 0.1 .
     ELSE rtn_botones:COLUMN = 1 .
     
  IF base_row - 0.1 >= 1
     THEN rtn_botones:ROW = base_row - 0.1.
     ELSE rtn_botones:ROW = 1.


END PROCEDURE.