/*La rvalor contine para cada evento el valor de satisfaccion de la fecha en particular*/
DEFINE TEMP-TABLE rvalor NO-UNDO
    FIELD fecha AS DATE   /*fecha de analisis*/
    FIELD nro_evento LIKE evento.nro_evento   /*nro de evento a analizar*/
    FIELD valor AS DECIMAL /*es la suma de los valores de satisfaccion obtenido 0 es lo minimo*/
    FIELD Mobs AS CHAR
    FIELD esmuestra AS LOGICAL /*si el valor es contabilizado como una muestra valida o es solo para desbordes*/
    INDEX idx1 IS PRIMARY  nro_evento
    INDEX idx2 valor DESCENDING fecha ascending   /*para los servicios*/
    INDEX idx3 valor DESCENDING fecha DESCENDING. /*para cobranzas*/

/*analizado es una tabla de eventos reducida que debe ser asignada*/
/*por cada analizado existen rvalores como dias tenga el mes*/
DEFINE TEMP-TABLE analizado NO-UNDO
    FIELD nro_evento LIKE evento.nro_evento /*nro de evento a analizar*/
    FIELD ind AS INT LABEL "Posic"
    FIELD heredado AS CHAR LABEL "H"
    FIELD muestras AS INT initial 0 /*dias en que el grado de satisfaccion es > 0*/
    FIELD sumas AS DECIMAL initial 0 /*sumatoria de los rvalor.valor del periodo*/
    FIELD agrupados AS CHAR  /*lista de los eventos componentes, cuando se asigne este debe asignarse cada uno de los eventos de la lista*/
    FIELD recursos AS CHAR /*lista de los recursos necesarios*/
    FIELD duracion AS INTEGER initial 0 /*es la suma de las duraciones de los eventos que figuran como agrupados*/
    FIELD hduracion AS INTEGER initial 0 /*es la suma de las duraciones de los eventos que figuran como agrupados, en minutos hombre trabajados*/
    FIELD FMSatif AS DATE /*fecha en la que se da el pico de satisfaccion, maximo rvalor.rvalor del periodo*/
    FIELD maxsatif AS DECIMAL initial 0 /*valor de la maxima satiszaccion*/
    FIELD vecinator AS INTEGER INITIAL 0 /*V800+V600*100+V400*1000+V2*10000 donde Vxxx es cantidad de vecinos a los xxx - V600 va desde V400 a V600*/
    FIELDS Mobs AS CHAR
    FIELDS antasig AS DATE
    FIELDS TR AS LOGICAL INITIAL FALSE
    field encadenado as integer initial 0 /*eventos que dependen de el*/
    FIELDS evsigue AS INT INITIAL 0 /*si tiene un avalor aca es un evento que sigue a otro se asigna a continuacion de este*/
    INDEX idx1 IS PRIMARY encadenado DESCENDING tr DESCENDING 
              muestras ASCENDING  sumas descending vecinator ASCENDING antasig ASCENDING  
    INDEX idx2 nro_evento
    INDEX idx4 evsigue
    index idx3 is word-index agrupados.

