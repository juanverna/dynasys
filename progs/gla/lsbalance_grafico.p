/*=================================================================================*/
/*                  GENERA EL LISTADO DE BALANCE CLASIFICADO                       */
/*=================================================================================*/

DEFINE INPUT PARAMETER  p-des_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-has_fecha      AS DATE.
DEFINE INPUT PARAMETER  p-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER  p-reexpresion    AS LOGICAL.
DEFINE INPUT PARAMETER  p-cdg_balance    AS CHARACTER.
DEFINE INPUT PARAMETER  p-lis_fecha      AS LOGICAL.
DEFINE INPUT PARAMETER  p-lin_pagina     AS INTEGER.
DEFINE INPUT PARAMETER  p-ult_pagina     AS INTEGER.
DEFINE INPUT PARAMETER  p-todas_cuent    AS LOGICAL.   
DEFINE OUTPUT PARAMETER p-xfile          AS CHARACTER.   

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

DEFINE VARIABLE l-saldo_acreed      LIKE Asn_detalle.debito   NO-UNDO.
DEFINE VARIABLE l-saldo_deudor      LIKE Asn_detalle.debito   NO-UNDO.
DEFINE VARIABLE l-saldo_per         LIKE Asn_detalle.debito   NO-UNDO.
DEFINE VARIABLE l-acm_debitos_per   LIKE Asn_detalle.debito   NO-UNDO.
DEFINE VARIABLE l-acm_creditos_per  LIKE Asn_detalle.credito  NO-UNDO.
DEFINE VARIABLE l-saldo_tot         LIKE Asn_detalle.debito   NO-UNDO.
DEFINE VARIABLE l-acm_debitos_tot   LIKE Asn_detalle.debito   NO-UNDO.
DEFINE VARIABLE l-acm_creditos_tot  LIKE Asn_detalle.credito  NO-UNDO.
DEFINE VARIABLE que_subclase        AS CHARACTER              NO-UNDO.
DEFINE VARIABLE que_archivo         AS CHARACTER              NO-UNDO.
DEFINE VARIABLE c-linea             AS INTEGER                NO-UNDO.

DEFINE BUFFER   Clase  FOR Clase_de_cuenta.
DEFINE BUFFER Subclase FOR Clase_de_cuenta.

DEFINE TEMP-TABLE T-Balance NO-UNDO LIKE Lst_sumysal.

{crystal_dyna.p}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
FIND FIRST Clase WHERE Clase.cdg_clase = ? NO-LOCK.
SESSION:IMMEDIATE-DISPLAY = YES.             
EMPTY TEMP-TABLE T-Balance NO-ERROR.

RUN recorrer_cuentas_patrimoniales ( INPUT ROWID(Clase) , 
                                     INPUT 0,
                                     INPUT-OUTPUT l-acm_debitos_per,
                                     INPUT-OUTPUT l-acm_creditos_per,
                                     INPUT-OUTPUT l-acm_debitos_tot,
                                     INPUT-OUTPUT l-acm_creditos_tot ).

ASSIGN l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
       l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.

c-linea = c-linea + 1.
CREATE T-Balance.
ASSIGN T-Balance.cdg_empresa       = Empresa.cdg_empresa
       T-Balance.cdg_nombalance    = p-cdg_balance
       T-Balance.que_codigo        = ""
       T-Balance.que_nombre        = "TOTAL GENERAL"
       T-Balance.acm_debitos_per   = l-acm_debitos_per
       T-Balance.acm_creditos_per  = l-acm_creditos_per
       T-Balance.saldo_per         = l-saldo_per
       T-Balance.acm_creditos_tot  = l-acm_creditos_tot
       T-Balance.acm_debitos_tot   = l-acm_debitos_tot
       T-Balance.saldo_tot         = l-saldo_tot
       T-Balance.linea             = c-linea.

/*=================================================================================*/
/*           INVOCA AL REPORT BUILDER PARA VER EL BALANCE                          */
/*=================================================================================*/

p-xfile = "c:\sic-temp\balance.xml".
RUN exportToXmlDset ( "dset", STRING( TEMP-TABLE T-Balance:HANDLE ), p-xfile).

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE recorrer_cuentas_patrimoniales:

    /*=================================================================================*/
    /*           RECORRE LA CLASIFICACION DE CUENTAS Y ARMA EL BALANCE                 */
    /*=================================================================================*/
    
    DEFINE INPUT PARAMETER que_clase                 AS ROWID.
    DEFINE INPUT PARAMETER c-nivel                     AS INTEGER.
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
    
    DEFINE VARIABLE linea_total        AS INTEGER.
    
    DEFINE BUFFER   Clase  FOR Clase_de_cuenta.
    DEFINE BUFFER Subclase FOR Clase_de_cuenta.
    
    DEFINE QUERY qry_clasificacion  FOR Subclase.
    DEFINE QUERY qry_cuentas        FOR Libro-cuenta,Cuenta.
    
    DEFINE VARIABLE que_subclase AS CHARACTER.
    
    /*=================================================================================*/
    /*                          B L O Q U E   P R I N C I P A L                        */
    /*=================================================================================*/

    FIND FIRST Clase WHERE ROWID(Clase) = que_clase NO-LOCK.

    IF SUBSTRING(Clase.cdg_subclase,1,2) < ".4"
    THEN DO:
        IF Clase.cdg_clase <> ?
        THEN DO:
           que_subclase = SUBSTRING(Clase.cdg_subclase,LENGTH(Clase.cdg_clase) + 2).   
              
           CREATE T-Balance.
           ASSIGN c-linea                     = c-linea + 1
                  c-nivel                     = c-nivel + 1
                  T-Balance.cdg_empresa       = Empresa.cdg_empresa
                  T-Balance.cdg_nombalance    = p-cdg_balance
                  T-Balance.que_padre         = Clase.cdg_clase /* que_subclase */
                  T-Balance.que_codigo        = Clase.cdg_subclase /* que_subclase */
                  T-Balance.que_nombre        = Clase.nombre_subclase
                  T-Balance.acm_debitos_per   = l-acm_debitos_per
                  T-Balance.acm_creditos_per  = l-acm_creditos_per
                  T-Balance.saldo_per         = l-saldo_per
                  T-Balance.acm_creditos_tot  = l-acm_creditos_tot
                  T-Balance.acm_debitos_tot   = l-acm_debitos_tot
                  T-Balance.saldo_tot         = l-saldo_tot
                  T-Balance.linea             = c-linea
                  T-Balance.nivel             = c-nivel.
        END.   
        
        IF CAN-FIND(FIRST Subclase WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                                     AND Subclase.cdg_clase = Clase.cdg_subclase
                                     AND SUBSTRING(Subclase.cdg_clase,1,2) < ".4")
        THEN DO:

            OPEN QUERY qry_clasificacion 
                 FOR EACH Subclase NO-LOCK
                     WHERE Subclase.cdg_librocontable = Clase.cdg_librocontable
                       AND Subclase.cdg_clase = Clase.cdg_subclase
                       AND SUBSTRING(Subclase.cdg_subclase,1,2) < ".4". 

            GET FIRST qry_clasificacion.
            DO WHILE AVAILABLE Subclase:              

                ASSIGN l-acm_debitos_per  = 0
                       l-acm_creditos_per = 0
                       l-acm_debitos_tot  = 0
                       l-acm_creditos_tot = 0
                       linea_total = c-linea.
        
                RUN recorrer_cuentas_patrimoniales ( INPUT ROWID(Subclase) , 
                                                     INPUT c-nivel,
                                                     INPUT-OUTPUT l-acm_debitos_per,
                                                     INPUT-OUTPUT l-acm_creditos_per,
                                                     INPUT-OUTPUT l-acm_debitos_tot,
                                                     INPUT-OUTPUT l-acm_creditos_tot ).

                FIND T-Balance WHERE T-Balance.linea = linea_total + 1 EXCLUSIVE-LOCK.

                ASSIGN l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
                       l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot

                       T-Balance.acm_debitos_per   = l-acm_debitos_per
                       T-Balance.acm_creditos_per  = l-acm_creditos_per
                       T-Balance.saldo_per         = l-saldo_per
                       T-Balance.acm_debitos_tot   = l-acm_debitos_tot
                       T-Balance.acm_creditos_tot  = l-acm_creditos_tot
                       T-Balance.saldo_tot         = l-saldo_tot
              
                       p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
                       p-acm_creditos_per = p-acm_creditos_per  + l-acm_creditos_per
                       p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
                       p-acm_creditos_tot = p-acm_creditos_tot  + l-acm_creditos_tot.
              
                GET NEXT qry_clasificacion.

           END.
        
        END.

        OPEN QUERY qry_cuentas 
             FOR EACH Libro-cuenta NO-LOCK
                     WHERE Libro-cuenta.cdg_librocontable = Clase.cdg_librocontable
                       AND Libro-cuenta.cdg_subclase = Clase.cdg_subclase
                       AND Libro-cuenta.cdg_empresa  = Empresa.cdg_empresa,
                           FIRST Cuenta OF Libro-cuenta NO-LOCK WHERE LOOKUP(Cuenta.grupo_pat,"A,P,C,R") <> 0
                                           BY Cuenta.cdg_cuenta. 

        GET FIRST qry_cuentas.
        DO WHILE AVAILABLE Cuenta:

            RUN calcular_saldo. 
            ASSIGN l-saldo_per = l-acm_debitos_per - l-acm_creditos_per
                   l-saldo_tot = l-acm_debitos_tot - l-acm_creditos_tot.
                
            c-linea = c-linea + 1.
            CREATE T-Balance.
            ASSIGN T-Balance.cdg_empresa       = Empresa.cdg_empresa
                   T-Balance.cdg_nombalance    = p-cdg_balance
                   T-Balance.que_padre         = Clase.cdg_subclase
                   T-Balance.que_codigo        = Cuenta.cdg_cuenta
                   T-Balance.que_nombre        = Cuenta.nombre_cta
                   T-Balance.acm_debitos_per   = l-acm_debitos_per
                   T-Balance.acm_creditos_per  = l-acm_creditos_per
                   T-Balance.saldo_per         = l-saldo_per
                   T-Balance.acm_creditos_tot  = l-acm_creditos_tot
                   T-Balance.acm_debitos_tot   = l-acm_debitos_tot
                   T-Balance.saldo_tot         = l-saldo_tot
                   T-Balance.linea             = c-linea
                   T-Balance.nivel             = c-nivel.

            
            ASSIGN
               p-acm_debitos_per  = p-acm_debitos_per   + l-acm_debitos_per
               p-acm_creditos_per = p-acm_creditos_per  + l-acm_creditos_per
               p-acm_debitos_tot  = p-acm_debitos_tot   + l-acm_debitos_tot
               p-acm_creditos_tot = p-acm_creditos_tot  + l-acm_creditos_tot.
            
            GET NEXT qry_cuentas.
        END.
        
    END.

END PROCEDURE.

PROCEDURE calcular_saldo:

   ASSIGN l-acm_debitos_per  = 0 
          l-acm_creditos_per = 0
          l-acm_debitos_tot  = 0
          l-acm_creditos_tot = 0.

   IF LOOKUP(Cuenta.grupo_pat,"A,P,C") <> 0
   THEN DO:
       FOR EACH Asn_detalle OF Cuenta 
           WHERE Asn_detalle.fecha_mayor <= p-has_fecha 
             AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
             AND Asn_detalle.nro_moneda  = Moneda.nro_moneda
             AND Asn_detalle.reexpresion
              BY Asn_detalle.fecha_mayor:
        
          IF Asn_detalle.fecha_mayor >= p-des_fecha  
          THEN DO:
              ASSIGN l-acm_debitos_per  = l-acm_debitos_per  + Asn_detalle.debito
                     l-acm_creditos_per = l-acm_creditos_per + Asn_detalle.credito.
          END.

          ASSIGN l-acm_debitos_tot  = l-acm_debitos_tot  + Asn_detalle.debito
                 l-acm_creditos_tot = l-acm_creditos_tot + Asn_detalle.credito.

       END.

   END.
   ELSE DO:
       IF Cuenta.grupo_pat = "R"
           THEN RUN calcular_resultados.p ( INPUT Empresa.cdg_empresa,
                                            INPUT p-cdg_balance,
                                            INPUT Moneda.nro_moneda,
                                            INPUT p-des_fecha,
                                            INPUT p-has_fecha,
                                            INPUT-OUTPUT l-acm_debitos_per,
                                            INPUT-OUTPUT l-acm_creditos_per,
                                            INPUT-OUTPUT l-acm_debitos_tot,
                                            INPUT-OUTPUT l-acm_creditos_tot ).
   END.

   ASSIGN l-saldo_per = l-acm_debitos_per  - l-acm_creditos_per
          l-saldo_tot = l-acm_debitos_tot  - l-acm_creditos_tot.

END PROCEDURE.



