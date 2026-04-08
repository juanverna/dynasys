
&SCOPED-DEFINE TABLA Rem_header_prv
&SCOPED-DEFINE CAMPO nro_remprov
&SCOPED-DEFINE TABLA2 Rem_detalle_prv
&SCOPED-DEFINE TABLA3 Registrable-remprov
&SCOPED-DEFINE TABLA_AUX Rem_header_prv
&SCOPED-DEFINE FRAME-NAME ff
DEFINE VARIABLE v-linea AS INTEGER.

DEFINE TEMP-TABLE T-Detalle_salida NO-UNDO
    FIELD cdg_articulo    AS CHARACTER FORMAT "X(15)"    COLUMN-LABEL "Cdg!Articulo"
    FIELD dsc_articulo    AS CHARACTER FORMAT "X(50)"    COLUMN-LABEL "Dsc!Articulo"
    FIELD cdg_registrable AS CHARACTER FORMAT "X(20)"    COLUMN-LABEL "Cdg!Registrable"
    FIELD cantidad        AS DECIMAL   FORMAT ">>>>9.99" COLUMN-LABEL "Cantidad!Remito"
    FIELD ingresado       AS DECIMAL   FORMAT ">>>>9.99" COLUMN-LABEL "Cantidad!Ingresada"
    FIELD nro_serie       AS CHARACTER FORMAT "X(20)"    COLUMN-LABEL "Número!Serie"
    FIELD num_etiqueta    AS CHARACTER FORMAT "X(12)"    COLUMN-LABEL "Número!Etiqueta"
    FIELD linea           AS INTEGER  /*lo utilizo solo para posicionar la selección de la linea del browse*/
    FIELD cumplido        AS LOGICAL.

DEFINE TEMP-TABLE T-Encabezado_salida NO-UNDO LIKE Rem_header.
FORM 
    WITH FRAME ff DOWN.
/*
********************************************************************************
    MUESTRA EN EL BROWSE DE DETALLES DE REMITO EL REMITO CORRESPONDIENTE 
********************************************************************************
*/

FIND rem_header_prv WHERE rem_header_prv.cdg_empresa = "M" AND rem_header_prv.tip_comprob = "RM" AND rem_header_prv.prf_comprob = 676 AND rem_header_prv.nro_comprob = 219.

CREATE T-Encabezado_salida.
BUFFER-COPY {&TABLA} TO T-Encabezado_salida
ASSIGN T-Encabezado_salida.nro_remito         = {&TABLA}.{&CAMPO}
       T-Encabezado_salida.direccion          = {&TABLA_AUX}.direccion
       T-Encabezado_salida.nombre             = {&TABLA_AUX}.nombre.

FOR EACH {&TABLA2} OF {&TABLA},
    Articulo OF {&TABLA2}:

        IF Articulo.es_registrable 
        THEN DO:
            FOR EACH {&TABLA3} OF {&TABLA2}, Registrable OF {&TABLA3}:  /*Genero un registro por cada registrable*/
                               MESSAGE rem_detalle_prv.nro_linea registrable-remprov.nro_registrable
                                   VIEW-AS ALERT-BOX MESSAGE.

                FIND FIRST Etiqueta WHERE Etiqueta.nro_registrable = Registrable.nro_registrable NO-LOCK.
                v-linea = v-linea + 1.
                CREATE T-Detalle_salida.
                ASSIGN T-Detalle_salida.cdg_articulo    = Articulo.cdg_articulo
                       T-Detalle_salida.dsc_articulo    = Articulo.descripcion
                       T-Detalle_salida.cdg_registrable = Registrable.cdg_registrable
                       T-Detalle_salida.nro_serie       = Registrable.nro_serie
                       T-Detalle_salida.num_etiqueta    = STRING(Etiqueta.num_etiqueta,"99999999")
                       T-Detalle_salida.cantidad        = 1
                       T-Detalle_salida.linea           = v-linea.
                DISPLAY t-detalle_salida.linea t-detalle_salida.cdg_articulo T-Detalle_salida.cdg_registrable WITH FRAME ff.
                        DOWN WITH FRAME ff.

            END.
        END.
        ELSE DO:
            FIND FIRST Etiqueta WHERE Etiqueta.nro_articulo = Articulo.nro_articulo NO-LOCK.
            v-linea = v-linea + 1.
            CREATE T-Detalle_salida.
            ASSIGN T-Detalle_salida.cdg_articulo    = Articulo.cdg_articulo
                   T-Detalle_salida.dsc_articulo    = Articulo.descripcion
                   T-Detalle_salida.cdg_registrable = ""
                   T-Detalle_salida.nro_serie       = ""
                   T-Detalle_salida.cantidad        = {&TABLA2}.cantidad
                   T-Detalle_salida.num_etiqueta    = STRING(Etiqueta.num_etiqueta,"99999999")
                   T-Detalle_salida.linea           = v-linea.
            DISPLAY t-detalle_salida.linea t-detalle_salida.cdg_articulo T-Detalle_salida.cdg_registrable WITH FRAME ff.
                        DOWN WITH FRAME ff.
        END.
END.
/*
DISPLAY
     T-Encabezado_salida.chofer 
     T-Encabezado_salida.cuit_transportista 
     T-Encabezado_salida.direccion 
     T-Encabezado_salida.dni_transportista 
     T-Encabezado_salida.fecha 
     T-Encabezado_salida.nombre 
     T-Encabezado_salida.nom_transportista 
     T-Encabezado_salida.nro_comprob 
     T-Encabezado_salida.patente 
     T-Encabezado_salida.precintos 
     T-Encabezado_salida.prf_comprob 
     T-Encabezado_salida.tip_comprob
    WITH FRAME {&FRAME-NAME} .
*/
