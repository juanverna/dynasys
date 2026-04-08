/*===================================================================================*/
/*                  CREA LOS REGISTROS DE AUDITORIA DE PARAMETROS                    */
/*===================================================================================*/

/*===================================================================================*/
/*                               TABLAS TEMPORALES                                   */
/*===================================================================================*/

DEFINE TEMP-TABLE T-Parametro NO-UNDO LIKE Parametro.

/*===================================================================================*/
/*                                  PARAMETROS                                       */
/*===================================================================================*/
    
DEFINE INPUT PARAMETER TABLE FOR T-Parametro.

/*===================================================================================*/
/*                                   PROCESO                                         */
/*===================================================================================*/

FIND FIRST T-Parametro.
CREATE Auditoria_parametros.
BUFFER-COPY T-Parametro TO Auditoria_parametros.
RUN completar_auditoria.p ( OUTPUT Auditoria_parametros.nro_usuario,
                            OUTPUT Auditoria_parametros.fecha_grab,
                            OUTPUT Auditoria_parametros.hora_grab,
                            OUTPUT Auditoria_parametros.pc_name).
RELEASE Auditoria_parametros.
