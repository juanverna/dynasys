/*=========================================================================================*/
/*            LEVANTA EL ARCHIVO DE DEFINICION DE ETIQUETAS DE COMANDO                     */
/*=========================================================================================*/

{dftabletiqueta.i}

/*=========================================================================================*/
/*                                      PARAMETROS                                         */
/*=========================================================================================*/

DEFINE OUTPUT PARAMETER TABLE FOR T-Etiqueta.

/*=========================================================================================*/
/*                 PROCESO DE CREACION DE LOS REGISTROS DE ETIQUETA                        */
/*=========================================================================================*/

RUN crear_una_etiqueta ( INPUT 1, INPUT 1, INPUT 1, INPUT "CANCELAR              ").
RUN crear_una_etiqueta ( INPUT 2, INPUT 2, INPUT 2, INPUT "ACEPTAR               ").
RUN crear_una_etiqueta ( INPUT 3, INPUT 3, INPUT 3, INPUT "FINALIZAR             ").
RUN crear_una_etiqueta ( INPUT 4, INPUT 4, INPUT 4, INPUT "APROBAR TODOS         ").
RUN crear_una_etiqueta ( INPUT 5, INPUT 5, INPUT 5, INPUT "INSPECCION VISUAL     ").

PROCEDURE crear_una_etiqueta:
    
    DEFINE INPUT PARAMETER p-nro_articulo      LIKE T-Etiqueta.nro_articulo. 
    DEFINE INPUT PARAMETER p-nro_registrable   LIKE T-Etiqueta.nro_registrable. 
    DEFINE INPUT PARAMETER p-num_etiqueta      LIKE T-Etiqueta.num_etiqueta.
    DEFINE INPUT PARAMETER p-descripcion       LIKE T-Etiqueta.descripcion.

    CREATE T-Etiqueta.
    ASSIGN T-Etiqueta.nro_articulo      = p-nro_articulo 
           T-Etiqueta.nro_registrable   = p-nro_registrable 
           T-Etiqueta.num_etiqueta      = p-num_etiqueta
           T-Etiqueta.descripcion       = p-descripcion.

END PROCEDURE.


