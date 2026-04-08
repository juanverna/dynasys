{HLPRNBCO.I}

ON VALUE-CHANGED OF ver_por IN FRAME frm-rango
DO:
   ASSIGN ver_por.
   
   IF ver_por = 1 
   THEN DO:  
      DISPLAY " " @ des_nombre
              " " @ has_nombre
              WITH FRAME frm-rango.                      
      DISABLE des_nombre
              has_nombre
              WITH FRAME frm-rango.   
      ENABLE  des_codigo
              has_codigo
              WITH FRAME frm-rango.
   END.
   ELSE DO:
      DISPLAY " " @ des_codigo
              " " @ has_codigo
              WITH FRAME frm-rango.                      
      DISABLE des_codigo
              has_codigo
              WITH FRAME frm-rango.   
      ENABLE  des_nombre
              has_nombre
              WITH FRAME frm-rango.
   END.
              
END.