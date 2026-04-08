/*---------------------------------------------*/
/* Crea la aditoria del registro de parametros */        
/*---------------------------------------------*/

CREATE T-Parametro.
BUFFER-COPY Parametro TO T-Parametro.
RUN crear_auditoria_parametros.p ( INPUT TABLE T-Parametro ).
EMPTY TEMP-TABLE T-Parametro.
