/*=================================================================================*/
/*             CLASIFICACION DE LAS OBLIGACIONES SEGUN ANTIGUEDAD                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo       LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo       LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER ref_fecha        AS DATE.
DEFINE INPUT PARAMETER ncol_vencidas    AS INTEGER.
DEFINE INPUT PARAMETER ncol_futuras     AS INTEGER.
DEFINE INPUT PARAMETER dias_columna     AS INTEGER.
DEFINE INPUT PARAMETER lat_pagos        AS INTEGER INITIAL 45.
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
DEFINE VARIABLE saldo_proveedor         AS DECIMAL.
DEFINE VARIABLE t-importe               AS DECIMAL EXTENT 32.
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
DEFINE VARIABLE desc_moneda             LIKE Moneda.descripcion.
DEFINE VARIABLE hay_movimientos         AS LOGICAL.

/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE Acumulado
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_proveedor       AS INTEGER
   FIELD n-columna           AS INTEGER
   FIELD importe             AS DECIMAL FORMAT ">>,>>>,>>9.99-"
   INDEX por_fila_columna IS UNIQUE PRIMARY nro_proveedor n-columna.

DEFINE TEMP-TABLE Def-fila
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_proveedor       AS INTEGER
   FIELD titulo-fila         AS CHARACTER FORMAT "X(35)"
   INDEX por_fila     IS UNIQUE PRIMARY nro_proveedor.

DEFINE TEMP-TABLE Def-columna
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD n-columna           AS INTEGER
   FIELD des_fecha           AS DATE FORMAT "99/99/9999"
   FIELD has_fecha           AS DATE FORMAT "99/99/9999"
   INDEX por_columna  IS UNIQUE PRIMARY n-columna.

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Composicion de Saldos por Edades" AT 75
   "Página:" AT 139 PAGE-NUMBER FORMAT ">>>9" AT 149
   SKIP
   fecha_lis
   "Fecha de Referencia:" AT 75
   ref_fecha 
   hora_lis AT 139
   SKIP
   "Importes en" AT 75
   desc_moneda NO-LABEL
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
   Proveedor.cdg_proveedor COLUMN-LABEL "Código!Proveedor"
   Proveedor.nombre        COLUMN-LABEL "Razón!Social" 
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
    desc_moneda = Moneda.descripcion + IF v-consolidado THEN " CONSOLIDADO" ELSE "".
  
                        /* se arma el titulo con las fechas */
  
    header_tt1 = "Identificación                                  " + "         Saldo ".
    header_tt2 = "del Proveedor                                   " + "         Total ".
    header_sr1 = "----------------------------------------------- " + "-------------- ".
  
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
    
    /* Crea los registros de acumulado para el total de los proveedores */
  
    FOR EACH Def-columna NO-LOCK
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
              BREAK BY Def-columna.n-columna:
        
        CREATE Acumulado.
        ASSIGN Acumulado.cdg_empresa    = Empresa.cdg_empresa
               Acumulado.nro_proveedor  = 0
               Acumulado.n-columna      = Def-columna.n-columna
               Acumulado.importe        = 0.
      
    END.

    saldo_total = 0.
    t-importe = 0.  
    FOR EACH Proveedor NO-LOCK
        WHERE Proveedor.cdg_proveedor <= has_codigo 
          AND Proveedor.cdg_proveedor >= des_codigo
          AND CAN-DO(Proveedor.lista_empresas,Empresa.cdg_empresa)  
              BY Proveedor.cdg_proveedor:
  
          VIEW FRAME frm-titulo.
  
         /* Crea los registros de acumulado para el proveedor a razon de uno por cada columna */
  
          FOR EACH Def-columna NO-LOCK
              WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                 BREAK BY Def-columna.n-columna:
        
              CREATE Acumulado.
              ASSIGN Acumulado.cdg_empresa    = Empresa.cdg_empresa
                     Acumulado.nro_proveedor  = Proveedor.nro_proveedor
                     Acumulado.n-columna      = Def-columna.n-columna
                     Acumulado.importe        = 0.
  
          END.
  
          hay_movimientos = NO.
          FOR EACH Cta_cte_prv OF Proveedor 
                   WHERE ( Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa OR v-consolidado )
                     AND CAN-DO (Usuario.lista_empresas,Cta_cte_prv.cdg_empresa)
                     AND Cta_cte_prv.nro_moneda  = Moneda.nro_moneda
                     AND Cta_cte_prv.credito <> Cta_cte_prv.debito:
  
              /* Halla el número de columna que corresponde en base a la fecha del movimiento */
           
              FIND FIRST Def-columna 
                   WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                     AND Def-columna.des_fecha   <= Cta_cte_prv.fecha_vencimiento + lat_pagos
                     AND Def-columna.has_fecha   >= Cta_cte_prv.fecha_vencimiento + lat_pagos
                         NO-LOCK.
           
              FIND FIRST Acumulado 
                   WHERE Acumulado.cdg_empresa   = Empresa.cdg_empresa
                     AND Acumulado.nro_proveedor = Proveedor.nro_proveedor
                     AND Acumulado.n-columna     = Def-columna.n-columna
                         EXCLUSIVE-LOCK.
             
              Acumulado.importe = Acumulado.importe + Cta_cte_prv.credito - Cta_cte_prv.debito.
              hay_movimientos   =  YES.
  
          END. 
  
          IF hay_movimientos
          THEN DO:
               saldo_proveedor = 0.
               columnas = "".
               FOR EACH Acumulado NO-LOCK OF Proveedor BY Acumulado.n-columna:
         
                   columnas = columnas + STRING(Acumulado.importe,">>,>>>,>>9.99-") + 
                              IF Acumulado.n-columna = ncol_vencidas 
                                 THEN "|"
                                 ELSE " ".
         
                   t-importe [ Acumulado.n-columna ] = t-importe [ Acumulado.n-columna ] + Acumulado.importe.
                   saldo_proveedor = saldo_proveedor + Acumulado.importe.
               END.
               saldo_total =  saldo_total + saldo_proveedor.
               columnas = STRING(saldo_proveedor,">>,>>>,>>9.99-") + " " + columnas.

               IF LINE-COUNTER = PAGE-SIZE - 1
               THEN DO:
                    DISPLAY header_sr1 
                            WITH FRAME frm-subraya.
                    DOWN WITH FRAME frm-listado.        
               END.
               DISPLAY Proveedor.cdg_proveedor
                       Proveedor.nombre
                       columnas
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.        

          END.
          
    END.
    DISPLAY header_sr1 
            WITH FRAME frm-subraya.
    DOWN WITH FRAME frm-listado.        

    columnas = "".
    FOR EACH Acumulado NO-LOCK WHERE Acumulado.nro_proveedor = 0 BY Acumulado.n-columna:
      
        columnas = columnas + STRING(t-importe [ Acumulado.n-columna ],">>,>>>,>>9.99-") + 
                   IF Acumulado.n-columna = ncol_vencidas 
                      THEN "|"
                      ELSE " ".
      
    END.
    columnas = STRING(saldo_total,">>,>>>,>>9.99-") + " " + columnas.
    DISPLAY "Total General" @ Proveedor.nombre
            columnas
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.        
  
    OUTPUT CLOSE.
  
    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22 ).

END PROCEDURE.

