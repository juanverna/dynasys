/*=======================================================================================================*/   
/*            VALIDACION DE ALTAS Y MODIFICACIONES DE RANGOS DE VIGENCIA EN RELACION A 2 TABLAS          */
/*-------------------------------------------------------------------------------------------------------*/   
/*                                                                                                       */
/*  &TABLAMAESTRA     Tabla maestra de la cual depende la vigencia                                       */
/*  &CDG_MAESTRA      Campo de código de la tabla maestra que se utiliza en la llamada de la rutina de   */
/*                    validacion                                                                         */
/*  &TABLAVIGENCIA    Tabla esclava de vigencia                                                          */
/*  &FECHA_DESDE      Campo de comienzo de la vigencia en la tabla esclava                               */
/*  &FECHA_HASTA      Campo de fin de la vigencia en la tabla esclava                                    */
/*  &ERRORES_RANGO    Códigos de error a utilizar en la validación de los campos de fecha, separados por */
/*                    coma dela forma ERROR1,ERROR2,ERROR3, donde                                        */
/*                            ERROR1: Error que se invoca cuando la fecha de comienzo es invalida        */
/*                            ERROR2: Error que se invoca cuando la fecha de final es invalida           */
/*                            ERROR3: Error que se invoca cuando la fecha de comienzo es mayor a la de   */
/*                                    final                                                              */
/*  &ERRORES_VIGENCIA Código de error que se invoca cuando, al validar un periodo, existen movimientos   */
/*                    para el mismo                                                                      */
/*  &CONDICION        Condición adicional que deben cumplir los registros de vigencia (por ejemplo,      */
/*                    pertenecer a la empresa actual ).                                                  */
/*  &RUTINAVALIDACION Rutina que se invoca para la validación de la existencia de movimientos            */
/*                                                                                                       */
/*=======================================================================================================*/   

DEFINE VARIABLE rc       AS INTEGER.  /* Código de retorno de la validacion de fechas          */
DEFINE VARIABLE lValido  AS LOGICAL.  /* Código de retorno de la validacion de movimientos     */
DEFINE VARIABLE dFecha1  AS DATE.     /* Comienzo rango de fechas de validacion de movimientos */
DEFINE VARIABLE dFecha2  AS DATE.     /* Comienzo rango de fechas de validacion de movimientos */      

DEFINE BUFFER B-{&TABLAVIGENCIA} FOR {&TABLAVIGENCIA}.   

DO WITH FRAME {&FRAME-NAME}:

   {findempresa.i} /* Halla la empresa actual */

   RUN validar_rango_fechas.p 
       ( INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_DESDE}, 
         INPUT FRAME {&FRAME-NAME} {&TABLAVIGENCIA}.{&FECHA_HASTA}, 
         INPUT "{&ERRORES_RANGO}",
         OUTPUT rc ).
   IF rc <> 0 
       THEN RETURN ERROR.

   /* Existe otro registro de esta misma tabla maestra que se superponga con la vigencia de pantalla? */

   FIND FIRST B-{&TABLAVIGENCIA} OF {&TABLAMAESTRA}
           WHERE 
           &IF DEFINED(CONDICION) NE 0
           &THEN
           {&CONDICION} AND 
           &ENDIF  
           ( 
           ( {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE >= B-{&TABLAVIGENCIA}.{&FECHA_DESDE} AND 
             {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE <= B-{&TABLAVIGENCIA}.{&FECHA_HASTA} )
            OR
           ( {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE >= B-{&TABLAVIGENCIA}.{&FECHA_DESDE} AND 
             {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE <= B-{&TABLAVIGENCIA}.{&FECHA_HASTA} )
            OR
           ( {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE <= B-{&TABLAVIGENCIA}.{&FECHA_DESDE} AND 
             {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE >= B-{&TABLAVIGENCIA}.{&FECHA_HASTA} ) 
           ) AND ROWID({&TABLAVIGENCIA}) <> ROWID(B-{&TABLAVIGENCIA})
           NO-LOCK NO-ERROR.
   IF AVAILABLE  B-{&TABLAVIGENCIA}
   THEN DO:
       RUN ponmensj.p ( INPUT "{&ERRORES_VIGENCIA}" ).
       RETURN ERROR.
   END.

   RUN GET-ATTRIBUTE  IN adm-broker-hdl ( INPUT "ADM-NEW-RECORD" ). /* Averiguamos si es un alta */
   IF RETURN-VALUE = "YES"
   THEN DO:

       /* ----------------------------------------------------------------------------- */
       /*  Si es un alta, como no pisauna vigencia anterior, validamos movimientos para */
       /*  El nuevo periodo de vigencia indicado                                        */
       /* ----------------------------------------------------------------------------- */

       RUN {&RUTINAVALIDACION} ( INPUT Empresa.cdg_empresa,      /* Código de Empresa */
                                 INPUT {&TABLAMAESTRA}.{&CDG_MAESTRA},    /* Código de Artículo */
                                 INPUT {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE,
                                 INPUT {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE,
                                 OUTPUT lValido  ).
       IF NOT lValido 
       THEN DO:
           RETURN ERROR.
       END.

   END.
   ELSE DO:

       /* ----------------------------------------------------------------------------- */
       /* NO es un alta. Deben entonces validarse los movimientos para el período abar- */
       /* cado por el cambio de vigencia. Los límites superior e inferior pueden modi-  */
       /* ficarse de manera de ampliar el rango, incluyendo nuevos días, o recudirlo    */
       /* con lo cual se excluyen determinados días. En el primer caso, debemos EXCLUIR */
       /* de la validacion los limites actuales para los cuales puede haber movimientos.*/
       /* En caso contrario, los límites actuales deben ser INCLUIDOS en la validacion  */
       /* ----------------------------------------------------------------------------- */

       IF {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE <> {&TABLAVIGENCIA}.{&FECHA_DESDE}
       THEN DO: 
           IF {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE > {&TABLAVIGENCIA}.{&FECHA_DESDE}
           THEN DO: /* Aumenta límite inferior, con lo que disminuye la vigencia */
               ASSIGN dFecha1 = {&TABLAVIGENCIA}.{&FECHA_DESDE}
                      dFecha2 = {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE.
               RUN {&RUTINAVALIDACION} ( INPUT Empresa.cdg_empresa,      /* Código de Empresa */
                                         INPUT {&TABLAMAESTRA}.{&CDG_MAESTRA},    /* Código de Artículo */
                                         INPUT dFecha1,
                                         INPUT dFecha2,
                                         OUTPUT lValido  ).
           END.
           ELSE DO: /* Disminuye el límite inferior, con lo que aumenta la vigencia */
               ASSIGN dFecha1 = {&TABLAVIGENCIA}.{&FECHA_DESDE}:INPUT-VALUE
                      dFecha2 = {&TABLAVIGENCIA}.{&FECHA_DESDE} - 1.
               RUN {&RUTINAVALIDACION} ( INPUT Empresa.cdg_empresa,      /* Código de Empresa */
                                         INPUT {&TABLAMAESTRA}.{&CDG_MAESTRA},    /* Código de Artículo */
                                         INPUT dFecha1,
                                         INPUT dFecha2,
                                         OUTPUT lValido  ).
           END.

           IF NOT lValido 
               THEN RETURN ERROR.

       END.

       IF {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE <> {&TABLAVIGENCIA}.{&FECHA_HASTA}
       THEN DO:
           IF {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE > {&TABLAVIGENCIA}.{&FECHA_HASTA}
           THEN DO:  /* Aumenta límite superior, con lo que aumenta la vigencia */
               ASSIGN dFecha1 = {&TABLAVIGENCIA}.{&FECHA_HASTA} + 1
                      dFecha2 = {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE.
               RUN {&RUTINAVALIDACION} ( INPUT Empresa.cdg_empresa,      /* Código de Empresa */
                                         INPUT {&TABLAMAESTRA}.{&CDG_MAESTRA},    /* Código de Artículo */
                                         INPUT dFecha1,
                                         INPUT dFecha2,
                                         OUTPUT lValido  ).
           END.
           ELSE DO: /* Disminuye límite superior, con lo que disminuye la vigencia */
               ASSIGN dFecha1 = {&TABLAVIGENCIA}.{&FECHA_HASTA}:INPUT-VALUE
                      dFecha2 = {&TABLAVIGENCIA}.{&FECHA_HASTA}.
               RUN {&RUTINAVALIDACION} ( INPUT Empresa.cdg_empresa,      /* Código de Empresa */
                                         INPUT {&TABLAMAESTRA}.{&CDG_MAESTRA},    /* Código de Artículo */
                                         INPUT dFecha1,
                                         INPUT dFecha2,
                                         OUTPUT lValido  ).
           END.

           IF NOT lValido 
               THEN RETURN ERROR.

       END.

   END.

END.
