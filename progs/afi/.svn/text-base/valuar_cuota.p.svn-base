/*==================================================================================================*/
/*             CALCULA LA CUOTA MENSUAL A ABONAR PARA UN DETERMINADO GRUPO FAMILIAR                 */
/*==================================================================================================*/

    DEFINE INPUT  PARAMETER rid_grupofam    AS ROWID.
    DEFINE OUTPUT PARAMETER p-importe_cuota AS DECIMAL.

/*==================================================================================================*/
/*      CALCULA LA CUOTA MENSUAL A ABONAR PARA UN DETERMINADO GRUPO FAMILIAR                        */
/*==================================================================================================*/

    FIND Grupofam WHERE ROWID(Grupofam) = rid_grupofam NO-LOCK.

    IF Grupofam.tipo_grupo = "G"
    THEN DO:

        FIND Plan OF Grupofam NO-LOCK.
        CASE Plan.modo_importe:

            WHEN "C"
            THEN DO:
        
                 FIND FIRST Plan-capita OF Grupofam  
                      WHERE Plan-capita.cant_capitas = Grupofam.cant_capitas 
                            NO-LOCK NO-ERROR.
                 p-importe_cuota = IF AVAILABLE Plan-capita 
                                      THEN Plan-capita.precio_neto
                                      ELSE ?.
            END.

            WHEN "D"
            THEN DO:
        
                 p-importe_cuota = Grupofam.importe_cuota.

            END.

            WHEN "I"
            THEN DO:
            
                 p-importe_cuota = 0.
                 FOR EACH Afiliado OF Grupofam WHERE Afiliado.cdg_estado <> "B" NO-LOCK:
                     FIND FIRST Plan-capita  
                          WHERE Plan-capita.cdg_empresa  = Grupofam.cdg_empresa
                            AND Plan-capita.cdg_plan     = Grupofam.cdg_plan
                            AND Plan-capita.cant_capitas = Afiliado.cdg_categoria 
                                     NO-LOCK NO-ERROR.
                     p-importe_cuota = p-importe_cuota + 
                                       IF AVAILABLE Plan-capita 
                                          THEN Plan-capita.precio_neto
                                          ELSE ?.
                 END.

            END.

        END CASE.

    END.        
    ELSE DO:
    
        p-importe_cuota = Grupofam.importe_cuota.

    END.
