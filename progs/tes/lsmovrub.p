/*=================================================================================*/
/*                      MOVIMIENTOS POR RUBRO DE CAJA ENTRE FECHAS                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja             LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER des_hora         AS INT FORMAT "9999".
DEFINE INPUT PARAMETER has_fecha        LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_hora         AS INT FORMAT "9999".
DEFINE INPUT PARAMETER des_rubro            LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER has_rubro            LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER arrastrar_saldos     AS INTEGER.
DEFINE INPUT PARAMETER consolidado          AS LOGICAL.

/*=================================================================================*/
/*                       VARIABLES, BUFFERS Y TABLAS TEMPORARIAS                   */
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}
{wglistar.i}

DEFINE VARIABLE nom_rubro           LIKE Rubro.nombre.
DEFINE VARIABLE nom_caja            LIKE Caja.nombre.

DEFINE VARIABLE chr_caja            AS CHARACTER.

DEFINE VARIABLE que_comprob         AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE titulo_det          AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE saldo               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE tot_ingreso         AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso          AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tgn_ingreso         AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_egreso          AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE lst_e               AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE lst_i               AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE ant_comprob         AS CHARACTER FORMAT "X(20)".

DEFINE VARIABLE pri_movi            AS LOGICAL.
DEFINE VARIABLE pri_fech            AS LOGICAL.

DEFINE BUFFER B-Rubro FOR Rubro.

DEFINE VAR carrastrar_saldos AS CHAR INITIAL "Sin arrastre saldo,Desde ultimo cierre,Desde Dia/Hora" NO-UNDO .
DEFINE VAR dhora AS INT NO-UNDO.
DEFINE VAR hhora AS INT NO-UNDO.
DEFINE VAR que_hora AS CHAR FORMAT "X(5)".

/*=================================================================================*/
/*                                FRAMES                                           */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Movimientos por Rubro de Caja:" AT 65 
  nom_caja
  "Página:" AT 155 PAGE-NUMBER FORMAT "99999" AT 162
  SKIP  
  fecha_lis   
  "del" AT 65
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 155
  SKIP
  nom_rubro AT 65
  SKIP(1)
  WITH WIDTH 175 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Caj_header.fecha          COLUMN-LABEL "Fecha!Movim"
  que_comprob               COLUMN-LABEL "Número de !Comprobante"
  Caj_header.cdg_empresa    COLUMN-LABEL "Em-!prs" FORMAT "X(3)"
  Caj_header.estado         COLUMN-LABEL "An!ul"
  Caj_header.observacion    COLUMN-LABEL "Observación!Movimiento"
  lst_i                     COLUMN-LABEL "Importe!Ingresos"
  lst_e                     COLUMN-LABEL "Importe!Egresos"
  saldo                     COLUMN-LABEL "Importe!Saldo"
  Caj_detalle.observacion   COLUMN-LABEL "Observación!Detalle" 
  WITH WIDTH 280 DOWN CENTERED USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
IF arrastrar_saldos = 1 THEN DO: /*buscando el ultimo cierre*/
      FOR EACH acumulado_caja NO-LOCK WHERE acumulado_caja.cerrado AND
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

   FIND Caja WHERE Caja.cdg_caja = que_caja NO-LOCK.
   titulo_det = "Caja:" + STRING(que_caja,">>9") + " " + 
                "Arrastrar Saldos:" + entry(arrastrar_saldos + 1 , carrastrar_saldos) + "  -  " +
                "Consolidado:" + STRING(consolidado,"Si/No").
   nom_caja = Caja.nombre.
   IF arrastrar_saldos <> 0 THEN

   {dirprinfile.i}
 
   tgn_ingreso = 0.
   tgn_egreso = 0.

   FOR EACH Rubro NO-LOCK WHERE Rubro.cdg_rubro <= has_rubro
                     AND Rubro.cdg_rubro >= des_rubro
                     BREAK BY Rubro.cdg_rubro:
                     
       nom_rubro = STRING(Rubro.cdg_rubro,"9999") + "-" + Rubro.nombre.
       pri_movi = YES.

       tot_ingreso = 0.
       tot_egreso = 0.
       ant_comprob = "".

       FOR EACH  Caj_detalle NO-LOCK OF Rubro, FIRST Caj_header NO-LOCK OF Caj_detalle
          WHERE ( Caj_header.cdg_empresa = Empresa.cdg_empresa OR consolidado )
            AND CAN-DO (Usuario.lista_empresas,Caj_header.cdg_empresa)
            AND   Caj_header.cdg_caja = Caja.cdg_caja 
            AND   Caj_header.fecha >= des_fecha   
            AND   Caj_header.hora >= des_hora 
            AND   Caj_header.fecha <= has_fecha
           AND    Caj_header.hora <= has_hora 
            AND   caj_header.estado <> "A"
            BREAK BY Caj_header.fecha 
                BY caj_header.hora
                BY Caj_header.tip_comprob 
                BY Caj_header.prf_comprob 
                BY Caj_header.nro_comprob 
                   WITH FRAME frm-listado:
      
          VIEW FRAME frm-titulo.

          IF pri_movi AND arrastrar_saldos <> 0
          THEN DO:
              RUN CALCULAR_EIRUBRO ( caj_header.cdg_caja, 
                                INPUT Rubro.cdg_rubro, 
                                des_fecha,
                                des_hora,
                                consolidado, 
                                empresa.cdg_empresa, 
                                OUTPUT tot_egreso, 
                                OUTPUT tot_ingreso ).
              saldo = tot_ingreso - tot_egreso.
              DISPLAY des_fecha - 1   @ Caj_header.fecha
                      "Saldo Inicial" @ Caj_header.observacion
                      saldo
                      WITH FRAME frm-listado.
              DOWN WITH FRAME frm-listado.
              pri_movi = NO.
          END.     
          ELSE DO:
              saldo = 0.
          END.

          IF Caj_header.estado <> "A"
          THEN DO:
              IF Caj_header.tipo_mov = "I" 
              THEN DO:
                  tot_ingreso = tot_ingreso + Caj_detalle.importe.
                  lst_i = Caj_detalle.importe.
              END.
              ELSE DO:
                  tot_egreso = tot_egreso + Caj_detalle.importe.
                  lst_e = Caj_detalle.importe.
              END.
          END.

          que_comprob = Caj_header.tip_comprob + " " + 
                        STRING(Caj_header.prf_comprob,"9999") + " " + 
                        STRING(Caj_header.nro_comprob,"99999999").
                              
          saldo = tot_ingreso - tot_egreso.
          DISPLAY Caj_header.fecha           WHEN FIRST-OF(Caj_header.fecha) 
                  que_comprob                WHEN que_comprob <> ant_comprob
                  Caj_header.estado          WHEN que_comprob <> ant_comprob
                  Caj_header.cdg_empresa     WHEN que_comprob <> ant_comprob
                  Caj_header.observacion     WHEN que_comprob <> ant_comprob
                  lst_i                      WHEN Caj_header.tipo_mov = "I"
                  lst_e                      WHEN Caj_header.tipo_mov = "E"
                  saldo                      WHEN Caj_header.estado <> "A" 
                  Caj_detalle.observacion 
                  WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.
                
          ant_comprob = que_comprob.

       END.

       tgn_ingreso = tgn_ingreso + tot_ingreso.
       tgn_egreso  = tgn_egreso  + tot_egreso .

       UNDERLINE lst_i 
                 lst_e 
                 saldo
                 WITH FRAME frm-listado.
       DOWN 2 WITH FRAME frm-listado.

       IF NOT LAST(Rubro.cdg_rubro) THEN PAGE.
     
  END.

  UNDERLINE lst_i 
            lst_e 
            WITH FRAME frm-listado.
  DISPLAY tgn_ingreso @ lst_i
          tgn_egreso  @ lst_e
          WITH FRAME frm-listado.
  DOWN 2 WITH FRAME frm-listado.     

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  
{calculareicaja.i}
