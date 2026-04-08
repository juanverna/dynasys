    DEFINE VARIABLE v-cdg_articulo AS CHARACTER.
    DEFINE VARIABLE v-cdg_registrable AS CHARACTER.

    ASSIGN v-articulo.
    IF NUM-ENTRIES(v-articulo,".") = 2
        THEN ASSIGN v-cdg_articulo = ENTRY(1,v-articulo,".")
                    v-cdg_registrable = ENTRY(2,v-articulo,".").
        ELSE ASSIGN v-cdg_articulo = v-articulo
                    v-cdg_registrable = "".

     FIND FIRST T-Detalle_salida WHERE T-Detalle_salida.cdg_articulo = v-cdg_articulo
                                   AND T-Detalle_salida.cdg_registrable = v-cdg_registrable
                                   AND T-detalle_salida.ingresado = NO NO-LOCK NO-ERROR.

     IF NOT AVAILABLE T-Detalle_salida
     THEN DO:
          RUN PONMENSJ.P (INPUT "EGRE002"). /*No existe el detalle o ya fue ingresado*/
          RETURN NO-APPLY.
     END.
     ELSE DO:
          T-Detalle_salida.ingresado = YES. /*marco el detalle*/

          BROWSE-2:SELECT-ROW (T-Detalle_salida.linea).
          ASSIGN
              T-Detalle_salida.cdg_articulo:BGCOLOR IN BROWSE BROWSE-2 = 9
              T-Detalle_salida.cdg_articulo:FGCOLOR IN BROWSE BROWSE-2 = 15
              T-Detalle_salida.dsc_articulo:BGCOLOR IN BROWSE BROWSE-2 = 9
              T-Detalle_salida.dsc_articulo:FGCOLOR IN BROWSE BROWSE-2 = 15
              T-Detalle_salida.cdg_registrable:BGCOLOR IN BROWSE BROWSE-2 = 9
              T-Detalle_salida.cdg_registrable:FGCOLOR IN BROWSE BROWSE-2 = 15
              T-Detalle_salida.dsc_registrable:BGCOLOR IN BROWSE BROWSE-2 = 9
              T-Detalle_salida.dsc_registrable:FGCOLOR IN BROWSE BROWSE-2 = 15
              T-Detalle_salida.cantidad:BGCOLOR IN BROWSE BROWSE-2 = 9
              T-Detalle_salida.cantidad:FGCOLOR IN BROWSE BROWSE-2 = 15.
     END.     

     FIND FIRST T-Detalle_salida WHERE T-Detalle_salida.ingresado = NO NO-LOCK NO-ERROR.
     IF AVAILABLE T-Detalle_salida THEN DO:  /*Aun no finalizó la carga*/
        APPLY "ENTRY":U TO v-articulo IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
     END.
     ELSE DO:
        btn_finalizar:SENSITIVE IN FRAME {&FRAME-NAME} = YES.
        APPLY "ENTRY":U TO btn_finalizar IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
     END.
