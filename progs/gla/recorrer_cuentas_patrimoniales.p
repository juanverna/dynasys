/*=================================================================================*/
/*           RECORRE LA CLASIFICACION DE CUENTAS Y ARMA EL BALANCE                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_clase                 AS ROWID.
DEFINE INPUT PARAMETER nivel                     AS INTEGER.
DEFINE INPUT PARAMETER p-cdg_empresa             AS CHARACTER.
DEFINE INPUT PARAMETER p-cdg_nombalance          AS CHARACTER.
DEFINE INPUT PARAMETER p-nro_moneda              AS INTEGER.
DEFINE INPUT PARAMETER p-des_fecha               AS DATE.
DEFINE INPUT PARAMETER p-has_fecha               AS DATE.
DEFINE INPUT-OUTPUT PARAMETER p-acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE INPUT-OUTPUT PARAMETER p-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos".

/*=================================================================================*/
/*                                V A R I A B L E S                                */
/*=================================================================================*/

DEFINE VARIABLE l-saldo_per        LIKE Asn_detalle.debito LABEL "Saldo" INITIAL 0.
DEFINE VARIABLE l-acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" INITIAL 0.
DEFINE VARIABLE l-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" INITIAL 0.
DEFINE VARIABLE l-saldo_tot        LIKE Asn_detalle.debito LABEL "Saldo" INITIAL 0.
DEFINE VARIABLE l-acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" INITIAL 0.
DEFINE VARIABLE l-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" INITIAL 0.

DEFINE VARIABLE v-esp              AS CHARACTER.
DEFINE SHARED VARIABLE c-linea     AS INTEGER.
DEFINE VARIABLE linea_total        AS INTEGER.

{VPERSINM.I}

DEFINE BUFFER   Clase  FOR Clase_de_cuenta.
DEFINE BUFFER Subclase FOR Clase_de_cuenta.

DEFINE QUERY qry_clasificacion  FOR Subclase.
DEFINE QUERY qry_cuentas        FOR Libro-cuenta,Cuenta.

{SHVSUMYS.I}

DEFINE VARIABLE que_subclase AS CHARACTER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FIND FIRST Clase WHERE ROWID(Clase) = que_clase NO-LOCK.
/*
IF NOT (Clase.cdg_clase BEGINS ".4" OR Clase.cdg_clase BEGINS ".5") OR Clase.cdg_clase = ?
THEN DO:
*/
IF SUBSTRING(Clase.cdg_subclase,1,2) < ".4" /* Perdon Backus y Von Noiman !!!! (10 a¤os en exactas para hacer esto....*/
THEN DO:
    IF Clase.cdg_clase <> ?
    THEN DO:
       que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(Clase.cdg_clase) + 2).   
       RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */
       DO TRANSACTION:
          c-linea = c-linea + 1.
          CREATE Lst_sumysal.
          ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
                 Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
                 Lst_sumysal.que_codigo        = v-esp + que_subclase
                 Lst_sumysal.que_nombre        = v-esp + Clase.nombre_subclase
                 Lst_sumysal.acm_debitos_per   = l-acm_debitos_per
                 Lst_sumysal.acm_creditos_per  = l-acm_creditos_per
                 Lst_sumysal.saldo_per         = l-saldo_per
                 Lst_sumysal.acm_creditos_tot  = l-acm_creditos_tot
                 Lst_sumysal.acm_debitos_tot   = l-acm_debitos_tot
                 Lst_sumysal.saldo_tot         = l-saldo_tot
                 Lst_sumysal.linea             = c-linea.
    
       END.
       nivel = nivel + 1.
    END.   
    
    RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */
    
    /*
    IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                                 AND Subclase.cdg_clase = Clase.cdg_subclase)
    THEN DO: /* No es el último nivel. Seguimos profundizando */
    */

    IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                                 AND Subclase.cdg_clase = Clase.cdg_subclase
                                 AND SUBSTRING(Subclase.cdg_clase,1,2) < ".4")
    THEN DO:

       RUN ABRE_QUERY.
       GET FIRST qry_clasificacion.
       DO WHILE AVAILABLE Subclase:              
    
          l-acm_debitos_per  = 0.
          l-acm_creditos_per = 0.
          l-acm_debitos_tot  = 0.
          l-acm_creditos_tot = 0.
    
          linea_total = c-linea.
    
          RUN recorrer_cuentas_patrimoniales.p ( INPUT ROWID(Subclase) , 
                                                 INPUT nivel,
                                                 INPUT p-cdg_empresa,
                                                 INPUT p-cdg_nombalance,
                                                 INPUT p-nro_moneda,
                                                 INPUT p-des_fecha,
                                                 INPUT p-has_fecha,
                                                 INPUT-OUTPUT l-acm_debitos_per,
                                                 INPUT-OUTPUT l-acm_creditos_per,
                                                 INPUT-OUTPUT l-acm_debitos_tot,
                                                 INPUT-OUTPUT l-acm_creditos_tot ).
          ASSIGN
              l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
              l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.
    
          /*             
          RUN IDENTAR ( INPUT 1 + nivel * 3 ). /* Fijamos identacion de los totales */
          */
          DO TRANSACTION:
             
             FIND Lst_sumysal WHERE Lst_sumysal.linea = linea_total + 1 EXCLUSIVE-LOCK.
             ASSIGN Lst_sumysal.acm_debitos_per   = l-acm_debitos_per
                    Lst_sumysal.acm_creditos_per  = l-acm_creditos_per
                    Lst_sumysal.saldo_per         = l-saldo_per
                    Lst_sumysal.acm_debitos_tot   = l-acm_debitos_tot
                    Lst_sumysal.acm_creditos_tot  = l-acm_creditos_tot
                    Lst_sumysal.saldo_tot         = l-saldo_tot.
                    
          END.
          
          ASSIGN
             p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
             p-acm_creditos_per = p-acm_creditos_per  + l-acm_creditos_per
             p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
             p-acm_creditos_tot = p-acm_creditos_tot  + l-acm_creditos_tot.
          
          GET NEXT qry_clasificacion.
       END.
    
    END.
    /*ELSE DO:*/
    
    /*
    RUN IDENTAR ( INPUT 1 + ( nivel + 1 ) * 3).  /* Las cuentas se listan identadas
                                            respecto del nivel de clasifcacion */
    */
    RUN ABRE_QUERY_CUENTAS.
    GET FIRST qry_cuentas.
    DO WHILE AVAILABLE Cuenta:
    
        RUN CALCULAR_SALDO. 
        ASSIGN
            l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
            l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.
            
        DO TRANSACTION:
           c-linea = c-linea + 1.
           CREATE Lst_sumysal.
           ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
                  Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
                  Lst_sumysal.que_codigo        = v-esp + Cuenta.cdg_cuenta
                  Lst_sumysal.que_nombre        = v-esp + Cuenta.nombre_cta
                  Lst_sumysal.acm_debitos_per   = l-acm_debitos_per
                  Lst_sumysal.acm_creditos_per  = l-acm_creditos_per
                  Lst_sumysal.saldo_per         = l-saldo_per
                  Lst_sumysal.acm_creditos_tot  = l-acm_creditos_tot
                  Lst_sumysal.acm_debitos_tot   = l-acm_debitos_tot
                  Lst_sumysal.saldo_tot         = l-saldo_tot
                  Lst_sumysal.linea             = c-linea.
        
        END.
        
        ASSIGN
           p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
           p-acm_creditos_per = p-acm_creditos_per  + l-acm_creditos_per
           p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
           p-acm_creditos_tot = p-acm_creditos_tot  + l-acm_creditos_tot.
        
        GET NEXT qry_cuentas.
    END.
    
    /*END.*/
END.


/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

/*
PROCEDURE ABRE_QUERY:

        OPEN QUERY qry_clasificacion 
             FOR EACH Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                                 AND Subclase.cdg_clase = Clase.cdg_subclase. 
                              
END PROCEDURE.

PROCEDURE ABRE_QUERY_CUENTAS:

        OPEN QUERY qry_cuentas 
             FOR EACH Libro-cuenta 
                     WHERE Libro-cuenta.cdg_librocontable = Clase.cdg_librocontable
                       AND Libro-cuenta.cdg_subclase = Clase.cdg_subclase
                       AND ( Libro-cuenta.cdg_subclase BEGINS ".1" 
                            OR Libro-cuenta.cdg_subclase BEGINS ".2" 
                            OR Libro-cuenta.cdg_subclase BEGINS ".3"  ) ,
                           FIRST Cuenta OF Libro-cuenta BY Cuenta.cdg_cuenta. 
                              
END PROCEDURE.
*/

PROCEDURE ABRE_QUERY:

        OPEN QUERY qry_clasificacion 
             FOR EACH Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                                 AND Subclase.cdg_clase = Clase.cdg_subclase
                                 AND SUBSTRING(Subclase.cdg_subclase,1,2) < ".4". 
                              
END PROCEDURE.

PROCEDURE ABRE_QUERY_CUENTAS:

        OPEN QUERY qry_cuentas 
             FOR EACH Libro-cuenta 
                     WHERE Libro-cuenta.cdg_librocontable = Clase.cdg_librocontable
                       AND Libro-cuenta.cdg_subclase = Clase.cdg_subclase
                       AND Libro-cuenta.cdg_empresa  = p-cdg_empresa,
                           FIRST Cuenta OF Libro-cuenta WHERE LOOKUP(Cuenta.grupo_pat,"A,P,C,R") <> 0
                                           BY Cuenta.cdg_cuenta. 
                              
END PROCEDURE.

PROCEDURE CALCULAR_SALDO:

    l-acm_debitos_per  = 0. 
    l-acm_creditos_per = 0.
    l-acm_debitos_tot  = 0.
    l-acm_creditos_tot = 0.

   IF LOOKUP(Cuenta.grupo_pat,"A,P,C") <> 0
   THEN DO:
       FOR EACH Asn_detalle OF Cuenta 
           WHERE Asn_detalle.fecha_mayor <= p-has_fecha 
             AND Asn_detalle.cdg_empresa = p-cdg_empresa
             AND Asn_detalle.nro_moneda  = p-nro_moneda
             AND Asn_detalle.reexpresion
              BY Asn_detalle.fecha_mayor:

        
          IF Asn_detalle.fecha_mayor >= p-des_fecha  
          THEN DO:
              l-acm_debitos_per  = l-acm_debitos_per  + Asn_detalle.debito.
              l-acm_creditos_per = l-acm_creditos_per + Asn_detalle.credito.
          END.

          l-acm_debitos_tot  = l-acm_debitos_tot  + Asn_detalle.debito.
          l-acm_creditos_tot = l-acm_creditos_tot + Asn_detalle.credito.

       END.

   END.
   ELSE DO:
       IF Cuenta.grupo_pat = "R"
           THEN RUN calcular_resultados.p ( INPUT p-cdg_empresa,
                                            INPUT p-cdg_nombalance,
                                            INPUT p-nro_moneda,
                                            INPUT p-des_fecha,
                                            INPUT p-has_fecha,
                                            INPUT-OUTPUT l-acm_debitos_per,
                                            INPUT-OUTPUT l-acm_creditos_per,
                                            INPUT-OUTPUT l-acm_debitos_tot,
                                            INPUT-OUTPUT l-acm_creditos_tot ).
   END.

   l-saldo_per = l-acm_debitos_per  - l-acm_creditos_per.
   l-saldo_tot = l-acm_debitos_tot  - l-acm_creditos_tot.

END PROCEDURE.

PROCEDURE IDENTAR:

    DEFINE INPUT PARAMETER i-columna AS INTEGER.
  
    v-esp = FILL(" ",i-columna).

END PROCEDURE.

PROCEDURE PONER_TOTAL:

    c-linea = c-linea + 1.
    CREATE Lst_sumysal.
    ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
           Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
           Lst_sumysal.que_codigo        = FILL("-",10)
           Lst_sumysal.que_nombre        = FILL("-",35)
           Lst_sumysal.acm_debitos_per   = 0
           Lst_sumysal.acm_creditos_per  = 0
           Lst_sumysal.saldo_per         = 0
           Lst_sumysal.acm_creditos_tot  = 0
           Lst_sumysal.acm_debitos_tot   = 0
           Lst_sumysal.saldo_tot         = 0
           Lst_sumysal.linea             = c-linea.

    c-linea = c-linea + 1.
    CREATE Lst_sumysal.
    ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
           Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
           Lst_sumysal.que_codigo        = v-esp + "Total"
           Lst_sumysal.que_nombre        = v-esp + Subclase.nombre_subclase
           Lst_sumysal.acm_debitos_per   = l-acm_debitos_per
           Lst_sumysal.acm_creditos_per  = l-acm_creditos_per
           Lst_sumysal.saldo_per         = l-saldo_per
           Lst_sumysal.acm_creditos_tot  = l-acm_creditos_tot
           Lst_sumysal.acm_debitos_tot   = l-acm_debitos_tot
           Lst_sumysal.saldo_tot         = l-saldo_tot
           Lst_sumysal.linea             = c-linea.

    c-linea = c-linea + 1.
    CREATE Lst_sumysal.
    ASSIGN Lst_sumysal.cdg_empresa       = p-cdg_empresa
           Lst_sumysal.cdg_nombalance    = p-cdg_nombalance
           Lst_sumysal.que_codigo        = FILL("-",10)
           Lst_sumysal.que_nombre        = FILL("-",35)
           Lst_sumysal.acm_debitos_per   = 0
           Lst_sumysal.acm_creditos_per  = 0
           Lst_sumysal.saldo_per         = 0
           Lst_sumysal.acm_creditos_tot  = 0
           Lst_sumysal.acm_debitos_tot   = 0
           Lst_sumysal.saldo_tot         = 0
           Lst_sumysal.linea             = c-linea.

END PROCEDURE.
