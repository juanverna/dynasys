            que_parametro = "CNOVAS" + INPUT Anticipo_sue.tip_comprob.
            FIND PARAMETRO 
                 WHERE Parametro.cdg_parametro = que_parametro
                       NO-LOCK NO-ERROR.
            IF AVAILABLE Parametro
               THEN IF Parametro.valor_n <> 0
                       THEN DO:
                            CREATE Parte.
                            ASSIGN
                                   Parte.cdg_destino       =
                                   Parte.cdg_usuario       =
                                   Parte.estado_pendiente  =
                                   Parte.fecha             =
                                   Parte.fecha_grab        =
                                   Parte.hora              =
                                   Parte.hora_grab         =
                                   Parte.informada         =
                                   Parte.nro_empleado      =
                                   Parte.nro_novedad       =
                                   Parte.observacion       =
                                   Parte.valor             = Antic
                        END.            