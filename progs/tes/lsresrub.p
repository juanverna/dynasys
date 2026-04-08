/*=================================================================================*/
/*                  LISTADO DE SALDOS POR RUBRO DE CAJA                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja      LIKE Caja.cdg_caja NO-UNDO.
DEFINE INPUT PARAMETER des_fecha     LIKE Caj_header.fecha NO-UNDO.
DEFINE INPUT PARAMETER has_fecha     LIKE Caj_header.fecha NO-UNDO.
DEFINE INPUT PARAMETER v-consolidado AS LOGICAL NO-UNDO.
DEFINE INPUT PARAMETER v-detalle AS LOGICAL NO-UNDO.

{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE saldo        AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE tot_ingreso  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso   AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tot_saldo    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".

DEFINE TEMP-TABLE Acumulado NO-UNDO
   FIELD cdg_rubro    LIKE Rubro.cdg_rubro
   FIELD ingresos     AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Ingresos"
   FIELD egresos      AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Egresos".

DEFINE TEMP-TABLE ttvalor
   FIELD cdg_banco        LIKE   Valor.cdg_banco       
   FIELD  cdg_rubro         LIKE  Valor.cdg_rubro        
   FIELD  cdg_sucurbanco    LIKE  Valor.cdg_sucurbanco   
   FIELD  estado            LIKE  Valor.estado           
   FIELD  fecha_deposito    LIKE  Valor.fecha_deposito   
   FIELD  importe           LIKE  Valor.importe          
   FIELD  nro_cliente       LIKE  Valor.nro_cliente      
   FIELD  numero_cheque     LIKE  Valor.numero_cheque
   FIELD  Origen AS CHAR FORMAT "x(18)" 
   INDEX fecha_deposito fecha_deposito DESC.   

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Resumen de Movimientos por Rubro" AT 32 
  "Página:" AT 77 PAGE-NUMBER FORMAT ">9" AT 84
  SKIP  
  fecha_lis   
  "Del " des_fecha AT 32
  "Al" 
  has_fecha 
  "Caja:" que_caja FORMAT ">>9"  
  hora_lis AT 77
  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Rubro.cdg_rubro
  Rubro.nombre
  Acumulado.ingresos
  Acumulado.egresos
  saldo
  WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

DEFINE FRAME valores
    Banco.abrevia          LIKE  valor.fecha_deposito   
    ttvalor.cdg_rubro      LIKE  Banco.abrevia
    ttvalor.cdg_banco      LIKE  valor.cdg_rubro
    ttvalor.cdg_sucurbanco LIKE  Valor.cdg_banco       
    ttvalor.numero_cheque  LIKE  Valor.cdg_sucurbanco   
    ttvalor.estado         LIKE  valor.numero_cheque    
    ttvalor.fecha_deposito LIKE  Valor.estado           
    ttvalor.importe        LIKE  Valor.importe          
    cliente.cdg_cliente    LIKE  cliente.cdg_cliente
    ttvalor.origen
    WITH WIDTH 132 DOWN CENTERED FRAME valores USE-TEXT STREAM-IO.      

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
  
  EMPTY TEMP-TABLE Acumulado.

  {dirprinfile.i}
 
  FOR EACH Caj_header OF Caja
     WHERE ( Caj_header.cdg_empresa = Empresa.cdg_empresa OR v-consolidado ) 
       AND CAN-DO (Usuario.lista_empresas,Caj_header.cdg_empresa)
       AND   Caj_header.fecha <= has_fecha
       AND   Caj_header.fecha >= des_fecha
       AND   Caj_header.estado <> "A"  
             WITH FRAME frm-listado:
      
      FOR EACH Caj_detalle OF Caj_header:
      
          FIND FIRST Acumulado 
               WHERE Acumulado.cdg_rubro = Caj_detalle.cdg_rubro NO-ERROR.
          IF NOT AVAILABLE Acumulado
          THEN DO:
             CREATE Acumulado.
             ASSIGN Acumulado.cdg_rubro = Caj_detalle.cdg_rubro.
          END.
                   
                 /* Si es un egreso, la cuenta   */
                 /* del detalle debe acreditarse */

          IF Caj_detalle.tipo_mov = "E"
             THEN Acumulado.egresos  = Acumulado.egresos  + Caj_detalle.importe.
             ELSE Acumulado.ingresos = Acumulado.ingresos + Caj_detalle.importe.
           /*ver que valor involucrado hay*/
           IF v-detalle  THEN DO:
               FIND valor OF caj_detalle NO-ERROR.
               IF AVAILABLE valor THEN DO:
                   CREATE ttvalor.
                   BUFFER-COPY valor TO ttvalor
                       ASSIGN ttvalor.origen = caj_header.tip_comprob + "-" +
                                               string(caj_header.prf_comprob,"9999") + "-" +
                                               string(caj_header.nro_comprob,"999999").
               END.
           END.
      END.   

  END.
  
  VIEW FRAME frm-titulo.

  FOR EACH Acumulado , Rubro OF Acumulado BY Rubro.cdg_rubro:

      saldo = Acumulado.ingresos - Acumulado.egresos.
      DISPLAY
             Rubro.cdg_rubro
             Rubro.nombre
             Acumulado.ingresos
             Acumulado.egresos
             saldo
             WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.

      tot_ingreso = tot_ingreso + Acumulado.ingresos.
      tot_egreso  = tot_egreso  + Acumulado.egresos.

  END.

  saldo = tot_ingreso - tot_egreso.

  UNDERLINE Acumulado.ingresos
            Acumulado.egresos
            saldo
            WITH FRAME frm-listado.
  DISPLAY tot_ingreso  @ Acumulado.ingresos
          tot_egreso   @ Acumulado.egresos
          saldo
          WITH FRAME frm-listado.
  IF v-detalle  THEN DO:
      FOR EACH ttvalor BY ttvalor.fecha_deposito :
          FIND cliente OF ttvalor NO-LOCK.
          FIND banco OF ttvalor NO-LOCK.
        DISPLAY 
            Banco.abrevia  
            ttvalor.cdg_rubro
            ttvalor.cdg_banco
            ttvalor.cdg_sucurbanco
            ttvalor.numero_cheque
            ttvalor.estado
            ttvalor.fecha_deposito
            ttvalor.importe
            cliente.cdg_cliente 
            ttvalor.origen WITH FRAME valores.
        DOWN WITH FRAME valores.
      END.
  END.
          
  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.
