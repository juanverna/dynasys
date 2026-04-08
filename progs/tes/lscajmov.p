/*=================================================================================*/
/*     EMITE UN LISTADO CON TODOS LOS MOVIMIENTOS DE CAJA DE UN PERIODO DADO       */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja           LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha          LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha          LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER arrastrar_saldos   AS LOGICAL.
DEFINE INPUT PARAMETER consolidado        AS LOGICAL.


/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{parlocales.i }
{dfvarimp.i }
{calculareicaja.i}

DEFINE TEMP-TABLE Acumulado NO-UNDO
       FIELD cdg_rubro    LIKE Rubro.cdg_rubro
       FIELD ingresos     AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Ingresos"
       FIELD egresos      AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Egresos"
    INDEX rubro cdg_rubro.
                                        
DEFINE VARIABLE titulo_det         AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE que_comprob        AS CHARACTER FORMAT "X(16)".

DEFINE VARIABLE tot_ingreso        AS DECIMAL FORMAT ">>>,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso         AS DECIMAL FORMAT ">>>,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tot_saldo          AS DECIMAL FORMAT "->>>,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE lst_e              AS DECIMAL FORMAT ">>>,>>>,>>9.99".
DEFINE VARIABLE lst_i              AS DECIMAL FORMAT ">>>,>>>,>>9.99".
DEFINE VARIABLE ingreso      AS DECIMAL FORMAT ">>>,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE egreso       AS DECIMAL FORMAT ">>>,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE saldo        AS DECIMAL FORMAT "->>>,>>>,>>9.99" LABEL "Saldo".
{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Resumen de Movimientos Por Caja" AT 45   
  "Página:" AT 103 PAGE-NUMBER FORMAT "9999" AT 110
  SKIP  
  fecha_lis   
  "del" AT 45
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 103
  titulo_det AT 45
  SKIP(1)
  WITH WIDTH 196 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Caj_header.fecha          COLUMN-LABEL "Fecha!Compbte."
  que_comprob               COLUMN-LABEL "Número de !Comprobante"
  Caj_header.cdg_empresa    COLUMN-LABEL "Em-!prs" FORMAT "X(3)"
  Caj_header.estado         COLUMN-LABEL "An!ul"
  Caj_header.observacion    COLUMN-LABEL "Observación!Movimiento"
  lst_i                     COLUMN-LABEL "Imprte!Ingresos"
  lst_e                     COLUMN-LABEL "Importe!Egresos"
  tot_saldo                 COLUMN-LABEL "Arrastre!Saldo"
  WITH WIDTH 196 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

DEFINE FRAME frm-resumen
  Rubro.cdg_rubro
  Rubro.nombre
  tot_saldo COLUMN-LABEL "Arrastre"
  Acumulado.ingresos
  Acumulado.egresos
  saldo COLUMN-LABEL "Diferencia"
  WITH WIDTH 260 DOWN CENTERED FRAME frm-resumen USE-TEXT STREAM-IO.
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

  EMPTY TEMP-TABLE acumulado.
  FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
  que_caja = Caja.cdg_caja.
  titulo_det = "Caja:" + STRING(que_caja,">>9") + " " + 
               "Arrastre Saldos:" + STRING(arrastrar_saldos,"Si/No") + "  -  " +
               "Consolidado:" + STRING(consolidado,"Si/No").
  
  IF arrastrar_saldos
  THEN DO:
      RUN CALCULAR_EI (caja.cdg_caja,
                       des_fecha, 
                       0,
                       consolidado, 
                       empresa.cdg_empresa, 
                       OUTPUT tot_egreso, 
                       OUTPUT tot_ingreso).
      saldo = tot_ingreso - tot_egreso.
  END.
  ELSE DO:
      saldo = 0.
  END.
 
  {dirprinfile.i &LIN-PAG=72}
   VIEW FRAME frm-titulo.

  tot_ingreso = 0.
  tot_egreso = 0.
  FOR EACH  Caj_header OF Caja
      WHERE Caj_header.fecha >= des_fecha 
      AND   Caj_header.fecha <= has_fecha
      AND ( Caj_header.cdg_empresa = Empresa.cdg_empresa OR consolidado )
      AND CAN-DO (Usuario.lista_empresas,Caj_header.cdg_empresa)
      BREAK BY(Caj_header.fecha) BY Caj_header.nro_transaccion
      WITH FRAME frm-listado:

      
      IF FIRST(Caj_header.fecha) AND arrastrar_saldos
      THEN DO:
         DISPLAY "Saldo anterior" @ Caj_header.observacion 
                  saldo @ tot_saldo
                  WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
      END.   
      
      IF Caj_header.estado <> "A"
      THEN DO:
         IF Caj_header.tipo_mov = "I" THEN tot_ingreso = tot_ingreso + Caj_header.importe.
         IF Caj_header.tipo_mov = "E" THEN tot_egreso = tot_egreso + Caj_header.importe.
         tot_saldo = saldo + tot_ingreso - tot_egreso.
      END.   

      que_comprob = Caj_header.tip_comprob + " " + 
                    STRING(Caj_header.prf_comprob,"9999") + " " + 
                    STRING(Caj_header.nro_comprob,"99999999").
      lst_i = Caj_header.importe.
      lst_e = Caj_header.importe.
      DISPLAY Caj_header.fecha    WHEN FIRST-OF(Caj_header.fecha)
              Caj_header.cdg_empresa 
              que_comprob 
              Caj_header.estado
              Caj_header.observacion 
              lst_i WHEN Caj_header.tipo_mov = "I"
              lst_e WHEN Caj_header.tipo_mov = "E"
              tot_saldo 
              WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.
      IF Caj_header.estado <> "A" THEN
      FOR EACH caj_detalle OF caj_header NO-LOCK:
      FIND FIRST Acumulado 
                   WHERE Acumulado.cdg_rubro = Caj_detalle.cdg_rubro NO-ERROR.
              IF NOT AVAILABLE Acumulado
              THEN DO:
                 CREATE Acumulado.
                 ASSIGN Acumulado.cdg_rubro = Caj_detalle.cdg_rubro.
              END.
              IF Caj_detalle.tipo_mov = "E"
                 THEN Acumulado.egresos  = Acumulado.egresos  + Caj_detalle.importe.
                 ELSE Acumulado.ingresos = Acumulado.ingresos + Caj_detalle.importe.
      END.      
  END.
  
  
  UNDERLINE Caj_header.observacion 
            lst_i
            lst_e
            tot_saldo
            WITH FRAME frm-listado STREAM-IO.  

  DISPLAY "Totales del rango"  @ Caj_header.observacion
          tot_ingreso @ lst_i
          tot_egreso  @ lst_e
          tot_saldo 
          WITH FRAME frm-listado STREAM-IO.  
  DOWN WITH FRAME frm-listado.

  UNDERLINE Caj_header.observacion 
            lst_i
            lst_e
            tot_saldo
            WITH FRAME frm-listado STREAM-IO.  

  DOWN WITH FRAME frm-listado.
  
  DISPLAY " " @ Caj_header.fecha WITH FRAME frm-listado STREAM-IO.
          
  VIEW FRAME frm-titresumen.


   FOR EACH rubro BY Rubro.cdg_rubro:
       tot_saldo = 0.
       tot_ingreso = 0.
       tot_egreso = 0.
       IF arrastrar_saldos THEN
           RUN CALCULAR_EIRUBRO (caja.cdg_caja,rubro.cdg_rubro,des_fecha, consolidado, empresa.cdg_empresa, OUTPUT tot_egreso, OUTPUT tot_ingreso).
       tot_saldo = tot_ingreso - tot_egreso.
       saldo = 0.
       FIND Acumulado OF rubro NO-ERROR.
       IF AVAILABLE acumulado THEN
        saldo = Acumulado.ingresos - Acumulado.egresos.
       IF saldo = 0 AND tot_saldo = 0 THEN NEXT.
       DISPLAY
              tot_saldo
              Rubro.cdg_rubro
              Rubro.nombre
              Acumulado.ingresos WHEN AVAILABLE acumulado
              Acumulado.egresos  WHEN AVAILABLE acumulado
              saldo
              tot_saldo + saldo COLUMN-LABEL "Saldo" FORMAT "->>>,>>>,>>9.99"
              WITH FRAME frm-resumen.
       DOWN WITH FRAME frm-resumen.
IF AVAILABLE acumulado THEN DO:
       tot_ingreso = tot_ingreso + Acumulado.ingresos.
       tot_egreso  = tot_egreso  + Acumulado.egresos.
END.
   END.

   OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  
 
