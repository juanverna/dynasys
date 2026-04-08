/*=================================================================================*/
/*             CLASIFICACION DE LOS DERECHOS SEGUN ANTIGUEDAD                      */
/*=================================================================================*/
DEFINE INPUT PARAMETER des_vendedor       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_vendedor       LIKE Vendedor.cdg_vendedor.

DEFINE INPUT PARAMETER des_codigo       LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo       LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER ref_fecha        AS DATE.
DEFINE INPUT PARAMETER ncol_vencidas    AS INTEGER.
DEFINE INPUT PARAMETER ncol_futuras     AS INTEGER.
DEFINE INPUT PARAMETER dias_columna     AS INTEGER.
DEFINE INPUT PARAMETER lat_cobros       AS INTEGER.
DEFINE INPUT PARAMETER p-des_fecha      AS DATE.
DEFINE INPUT PARAMETER p-has_fecha      AS DATE.
DEFINE INPUT PARAMETER v-consolidado    AS LOGICAL.
DEFINE INPUT PARAMETER des_zonag        LIKE Zona_geografica.cdg_zonag.
DEFINE INPUT PARAMETER has_zonag        LIKE Zona_geografica.cdg_zonag.
  

/*=================================================================================*/
/*                                   VARIABLES                                     */
/*=================================================================================*/

{VPERSINM.I}
{WGLISTAR.I}
{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE saldo_total             AS DECIMAL.
DEFINE VARIABLE saldo_cliente           AS DECIMAL.
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

DEFINE VARIABLE v-des_zonag             LIKE Zona_geografica.cdg_zonag.
DEFINE VARIABLE v-has_zonag             LIKE Zona_geografica.cdg_zonag.
/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE Acumulado
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente       AS INTEGER
   FIELD n-columna           AS INTEGER
   FIELD importe             AS DECIMAL FORMAT ">>,>>>,>>9.99-"
   INDEX por_fila_columna IS UNIQUE PRIMARY nro_cliente n-columna.

DEFINE TEMP-TABLE Def-fila
   FIELD cdg_empresa         LIKE Empresa.cdg_empresa
   FIELD nro_cliente       AS INTEGER
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
   "Composición de Saldos por Edades" AT 75
   "Página:" AT 139 PAGE-NUMBER FORMAT ">>>9" AT 149
   SKIP
   fecha_lis
   "Fecha de Referencia:" AT 75
   ref_fecha 
   hora_lis AT 139
   SKIP
   "Importes en" AT 75
   desc_moneda NO-LABEL
   SKIP
   "Rango de Vendedores: " AT 75
   des_vendedor
   " - "
   has_vendedor
   SKIP
    "Rango de Zonas: " AT 75
    v-des_zonag
    " - "
    v-has_zonag
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
                                          THEN p-des_fecha 
                                          ELSE voy_fecha + 1
             Def-columna.has_fecha   = IF ncol = ntcols 
                                          THEN p-has_fecha 
                                          ELSE voy_fecha + dias_columna
             voy_fecha               = Def-columna.has_fecha.
  
    END.
  
    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
    desc_moneda = Moneda.descripcion + IF v-consolidado THEN " CONSOLIDADO" ELSE "".
  
                        /* se arma el titulo con las fechas */
  
    header_tt1 = "Identificación                                    " + "         Saldo ".
    header_tt2 = "del Cliente                                       " + "         Total ".
    header_sr1 = "------------------------------------------------- " + "-------------- ".
  
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
    FIND Zona_geografica WHERE cdg_zonag = des_zonag NO-ERROR.
    IF AVAILABLE Zona_geografica THEN v-des_zonag = Zona_geografica.nombre.
    
    FIND Zona_geografica WHERE cdg_zonag = has_zonag NO-ERROR.
    IF AVAILABLE Zona_geografica THEN v-has_zonag = Zona_geografica.nombre.



    FOR EACH Vendedor WHERE cdg_vendedor >= des_vendedor
                        AND cdg_vendedor <= has_vendedor:
    FOR EACH Cliente OF Vendedor NO-LOCK,
        FIRST Domicilio OF Cliente NO-LOCK 
        WHERE Cliente.cdg_cliente <= has_codigo 
          AND Cliente.cdg_cliente >= des_codigo
          AND (CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa) OR v-consolidado)
          AND Domicilio.cdg_subclasezng >= des_zonag
          AND Domicilio.cdg_subclasezng <= has_zonag
              BY Cliente.cdg_cliente:
  
          VIEW FRAME frm-titulo.
  
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
                     AND CAN-DO (usuario.lista_empresas,Cta_cte.cdg_empresa)
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
               columnas = "".
               FOR EACH Acumulado NO-LOCK OF Cliente BY Acumulado.n-columna:
         
                   columnas = columnas + STRING(Acumulado.importe,">>,>>>,>>9.99-") + 
                              IF Acumulado.n-columna = ncol_vencidas 
                                 THEN "|"
                                 ELSE " ".
         
                   t-importe [ Acumulado.n-columna ] = t-importe [ Acumulado.n-columna ] + Acumulado.importe.
                   saldo_cliente = saldo_cliente + Acumulado.importe.
               END.
               saldo_total =  saldo_total + saldo_cliente.
               columnas = STRING(saldo_cliente,">>,>>>,>>9.99-") + " " + columnas.

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
          
    END.
    END.
    DISPLAY header_sr1 
            WITH FRAME frm-subraya.
    DOWN WITH FRAME frm-listado.        

    columnas = "".
    FOR EACH Acumulado NO-LOCK WHERE Acumulado.nro_cliente = 0 BY Acumulado.n-columna:
      
        columnas = columnas + STRING(t-importe [ Acumulado.n-columna ],">>,>>>,>>9.99-") + 
                   IF Acumulado.n-columna = ncol_vencidas 
                      THEN "|"
                      ELSE " ".
      
    END.
    columnas = STRING(saldo_total,">>,>>>,>>9.99-") + " " + columnas.
    DISPLAY "Total General" @ Cliente.nom_cliente
            columnas
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.        
  
    OUTPUT CLOSE.
  
    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22 ).

END PROCEDURE.

