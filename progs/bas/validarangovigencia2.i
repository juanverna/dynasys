
   DEFINE VARIABLE rc AS INTEGER.       

   RUN validar_rango_fechas.p 
       ( INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_DESDE}, 
         INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_HASTA}, 
         INPUT "{&ERRORES_RANGO}",
         OUTPUT rc).
   IF rc <> 0 
       THEN RETURN ERROR.
   
   IF CAN-FIND(FIRST B-{&TABLAVIGENCIA}
               WHERE 
               {&CONDICION}
                AND 
                     ( ( INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_DESDE} >= B-{&TABLAVIGENCIA}.{&FECHA_DESDE} AND 
                         INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_DESDE} <= B-{&TABLAVIGENCIA}.{&FECHA_HASTA} ) OR
                       ( INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_HASTA} >= B-{&TABLAVIGENCIA}.{&FECHA_DESDE} AND 
                         INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_HASTA} <= B-{&TABLAVIGENCIA}.{&FECHA_HASTA} ) OR
                       ( INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_DESDE} <= B-{&TABLAVIGENCIA}.{&FECHA_DESDE} AND 
                         INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_HASTA} >= B-{&TABLAVIGENCIA}.{&FECHA_HASTA} ) ) AND 
                         ROWID({&TABLAVIGENCIA}) <> ROWID(B-{&TABLAVIGENCIA}) )
   THEN DO:
       RUN ponmensj.p ( INPUT "{&ERRORES_VIGENCIA}" ).
       RETURN ERROR.
   END.
