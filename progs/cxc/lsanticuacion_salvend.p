/*=================================================================================*/
/*             CLASIFICACION DE LOS DERECHOS SEGUN ANTIGUEDAD                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER ref_fecha        AS DATE.
DEFINE INPUT PARAMETER ncol_vencidas    AS INTEGER.
DEFINE INPUT PARAMETER ncol_futuras     AS INTEGER.
DEFINE INPUT PARAMETER dias_columna     AS INTEGER.
DEFINE INPUT PARAMETER lat_cobros       AS INTEGER.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER v-consolidado    AS LOGICAL.

/*=================================================================================*/
/*                                   VARIABLES                                     */
/*=================================================================================*/

{VPERSINM.I}
{WGLISTAR.I}
{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE saldo_total             AS DECIMAL.
DEFINE VARIABLE saldo_total_vencido     AS DECIMAL.
DEFINE VARIABLE saldo_total_a_vencer    AS DECIMAL.

DEFINE VARIABLE saldo_cliente           AS DECIMAL.
DEFINE VARIABLE saldo_cliente_vencido   AS DECIMAL.
DEFINE VARIABLE saldo_cliente_a_vencer  AS DECIMAL.

DEFINE VARIABLE saldo_vendedor          AS DECIMAL.
DEFINE VARIABLE saldo_vendedor_vencido  AS DECIMAL.
DEFINE VARIABLE saldo_vendedor_a_vencer AS DECIMAL.

DEFINE VARIABLE t-importe               AS DECIMAL EXTENT 32.
DEFINE VARIABLE v-importe               AS DECIMAL EXTENT 32.
DEFINE VARIABLE ntcols                  AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol                    AS INTEGER.
DEFINE VARIABLE nt_items                AS INTEGER.
DEFINE VARIABLE ldes                    AS INTEGER.
DEFINE VARIABLE ult_column              AS INTEGER.
DEFINE VARIABLE header_tt1              AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2              AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sr1              AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sr2              AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE columnas                AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE voy_fecha               AS DATE.
DEFINE VARIABLE separa                  AS CHARACTER.
DEFINE VARIABLE desc_moneda             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE hay_movimientos         AS LOGICAL.

/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE Acumulado
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente         AS INTEGER
   FIELD n-columna           AS INTEGER
   FIELD importe             AS DECIMAL FORMAT ">>,>>>,>>9.99-"
   INDEX por_fila_columna IS UNIQUE PRIMARY nro_cliente n-columna.

DEFINE TEMP-TABLE Def-fila
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente         AS INTEGER
   FIELD titulo-fila         AS CHARACTER FORMAT "X(35)"
   INDEX por_fila     IS UNIQUE PRIMARY nro_cliente.

DEFINE TEMP-TABLE Def-columna
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD n-columna           AS INTEGER
   FIELD des_fecha           AS DATE FORMAT "99/99/9999"
   FIELD has_fecha           AS DATE FORMAT "99/99/9999"
   INDEX por_columna  IS UNIQUE PRIMARY n-columna.

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Composición de Saldos por Edades Por Vendedor" AT 75
   "Página:" AT 139 PAGE-NUMBER FORMAT ">>>9" AT 149
   SKIP
   fecha_lis
   "Fecha de Referencia:" AT 75
   ref_fecha 
   hora_lis AT 139
   SKIP
   desc_moneda AT 75 NO-LABEL
   SKIP(2)
   header_sr1 SKIP
   header_tt1 SKIP
   header_tt2 SKIP
   header_sr2
   WITH WIDTH 256 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM 
   header_sr1 
   WITH FRAME frm-subraya WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   Cliente.cdg_cliente COLUMN-LABEL "Código!Cliente"
   Cliente.nom_cliente        COLUMN-LABEL "Razón!Social" 
   columnas
   WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar_todo.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/


PROCEDURE listar_todo:

    fecha_lis = STRING(TODAY,"99/99/99").
    hora_lis = STRING(TIME,"HH:MM:SS").
  
    {findempresa.i}
    que_empresa = Empresa.nombre.
  
    /*--------------------------------------------------------------------------------*/
    /* Armado dinamico de las definiciones de columnas en base a los intervalos dados */
    /*--------------------------------------------------------------------------------*/
  
    ntcols = ncol_vencidas + ncol_futuras.
    voy_fecha = ref_fecha - dias_columna * ncol_vencidas.
    
    DO ncol = 1 TO ntcols:
  
      CREATE Def-columna.
      ASSIGN
             Def-columna.cdg_empresa = Empresa.cdg_empresa
             Def-columna.n-columna   = ncol
             Def-columna.des_fecha   = IF ncol = 1 
                                          THEN DATE(1,1,1901) 
                                          ELSE voy_fecha + 1
             Def-columna.has_fecha   = IF ncol = ntcols 
                                          THEN DATE(12,31,2099) 
                                          ELSE voy_fecha + dias_columna
             voy_fecha               = Def-columna.has_fecha.
  
    END.
  
    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  
                        /* se arma el titulo con las fechas */
  
    header_tt1 = "Identificación                                    " + "         Saldo " + "         Saldo " + "         Saldo ".
    header_tt2 = "del Cliente                                       " + "         Total " + "       Vencido " + "      A Vencer ".
    header_sr1 = "------------------------------------------------- " + "-------------- " + "-------------- " + "-------------- ".
  
    FOR EACH Def-columna NO-LOCK
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
           BREAK BY Def-columna.n-columna:

        separa = IF Def-columna.n-columna = ncol_vencidas THEN "|" ELSE " ".
        header_tt1 = header_tt1 +   
                     IF Def-columna.n-columna = 1
                        THEN "      Hasta el "
                        ELSE "    " + STRING(Def-columna.des_fecha,"99/99/9999") + separa.
   
        header_tt2 = header_tt2 +   
                     IF LAST(Def-columna.n-columna)
                        THEN "   en adelante " 
                        ELSE "    " + STRING(Def-columna.has_fecha,"99/99/9999") + separa.
   
        header_sr1 = header_sr1 + "--------------" + separa.
        ntcols = Def-columna.n-columna.

    END.

    header_sr2 = header_sr1.
  
    {dirprinfile.i &LIN-PAG 66}
    
    /* Crea los registros de acumulado para el total de los clientees */
  
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
    FOR EACH Cliente NO-LOCK
          WHERE CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa),
                FIRST Vendedor OF Cliente 
                      WHERE Vendedor.cdg_vendedor <= has_codigo 
                        AND Vendedor.cdg_vendedor >= des_codigo
              BREAK BY Vendedor.cdg_vendedor  
                    BY Cliente.cdg_cliente:
  
          VIEW FRAME frm-titulo.

          desc_moneda = Moneda.descripcion + IF v-consolidado THEN " CONSOLIDADO" ELSE "" +
                        " - " + Vendedor.nombre + " - " + STRING(des_fecha,"99/99/99") + " al " + STRING(has_fecha,"99/99/99").
  
         /* Crea los registros de acumulado para el cliente a razon de uno por cada columna */
  
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
                     AND Cta_cte.nro_moneda    = Moneda.nro_moneda
                     AND Cta_cte.credito <> Cta_cte.debito:
  
              /* Halla el número de columna que corresponde en base a la fecha del movimiento */
           
              FIND FIRST Def-columna 
                   WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                     AND Def-columna.des_fecha   <= Cta_cte.fecha_vencimiento + lat_cobros
                     AND Def-columna.has_fecha   >= Cta_cte.fecha_vencimiento + lat_cobros
                         NO-LOCK.
           
              FIND FIRST Acumulado 
                   WHERE Acumulado.cdg_empresa   = Empresa.cdg_empresa
                     AND Acumulado.nro_cliente   = Cliente.nro_cliente
                     AND Acumulado.n-columna     = Def-columna.n-columna
                         EXCLUSIVE-LOCK.
             
              Acumulado.importe = Acumulado.importe + Cta_cte.debito - Cta_cte.credito.
              hay_movimientos   =  YES.
  
          END. 
  
          IF hay_movimientos
          THEN DO:

               ASSIGN
                    saldo_cliente_vencido  = 0
                    saldo_cliente_a_vencer = 0.

               columnas = "".
               FOR EACH Acumulado NO-LOCK OF Cliente BY Acumulado.n-columna:
         
                   columnas = columnas + STRING(Acumulado.importe,">>,>>>,>>9.99-") + 
                              IF Acumulado.n-columna = ncol_vencidas 
                                 THEN "|"
                                 ELSE " ".

                   IF Acumulado.n-columna <= ncol_vencidas 
                      THEN saldo_cliente_vencido  = saldo_cliente_vencido  + Acumulado.importe.
                      ELSE saldo_cliente_a_vencer = saldo_cliente_a_vencer + Acumulado.importe.

                   v-importe [ Acumulado.n-columna ] = v-importe [ Acumulado.n-columna ] + Acumulado.importe.
                   t-importe [ Acumulado.n-columna ] = t-importe [ Acumulado.n-columna ] + Acumulado.importe.

               END.

               saldo_cliente = saldo_cliente_vencido + saldo_cliente_a_vencer.
               columnas = STRING(saldo_cliente,">>,>>>,>>9.99-") + " " + 
                          STRING(saldo_cliente_vencido,">>,>>>,>>9.99-") + " " + 
                          STRING(saldo_cliente_a_vencer,">>,>>>,>>9.99-") + " " +                            
                          columnas.

               IF LINE-COUNTER = PAGE-SIZE - 1
               THEN DO:
                    DISPLAY header_sr1 
                            WITH FRAME frm-subraya.
                    DOWN WITH FRAME frm-listado.        
               END.

               DISPLAY Cliente.cdg_cliente
                       Cliente.nom_cliente
                       columnas
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.        

          END.
          
          IF LAST-OF(Vendedor.cdg_vendedor)
          THEN DO:

                columnas = "".
                saldo_vendedor_vencido = 0.
                saldo_vendedor_a_vencer = 0.
                FOR EACH Acumulado NO-LOCK WHERE Acumulado.nro_cliente = 0 BY Acumulado.n-columna:
                  
                    columnas = columnas + STRING(v-importe [ Acumulado.n-columna ],">>,>>>,>>9.99-") + 
                               IF Acumulado.n-columna = ncol_vencidas 
                                  THEN "|"
                                  ELSE " ".

                    IF Acumulado.n-columna <= ncol_vencidas 
                       THEN saldo_vendedor_vencido  = saldo_vendedor_vencido  + v-importe [ Acumulado.n-columna ].
                       ELSE saldo_vendedor_a_vencer = saldo_vendedor_a_vencer + v-importe [ Acumulado.n-columna ].

                    v-importe [ Acumulado.n-columna ] = 0.

                END.

                saldo_vendedor = saldo_vendedor_vencido + saldo_vendedor_a_vencer.
                columnas = STRING(saldo_vendedor,">>,>>>,>>9.99-") + " " + 
                           STRING(saldo_vendedor_vencido,">>,>>>,>>9.99-") + " " + 
                           STRING(saldo_vendedor_a_vencer,">>,>>>,>>9.99-") + " " +                            
                           columnas.
                DISPLAY header_sr1 
                        WITH FRAME frm-subraya.
                DOWN WITH FRAME frm-listado.        
                DISPLAY "Total " + Vendedor.nombre @ Cliente.nom_cliente
                        columnas
                        WITH FRAME frm-listado.
                DOWN 2 WITH FRAME frm-listado.        

                IF NOT LAST(Vendedor.cdg_vendedor) THEN PAGE.

          END.
          
    END.
    DISPLAY header_sr1 
            WITH FRAME frm-subraya.
    DOWN WITH FRAME frm-listado.        

    OUTPUT CLOSE.
  
    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22 ).

END PROCEDURE.

