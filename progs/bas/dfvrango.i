DEFINE {1} SHARED VARIABLE ver_por AS INTEGER LABEL "Ordenado Por" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "{&LBL-CODIGO}",  1 , 
                                         "{&LBL-NOMBRE}", 0 INITIAL 0.

DEFINE {1} SHARED VARIABLE des_codigo   LIKE {&TABLA}.{&CODIGO} 
&IF DEFINED(LBL-TABLA) = 0
&THEN
    LABEL "Desde {&TABLA}".
&ELSE
    LABEL "Desde {&LBL-TABLA}".
&ENDIF        
DEFINE {1} SHARED VARIABLE has_codigo   LIKE {&TABLA}.{&CODIGO}
&IF DEFINED(LBL-TABLA) = 0
&THEN
    LABEL "Hasta {&TABLA}".
&ELSE
    LABEL "Hasta {&LBL-TABLA}".
&ENDIF        
DEFINE {1} SHARED VARIABLE des_nombre   LIKE {&TABLA}.{&NOMBRE}.
DEFINE {1} SHARED VARIABLE has_nombre   LIKE {&TABLA}.{&NOMBRE}.
