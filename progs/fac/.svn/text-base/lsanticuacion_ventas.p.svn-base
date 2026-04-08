/*=================================================================================*/
/*             CLASIFICACION DE LOS DERECHOS SEGUN ANTIGUEDAD                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo       LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER ntcols           AS INTEGER.
DEFINE INPUT PARAMETER dias_columna     AS INTEGER.
DEFINE INPUT PARAMETER p-des_fecha      AS DATE.
DEFINE INPUT PARAMETER p-has_fecha      AS DATE.
DEFINE INPUT PARAMETER v-consolidado    AS LOGICAL.
DEFINE INPUT PARAMETER v-inhabilitados  AS LOGICAL.

/*=================================================================================*/
/*                                   VARIABLES                                     */
/*=================================================================================*/

{VPERSINM.I}
{WGLISTAR.I}
{parlocales.i}
{dfvarimp.i}
{strdebitan.i}

DEFINE VARIABLE saldo_total             AS DECIMAL.

DEFINE VARIABLE total_cliente           AS DECIMAL.
DEFINE VARIABLE saldo_vendedor          AS DECIMAL.

DEFINE VARIABLE t-importe               AS DECIMAL EXTENT 32.
DEFINE VARIABLE v-importe               AS DECIMAL EXTENT 32.
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

DEFINE VARIABLE que_sector           LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.


/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

FUNCTION fechafindemes RETURNS DATE ( INPUT fecha_original AS DATE ):

    DEFINE VARIABLE x-dia AS INTEGER.
    x-dia = DAY(fecha_original).
    RUN findemes.p (  INPUT-OUTPUT x-dia, INPUT MONTH(fecha_original), INPUT YEAR(fecha_original)).
    RETURN DATE(MONTH(fecha_original),x-dia,YEAR(fecha_original)).

END FUNCTION.


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
   "Total vendido por período por vendedor" AT 75
   "Página:" AT 139 PAGE-NUMBER FORMAT ">>>9" AT 149
   SKIP
   fecha_lis
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

    DO ncol = ntcols TO 1 BY -1:

        CREATE Def-columna.
        ASSIGN Def-columna.cdg_empresa = Empresa.cdg_empresa
               Def-columna.n-columna   = ncol.
        CASE dias_columna:
            WHEN 1 /* Ancho de columna 1 día */
            THEN DO:
                IF ncol = ntcols
                    THEN Def-columna.has_fecha   = p-has_fecha.
                    ELSE Def-columna.has_fecha   = voy_fecha - 1.
                IF ncol = 1
                    THEN Def-columna.des_fecha   = MINIMUM(voy_fecha,p-des_fecha).
                    ELSE Def-columna.des_fecha   = Def-columna.has_fecha - 1.

                voy_fecha = Def-columna.des_fecha.
            END.
            WHEN 2 /* Ancho de columna 1 semana */
            THEN DO:
                IF ncol = ntcols
                    THEN Def-columna.has_fecha   = p-has_fecha.
                    ELSE Def-columna.has_fecha   = voy_fecha - 1.
                IF ncol = 1
                    THEN Def-columna.des_fecha   = MINIMUM(voy_fecha,p-des_fecha).
                    ELSE Def-columna.des_fecha   = Def-columna.has_fecha - 7.

                voy_fecha = Def-columna.des_fecha.
            END.
            WHEN 3 /* Ancho de columna 1 mes */
            THEN DO:
                IF ncol = ntcols
                    THEN Def-columna.has_fecha   = fechafindemes(p-has_fecha).
                    ELSE Def-columna.has_fecha   = voy_fecha - 1.
                IF ncol = 1
                    THEN Def-columna.des_fecha   = MINIMUM(voy_fecha,p-des_fecha).
                    ELSE Def-columna.des_fecha   = DATE(MONTH(Def-columna.has_fecha),1,YEAR(Def-columna.has_fecha)).

                voy_fecha = Def-columna.des_fecha.
            END.

        END CASE.
  
    END.
  
    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  
                        /* se arma el titulo con las fechas */
  
    header_tt1 = "Identificación                               " + "         Total ".
    header_tt2 = "del Cliente                                  " + "       Vendido ".
    header_sr1 = "-------------------------------------------- " + "-------------- ".
  
    FOR EACH Def-columna NO-LOCK
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
           BREAK BY Def-columna.n-columna:

        header_tt1 = header_tt1 +   
                     IF Def-columna.n-columna = 1
                        THEN "      Hasta el"
                        ELSE "    " + STRING(Def-columna.des_fecha,"99/99/9999").
   
        header_tt2 = header_tt2 + "    " + STRING(Def-columna.has_fecha,"99/99/9999").
        header_sr1 = header_sr1 + "--------------".
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
          WHERE CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
          AND ( cliente.cdg_estado = "A" OR v-inhabilitados)
          AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0,
                FIRST Vendedor OF Cliente 
                      WHERE Vendedor.cdg_vendedor <= has_codigo 
                        AND Vendedor.cdg_vendedor >= des_codigo
              BREAK BY Vendedor.cdg_vendedor  
                    BY Cliente.cdg_cliente:
    

          VIEW FRAME frm-titulo.

          desc_moneda = Moneda.descripcion + IF v-consolidado THEN " CONSOLIDADO" ELSE "" +
                        " - " + Vendedor.nombre + " - " + STRING(p-des_fecha,"99/99/99") + " al " + STRING(p-has_fecha,"99/99/99").
  
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
          FOR EACH Fac_header OF Cliente 
                   WHERE ( Fac_header.cdg_empresa = Empresa.cdg_empresa OR v-consolidado )
                     AND CAN-DO (Usuario.lista_empresas,Fac_header.cdg_empresa)
                     AND Fac_header.nro_moneda    = Moneda.nro_moneda
                     AND Fac_header.fecha <= p-has_fecha 
                     AND Fac_header.fecha >= p-des_fecha
                     AND Fac_header.anulado = NO,
              FIRST Tipocomprobante OF Fac_header:
  
              /* Halla el número de columna que corresponde en base a la fecha del movimiento */
           
              FIND FIRST Def-columna 
                   WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
                     AND Def-columna.des_fecha   <= Fac_header.fecha
                     AND Def-columna.has_fecha   >= Fac_header.fecha
                         NO-LOCK.
           
              FIND FIRST Acumulado 
                   WHERE Acumulado.cdg_empresa   = Empresa.cdg_empresa
                     AND Acumulado.nro_cliente   = Cliente.nro_cliente
                     AND Acumulado.n-columna     = Def-columna.n-columna
                         EXCLUSIVE-LOCK.
             
              IF Tipocomprobante.debita
                  THEN Acumulado.importe = Acumulado.importe + Fac_header.imp_total.
                  ELSE Acumulado.importe = Acumulado.importe - Fac_header.imp_total.
              hay_movimientos   =  YES.
  
          END. 
  
/*           IF hay_movimientos  */
/*           THEN DO:            */

               ASSIGN
                    total_cliente  = 0.

               columnas = "".
               FOR EACH Acumulado NO-LOCK OF Cliente BY Acumulado.n-columna:
         
                   columnas = columnas + STRING(Acumulado.importe,"->>,>>>,>>9.99").
                   total_cliente  = total_cliente  + Acumulado.importe.
                   v-importe [ Acumulado.n-columna ] = v-importe [ Acumulado.n-columna ] + Acumulado.importe.
                   t-importe [ Acumulado.n-columna ] = t-importe [ Acumulado.n-columna ] + Acumulado.importe.

               END.

               columnas = STRING(total_cliente,"->>,>>>,>>9.99") + " " + columnas.

               IF LINE-COUNTER = PAGE-SIZE - 1
               THEN DO:
                    DISPLAY header_sr1
                            WITH FRAME frm-subraya.
                    DOWN WITH FRAME frm-listado.
               END.

               DISPLAY Cliente.cdg_cliente
                       Cliente.nom_cliente FORMAT "X(35)"
                       columnas
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.        

/*           END.  */
          
          IF LAST-OF(Vendedor.cdg_vendedor)
          THEN DO:

                columnas = "".
                saldo_vendedor = 0.
                FOR EACH Acumulado NO-LOCK WHERE Acumulado.nro_cliente = 0 BY Acumulado.n-columna:
                  
                    columnas = columnas + STRING(v-importe [ Acumulado.n-columna ],"->>,>>>,>>9.99").
                    saldo_vendedor = saldo_vendedor + v-importe [ Acumulado.n-columna ].
                    v-importe [ Acumulado.n-columna ] = 0.

                END.

                columnas = STRING(saldo_vendedor,"->>,>>>,>>9.99") + " " + columnas.
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

