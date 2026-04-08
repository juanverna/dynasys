DEFINE TEMP-TABLE T-Carta_encabezado NO-UNDO
    FIELD fecha           AS DATE
    FIELD rem_nombre      AS CHARACTER 
    FIELD rem_direccion   AS CHARACTER
    FIELD rem_cdg_postal  AS CHARACTER
    FIELD rem_localidad   AS CHARACTER
    FIELD rem_provincia   AS CHARACTER
    FIELD rem_dni         AS CHARACTER
    FIELD dst_nombre      AS CHARACTER
    FIELD dst_direccion   AS CHARACTER
    FIELD dst_cdg_postal  AS CHARACTER
    FIELD dst_localidad   AS CHARACTER
    FIELD dst_provincia   AS CHARACTER
    FIELD texto           AS CHARACTER.

FIND PARAMETRO WHERE CDG_PARAMETRO = "txtdocum".


CREATE T-Carta_encabezado.
ASSIGN T-Carta_encabezado.fecha           = TODAY
       T-Carta_encabezado.rem_nombre      = "Silvia Mercedes Uría" 
       T-Carta_encabezado.rem_direccion   = "Cochabamba 191"
       T-Carta_encabezado.rem_cdg_postal  = "1828"
       T-Carta_encabezado.rem_localidad   = "Banfield"
       T-Carta_encabezado.rem_provincia   = "Buenos Aires"
       T-Carta_encabezado.rem_dni         = "DNI. 11.042.877" 
       T-Carta_encabezado.dst_nombre      = "María M. Passarelli"
       T-Carta_encabezado.dst_direccion   = "Aguapey 3853"
       T-Carta_encabezado.dst_cdg_postal  = "1824"
       T-Carta_encabezado.dst_localidad   = "Monte Chingolo"
       T-Carta_encabezado.dst_provincia   = "Buenos Aires"
       T-Carta_encabezado.texto           = Parametro.observacion.
    
RUN prcarta_documento.p ( INPUT TABLE T-Carta_encabezado ).
