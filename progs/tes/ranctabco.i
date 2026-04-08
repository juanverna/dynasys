DEFINE {1} SHARED VARIABLE ver_por AS INTEGER LABEL "Ordenado Por" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Código",  1 , "Denominación", 0 INITIAL 1.
DEFINE {1} SHARED VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE {1} SHARED VARIABLE por_nom AS INTEGER INITIAL 0.
DEFINE {1} SHARED VARIABLE des_codigo LIKE Cuenta_bancaria.cdg_cuenta_ban  LABEL "Desde Cuenta".
DEFINE {1} SHARED VARIABLE has_codigo LIKE Cuenta_bancaria.cdg_cuenta_ban  LABEL "Hasta Cuenta".
DEFINE {1} SHARED VARIABLE des_nombre LIKE Cuenta_bancaria.denominacion_cta.
DEFINE {1} SHARED VARIABLE has_nombre LIKE Cuenta_bancaria.denominacion_cta.
DEFINE QUERY qry_Cuenta_bancaria FOR Cuenta_bancaria.
