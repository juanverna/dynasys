
&SCOPED-DEFINE VACIO           ""

&SCOPED-DEFINE FRAME-INGRESO   frm-rango
&SCOPED-DEFINE EVENTO          U8
&SCOPED-DEFINE TABLA           Vendedor
&SCOPED-DEFINE CODIGO          cdg_Vendedor
&SCOPED-DEFINE NOMBRE          nombre
&SCOPED-DEFINE VAR-CODIGO      des_codigo
&SCOPED-DEFINE VAR-NOMBRE      des_nombre
&SCOPED-DEFINE RUTINA          SELVENDR
&SCOPED-DEFINE ROWID-TABLA     act_Vendedor
&SCOPED-DEFINE INDICE          cdg_Vendedor
&SCOPED-DEFINE ALFABETICO      alfabetico
{TRIGRANG.I}

ON VALUE-CHANGED OF ver_por IN FRAME frm-rango
DO:
   ASSIGN ver_por.
   
   IF ver_por = 1 
   THEN DO:  
      DISPLAY " " @ des_nombre
              WITH FRAME frm-rango.                      
      DISABLE des_nombre
              WITH FRAME frm-rango.   
      ENABLE  des_codigo
              WITH FRAME frm-rango.
   END.
   ELSE DO:
      DISPLAY " " @ des_codigo
              WITH FRAME frm-rango.                      
      DISABLE des_codigo
              WITH FRAME frm-rango.   
      ENABLE  des_nombre
              WITH FRAME frm-rango.
   END.
              
END.
