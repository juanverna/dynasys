&IF DEFINED(MXP-PRESENTE) <> 0
&THEN

ON CHOOSE OF btn_mxp IN FRAME frm-entidad
DO:
   
   RUN {1}.P ( INPUT "A" ,
               INPUT-OUTPUT rid_gl-account,
               OUTPUT mxp_error). 
   
END.              

&ENDIF