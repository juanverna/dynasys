/*=====================================================================================================*/
/* PRODUCE LA VALIDACIÓN DE DOS FECHAS QUE DEBEN DEFINIR UN RANGO, LOS POSIBLES VALORES DE RETORNO SON */
/*                                                                                                     */
/*       0 -  El rango es correcto                                                                     */
/*       1 -  La fecha inicial no es válida                                                            */
/*       2 -  La fecha final no es válida                                                              */
/*       3 -  La fecha final es menor que la inicial                                                   */
/*                                                                                                     */
/* Los parámetros de ingreso son CHAR porque usualmente se invocará esta rutina para validar los va-   */
/* lores de pantalla de una transacción, recuperados mediante el atributo SCREE-VALUE                  */
/*=====================================================================================================*/

   DEFINE INPUT PARAMETER p-fecha1  AS CHARACTER. 
   DEFINE INPUT PARAMETER p-fecha2  AS CHARACTER.
   DEFINE INPUT PARAMETER p-errores AS CHARACTER.
   DEFINE OUTPUT PARAMETER      rc  AS INTEGER.

/*=====================================================================================================*/
/*                                     VARIABLES LOCALES                                               */
/*=====================================================================================================*/

   DEFINE VARIABLE x_fecha AS DATE.

/*=====================================================================================================*/
/*                                          PROCESO                                                    */
/*=====================================================================================================*/

   x_fecha = DATE(p-fecha1) NO-ERROR.
   IF ERROR-STATUS:ERROR OR x_fecha = DATE("") 
   THEN DO:
        rc = 1.
        RUN ponmensj.p ( INPUT ENTRY(1,p-errores,",")).
        RETURN.
   END.

   x_fecha = DATE(p-fecha2) NO-ERROR.
   IF ERROR-STATUS:ERROR OR x_fecha = DATE("")
   THEN DO:
        rc = 2.
        RUN ponmensj.p ( INPUT ENTRY(2,p-errores,",")).        
        RETURN.
   END.

   IF DATE(p-fecha2)< DATE(p-fecha1)
   THEN DO:
        rc = 3.
        RUN ponmensj.p ( INPUT ENTRY(3,p-errores,",")).
        RETURN.
   END.

   rc = 0. /* Retorna sin error */
