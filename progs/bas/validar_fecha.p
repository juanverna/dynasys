/*=====================================================================================================*/
/*              PRODUCE LA VALIDACIÓN DE UNA FECHA LOS POSIBLES VALORES DE RETORNO SON                 */
/*                                                                                                     */
/*       0 -  La fecha es correcto                                                                     */
/*       1 -  La fecha no es válida                                                                    */
/*                                                                                                     */
/* Los parámetros de ingreso son CHAR porque usualmente se invocará esta rutina para validar los va-   */
/* lores de pantalla de una transacción, recuperados mediante el atributo SCREE-VALUE                  */
/*=====================================================================================================*/

   DEFINE INPUT PARAMETER p-fecha1  AS CHARACTER. 
   DEFINE INPUT PARAMETER p-error   AS CHARACTER.
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
        RUN ponmensj.p ( INPUT p-error).
        RETURN ERROR.
   END.

   rc = 0. /* Retorna sin error */
