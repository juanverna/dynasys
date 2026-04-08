
DEFINE TEMP-TABLE aimp
    FIELD c_nro_tipo_evento LIKE tipo_evento.nro_tipo_evento COLUMN-LABEL "Tipo!Evento"
    FIELD nro_evento AS INT LABEL "EVENTO"
    FIELD recurso LIKE evento.recurso
    FIELD turno LIKE evento.turno
    FIELD aviso_evento AS INT LABEL "AVISO EVENTO"
    FIELD aviso_fasignado AS DATE LABEL "REPARTIR"
    FIELD aviso_recurso AS CHAR LABEL "RECURSO"
    FIELD tipoespecial AS CHAR LABEL "ESPECIAL"
    INDEX aimp1 recurso turno.
    

    {crystal_dyna.p}

 {findempresa.i}
 {impresoras.i}


        FIND evento WHERE evento.nro_evento = 866351.
    CREATE aimp.
              ASSIGN
                  aimp.c_nro_tipo_evento = evento.nro_tipo_evento 
                  aimp.nro_evento = evento.nro_evento.
                  aimp.recurso = evento.recurso.
                  aimp.turno = evento.turno.
                  RUN printorden.p ( INPUT TABLE aimp, OUTPUT xfile, ? ). 
