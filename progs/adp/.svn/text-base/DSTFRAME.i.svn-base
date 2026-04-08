PROCEDURE ARREGLAR_FRAME:

  DEFINE VARIABLE delta_btn AS DECIMAL INITIAL 0.1.

  DO WITH FRAME {&FRAME-NAME}:
  
     btn_cancel:WIDTH  = ( {&BROWSE-NAME}:WIDTH - delta_btn * 11 ) / 4.

     btn_todas:WIDTH       = btn_cancel:WIDTH .
     btn_listados:WIDTH    = btn_cancel:WIDTH .
     btn_exit:WIDTH        = btn_cancel:WIDTH .

     btn_cancel:COLUMN     = {&BROWSE-NAME}:COLUMN  +  delta_btn * 4.
     btn_todas:COLUMN      = btn_cancel:COLUMN  + btn_cancel:WIDTH + delta_btn.
     btn_listados:COLUMN   = btn_todas:COLUMN  + btn_cancel:WIDTH + delta_btn.
     btn_exit:COLUMN       = btn_listados:COLUMN  + btn_cancel:WIDTH + delta_btn.


     rtn_botones:COLUMN    = {&BROWSE-NAME}:COLUMN .
     rtn_botones:WIDTH     = {&BROWSE-NAME}:WIDTH .
     IF btn_cancel:ROW - 0.1 >= 1
        THEN rtn_botones:ROW = btn_cancel:ROW - 0.1.
        ELSE rtn_botones:ROW = 1.

     {&BROWSE-NAME}:NUM-LOCKED-COLUMNS  = 5.
     
  END.   

END PROCEDURE.                                          