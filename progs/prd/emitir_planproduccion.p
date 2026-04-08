/*=================================================================================*/
/*                    EMISION DE FACTURAS/DEVOLUCIONES A CLIENTES                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Planprod_hd               NO-UNDO LIKE Planprod_hd.
DEFINE TEMP-TABLE T-Planprod_dt               NO-UNDO LIKE Planprod_dt.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Planprod_hd.
DEFINE INPUT PARAMETER TABLE FOR T-Planprod_dt.

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

{VRSHARED.I "new"}

DEFINE VARIABLE que_rutina            AS CHARACTER.
DEFINE VARIABLE equiv_granel          LIKE Planprod_dt.granel.
DEFINE VARIABLE v-prox_docum          AS CHARACTER.
DEFINE VARIABLE rid_planprod          AS ROWID.

/*=================================================================================*/
/*                          TRANSACCION PROPIAMENTE DICHA                          */
/*=================================================================================*/

DO TRANSACTION:

/*---------------------------------------------------------------------------------*/
/*              ASIGNAMOS EL NUMERO SI EL COMPROBANTE ES AUTONUMERADO              */
/*---------------------------------------------------------------------------------*/

    FIND FIRST T-Planprod_hd EXCLUSIVE-LOCK.
    FIND Tipocomprobante OF T-Planprod_hd NO-LOCK.

    IF Tipocomprobante.autonumerado
    THEN DO:

        v-prox_docum = Tipocomprobante.prefijo_contador + STRING(T-Planprod_hd.prf_comprob,"9999").
        T-Planprod_hd.tip_comprob =  Tipocomprobante.tip_comprob.    

        FIND Parametro WHERE Parametro.cdg_parametro = v-prox_docum 
                         AND Parametro.cdg_empresa   = T-Planprod_hd.cdg_empresa 
                             EXCLUSIVE-LOCK NO-ERROR.
          
        IF NOT AVAILABLE Parametro
        THEN DO:
             CREATE Parametro.
             ASSIGN Parametro.cdg_empresa   = T-Planprod_hd.cdg_empresa
                    Parametro.cdg_parametro = v-prox_docum
                    Parametro.descripcion   = "Contador autoagregado por " + PROGRAM-NAME(1)
                    Parametro.observacion   = ""
                    Parametro.tipo          = "N"
                    Parametro.valor_n       = 1.
        END.         
        
        ASSIGN
           T-Planprod_hd.nro_comprob = Parametro.valor_n
           Parametro.valor_n         = Parametro.valor_n + 1.

    END.

/*---------------------------------------------------------------------------------*/
/*                     BAJAMOS LAS TABLAS TEMPORALES                               */
/*---------------------------------------------------------------------------------*/

    FIND FIRST T-Planprod_hd.

    CREATE Planprod_hd.
    BUFFER-COPY T-Planprod_hd TO Planprod_hd
        ASSIGN  Planprod_hd.nro_planprod   = NEXT-VALUE(proximo_planprod).

    RUN completar_auditoria.p ( OUTPUT Planprod_hd.nro_usuario,
                                OUTPUT Planprod_hd.fecha_grab,
                                OUTPUT Planprod_hd.hora_grab,
                                OUTPUT Planprod_hd.pc_name ).
    
    FOR EACH T-Planprod_dt:
       CREATE Planprod_dt.
       BUFFER-COPY T-Planprod_dt TO Planprod_dt
           ASSIGN  Planprod_dt.nro_planprod = Planprod_hd.nro_planprod.
    END.
    
    rid_planprod = ROWID(Planprod_hd).

    RELEASE Parametro.        
    RELEASE Planprod_hd.
    RELEASE Planprod_dt.


END. /* Finaliza la transaccion de emision */
         
/*---------------------------------------------------------------------------------*/
/*                         IMPRESION DEL COMPROBANTE                               */
/*---------------------------------------------------------------------------------*/

RUN imprimir_planprod.p ( INPUT rid_planprod ). 

