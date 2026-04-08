/*
********************************************************************************
    MUESTRA EN EL BROWSE DE DETALLES DE REMITO EL REMITO CORRESPONDIENTE 
********************************************************************************
*/

CREATE T-Encabezado_salida.
BUFFER-COPY {&TABLA} TO T-Encabezado_salida
ASSIGN T-Encabezado_salida.nro_remito         = {&TABLA}.{&CAMPO}
       T-Encabezado_salida.direccion          = {&TABLA_AUX}.direccion
       T-Encabezado_salida.nombre             = {&TABLA_AUX}.nombre.

FOR EACH {&TABLA2} OF {&TABLA},
    Articulo OF {&TABLA2}:

        IF Articulo.es_registrable 
        THEN DO:
            FOR EACH {&TABLA3} OF {&TABLA2},
                Registrable OF {&TABLA3}:  /*Genero un registro por cada registrable*/

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
        END.
END.
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


{&OPEN-QUERY-{&BROWSE-NAME}}

v-codetiqueta:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
v-remito:SENSITIVE IN FRAME {&FRAME-NAME} = NO.


