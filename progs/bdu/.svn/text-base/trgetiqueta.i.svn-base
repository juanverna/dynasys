    /*
    &IF "{&OPSYS}" = "WIN32" 
    &THEN
    btn_aprobar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
    &ENDIF
    */
    DEFINE VARIABLE v-num_etiqueta    AS INTEGER.
    DEFINE VARIABLE v-cantidad        LIKE Sre_detalle.cantidad.
    DEFINE VARIABLE v-cdg_articulo    AS CHARACTER.
    DEFINE VARIABLE v-cdg_registrable AS CHARACTER.

    ASSIGN v-codetiqueta.

    IF INDEX(v-codetiqueta,"-") = 0 /* No hay guión, es una lectura automática */
    THEN DO:
        IF LENGTH(v-codetiqueta) <> 16
        THEN DO:
            RUN ponmensj.p ( INPUT "EGRE003" ).
            DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
            APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
            RETURN NO-APPLY.
        END.
        ELSE DO:
            v-num_etiqueta = INTEGER(SUBSTRING(v-codetiqueta,1,8)) NO-ERROR.
            IF ERROR-STATUS:ERROR
            THEN DO:
                RUN ponmensj.p ( INPUT "EGRE004" ). 
                DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                RETURN NO-APPLY. 
            END.
            ELSE DO:
                v-cantidad = DECIMAL(SUBSTRING(v-codetiqueta,9,8)) / 100 NO-ERROR.
                IF ERROR-STATUS:ERROR
                THEN DO:
                    RUN ponmensj.p ( INPUT "EGRE005" ).
                    DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                    APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                    RETURN NO-APPLY. 
                END.
            END.
        END.
    END.
    ELSE DO: /* Hay guión, es un ingreso manual de datos */
        v-num_etiqueta = INTEGER(ENTRY(1,v-codetiqueta,"-")) NO-ERROR.
        IF ERROR-STATUS:ERROR
        THEN DO:
            RUN ponmensj.p ( INPUT "EGRE004" ). 
            DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
            APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
            RETURN NO-APPLY. 
        END.
        ELSE DO:
            v-cantidad = DECIMAL(ENTRY(2,v-codetiqueta,"-")) NO-ERROR.
            IF ERROR-STATUS:ERROR
            THEN DO:
                RUN ponmensj.p ( INPUT "EGRE005" ).
                DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                RETURN NO-APPLY. 
            END.
        END.
    END.

    /* ------------------------------------------------------------------------------------------------- */
    /* Llegados aquí, tanto v-num_etiqueta como v-cantidad contienen datos válidos y ya no importa si es */
    /* una lectura automática de un código de barra o un ingreso manual                                  */
    /* ------------------------------------------------------------------------------------------------- */

    IF INTEGER(v-num_etiqueta) > 1000
    THEN DO:
        FIND Etiqueta WHERE Etiqueta.num_etiqueta = INTEGER(v-num_etiqueta) NO-ERROR.
        IF NOT AVAILABLE Etiqueta
        THEN DO:
            RUN ponmensj.p ( INPUT "EGRE006" ).
            DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
            APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
            RETURN NO-APPLY. 
        END.
        ELSE DO:
            FIND Articulo OF Etiqueta NO-LOCK.
            v-cdg_articulo = Articulo.cdg_articulo.
            IF Articulo.es_registrable
            THEN DO:
                FIND Registrable WHERE Registrable.nro_registrable = Etiqueta.nro_registrable NO-LOCK.
                v-cdg_registrable = Registrable.cdg_registrable.
            END.
            ELSE DO:
                v-cdg_registrable = "".
            END.

            FIND FIRST T-Detalle_salida WHERE T-Detalle_salida.cdg_articulo = v-cdg_articulo
                                          AND T-Detalle_salida.cdg_registrable = v-cdg_registrable
                                              NO-ERROR.
        
            IF NOT AVAILABLE T-Detalle_salida
            THEN DO:
                RUN PONMENSJ.P (INPUT "EGRE002"). /*No existe el detalle*/
                DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                RETURN NO-APPLY. 
            END.
            ELSE DO:
                  
                IF T-Detalle_salida.cantidad < T-Detalle_salida.ingresado + v-cantidad
                THEN DO:
                    RUN PONMENSJ.P (INPUT "EGRE007"). /*Ya fue ingresado*/
                    DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                    APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                    RETURN NO-APPLY. 
                END.
                ELSE DO:
                    T-Detalle_salida.ingresado = T-Detalle_salida.ingresado + v-cantidad.
        
                     {&OPEN-QUERY-{&BROWSE-NAME}}

                END.
        
            END.     

            &IF "{&OPSYS}" = "UNIX" 
            &THEN
            v-texto = "".
            DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
            &ENDIF
            
            IF CAN-FIND(FIRST T-Detalle_salida WHERE T-Detalle_salida.cantidad > T-Detalle_salida.ingresado)
            THEN DO:  /*Aun no finalizó la carga*/
                DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                RETURN NO-APPLY. 
            END.
            ELSE DO:
               &IF "{&OPSYS}" = "WIN32" 
               &THEN
                btn_finalizar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
                btn_aprobar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.
               &ENDIF
             /* APPLY "ENTRY":U TO btn_finalizar IN FRAME {&FRAME-NAME}.*/
                DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                RETURN NO-APPLY. 
            END.

        END.
    END.
    ELSE DO:

       &IF "{&OPSYS}" = "UNIX" 
       &THEN
       v-texto = "".
       DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
       &ENDIF

       CASE INTEGER(v-num_etiqueta):
           WHEN 1 THEN DO: /* Cancelar */
               RUN cancelar_operacion.
               APPLY "ENTRY":U TO v-remito IN FRAME {&FRAME-NAME}.
           END.
           WHEN 3 THEN DO: /* Finalizar */
               IF NOT CAN-FIND(FIRST T-Detalle_salida WHERE T-Detalle_salida.cantidad > T-Detalle_salida.ingresado)
               THEN DO:
                   RUN finalizar_operacion.
                   RUN cancelar_operacion.
                   APPLY "ENTRY":U TO v-remito IN FRAME {&FRAME-NAME}.
               END.
               ELSE DO:
                   DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
                   APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
                   RETURN NO-APPLY.
               END.
           END.
           WHEN 4 THEN DO: /* Aprobar Todo */
               RUN aprobar_todo.
               &IF "{&OPSYS}" = "WIN32" 
               &THEN
               btn_finalizar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
               btn_aprobar:SENSITIVE IN FRAME {&FRAME-NAME} = NO.  
               &ENDIF
               DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
               APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
               RETURN NO-APPLY.
           END.
           OTHERWISE DO: /* No es un comando válido */
               RUN PONMENSJ.P (INPUT "EGRE008"). /*Comando no valido*/
               DISPLAY " " @  v-codetiqueta WITH FRAME {&FRAME-NAME}.
               APPLY "ENTRY" TO v-codetiqueta IN FRAME {&FRAME-NAME}.
               RETURN NO-APPLY.
           END.
       END CASE.

   END.
