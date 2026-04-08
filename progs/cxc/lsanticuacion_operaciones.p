
/*=================================================================================*/
/*             CLASIFICACION DE LOS DERECHOS SEGUN ANTIGUEDAD                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER ref_fecha        AS DATE.
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

DEFINE VARIABLE saldo_cliente2          AS DECIMAL.
DEFINE VARIABLE saldo_cliente_vencido2  AS DECIMAL.
DEFINE VARIABLE saldo_cliente_a_vencer2 AS DECIMAL.

DEFINE VARIABLE saldo_vendedor          AS DECIMAL.
DEFINE VARIABLE saldo_vendedor_vencido  AS DECIMAL.
DEFINE VARIABLE saldo_vendedor_a_vencer AS DECIMAL.

DEFINE VARIABLE saldo_vendedor2          AS DECIMAL.
DEFINE VARIABLE saldo_vendedor_vencido2  AS DECIMAL.
DEFINE VARIABLE saldo_vendedor_a_vencer2 AS DECIMAL.

DEFINE VARIABLE t-importe2              AS DECIMAL EXTENT 32.
DEFINE VARIABLE v-importe2              AS DECIMAL EXTENT 32.

DEFINE VARIABLE t-importe               AS DECIMAL EXTENT 32.
DEFINE VARIABLE v-importe               AS DECIMAL EXTENT 32.
DEFINE VARIABLE ntcols                  AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol                    AS INTEGER.

DEFINE VARIABLE v-consol                AS CHARACTER FORMAT "X(15)".

DEFINE VARIABLE aa                      AS INTEGER.
DEFINE VARIABLE mm                      AS INTEGER.
DEFINE VARIABLE dd                      AS INTEGER.

DEFINE VARIABLE nt_items                AS INTEGER.
DEFINE VARIABLE ldes                    AS INTEGER.
DEFINE VARIABLE ult_column              AS INTEGER.
DEFINE VARIABLE header_tt1              AS CHARACTER FORMAT "X(280)".
DEFINE VARIABLE header_tt2              AS CHARACTER FORMAT "X(280)".
DEFINE VARIABLE header_sr1              AS CHARACTER FORMAT "X(280)".
DEFINE VARIABLE header_sr2              AS CHARACTER FORMAT "X(280)".
DEFINE VARIABLE columnas                AS CHARACTER FORMAT "X(220)".
DEFINE VARIABLE columna2                AS CHARACTER FORMAT "X(220)".
DEFINE VARIABLE voy_fecha               AS DATE.
DEFINE VARIABLE des_fecha               AS DATE.
DEFINE VARIABLE has_fecha               AS DATE.
DEFINE VARIABLE letra                   AS CHARACTER.
DEFINE VARIABLE desc_moneda             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE hay_movimientos         AS LOGICAL.

/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE Acumulado
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente         AS INTEGER
   FIELD n-columna           AS INTEGER
   FIELD importe_facturado   AS DECIMAL FORMAT ">>>,>>>,>>9.99-"
   FIELD importe_cobrado     AS DECIMAL FORMAT ">>>,>>>,>>9.99-"
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
   "Composición de Operaciones del último año Por Vendedor" AT 75
   "Página:" AT 208 PAGE-NUMBER FORMAT "9999" AT 217
   SKIP
   fecha_lis
   "Fecha de Referencia:" AT 75
   ref_fecha 
   hora_lis AT 208
   SKIP
   desc_moneda AT 75 NO-LABEL
   SKIP
   v-consol AT 75 
   SKIP(2)
   header_sr1 SKIP
   header_tt1 SKIP
   header_tt2 SKIP
   header_sr2
   WITH WIDTH 290 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM 
   header_sr1 
   WITH FRAME frm-subraya WIDTH 290 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   Cliente.cdg_cliente COLUMN-LABEL "Código!Cliente"
   Cliente.nom_cliente COLUMN-LABEL "Razón!Social" 
   columnas
   WITH FRAME frm-listado DOWN WIDTH 290 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar_todo.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/


PROCEDURE listar_todo:

    IF v-consolidado THEN v-consol = "CONSOLIDADO". 
    aa = YEAR(ref_fecha).
    mm = MONTH(ref_fecha).
    dd = DAY(ref_fecha).

    RUN findemes.p ( INPUT-OUTPUT dd, INPUT mm, INPUT aa).
    ref_fecha = DATE(mm,dd,aa).

    fecha_lis = STRING(TODAY,"99/99/99").
    hora_lis = STRING(TIME,"HH:MM:SS").
  
    {findempresa.i}
    que_empresa = Empresa.nombre.
  
    /*--------------------------------------------------------------------------------*/
    /* Armado dinamico de las definiciones de columnas en base a los intervalos dados */
    /*--------------------------------------------------------------------------------*/
  
    ntcols = 12.
    voy_fecha = ref_fecha.
  
    DO ncol = 1 TO 12 :

        CREATE Def-columna.
        ASSIGN Def-columna.cdg_empresa = Empresa.cdg_empresa
               Def-columna.n-columna   = ncol
               Def-columna.has_fecha   = voy_fecha
               Def-columna.des_fecha   = DATE(MONTH(voy_fecha),1,YEAR(voy_fecha))

        aa = YEAR(voy_fecha).
        mm = MONTH(voy_fecha).
        dd = 1.

        mm = mm - 1.
        IF mm = 0
        THEN DO:
            mm = 12.
            aa = aa - 1.
        END.

        RUN findemes.p ( INPUT-OUTPUT dd, INPUT mm, INPUT aa).
        voy_fecha  = DATE(mm,dd,aa).

    END.

    FIND Def-columna WHERE Def-columna.n-columna = 1.
    has_fecha = Def-columna.has_fecha.

    FIND Def-columna WHERE Def-columna.n-columna = 12.
    des_fecha = Def-columna.des_fecha.
                     
    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  
                        /* se arma el titulo con las fechas */
  
    header_tt1 = "Identificación                                    " + "         Total  " .
    header_tt2 = "del Cliente                                       " + "       Operado  " .
    header_sr1 = "------------------------------------------------- " + "--------------  " .
  
    FOR EACH Def-columna NO-LOCK
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
           BREAK BY Def-columna.n-columna:

        header_tt1 = header_tt1 + " " + STRING(Def-columna.des_fecha,"99/99/9999") + "  ".
        header_tt2 = header_tt2 + " " + STRING(Def-columna.has_fecha,"99/99/9999") + "  ".
        header_sr1 = header_sr1 + "-----------  ".
        ntcols = Def-columna.n-columna.

    END.

    header_sr2 = header_sr1.
  
    {dirprinfile.i &LIN-PAG 66}
    
    /* Crea los registros de acumulado para el total de los clientees */
  
    FOR EACH Def-columna NO-LOCK
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
              BREAK BY Def-columna.n-columna:
        
        CREATE Acumulado.
        ASSIGN Acumulado.cdg_empresa       = Empresa.cdg_empresa
               Acumulado.nro_cliente       = 0
               Acumulado.n-columna         = Def-columna.n-columna
               Acumulado.importe_facturado = 0
               Acumulado.importe_cobrado   = 0.
      
    END.

    saldo_total = 0.
    t-importe   = 0.
    t-importe2  = 0.
    FOR EACH Cliente NO-LOCK
          WHERE CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa),
                FIRST Vendedor OF Cliente 
                      WHERE Vendedor.cdg_vendedor <= has_codigo 
                        AND Vendedor.cdg_vendedor >= des_codigo
              BREAK BY Vendedor.cdg_vendedor  
                    BY Cliente.cdg_cliente:
  
          VIEW FRAME frm-titulo.

          ASSIGN
               saldo_cliente = 0
               saldo_cliente2 = 0
               columnas = ""
               columna2 = "".

          desc_moneda = Moneda.descripcion + " - " + Vendedor.nombre + " - " + STRING(des_fecha,"99/99/99") + " al " + STRING(has_fecha,"99/99/99").
  
         /* Crea los registros de acumulado para el cliente a razon de uno por cada columna */
  
          FOR EACH Def-columna NO-LOCK
              WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                 BREAK BY Def-columna.n-columna:
        
              CREATE Acumulado.
              ASSIGN Acumulado.cdg_empresa       = Empresa.cdg_empresa
                     Acumulado.nro_cliente       = Cliente.nro_cliente
                     Acumulado.n-columna         = Def-columna.n-columna
                     Acumulado.importe_facturado = 0
                     Acumulado.importe_cobrado   = 0.
  
          END.
 
          hay_movimientos = NO.
          FOR EACH Cta_cte OF Cliente 
                   WHERE ( Cta_cte.cdg_empresa = Empresa.cdg_empresa OR v-consolidado )
                     AND Cta_cte.nro_moneda    = Moneda.nro_moneda
                     AND Cta_cte.fecha_emision >= des_fecha
                     AND Cta_cte.fecha_emision <= has_fecha:
  
              /* Halla el número de columna que corresponde en base a la fecha del movimiento */
           
              FIND FIRST Def-columna 
                   WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                     AND Def-columna.des_fecha   <= Cta_cte.fecha_emision
                     AND Def-columna.has_fecha   >= Cta_cte.fecha_emision
                         NO-LOCK.
           
              FIND FIRST Acumulado 
                   WHERE Acumulado.cdg_empresa   = Empresa.cdg_empresa
                     AND Acumulado.nro_cliente   = Cliente.nro_cliente
                     AND Acumulado.n-columna     = Def-columna.n-columna
                         EXCLUSIVE-LOCK.
                
              letra = SUBSTRING(Cta_cte.tip_comprob,1,1).

              CASE letra:
                  WHEN "F" THEN Acumulado.importe_facturado = Acumulado.importe_facturado + Cta_cte.debito.
                  WHEN "D" THEN Acumulado.importe_facturado = Acumulado.importe_facturado + Cta_cte.debito.
                  WHEN "C" THEN Acumulado.importe_facturado = Acumulado.importe_facturado - Cta_cte.credito.
                  WHEN "R" THEN Acumulado.importe_cobrado = Acumulado.importe_cobrado + Cta_cte.credito.
              END CASE.

              hay_movimientos   =  YES.
  
          END. 

          IF hay_movimientos
          THEN DO:

               FOR EACH Acumulado NO-LOCK OF Cliente BY Acumulado.n-columna:
         
                   columnas = columnas + STRING(Acumulado.importe_facturado,">>>,>>9.99-") + "  ".

                   columna2 = columna2 + STRING(Acumulado.importe_cobrado,">>>,>>9.99-") + "  ".

                   saldo_cliente = saldo_cliente + Acumulado.importe_facturado.

                   v-importe [ Acumulado.n-columna ] = v-importe [ Acumulado.n-columna ] + Acumulado.importe_facturado.
                   t-importe [ Acumulado.n-columna ] = t-importe [ Acumulado.n-columna ] + Acumulado.importe_facturado.

                   saldo_cliente2  = saldo_cliente2  + Acumulado.importe_cobrado.

                   v-importe2 [ Acumulado.n-columna ] = v-importe2 [ Acumulado.n-columna ] + Acumulado.importe_cobrado.
                   t-importe2 [ Acumulado.n-columna ] = t-importe2 [ Acumulado.n-columna ] + Acumulado.importe_cobrado.
               END.

               columnas = STRING(saldo_cliente,">>>,>>>,>>9.99-") + " " + columnas.

               columna2 = STRING(saldo_cliente2,">>>,>>>,>>9.99-") + " " + columna2.

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

               DISPLAY columna2 @ columnas
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.

          END.
          
          IF LAST-OF(Vendedor.cdg_vendedor)
          THEN DO:

                columnas = "".
                saldo_vendedor = 0.
                
                columna2 = "".
                saldo_vendedor2 = 0.

                FOR EACH Acumulado NO-LOCK WHERE Acumulado.nro_cliente = 0 BY Acumulado.n-columna:
                  
                    columnas = columnas + STRING(v-importe [ Acumulado.n-columna ],">>>,>>9.99-") + "  ".
                    
                    saldo_vendedor = saldo_vendedor + v-importe [ Acumulado.n-columna ].

                    v-importe [ Acumulado.n-columna ] = 0.

                    columna2 = columna2 + STRING(v-importe2 [ Acumulado.n-columna ],">>>,>>9.99-") + "  ". 

                    saldo_vendedor2  = saldo_vendedor2  + v-importe2 [ Acumulado.n-columna ].

                    v-importe2 [ Acumulado.n-columna ] = 0.

                END.

                columnas = STRING(saldo_vendedor,">>>,>>>,>>9.99-") + " " + columnas.
                columna2 = STRING(saldo_vendedor2,">>>,>>>,>>9.99-") + " " + columna2.

                DISPLAY header_sr1 
                        WITH FRAME frm-subraya.
                DOWN WITH FRAME frm-listado.        
                DISPLAY "Total " + Vendedor.nombre @ Cliente.nom_cliente
                        columnas
                        WITH FRAME frm-listado.
                DOWN WITH FRAME frm-listado.

                DISPLAY columna2 @ columnas
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



