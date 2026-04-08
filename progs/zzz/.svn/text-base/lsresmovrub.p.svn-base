/*=================================================================================*/
/*                      MOVIMIENTOS POR RUBRO DE CAJA ENTRE FECHAS                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja     LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha    LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER des_rubro    LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER has_rubro    LIKE Rubro.cdg_rubro.
DEFINE INPUT PARAMETER todos_mov    AS LOGICAL.
DEFINE INPUT PARAMETER consolidado  AS LOGICAL.

/*---------------------------------------------------------------------------------*/
/*                       VARIABLES, BUFFERS Y TABLAS TEMPORARIAS                   */
/*---------------------------------------------------------------------------------*/

{dfvarimp.i}
{parlocales.i}
{wglistar.i}

DEFINE VARIABLE nom_rubro           LIKE Rubro.nombre.
DEFINE VARIABLE nom_caja            LIKE Caja.nombre.

DEFINE VARIABLE chr_caja            AS CHARACTER.

DEFINE VARIABLE que_movims          AS CHARACTER INITIAL "I/E".
DEFINE VARIABLE que_comprob         AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE titulo_det          AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE que_fecha           AS CHARACTER.
DEFINE VARIABLE ingreso             AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE egreso              AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE saldo               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE tot_ingreso         AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso          AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tgn_ingreso         AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_egreso          AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE lst_e               AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE lst_i               AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE ant_comprob         AS CHARACTER FORMAT "X(16)".

DEFINE VARIABLE pri_movi            AS LOGICAL.
DEFINE VARIABLE pri_fech            AS LOGICAL.

DEFINE BUFFER B-Rubro FOR Rubro.

/*---------------------------------------------------------------------------------*/
/*                                FRAMES                                           */
/*---------------------------------------------------------------------------------*/

DEFINE WORK-TABLE Acumulado
   FIELD tipo         AS INTEGER
   FIELD cdg_rubro   LIKE Rubro.cdg_rubro
   FIELD saldo        AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE FRAME frm-titulo-r HEADER
  que_empresa 
  "Saldos por Rubro" AT 40 
  "Página:" AT 68 PAGE-NUMBER FORMAT ">9" AT 76
  SKIP  
  fecha_lis   
  "del" AT 40
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 68
  "desde Rubro" AT 40
  des_rubro
  "hasta" 
  has_rubro FORMAT ">>>>>>>9"
  SKIP(1)
  WITH WIDTH 80 FRAME frm-titulo-r TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-r
  SPACE(3)
  Rubro.cdg_rubro                COLUMN-LABEL "Código!Rubro"
  Rubro.nombre                   COLUMN-LABEL "Denominación!Rubro"
  lst_i  FORMAT "->>,>>>,>>9.99"  COLUMN-LABEL "Importe!Débitos"
  lst_e  FORMAT "->>,>>>,>>9.99"  COLUMN-LABEL "Importe!Creditos"
  WITH WIDTH 80 DOWN CENTERED USE-TEXT STREAM-IO.

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
   titulo_det = "Caja:" + STRING(que_caja,">>9") + " " + 
                "Anulaciones:" + STRING(todos_mov,"Si/No") + "  -  " +
                "Consolidado:" + STRING(consolidado,"Si/No").
   nom_caja = Caja.nombre.

   {dirprinfile.i}
 
   tgn_ingreso = 0.
   tgn_egreso = 0.

   FIND FIRST Acumulado NO-ERROR.
   IF AVAILABLE Acumulado
   THEN DO:
      FOR EACH Acumulado:
          DELETE Acumulado.
      END.    
   END.

   FOR EACH Rubro WHERE Rubro.cdg_rubro <= has_rubro
                     AND Rubro.cdg_rubro >= des_rubro
                     BREAK BY Rubro.cdg_rubro:
                     
       tot_ingreso = 0.
       tot_egreso = 0.
       ant_comprob = "".

       FOR EACH  Caj_detalle OF Rubro, FIRST Caj_header OF Caj_detalle
          WHERE ( Caj_header.cdg_empresa = Empresa.cdg_empresa OR consolidado ) 
            AND   Caj_header.cdg_caja = Caja.cdg_caja 
            AND   Caj_header.fecha >= des_fecha 
            AND   Caj_header.fecha <= has_fecha
            AND ( Caj_header.estado <> "A" OR todos_mov ) 
          BREAK BY Caj_header.fecha BY Caj_detalle.nro_transaccion
                 WITH FRAME frm-listado:
      
          IF FIRST(Caj_header.fecha)
          THEN DO:
                RUN CALCULAR_EI ( INPUT Rubro.cdg_rubro, 
                                  OUTPUT tot_egreso, 
                                  OUTPUT tot_ingreso ).
                saldo = tot_ingreso - tot_egreso.
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
                              
          FIND FIRST Acumulado 
               WHERE Acumulado.cdg_rubro = Rubro.cdg_rubro NO-ERROR.
          IF NOT AVAILABLE Acumulado
          THEN DO:
               CREATE Acumulado.
               ASSIGN 
                  Acumulado.tipo      = 2
                  Acumulado.cdg_rubro = Rubro.cdg_rubro.
          END.
            
          IF Caj_detalle.tipo_mov = "I"
             THEN Acumulado.saldo = Acumulado.saldo + Caj_detalle.importe.
             ELSE Acumulado.saldo = Acumulado.saldo - Caj_detalle.importe.
               
          pri_fech = NO.                     
          pri_movi = NO.

       END.

       FIND FIRST Acumulado 
            WHERE Acumulado.cdg_rubro = Rubro.cdg_rubro NO-ERROR.
       IF NOT AVAILABLE Acumulado
       THEN DO:
            CREATE Acumulado.
            ASSIGN Acumulado.tipo      = 1
                   Acumulado.cdg_rubro = Rubro.cdg_rubro.
       END.
            
       Acumulado.saldo = tot_ingreso - tot_egreso.
                      
       tgn_ingreso = tgn_ingreso + tot_ingreso.
       tgn_egreso  = tgn_egreso  + tot_egreso .
     
  END.
 
  tgn_ingreso = 0.
  tgn_egreso = 0.

  FOR EACH Acumulado BY Acumulado.tipo BY Acumulado.cdg_rubro:

      lst_i = Acumulado.saldo.
      lst_e = lst_i.

      IF Acumulado.tipo = 1
         THEN tgn_ingreso = tgn_ingreso + Acumulado.saldo.
         ELSE tgn_egreso  = tgn_egreso  + Acumulado.saldo.
         
      VIEW FRAME frm-titulo-r.
      FIND Rubro WHERE Rubro.cdg_rubro = Acumulado.cdg_rubro NO-LOCK.
      DISPLAY Rubro.cdg_rubro
              Rubro.nombre
              lst_i WHEN Acumulado.tipo = 1
              lst_e WHEN Acumulado.tipo = 2
              WITH FRAME frm-listado-r.
      DOWN WITH FRAME frm-listado-r.
      
  END.
  UNDERLINE lst_i 
            lst_e 
            WITH FRAME frm-listado-r.
  DISPLAY tgn_ingreso @ lst_i
          tgn_egreso  @ lst_e
          WITH FRAME frm-listado-r.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

PROCEDURE CALCULAR_EI:

   DEFINE INPUT  PARAMETER que_rubro     LIKE Rubro.cdg_rubro.
   DEFINE OUTPUT PARAMETER tot_egresogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_ingresong AS DECIMAL.

   DEFINE BUFFER B-Caj_detalle FOR Caj_detalle.
   DEFINE BUFFER B-Caj_header FOR Caj_header.
  
   tot_egresogr = 0.
   tot_ingresong = 0.

   FOR EACH B-Caj_header OF Caja
       WHERE Caj_header.cdg_empresa = Empresa.cdg_empresa
         AND B-Caj_header.fecha <  des_fecha
         AND B-Caj_header.estado <> "A":

       FOR EACH B-Caj_detalle OF B-Caj_header WHERE B-Caj_detalle.cdg_rubro = que_rubro NO-LOCK:
            IF B-Caj_header.tipo_mov = "E" 
               THEN tot_egresogr  = tot_egresogr  + B-Caj_detalle.importe.
               ELSE tot_ingresong = tot_ingresong + B-Caj_detalle.importe.
       END.
   END.
   
END PROCEDURE.
