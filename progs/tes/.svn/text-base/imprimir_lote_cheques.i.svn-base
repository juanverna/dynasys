DEFINE VARIABLE tipo_orden    AS CHARACTER  NO-UNDO.
DEFINE VARIABLE TEXTO         AS CHARACTER  NO-UNDO.
DEFINE VARIABLE orden         AS CHARACTER  NO-UNDO.
DEFINE BUFFER b_Campo_modelocheque FOR Campo_modelocheque.
DEFINE VARIABLE largo         AS INTEGER    NO-UNDO.



IF CAN-FIND(FIRST Campo_modelocheque
            WHERE Campo_modelocheque.cdg_modelocheque = Modelocheque.cdg_modelocheque) 
    THEN
DO:
    EMPTY TEMP-TABLE T-Imagen_cheque.
        DO j-orden = 1 TO Modelocheque.cant_renglones:
            CREATE T-Imagen_cheque.
            ASSIGN T-Imagen_cheque.n-fila = j-orden
                   T-Imagen_cheque.ch_linea = " ".
        END.
        /* si el modelo no tiene NOALAORDEN => PONE EL VALOR DEL PROVEEDOR
                           tiene NOALAORDEN => 
                           SI Campo_modelocheque.valor_fijo = "S"  => SIEMPRE PONE NO A LA ORDEN
                                                            = "N"  => NUNCA PONE NO A LA ORDEN
                                                            = "P"  => TOMA EL VALOR DEL PROVEEDOR */
        IF AVAILABLE Cheque THEN
           FIND FIRST Proveedor OF Cheque NO-LOCK NO-ERROR.
        
        tipo_orden = "P".
        FIND FIRST b_Campo_modelocheque OF Modelocheque 
             WHERE b_Campo_modelocheque.cdg_campomodelo = "noalaorden"  
             NO-LOCK NO-ERROR.
        IF AVAILABLE b_Campo_modelocheque THEN
           ASSIGN tipo_orden = b_Campo_modelocheque.valor_fijo.

         TEXTO = "".
           CASE tipo_orden :
                WHEN "P" THEN 
                IF NOT AVAILABLE Cheque OR 
                   (AVAILABLE Cheque AND Proveedor.no_a_la_orden ) THEN
                   TEXTO = " - No a la Orden.".
                WHEN "S" THEN TEXTO = " - No a la Orden.".
                WHEN "N" THEN TEXTO = "".
           END CASE.
              


        IF AVAILABLE Cheque THEN
           RUN importe_en_letras.p ( INPUT Cheque.importe, OUTPUT v-monto_letras ).
        ELSE
           v-monto_letras = fill("-",200).
    
    
        FIND FIRST Campo_modelocheque OF Modelocheque WHERE Campo_modelocheque.cdg_campomodelo = "monto_letras1" NO-LOCK NO-ERROR.
        v-monto_letras = v-monto_letras + " " + FILL("-",200).
        IF AVAILABLE Campo_modelocheque THEN
        RUN renglons.p (INPUT  v-monto_letras, 
                        INPUT  Campo_modelocheque.n_campomodelo,
                        OUTPUT v-monto_letras,
                        INPUT  "|").
        IF NOT AVAILABLE Cheque THEN
           v-monto_letras = fill("-",200).
    
        FIND FIRST Campo_modelocheque OF Modelocheque WHERE Campo_modelocheque.cdg_campomodelo = "orden" NO-LOCK NO-ERROR.
        IF AVAILABLE Cheque AND AVAILABLE Campo_modelocheque THEN
        DO: 
            orden =  TRIM(STRING(Cheque.orden)) + TEXTO.
            RUN renglons.p (INPUT  orden, 
                            INPUT  Campo_modelocheque.n_campomodelo,
                            OUTPUT v-orden_cheque,
                            INPUT  "|").
        END.
        IF NOT AVAILABLE Cheque AND AVAILABLE Campo_modelocheque THEN
        DO: 
            IF texto = "" THEN
               orden = FILL(" -",200).
            ELSE
            DO:
               ASSIGN 
               largo = ( Campo_modelocheque.n_campomodelo - length(texto))/ 2.
               orden = FILL(" -",largo) + texto.   
            END.
            RUN renglons.p (INPUT  orden, 
                            INPUT  Campo_modelocheque.n_campomodelo,
                            OUTPUT v-orden_cheque,
                            INPUT  "|").
            
        END.
        

        
    
        v-orden_1 = ENTRY(1,v-orden_cheque, "|").
    
        v-orden_2 = "".
        DO k-orden = 2 TO NUM-ENTRIES(v-orden_cheque, "|"):
           v-orden_2 = v-orden_2 + ENTRY(k-orden,v-orden_cheque, "|").
        END.

    
        
        FOR EACH Campo_modelocheque OF Modelocheque 
            BY Campo_modelocheque.x_campomodelo BY Campo_modelocheque.y_campomodelo:
    
           v-valorstring = "".
           IF AVAILABLE Cheque THEN
                CASE Campo_modelocheque.cdg_campomodelo:
                      WHEN "fecha_emision" THEN v-valorstring = STRING(Cheque.fecha_emision).
                      WHEN "diafch_emision" THEN v-valorstring = STRING(DAY(Cheque.fecha_emision)).
                      WHEN "mesfch_emision" THEN v-valorstring = STRING(MONTH(Cheque.fecha_emision)).
                      WHEN "anofch_emision" THEN v-valorstring = STRING(YEAR(Cheque.fecha_emision)).
                      WHEN "nomesfch_emision" THEN v-valorstring = nom_mes [ MONTH(Cheque.fecha_emision) ].

                      WHEN "diafch_pago" THEN v-valorstring = STRING(DAY(Cheque.fecha_salida)).
                      WHEN "mesfch_pago" THEN v-valorstring = STRING(MONTH(Cheque.fecha_salida)).
                      WHEN "anofch_pago" THEN v-valorstring = STRING(YEAR(Cheque.fecha_salida)).
                      WHEN "nomesfch_pago" THEN v-valorstring = nom_mes [ MONTH(Cheque.fecha_salida) ] .

                    WHEN "importe"       THEN RUN formateo_importe.
                    WHEN "numero_cheque" THEN v-valorstring = STRING(Cheque.numero_cheque).
                    WHEN "monto_letras1" THEN v-valorstring = ENTRY(1,v-monto_letras,"|") + FILL("-",Campo_modelocheque.n_campomodelo - LENGTH(ENTRY(1,v-monto_letras,"|"))).
                    WHEN "monto_letras2" THEN v-valorstring = IF NUM-ENTRIES(v-monto_letras,"|") > 1
                                                                 THEN ENTRY(2,v-monto_letras,"|") + FILL("-",Campo_modelocheque.n_campomodelo - LENGTH(ENTRY(2,v-monto_letras,"|")))
                                                                 ELSE FILL("-",Campo_modelocheque.n_campomodelo).
                    WHEN "orden"  THEN 
                    DO:
                        largo = (Campo_modelocheque.n_campomodelo - LENGTH(v-orden_1)) / 2.
                        
                        v-valorstring = v-orden_1 + " " + FILL("- ",largo).
                    END.
                    WHEN "orden2" THEN 
                    DO:
                        largo = (Campo_modelocheque.n_campomodelo - LENGTH(v-orden_2)) / 2.
                        
                        v-valorstring = v-orden_2 + " " + FILL("- ",largo).
                    END.
                    WHEN "observacion" THEN v-valorstring = Cheque.observacion.
                    WHEN "firmante" THEN v-valorstring = x-firmante.
                    WHEN "empresa" THEN v-valorstring = Empresa.nombre.
                    WHEN "datofijo" THEN v-valorstring = Campo_modelocheque.valor_fijo.
                    WHEN "lugarpago" THEN RUN busco_lugar_pago.                
                    
                END CASE.
            ELSE
               CASE Campo_modelocheque.cdg_campomodelo:
                    WHEN "fecha_emision" THEN v-valorstring = STRING("99/99/9999").
                    WHEN "diafch_emision" THEN v-valorstring = STRING("99").
                    WHEN "mesfch_emision" THEN v-valorstring = STRING("99").
                    WHEN "anofch_emision" THEN v-valorstring = STRING("9999").
                    WHEN "nomesfch_emision" THEN v-valorstring = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX".
                    WHEN "diafch_pago" THEN v-valorstring = STRING("99").
                    WHEN "mesfch_pago" THEN v-valorstring = STRING("99").
                    WHEN "anofch_pago" THEN v-valorstring = STRING("9999").
                    WHEN "nomesfch_pago" THEN v-valorstring = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX".
                    WHEN "importe"       THEN RUN formateo_importe.
                    WHEN "numero_cheque" THEN v-valorstring = STRING(9999999).
                    WHEN "monto_letras1" THEN v-valorstring = ENTRY(1,v-monto_letras,"|") + FILL("-",Campo_modelocheque.n_campomodelo - LENGTH(ENTRY(1,v-monto_letras,"|"))).
                    WHEN "monto_letras2" THEN v-valorstring = IF NUM-ENTRIES(v-monto_letras,"|") > 1
                                                                 THEN ENTRY(2,v-monto_letras,"|") + FILL("-",Campo_modelocheque.n_campomodelo - LENGTH(ENTRY(2,v-monto_letras,"|")))
                                                                 ELSE FILL("-",Campo_modelocheque.n_campomodelo).
                    WHEN "orden"  THEN v-valorstring = v-orden_1.
                    WHEN "orden2" THEN v-valorstring = v-orden_2. 
                    WHEN "observacion" THEN v-valorstring = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX".
                    WHEN "firmante" THEN v-valorstring = x-firmante.
                    WHEN "empresa" THEN v-valorstring = Empresa.nombre.
                    WHEN "datofijo" THEN v-valorstring = Campo_modelocheque.valor_fijo.
                    WHEN "lugarpago" THEN RUN busco_lugar_pago.                
                    
                END CASE.
    
    
    

            IF v-valorstring <> "" THEN
            RUN poner_campo ( INPUT Campo_modelocheque.x_campomodelo, 
                              INPUT Campo_modelocheque.y_campomodelo,
                              INPUT Campo_modelocheque.n_campomodelo,
                              INPUT v-valorstring,
                              INPUT Campo_modelocheque.s1_campomodelo,
                              INPUT Campo_modelocheque.s2_campomodelo,
                              INPUT Modelocheque.cdg_impresora).
        END.
    
        FOR EACH T-Imagen_cheque:
            PUT UNFORMATTED T-Imagen_cheque.ch_linea SKIP.
        END.
    
        /*
        PUT "------------------------------------------------------------------" SKIP.
        */
END.
