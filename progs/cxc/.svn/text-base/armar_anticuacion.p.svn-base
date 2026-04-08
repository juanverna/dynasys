/*=================================================================================*/
/*             CLASIFICACION DE LOS DERECHOS SEGUN ANTIGUEDAD                      */
/*=================================================================================*/

DEFINE TEMP-TABLE Acumulado NO-UNDO
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente       AS INTEGER
   FIELD n-columna           AS INTEGER
   FIELD importe             AS DECIMAL FORMAT ">>,>>>,>>9.99-"
   INDEX por_fila_columna IS UNIQUE PRIMARY nro_cliente n-columna.

DEFINE OUTPUT PARAMETER TABLE FOR Acumulado.

/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE Def-fila  NO-UNDO
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente       AS INTEGER
   FIELD titulo-fila         AS CHARACTER FORMAT "X(35)"
   INDEX por_fila     IS UNIQUE PRIMARY nro_cliente.

DEFINE TEMP-TABLE Def-columna NO-UNDO
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD n-columna           AS INTEGER
   FIELD des_fecha           AS DATE FORMAT "99/99/9999"
   FIELD has_fecha           AS DATE FORMAT "99/99/9999"
   INDEX por_columna  IS UNIQUE PRIMARY n-columna.



/*=================================================================================*/
/*                                   VARIABLES                                     */
/*=================================================================================*/

DEFINE VARIABLE des_codigo       LIKE Cliente.cdg_cliente.
DEFINE VARIABLE has_codigo       LIKE Cliente.cdg_cliente.
DEFINE VARIABLE que_moneda       LIKE Moneda.cdg_moneda.
DEFINE VARIABLE ref_fecha        AS DATE.
DEFINE VARIABLE ncol_vencidas    AS INTEGER.
DEFINE VARIABLE ncol_futuras     AS INTEGER.
DEFINE VARIABLE dias_columna     AS INTEGER.
DEFINE VARIABLE lat_cobros       AS INTEGER.
DEFINE VARIABLE p-des_fecha      AS DATE.
DEFINE VARIABLE p-has_fecha      AS DATE.
DEFINE VARIABLE v-consolidado    AS LOGICAL.
DEFINE VARIABLE des_zonag        LIKE Zona_geografica.cdg_zonag.
DEFINE VARIABLE has_zonag        LIKE Zona_geografica.cdg_zonag.
  
DEFINE VARIABLE saldo_total             AS DECIMAL.
DEFINE VARIABLE saldo_cliente           AS DECIMAL.
DEFINE VARIABLE t-importe               AS DECIMAL EXTENT 32.
DEFINE VARIABLE ntcols                  AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol                    AS INTEGER.
DEFINE VARIABLE nt_items                AS INTEGER.
DEFINE VARIABLE ldes                    AS INTEGER.
DEFINE VARIABLE ult_column              AS INTEGER.
DEFINE VARIABLE voy_fecha               AS DATE.
DEFINE VARIABLE hay_movimientos         AS LOGICAL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

ASSIGN ref_fecha        = TODAY
       ncol_vencidas    = 1
       ncol_futuras     = 1
       dias_columna     = 30
       lat_cobros       = 0
       v-consolidado    = YES
       que_moneda       = "PE".

FIND Empresa "S".

RUN armar_anticuacion.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/


PROCEDURE armar_anticuacion:

    /*--------------------------------------------------------------------------------*/
    /* Armado dinamico de las definiciones de columnas en base a los intervalos dados */
    /*--------------------------------------------------------------------------------*/
    
    ASSIGN ntcols = ncol_vencidas + ncol_futuras
           voy_fecha = ref_fecha - dias_columna * ncol_vencidas.
    
    DO ncol = 1 TO ntcols:
    
      CREATE Def-columna.
      ASSIGN Def-columna.cdg_empresa = Empresa.cdg_empresa
             Def-columna.n-columna   = ncol
             Def-columna.des_fecha   = IF ncol = 1 
                                          THEN p-des_fecha 
                                          ELSE voy_fecha + 1
             Def-columna.has_fecha   = IF ncol = ntcols 
                                          THEN p-has_fecha 
                                          ELSE voy_fecha + dias_columna
             voy_fecha               = Def-columna.has_fecha.
    
    END.
    
    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
    
    FOR EACH Def-columna NO-LOCK
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
              BREAK BY Def-columna.n-columna:
        
        CREATE Acumulado.
        ASSIGN Acumulado.cdg_empresa    = Empresa.cdg_empresa
               Acumulado.nro_cliente    = 0
               Acumulado.n-columna      = Def-columna.n-columna
               Acumulado.importe        = 0.
      
    END.              
    
    saldo_total = 0.
    t-importe = 0. 
      
    FOR EACH Cliente:
   
       /* Crea los registros de acumulado para el cliente a razon de uno por cada columna */
    
        CREATE Acumulado.
        ASSIGN Acumulado.cdg_empresa    = Empresa.cdg_empresa
               Acumulado.nro_cliente    = Cliente.nro_cliente
               Acumulado.n-columna      = 0
               Acumulado.importe        = 0.
        
        FOR EACH Def-columna NO-LOCK
          WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
             BREAK BY Def-columna.n-columna:
        
          CREATE Acumulado.
          ASSIGN Acumulado.cdg_empresa    = Empresa.cdg_empresa
                 Acumulado.nro_cliente    = Cliente.nro_cliente
                 Acumulado.n-columna      = Def-columna.n-columna
                 Acumulado.importe        = 0.
        
        END.

        hay_movimientos = NO.
        FOR EACH Cta_cte OF Cliente 
               WHERE ( Cta_cte.cdg_empresa = Empresa.cdg_empresa OR v-consolidado )
                 AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa)
                 AND Cta_cte.cdg_empresa <> "H"
                 AND Cta_cte.nro_moneda    = Moneda.nro_moneda 
                 AND Cta_cte.credito <> Cta_cte.debito
                 AND Cta_cte.fecha_emision >= p-des_fecha
                 AND Cta_cte.fecha_emision <= p-has_fecha:
        
          /* Halla el número de columna que corresponde en base a la fecha del movimiento */
        
          FIND FIRST Def-columna 
               WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                 AND Def-columna.cdg_empresa <> "H"
                 AND Def-columna.des_fecha   <= Cta_cte.fecha_emision + lat_cobros
                 AND Def-columna.has_fecha   >= Cta_cte.fecha_emision + lat_cobros
                     NO-LOCK.
        
          FIND FIRST Acumulado 
               WHERE Acumulado.cdg_empresa   = Empresa.cdg_empresa
                 AND Acumulado.cdg_empresa  <> "H"
                 AND Acumulado.nro_cliente   = Cliente.nro_cliente
                 AND Acumulado.n-columna     = Def-columna.n-columna
                     EXCLUSIVE-LOCK.
         
          Acumulado.importe = Acumulado.importe + Cta_cte.debito - Cta_cte.credito.
          hay_movimientos   =  YES.
        
        END. 
        
        IF hay_movimientos
        THEN DO:
           saldo_cliente = 0.
           FOR EACH Acumulado NO-LOCK OF Cliente BY Acumulado.n-columna:
               t-importe [ Acumulado.n-columna ] = t-importe [ Acumulado.n-columna ] + Acumulado.importe.
               saldo_cliente = saldo_cliente + Acumulado.importe.
           END.
           saldo_total =  saldo_total + saldo_cliente.
        
           FIND Acumulado OF Cliente 
               WHERE Acumulado.cdg_empresa    = Empresa.cdg_empresa
                 AND Acumulado.nro_cliente    = Cliente.nro_cliente
                 AND Acumulado.n-columna      = 0.
                  
           ASSIGN Acumulado.importe        = saldo_total.
        
        END.

   END.

END PROCEDURE.

