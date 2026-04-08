/*=================================================================================*/
/*                     LISTADO DE MOVIMIENTOS DETALLADOS DE CAJA                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja         LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER des_hora         AS INT FORMAT "9999".
DEFINE INPUT PARAMETER has_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_hora         AS INT FORMAT "9999".
DEFINE INPUT PARAMETER arrastrar_saldos AS INTEGER.
DEFINE INPUT PARAMETER consolidado      AS LOGICAL.

{calculareicaja.i}
/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{parlocales.i}
{dfvarimp.i}
                                        
DEFINE VARIABLE que_fecha     AS CHARACTER.
DEFINE VARIABLE que_comprob   AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE titulo_det    AS CHARACTER FORMAT "X(70)".
DEFINE VARIABLE ingreso       AS DECIMAL FORMAT ">>>,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE egreso        AS DECIMAL FORMAT ">>>,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE saldo         AS DECIMAL FORMAT "->>>,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE tot_ingreso   AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tot_saldo     AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE lst_e         AS DECIMAL FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE lst_i         AS DECIMAL FORMAT "->>>,>>>,>>9.99".
DEFINE VARIABLE v-detalle     LIKE Caj_detalle.observacion.
DEFINE VAR carrastrar_saldos AS CHAR INITIAL "Sin arrastre saldo,Desde ultimo cierre,Desde Dia/Hora" NO-UNDO .
DEFINE VAR dhora AS INT NO-UNDO.
DEFINE VAR hhora AS INT NO-UNDO.
DEFINE VAR que_hora AS CHAR FORMAT "X(5)".

DEFINE TEMP-TABLE Acumulado NO-UNDO
       FIELD cdg_rubro    LIKE Rubro.cdg_rubro
       FIELD ingresos     AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Ingresos"
       FIELD egresos      AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Egresos".
{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Detalle de Movimientos por Caja" AT 60 
  "Página:" AT 140 PAGE-NUMBER FORMAT ">9" AT 147
  SKIP  
  fecha_lis   
  "del" AT 60
  des_fecha des_hora
  "al" 
  has_fecha has_hora
  hora_lis AT 140
  titulo_det AT 60
  SKIP(1)
  WITH WIDTH 151 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  que_fecha                 COLUMN-LABEL "Fecha!Comp"
  que_hora                  COLUMN-LABEL "Hora!Comp"
  Caj_header.cdg_empresa    COLUMN-LABEL "Cod!Emp" FORMAT "X(3)"
  que_comprob               COLUMN-LABEL "Comprobante!Movimiento"
  /*
  Caj_header.fecha          COLUMN-LABEL "Fecha"
  Caj_header.tip_comprob    COLUMN-LABEL "Cmp"
  Caj_header.nro_comprob    COLUMN-LABEL "Numero"
  */
  Caj_header.estado         NO-LABEL
  Caj_header.observacion    COLUMN-LABEL "Observaciones!Comprobante"
  lst_i                     COLUMN-LABEL "Importe!Ingresos"
  lst_e                     COLUMN-LABEL "Importe!Egresos"
  saldo                     COLUMN-LABEL "Arrastre!Saldo"
  Rubro.abrevia             COLUMN-LABEL "Ru-!bro"
  Caj_detalle.importe       COLUMN-LABEL "Importe!Detalle"
  v-detalle                 COLUMN-LABEL "Observaciones de!Detalle del movimiento" FORMAT "X(33)"
  WITH WIDTH 251 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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

{findempresa.i}
que_empresa = Empresa.nombre.
IF arrastrar_saldos = 1 THEN DO: /*buscando el ultimo cierre*/
      FOR EACH acumulado_caja WHERE acumulado_caja.cerrado AND
          acumulado_caja.cdg_caja = que_caja AND
          ( acumulado_caja.cdg_empresa = Empresa.cdg_empresa OR consolidado ) AND
          Acumulado_caja.cdg_rubro = 0 BY acumulado_caja.fechaA DESCENDING:
          LEAVE.
      END.
      IF AVAILABLE acumulado_caja THEN DO:
          des_fecha = DATE(fechaA).
          des_hora = INT(replace(SUBstring( STRING(fechaA),12,5),":","")).

      END.
  END.
dhora = truncate( des_hora / 100 , 0 ) * 3600 + (des_hora - TRUNCATE( des_hora / 100 , 0 ) * 100) * 60.
hhora = truncate( has_hora / 100 , 0 ) * 3600 + (has_hora - TRUNCATE( has_hora / 100 , 0 ) * 100) * 60.
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
  EMPTY TEMP-TABLE Acumulado.
  saldo = 0.
  tot_ingreso = 0.
  tot_egreso = 0 .
  FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
  titulo_det = "Caja:" + STRING(que_caja,">>9") + " " + 
               "Arrastrar Saldos:" + entry(arrastrar_saldos + 1 , carrastrar_saldos) + "  -  " +
               "Consolidado:" + STRING(consolidado,"Si/No").

  IF arrastrar_saldos = 1 THEN DO: /*buscando el ultimo cierre*/
      FOR EACH acumulado_caja WHERE acumulado_caja.cerrado AND
          acumulado_caja.cdg_caja = que_caja AND
          ( acumulado_caja.cdg_empresa = Empresa.cdg_empresa OR consolidado ) AND
          Acumulado_caja.cdg_rubro = 0 BY ( acumulado_caja.ano * 100 + acumulado_caja.mes ) DESCENDING:
          LEAVE.
      END.
      IF AVAILABLE acumulado_caja THEN DO:
          des_fecha = DATE(fechaA).
          des_hora = INT(replace(SUBstring( STRING( fechaA),12,5),":","")).
      END.
  END.
  IF arrastrar_saldos <> 0
  THEN DO:
      RUN CALCULAR_EI ( caja.cdg_caja, des_fecha, des_hora , consolidado, empresa.cdg_empresa, OUTPUT egreso, OUTPUT ingreso ).
      saldo = ingreso - egreso.
      tot_ingreso = ingreso.
      tot_egreso  = egreso.
  END.

  {dirprinfile.i &LIN-PAG=72}
  VIEW FRAME frm-titulo.
  DISPLAY saldo WITH FRAME frm-listado.
  IF arrastrar_saldos <> 0 THEN DO:
    DISPLAY SUBSTRING(STRING(des_fecha),1,5) @ que_fecha
                 SUBstring( STRing( des_hora,"9999"),1,2) + ":" + SUBstring(STRing(des_hora,"9999"),3,2) @ que_hora 
             "Saldo inicial" @ Caj_header.observacion 
                  saldo
                  WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
  END.
  FOR EACH  Caj_header OF Caja
      WHERE (( Caj_header.fecha = des_fecha AND caj_header.hora >= dhora  ) OR
              caj_header.fecha > des_fecha )
      AND  ( Caj_header.fecha < has_fecha 
             OR ( Caj_header.fecha = has_fecha and caj_header.hora <= hhora ))
      AND Caj_header.estado <> "A"
      AND ( Caj_header.cdg_empresa = Empresa.cdg_empresa OR consolidado )
       AND CAN-DO (Usuario.lista_empresas,Caj_header.cdg_empresa)
      BREAK BY Caj_header.fecha 
            BY caj_header.hora 
            BY Caj_header.nro_transaccion
      WITH FRAME frm-listado:
      que_fecha = SUBSTRING(STRING(Caj_header.fecha),1,5).
      que_hora = STRING(caj_header.hora,"HH:MM").
      que_comprob = Caj_header.tip_comprob + " " + STRING(Caj_header.nro_comprob,"ZZZZZZZ9").
      lst_e = Caj_header.importe.
      lst_i = lst_e.

      IF Caj_header.tipo_mov = "I" 
         THEN DO:
            ingreso = ingreso + Caj_header.importe.
            tot_ingreso = tot_ingreso + Caj_header.importe.
         END.  
         IF Caj_header.tipo_mov = "E" 
         THEN DO:
            egreso  = egreso  + Caj_header.importe.
            tot_egreso = tot_egreso  + Caj_header.importe.
         END.   
         saldo = ingreso - egreso.
 

      FOR EACH Caj_detalle OF Caj_header,
              EACH Rubro OF Caj_detalle BREAK BY Caj_detalle.nro_transaccion:
      
          RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT v-detalle ).

          DISPLAY que_fecha       WHEN FIRST-OF(Caj_header.fecha) AND FIRST-OF(Caj_detalle.nro_transaccion)
                  que_hora
                  Caj_header.cdg_empresa WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  que_comprob     WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  /*
                  Caj_header.fecha    WHEN FIRST-OF(Caj_header.fecha) AND FIRST-OF(Caj_detalle.nro_transaccion)
                  Caj_header.tip_comprob WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  Caj_header.nro_comprob WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  */
                  Caj_header.estado NO-LABEL WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  Caj_header.observacion WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  lst_i WHEN Caj_header.tipo_mov = "I" AND FIRST-OF(Caj_detalle.nro_transaccion)
                  lst_e WHEN Caj_header.tipo_mov = "E" AND FIRST-OF(Caj_detalle.nro_transaccion)
                  saldo WHEN Caj_header.estado <> "A" AND FIRST-OF(Caj_detalle.nro_transaccion)
                  Rubro.abrevia
                  Caj_detalle.importe 
                  v-detalle
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
  
  UNDERLINE Caj_header.observacion 
            lst_i
            lst_e
            saldo
            WITH FRAME frm-listado STREAM-IO.  

  DISPLAY "Totales del periodo"  @ Caj_header.observacion
          ingreso @ lst_i
          egreso  @ lst_e
          saldo 
          WITH FRAME frm-listado STREAM-IO.  
  DOWN WITH FRAME frm-listado.

  UNDERLINE Caj_header.observacion 
            lst_i
            lst_e
            saldo
            WITH FRAME frm-listado STREAM-IO.  

  tot_saldo = tot_ingreso - tot_egreso.
  
  DISPLAY "Totales al " + STRING(has_fecha) @ Caj_header.observacion
          tot_ingreso     @ lst_i
          tot_egreso      @ lst_e
          tot_saldo       @ saldo
          WITH FRAME frm-listado STREAM-IO.
  DOWN WITH FRAME frm-listado.
  
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

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

