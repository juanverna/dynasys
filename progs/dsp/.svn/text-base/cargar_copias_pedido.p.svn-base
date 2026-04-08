/*========================================================================================================*/
/*  LEVANTA EN UNA TABLA TEMPORAL LA CANTIDAD DE COPIAS DE PEDIDO A ENVIAR A CADA SECTOR SEGUN LA EMPRESA */
/*========================================================================================================*/      

/*========================================================================================================*/
/*                                    TABLAS TEMPORALES                                                   */
/*========================================================================================================*/      
                                                                                                                  
DEFINE TEMP-TABLE T-Copias_pedido NO-UNDO LIKE Copias_pedido.

/*========================================================================================================*/
/*                                       PARAMETROS                                                       */
/*========================================================================================================*/      

DEFINE OUTPUT PARAMETER TABLE FOR T-Copias_pedido.

/*========================================================================================================*/
/*                                        PROCESO                                                         */
/*========================================================================================================*/      

EMPTY TEMP-TABLE T-Copias_pedido.

{findempresa.i}

IF Empresa.cdg_empresa = "M"
THEN DO:
    FOR EACH Area WHERE Area.n_copias <> 0:
      CREATE T-Copias_pedido.
      ASSIGN T-Copias_pedido.nro_pedido = 0
             T-Copias_pedido.nro_area   = Area.nro_area
             T-Copias_pedido.n_copias   = Area.n_copias.
    END.
END.

