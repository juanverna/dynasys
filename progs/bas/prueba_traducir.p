DEFINE VARIABLE v-nombre_tabla       AS CHARACTER INITIAL "Cliente"      FORMAT "X(30)".
DEFINE VARIABLE v-campo_clave        AS CHARACTER INITIAL "cdg_cliente"  FORMAT "X(30)".
DEFINE VARIABLE v-campo_descripcion  AS CHARACTER INITIAL "nom_cliente"  FORMAT "X(30)".
DEFINE VARIABLE v-valor_clave        AS CHARACTER INITIAL "B00001"       FORMAT "X(30)".
DEFINE VARIABLE v-valor_descripcion  AS CHARACTER FORMAT "X(30)".

REPEAT:

    UPDATE 
        v-nombre_tabla       
        v-campo_clave        
        v-valor_clave
        v-campo_descripcion.
    
    
    RUN traducir_tabla.p ( INPUT   v-nombre_tabla, 
                           INPUT   v-campo_clave, 
                           INPUT   v-campo_descripcion, 
                           INPUT   v-valor_clave, 
                           OUTPUT  v-valor_descripcion  ). 

    MESSAGE v-valor_descripcion
        VIEW-AS ALERT-BOX INFO BUTTONS OK.

END.
