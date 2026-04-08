/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja    LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha   LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha   LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER todos_mov   AS LOGICAL.
DEFINE INPUT PARAMETER consolidado AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE titulo_det   AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE que_fecha    AS CHARACTER.
DEFINE VARIABLE que_comprob  AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE ingreso      AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE egreso       AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE saldo        AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE tot_ingreso  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tot_egreso   AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tot_saldo    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE lst_e        AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE lst_i        AS DECIMAL FORMAT ">,>>>,>>9.99".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Egresos Generales de Caja" AT 60 
  que_caja FORMAT ">>9"  
  "Página:" AT 147 PAGE-NUMBER FORMAT ">9" AT 154
  SKIP  
  fecha_lis   
  "del" AT 60
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 147
  titulo_det AT 60
  SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  que_fecha                 COLUMN-LABEL "Fecha!Movim"
  que_comprob               COLUMN-LABEL "Número de !Comprobante"
  Caj_header.cdg_empresa    COLUMN-LABEL "Em-!prs" FORMAT "X(3)"
  Caj_header.estado         COLUMN-LABEL "An!ul"
  Caj_header.observacion    COLUMN-LABEL "Observación!Movimiento"
  lst_e                     COLUMN-LABEL "Importe!Movimiento"
  Rubro.abrevia             COLUMN-LABEL "Rubro!Caja"
  Caj_detalle.importe       COLUMN-LABEL "Importe!Detalle"
  Caj_detalle.observacion   COLUMN-LABEL "Observación!Detalle"
  WITH WIDTH 260 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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
        AND Caj_header.tipo_mov = "E"
        AND LOOKUP(Caj_header.tip_comprob,"CJ,OP,DP") <> 0
         BREAK BY(Caj_header.fecha) BY Caj_header.nro_transaccion
             WITH FRAME frm-listado:
     
      VIEW FRAME frm-titulo.
      
      que_fecha = SUBSTRING(STRING(Caj_header.fecha),1,5).
      que_comprob = Caj_header.tip_comprob + " " + 
                    STRING(Caj_header.prf_comprob,"9999")  + " " + 
                    STRING(Caj_header.nro_comprob,"99999999").
      lst_e = Caj_header.importe.

      IF Caj_header.estado <> "A"
      THEN DO:
            egreso  = egreso  + Caj_header.importe.
            tot_egreso = tot_egreso  + Caj_header.importe.
            saldo = egreso.
      END.   

      FOR EACH Caj_detalle OF Caj_header,
              EACH Rubro OF Caj_detalle BREAK BY Caj_detalle.nro_transaccion:
      
          DISPLAY que_fecha       WHEN FIRST-OF(Caj_header.fecha) AND FIRST-OF(Caj_detalle.nro_transaccion)
                  que_comprob     WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  Caj_header.cdg_empresa WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  Caj_header.estado  WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  Caj_header.observacion WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  lst_e WHEN FIRST-OF(Caj_detalle.nro_transaccion)
                  Rubro.abrevia
                  Caj_detalle.importe 
                  Caj_detalle.observacion
                  WITH FRAME frm-listado.
                  
          DOWN WITH FRAME frm-listado.         
                  
      END.   
  END.
  
  UNDERLINE Caj_header.observacion 
            lst_e
            WITH FRAME frm-listado STREAM-IO.  

  DISPLAY "Totales del periodo"  @ Caj_header.observacion
          egreso  @ lst_e
          WITH FRAME frm-listado STREAM-IO.  
  DOWN WITH FRAME frm-listado.

  UNDERLINE Caj_header.observacion 
            lst_e
            WITH FRAME frm-listado STREAM-IO.  

  DISPLAY " " @ que_fecha WITH FRAME frm-listado STREAM-IO.
          
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

