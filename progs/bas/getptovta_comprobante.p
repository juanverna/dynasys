/*=========================================================================================================*/
/*                 ENCUENTRA EL PUNTO DE VENTA PARA UN TIPO DE COMPROBANTE DETERMINADO                     */
/*=========================================================================================================*/

DEFINE INPUT  PARAMETER p-cdg_comprobante LIKE Tipo_puntovta.cdg_comprobante.
DEFINE OUTPUT PARAMETER p-pto_venta       AS INTEGER.
   
/*=========================================================================================================*/
/*                                                 PROCESO                                                 */
/*=========================================================================================================*/

{parlocales.i}

DEFINE VARIABLE v-pc_name AS CHARACTER.

/*=========================================================================================================*/
/*                                                 PROCESO                                                 */
/*=========================================================================================================*/

{findempresa.i}

RUN pcname1.p ( OUTPUT v-pc_name ).

FIND Parametro-excep WHERE Parametro-excep.cdg_empresa   = Empresa.cdg_empresa
                       AND Parametro-excep.cdg_parametro = "PTOVTAUS" 
                       AND Parametro-excep.clave-excep   = v-pc_name 
                           NO-LOCK NO-ERROR.
IF AVAILABLE Parametro-excep
THEN DO:
    ASSIGN
        p-pto_venta = Parametro-excep.valor_n.
END.
ELSE DO:
    FIND FIRST Tipo_puntovta 
        WHERE Tipo_puntovta.cdg_comprobante = p-cdg_comprobante
          AND Tipo_puntovta.cdg_empresa = Empresa.cdg_empresa
          AND Tipo_puntovta.preferido
              NO-LOCK NO-ERROR.
    IF AVAILABLE Tipo_puntovta
    THEN DO:
       p-pto_venta = Tipo_puntovta.cdg_puntovta.
    END.
    ELSE DO:
       MESSAGE "NO SE ENCUENTRA EL PRIMER CENTRO EMISOR HABILITADO PARA ESTE COMPROBANTE O BIEN NO SE ENCUENTRA EL PREFERIDO"
                VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION".
       p-pto_venta = 0.
    END.
END.
