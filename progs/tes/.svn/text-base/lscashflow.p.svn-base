/*=================================================================================*/
/*              EMITE EL LISTADO DE ORIGEN Y APLICACION DE FONDOS                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER ref_fecha        AS DATE.
DEFINE INPUT PARAMETER ncol_vencidas    AS INTEGER.
DEFINE INPUT PARAMETER ncol_futuras     AS INTEGER.
DEFINE INPUT PARAMETER dias_columna     AS INTEGER.
DEFINE INPUT PARAMETER lat_pagos        AS INTEGER INITIAL 45.
DEFINE INPUT PARAMETER lat_cobros       AS INTEGER INITIAL 30.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER consolidado      AS LOGICAL.

/*=================================================================================*/
/*                                      VARIABLES                                  */
/*=================================================================================*/

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

{parlocales.i}
{dfvarimp.i}

/*=================================================================================*/
/*                           FRAMES Y TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE Acumulado
   FIELD cdg_empresa  LIKE Empresa.cdg_empresa
   FIELD n-fila       AS INTEGER
   FIELD n-columna    AS INTEGER
   FIELD importe      AS DECIMAL FORMAT ">>,>>>,>>9.99-"
   INDEX por_fila_columna IS UNIQUE PRIMARY n-fila n-columna.

DEFINE TEMP-TABLE Def-fila
   FIELD cdg_empresa  LIKE Empresa.cdg_empresa
   FIELD n-fila       AS INTEGER
   FIELD titulo-fila  AS CHARACTER FORMAT "X(35)"
   INDEX por_fila     IS UNIQUE PRIMARY n-fila.

DEFINE TEMP-TABLE Def-columna
   FIELD cdg_empresa  LIKE Empresa.cdg_empresa
   FIELD n-columna    AS INTEGER
   FIELD des_fecha    AS DATE FORMAT "99/99/9999"
   FIELD has_fecha    AS DATE FORMAT "99/99/9999"
   INDEX por_columna  IS UNIQUE PRIMARY n-columna.

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Origen y Aplicación de Fondos" AT 75
   "Página:" AT 139 PAGE-NUMBER FORMAT ">>>9" AT 149
   SKIP
   fecha_lis
   "Fecha de Referencia:" AT 75
   ref_fecha 
   hora_lis AT 139
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
   Def-fila.titulo-fila
   columnas
   WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

  {findempresa.i}
  
  fecha_lis = STRING(TODAY,"99/99/99").
  hora_lis = STRING(TIME,"HH:MM:SS").
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

  /*--------------------------------------------------------------------------------*/
  /* Creacion de las definiciones de filas fijas en base a los rubros ya definidos  */
  /*--------------------------------------------------------------------------------*/

  {crearfila.i "010" "Deudores por Ventas"}
  {crearfila.i "020" "Valores en Cartera"}
  {crearfila.i "030" "Otros Ingresos 1"}
  {crearfila.i "040" "Otros Ingresos 2"}
  {crearfila.i "050" "Total de Ingresos"}
  {crearfila.i "060" "Saldo Columna Anterior"}
  {crearfila.i "070" "Disponibilidad Total"}

  {crearfila.i "080" "Proveedores"}
  {crearfila.i "090" "Valores Emitidos"}
  {crearfila.i "100" "Otros Egresos 1"}
  {crearfila.i "110" "Otros Egresos 2"}
  {crearfila.i "120" "Total de Egresos"}
  {crearfila.i "130" "Saldo Columna Anterior"}
  {crearfila.i "140" "Compromisos Totales"}

  {crearfila.i "150" "Resultado Neto"}

                    /* se arma el titulo con las fechas */

  header_tt1 = "                                   ".
  header_tt2 = "Concepto                           ".
  header_sr1 = "-----------------------------------".

  FOR EACH Def-columna NO-LOCK
      WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
         BREAK BY Def-columna.n-columna:

     separa = IF Def-columna.des_fecha = ref_fecha THEN "|" ELSE " ".
     header_tt1 = header_tt1 + separa +  
                  IF FIRST(Def-columna.n-columna)
                     THEN "     Hasta el "
                     ELSE "   " + STRING(Def-columna.des_fecha,"99/99/9999") + " ".

     header_tt2 = header_tt2 + separa +  
                  IF LAST(Def-columna.n-columna)
                     THEN "  en adelante " 
                     ELSE "   " + STRING(Def-columna.has_fecha,"99/99/9999") + " ".

     header_sr1 = header_sr1 + separa + "--------------".
     ntcols = Def-columna.n-columna.
  END.
  header_sr2 = header_sr1.

  RUN sumar_clientes.
  RUN sumar_valores.  
  RUN sumar_proveedores.
  RUN sumar_cheques.  
  RUN SUMAR_TOTALES.  

  {dirprinfile.i &LIN-PAG 66}
  
  FOR EACH Def-fila WHERE Def-fila.cdg_empresa = Empresa.cdg_empresa NO-LOCK:

      VIEW FRAME frm-titulo.

      columnas = "".
      FOR EACH Acumulado OF Def-fila NO-LOCK:

          columnas = columnas + STRING(Acumulado.importe,">>,>>>,>>9.99-") + 
                     IF Acumulado.n-columna = ncol_vencidas 
                        THEN "|"
                        ELSE " ".
          

      END.
      DISPLAY Def-fila.titulo-fila
              columnas
              WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.        

      IF Def-fila.n-fila = 060 OR
         Def-fila.n-fila = 070 OR
         Def-fila.n-fila = 130 OR
         Def-fila.n-fila = 140 
      THEN DO: 
            DISPLAY header_sr1 
                    WITH FRAME frm-subraya.
            DOWN WITH FRAME frm-listado.        
      END.

  END.
  DISPLAY header_sr1 
          WITH FRAME frm-subraya.
  DOWN WITH FRAME frm-listado.        
  
  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

/*=================================================================================*/
/*                       P R O C E D I M I E N T O S                               */
/*=================================================================================*/

PROCEDURE sumar_clientes:

  FOR EACH Cliente WHERE CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa) NO-LOCK:

        FOR EACH Cta_cte OF Cliente 
                 WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
                  AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa)
                /* AND Cta_cte.nro_moneda  = Moneda.nro_moneda */
                   AND Cta_cte.credito <> Cta_cte.debito:


           RUN acumular_importe ( INPUT Cta_cte.fecha_vencimiento + lat_cobros,
                                  INPUT 10,
                                  INPUT Cta_cte.debito - Cta_cte.credito).


        END. 

  END.

END PROCEDURE.

PROCEDURE sumar_proveedores:

  FOR EACH Proveedor WHERE CAN-DO(Proveedor.lista_empresas,Empresa.cdg_empresa)  NO-LOCK:

        FOR EACH Cta_cte_prv OF Proveedor 
                 WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                    AND CAN-DO (Usuario.lista_empresas,Cta_cte_prv.cdg_empresa)
                /* AND Cta_cte_prv.nro_moneda  = Moneda.nro_moneda */
                   AND Cta_cte_prv.credito <> Cta_cte_prv.debito:


           RUN acumular_importe ( INPUT Cta_cte_prv.fecha_vencimiento + lat_pagos,
                                  INPUT 80,
                                  INPUT Cta_cte_prv.credito - Cta_cte_prv.debito).


        END. 

  END.

END PROCEDURE.


PROCEDURE sumar_valores:

  FOR EACH Valor WHERE Valor.cdg_empresa = Empresa.cdg_empresa
      AND CAN-DO (Usuario.lista_empresas,Valor.cdg_empresa)
                   AND Valor.estado = "00":

      RUN acumular_importe ( INPUT Valor.fecha_acredita,
                             INPUT 20,
                             INPUT Valor.importe).
         
  END. 


END PROCEDURE.

PROCEDURE sumar_cheques:

  FOR EACH Cuenta_bancaria WHERE Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa
              AND CAN-DO (Usuario.lista_empresas,Cuenta_bancaria.cdg_empresa) :
        FOR EACH Cheque OF Cuenta_bancaria WHERE Cheque.estado = "00":
      
            RUN acumular_importe ( INPUT Cheque.fecha_acredita,
                                   INPUT 90,
                                   INPUT Cheque.importe).
               
        END. 
  END.


END PROCEDURE.

PROCEDURE CREAR_ACUMULADO:

  DEFINE INPUT PARAMETER que_fila AS INTEGER.

  DO ncol = 1 TO ntcols:
    CREATE Acumulado.
    ASSIGN
           Acumulado.cdg_empresa = Empresa.cdg_empresa 
           Acumulado.n-fila      = que_fila
           Acumulado.n-columna   = ncol.
  END.

END PROCEDURE.

PROCEDURE SUMAR_TOTALES:

  /*-------------------------------------------------------------*/
  /*    "010"         "Deudores por Ventas"                      */
  /*    "020"         "Valores en Cartera"                       */
  /*    "030"         "Otros Ingresos 1"                         */
  /*    "040"         "Otros Ingresos 2"                         */
  /*    "050"         "Total de Ingresos"                        */
  /*    "060"         "Saldo Columna Anterior"                   */
  /*    "070"         "Disponibilidad Total"                     */
  /*    "080"         "Proveedores"                              */
  /*    "090"         "Valores Emitidos"                         */
  /*    "100"         "Otros Egresos 1"                          */
  /*    "110"         "Otros Egresos 2"                          */
  /*    "120"         "Total de Egresos"                         */
  /*    "130"         "Saldo Columna Anterior"                   */
  /*    "140"         "Compromisos Totales"                      */
  /*    "150"         "Resultado Neto"                           */
  /*-------------------------------------------------------------*/

  DEFINE VARIABLE t-ingresos AS DECIMAL.
  DEFINE VARIABLE a-ingresos AS DECIMAL.
  DEFINE VARIABLE t-egresos  AS DECIMAL.
  DEFINE VARIABLE a-egresos  AS DECIMAL.
  DEFINE VARIABLE t-disponib AS DECIMAL.
  DEFINE VARIABLE t-comprom  AS DECIMAL.
  DEFINE VARIABLE s-netocol  AS DECIMAL.

  DEFINE BUFFER B-Acumulado FOR Acumulado.
  DO ncol = 1 TO ntcols:

     t-ingresos = 0.
     FOR EACH Acumulado 
          WHERE /* Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ Acumulado.n-columna = ncol
            AND Acumulado.n-fila < 050
                NO-LOCK:
     
         t-ingresos = t-ingresos + Acumulado.importe.
          
     END.     

     IF ncol > 1
     THEN DO:

        FIND B-Acumulado 
             WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
               AND */ B-Acumulado.n-columna = ncol - 1
               AND B-Acumulado.n-fila = 070
                   NO-LOCK.
        a-ingresos = B-Acumulado.importe.  
        FIND B-Acumulado 
             WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
               AND */ B-Acumulado.n-columna = ncol - 1
               AND B-Acumulado.n-fila = 140
                   NO-LOCK.
        a-egresos = B-Acumulado.importe.  

     END.
     ELSE DO:

        a-ingresos = 0.
        a-egresos  = 0.

     END.

     t-egresos = 0.
     FOR EACH Acumulado 
          WHERE /* Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ Acumulado.n-columna = ncol
            AND Acumulado.n-fila < 120
            AND Acumulado.n-fila > 070
                NO-LOCK:
     
          t-egresos = t-egresos + Acumulado.importe.
          
     END.     

     t-disponib = t-ingresos + a-ingresos.
     t-comprom  = t-egresos + a-egresos.
     s-netocol  = t-disponib - t-comprom.

     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 050
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = t-ingresos.  

     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 060
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = a-ingresos.  

     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 070
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = t-disponib.  

     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 120
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = t-egresos.  

     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 130
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = a-egresos.  


     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 140
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = t-comprom.  

     FIND B-Acumulado 
          WHERE /* B-Acumulado.cdg_empresa = Empresa.cdg_empresa
            AND */ B-Acumulado.n-columna = ncol
            AND B-Acumulado.n-fila = 150
                EXCLUSIVE-LOCK.
     B-Acumulado.importe = s-netocol.  

  END.


END PROCEDURE.

PROCEDURE acumular_importe:

   DEFINE INPUT PARAMETER que_fecha   AS DATE.
   DEFINE INPUT PARAMETER que_fila    AS INTEGER.
   DEFINE INPUT PARAMETER que_importe AS DECIMAL.

   FIND FIRST Def-columna 
        WHERE Def-columna.cdg_empresa = Empresa.cdg_empresa
          AND Def-columna.des_fecha   <= que_fecha
          AND Def-columna.has_fecha   >= que_fecha
              NO-LOCK NO-ERROR.

   IF AVAILABLE Def-columna
   THEN DO:
        FIND FIRST Acumulado 
             WHERE Acumulado.cdg_empresa  = Empresa.cdg_empresa
               AND Acumulado.n-fila       = que_fila
               AND Acumulado.n-columna    = Def-columna.n-columna
                   EXCLUSIVE-LOCK.
         
        Acumulado.importe = Acumulado.importe + que_importe.
   END.
   ELSE DO:
        MESSAGE "No se halló columna" SKIP 
                "Fecha " STRING(que_fecha,"99/99/9999") SKIP
                "Fila "  STRING(que_fila,"9999") SKIP
                VIEW-AS ALERT-BOX MESSAGE.
   END.

END PROCEDURE.
