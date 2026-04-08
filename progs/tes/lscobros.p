/*=================================================================================*/
/*   EMITE UN LISTADO CON TODAS LAS COBRANZAS REGISTRADAS EN UN RANGO DE FECHAS    */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja    LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha   LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha   LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER todos_mov   AS LOGICAL.
DEFINE INPUT PARAMETER consolidado AS LOGICAL.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}

DEFINE TEMP-TABLE Acumulado NO-UNDO
       FIELD cdg_rubro    LIKE Rubro.cdg_rubro
       FIELD ingresos     AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Ingresos"
       FIELD egresos      AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Egresos".

                                        
DEFINE VARIABLE titulo_det   AS CHARACTER FORMAT "X(50)".

DEFINE VARIABLE que_fecha    AS CHARACTER.
DEFINE VARIABLE que_comprob  AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE ingreso      AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE egreso       AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE saldo        AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE subsaldo        AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "SubSaldo".
DEFINE VARIABLE tot_ingreso  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso   AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tot_saldo    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE lst_e        AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE lst_i        AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE dtl_rubro    LIKE Caj_detalle.observacion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Detalle de Cobranzas Registradas" AT 60 
  "Página:" AT 132 PAGE-NUMBER FORMAT ">9" AT 139
  SKIP  
  fecha_lis   
  "del" AT 60
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 132
  titulo_det AT 60
  SKIP(1)
  WITH WIDTH 260 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  que_fecha                 COLUMN-LABEL "Fecha!Movim"
  que_comprob               COLUMN-LABEL "Número de !Comprobante"
  Caj_header.cdg_empresa    COLUMN-LABEL "Em-!prs" FORMAT "X(3)"
  Caj_header.estado         COLUMN-LABEL "An!ul"
  Caj_header.observacion    COLUMN-LABEL "Observación!Movimiento"
  lst_i                     COLUMN-LABEL "Importe!Recibo"
  Rubro.abrevia             COLUMN-LABEL "Con-!cepto"
  Caj_detalle.importe       COLUMN-LABEL "Importe!Rubro"
  dtl_rubro                 COLUMN-LABEL "Observaciones de!detalle del movimiento"
  WITH WIDTH 260 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

DEFINE FRAME frm-titresumen HEADER
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
  WITH WIDTH 132 FRAME frm-titresumen TOP-ONLY PAGE-TOP STREAM-IO.




DEFINE FRAME frm-resumen
  Rubro.cdg_rubro
  Rubro.nombre
  Acumulado.ingresos
  Acumulado.egresos
  saldo
  WITH WIDTH 260 DOWN CENTERED FRAME frm-resumen USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
  FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
  EMPTY TEMP-TABLE Acumulado.
  titulo_det = "Caja:" + STRING(que_caja,">>9") + " " + 
               "Anulaciones:" + STRING(todos_mov,"Si/No") + "  -  " +
               "Consolidado:" + STRING(consolidado,"Si/No").

  saldo = 0.
  tot_ingreso = 0.
  tot_egreso  = 0.

  {dirprinfile.i}

  FOR EACH  Caj_header OF Caja
      WHERE ( Caj_header.cdg_empresa = Empresa.cdg_empresa OR consolidado )
        AND CAN-DO (Usuario.lista_empresas,Caj_header.cdg_empresa)
        AND   Caj_header.fecha >= des_fecha 
        AND   Caj_header.fecha <= has_fecha
        AND ( Caj_header.estado <> "A" OR todos_mov ) 
        AND Caj_header.tipo_mov = "I"
        AND Caj_header.tip_comprob BEGINS "R"
        BREAK BY(Caj_header.fecha) BY Caj_header.nro_transaccion
             WITH FRAME frm-listado:
     
      VIEW FRAME frm-titulo.
      
      que_fecha = SUBSTRING(STRING(Caj_header.fecha),1,5).
      que_comprob = Caj_header.tip_comprob + " " + 
                    STRING(Caj_header.prf_comprob,"9999") + " " + 
                    STRING(Caj_header.nro_comprob,"99999999").
      lst_i = Caj_header.importe.

      IF Caj_header.estado <> "A"
          THEN DO:
                ingreso  = ingreso  + Caj_header.importe.
                tot_ingreso = tot_ingreso  + Caj_header.importe.
                saldo = ingreso.
                subsaldo = subsaldo + Caj_header.importe.
            FOR EACH Caj_detalle OF Caj_header,
                  EACH Rubro OF Caj_detalle BREAK BY Caj_detalle.nro_transaccion:
          
              RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT dtl_rubro ).
    
              DISPLAY que_fecha       WHEN FIRST-OF(Caj_header.fecha) AND FIRST-OF(Caj_detalle.nro_transaccion)
                      Caj_header.cdg_empresa WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                      que_comprob     WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                      Caj_header.estado NO-LABEL WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                      Caj_header.observacion WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                      lst_i WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                      Rubro.abrevia
                      Caj_detalle.importe 
                      dtl_rubro
                      WITH FRAME frm-listado.
              DOWN WITH FRAME frm-listado.   
                      
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
    
                      
          END. 
      END.
      ELSE DO:
              DISPLAY que_fecha WHEN FIRST-OF(Caj_header.fecha) 
                      Caj_header.cdg_empresa 
                      que_comprob
                      Caj_header.estado NO-LABEL
                      Caj_header.observacion 
              WITH FRAME frm-listado.
              DOWN WITH FRAME frm-listado.   

      END.

      IF LAST-OF(caj_header.fecha) AND has_fecha - des_fecha > 0 THEN  DO:
        DISPLAY  que_fecha  "Subtotal ************" @ Caj_header.observacion
          subsaldo @ lst_i "***********" @ Caj_detalle.importe 
        WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.   
        subsaldo = 0.
      END.
  END.
  
  UNDERLINE Caj_header.observacion 
            lst_i
            WITH FRAME frm-listado STREAM-IO.  
  DOWN WITH FRAME frm-listado.



  DISPLAY "Totales del periodo"  @ Caj_header.observacion
          ingreso  @ lst_i
          WITH FRAME frm-listado STREAM-IO.  
  DOWN WITH FRAME frm-listado.

  UNDERLINE Caj_header.observacion 
            lst_i
            WITH FRAME frm-listado STREAM-IO.  

  DISPLAY " " @ que_fecha WITH FRAME frm-listado STREAM-IO.

/*Totales del periodo por rubro de caja*/

  VIEW FRAME frm-titresumen.
tot_ingreso = 0.
tot_egreso = 0.

  FOR EACH Acumulado , Rubro OF Acumulado BY Rubro.cdg_rubro:

      saldo = Acumulado.ingresos - Acumulado.egresos.
      DISPLAY
             Rubro.cdg_rubro
             Rubro.nombre
             Acumulado.ingresos
             Acumulado.egresos
             saldo
             WITH FRAME frm-resumen.
      DOWN WITH FRAME frm-resumen.

      tot_ingreso = tot_ingreso + Acumulado.ingresos.
      tot_egreso  = tot_egreso  + Acumulado.egresos.

  END.

  saldo = tot_ingreso - tot_egreso.

  UNDERLINE Acumulado.ingresos
            Acumulado.egresos
            saldo
            WITH FRAME frm-resumen.
  DISPLAY tot_ingreso  @ Acumulado.ingresos
          tot_egreso   @ Acumulado.egresos
          saldo
          WITH FRAME frm-resumen.
          
  OUTPUT CLOSE.



          
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

